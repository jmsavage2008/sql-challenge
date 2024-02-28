CREATE TABLE Departments (
    dept_no VARCHAR(5)   NOT NULL,
    dept_name VARCHAR(30)   NOT NULL,
    PRIMARY KEY (dept_no)
);

Create Table Titles (
	title_id VARCHAR(5) NOT NULL,
	title VARCHAR(30),
	Primary Key (title_id)
);

Create Table Employees (
	emp_no INT not null,
	emp_title_id VARCHAR(5),
	birth_date DATE,
	first_name VARCHAR(30),
	last_name VARCHAR(30),
	sex VARCHAR(1),
	hire_date DATE,
	Primary Key (emp_no),
	Foreign key (emp_title_id) references Titles (title_id)
);

Create table DepartmentEmployees (
	emp_no INT Not null,
	dept_no VARCHAR(5),
	Primary Key (emp_no, dept_no),
	Foreign Key (dept_no) references Departments (dept_no),
	Foreign Key (emp_no) references Employees (emp_no)
);

Create table DepartmentManager (
	dept_no VARCHAR(5),
	emp_no INT Not null,
	Primary Key (emp_no, dept_no),
	Foreign Key (dept_no) references Departments (dept_no),
	Foreign Key (emp_no) references Employees (emp_no)
);


Create TABLE Salaries (
	emp_no INT not null,
	salary INT,
	Primary Key (emp_no),
	Foreign Key (emp_no) references Employees (emp_no)
);

--List the employee number, last name, first name, sex, and salary of each employee

Select e.emp_no, e.last_name, e.first_name, e.sex, s.salary
from Employees as e
inner join Salaries as s on
e.emp_no=s.emp_no;

--List the first name, last name, and hire date for the employees who were hired in 1986.
Select first_name, last_name, hire_date
From employees
Where hire_date >='1986-01-01' and hire_date <'1987-01-01';

--List the manager of each department along with their department number, department name, employee number, last name, and first name.
Select d.dept_no, d.dept_name, m.emp_no, e.last_name, e.first_name
from departments as d
join departmentmanager as m on
d.dept_no = m.dept_no
join employees as e on
m.emp_no = e.emp_no


--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
Select d.dept_no, de.emp_no, e.last_name, e.first_name, d.dept_name
from departments as d
inner join departmentemployees as de on
d.dept_no = de.dept_no
inner join employees as e on
de.emp_no = e.emp_no

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
Select first_name, last_name, sex
from employees
where first_name = 'Hercules' and last_name like 'B%'

--List each employee in the Sales department, including their employee number, last name, and first name.

Select d.dept_name, de.emp_no, e.last_name, e.first_name
from departments d
join departmentemployees de
on d.dept_no = de.dept_no
join employees e
on de.emp_no = e.emp_no
where d.dept_name = 'Sales';

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
Select de.emp_no, e.last_name, e.first_name, d.dept_name
from departments d
join departmentemployees de
on d.dept_no = de.dept_no
join employees e
on de.emp_no = e.emp_no
where d.dept_name = 'Sales' or d.dept_name = 'Development';

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
Select last_name, Count(last_name) as "Last Name Frequency"
from employees
group by last_name
Order by "Last Name Frequency" Desc;


