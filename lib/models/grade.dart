class Grade {
  int gradeId;
  String gradeName;

  Grade({this.gradeId, this.gradeName});

  Map<String, dynamic> toMap() {
    return ({
      "gradeId": gradeId,
      "gradeName": gradeName,
    });
  }
}
