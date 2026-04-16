package com.employeemanagement.model;

public class Review {
    private String reviewerName;
    private int rating;
    private String feedbackText;
    private String date;

    public Review(String reviewerName, int rating, String feedbackText, String date) {
        this.reviewerName = reviewerName;
        this.rating = rating;
        this.feedbackText = feedbackText;
        this.date = date;
    }

    public String getReviewerName() { return reviewerName; }
    public void setReviewerName(String reviewerName) { this.reviewerName = reviewerName; }

    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }

    public String getFeedbackText() { return feedbackText; }
    public void setFeedbackText(String feedbackText) { this.feedbackText = feedbackText; }

    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }
}
