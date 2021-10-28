import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/models/calendarevent.dart';
import 'package:flutter_task_planner_app/theme/colors/light_colors.dart';
import 'package:flutter_task_planner_app/utils/db/database.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

_getCalendarEvent() async {
  var res = await DatabaseProvider.db.getCalendarEvents();
  return res;
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    List<Appointment> meetings = <Appointment>[];
    return Scaffold(
      body: FutureBuilder(
        future: _getCalendarEvent(),
        builder: (context, eventData) {
          meetings.clear();
          if (eventData.hasData) {
            var event = eventData.data;
            for (int i = 0; i < event.length; i++) {
              meetings.add(Appointment(
                startTime: DateTime.parse(event[i]["startTime"]),
                endTime: DateTime.parse(event[i]["endTime"]),
                subject: event[i]["title"],
                color: LightColors.kDarkYellow,
              ));
            }
            return SfCalendar(
                view: CalendarView.week,
                firstDayOfWeek: DateTime.monday,
                backgroundColor: LightColors.kLightYellow,
                dataSource: _MeetingDataSource(meetings),
                todayHighlightColor: LightColors.kDarkYellow);
          } else {
            return SfCalendar(
                view: CalendarView.week,
                firstDayOfWeek: DateTime.monday,
                backgroundColor: LightColors.kLightYellow,
                dataSource: _MeetingDataSource(meetings),
                todayHighlightColor: LightColors.kDarkYellow);
          }
        },
      ),
      appBar: AppBar(
        title: Text("Calendar"),
        actions: [],
        backgroundColor: LightColors.kDarkYellow,
      ),
    );
  }
}

class _MeetingDataSource extends CalendarDataSource {
  _MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
