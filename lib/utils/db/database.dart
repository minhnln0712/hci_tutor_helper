import 'dart:developer';

import 'package:flutter_task_planner_app/models/grade.dart';
import 'package:flutter_task_planner_app/models/note.dart';
import 'package:flutter_task_planner_app/models/student.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('Lớp 1')");
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('Lớp 2')");
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('Lớp 3')");
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('Lớp 4')");
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('Lớp 5')");
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('Lớp 6')");
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('Lớp 7')");
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('Lớp 8')");
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('Lớp 9')");
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('Lớp 10')");
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('Lớp 11')");
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('Lớp 12')");
      await db.execute('''
        CREATE TABLE tblSubject (
        subjectId INTEGER PRIMARY KEY AUTOINCREMENT,
        subjectName TEXT,
        gradeId INTEGER REFERENCES tblGrade(gradeId)
        )''');
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Tiếng Việt 1',1)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Toán 1',1)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Tiếng Anh 1',1)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Tiếng Việt 2',2)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Toán 2',2)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Tiếng Anh 2',2)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Tiếng Việt 3',3)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Toán 3',3)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Tiếng Anh 3',3)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Tiếng Việt 4',4)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Toán 4',4)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Tiếng Anh 4',4)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Tiếng Việt 5',5)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Toán 5',5)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Tiếng Anh 5',5)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Tiếng Việt 6',6)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Toán 6',6)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Tiếng Anh 6',6)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Tiếng Việt 7',7)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Toán 7',7)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Tiếng Anh 7',7)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Tiếng Việt 8',8)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Toán 8',8)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Tiếng Anh 8',8)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Tiếng Việt 9',9)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Toán 9',9)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Tiếng Anh 9',9)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Tiếng Việt 10',10)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Toán 10',10)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Tiếng Anh 10',10)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Tiếng Việt 11',11)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Toán 11',11)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Tiếng Anh 11',11)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Tiếng Việt 12',12)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Toán 12',12)");
      await db.rawInsert(
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Tiếng Anh 12',12)");
      await db.execute('''
        CREATE TABLE tblStudent (
        studentId INTEGER PRIMARY KEY AUTOINCREMENT,
        fullName TEXT,
        address TEXT,
        imageLink TEXT,
        phone TEXT,
        subjectId INTEGER REFERENCES tblSubject(subjectId),
        gradeId INTEGER REFERENCES tblGrade(gradeId),
        createDate DATE
        )''');
      await db.execute('''
        CREATE TABLE tblNote (
        noteId INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        body TEXT,
        createDate DATE,
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
}
