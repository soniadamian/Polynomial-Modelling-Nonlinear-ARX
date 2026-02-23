# Polynomial-Modelling-Nonlinear-ARX
Team-based system identification project involving polynomial regression and nonlinear ARX modeling for static and dynamic systems, including parameter estimation, validation, and performance analysis in MATLAB.
## Project Overview

This project is split into two complementary parts:

1) **Static nonlinear function approximation** using 2D polynomial regression  
2) **Dynamic system identification** using an **ARX (AutoRegressive with eXogenous input)** model

Both parts emphasize:
- manual construction of regression matrices (feature engineering)
- least squares parameter estimation
- validation-based evaluation (MSE)
- analysis of overfitting / generalization

---

## Part 1 — Static Nonlinear Function Fitting (Polynomial Regression)

### Goal
Approximate an unknown 2D nonlinear static function `y = f(x1, x2)` from identification data and evaluate generalization on a separate validation set.

### Method
- Build polynomial basis features up to degree **m**:
  
- Construct regression matrix **PHI** over the input grid.
- Estimate parameters using **Least Squares**
- Compute **MSE** on both identification and validation sets for multiple values of **m**
- Select **optimal polynomial degree** based on validation MSE

### Outputs
- 3D surface plots: true vs. approximated function (ID and VAL)
- MSE curves vs. model degree (overfitting analysis)
- Best-degree model re-evaluated and visualized

---

## Part 2 — Dynamic System Identification (ARX)

### Goal
Identify a discrete-time dynamic model relating input `u(k)` to output `y(k)` using an ARX structure, then compare:
- **one-step-ahead prediction**
- **free-run simulation**

### ARX model:
y(k) + a1*y(k-1) + ... + a_na*y(k-na) = b1*u(k-1) + ... + b_nb*u(k-nb)

### Method
- Build regression matrix:
  - past outputs: `-y(k-i)` for `i=1..na`
  - past inputs: `u(k-j)` for `j=1..nb`
- Estimate parameters using **Least Squares**:

- Evaluate:
  - **Free-run simulation** by recursively generating `yhat(k)` using past predicted outputs
  - **One-step-ahead prediction** using measured regressors: `y_pred = PHI_val * theta`
- Compare results with MATLAB System Identification Toolbox:
  - `arx(id_data,[na nb nk])`
  - `sim(arx_model, val_data)`

### Outputs
- Plots comparing:
  - measured vs simulated output (`y` vs `yhat`)
  - measured vs simulated vs predicted (`y_val` vs `yhat_val` vs `y_pred`)

---

## Evaluation

- **Validation-based model selection** (Part 1: polynomial degree `m`)
- **Error metrics:** Mean Squared Error (MSE)
- **Generalization analysis:** compare training vs validation error
- **Prediction vs Simulation:** assess dynamic model performance under free-run conditions

---

##  Technologies Used

- MATLAB
- Least Squares Estimation
- Polynomial Feature Expansion
- ARX Modeling (System Identification)
- Model Validation (MSE, overfitting analysis)
- MATLAB System Identification Toolbox (baseline comparison)

---


##  Notes

- This was a **team project** developed as part of a system identification assignment.
- The implementation includes both **manual identification** and a **toolbox-based baseline** for comparison.

---
