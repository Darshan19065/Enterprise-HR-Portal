package com.employeemanagement.servlet;

import com.employeemanagement.data.EmployeeStore;
import com.employeemanagement.model.Employee;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/export")
public class CsvExportServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=\"hr_active_roster.csv\"");
        
        PrintWriter writer = response.getWriter();
        
        // Write CSV Header
        writer.println("ID,Name,Email,Role,Department,Join Date,Weekly Hours,Days Worked,Daily Average");
        
        List<Employee> employees = EmployeeStore.getAllEmployees();
        
        for (Employee emp : employees) {
            writer.printf("%d,\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",%d,%d,%.1f\n",
                    emp.getId(),
                    emp.getName(),
                    emp.getEmail(),
                    emp.getRole(),
                    emp.getDepartment(),
                    emp.getJoiningDate(),
                    emp.getWeeklyHours(),
                    emp.getDaysWorkedThisWeek(),
                    emp.getDailyAverage()
            );
        }
    }
}
