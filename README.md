# 📈 Growth Dashboard for 365 DataScience

This project demonstrates an end-to-end data pipeline and dashboard development process to analyze user growth trends for 365 DataScience. It combines **SQL**, **Python**, and **Tableau** to extract, transform, analyze, and visualize millions of records from a MySQL database.

---

##  Tech Stack

- **SQL (MySQL)**
- **Python (pandas, mysql.connector)**
- **Tableau (Desktop & Public)**

---

##  Project Workflow

### 1. **Data Preparation with SQL**
- Wrote optimized SQL queries for tables containing millions of records.
- Utilized advanced SQL techniques including CTEs, complex JOINs, conditional logic (CASE WHEN, IF, IFNULL), date formatting, type casting, aggregation function
- Ensured clean, structured data for downstream transformation.

### 2. **Data Transformation with Python**
Connected MySQL to Python with the following libraries:
- pandas – for data manipulation
- datetime – for handling date logic
- mysql.connector – for connecting to MySQL
Connected to the MySQL database and loaded extracted data into Python.
Created custom functions to identify and label user types:
- Base users
- New users
- Churned users
- Resurrected users
Applied these functions to transform the dataset. Saved the transformed results and wrote them back into MySQL for visualization in Tableau.

### 3. Data Visualization with Tableau
- Connected Tableau to MySQL using a live connection for up-to-date insights.
- Created interactive and user-friendly dashboard with:
- Date granularity filter (daily, weekly, monthly) via complex calculated fields & parameters
- Label toggle using parameter controls
- Reference lines for setting minimum axis ranges
- Stacked bar charts with total value labels
- Top N Channels dynamic filter
- Conditional coloring and arrows for KPIs (positive/negative values)
- Clean layout and professional styling for clarity and usability

📊 Dashboard Features
- Track user growth over time with dynamic granularity
- Understand key metrics and user types (new, churned, resurrected)
- Analyze top-performing acquisition channels
- Interact with visual elements to tailor insights to business needs


🌐 Live Dashboard<br>
🚀 [Click here to view the live dashboard on Tableau Public](https://public.tableau.com/views/GrowthAnalysis_17505893028420/DashboardHome?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)


⭐️ Don't forget to star the repo if you found this useful :)
