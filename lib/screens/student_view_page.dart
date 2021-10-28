import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/screens/event_create_page.dart';
import 'package:flutter_task_planner_app/screens/student_update_page.dart';
import 'package:flutter_task_planner_app/theme/colors/light_colors.dart';
import 'package:flutter_task_planner_app/utils/db/database.dart';
import 'package:flutter_task_planner_app/widgets/drawer.dart';
import 'package:get/get.dart';

import 'event_update_page.dart';

class StudentDetail extends StatefulWidget {
  @override
  State<StudentDetail> createState() => _StudentDetailState();
}

class _StudentDetailState extends State<StudentDetail> {
  var data = Get.arguments;

  _getCalendarEvent() async {
    var res = await DatabaseProvider.db.getCalendarEvents();
    return res;
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
                  SizedBox(height: 5.0),
                  SizedBox(
                    height: 200,
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.yellowAccent, // red as border color
                          ),
                        ),
                        child: Image.file(File(data["imageLink"]))),
                  ),
                  SizedBox(height: 5.0),
                  Column(
                    children: [
                      listItem("Name:", data["fullName"]),
                      listItem("Address:", data["address"]),
                      listItem("Grade:", data["gradeName"]),
                      listItem("Subject:", data["subjectName"]),
                      listItem("Phone:", data["phone"]),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.to(() => CreateEvent(),
                              arguments: {"studentId": data["studentId"]});
                        },
                        child: Text(
                          "Create Lesson",
                          style: TextStyle(
                              color: LightColors.kLightYellow,
                              fontWeight: FontWeight.w800),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: LightColors.kDarkYellow,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => UpdateStudent(), arguments: {
                            "studentId": data["studentId"],
                            "fullName": data["fullName"],
                            "address": data["address"],
                            "imageLink": data["imageLink"],
                            "phone": data["phone"],
                            "subjectId": data["subjectId"],
                            "subjectName": data["subjectName"],
                            "gradeId": data["gradeId"],
                            "gradeName": data["gradeName"]
                          });
                        },
                        child: Text(
                          "Update Info",
                          style: TextStyle(
                              color: LightColors.kLightYellow,
                              fontWeight: FontWeight.w800),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: LightColors.kDarkYellow,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          showAlertDialog(context);
                        },
                        child: Text(
                          "Delete Student",
                          style: TextStyle(
                              color: LightColors.kLightYellow,
                              fontWeight: FontWeight.w800),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: LightColors.kDarkYellow,
                        ),
                      ),
                    ],
                  ),
                  subheading('Teaching Calendar'),
                  SizedBox(
                    height: 350,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [_class()],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Material listItem(String left, String right) {
    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            left,
            style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w900,
                backgroundColor: LightColors.kLightYellow),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 135,
            child: Text(
              right.trim(), //Address
              overflow: TextOverflow.clip,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  backgroundColor: LightColors.kLightYellow),
            ),
          ),
        ],
      ),
      color: LightColors.kLightYellow,
    );
  }

  AppBar _navigator() {
    return AppBar(
      title: Text("Student Information"),
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

  Container _class() {
    return Container(
      height: MediaQuery.of(context).size.height - 250,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder(
          future: _getCalendarEvent(),
          builder: (context, eventData) {
            if (eventData.hasData) {
              var event = eventData.data;
              return ListView.builder(
                  itemCount: event.length,
                  itemBuilder: (context, index) {
                    if (event[index]["studentId"] == data["studentId"]) {
                      return buildClassItem(
                          event[index]["eventId"],
                          event[index]["title"],
                          event[index]["description"],
                          event[index]["startTime"],
                          event[index]["endTime"]);
                    } else {
                      return const Visibility(
                        child: Text(""),
                        visible: false,
                      );
                    }
                  });
            } else if (eventData.hasError) {
              return const Visibility(
                child: Text(""),
                visible: false,
              );
            } else {
              return const Visibility(
                child: Text(""),
                visible: false,
              );
            }
          }),
    );
  }

  Container buildClassItem(int eventid, String title, String description,
      String startTime, String endTime) {
    var startTimeStr = startTime.split("T");
    String date = startTimeStr[0];
    var fromTimeStr = startTimeStr[1].split(":");
    String fromTime = fromTimeStr[0] + ":" + fromTimeStr[1];
    var endTimeStr = endTime.split("T");
    var toTimeStr = endTimeStr[1].split(":");
    String toTime = toTimeStr[0] + ":" + toTimeStr[1];
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
          color: const Color(0xFFF9F9FB),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.black)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 150,
                  child: Text(
                    title.trim(), //Subject Name
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 150,
                  child: Text(
                    description.trim(), //Address
                    overflow: TextOverflow.clip,
                    style: const TextStyle(color: Colors.black, fontSize: 13),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 150,
                  child: Text(
                    "At " + date.trim(), //Address
                    overflow: TextOverflow.clip,
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 150,
                  child: Text(
                    "From " +
                        fromTime.trim() +
                        " to " +
                        toTime.trim(), //Address
                    overflow: TextOverflow.clip,
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Get.to(() => UpdateEvent(), arguments: {
                    "eventId": eventid,
                    "title": title,
                    "description": description,
                    "date": date,
                    "fromTime": fromTime,
                    "toTime": toTime
                  });
                },
                icon: const Icon(Icons.arrow_right_alt_rounded),
              ),
            ],
          ),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("Confirm"),
      onPressed: () {
        Get.back();
        Get.back();
        Get.back();
      },
    );
    AlertDialog secondAlert = AlertDialog(
      title: const Text("Attention!"),
      content: const Text("The student have been deleted successfully!"),
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
    Widget deleteButton = TextButton(
      child: const Text("Delete"),
      onPressed: () async {
        await DatabaseProvider.db.deleteStudent(data["studentId"]);
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
        deleteButton,
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
