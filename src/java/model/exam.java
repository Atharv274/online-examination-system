package model;

public class exam {

    private int exam_id;
    private String title;
    private int duration;
    private int total_marks;

    public int getExam_id() { return exam_id; }
    public void setExam_id(int exam_id) { this.exam_id = exam_id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public int getDuration() { return duration; }
    public void setDuration(int duration) { this.duration = duration; }

    public int getTotal_marks() { return total_marks; }
    public void setTotal_marks(int total_marks) { this.total_marks = total_marks; }
}
