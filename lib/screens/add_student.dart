import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_task_planner_app/models/student.dart';
import 'package:flutter_task_planner_app/screens/home_page.dart';
import 'package:flutter_task_planner_app/theme/colors/light_colors.dart';
import 'package:flutter_task_planner_app/utils/db/database.dart';
import 'package:flutter_task_planner_app/widgets/drawer.dart';
import 'package:get/get.dart';

class AddStudent extends StatefulWidget {
  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  var data = Get.arguments;
  List<String> listGrade = [];
  List<String> listSubject = [];
  String listGradeItems = "";
  String listSubjectItems = "";
  int gradeId = 0;
  int subjectId = 0;
  String fullName = "";
  String address = "";
  String imageLink = "";
  String phoneNumber = "";
  int gradeNow = 1;
  bool firstTime = true;
  bool gradeChanged = false;

  _getGrade() async {
    final students = await DatabaseProvider.db.getGrades();
    return students;
  }

  _getSubject(int gradeId) async {
    final students = await DatabaseProvider.db.getSubjects(gradeId);
    return students;
  }

  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
          color: LightColors.kDarkBlue,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }

  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: new AppDrawer(),
      backgroundColor: LightColors.kLightYellow,
      body: SafeArea(
        child: Column(
          children: <Widget>[_navigator(), _body()],
        ),
      ),
    );
  }

  Expanded _body() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                children: <Widget>[
                  subheading('Thông tin học sinh'),
                  SizedBox(height: 5.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Tên học sinh:"),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          fullName = value;
                        },
                      ),
                      Text("Địa chỉ:"),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          address = value;
                        },
                      ),
                      Text("Link ảnh:"),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          imageLink = value;
                        },
                      ),
                      Text("Số điện thoại:"),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        onChanged: (value) {
                          phoneNumber = value;
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Khối Lớp:"),
                          Text("Môn Học:"),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FutureBuilder(
                              future: _getGrade(),
                              builder: (context, gradeData) {
                                if (gradeData.hasData) {
                                  if (firstTime) {
                                    listGrade = gradeData.data;
                                    listGradeItems = listGrade[0].toString();
                                    gradeChanged = true;
                                    gradeNow = 1;
                                  }
                                  return DropdownButton(
                                    value: listGradeItems,
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    isDense: true,
                                    onChanged: (newValue) {
                                      setState(() {
                                        listGradeItems = newValue;
                                        gradeChanged = true;
                                      });
                                      var listGradeItemsStr =
                                          newValue.split(" ");
                                      gradeNow =
                                          int.parse(listGradeItemsStr[1]);
                                    },
                                    items: listGrade.map((String items) {
                                      return DropdownMenuItem(
                                          value: items, child: Text(items));
                                    }).toList(),
                                  );
                                } else {
                                  return Visibility(
                                    child: Text(""),
                                    visible: false,
                                  );
                                }
                              }),
                          FutureBuilder(
                              future: _getSubject(gradeNow),
                              builder: (context, subjectData) {
                                if (subjectData.hasData) {
                                  listSubject = subjectData.data;
                                  if (gradeChanged) {
                                    listSubjectItems =
                                        listSubject[0].toString();
                                  }
                                  firstTime = false;
                                  return DropdownButton(
                                    value: listSubjectItems,
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    items: listSubject.map((String items) {
                                      return DropdownMenuItem(
                                          value: items, child: Text(items));
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        listSubjectItems = newValue;
                                        gradeChanged = false;
                                      });
                                    },
                                  );
                                } else {
                                  return Visibility(
                                    child: Text(""),
                                    visible: false,
                                  );
                                }
                              }),
                        ],
                      ),
                      SizedBox(
                        height: 200,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () async {
                              gradeId = await DatabaseProvider.db
                                  .getGradeIdbyGradeName(listGradeItems);
                              subjectId = await DatabaseProvider.db
                                  .getSubjectIdbySubjectName(listSubjectItems);
                              showAlertDialog(context);
                            },
                            child: Text("Tạo học sinh"),
                            style: TextButton.styleFrom(
                                shape: StadiumBorder(),
                                backgroundColor: Colors.cyan,
                                primary: Colors.white,
                                textStyle: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w400)),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _navigator() {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_sharp,
          color: Colors.white,
        ),
        onPressed: () {
          Get.back();
        },
      ),
      actions: [],
    );
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Get.offAll(() => HomePage());
      },
    );
    AlertDialog secondAlert = AlertDialog(
      title: const Text("Class Student!"),
      content: const Text("The Student has been Created!!!"),
      actions: [
        okButton,
      ],
    );
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Get.back();
      },
    );
    Widget createButton = TextButton(
      child: const Text("Create"),
      onPressed: () async {
        var newStudent = Student(
            fullName: fullName,
            address: address,
            imageLink: imageLink,
            createDate: DateTime.now().toString(),
            gradeId: gradeId,
            phone: phoneNumber,
            subjectId: subjectId);
        await DatabaseProvider.db.addNewStudent(newStudent);
        // print(gradeId);
        // print(subjectId);
        // print(fullName);
        // print(address);
        // print(imageLink);
        // print(phoneNumber);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return secondAlert;
          },
        );
      },
    );
    AlertDialog firstAlert = AlertDialog(
      title: const Text("Create student!"),
      content: const Text("Are you sure you want to Create this student?"),
      actions: [
        cancelButton,
        createButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return firstAlert;
      },
    );
  }
}
