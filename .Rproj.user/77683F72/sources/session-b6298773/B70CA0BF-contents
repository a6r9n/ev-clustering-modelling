# R/data_utils.R
# Helper functions for loading and preparing the EV dataset

#' Load EV dataset
#'
#' @param path Path to the anonymised EV CSV file.
#' @return A data.frame with EV features.
load_ev_data <- function(path = "../Data/Processed/ev-data-anon.csv") {
  ev <- read.csv(path, check.names = TRUE)
  
  # Ensure all numeric-looking columns are numeric
  num_cols <- sapply(ev, is.numeric)
  ev[, num_cols] <- lapply(ev[, num_cols, drop = FALSE], as.numeric)
  
  ev
}

#' Scale numeric columns of EV dataset for clustering
#'
#' @param ev Data frame returned by load_ev_data()
#' @return A scaled numeric matrix suitable for clustering
scale_ev_numeric <- function(ev) {
  num_cols <- sapply(ev, is.numeric)
  
  ev_scaled <- scale(ev[, num_cols, drop = FALSE])
  
  # Optional: preserve rownames if present
  if (!is.null(rownames(ev))) {
    rownames(ev_scaled) <- rownames(ev)
  }
  
  ev_scaled
}
