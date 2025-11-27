# 01_exploracion.R
library(tidyverse)
library(caret)

set.seed(123)

# 1) Leer datos
setwd("/Users/carolinadougnacvaldivia/RStudio_UAI/ml-banking-revenue")
data_path <- file.path("data", "BankRevenue.csv")
bank <- read.csv(data_path, stringsAsFactors = FALSE)

# 2) Vista general
glimpse(bank)
summary(bank$Rev_Total)

# 3) Tratamiento básico (ejemplos, ajusta según tus variables)
# - Elimina ID si existe
bank <- bank %>% select(-matches("id|ID|Id"))

# - Convertir algunas variables a factor (ejemplo genérico)
# bank$Genero  <- factor(bank$Genero)
# bank$Segmento <- factor(bank$Segmento)

# 4) Train / Test split (80/20 estratificado en Rev_Total “cortado”)
bank$Rev_cat <- cut(bank$Rev_Total,
                    breaks = quantile(bank$Rev_Total, probs = seq(0, 1, 0.2), na.rm = TRUE),
                    include.lowest = TRUE)

set.seed(123)
train_idx <- createDataPartition(bank$Rev_cat, p = 0.8, list = FALSE)

train_data <- bank[train_idx, ] %>% select(-Rev_cat)
test_data  <- bank[-train_idx, ] %>% select(-Rev_cat)

# 5) Guardar datasets ya limpiados y particionados
saveRDS(train_data, "outputs/train_data.rds")
saveRDS(test_data,  "outputs/test_data.rds")

