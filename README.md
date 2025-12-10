# EV Clustering and Price Modelling

*End-to-end R project for analysing an anonymised EV dataset: distance matrices, optimal-k selection, k-means clustering, dimensionality reduction, and predictive modelling (MLR, PCR, PLS) with RMSE benchmarking. Fully reproducible with modular functions and an HTML report.*

### Live Report: [Click Here](https://a6r9n.github.io/ev-clustering-modelling/ev_clustering_modelling.html)

---

## Project Overview

This project performs:

* **Clustering analysis** of an electric vehicle dataset
* **Dimensionality reduction & distance visualisation**
* **K-means clustering with silhouette validation**
* **Predictive modelling** of electric vehicle prices using:

  * Multiple Linear Regression (MLR)
  * Principal Component Regression (PCR)
  * Partial Least Squares Regression (PLS)

The goal is to understand structural patterns in EV specifications and build models to predict vehicle price with high accuracy.

---

## Folder Structure

```
ev-clustering-modelling/
│
├── Analysis/
│    └── ev_clustering_modelling.Rmd
│
├── Data/
│    └── ev-data-anon.csv
│
├── R/
│    ├── data_utils.R
│    ├── clustering.R
│    └── modelling.R
│
├── docs/
│    └── ev_clustering_modelling.html
│
└── README.md
```

---

## Techniques Used

### **Clustering & Visualisation**

* Distance matrix (heatmap)
* Silhouette analysis for optimal K
* K-means clustering
* Scaled numeric attributes
* Cluster centroids visualisation

### **Modelling & Prediction**

* Train/test split (80/20)
* Multiple Linear Regression
* Principal Component Regression
* Partial Least Squares Regression
* RMSE comparison across models

---

## **Results**

| Model   | RMSE ↓   | Correlation ↑ |
| ------- | -------- | ------------- |
| **MLR** | High     | Moderate      |
| **PCR** | Mid      | Strong        |
| **PLS** | Lowest   | Strongest     |

**Conclusion:**
*Partial Least Squares (PLS) achieved the best prediction performance.*

---

## How to Reproduce

1. Clone the repository:

```bash
git clone https://github.com/a6r9n/ev-clustering-modelling.git
```

2. Open RStudio and install required packages:

```r
install.packages(c("ggplot2", "dplyr", "factoextra", "pls"))
```

3. Open `Analysis/ev_clustering_modelling.Rmd`

4. Click **Knit** to generate the HTML report.

---
