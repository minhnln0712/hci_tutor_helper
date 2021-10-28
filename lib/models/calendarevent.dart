class CalendarEvent {
  int eventId;
  String title;
  String description;
  String createDate;
  String startTime;
  String endTime;
  int studentId;

  CalendarEvent(
      {this.eventId,
      this.title,
      this.description,
      this.createDate,
      this.startTime,
      this.endTime,
      this.studentId});

  Map<String, dynamic> toMap() {
    return ({
      "eventId": eventId,
      "title": title,
      "description": description,
      "createDate": createDate,
      "startTime": startTime,
      "endTime": endTime,
      "studentId": studentId
    });
  }
}
