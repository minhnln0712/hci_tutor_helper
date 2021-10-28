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

class UpdateStudent extends StatefulWidget {
  @override
  State<UpdateStudent> createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {
  var data_from_view_page = Get.arguments;
  List<String> listGrade = [];
  List<String> listSubject = [];
  String listGradeItems = "";
  String listSubjectItems = "";
  int gradeId = 0;
  int subjectId = 0;
  String fullName = "";
  String address = "";
  String phoneNumber = "";
  int gradeNow = 0;
  bool firstTime = true;
  bool gradeChanged = false;
  String imageLink = "";

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

  Expanded _body() {
    gradeId = data_from_view_page["gradeId"];
    subjectId = data_from_view_page["subjectId"];
    fullName = data_from_view_page["fullName"];
    address = data_from_view_page["address"];
    phoneNumber = data_from_view_page["phone"];
    if (firstTime) {
      gradeNow = data_from_view_page["gradeId"];
    }
    imageLink = data_from_view_page["imageLink"];
    var imageDisplay = Image.file(File(data_from_view_page["imageLink"]));
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
                                chooseimage(File file) {
                                  setState(() {
                                    imageDisplay = Image.file(file);
                                  });
                                }

                                final ImagePicker _picker = ImagePicker();
                                final XFile image = await _picker.pickImage(
                                    source: ImageSource.gallery);
                                chooseimage(File(image.path));
                                imageLink = image.path.toString();
                              }, // Handle your callback.
                              splashColor: Colors.brown.withOpacity(0.5),
                              child: imageDisplay,
                            ),
                          ),
                        ],
                      ),
                      Text("Name:"),
                      TextFormField(
                        initialValue: fullName,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          fullName = value;
                        },
                      ),
                      Text("Address:"),
                      TextFormField(
                        initialValue: address,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          address = value;
                        },
                      ),
                      Text("Phone Number:"),
                      TextFormField(
                        initialValue: phoneNumber,
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
                                    listGradeItems =
                                        data_from_view_page["gradeName"];
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
                                  if (firstTime) {
                                    listSubjectItems =
                                        data_from_view_page["subjectName"];
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
                            child: Text("Update"),
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
        Get.back();
        Get.back();
        Get.back();
        Get.back();
        Get.back();
      },
    );
    AlertDialog secondAlert = AlertDialog(
      title: const Text("Attention!"),
      content: const Text("The Student has been updated succesfully!"),
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
    Widget updateButton = TextButton(
      child: const Text("Update"),
      onPressed: () async {
        await DatabaseProvider.db.updateStudent(
            data_from_view_page["studentId"],
            fullName,
            address,
            imageLink,
            phoneNumber,
            subjectId,
            gradeId);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return secondAlert;
          },
        );
      },
    );
    AlertDialog firstAlert = AlertDialog(
      title: const Text("Update student!"),
      content: const Text("Are you sure you want to Update this student?"),
      actions: [
        cancelButton,
        updateButton,
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
