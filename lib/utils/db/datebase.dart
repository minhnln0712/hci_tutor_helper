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
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('1')");
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('2')");
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('3')");
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('4')");
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('5')");
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('6')");
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('7')");
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('8')");
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('9')");
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('10')");
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('11')");
      await db.rawInsert("INSERT INTO tblGrade(gradeName) VALUES('12')");
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
          "INSERT INTO tblSubject(subjectName,gradeId) VALUES('Tiếng Anh',3)");
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
