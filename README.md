# Data-Science-Internship-Project 

<img alt="internship" src="assets/Shine_Intern_-_Linkedin_Announcement.png" width="50%" />

This repository contains the project files for my Data Science internship at 10Pearls for their Shine Internship Program. 

## Project Overview
The objective of this project is to analyze customer churn data from a telecommunications company, develop a predictive model to identify customers who are likely to churn, and manage the data using SQL. Churn with a telecommunications company happens when a customer stops using the services of the telecommunication and might opt for another telecommunications company for services. There can be various reasons for churn, for example, poor service quality, high rates of services that are unable to meet the required standards, etc. The project aims to understand the reasons for customer churn patterns based on various factors, and be able to predict whether a customer is likely to churn or not. 

## Project Structure
The project is divided into four main modules:
- **Module 1: Python**
- **Module 2: AI Algorithm**
- **Module 3: SQL**
- **Module 4: Model Deployment**

## Data Set Overview
The dataset is available in the [data](data) folder as [Telco-Customer-Churn.csv](Telco-Customer-Churn.csv). Each row represents a customer, each column contains customer’s attributes described on the column Metadata.
**The dataset includes information about:**
- Customers who left within the last month – the column is called Churn
- Services that each customer has signed up for – phone, multiple lines, internet, online security, online backup, device protection, tech support, and streaming TV and movies
- Customer account information – how long they’ve been a customer, contract, payment method, paperless billing, monthly charges, and total charges
- Demographic info about customers – gender, age range, and if they have partners and dependents

---

## Modules
### 1. Python - Data Processing, EDA, and Feature Engineering

Some of the insights from the data set, included with visuals in the [Module 1 Task](Module_1_Python_DataProcessing/Data_Processing.ipynb) file are as follows:
1.  **Month-to-Month** contract types had the **highest churn** rates amongst all contract types
2. Customers with higher monthly charges yet lower total charges tend to churn more, this may indicate that they select a lot of services that result in a higher monthly charge, yet before it accumulates a lot to contribute to total charges, they churn. 
3. The above point is further strengthened by the fact that customers with lesser tenures show a higher churn rate than those with higher tenures. This indicates that customers with lesser monthly charges, but longer tenures show more loyalty to the teleco.
4. Customers with partners also have a lower churn rate than those without partners.
5. Customers paying via electronic check have the highest churn rates, which may indicate they are dissatisfied with this service, while customers with automatic payment methods (bank and credit card) have the lowest churn rates. 
6. Finally, we used SMOTE (Synthetic Minority Oversampling Technique) to generate synthetic data, to improve the performance of our model (without this, our model produced less accuracies as desired) 


### 2. AI Algorithm - Machine Learning Model Training, Tuning, Evaluation and Selection

The exported data set, from Module 1, was split into training and testing sets. 80% of the data was used for training the model, while 20% of the data was used for testing the model.

The set of models was as so:
- Logistic Regression
- Decision Trees
- Random Forest
- Gradient Boosting
- Support Vector Machine
- XGBoost
- Voting Classifier

The models were then tuned using Grid Search where appropriate, and then ranked based on various metrics. A table summary is shown below:

**Single Value Rankings:**
| Model | Accuracy | Precision | Recall | F1-Score | ROC-AUC | 
| --- | --- | --- | --- | --- | --- |
| Voting Classifier |  0.854308 | 0.850674 | 0.858115 | 0.854378 | 0.854323 |
| XGBoost (Tuned) | 0.854308 | 0.854776 | 0.852284 | 0.853528 | 0.854300 |
| Gradient Boosting (Tuned) | 0.851404 | 0.853922 | 0.846453 | 0.850171 | 0.851385 |
| Logistic Regression (Tuned) | 0.845595 | 0.856426 | 0.828960 | 0.842469 | 0.845531 |
| Random Forest (Tuned) | 0.843175 | 0.846608 | 0.836735 | 0.841642 | 0.843150 |
| Decision Tree (Tuned) | 0.820910 | 0.828514 | 0.807580 | 0.817913 | 0.820859 |
| Support Vector Machine | 0.644724 | 0.665174 | 0.577259 | 0.618106 | 0.644464 |

**Cross Validation (CV) Rankings:**
| Model | CV Accuracy | CV Precision | CV Recall | CV F1-Score | CV ROC-AUC |
| --- | --- | --- | --- | --- | --- |
| Voting Classifier | 0.841964 | 0.846039 | 0.834199 | 0.828119 | 0.935283 |
| XGBoost (Tuned) | 0.839060 | 0.849521 | 0.821803 | 0.821243 | 0.936882 |
| Random Forest (Tuned) | 0.837509 | 0.849088 | 0.820446 | 0.820879 | 0.933112 |
| Gradient Boosting (Tuned) | 0.836833 | 0.848448 | 0.818510 | 0.818419 | 0.935346 |
| Logistic Regression (Tuned) | 0.830732 | 0.853064 | 0.797789 | 0.808648 | 0.932161 |
| Decision Tree (Tuned) | 0.816008 | 0.805139 | 0.830326 | 0.810678 | 0.885085 |
| Support Vector Machine | 0.659694 | 0.678475 | 0.607596 | 0.640950 | 0.742976 |

**Best Models**
Based on the above values, the Voting Classifier was evaluated to be the best, with XGBoost (Tuned) coming in a close second. However, interestingly, for finding the prediction results, the **Random Forest (Tuned)** model gave the best results with **91.14%** being correct predictions.

### 3. SQL - Database Schema Design, SQL Queries and SQL Analysis
For the purposes of this project, a **PostgreSQL** database was used with **pgAdmin4** for database management. As per the details of the task given, the schema had 4 tables; customers, services, billing and churn predictions, each being linked with the **customer ID** as the key (primary for customers and foreign referenced for the other tables).
The ERD was then designed (in pgAdmin through ERD Tool) as so:
![ERD](assets/schema.png)

The SQL Queries have been documented in the [Scripts](Module_3_SQL_Analysis/sql_scripts/) directory.

The summary report along with insights is all mentioned in the [Module 3 SQL](Module_3_SQL_Analysis/sql_analysis.ipynb) file.


### 4. Model Deployment and API Consumption
The trained models were now deployed using a Flask Application along with API for consumption. The models were saved as a pickle file, and then loaded into the Flask application. The API was then created to consume the model, and the model was tested using `Curl`.

The complete documentation can be found in the [Module 4 Model Deployment](Module_4_Model_Deployment) directory in the [python notebook](model_depl_api.ipynb).

Currently its being explored for deployment on a proper server, and will be updated soon.

---

## Acknowledgements
I am grateful for [10Pearls](www.10pearls.com) for providing me with this internship opportunity under their Shine Internship Program. It was an amazing learning opportunity, and a great 8 weeks. 

Special thanks to **Ummara Amin**, **Ambreen Gul** for making the onboarding process smooth, and a special thanks to **Syed Zainab Yousuf Zaidi** - our technical mentor for her mentorship during the internship. 