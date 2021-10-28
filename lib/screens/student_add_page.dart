import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_task_planner_app/models/student.dart';
import 'package:flutter_task_planner_app/screens/home_page.dart';
import 'package:flutter_task_planner_app/theme/colors/light_colors.dart';
import 'package:flutter_task_planner_app/utils/db/database.dart';
import 'package:flutter_task_planner_app/widgets/drawer.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
  var imageDisplay = Image.asset("assets/images/avatar.png");

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

  chooseimage(File file) {
    setState(() {
      imageDisplay = Image.file(file);
    });
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
                  subheading('Student Information'),
                  SizedBox(height: 5.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 200,
                            child: InkWell(
                              onTap: () async {
                                final ImagePicker _picker = ImagePicker();
                                final XFile image = await _picker.pickImage(
                                    source: ImageSource.gallery);
                                if (image != null) {
                                  chooseimage(File(image.path));
                                  imageLink = image.path.toString();
                                }
                              }, // Handle your callback.
                              splashColor: Colors.brown.withOpacity(0.5),
                              child: imageDisplay,
                            ),
                          ),
                        ],
                      ),
                      Text("Name:"),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          fullName = value;
                        },
                      ),
                      Text("Address:"),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          address = value;
                        },
                      ),
                      Text("Phone Number:"),
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
                          Text("Grade:"),
                          Text("Subject:"),
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
                        height: 100,
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
                            child: Text("Create"),
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
      title: Text("Create a student"),
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
      backgroundColor: LightColors.kDarkYellow,
    );
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("Confirm"),
      onPressed: () {
        Get.offAll(() => HomePage());
      },
    );
    AlertDialog secondAlert = AlertDialog(
      title: const Text("Attention!"),
      content: const Text("The student have been created successfully!"),
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
            subjectId: subjectId,
            status: true);
        await DatabaseProvider.db.addNewStudent(newStudent);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return secondAlert;
          },
        );
      },
    );
    AlertDialog firstAlert = AlertDialog(
      title: const Text("Attention!"),
      content: const Text("Are you sure you want create this student?"),
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
