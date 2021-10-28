import 'dart:developer';

import 'package:flutter_task_planner_app/models/calendarevent.dart';
import 'package:flutter_task_planner_app/models/grade.dart';
import 'package:flutter_task_planner_app/models/note.dart';
import 'package:flutter_task_planner_app/models/student.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), "tutor_helper.db"),
        onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE tblGrade (
        gradeId INTEGER PRIMARY KEY AUTOINCREMENT,
        gradeName TEXT
        )''');
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('Grade 1')");
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('Grade 2')");
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('Grade 3')");
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('Grade 4')");
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('Grade 5')");
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('Grade 6')");
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('Grade 7')");
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('Grade 8')");
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('Grade 9')");
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('Grade 10')");
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('Grade 11')");
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('Grade 12')");
      await db.execute('''
        CREATE TABLE tblSubject (
        subjectId INTEGER PRIMARY KEY AUTOINCREMENT,
        subjectName TEXT,
        gradeId INTEGER REFERENCES tblGrade(gradeId)
        )''');
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Vietnamese 1',1)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Math 1',1)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('English 1',1)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Vietnamese 2',2)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Math 2',2)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('English 2',2)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Vietnamese 3',3)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Math 3',3)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('English 3',3)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Vietnamese 4',4)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Math 4',4)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('English 4',4)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Vietnamese 5',5)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Math 5',5)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('English 5',5)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Literature 6',6)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Math 6',6)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('English 6',6)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Literature 7',7)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Math 7',7)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('English 7',7)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Literature 8',8)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Math 8',8)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('English 8',8)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Literature 9',9)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Math 9',9)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('English 9',9)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Literature 10',10)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Math 10',10)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('English 10',10)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Literature 11',11)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Math 11',11)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('English 11',11)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Literature 12',12)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Math 12',12)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('English 12',12)");
      await db.execute('''
        CREATE TABLE tblStudent (
        studentId INTEGER PRIMARY KEY AUTOINCREMENT,
        fullName TEXT,
        address TEXT,
        imageLink TEXT,
        phone TEXT,
        subjectId INTEGER REFERENCES tblSubject(subjectId),
        gradeId INTEGER REFERENCES tblGrade(gradeId),
        createDate DATE,
        status BIT
        )''');
      await db.execute('''
        CREATE TABLE tblNote (
        noteId INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        body TEXT,
        createDate DATE,
        studentId INTEGER REFERENCES tblStudent(studentId)
        )''');
      await db.execute('''
        CREATE TABLE tblCalendarEvent (
        eventId INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        createDate DATE,
        startTime DATE,
        endTime DATE,
        studentId INTEGER REFERENCES tblStudent(studentId)
        )''');
    }, version: 1);
  }

  Future<dynamic> getGrades() async {
    final db = await database;
    var response = await db.rawQuery("SELECT gradeName FROM tblGrade");
    if (response.length == 0)
      return null;
    else {
      var resultMap = response.toList();
      List<String> listGrade = [];
      for (int i = 0; i < resultMap.length; i++) {
        listGrade.add(resultMap[i]["gradeName"]);
      }
      return listGrade.isNotEmpty ? listGrade : null;
    }
  }

  Future<int> getGradeIdbyGradeName(String gradeName) async {
    final db = await database;
    var response = await db.rawQuery(
        "SELECT gradeId FROM tblGrade WHERE gradeName = '$gradeName'");
    if (response.length == 0)
      return null;
    else {
      var resultMap = response.toList();
      int gradeId = resultMap[0]["gradeId"];
      return gradeId != 0 ? gradeId : 0;
    }
  }

  Future<String> getGradeNamebyGradeId(int gradeId) async {
    final db = await database;
    var response = await db
        .rawQuery("SELECT gradeName FROM tblGrade WHERE gradeId = '$gradeId'");
    if (response.length == 0)
      return null;
    else {
      var resultMap = response.toList();
      String gradeName = resultMap[0]["gradeName"];
      return gradeName.isNotEmpty ? gradeName : 0;
    }
  }

  Future<dynamic> getSubjects(int gradeId) async {
    final db = await database;
    var response = await db.rawQuery(
        "SELECT subjectName FROM tblSubject WHERE gradeId = $gradeId");
    if (response.length == 0)
      return null;
    else {
      var resultMap = response.toList();
      List<String> listSubject = [];
      for (int i = 0; i < resultMap.length; i++) {
        listSubject.add(resultMap[i]["subjectName"]);
      }
      return listSubject.isNotEmpty ? listSubject : null;
    }
  }

  Future<int> getSubjectIdbySubjectName(String subjectName) async {
    final db = await database;
    var response = await db.rawQuery(
        "SELECT subjectId FROM tblSubject WHERE subjectName = '$subjectName'");
    if (response.length == 0)
      return null;
    else {
      var resultMap = response.toList();
      int subjectId = resultMap[0]["subjectId"];
      return subjectId != 0 ? subjectId : 0;
    }
  }

  Future<String> getSubjectNamebySubjectId(int subjectId) async {
    final db = await database;
    var response = await db.rawQuery(
        "SELECT subjectName FROM tblSubject WHERE subjectId = '$subjectId'");
    if (response.length == 0)
      return null;
    else {
      var resultMap = response.toList();
      String subjectName = resultMap[0]["subjectName"];
      return subjectName.isNotEmpty ? subjectName : 0;
    }
  }

  addNewStudent(Student student) async {
    final db = await database;
    db.insert("tblStudent", student.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  updateStudent(int studentId, String fullName, String address,
      String imageLink, String phone, int subjectId, int gradeId) async {
    final db = await database;
    await db.rawUpdate("""
    UPDATE tblStudent\n
    SET fullName = '$fullName',address = '$address',imageLink = '$imageLink',phone='$phone',subjectId=$subjectId,gradeId=$gradeId\n
    WHERE studentId = $studentId\n
    """);
  }

  deleteStudent(int studentId) async {
    final db = await database;
    await db.rawUpdate("""
    UPDATE tblStudent 
    SET status = 0  
    WHERE studentId = $studentId 
    """);
  }

  Future<dynamic> getStudents() async {
    final db = await database;
    var response = await db.query("tblStudent");
    if (response.length == 0)
      return null;
    else {
      var resultMap = response.toList();
      return resultMap.isNotEmpty ? resultMap : null;
    }
  }

  addNewNote(Note note) async {
    final db = await database;
    db.insert("tblNote", note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<dynamic> getNotes() async {
    final db = await database;
    var response = await db.query("tblNote");
    if (response.length == 0)
      return null;
    else {
      var resultMap = response.toList();
      return resultMap.isNotEmpty ? resultMap : null;
    }
  }

  updateNote(int noteId, String title, String body) async {
    final db = await database;
    db.rawUpdate("""
    UPDATE tblNote\n
    SET title='$title',body='$body'\n
    WHERE noteId = $noteId
    """);
  }

  deleteNote(int noteId) async {
    final db = await database;
    db.rawDelete("""
    DELETE FROM tblNote\n
    WHERE noteId = $noteId
    """);
  }

  addNewCalendarEvent(CalendarEvent event) async {
    final db = await database;
    await db.insert("tblCalendarEvent", event.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<dynamic> getCalendarEvents() async {
    final db = await database;
    var response = await db.rawQuery("""
    SELECT *\n
    FROM tblCalendarEvent\n
    ORDER BY startTime ASC
    """);
    log(response.length.toString());
    if (response.length == 0)
      return null;
    else {
      var resultMap = response.toList();
      return resultMap.isNotEmpty ? resultMap : null;
    }
  }

  void updateEvent(int eventId, String title, String description,
      String startTime, String endTime) async {
    var startTimeDate = DateTime.parse(startTime);
    var endTimeDate = DateTime.parse(endTime);
    final db = await database;
    var res = await db.rawUpdate("""
    UPDATE tblCalendarEvent\n
    SET title='$title',description='$description',startTime='$startTimeDate',endTime='$endTimeDate'\n
    WHERE eventId=$eventId
    """);
    log(res.toString());
  }

  void deleteEvent(int eventId) async {
    final db = await database;
    await db.rawDelete("""
    DELETE FROM tblCalendarEvent\n
    WHERE eventId = $eventId
    """);
  }
}
