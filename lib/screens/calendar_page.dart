import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/components/date_time_format.dart';
import 'package:flutter_task_planner_app/dates_list.dart';
import 'package:flutter_task_planner_app/theme/colors/light_colors.dart';
import 'package:flutter_task_planner_app/widgets/calendar_dates.dart';
import 'package:flutter_task_planner_app/widgets/task_container.dart';
import 'package:flutter_task_planner_app/screens/create_new_task_page.dart';
import 'package:flutter_task_planner_app/widgets/back_button.dart';
import 'package:flutter_week_view/flutter_week_view.dart';

class CalendarPage extends StatelessWidget {
  Widget _dashedText() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Text(
        '------------------------------------------',
        maxLines: 1,
        style:
            TextStyle(fontSize: 20.0, color: Colors.black12, letterSpacing: 5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            0,
          ),
          child: Column(
            children: <Widget>[
              MyBackButton(),
              SizedBox(height: 30.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Today',
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.w700),
                    ),
                    Container(
                      height: 40.0,
                      width: 120,
                      decoration: BoxDecoration(
                        color: LightColors.kGreen,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateNewTaskPage(),
                            ),
                          );
                        },
                        child: Center(
                          child: Text(
                            'Add task',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ]),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Today Class, Minh',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppDateTimeFormat.monthFormat.format(now) +
                      " " +
                      AppDateTimeFormat.yearFormat.format(now),
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
              ),
              SizedBox(height: 20.0),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        WeekView(
                          dates: [
                            date.subtract(Duration(days: 1)),
                            date,
                            date.add(Duration(days: 1))
                          ],
                          events: [
                            FlutterWeekViewEvent(
                              title: 'An event 1',
                              description: 'A description 1',
                              start: date.subtract(Duration(hours: 1)),
                              end: date.add(Duration(hours: 18, minutes: 30)),
                            ),
                            FlutterWeekViewEvent(
                              title: 'An event 2',
                              description: 'A description 2',
                              start: date.add(Duration(hours: 19)),
                              end: date.add(Duration(hours: 22)),
                            ),
                            FlutterWeekViewEvent(
                              title: 'An event 3',
                              description: 'A description 3',
                              start: date.add(Duration(hours: 23, minutes: 30)),
                              end: date.add(Duration(hours: 25, minutes: 30)),
                            ),
                            FlutterWeekViewEvent(
                              title: 'An event 4',
                              description: 'A description 4',
                              start: date.add(Duration(hours: 20)),
                              end: date.add(Duration(hours: 21)),
                            ),
                            FlutterWeekViewEvent(
                              title: 'An event 5',
                              description: 'A description 5',
                              start: date.add(Duration(hours: 20)),
                              end: date.add(Duration(hours: 21)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
