import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/screens/calendar_page.dart';
import 'package:flutter_task_planner_app/screens/choose_student.dart';
import 'package:flutter_task_planner_app/screens/google_map_screen.dart';
import 'package:flutter_task_planner_app/theme/colors/light_colors.dart';
import 'package:flutter_task_planner_app/widgets/drawer.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_task_planner_app/widgets/task_column.dart';
import 'package:flutter_task_planner_app/widgets/active_project_card.dart';
import 'package:flutter_task_planner_app/widgets/top_container.dart';

class HomePage extends StatelessWidget {
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

  static CircleAvatar calendarIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: LightColors.kGreen,
      child: Icon(
        Icons.calendar_today,
        size: 20.0,
        color: Colors.white,
      ),
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
          children: <Widget>[
            TopContainer(
              height: 180,
              width: width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // Icon(Icons.menu,
                        //     color: LightColors.kDarkBlue, size: 30.0),
                        Icon(Icons.search,
                            color: LightColors.kDarkBlue, size: 25.0),
                        IconButton(
                          icon: const Icon(Icons.menu),
                          splashRadius: 100,
                          onPressed: () {
                            _scaffoldKey.currentState.openDrawer();
                            _scaffoldKey.currentState.openEndDrawer();
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          CircularPercentIndicator(
                            radius: 95.0,
                            lineWidth: -1,
                            animation: true,
                            percent: 1,
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: LightColors.kRed,
                            backgroundColor: LightColors.kDarkYellow,
                            center: CircleAvatar(
                              backgroundColor: LightColors.kBlue,
                              radius: 35.0,
                              backgroundImage: AssetImage(
                                'assets/images/avatar.png',
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  'Nhat Minh',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: LightColors.kDarkBlue,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  'Easy Way to Control Your Work',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ]),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        children: <Widget>[
                          TextButton(
                              onPressed: () {
                                Get.to(() => CalendarPage());
                              },
                              child: TaskColumn(
                                icon: Icons.calendar_today,
                                iconBackgroundColor: LightColors.kRed,
                                title: 'Lịch Trình',
                                subtitle: 'Kiểm tra công việc của bạn mỗi ngày',
                              )),
                          SizedBox(height: 15.0),
                          TextButton(
                              onPressed: () {
                                Get.to(() => ChoosingPage(),
                                    arguments: {"functionID": 1});
                              },
                              child: TaskColumn(
                                icon: Icons.blur_circular,
                                iconBackgroundColor: LightColors.kDarkYellow,
                                title: 'Dặn dò',
                                subtitle: 'Những gì sẽ kiểm tra!',
                              )),
                          SizedBox(height: 15.0),
                          TextButton(
                            onPressed: () {
                              Get.to(() => ChoosingPage(),
                                  arguments: {"functionID": 2});
                            },
                            child: TaskColumn(
                              icon: Icons.location_on,
                              iconBackgroundColor: LightColors.kDarkBlue,
                              title: 'Địa điểm',
                              subtitle: 'Tìm đường tới vị trí của học sinh',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        children: <Widget>[
                          subheading('Danh Sách Học Sinh'),
                          SizedBox(height: 5.0),
                          Wrap(
                            children: [
                              TextButton(
                                onPressed: () {
                                  print("student1");
                                },
                                child: ActiveProjectsCard(
                                  cardColor: LightColors.kGreen,
                                  imgLink: "assets/images/student1.jpg",
                                  name: 'Quốc Trung',
                                  subject: 'Anh',
                                  grade: "5",
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  print("student2");
                                },
                                child: ActiveProjectsCard(
                                  cardColor: LightColors.kRed,
                                  imgLink: "assets/images/student2.jpg",
                                  name: 'Nhật Ánh',
                                  subject: 'Văn',
                                  grade: "3",
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  print("student3");
                                },
                                child: ActiveProjectsCard(
                                  cardColor: Colors.amber[800],
                                  imgLink: "assets/images/student3.jpg",
                                  name: 'Hải Dương',
                                  subject: 'Toán',
                                  grade: "5",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
