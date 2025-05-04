# 🎓 Student Course Management System
Creating a student course management system for an edtech company

# 🚀 Project Overview
In this SQL project, I simulated a real-world EdTech application. As a newly hired Junior Database Developer, my mission was to design and implement a relational database that tracks students, courses, enrollments, instructors, and performance metrics.

## The system supports:

1. Student-course enrollments

2. Grade tracking and performance analysis

3. Instructor-course relationships

4. Auditing and logging new data via triggers

All logic is built using SQL, with bonus use of CTEs, window functions, views, indexes, and triggers for advanced querying and optimization.

## 🧱 Schema Breakdown

| Table | Description |
|-------|-------------|
| **students** | Holds student details (`student_id`, `first_name`, `last_name`, ...) |
| **courses** | Contains course metadata (`course_id`, `course_name`, `instructor_id`) |
| **instructors** | List of instructors and their assigned course(s) |
| **enrollments** | Maps students to courses with `grade`, `enrollment_date`, and foreign keys to `students` and `courses` |
| **enrollment_log** | Audit table triggered on every new enrollment. Tracks insert time and action details |

---

## 🧠 Key Queries and What They Reveal

| Query | Description |
|-------|-------------|
| **Students Enrolled** | Who's active in the system |
| **More Than 2 Courses** | Highlights students that enjoy using the platform |
| **Zero Enrollments** | Unused accounts |
| **Course Popularity nd average grades** | Academic performance and demand per course |
| **More than 1 fail** | Intervention alerts |
| **Top Students** | Honors list using `RANK()` |
| **Student Summary View** | Reusable view for dashboards |

---

## ⚙️ Instructions to Run

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/student-course-management.git
   cd student-course-management
   ```

2. Open your PostgreSQL interface and run the SQL file:
   ```sql
   \i schema_and_queries.sql
   ```

## 🧠 Challenges Faced & Lessons Learned
- **🔗 JOIN Mastery**  
  `LEFT JOIN`, `INNER JOIN`, a good number of queries made use of joins highlighting the need to master their use.

- **📐 Schema Design Matters**  
  A tiny misstep in keys or naming? Chaos. I generated my data 3 times before getting it right and I largely atrribute it to not having a proper database schema design.

---

## ✅ Future Improvements

- Add user authentication and role-based access.
- Integrate a frontend dashboard (e.g., Streamlit, React).
- Visualize data directly using tools like Metabase or Superset.
- Add support for attendance tracking and exam scheduling.

---
