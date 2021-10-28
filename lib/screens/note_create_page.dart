import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/models/note.dart';
import 'package:flutter_task_planner_app/screens/student_choose_page.dart';
import 'package:flutter_task_planner_app/theme/colors/light_colors.dart';
import 'package:flutter_task_planner_app/utils/db/database.dart';
import 'package:flutter_task_planner_app/widgets/drawer.dart';
import 'package:get/get.dart';

class NoteCreate extends StatefulWidget {
  @override
  State<NoteCreate> createState() => _NoteCreateState();
}

class _NoteCreateState extends State<NoteCreate> {
  var data = Get.arguments;
  String title = "";
  String body = "";

  @override
  Widget build(BuildContext context) {
    var _scaffoldKey = new GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: new AppDrawer(),
      backgroundColor: LightColors.kLightYellow,
      body: SafeArea(
        child: Column(
          children: <Widget>[_navigator(), _noteBody()],
        ),
      ),
    );
  }

  AppBar _navigator() {
    return AppBar(
      title: TextFormField(
        initialValue: title,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Title',
          contentPadding:
              const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        onChanged: (value) {
          title = value;
        },
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_sharp,
          color: Colors.white,
        ),
        onPressed: () {
          if (title != "" || body != "") {
            if (title == "") {
              title = "(" + DateTime.now().toString().split(" ")[0] + ")";
            }
            Note newNote = Note(
                title: title,
                body: body,
                createDate: DateTime.now().toString(),
                studentId: data["studentId"]);
            DatabaseProvider.db.addNewNote(newNote);
          }
          Get.back();
          Get.back();
        },
      ),
      actions: [],
      backgroundColor: LightColors.kDarkYellow,
    );
  }

  Container _noteBody() {
    return Container(
      child: Expanded(
        child: SizedBox(
          height: 1000,
          child: TextFormField(
            autofocus: true,
            initialValue: '',
            keyboardType: TextInputType.multiline,
            maxLines: null,
            maxLength: null,
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.only(left: 14.0, top: 10.0, right: 5),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            onChanged: (value) {
              body = value;
            },
          ),
        ),
      ),
    );
  }
}
