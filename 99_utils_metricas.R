# 99_utils_metricas.R
calcular_metricas <- function(y_real, y_pred) {
  y_real <- as.numeric(y_real)
  y_pred <- as.numeric(y_pred)
  
  # RMSE
  rmse_val <- sqrt(mean((y_real - y_pred)^2, na.rm = TRUE))
  
  # MAE
  mae_val <- mean(abs(y_real - y_pred), na.rm = TRUE)
  
  # R^2
  ss_res <- sum((y_real - y_pred)^2, na.rm = TRUE)
  ss_tot <- sum((y_real - mean(y_real, na.rm = TRUE))^2, na.rm = TRUE)
  r2_val <- 1 - ss_res / ss_tot
  
  data.frame(
    RMSE = rmse_val,
    MAE  = mae_val,
    R2   = r2_val
  )
}
