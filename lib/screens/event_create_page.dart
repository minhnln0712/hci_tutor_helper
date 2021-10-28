// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/components/date_time_format.dart';
import 'package:flutter_task_planner_app/models/calendarevent.dart';
import 'package:flutter_task_planner_app/theme/colors/light_colors.dart';
import 'package:flutter_task_planner_app/utils/db/database.dart';
import 'package:get/get.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:day_picker/day_picker.dart';

class CreateEvent extends StatefulWidget {
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final List<DayInWeek> _days = [
    DayInWeek("Mon"),
    DayInWeek("Tue"),
    DayInWeek("Wed"),
    DayInWeek("Thu"),
    DayInWeek("Fri"),
    DayInWeek("Sat"),
    DayInWeek("Sun"),
  ];
  var data_from_student_info = Get.arguments;
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  String startTimeChanged = '';
  String startTimeToValidate = '';
  String startTimeSaved = '';
  String endTimeChanged = '';
  String endTimeToValidate = '';
  String endTimeSaved = '';
  List<int> weekdateData = [];
  List<List<String>> classDateTimeData = [];
  String title = "";
  String description = "";

  _startDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedStartDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.parse("2100-01-01"),
    );
    if (picked != null && picked != selectedStartDate) {
      setState(() {
        selectedStartDate = picked;
      });
    }
  }

  _endDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedEndDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.parse("2100-01-01"),
    );
    if (picked != null && picked != selectedEndDate) {
      setState(() {
        selectedEndDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_navigator(), _upper()]);
  }

  AppBar _navigator() {
    return AppBar(
      title: Text("Create Event"),
      backgroundColor: LightColors.kDarkYellow,
    );
  }

  Widget _upper() {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        margin: const EdgeInsets.only(top: 75),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
        height: 800,
        width: 420,
        decoration: const BoxDecoration(
          color: LightColors.kLightYellow,
        ),
        child: Column(
          children: [
            Row(
              children: const [
                Text(
                  "Title",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            TextFormField(
              initialValue: title,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                title = value;
              },
            ),
            Row(
              children: const [
                Text(
                  "Description",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            TextFormField(
              initialValue: description,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              onChanged: (value) {
                description = value;
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Start Date:",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () => _startDate(context),
                    child: Text(
                      "${selectedStartDate.toLocal()}".split(' ')[0],
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "End Date:",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () => _endDate(context),
                    child: Text(
                      "${selectedEndDate.toLocal()}".split(' ')[0],
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                  ),
                ),
              ],
            ),
            Wrap(
              children: [
                SelectWeekDays(
                  days: _days,
                  border: false,
                  boxDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      colors: [Color(0xFFAE8556), Color(0xFFAE8556)],
                      tileMode: TileMode.repeated,
                    ),
                  ),
                  onSelect: (List<String> values) {
                    weekdateData.clear();
                    Map<String, int> weekday = {
                      "Mon": 1,
                      "Tue": 2,
                      "Wed": 3,
                      "Thu": 4,
                      "Fri": 5,
                      "Sat": 6,
                      "Sun": 7,
                    };
                    var entryList = weekday.entries.toList();
                    for (int i = 0; i < values.length; i++) {
                      for (int k = 0; k < weekday.length; k++) {
                        if (values[i] == entryList[k].key) {
                          weekdateData.add(entryList[k].value);
                          break;
                        }
                      }
                    }
                  },
                ),
              ],
            ),
            Wrap(
              children: [
                DateTimePicker(
                  type: DateTimePickerType.time,
                  timePickerEntryModeInput: true,
                  initialValue: '',
                  icon: const Icon(Icons.access_time),
                  timeLabelText: "Start Time",
                  use24HourFormat: true,
                  locale: const Locale('vi', 'VN'),
                  onChanged: (val) => setState(() => startTimeChanged = val),
                  validator: (val) {
                    setState(() => startTimeToValidate = val ?? '');
                    return null;
                  },
                  onSaved: (val) => setState(() => startTimeSaved = val ?? ''),
                ),
              ],
            ),
            Wrap(
              children: [
                DateTimePicker(
                  type: DateTimePickerType.time,
                  timePickerEntryModeInput: true,
                  initialValue: '',
                  icon: const Icon(Icons.access_time),
                  timeLabelText: "End Time",
                  use24HourFormat: true,
                  locale: const Locale('vi', 'VN'),
                  onChanged: (val) => setState(() => endTimeChanged = val),
                  validator: (val) {
                    setState(() => endTimeToValidate = val ?? '');
                    return null;
                  },
                  onSaved: (val) => setState(() => endTimeSaved = val ?? ''),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            _under(),
          ],
        ),
      ),
    );
  }

  Row _under() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
            onPressed: () {
              classDateTimeData.clear();
              for (int i = 0; i < weekdateData.length; i++) {
                List<List<String>> dateTimeData = DateTimeApp.getDaysInBetween(
                    "${selectedStartDate.toLocal()}".split(' ')[0],
                    "${selectedEndDate.toLocal()}".split(' ')[0],
                    weekdateData[i],
                    startTimeChanged,
                    endTimeChanged);
                for (int k = 0; k < dateTimeData.length; k++) {
                  classDateTimeData.add(dateTimeData[k]);
                }
              }
              showAlertDialog(context);
            },
            child: const Text(
              "Create",
              style: TextStyle(color: Colors.white),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Color(0xFFAE8556),
              textStyle: const TextStyle(fontSize: 20),
            ))
      ],
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
      content: const Text("This event has been created successfully!"),
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
      onPressed: () {
        for (int i = 0; i < classDateTimeData.length; i++) {
          var date = classDateTimeData[i][0].split("T");
          String dateStr = date[0];
          var event = CalendarEvent(
              title: title,
              description: description,
              createDate: DateTime.now().toString(),
              startTime: classDateTimeData[i][0],
              endTime: classDateTimeData[i][1],
              studentId: data_from_student_info["studentId"]);
          DatabaseProvider.db.addNewCalendarEvent(event);
        }

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
      content: const Text("Are you sure to create this Event!"),
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
