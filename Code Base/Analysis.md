### 1. Students who enrolled in at least one course (Students present in enrollments table)
```TSQL
  SELECT
    DISTINCT(st.student_id) as ID,
    first_name,
    last_name
  FROM 
    students AS st 
    INNER JOIN enrollments as er 
    ON st.student_id = er.student_id;
```
![image](https://github.com/user-attachments/assets/a4a20d37-dcc9-471d-a510-8d40e44ed45c)

### 2. Students enrolled in more than two courses
```TSQL
SELECT
  st.student_id as ID,
	first_name as Name,
	COUNT(er.enrollment_id) as courses
FROM 
	students AS st 
	INNER JOIN enrollments as er 
	ON st.student_id = er.student_id
GROUP BY 
	st.student_id, first_name
HAVING 
	COUNT(er.enrollment_id) > 2;
```
| ID     | Name           | Courses |
|--------|----------------|---------|
| MWP09  | Ráo            | 5       |
| ERS08  | Méryl          | 4       |
| INB44  | Ráo            | 4       |
| MSL45  | Céline         | 4       |
| NVS43  | Bérangère      | 4       |
| YML47  | Maëlys         | 4       |
| IXN38  | Gösta          | 5       |
| XSK07  | Lorène         | 4       |
| YYA57  | Pò             | 4       |
| VBL05  | Personnalisée  | 6       |

### 3. Students who haven’t enrolled in any course (Students absent in enrollments table)
```TSQL
SELECT 
	DISTINCT(st.student_id) as ID,
	first_name,
	last_name
FROM 
	students AS st 
	LEFT JOIN enrollments as er 
	ON st.student_id = er.student_id
WHERE er.student_id IS NULL;
```
![image](https://github.com/user-attachments/assets/e38d5f30-4530-470e-81cb-f0b433f3178b)

### 4. Students with their average grade across all courses
```TSQL
SELECT 
    st.student_id,
    course_id,
    st.first_name,
    ROUND(AVG(
        CASE grade
            WHEN 'A' THEN 4
            WHEN 'B' THEN 3
            WHEN 'C' THEN 2.5
            WHEN 'D' THEN 2
            WHEN 'E' THEN 1
            WHEN 'F' THEN 0
        END
    ), 2) AS average_grade
FROM 
    students st
JOIN 
    enrollments er ON st.student_id = er.student_id
GROUP BY 
    st.student_id, st.first_name, course_id
ORDER BY
	student_id DESC, average_grade DESC;
```
![image](https://github.com/user-attachments/assets/a17008c6-6ac2-41c1-a339-1fe8e6a9d074)

### 5. Average Grade per Course and total enrolled students (A-4, B-3.5, C-3, D-2, E-1, F-0)
```TSQL
SELECT 
	course_name,
	cs.course_id,
    ROUND( 
    	AVG(
        	CASE 
            	WHEN grade = 'A' THEN 4      
            	WHEN grade = 'B' THEN 3.5
            	WHEN grade = 'C' THEN 3
            	WHEN grade = 'D' THEN 2
            	WHEN grade = 'E' THEN 1
            	WHEN grade = 'F' THEN 0
        	END
    	  )::NUMERIC,1
    	) AS average_marks,
    COUNT(er.student_id) AS popularity
FROM
	courses as cs
	INNER JOIN enrollments AS er 
	ON cs.course_id = er.course_id
GROUP BY
	cs.course_name, cs.course_id
ORDER BY 
	average_marks DESC, popularity DESC;
```
![image](https://github.com/user-attachments/assets/258f3adf-c95d-49b0-a449-83227604b3b0)

### 6. Students enrolled in a course taught by Meyer Bliss
```TSQL
SELECT 
    st.student_id,
    st.first_name,
    st.last_name
FROM 
    students st
INNER JOIN 
    enrollments er ON st.student_id = er.student_id
INNER JOIN 
    courses cs ON er.course_id = cs.course_id
INNER JOIN 
    instructors i ON cs.instructor_id = i.instructor_id
WHERE 
	i.first_name = 'Meyer' AND i.last_name = 'Bliss';
```
![image](https://github.com/user-attachments/assets/9eb7cccd-4722-4f49-a06e-32c3b83d224e)

### 7. Top 3 students by average grade
```TSQL
WITH grade_marks AS (
  SELECT 
      st.student_id,
      first_name,
      last_name,
      CASE er.grade
          WHEN 'A' THEN 4
          WHEN 'B' THEN 3
          WHEN 'C' THEN 2.5
          WHEN 'D' THEN 2
          WHEN 'E' THEN 1
          WHEN 'F' THEN 0
          ELSE NULL
      END AS numeric_grade
  FROM 
      students AS st
  JOIN 
      enrollments AS er ON st.student_id = er.student_id
),
ranked_students AS (
  SELECT 
      student_id,
      first_name,
      last_name,
      ROUND(AVG(numeric_grade), 3) AS average_grade,
      RANK() OVER (ORDER BY AVG(numeric_grade) DESC) AS rank
  FROM 
      grade_marks
  GROUP BY 
      student_id, first_name, last_name
)
SELECT * 
FROM ranked_students
WHERE rank <= 3
LIMIT 3;
```
![image](https://github.com/user-attachments/assets/c5f7f8ba-eadb-42c4-ba0e-2ff7025c4604)

### 8. Students failing (grade = ‘F’) in more than one course
```TSQL
SELECT 
    st.student_id,
    first_name,
    last_name,
    COUNT(*) AS failed_courses
FROM 
    students AS st
INNER JOIN 
    enrollments AS er 
    ON st.student_id = er.student_id
WHERE 
    er.grade = 'F'
GROUP BY 
    st.student_id, st.first_name
HAVING 
    COUNT(*) > 1;
```
![image](https://github.com/user-attachments/assets/23beb5db-bcac-4d45-9c8e-d40f09538b27)
