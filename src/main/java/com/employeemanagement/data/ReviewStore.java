package com.employeemanagement.data;

import com.employeemanagement.model.Review;

import java.util.ArrayList;
import java.util.List;

public class ReviewStore {
    private static final List<Review> reviews = new ArrayList<>();

    static {
        reviews.add(new Review("John Doe", 5, "Amazing culture and great benefits! Best place I've worked.", "2024-03-12"));
        reviews.add(new Review("Anonymous", 4, "Good work-life balance, but the coffee machine is always broken.", "2024-04-01"));
    }

    public static List<Review> getAllReviews() {
        return reviews;
    }

    public static void addReview(String name, int rating, String feedback) {
        // Just using today's date placeholder
        String today = java.time.LocalDate.now().toString();
        reviews.add(0, new Review(name, rating, feedback, today));
    }
}
