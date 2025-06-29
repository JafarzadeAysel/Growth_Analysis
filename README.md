# 📈 Growth Dashboard for 365 DataScience

This project demonstrates an end-to-end data pipeline and dashboard development process to analyze user growth trends for 365 DataScience. It combines **SQL**, **Python**, and **Tableau** to extract, transform, analyze, and visualize millions of records from a MySQL database.

---

## 🔧 Tech Stack

- **SQL (MySQL)**
- **Python (pandas, mysql.connector)**
- **Tableau (Desktop & Public)**

---

## 🗂 Project Workflow

### 1. **Data Preparation with SQL**
- Wrote optimized SQL queries for tables containing millions of records.
- Used advanced SQL techniques such as:
  - `CTEs`, `JOINs`, `CASE WHEN`, `IFNULL`, `IF`, `DATE_FORMAT`, `MIN()`, `CAST()`, and subqueries.
- Ensured clean, structured data for downstream transformation.

### 2. **Data Transformation with Python**
- Connected MySQL to Python using:
  ```python
  import pandas as pd  
  from datetime import date, timedelta  
  import mysql.connector
