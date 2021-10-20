import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_task_planner_app/models/subject.dart';
import 'package:flutter_task_planner_app/theme/colors/light_colors.dart';
import 'package:flutter_task_planner_app/utils/db/datebase.dart';
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
  String fullName = "";
  String address = "";
  String imageLink = "";
  String phoneNumber = "";
  TextEditingController myController = TextEditingController();
  int gradeNow = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    var _scaffoldKey = new GlobalKey<ScaffoldState>();
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
    Future.delayed(const Duration(),
        () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
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
                      TextField(
                        controller: myController,
                        onChanged: (text) {},
                      ),
                      Text("Địa chỉ:"),
                      Text("Link ảnh:"),
                      Text("Số điện thoại:"),
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
                                  listGrade = gradeData.data;
                                  // listGradeItems = listGrade[0].toString();
                                  return DropdownButton(
                                    hint: Text("Chọn lớp"),
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    isDense: true,
                                    onChanged: (newValue) {
                                      setState(() {
                                        listGradeItems = newValue;
                                      });
                                      gradeNow = int.parse(newValue);
                                      print(newValue);
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
                                  listSubjectItems = listSubject[0].toString();
                                  return DropdownButton(
                                    hint: Text("Chọn môn học"),
                                    value: listSubjectItems,
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    items: listSubject.map((String items) {
                                      return DropdownMenuItem(
                                          value: items, child: Text(items));
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        listSubjectItems = newValue;
                                        print(newValue);
                                      });
                                    },
                                  );
                                } else if (!subjectData.hasData) {
                                  listSubject = ["-"];
                                  listSubjectItems = listSubject[0].toString();
                                  return DropdownButton(
                                    hint: Text("Chọn môn học"),
                                    value: listSubjectItems,
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    items: listSubject.map((String items) {
                                      return DropdownMenuItem(
                                          value: items, child: Text(items));
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        listSubjectItems = newValue;
                                        print(newValue);
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
                            onPressed: () {
                              print(listGradeItems);
                              print(listSubjectItems);
                              print(fullName);
                              print(address);
                              print(imageLink);
                              print(phoneNumber);
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
}
