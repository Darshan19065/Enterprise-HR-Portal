package com.employeemanagement.model;

public class Employee {
    private int id;
    private String name;
    private String email;
    private String role;
    private String department;
    private int weeklyHours;
    private int daysWorkedThisWeek;
    private String joiningDate;
    private String endDate;

    public Employee(int id, String name, String email, String role, String department, int weeklyHours, int daysWorkedThisWeek, String joiningDate, String endDate) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.role = role;
        this.department = department;
        this.weeklyHours = weeklyHours;
        this.daysWorkedThisWeek = daysWorkedThisWeek;
        this.joiningDate = joiningDate;
        this.endDate = endDate;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }

    public int getWeeklyHours() { return weeklyHours; }
    public void setWeeklyHours(int weeklyHours) { this.weeklyHours = weeklyHours; }
    
    public int getDaysWorkedThisWeek() { return daysWorkedThisWeek; }
    public void setDaysWorkedThisWeek(int daysWorkedThisWeek) { this.daysWorkedThisWeek = daysWorkedThisWeek; }

    public String getJoiningDate() { return joiningDate; }
    public void setJoiningDate(String joiningDate) { this.joiningDate = joiningDate; }

    public String getEndDate() { return endDate; }
    public void setEndDate(String endDate) { this.endDate = endDate; }
    
    // Dynamic calculated average
    public double getDailyAverage() {
        if (daysWorkedThisWeek == 0) return 0.0;
        return (double) weeklyHours / daysWorkedThisWeek;
    }
}
