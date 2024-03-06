import 'package:getx_student_app/getx/snackbar/snackbar.dart';
import 'package:getx_student_app/model/student_model.dart';
import 'package:getx_student_app/presentation/add_student_details/screen_add_student_details.dart';
import 'package:getx_student_app/presentation/student_list/screen_student_list.dart';
import 'package:sqflite/sqflite.dart';

late Database db;
Future<void> initializeDatabase() async {
  db = await openDatabase(
    'student.db',
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE student (uid TEXT PRIMARY KEY, admissionNo INTEGER, studentname TEXT, rollNo INTEGER, class TEXT, phonenumber REAL, imagesrc)');
    },
  );
}

Future<void> addStudentDetailsToDB(StudentModel studentModel) async {
  final existingRecord = await db.query('student',
      where: 'admissionNo = ?', whereArgs: [studentModel.admissionNo]);
  if (existingRecord.isEmpty) {
    await db.insert('student', studentModel.toMap());
    SnackBarControllerClass().showSnackBar(
        title: 'Successfully Added.',
        content: 'Successfully add the student details');
    imagevaluenotifier.value = null;
    studentController.fetchStudentData();
  } else {
    SnackBarControllerClass().showSnackBar(
        title: 'Admission No', content: 'Admission No. is already present');
  }
}

Future<List<StudentModel>> getStudentListFromDB() async {
  final List<Map<String, dynamic>> studentDetails = await db.query('student');
  List<StudentModel> studentList = [];
  for (var eachstudent in studentDetails) {
    studentList.add(StudentModel.fromMap(eachstudent));
  }
  return studentList;
}

Future<void> deleteStudentListFormDB(StudentModel studentModel) async {
  final index = await db
      .delete('student', where: 'uid = ?', whereArgs: [studentModel.uid]);
  if (!index.isNaN) {
    SnackBarControllerClass().showSnackBar(
        title: 'Delete Successfully',
        content: 'Successfully delete the student details');

    studentController.fetchStudentData();
  }
}

Future<void> updateStudentListFormDB(StudentModel studentModel) async {
  final index = await db.update('student', studentModel.toMap(),
      where: 'uid = ?', whereArgs: [studentModel.uid]);
  if (!index.isNaN) {
    SnackBarControllerClass().showSnackBar(
        title: 'Successfully Updated',
        content: 'Successfully update the student details');

    studentController.fetchStudentData();
  }
}
