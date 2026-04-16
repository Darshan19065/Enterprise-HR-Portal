package com.employeemanagement.servlet;

import com.employeemanagement.data.EmployeeStore;
import com.employeemanagement.data.ReviewStore;
import com.employeemanagement.data.ProjectStore;
import com.employeemanagement.model.Employee;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/action")
public class ActionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String actionType = request.getParameter("actionType");
        String activeTab = "1";

        if ("editEmployee".equals(actionType)) {
            activeTab = "3"; 
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String role = request.getParameter("role");
                String dept = request.getParameter("department");
                String join = request.getParameter("joiningDate");
                String end = request.getParameter("endDate");

                EmployeeStore.updateEmployee(id, name, email, role, dept, join, end);
            } catch (Exception e) {}
            
        } else if ("addEmployee".equals(actionType)) {
            activeTab = "3"; 
            try {
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String role = request.getParameter("role");
                String dept = request.getParameter("department");
                String join = request.getParameter("joiningDate");
                String end = request.getParameter("endDate");
                if (end == null || end.trim().isEmpty()) end = "Active";

                EmployeeStore.addEmployee(name, email, role, dept, join, end);
            } catch (Exception e) {}

        } else if ("deleteEmployee".equals(actionType)) {
            activeTab = "3"; 
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                EmployeeStore.removeEmployee(id);
            } catch (Exception e) {}
            
        } else if ("logTime".equals(actionType)) {
            activeTab = "6"; 
            try {
                int id = Integer.parseInt(request.getParameter("employeeId"));
                int hours = Integer.parseInt(request.getParameter("todaysHours"));
                EmployeeStore.logDailyTime(id, hours);
            } catch (Exception e) {}
            
        } else if ("resetWeek".equals(actionType)) {
            activeTab = "6";
            EmployeeStore.resetWeek();
            
        } else if ("addReview".equals(actionType)) {
            activeTab = "5";
            try {
                String name = request.getParameter("name");
                if(name == null || name.trim().isEmpty()) name = "Anonymous";
                int rating = Integer.parseInt(request.getParameter("rating"));
                String feedback = request.getParameter("feedback");

                ReviewStore.addReview(name, rating, feedback);
            } catch (Exception e) {}
            
        } else if ("updateProject".equals(actionType)) {
            activeTab = "2";
            try {
                int projectId = Integer.parseInt(request.getParameter("projectId"));
                String newStatus = request.getParameter("status");
                ProjectStore.updateProjectStatus(projectId, newStatus);
            } catch (Exception e) {}
            
        } else if ("addProject".equals(actionType)) {
            activeTab = "2";
            try {
                String name = request.getParameter("projectName");
                String manager = request.getParameter("managerName");
                double cost = Double.parseDouble(request.getParameter("cost"));
                ProjectStore.addProject(name, manager, cost);
            } catch (Exception e) {}
            
        } else if ("assignPTO".equals(actionType)) {
            activeTab = "8";
            try {
                int id = Integer.parseInt(request.getParameter("employeeId"));
                Employee emp = EmployeeStore.getEmployeeById(id);
                if (emp != null) {
                    emp.setEndDate("On Leave");
                }
            } catch (Exception e) {}
            
        } else if ("returnPTO".equals(actionType)) {
            activeTab = "8";
            try {
                int id = Integer.parseInt(request.getParameter("employeeId"));
                Employee emp = EmployeeStore.getEmployeeById(id);
                if (emp != null) {
                    emp.setEndDate("Active");
                }
            } catch (Exception e) {}
        }

        response.sendRedirect("dashboard?tab=" + activeTab);
    }
}
