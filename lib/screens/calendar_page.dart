import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/theme/colors/light_colors.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

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
    List<Appointment> meetings = <Appointment>[];
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    return Scaffold(
      body: SfCalendar(
          view: CalendarView.week,
          firstDayOfWeek: DateTime.monday,
          backgroundColor: LightColors.kLightYellow,
          dataSource: _MeetingDataSource(meetings),
          todayHighlightColor: LightColors.kDarkYellow),
      appBar: AppBar(
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
