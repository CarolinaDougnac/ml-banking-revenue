# 📊 Predicción de ingresos de clientes bancarios con Machine Learning (R)

Este proyecto desarrolla un modelo de Machine Learning para **predecir los ingresos totales de clientes bancarios (`Rev_Total`)**, utilizando un conjunto de variables demográficas, de productos financieros y comportamiento de uso.

El objetivo es evaluar y comparar distintos algoritmos de regresión, implementados en R, para seleccionar el modelo con mejor desempeño y construir un pipeline reproducible.

---

## 🚀 Objetivos del proyecto

- Construir un pipeline en R completamente reproducible.
- Comparar distintos modelos de regresión:
  - Elastic Net  
  - Árbol de regresión  
  - Random Forest  
  - KNN regresión  
- Seleccionar el mejor modelo según RMSE, MAE y R².
- Generar un informe profesional con interpretación de resultados.

---

## 🗂 Estructura del repositorio
ml-banking-revenue/
├─ data/
│  └─ BankRevenue.csv/
├─ 01_exploracion.R
├─ 02_modelos_lineales.R
├─ 03_modelos_tree_rf.R
├─ 04_modelos_knn.R
├─ 99_utils_metricas.R
├─ outputs/
│  ├─ metricas_lineal.csv
│  ├─ metricas_tree_rf.csv
│  ├─ metricas_knn.csv
│  └─ resultados_metricas.csv
├─ Comparación de modelos de regresión.pdf
└─ README.md

---

## 🧪 Metodología aplicada

1. **Exploración inicial** del dataset y revisión de variables.
2. **Preprocesamiento**: limpieza, conversión de tipos, preparación.
3. **Partición train/test**:  
   80% entrenamiento / 20% prueba.
4. **Entrenamiento** de modelos con `caret`:
   - Elastic Net (glmnet)
   - Árbol de regresión (rpart)
   - Random Forest (randomForest / ranger)
   - KNN regresión
5. **Validación cruzada** (cross-validation) con grid search.
6. **Evaluación** con:
   - RMSE  
   - MAE  
   - R²
7. **Comparación** de modelos.
8. **Selección** del modelo final.
9. **Generación de informe**.

---

## 📈 Resultados (conjunto de prueba)

| Modelo              | RMSE    | MAE     | R²        |
|--------------------|---------|---------|-----------|
| **Random Forest**  | **2.7824** | **1.4533** | **0.23106** |
| Árbol de regresión | 2.8042 | 1.4903 | 0.21894   |
| KNN                | 2.9178 | 1.5683 | 0.15441   |
| Elastic Net        | 3.0056 | 1.6918 | 0.10275   |

---

## 🏆 Modelo ganador

El **Random Forest** obtuvo el mejor desempeño predictivo, logrando:

- **RMSE:** ~2.78  
- **MAE:** ~1.45  
- **R²:** ~0.23  

Esto sugiere que las relaciones entre las variables y los ingresos son **no lineales**, y que los modelos basados en árboles capturan mejor estas interacciones.

---

## 📁 Archivo del informe

El informe final **“Comparación de modelos de regresión”** está incluido en este repositorio en formato PDF/Word.

---

## 🔁 Reproducibilidad

Para ejecutar el proyecto:

```r
# Instalar paquetes necesarios
install.packages(c("tidyverse", "caret", "glmnet", "rpart", "randomForest"))

# Ejecutar scripts en orden
source("01_exploracion.R")
source("02_modelos_lineales.R")
source("03_modelos_tree_rf.R")
source("04_modelos_knn.R")
source("05_resumen_metricas.R")

📌 Trabajo futuro
	•	Ingeniería de atributos avanzada.
	•	Inclusión de variables de comportamiento transaccional.
	•	Modelos más sofisticados:
	•	XGBoost
	•	LightGBM
	•	CatBoost
	•	Cross-validation más exhaustiva.
	•	Calibración del modelo final.
	•	Dashboard interactivo para visualización de predicciones.

-------------
Carolina Duognac Valdivia
Meteoróloga – Ingeniera en Computación e Informática
Apasionada por la analítica, Machine Learning y tecnología.

🔗 LinkedIn: https://www.linkedin.com/in/carolinadougnac/
📧 Email: carolinadougnacv@gmail.com


