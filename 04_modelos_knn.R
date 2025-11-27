# 04_modelos_knn.R
library(tidyverse)
library(caret)
source("99_utils_metricas.R")

set.seed(123)

train_data <- readRDS("outputs/train_data.rds")
test_data  <- readRDS("outputs/test_data.rds")

target <- "Rev_Total"
predictors <- setdiff(names(train_data), target)
form <- as.formula(paste(target, "~", paste(predictors, collapse = " + ")))

ctrl <- trainControl(
  method = "repeatedcv",
  number = 5,
  repeats = 3
)

grid_knn <- expand.grid(
  k = seq(3, 25, by = 2)
)

modelo_knn <- train(
  form,
  data = train_data,
  method = "knn",
  trControl = ctrl,
  tuneGrid = grid_knn,
  metric = "RMSE"
)

pred_train <- predict(modelo_knn, newdata = train_data)
pred_test  <- predict(modelo_knn, newdata = test_data)

metricas_knn <- bind_rows(
  calcular_metricas(train_data[[target]], pred_train) %>%
    mutate(Conjunto = "Train", Modelo = "KNN"),
  calcular_metricas(test_data[[target]], pred_test) %>%
    mutate(Conjunto = "Test", Modelo = "KNN")
)

print(metricas_knn)

saveRDS(modelo_knn, "outputs/modelo_knn.rds")
write.csv(metricas_knn, "outputs/metricas_knn.csv", row.names = FALSE)

