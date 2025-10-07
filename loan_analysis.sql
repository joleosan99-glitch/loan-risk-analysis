-- Data exploration
SELECT COUNT(*) AS total_applications FROM loan_data;


-- Overall approval rate
SELECT 
    Loan_Status,
    COUNT(*) AS count_applicants,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM loan_data), 2) AS percentage
FROM loan_data
GROUP BY Loan_Status;


-- Risk segmentation dengan CTE
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