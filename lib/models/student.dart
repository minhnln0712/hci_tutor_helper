class Student {
  int studentId;
  String fullName;
  String address;
  String imageLink;
  String phone;
  int subjectId;
  int gradeId;
  String createDate;
  bool status;

  Student(
      {this.studentId,
      this.fullName,
      this.address,
      this.imageLink,
      this.phone,
      this.subjectId,
      this.gradeId,
      this.createDate,
      this.status});

  Map<String, dynamic> toMap() {
    return ({
      "studentId": studentId,
      "fullName": fullName,
      "address": address,
      "imageLink": imageLink,
      "phone": phone,
      "subjectId": subjectId,
      "gradeId": gradeId,
      "createDate": createDate,
      "status": status,
    });
  }
}
