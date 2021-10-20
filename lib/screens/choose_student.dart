import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/screens/calendar_page.dart';
import 'package:flutter_task_planner_app/screens/google_map_screen.dart';
import 'package:flutter_task_planner_app/theme/colors/light_colors.dart';
import 'package:flutter_task_planner_app/utils/db/datebase.dart';
import 'package:flutter_task_planner_app/widgets/drawer.dart';
import 'package:get/get.dart';
import 'package:flutter_task_planner_app/widgets/task_column.dart';
import 'package:flutter_task_planner_app/widgets/active_project_card.dart';

class ChoosingPage extends StatelessWidget {
  var data = Get.arguments;
  getStudents() async {
    final students = await DatabaseProvider.db.getStudents();
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
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                children: <Widget>[
                  subheading('Danh Sách Học Sinh'),
                  SizedBox(height: 5.0),
                  Wrap(
                    children: [
                      FutureBuilder(
                          future: getStudents(),
                          // ignore: missing_return
                          builder: (context, studentData) {
                            if (studentData.hasData) {
                              return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    return TextButton(
                                      onPressed: () {
                                        print(studentData.data[index]
                                            ["studentId"]);
                                        print(studentData.data[index]
                                            ["fullName"]);
                                      },
                                      child: ActiveProjectsCard(
                                        cardColor: LightColors.kGreen,
                                        imgLink: "assets/images/student1.jpg",
                                        name: studentData.data[index]
                                            ["fullName"],
                                        subject: studentData.data[index]
                                            ["subjectId"],
                                        grade: studentData.data[index]
                                            ["gradeId"],
                                      ),
                                    );
                                  });
                            } else if (studentData.hasError) {
                              return Text("");
                            } else {
                              return Text("Bạn chưa nhập học sinh nào hết!");
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
