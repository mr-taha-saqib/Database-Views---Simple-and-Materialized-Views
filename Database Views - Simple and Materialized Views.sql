--Lab 5

create database viewdb
use viewdb
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    instructor VARCHAR(100)
);

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

INSERT INTO Students (student_id, first_name, last_name, date_of_birth)
VALUES
    (1, 'John', 'Doe', '1995-05-15'),
    (2, 'Jane', 'Smith', '1998-09-20'),
    (3, 'Alice', 'Johnson', '1997-03-13'),
    (4, 'Ella', 'Johnson', '1996-07-12'),
    (5, 'Liam', 'Brown', '1999-02-25'),
    (6, 'Ava', 'Miller', '1998-11-18'),
    (7, 'Noah', 'Garcia', '1997-09-03'),
    (8, 'Olivia', 'Martinez', '1996-04-29'),
    (9, 'Emma', 'Lopez', '1998-06-21'),
    (10, 'William', 'Davis', '1997-03-14'),
    (11, 'Sophia', 'Rodriguez', '1999-08-05'),
    (12, 'James', 'Hernandez', '1995-12-08'),
    (13, 'Charlotte', 'Young', '1996-10-17'),
    (14, 'Benjamin', 'Lee', '1998-05-20'),
    (15, 'Amelia', 'Walker', '1997-01-23');

INSERT INTO Courses (course_id, course_name, instructor)
VALUES
    (101, 'Introduction to Database', 'Professor Smith'),
    (102, 'Web Development Basics', 'Professor Johnson'),
    (103, 'Data Analysis Techniques', 'Professor Brown'),
    (104, 'Advanced Database Management', 'Professor Johnson'),
    (105, 'Data Mining Techniques', 'Professor Lee'),
    (106, 'Web Application Development', 'Professor Martinez'),
    (107, 'Software Engineering Principles', 'Professor Davis'),
    (108, 'Network Security Fundamentals', 'Professor Rodriguez'),
    (109, 'Artificial Intelligence Fundamentals', 'Professor Hernandez'),
    (110, 'Database Design and Optimization', 'Professor Young'),
    (111, 'Mobile App Development', 'Professor Walker'),
    (112, 'Cloud Computing Technologies', 'Professor Moore'),
    (113, 'Human-Computer Interaction', 'Professor Turner'),
    (114, 'Business Analytics', 'Professor Perez'),
    (115, 'Computer Graphics and Visualization', 'Professor Foster');


INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date)
VALUES
    (1, 1, 101, '2023-01-15'),
    (2, 1, 102, '2023-02-20'),
    (3, 2, 101, '2023-01-15'),
    (4, 3, 103, '2023-03-05'),
    (5, 4, 104, '2023-02-10'),
    (6, 5, 105, '2023-03-15'),
    (7, 6, 106, '2023-01-22'),
    (8, 7, 107, '2023-04-05'),
    (9, 8, 108, '2023-02-28'),
    (10, 10, 109, '2023-01-10'),
    (11, 10, 110, '2023-03-18'),
    (12, 11, 112, '2023-02-08'),
    (13, 12, 112, '2023-03-02'),
    (14, 13, 113, '2023-04-12'),
    (15, 14, 114, '2023-01-29'),
    (16, 15, 115, '2023-03-21');


select*
from Students

select*
from Courses

select*
from Enrollments

--Q1
create view [stulist]
as
select s.first_name,s.last_name,s.date_of_birth
from Students s

select *
from stulist

--Q2
select top 5 s.first_name,s.last_name,s.student_id
from Students s
order by s.student_id DESC

--Q3
alter view [stulist]
as
select *,YEAR(GETDATE())-year(date_of_birth) as age
from Students s
select* from stulist

--Q4
create view [courseenroll]
as
select e.course_id,count(*) as Enrollid
from Enrollments e
group by e.course_id

select * from courseenroll

--Q5
select e.course_id,e.Enrollid
from courseenroll e
where Enrollid=(select(max(Enrollid)) from courseenroll)


--Q7
select top 1 cn.course_id,s.first_name,s.last_name
from courseenroll cn
join Enrollments E on cn.course_id=e.course_id
join Students s on e.student_id=s.student_id
order by cn.Enrollid desc

--Q8
drop view [stulist]
drop view [courseenroll]

--Q9
create view [stcourse]
as
select concat(first_name,' ',last_name) as fn,count(*) as c_c
from Students s
left join Enrollments E on s.student_id=e.student_id
group by concat(first_name,' ',last_name)

select* from stcourse

--Q10
select top 1 * from Stcourse
order by c_c desc;


--Q11
create view [Inscourse]
as
select instructor, count(course_id) as course_c
from Courses
group by instructor;

select* from Inscourse

--Q12
select top 1 * from Inscourse
order by course_c desc;

--Q15
create view [stc_info]
as
select concat(S.first_name, ' ', S.last_name) as fn, c.course_name, c.instructor
from Students S
join Enrollments E on S.student_id = E.student_id
join Courses c on E.course_id = c.course_id;

select* from stc_info


--------------------------------------------------------------------------------------------------------------------