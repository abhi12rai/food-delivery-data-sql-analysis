# 🍔 SQL Data Analytics Project – Food Delivery Case Study

## ✨ Project Introduction
This project is based on Food Delivery Orders Data created to simulate a real-world business case for a food delivery platform (similar to Noon Food in Dubai).

We will solve a series of interesting SQL questions that analyze customer behavior, restaurant performance, and promotional activities.
The goal is to derive meaningful business insights to support the growth and operations teams.

The project is designed step-by-step to mirror how analysts approach real industry problems

## 🗂️ Dataset Overview
The data records food orders placed between 1st January 2025 and 31st March 2025 (3 months of data).
Although the actual Noon Food launched on 1st May, for the purpose of this project, we consider 1st Jan 2025 as the launch date.

Table: orders


Column Name	Description
Order_id	Unique identifier for each order
Customer_code	Unique identifier for each customer
Placed_at	Date and time when the order was placed
Restaurant_id	ID of the restaurant fulfilling the order
Cuisine	Type of cuisine (e.g., Italian, Chinese, Indian)
Order_status	Status of the order (Delivered, Cancelled, etc.)
Promo_code_Name	Name of promo code used (nullable)
If Promo_code_Name is NULL, the order was placed without a promo code.

If populated, the customer applied a promo during checkout.

## 🎯 Objective of the Project

The main objective of this project is to perform data analysis on food delivery order data to help the business team and growth team at Noon Food make better decisions.

Through SQL queries, we aim to:
- Identify the top-performing restaurants by cuisine.
- Track customer acquisition trends over time.
- Understand customer loyalty and retention behavior.
- Analyze the impact of promotional codes on customer acquisition.
- Provide insights that can drive marketing strategies and personalized communication.

The project simulates real-world business problems faced by food delivery companies and demonstrates how data-driven insights can be generated using SQL.



## Problem Statements:

Identify the Top 3 Outlets by Cuisine Type
Find the top 3 restaurants for each cuisine based on the number of orders, without using LIMIT or TOP functions.

Calculate Daily New Customer Acquisition
Determine how many new customers joined (placed their first order) each day since the launch date.

Find Customers Acquired in January 2025 with Only One Order
Count the customers who were acquired in January 2025 and placed only one order, without placing any further orders.

List Inactive Customers Acquired a Month Ago
Find customers who were acquired one month ago with their first order using a promo code, and have not placed any orders in the last 7 days.

Trigger Communication After Every Third Order
Create a query that identifies customers who have just placed their 3rd, 6th, 9th (etc.) order, to trigger personalized communication.

Identify Promo-Only Customers
List customers who have placed more than one order, and all their orders were placed using a promo code only.

Analyze Organic Customer Acquisition in January 2025
Calculate what percentage of customers were organically acquired in January 2025 (placed their first order without any promo code).

All queries are included in [`food_delivery_analysis.sql`](./food_delivery_analysis.sql).


## 🛠️ Skills Demonstrated
SQL querying

Data cleaning & transformation

CTEs (Common Table Expressions)

Window functions (ROW_NUMBER, RANK, etc.)

Aggregations and filtering

Analytical problem solving

Business insight generation


## 🙋‍♂️ About Me
Hi, I'm Abhishek – a credit controller learning data analytics. I’ve completed SQL courses and am actively building a portfolio.

Let’s connect on [LinkedIn](linkedin.com/in/abhishek-rai-5054001b7)!

## ⭐️ If you like this project, give it a star!
