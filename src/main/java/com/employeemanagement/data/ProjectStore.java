package com.employeemanagement.data;

import com.employeemanagement.model.Project;

import java.util.ArrayList;
import java.util.List;

public class ProjectStore {
    private static final List<Project> projects = new ArrayList<>();
    private static int nextProjectId = 107;

    static {
        projects.add(new Project(101, "Titanium Infrastructure Upgrade", "Diana Prince", "Active", 1250000.00));
        projects.add(new Project(102, "Global HR Cloud Portal", "Bob Jones", "Planning", 85000.00));
        projects.add(new Project(103, "E-Commerce Re-Architecture", "Alice Smith", "Completed", 3400000.00));
        projects.add(new Project(104, "Cybersecurity Audit Q3", "Diana Prince", "Active", 450000.00));
        projects.add(new Project(105, "Marketing Funnel Dashboard", "Charlie Davis", "Active", 210000.00));
        projects.add(new Project(106, "European Market Expansion", "Bob Jones", "Planning", 5600000.00));
    }

    public static List<Project> getAllProjects() {
        return projects;
    }

    public static void updateProjectStatus(int projectId, String newStatus) {
        for (Project proj : projects) {
            if (proj.getProjectId() == projectId) {
                proj.setStatus(newStatus);
                break;
            }
        }
    }

    public static void addProject(String name, String manager, double cost) {
        projects.add(new Project(nextProjectId++, name, manager, "Planning", cost));
    }
}
