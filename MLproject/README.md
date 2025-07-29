# Cardiovascular Disease Prediction

This project aims to predict the 10-year risk of coronary heart disease (CHD) using a logistic regression model based on the [Cardiovascular Study dataset](https://www.kaggle.com/datasets/christofel04/cardiovascular-study-dataset-predict-heart-disea). The goal is to identify key risk factors and build a predictive model that helps assess long-term cardiovascular risk.

## Tools Used
Python

Pandas

Matplotlib 

Seaborn

Jupyter Notebook

Scikit-learn

## Dataset

The dataset includes medical and lifestyle information from a long-term cardiovascular study. Key features used for prediction include:

- Age  
- Gender  
- Total cholesterol  
- Systolic and diastolic blood pressure  
- Smoking habits  
- Glucose levels  
- BMI
- Heart rate  
- Presence of hypertension, diabetes  
- And more  

**Target variable:**  
- `TenYearCHD`: whether the person developed CHD within 10 years (1 = Yes, 0 = No)

##  Model

A **logistic regression** model was trained to classify whether a person is at risk of CHD within the next 10 years.

### Key Steps:
- Data cleaning and preprocessing  
- Exploratory Data Analysis
- Modeling
- Evaluation metrics: Precision, Recall

## Results

- Logistic regression model achieved an:
 - Precision: 0.226
 - Recall: 0.84
- Most important predictors by coefficient size:
  - `prevalentStroke`: **1.08**
  - `sex`: **0.30**
  - `is_smoking`: **0.25**




Created by Giedrius Bergaudas 
