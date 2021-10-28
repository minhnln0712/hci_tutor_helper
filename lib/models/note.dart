class Note {
  int noteId;
  String title;
  String body;
  String createDate;
  int studentId;

  Note({this.noteId, this.title, this.body, this.createDate, this.studentId});

  Map<String, dynamic> toMap() {
    return ({
      "noteId": noteId,
      "title": title,
      "body": body,
      "createDate": createDate,
      "studentId": studentId
    });
  }
}
