package com.employeemanagement.data;

import com.employeemanagement.model.Employee;

import java.util.ArrayList;
import java.util.List;
import java.util.Iterator;

public class EmployeeStore {
    private static final List<Employee> employees = new ArrayList<>();
    private static int nextId = 16;

    static {
        employees.add(new Employee(1, "Alice Smith", "alice@company.com", "Senior Analyst", "Project Analysis", 32, 4, "2021-06-15", "Active"));
        employees.add(new Employee(2, "Bob Jones", "bob@company.com", "HR Director", "HR Overview", 15, 2, "2019-11-01", "Active"));
        employees.add(new Employee(3, "Charlie Davis", "charlie@company.com", "Lead UX Designer", "Creative Design", 40, 5, "2022-03-10", "Active"));
        employees.add(new Employee(4, "Diana Prince", "diana@company.com", "VP of Operations", "Corporate Operations", 45, 5, "2018-01-20", "Active"));
        employees.add(new Employee(5, "Evan Wright", "evan@company.com", "Systems Analyst", "Project Analysis", 20, 3, "2023-01-11", "Active"));
        employees.add(new Employee(6, "Fiona Apple", "fiona@company.com", "Product Manager", "Corporate Operations", 24, 3, "2020-05-18", "Active"));
        employees.add(new Employee(7, "George Martin", "george@company.com", "Content Writer", "Creative Design", 0, 0, "2022-09-01", "2024-01-15"));
        employees.add(new Employee(8, "Hannah Montana", "hannah@company.com", "Sales representative", "Client Support", 40, 5, "2023-06-25", "Active"));
        employees.add(new Employee(9, "Ian Somerhalder", "ian@company.com", "Data Analyst", "Project Analysis", 16, 2, "2021-12-05", "Active"));
        employees.add(new Employee(10, "Julia Roberts", "julia@company.com", "Financial Controller", "Financial Review", 40, 5, "2017-08-30", "Active"));
        employees.add(new Employee(11, "Kevin Hart", "kevin@company.com", "Support Specialist", "Client Support", 35, 4, "2022-11-20", "Active"));
        employees.add(new Employee(12, "Liam Neeson", "liam@company.com", "Security Manager", "Corporate Operations", 42, 5, "2019-03-14", "Active"));
        employees.add(new Employee(13, "Meryl Streep", "meryl@company.com", "Legal Counsel", "Financial Review", 10, 1, "2020-07-22", "Active"));
        employees.add(new Employee(14, "Noah Centineo", "noah@company.com", "Junior Analyst", "Project Analysis", 32, 4, "2024-01-05", "Active"));
        employees.add(new Employee(15, "Olivia Wilde", "olivia@company.com", "Marketing Director", "Creative Design", 28, 4, "2021-02-18", "Active"));
    }

    public static List<Employee> getAllEmployees() {
        return employees;
    }

    public static Employee getEmployeeById(int id) {
        for (Employee emp : employees) {
            if (emp.getId() == id) {
                return emp;
            }
        }
        return null;
    }

    public static void updateEmployee(int id, String name, String email, String role, String dept, String joinDate, String endDate) {
        Employee emp = getEmployeeById(id);
        if (emp != null) {
            emp.setName(name);
            emp.setEmail(email);
            emp.setRole(role);
            emp.setDepartment(dept);
            emp.setJoiningDate(joinDate);
            emp.setEndDate(endDate);
        }
    }
    
    public static void addEmployee(String name, String email, String role, String dept, String joinDate, String endDate) {
        employees.add(new Employee(nextId++, name, email, role, dept, 0, 0, joinDate, endDate));
    }

    public static void removeEmployee(int id) {
        Iterator<Employee> iterator = employees.iterator();
        while (iterator.hasNext()) {
            if (iterator.next().getId() == id) {
                iterator.remove();
                break;
            }
        }
    }

    public static void logDailyTime(int id, int hours) {
        Employee emp = getEmployeeById(id);
        if (emp != null) {
            emp.setWeeklyHours(emp.getWeeklyHours() + hours);
            emp.setDaysWorkedThisWeek(emp.getDaysWorkedThisWeek() + 1);
        }
    }

    public static void resetWeek() {
        for (Employee emp : employees) {
            emp.setWeeklyHours(0);
            emp.setDaysWorkedThisWeek(0);
        }
    }
}
