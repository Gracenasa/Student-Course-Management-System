CREATE TABLE Students (
    student_id VARCHAR(25) PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(255) UNIQUE,
    date_of_birth DATE
);

CREATE TABLE Instructors (
    instructor_id VARCHAR(25) PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(255) UNIQUE
);

CREATE TABLE Courses (
    course_id VARCHAR(25) PRIMARY KEY,
    course_name VARCHAR(255),
    course_description TEXT,
    instructor_id VARCHAR(25),
    FOREIGN KEY (instructor_id) REFERENCES Instructors(instructor_id)
);

CREATE TABLE Enrollments (
    enrollment_id VARCHAR(25) PRIMARY KEY,
    student_id VARCHAR(25),
    course_id VARCHAR(25),
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);



