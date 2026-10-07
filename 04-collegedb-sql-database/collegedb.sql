
-- حذف قاعدة البيانات إذا كانت موجودة
DROP DATABASE IF EXISTS CollegeDB;
CREATE DATABASE CollegeDB;
USE CollegeDB;

-- إنشاء الجداول
CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);

CREATE TABLE Teachers (
    teacher_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT
);

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    enrollment_date DATE
);

CREATE TABLE Enrollments (
    enroll_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    grade VARCHAR(5),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

CREATE TABLE CourseAssignments (
    assignment_id INT PRIMARY KEY,
    teacher_id INT,
    course_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

CREATE TABLE StudentBackup LIKE Students;

-- إدخال بيانات تجريبية
INSERT INTO Departments VALUES 
(1, 'Computer Science'),
(2, 'Business Administration'),
(3, 'Mathematics');

INSERT INTO Teachers VALUES 
(101, 'Ahmed', 'Salem', 'ahmed.salem@college.edu', 1),
(102, 'Noura', 'Ali', 'noura.ali@college.edu', 2),
(103, 'Faisal', 'Khalid', 'faisal.k@college.edu', 1);

INSERT INTO Courses VALUES 
(201, 'Database Systems', 3),
(202, 'Marketing Principles', 2),
(203, 'Linear Algebra', 3);

INSERT INTO Students VALUES 
(301, 'Sara', 'Mansour', 'sara.m@students.edu', '0501234567', '2023-09-01'),
(302, 'Khalid', 'Zaid', 'khalid.z@students.edu', '0502345678', '2022-09-01'),
(303, 'Lama', 'Ibrahim', 'lama.i@students.edu', '0503456789', '2024-01-10');

INSERT INTO Enrollments VALUES 
(401, 301, 201, 'A'),
(402, 302, 202, 'B'),
(403, 303, 203, 'A+');

INSERT INTO CourseAssignments VALUES 
(501, 101, 201),
(502, 102, 202),
(503, 103, 203);

-- نسخ بيانات الطلاب إلى جدول النسخة الاحتياطية
INSERT INTO StudentBackup
SELECT * FROM Students;

-- إنشاء View لأسماء الطلاب والمقررات
CREATE VIEW StudentCourses AS
SELECT s.first_name, s.last_name, c.course_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id;

-- إنشاء Stored Procedure لإضافة طالب
DELIMITER //
CREATE PROCEDURE AddStudent(
    IN p_id INT,
    IN p_first_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_phone VARCHAR(20),
    IN p_date DATE
)
BEGIN
    INSERT INTO Students(student_id, first_name, last_name, email, phone, enrollment_date)
    VALUES (p_id, p_first_name, p_last_name, p_email, p_phone, p_date);
END //
DELIMITER ;

-- إنشاء Function تعيد عدد الطلاب
DELIMITER //
CREATE FUNCTION GetTotalStudents()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM Students;
    RETURN total;
END //
DELIMITER ;

-- إنشاء جدول Log للتسجيلات
CREATE TABLE EnrollmentLog (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrolled_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- إنشاء Trigger لتسجيل التسجيلات الجديدة
DELIMITER //
CREATE TRIGGER LogEnrollment
AFTER INSERT ON Enrollments
FOR EACH ROW
BEGIN
    INSERT INTO EnrollmentLog(student_id, course_id)
    VALUES (NEW.student_id, NEW.course_id);
END //
DELIMITER ;

-- إنشاء Cursor لعرض أسماء المعلمين
DELIMITER //
CREATE PROCEDURE ShowAllTeachers()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE t_name VARCHAR(100);
    DECLARE cur CURSOR FOR 
        SELECT CONCAT(first_name, ' ', last_name) FROM Teachers;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO t_name;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SELECT t_name AS Teacher;
    END LOOP;

    CLOSE cur;
END //
DELIMITER ;

-- إنشاء Procedure لإضافة مقرر باستخدام Dynamic SQL
DELIMITER //
CREATE PROCEDURE AddCourseDynamic(
    IN id INT,
    IN name VARCHAR(100),
    IN cr INT
)
BEGIN
    SET @sql = CONCAT("INSERT INTO Courses(course_id, course_name, credits) VALUES (", id, ", '", name, "', ", cr, ")");
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //
DELIMITER ;
