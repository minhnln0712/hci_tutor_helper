import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/models/note.dart';
import 'package:flutter_task_planner_app/screens/student_choose_page.dart';
import 'package:flutter_task_planner_app/theme/colors/light_colors.dart';
import 'package:flutter_task_planner_app/utils/db/database.dart';
import 'package:flutter_task_planner_app/widgets/drawer.dart';
import 'package:get/get.dart';

class NoteEditor extends StatefulWidget {
  @override
  State<NoteEditor> createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditor> {
  var data = Get.arguments;
  String title = "";
  String body = "";
  _getNotes() async {
    var result = await DatabaseProvider.db.getNotes();
    return result;
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
          _navigator(data["title"], data["body"]),
          _noteBody()
        ],
      )),
    );
  }

  AppBar _navigator(String oldTitle, String oldBody) {
    title = oldTitle;
    body = oldBody;
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
          if (title != oldTitle || body != oldBody) {
            DatabaseProvider.db.updateNote(data["noteId"], title, body);
          }
          Get.off(() => ChoosingPage());
        },
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            showAlertDialog(context);
          },
          child: Icon(Icons.delete_forever),
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(LightColors.kDarkYellow)),
        )
      ],
      backgroundColor: LightColors.kDarkYellow,
    );
  }

  Container _noteBody() {
    return Container(
      child: Expanded(
        child: TextFormField(
          autofocus: true,
          initialValue: body,
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
    );
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Get.off(() => ChoosingPage());
      },
    );
    AlertDialog secondAlert = AlertDialog(
      title: const Text("Attention!"),
      content: const Text("The Note has been deleted succesfully!"),
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
    Widget deleteButton = TextButton(
      child: const Text("Delete"),
      onPressed: () async {
        DatabaseProvider.db.deleteNote(data["noteId"]);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return secondAlert;
          },
        );
      },
    );
    AlertDialog firstAlert = AlertDialog(
      title: const Text("Delete note!"),
      content: const Text("Are you sure you want to Delete this note?"),
      actions: [
        cancelButton,
        deleteButton,
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
