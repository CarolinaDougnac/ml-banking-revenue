# 05_resumen_metricas.R
library(tidyverse)

metricas_lineal    <- read.csv("outputs/metricas_lineal.csv")
metricas_tree_rf   <- read.csv("outputs/metricas_tree_rf.csv")
metricas_knn       <- read.csv("outputs/metricas_knn.csv")

metricas_total <- bind_rows(
  metricas_lineal,
  metricas_tree_rf,
  metricas_knn
)

write.csv(metricas_total, "outputs/resultados_metricas.csv", row.names = FALSE)

metricas_total %>%
  filter(Conjunto == "Test") %>%
  arrange(RMSE)

