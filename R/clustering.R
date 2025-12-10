# R/clustering.R
# Clustering utilities for EV dataset

library(factoextra)
library(cluster)

#-----------------------------
# Distance matrix helpers
#-----------------------------

#' Compute a Euclidean distance matrix for scaled EV data
#'
#' @param ev_scaled Numeric matrix from scale_ev_numeric()
#' @param n_sample Optional: number of rows to keep (e.g. 30 for a smaller heatmap)
#' @return A dist object
compute_ev_distance <- function(ev_scaled, n_sample = NULL) {
  if (!is.null(n_sample)) {
    ev_scaled <- ev_scaled[1:n_sample, , drop = FALSE]
  }
  
  d <- dist(ev_scaled, method = "euclidean")
  attr(d, "labels") <- rownames(ev_scaled)
  d
}

#' Plot a distance matrix as a heatmap
#'
#' @param dist_obj A dist object from compute_ev_distance()
plot_ev_distance <- function(dist_obj) {
  factoextra::fviz_dist(
    dist_obj,
    lab_size   = 3,
    show_labels = TRUE
  )
}

#-----------------------------
# K-means clustering helpers
#-----------------------------

#' Silhouette-based choice of k
#'
#' @param ev_scaled Numeric matrix from scale_ev_numeric()
#' @param k_max Maximum k to try (default 10)
#' @return A ggplot object from fviz_nbclust()
find_optimal_k <- function(ev_scaled, k_max = 10) {
  factoextra::fviz_nbclust(
    ev_scaled,
    FUNcluster = kmeans,
    method     = "silhouette",
    k.max      = k_max
  )
}

#' Run k-means on scaled EV data
#'
#' @param ev_scaled Numeric matrix from scale_ev_numeric()
#' @param k Number of clusters
#' @param seed Random seed for reproducibility
#' @return A list with kmeans model and cluster vector
run_kmeans_ev <- function(ev_scaled, k, seed = 123) {
  set.seed(seed)
  km <- kmeans(ev_scaled, centers = k, nstart = 25)
  
  list(
    model    = km,
    clusters = km$cluster
  )
}

#' Plot k-means clusters using the first two principal components
#'
#' @param ev_scaled Numeric matrix from scale_ev_numeric()
#' @param km_result List returned by run_kmeans_ev()
plot_kmeans_clusters <- function(ev_scaled, km_result) {
  factoextra::fviz_cluster(
    km_result$model,
    data        = ev_scaled,
    ellipse     = TRUE,
    geom        = "point",
    show.clust.cent = TRUE,
    repel       = TRUE
  )
}
