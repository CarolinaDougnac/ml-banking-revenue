# 02_modelos_lineales.R
library(tidyverse)
library(caret)
library(glmnet)
source("99_utils_metricas.R")

set.seed(123)

train_data <- readRDS("outputs/train_data.rds")
test_data  <- readRDS("outputs/test_data.rds")

# 1) Definir fórmula
target <- "Rev_Total"
predictors <- setdiff(names(train_data), target)
form <- as.formula(paste(target, "~", paste(predictors, collapse = " + ")))

# 2) Configuración de entrenamiento caret
ctrl <- trainControl(
  method = "repeatedcv",
  number = 5,
  repeats = 3,
  verboseIter = FALSE
)

# 3) Elastic Net (alpha entre 0 y 1)
grid_en <- expand.grid(
  alpha = seq(0, 1, by = 0.25),
  lambda = 10^seq(-3, 1, length = 20)
)

modelo_en <- train(
  form,
  data = train_data,
  method = "glmnet",
  trControl = ctrl,
  tuneGrid = grid_en,
  metric = "RMSE"
)

# Mejor combinación alpha-lambda
modelo_en$bestTune

# 4) Predicciones
pred_train <- predict(modelo_en, newdata = train_data)
pred_test  <- predict(modelo_en, newdata = test_data)

met_train <- calcular_metricas(train_data[[target]], pred_train)
met_test  <- calcular_metricas(test_data[[target]], pred_test)

metricas_lineal <- bind_rows(
  met_train %>% mutate(Conjunto = "Train", Modelo = "ElasticNet"),
  met_test  %>% mutate(Conjunto = "Test",  Modelo = "ElasticNet")
)

print(metricas_lineal)

# 5) Guardar
saveRDS(modelo_en, "outputs/modelo_elasticnet.rds")
write.csv(metricas_lineal, "outputs/metricas_lineal.csv", row.names = FALSE)

