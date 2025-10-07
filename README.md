# Loan Eligibility & Risk Analysis

## 📊 Business Understanding
This project analyzes loan application data to identify key factors that influence loan approval decisions. The goal is to help financial institutions improve their credit risk assessment and understand applicant profiles.

## 📁 Data Sources
- **Dataset:** Loan Prediction Dataset from Kaggle
- **Rows:** 614 loan applications
- **Period:** N/A

## 🛠️ Tools & Technologies
- **SQL** - Data analysis and querying
- **Tableau** - Data visualization and dashboard creation
- **DB Browser** - Database management

## 📈 SQL Analysis

### Data Exploration
```sql
-- Check basic dataset information
SELECT COUNT(*) AS total_applications FROM loan_data;
```

### Key Metrics Calculation
```sql
-- Overall approval rate
SELECT 
    Loan_Status,
    COUNT(*) AS count_applicants,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM loan_data), 2) AS percentage
FROM loan_data
GROUP BY Loan_Status;
```

### Risk Segmentation Analysis
```sql
-- Segment applicants by risk level
WITH ApplicantInfo AS (
    SELECT *,
           (ApplicantIncome + COALESCE(CoapplicantIncome, 0)) AS Total_Income
    FROM loan_data
)
SELECT 
    CASE 
        WHEN Credit_History = 1 AND Total_Income > 5000 THEN 'Low Risk'
        WHEN Credit_History = 1 AND Total_Income <= 5000 THEN 'Medium Risk' 
        ELSE 'High Risk'
    END AS risk_segment,
    COUNT(*) AS segment_count,
    ROUND(AVG(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END) * 100, 2) AS approval_rate
FROM ApplicantInfo
GROUP BY risk_segment
ORDER BY approval_rate DESC;
```

## 📊 Tableau Dashboard

[View Interactive Dashboard](https://public.tableau.com/app/profile/saputra.san/vizzes)

## 🔍 Key Findings

### 1. Approval Rate
- **69%** of loan applications were approved
- **31%** were rejected

### 2. Income Impact
- Approved applicants have **higher average income** than rejected applicants
- Strong positive correlation between income and loan amount

### 3. Education Factor
- Graduate applicants have **significantly higher approval rates**

### 4. Risk Segmentation
- **Low Risk** segment: Highest approval rate
- **High Risk** segment: Lowest approval rate

## 💡 Business Recommendations

1. **Credit Policy:** Consider relaxing criteria for medium-risk applicants with good credit history but moderate income
2. **Product Development:** Create specialized loan products for graduate professionals
3. **Risk Management:** Maintain strict criteria for high-risk segments

## 📂 Project Structure
```
loan-risk-analysis/
├── README.md
├── loan_analysis.sql
└── (https://public.tableau.com/app/profile/saputra.san/vizzes)
```
