# CollegeDB — Relational Database Design & SQL (MySQL)

**Type:** Semester project · **Date:** May 2025 · **Tools:** MySQL, MySQL Workbench

## The problem
A college needs one reliable place to store and query its students, teachers, departments, courses, enrollments and teaching assignments.

## What I did
1. **Designed the schema** — 7 related tables with primary and foreign keys:
   `Departments`, `Teachers`, `Courses`, `Students`, `Enrollments`, `CourseAssignments`, and `StudentBackup` — plus an `EnrollmentLog` audit table.
2. **Built and populated it** with DDL (`CREATE`, `ALTER`) and DML (`INSERT`, `UPDATE`, `DELETE`).
3. **Wrote queries that answer real questions**, using:
   - filtering & sorting — `WHERE`, `LIKE`, `BETWEEN`, `IN`, `ORDER BY`
   - aggregation — `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, `GROUP BY`, `HAVING`
   - joins — `INNER`, `LEFT`, `RIGHT`, `CROSS`
   - set operations — `UNION`, plus `INTERSECT` and `MINUS` logic rebuilt with subqueries / `LEFT JOIN` (MySQL doesn't support them natively)
   - subqueries in `WHERE` and `FROM`
4. **Automated the database:**
   - a **view** (`StudentCourses`) that joins students to their courses,
   - **stored procedures** (`AddStudent`, `ShowAllTeachers`, `AddCourseDynamic` using dynamic SQL),
   - a **trigger** (`LogEnrollment`) that automatically records every new enrollment in an audit log,
   - a **function** and a **cursor**.

## Files
- [`collegedb.sql`](collegedb.sql) — full script: schema, data, queries, views, procedures, triggers
- [`collegedb_report.pdf`](collegedb_report.pdf) — project report with the ER diagram
- [`screenshots/`](screenshots) — screenshots of query results

## Skills demonstrated
Relational modelling · ER diagrams · SQL querying · joins & aggregation · views · stored procedures · triggers · audit logging
