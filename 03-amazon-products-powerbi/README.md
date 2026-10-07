# Amazon Products — Rating vs. Popularity Analysis (Power BI)

**Type:** Individual assignment · **Course:** MIS 419 – Knowledge Management & Data Mining · **Date:** September 2026
**Tools:** Power BI Desktop

## The problem
An online retailer's product catalogue has thousands of items, each with an average customer rating and a number of ratings. Which products are both **highly rated** *and* **popular** — and does that differ by category?

## What I did
1. Imported the Amazon product dataset into Power BI and reviewed the fields (product ID, product name, category, rating, rating count).
2. Built a **scatter chart** that plots every product by **average rating (x-axis)** against **average rating count (y-axis)**, coloured by **category**.
3. Added rich **tooltips** (product name, ID, category, rating, rating count) so a user can hover over any point and identify the product instantly.

## Why this view is useful
- Products in the **top-right** are proven winners: highly rated *and* widely bought — candidates for promotion.
- Products with **high ratings but few reviews** are hidden gems that may deserve more marketing.
- Products with **many reviews but low ratings** signal quality issues worth investigating.
- Colour by category shows which categories dominate each zone.

## Files
- [`amazon_products_rating_analysis.pbix`](amazon_products_rating_analysis.pbix) — open with Power BI Desktop (free)

## Skills demonstrated
Power BI visual design · scatter analysis · tooltip design · turning a chart into business recommendations
