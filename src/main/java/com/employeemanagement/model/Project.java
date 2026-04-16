package com.employeemanagement.model;

public class Project {
    private int projectId;
    private String projectName;
    private String assignedManager;
    private String status;
    private double revenueCollection;

    public Project(int projectId, String projectName, String assignedManager, String status, double revenueCollection) {
        this.projectId = projectId;
        this.projectName = projectName;
        this.assignedManager = assignedManager;
        this.status = status;
        this.revenueCollection = revenueCollection;
    }

    public int getProjectId() { return projectId; }
    public void setProjectId(int projectId) { this.projectId = projectId; }

    public String getProjectName() { return projectName; }
    public void setProjectName(String projectName) { this.projectName = projectName; }

    public String getAssignedManager() { return assignedManager; }
    public void setAssignedManager(String assignedManager) { this.assignedManager = assignedManager; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public double getRevenueCollection() { return revenueCollection; }
    public void setRevenueCollection(double revenueCollection) { this.revenueCollection = revenueCollection; }
}
