# COVID-19 Tournament: Forecasting Collaborative
# life-satisfaction forecasting script
# Kasun Bandara, June 2020

# This script takes the past observations as a time series and generate forecasts for the next 12 months
# This approach uses an ensemble of state-of-the-art time series techniques that use to forecast monthly data.
# Forecasting techniques: ARIMA, ETS and Theta.
# Implementations are based on the forecast() package.

# @input: ideology-data.csv
# @output: ideology-republican-forecasts.csv, ideology-democrat-forecasts.csv


# Please uncomment the below command, in case you haven't installed the following pakcage in your enviornment.
# install.packages("forecast")

# Loading the required libraries.
# (https://cran.r-project.org/web/packages/forecast/forecast.pdf)
require(forecast)
library(forecast)

df <- read.csv("ideology-data.csv", header = TRUE)

arima_model <- auto.arima(ts(df$Democrat, frequency = 12))
arima_forecast <- forecast(arima_model, h = 12)
arima_forecast <- as.numeric(arima_forecast$mean)


ets_model <- ets(ts(df$Democrat, frequency = 12))
ets_forecast <- forecast(ets_model, h = 12)
ets_forecast <- as.numeric(ets_forecast$mean)


theta_model <- thetaf(ts(df$Democrat, frequency = 12))
theta_forecast <- forecast(theta_model, h = 12)
theta_forecast <- as.numeric(theta_forecast$mean)

forecast_combination <- cbind(arima_forecast, ets_forecast, theta_forecast)

forecast_ensemble <- rowMeans(forecast_combination)

write.table(forecast_ensemble, "ideology-democrat-forecasts.txt", sep = ",", col.names = FALSE, row.names = FALSE)


################################################################3


arima_model <- auto.arima(ts(df$Republican, frequency = 12))
arima_forecast <- forecast(arima_model, h = 12)
arima_forecast <- as.numeric(arima_forecast$mean)


ets_model <- ets(ts(df$Republican, frequency = 12))
ets_forecast <- forecast(ets_model, h = 12)
ets_forecast <- as.numeric(ets_forecast$mean)


theta_model <- thetaf(ts(df$Republican, frequency = 12))
theta_forecast <- forecast(theta_model, h = 12)
theta_forecast <- as.numeric(theta_forecast$mean)

forecast_combination <- cbind(arima_forecast, ets_forecast, theta_forecast)

forecast_ensemble <- rowMeans(forecast_combination)

write.table(forecast_ensemble, "ideology-republican-forecasts.txt", sep = ",", col.names = FALSE, row.names = FALSE)

