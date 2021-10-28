import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/screens/note_list_page.dart';
import 'package:flutter_task_planner_app/screens/student_view_page.dart';
import 'package:flutter_task_planner_app/theme/colors/light_colors.dart';
import 'package:flutter_task_planner_app/utils/db/database.dart';
import 'package:flutter_task_planner_app/utils/map_ultis.dart';
import 'package:flutter_task_planner_app/widgets/drawer.dart';
import 'package:get/get.dart';
import 'package:flutter_task_planner_app/widgets/active_project_card.dart';

class ChoosingPage extends StatefulWidget {
  @override
  State<ChoosingPage> createState() => _ChoosingPageState();
}

class _ChoosingPageState extends State<ChoosingPage> {
  var data = Get.arguments;

  _getStudents() async {
    final students = await DatabaseProvider.db.getStudents();
    return students;
  }

  _getSubjectName(int subjectId) async {
    final subjectName =
        await DatabaseProvider.db.getSubjectNamebySubjectId(subjectId);
    return subjectName;
  }

  _getGradeName(int gradeId) async {
    final gradeName = await DatabaseProvider.db.getGradeNamebyGradeId(gradeId);
    return gradeName;
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
                  Wrap(
                    children: [
                      FutureBuilder(
                          future: _getStudents(),
                          builder: (context, studentData) {
                            if (studentData.hasData) {
                              return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: studentData.data.length,
                                  itemBuilder: (context, index) {
                                    String gradeName = "";
                                    String subjectName = "";
                                    return FutureBuilder(
                                        future: _getGradeName(
                                            studentData.data[index]["gradeId"]),
                                        builder: (context, gradeData) {
                                          if (gradeData.hasData) {
                                            gradeName = gradeData.data;
                                            return FutureBuilder(
                                              future: _getSubjectName(
                                                  studentData.data[index]
                                                      ["subjectId"]),
                                              builder: (context, subjectData) {
                                                subjectName = subjectData.data;
                                                if (subjectName != null &&
                                                    studentData.data[index]
                                                            ["status"] ==
                                                        1) {
                                                  return TextButton(
                                                    onPressed: () {
                                                      if (data["functionID"] ==
                                                          1) {
                                                        Get.to(() => NoteList(),
                                                            arguments: {
                                                              "studentId": studentData
                                                                          .data[
                                                                      index]
                                                                  ["studentId"],
                                                              "fullName":
                                                                  studentData.data[
                                                                          index]
                                                                      [
                                                                      "fullName"]
                                                            });
                                                      } else if (data[
                                                              "functionID"] ==
                                                          2) {
                                                        String address =
                                                            studentData
                                                                    .data[index]
                                                                ["address"];
                                                        MapUtil.openMap(
                                                            Uri.encodeComponent(
                                                                address));
                                                      }
                                                      if (data["functionID"] ==
                                                          3) {
                                                        Get.to(
                                                            () =>
                                                                StudentDetail(),
                                                            arguments: {
                                                              "studentId": studentData
                                                                          .data[
                                                                      index]
                                                                  ["studentId"],
                                                              "fullName": studentData
                                                                          .data[
                                                                      index]
                                                                  ["fullName"],
                                                              "address": studentData
                                                                          .data[
                                                                      index]
                                                                  ["address"],
                                                              "imageLink": studentData
                                                                          .data[
                                                                      index]
                                                                  ["imageLink"],
                                                              "phone": studentData
                                                                          .data[
                                                                      index]
                                                                  ["phone"],
                                                              "subjectId": studentData
                                                                          .data[
                                                                      index]
                                                                  ["subjectId"],
                                                              "subjectName":
                                                                  subjectName,
                                                              "gradeId": studentData
                                                                          .data[
                                                                      index]
                                                                  ["gradeId"],
                                                              "gradeName":
                                                                  gradeName
                                                            });
                                                      }
                                                    },
                                                    child: ActiveProjectsCard(
                                                      cardColor:
                                                          LightColors.kBlue,
                                                      name: studentData
                                                              .data[index]
                                                          ["fullName"],
                                                      subject: subjectName,
                                                      grade: gradeName,
                                                    ),
                                                  );
                                                } else {
                                                  return const Visibility(
                                                    child: Text(""),
                                                    visible: false,
                                                  );
                                                }
                                              },
                                            );
                                          } else {
                                            return const Visibility(
                                              child: Text(""),
                                              visible: false,
                                            );
                                          }
                                        });
                                  });
                            } else if (studentData.hasError) {
                              return Text("");
                            } else {
                              return Text("You aren't create any student yet");
                            }
                          })
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
      title: Text("Student List"),
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
}
