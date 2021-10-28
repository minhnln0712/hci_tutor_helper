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

class UpdateEvent extends StatefulWidget {
  @override
  _UpdateEventState createState() => _UpdateEventState();
}

class _UpdateEventState extends State<UpdateEvent> {
  var data_from_student_info = Get.arguments;
  String startTimeChanged = '';
  String startTimeToValidate = '';
  String startTimeSaved = '';
  String endTimeChanged = '';
  String endTimeToValidate = '';
  String endTimeSaved = '';
  String title = "";
  String description = "";
  String startTime = "";
  String endTime = "";

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
      title: Text("Update Event"),
      backgroundColor: LightColors.kDarkYellow,
    );
  }

  Widget _upper() {
    title = data_from_student_info["title"];
    description = data_from_student_info["description"];
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
            Wrap(
              children: [
                DateTimePicker(
                  type: DateTimePickerType.time,
                  timePickerEntryModeInput: true,
                  initialValue: data_from_student_info["fromTime"],
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
                  initialValue: data_from_student_info["toTime"],
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
              height: 300,
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
              showAlertDialog(context);
            },
            child: const Text(
              "Update",
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
        Get.back();
        Get.back();
      },
    );
    AlertDialog secondAlert = AlertDialog(
      title: const Text("Attention!"),
      content: const Text("This event has been updated successfully!"),
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
      onPressed: () {
        if (startTimeChanged != "") {
          startTime =
              data_from_student_info["date"] + "T" + startTimeChanged + ":00";
        } else {
          startTime = data_from_student_info["date"] +
              "T" +
              data_from_student_info["fromTime"] +
              ":00";
        }
        if (endTimeChanged != "") {
          endTime =
              data_from_student_info["date"] + "T" + endTimeChanged + ":00";
        } else {
          endTime = data_from_student_info["date"] +
              "T" +
              data_from_student_info["toTime"] +
              ":00";
        }
        DatabaseProvider.db.updateEvent(data_from_student_info["eventId"],
            title, description, startTime, endTime);
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
      content: const Text("Are you sure to update this Event!"),
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
