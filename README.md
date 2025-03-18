# Restaurant Sales Analysis & Performance Dashboard

## Description
This project analyzes restaurant sales data, focusing on key metrics such as best-selling items, revenue trends over time, and the most common payment methods. The analysis was performed using SQL for data cleaning, and the results were visualized through Tableau for better understanding and decision-making.

The project includes:
- A data cleaning script in SQL to preprocess the sales data.
- A Tableau dashboard to visualize key insights from the restaurant sales data.

## Files Included
- **restaurant_sales_cleaning.sql**: SQL script used to clean and preprocess the sales data. It removes duplicates, handles null values, and prepares the data for analysis.
- **Restaurant Performance Overview.png**: A screenshot of the Tableau dashboard that visualizes key metrics, such as best-selling items by quantity, revenue items by sales value, and monthly revenue trends.
- **Restaurant Performance Overview.twbx**: The Tableau workbook containing the interactive dashboard visualizing restaurant sales performance over time, payment methods, and more.

## Setup Instructions
1. **SQL Script**:
   - Run the `restaurant_sales_cleaning.sql` script in a MySQL database to clean the raw sales data. This script will prepare the data by removing any invalid or redundant entries.
   
2. **Tableau Dashboard**:
   - Open the `Restaurant Performance Overview.twbx` file in Tableau Desktop. This file contains the interactive dashboard that displays visualizations such as:
     - Top 10 best-selling items by quantity.
     - Top 10 revenue-generating items by sales value.
     - Payment method breakdown.
     - Revenue trends over time.
   - You can explore the dashboard and interact with the visualizations to gain insights into the restaurant’s performance.

3. **View the Dashboard Image**:
   - The `Restaurant Performance Overview.png` file is a static image of the dashboard, allowing you to get an overview of the key visualizations if you don't have access to Tableau.

## Key Insights
- **Top-selling Items by Quantity**: Pasta Alfredo, Side Salad, and Water were the most popular items in terms of quantity sold.
- **Revenue by Sales Value**: The most profitable items were Pasta Alfredo, Grilled Chicken, and Steak.
- **Payment Methods**: The majority of payments were made via credit cards, followed by cash and digital wallets.
- **Revenue Trends**: The restaurant saw steady growth in revenue from January to June, followed by some fluctuations in the latter months.

## Technologies Used
- **SQL**: Data cleaning and preparation.
- **Tableau**: Data visualization and dashboard creation.
- **MySQL**: Database management.

## License
The dataset used in this project is sourced from Kaggle and is provided without any explicit license. Please refer to the [dataset page on Kaggle](https://www.kaggle.com/datasets/ahmedmohamed2003/restaurant-sales-dirty-data-for-cleaning-training) for further details. This project is intended for educational and personal use only. No commercial use is permitted unless otherwise stated by the dataset owner.

## Contributions
Feel free to fork this repository, make improvements, or contribute additional analysis. Contributions are welcome!
