# Funnel & Retention Analysis with SQL – MercadoLibre

## Project Overview
This project analyzes user behavior across the e-commerce funnel for MercadoLibre, focusing on **conversion performance** and **user retention over time**. The goal is to identify drop-off points, evaluate engagement patterns, and generate actionable insights to support product and growth decisions.

The analysis simulates a real-world business case where data is used to optimize conversion rates and improve customer retention across markets and platforms.

---

## Business Problem
E-commerce platforms face challenges in understanding:
- Where users drop off in the conversion funnel
- How retention evolves after the first interaction
- Which segments (country, device, traffic source) show weaker performance

This project addresses these questions by combining **funnel analysis** and **cohort-based retention analysis** using SQL.

---

## Objectives
- Build a multi-step conversion funnel from raw event-level data
- Calculate conversion rates and drop-offs at each funnel stage
- Analyze user retention at D7, D14, D21, and D28
- Compare funnel and retention performance across key segments
- Deliver data-driven recommendations for growth and retention optimization

---

## Data & Methodology
- Created structured queries using **SQL and CTEs**
- Defined funnel stages (visit → product view → cart → purchase)
- Calculated conversion metrics and leakage points
- Built cohort tables to measure retention over time
- Segmented analysis by country, device type, and traffic source
- Applied validation checks to ensure metric accuracy and consistency

---

## Key Insights
- Identified critical drop-off stages with the highest impact on overall conversion
- An average drop-off rate of 84.5% between the select_item and add_to_cart stages shows the first major loss of users in the conversion table.
- Detected meaningful differences in funnel efficiency by device and country
- Revealed retention decay patterns across cohorts, highlighting opportunities for early engagement improvements
- Quantified the potential business impact of improving key funnel steps

<img width="1007" height="540" alt="image" src="https://github.com/user-attachments/assets/697f28a8-bca2-4ee6-9e93-736ec697eb32" />

---

## Tools & Technologies
- **SQL**
- **Common Table Expressions (CTEs)**
- Relational databases
- Funnel analysis
- Cohort retention analysis
- KPI calculation and validation

---

## Deliverables
- Clean, well-documented SQL queries
- Funnel and retention metrics tables
- Executive-level insights and recommendations
- Simulated business impact scenarios for conversion and retention improvements

---

## Business Impact
The analysis provides a structured framework for:
- Improving conversion rates through targeted funnel optimization
- Enhancing retention strategies based on cohort behavior
- Supporting data-driven decision-making for product and growth teams

---

## Author
**Ricardo Hernández**  
Data Analyst | Engineering Background | SQL & Python  
