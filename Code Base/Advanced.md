### 1. A view to summarise student performance per course
```TSQL
CREATE VIEW student_course_summary AS
SELECT 
    st.first_name,
    cs.course_name AS course,
    er.grade
FROM 
    students st
INNER JOIN 
    enrollments er 
    ON st.student_id = er.student_id
INNER JOIN 
    courses cs ON 
    er.course_id = cs.course_id;
```

#### Test the view
```TSQL
SELECT * FROM student_course_summary
ORDER BY grade desc;
```

### 2. Add an INDEX on Enrollments.student_id
```TSQL
CREATE INDEX enrollments_student_id
ON enrollments(student_id);
```

### 3. Adding A TRIGGER
#### a) Creating a table to store logs
```TSQL
CREATE TABLE enrollment_log (
    log_id SERIAL PRIMARY KEY,
    student_id VARCHAR(25),
    course_id VARCHAR(25),
    enrollment_date DATE,
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### b) Creating trigger function
```TSQL
CREATE OR REPLACE FUNCTION log_new_enrollment()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO enrollment_log (student_id, course_id, enrollment_date)
    VALUES (NEW.student_id, NEW.course_id, NEW.enrollment_date);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
```

#### c)Creating trigger
```TSQL
CREATE TRIGGER trigger_log_enrollment
AFTER INSERT ON enrollments
FOR EACH ROW
EXECUTE FUNCTION log_new_enrollment();
```


### 4. Test trigger
#### a) Add data to enrollments table
```TSQL
INSERT INTO enrollments (enrollment_id, student_id, course_id, enrollment_date, grade)
VALUES ('ENR5001', 'KIH22', 'DS303', '2025-05-04', 'A');
```

#### b) Run enrollment log table
```TSQL
SELECT *
FROM enrollment_log;
```

Here is a link to a Youtube [Tutorial](https://youtu.be/hTRr-tVVfZ4?si=j-WcQEzsNh05VztS) on creating triggers
