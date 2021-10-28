import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/screens/note_create_page.dart';
import 'package:flutter_task_planner_app/screens/note_edit_page.dart';
import 'package:flutter_task_planner_app/theme/colors/light_colors.dart';
import 'package:flutter_task_planner_app/utils/db/database.dart';
import 'package:flutter_task_planner_app/widgets/drawer.dart';
import 'package:get/get.dart';

class NoteList extends StatefulWidget {
  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  var data = Get.arguments;

  _getNotes() async {
    var result = await DatabaseProvider.db.getNotes();
    return result;
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
          children: <Widget>[
            _navigator(),
            _body(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => NoteCreate(),
              arguments: {"studentId": data["studentId"]});
        },
        child: Icon(Icons.note_add),
      ),
    );
  }

  Expanded _body() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FutureBuilder(
                future: _getNotes(),
                builder: (context, noteData) {
                  if (noteData.hasData) {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: noteData.data.length,
                        itemBuilder: (context, index) {
                          if (noteData.data[index]["studentId"] ==
                              data["studentId"]) {
                            return _sizedBox(
                                noteData.data[index]["noteId"],
                                noteData.data[index]["title"],
                                noteData.data[index]["body"]);
                          } else {
                            return const Visibility(
                              child: Text(""),
                              visible: false,
                            );
                          }
                        });
                  } else {
                    return const Visibility(
                      child: Text(""),
                      visible: false,
                    );
                  }
                })
          ],
        ),
      ),
    );
  }

  AppBar _navigator() {
    var studentNameStr = data["fullName"].toString().split(" ");
    String studentName = studentNameStr[studentNameStr.length - 1];
    return AppBar(
      title: Text("Note for $studentName"),
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

  Container _sizedBox(int noteId, String title, String body) {
    return Container(
      child: SizedBox(
          height: 100,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 15, 10, 5),
            child: ElevatedButton(
                onPressed: () {
                  Get.to(() => NoteEditor(), arguments: {
                    "noteId": noteId,
                    "title": title,
                    "body": body,
                  });
                },
                child: Row(
                  children: [
                    Wrap(
                      children: [
                        Text(
                          title.trim(),
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w900),
                        )
                      ],
                    )
                  ],
                )),
          )),
    );
  }
}
