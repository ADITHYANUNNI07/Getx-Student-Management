import 'package:getx_student_app/db/sqflite.dart';
import 'package:getx_student_app/model/student_model.dart';

Future<void> addstudentDetailsFN(
    dynamic formKey, StudentModel studentModel) async {
  await addStudentDetailsToDB(studentModel);
}
