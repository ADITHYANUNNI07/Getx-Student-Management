import 'package:get/get.dart';
import 'package:getx_student_app/db/sqflite.dart';
import 'package:getx_student_app/model/student_model.dart';

class StudentControllerClass extends GetxController {
  var studentList = <StudentModel>[].obs;
  var isLoaded = false.obs;

  void fetchStudentData() async {
    studentList.value = await getStudentListFromDB();
    isLoaded.value = true;
  }
}
