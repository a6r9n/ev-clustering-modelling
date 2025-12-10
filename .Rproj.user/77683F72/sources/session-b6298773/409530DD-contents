# R/modelling.R
# Modelling and prediction for EV prices

library(dplyr)
library(pls)

#---------------------------------
# 1. Prepare data for modelling
#---------------------------------

#' Select predictors and response for price modelling
#'
#' We use several technical attributes to predict Price.
#'
#' @param ev Original EV data frame from load_ev_data()
#' @return A data frame with predictors and Price
prepare_ev_modelling_data <- function(ev) {
  ev %>%
    dplyr::select(
      Battery,
      TopSpeed,
      Range,
      WhperKm,
      FastChargeSpeed,
      NumberofSeats,
      Price
    ) %>%
    na.omit()
}

#---------------------------------
# 2. Train/test split
#---------------------------------

#' Split data into train and test sets
#'
#' @param df Data frame returned by prepare_ev_modelling_data()
#' @param train_frac Fraction for training (default 0.8)
#' @param seed Random seed for reproducibility
#' @return A list with train and test data frames
split_train_test <- function(df, train_frac = 0.8, seed = 42) {
  set.seed(seed)
  n <- nrow(df)
  n_train <- round(n * train_frac)
  
  train_idx <- sample(seq_len(n), size = n_train)
  
  train <- df[train_idx, , drop = FALSE]
  test  <- df[-train_idx, , drop = FALSE]
  
  list(train = train, test = test)
}

#---------------------------------
# 3. Model fitting functions
#---------------------------------

#' Fit a multiple linear regression model
#'
#' @param train Training data (includes Price + predictors)
#' @return An lm object
fit_mlr <- function(train) {
  lm(Price ~ ., data = train)
}

#' Fit a Principal Component Regression model
#'
#' @param train Training data
#' @param ncomp Number of components
#' @return A pcr model object
fit_pcr_model <- function(train, ncomp = 3) {
  pls::pcr(
    Price ~ .,
    ncomp = ncomp,
    data  = train,
    scale = TRUE,
    validation = "none"
  )
}

#' Fit a Partial Least Squares Regression model
#'
#' @param train Training data
#' @param ncomp Number of components
#' @return A plsr model object
fit_pls_model <- function(train, ncomp = 3) {
  pls::plsr(
    Price ~ .,
    ncomp = ncomp,
    data  = train,
    scale = TRUE,
    validation = "none"
  )
}

#---------------------------------
# 4. Prediction helpers
#---------------------------------

#' Predict with MLR model on test set
#'
#' @param model lm model
#' @param test Test data
#' @return Numeric vector of predictions
predict_mlr <- function(model, test) {
  predict(model, newdata = test)
}

#' Predict with PCR model
#'
#' @param model pcr model
#' @param test Test data
#' @param ncomp Number of components to use
#' @return Numeric vector of predictions
predict_pcr_model <- function(model, test, ncomp = 3) {
  as.numeric(predict(model, newdata = test, ncomp = ncomp))
}

#' Predict with PLS model
#'
#' @param model plsr model
#' @param test Test data
#' @param ncomp Number of components to use
#' @return Numeric vector of predictions
predict_pls_model <- function(model, test, ncomp = 3) {
  as.numeric(predict(model, newdata = test, ncomp = ncomp))
}

#---------------------------------
# 5. Evaluation metrics
#---------------------------------

#' Compute RMSE between actual and predicted values
#'
#' @param actual True values
#' @param predicted Predicted values
#' @return RMSE as a single numeric value
rmse <- function(actual, predicted) {
  sqrt(mean((actual - predicted)^2))
}

#' Compute correlation between actual and predicted values
#'
#' @param actual True values
#' @param predicted Predicted values
#' @return Pearson correlation
pred_correlation <- function(actual, predicted) {
  stats::cor(actual, predicted)
}

#' Run full evaluation for a model
#'
#' @param actual True values
#' @param predicted Predicted values
#' @param model_name Short name for the model
#' @return A one-row data.frame with RMSE and correlation
summarise_model_performance <- function(actual, predicted, model_name) {
  data.frame(
    model      = model_name,
    rmse       = rmse(actual, predicted),
    correlation = pred_correlation(actual, predicted)
  )
}

