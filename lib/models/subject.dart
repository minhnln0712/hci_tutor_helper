class Subject {
  int subjectId;
  String subjectName;
  int gradeId;

  Subject({this.subjectId, this.subjectName, this.gradeId});

  Map<String, dynamic> toMap() {
    return ({
      "subjectId": subjectId,
      "subjectName": subjectName,
      "gradeId": gradeId,
    });
  }
}