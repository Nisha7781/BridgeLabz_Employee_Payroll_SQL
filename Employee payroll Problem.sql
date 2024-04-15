-- Employee Payroll problem

-- UC 1: Ability to create a payroll service database

create database payroll_service;
show databases;
use payroll_service;

-- UC 2: Ability to create a employee payroll table in the payroll service database to manage employee payrolls 

create table employee_payroll (
Emp_ID int not null auto_increment, 
Emp_Name varchar(30) not null, 
Salary double not null, 
Start_date date not null,
primary key (Emp_ID));
describe employee_payroll;

-- UC 3: Ability to create employee payroll data in the payroll service database as part of CRUD Operation 

insert into  employee_payroll (Emp_Name, Salary, Start_date) values ('Nisha', 50000, '2024-01-01'), 
('Nikita', 40000, '2024-01-15'), ('Sanika', 30000, '2024-03-01'), ('Venkatesh', 75000, '2024-01-01');
  
-- UC 4: Ability to retrieve all the employee payroll data that is added to payroll service database

select * from employee_payroll;

/* UC 5: Ability to retrieve salary data for a particular employee as well as all employees who have joined in a particular data range from 
the payroll service database */

select salary from employee_payroll where Emp_Name = 'Nisha';
delete from employee_payroll where Emp_Name = 'Nisha';
insert into  employee_payroll (Emp_ID, Emp_Name, Salary, Start_date) values (1, 'Nisha', 60000, '2024-01-01');
select * from employee_payroll;
select * from employee_payroll where Start_date between cast('2024-02-01' as date) and date (now());

-- truncate table employee_payroll;

-- UC6: Ability to add Gender to Employee Payroll Table and Update the Rows to reflect the correct Employee Gender

alter table employee_payroll 
add Gender char(1) after Emp_Name;
select * from employee_payroll;

update employee_payroll set Gender = 'F' where Emp_Name = 'Nisha' or Emp_Name = 'Nikita' or Emp_Name = 'Sanika'; 
update employee_payroll set Gender = 'M' where Emp_Name = 'Venkatesh';

-- UC 7: Ability to find sum, average, min, max and number of male and female employees

insert into employee_payroll (Emp_Name, Gender, Salary, Start_date) values ('Vinayak', 'M', 56000, '2024-02-10');

select sum(Salary) from employee_payroll where Gender = 'F' Group by Gender;
select avg(Salary) from employee_payroll where Gender = 'F' Group by Gender;
select min(Salary) from employee_payroll where Gender = 'M' Group by Gender;
select max(Salary) from employee_payroll where Gender = 'F' Group by Gender;
select count(Salary) from employee_payroll where Gender = 'M' Group by Gender;

-- UC 8: Ability to extend employee_payroll data to store employee information like employee phone, address and department

select * from employee_payroll;

alter table employee_payroll rename column Salary to BasicPay;
alter table employee_payroll 
add Phone varchar(20) after Gender, 
add Address varchar(30) default 'Mumbai' after Phone, 
add Department varchar(20) not null after Address;

-- UC 9: Ability to extend employee_payroll table to have Basic Pay, Deductions, Taxable Pay, Income Tax, Net Pay

alter table employee_payroll  
add column TaxablePay int, 
add column IncomeTax int,
add column Deduction int,
add column NetPay int;

select * from employee_payroll;

-- UC 10: 

update employee_payroll
set Phone = '9876781234', Department = 'HR', BasicPay = 35000, TaxablePay = 1000, IncomeTax = 500, Deduction = 1000, NetPay = 32500
where Emp_Name = 'Nisha';

update employee_payroll
set Phone = '9576561254', Department = 'Sales', BasicPay = 25000, TaxablePay = 800, IncomeTax = 400, Deduction = 800, NetPay =23000
where Emp_Name = 'Nikita';

update employee_payroll
set Phone = '7372281839', Department = 'Marketing', BasicPay = 25000, TaxablePay = 900, IncomeTax = 300, Deduction = 800, NetPay =23000
where Emp_Name = 'Sanika';

update employee_payroll
set Phone = '8883929388', Department = 'IT', BasicPay = 45000, TaxablePay = 1200, IncomeTax = 800, Deduction = 500, NetPay = 425000
where Emp_Name = 'Venkatesh';

update employee_payroll
set Phone = '7677828237', Department = 'Sales', BasicPay = 28000, TaxablePay = 1000, IncomeTax = 300, Deduction = 200, NetPay =26500
where Emp_Name = 'Vinayak';

INSERT INTO employee_payroll (Emp_Name, Gender, Start_date, Phone, Department, BasicPay, TaxablePay, IncomeTax, Deduction, NetPay) 
VALUES ("Nikita", 'F', '2024-01-15', '9576561254', "Marketing", 30000, 1500, 500, 500, 27500);

select * from employee_payroll;

-- UC 11: For Many to Many relationship, create new Table called Employee Department having Employee Id and Department ID and redo the UC 7

create table Department (
    Dept_ID int not null primary key auto_increment,
    Dept_Name varchar(50));

create table Employee_Dept (
    Emp_ID int , Dept_ID int,
    foreign key (Emp_ID) references employee_payroll(Emp_ID),
    foreign key (Dept_ID) references Department(Dept_ID));

insert into Department (Dept_Name) values('HR'), ('Sales'), ('Marketing'), ('IT');

insert into Employee_Dept (Emp_ID, Dept_ID) values
    (1, 1), (2, 2), (3, 3), (4, 4),(5, 2), (6,3);
    
select * from Employee_Dept;
select * from Department;
select * from employee_payroll;


select sum(BasicPay) from employee_payroll where Gender = 'F';
select avg(BasicPay) from employee_payroll where Gender = 'F';
select min(BasicPay) from employee_payroll where Gender = 'M';
select max(BasicPay) from employee_payroll where Gender = 'F';
select count(BasicPay) from employee_payroll where Gender = 'M';

select Emp_Name, BasicPay from employee_payroll where Emp_Name = 'Nikita';

-- UC12: Ensure all retrieve queries done especially in UC 4, UC 5 and UC 7 are working with new table structure

select ep.* from employee_payroll ep
join Employee_Dept ed on ep.Emp_ID = ed.Emp_ID
where ep.Emp_Name = 'Nikita' or ed.Dept_ID = 1;

select ep. Emp_Name, d. Dept_Name, ep.BasicPay 
from employee_payroll ep 
join Employee_Dept ed on ep.Emp_ID = ed.Emp_ID
join Department d on ed.Dept_ID = d.Dept_ID
where d.Dept_Name = 'Sales';

select * from employee_payroll where Start_date between cast('2024-02-01' as date) and date (now());

select d.Dept_Name, COUNT(*) as Empolyee_Count 
from employee_payroll ep 
join Employee_Dept ed on ep.Emp_ID = ed.Emp_ID
join Department d on ed.Dept_ID = d.Dept_ID
GROUP BY d.Dept_Name;
