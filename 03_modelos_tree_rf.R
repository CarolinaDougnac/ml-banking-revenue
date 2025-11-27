# 03_modelos_tree_rf.R

library(tidyverse)
library(caret)
library(rpart)
library(randomForest)

# Cargar la función calcular_metricas()
source("99_utils_metricas.R")

set.seed(123)

# 1) Cargar datos
train_data <- readRDS("outputs/train_data.rds")
test_data  <- readRDS("outputs/test_data.rds")

# 2) Definir fórmula
target <- "Rev_Total"
predictors <- setdiff(names(train_data), target)
form <- as.formula(paste(target, "~", paste(predictors, collapse = " + ")))

# 3) Control de entrenamiento
ctrl <- trainControl(
  method = "cv",
  number = 3
)

# 4) Árbol de regresión
grid_tree <- expand.grid(cp = seq(0.001, 0.05, by = 0.005))

modelo_tree <- train(
  form,
  data = train_data,
  method = "rpart",
  trControl = ctrl,
  tuneGrid = grid_tree,
  metric = "RMSE"
)

# 5) Random Forest (tarda un monton)
grid_rf <- expand.grid(
  mtry = c(3, 5, 10)
)

modelo_rf <- train(
  form,
  data = train_data,
  method = "rf",
  trControl = ctrl,
  tuneGrid = grid_rf,
  metric = "RMSE",
  importance = TRUE
)

# 6) Función auxiliar para métricas
calc_met <- function(modelo, nombre_modelo) {
  pred_tr <- predict(modelo, newdata = train_data)
  pred_te <- predict(modelo, newdata = test_data)
  
  met_tr <- calcular_metricas(train_data[[target]], pred_tr) %>%
    mutate(Conjunto = "Train", Modelo = nombre_modelo)
  
  met_te <- calcular_metricas(test_data[[target]], pred_te) %>%
    mutate(Conjunto = "Test", Modelo = nombre_modelo)
  
  bind_rows(met_tr, met_te)
}

# 7) Métricas árbol + RF
metricas_tree_rf <- bind_rows(
  calc_met(modelo_tree, "Arbol"),
  calc_met(modelo_rf,   "RandomForest")
)

# Mostrar en consola
print(metricas_tree_rf)

# 8) Importancia de variables RF
print(varImp(modelo_rf))

# 9) Guardar modelos y métricas
saveRDS(modelo_tree, "outputs/modelo_tree.rds")
saveRDS(modelo_rf,   "outputs/modelo_rf.rds")
write.csv(metricas_tree_rf, "outputs/metricas_tree_rf.csv", row.names = FALSE)

