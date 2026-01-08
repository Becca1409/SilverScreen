# SilverScreen 🎬

This project models and analyzes cinema performance data using dbt, with the goal of producing a clean, business-ready table that shows cinema profitability by movie, month, and location.

The data represents the operations of Silver Screen, an entertainment company operating three cinema locations in New Jersey, USA, where management requested visibility into the performance and efficiency of each location.

The project follows dbt best practices, with a clear separation between staging, intermediate, and mart layers, and a strong focus on grain alignment, data quality, and testing.

---

## Project Structure

- **staging/**
  - Cleans and standardizes raw source data
  - Applies light transformations (renaming, typing, date truncation)
  - One model per source

- **int/**
  - Combines and aggregates staging models
  - Aligns data to a consistent grain (movie × month × location)
  - Separates revenue logic from cost logic

- **marts/**
  - Final business-facing model: `cinema_profitability`
  - Joins revenue and cost data at the same grain
  - Ready for analysis and reporting

---

## Key Models

- `int_revenue`  
  Aggregates ticket sales and revenue per movie, month, and also location.

- `int_movie_costs`  
  Aggregates rental costs per movie, month, and location and adds movie data for additional context.

- `cinema_profitability`  
  Final model is combining revenue and costs in order to support a profitability analysis.

---

## Data Quality & Testing

The project includes both schema tests and custom singular tests:
- `not_null` checks on key columns
- Custom test to ensure **revenue is never negative**
- Custom grain test to validate **one row per movie × month × location**
- A full dbt pipeline built on Snowflake, with staging (raw source data), intermediate models (cleaned, renamed, and standardized), and mart models (final table for analysis)
- A production dbt Cloud deploy job runs `dbt build` successfully, validating models and tests end-to-end

All models pass `dbt run` and `dbt test` successfully.

---

## Notes

For this project, some transformations (such as monthly date truncation, column renaming, and data type standardization) were intentionally applied in the **staging layer**, as the dataset is small and the focus is on clarity and learning rather than large-scale optimization.

---

## Tools Used

- dbt Cloud
- Snowflake
- GitHub

---

This project was built step by step, with an emphasis on understanding *why* each modeling decision was made, not just making the code work.
