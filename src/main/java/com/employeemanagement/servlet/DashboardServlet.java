package com.employeemanagement.servlet;

import com.employeemanagement.data.EmployeeStore;
import com.employeemanagement.data.ProjectStore;
import com.employeemanagement.data.ReviewStore;
import com.employeemanagement.model.Employee;
import com.employeemanagement.model.Project;
import com.employeemanagement.model.Review;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Employee> employees = EmployeeStore.getAllEmployees();
        List<Review> reviews = ReviewStore.getAllReviews();
        List<Project> projects = ProjectStore.getAllProjects();
        
        // Compute basic stats summing WEEKLY hours
        int totalHours = employees.stream().mapToInt(Employee::getWeeklyHours).sum();
        int activeCount = (int) employees.stream().filter(e -> "Active".equalsIgnoreCase(e.getEndDate())).count();
        
        // Compute financials
        double totalRevenue = projects.stream().mapToDouble(Project::getRevenueCollection).sum();
        NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(new Locale("en", "US"));
        String formattedRevenue = currencyFormatter.format(totalRevenue);

        request.setAttribute("employees", employees);
        request.setAttribute("reviews", reviews);
        request.setAttribute("projects", projects);
        
        request.setAttribute("totalHours", totalHours);
        request.setAttribute("activeCount", activeCount);
        request.setAttribute("totalRevenue", formattedRevenue);
        
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}
