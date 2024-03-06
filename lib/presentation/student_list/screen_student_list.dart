import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:getx_student_app/core/color/color.dart';
import 'package:getx_student_app/core/constant/constant.dart';
import 'package:getx_student_app/core/widget/widget.dart';
import 'package:getx_student_app/getx/dialog/dialog.dart';
import 'package:getx_student_app/getx/student/student_getx.dart';
import 'package:getx_student_app/model/student_model.dart';
import 'package:getx_student_app/presentation/add_student_details/screen_add_student_details.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

final StudentControllerClass studentController =
    Get.put(StudentControllerClass());

class StudentListScrn extends StatelessWidget {
  const StudentListScrn({super.key});

  @override
  Widget build(BuildContext context) {
    studentController.fetchStudentData();
    final searchController = TextEditingController();
    DateTime now = DateTime.now();
    int currentHour = now.hour;
    String? greeting;
    if (currentHour >= 0 && currentHour < 12) {
      greeting = 'Good Morning ☀️';
    } else if (currentHour >= 12 && currentHour < 17) {
      greeting = 'Good Afternoon 🌤️';
    } else if (currentHour >= 17 && currentHour < 21) {
      greeting = 'Good Evening 🌙';
    } else {
      greeting = 'Good Night 🌜';
    }
    final size = MediaQuery.of(context).size;
    return Container(
      color: const Color(0xff21209C),
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xff21209C),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                padding: const EdgeInsets.all(18),
                width: size.width,
                child: Column(
                  children: [
                    const Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'Hello,',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        greeting,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    sizedHeight10,
                    TextFormWidget(
                      label: 'Search',
                      hintText: 'Enter Student Name Or RollNo',
                      icon: Icons.search,
                      controller: searchController,
                      onChanged: (value) {
                        studentController.fetchStudentData();
                      },
                    )
                  ],
                ),
              ),
              Obx(() {
                if (!studentController.isLoaded.value) {
                  return const Expanded(
                      child: Center(
                          child: CircularProgressIndicator(
                    strokeWidth: 3,
                  )));
                } else if (studentController.studentList.isEmpty) {
                  return const Expanded(
                      child: Center(
                    child: Text(
                      'Oops! Please add Student Details',
                      style: TextStyle(color: colorAppColor, fontSize: 16),
                    ),
                  ));
                } else {
                  List<StudentModel> filteredList = [];
                  if (searchController.text.isNotEmpty) {
                    filteredList =
                        studentController.studentList.where((student) {
                      final query = searchController.text.toLowerCase();
                      return student.name.toLowerCase().contains(query) ||
                          student.rollNo.toString().contains(query);
                    }).toList();
                  } else {
                    filteredList = studentController.studentList;
                  }
                  return Expanded(
                    child: ListView(
                        children: List.generate(
                      filteredList.length,
                      (index) => InkWell(
                        onLongPress: () => DialogBoxControllerClass()
                            .showDialogBox(filteredList[index]),
                        child: Slidable(
                          startActionPane: ActionPane(
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                foregroundColor: Colors.white,
                                backgroundColor: colorAppColor,
                                label: 'Edit',
                                icon: LineAwesomeIcons.edit,
                                spacing: 5,
                                borderRadius: BorderRadius.circular(9),
                                onPressed: (context) {
                                  Get.to(
                                    () => AddStudentDetails(
                                      studentModel: filteredList[index],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Container(
                                  height: size.height * 0.2,
                                  decoration: BoxDecoration(
                                    color: colorWhite,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: size.width,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: size.height * 0.2,
                                        width: 5,
                                        decoration: BoxDecoration(
                                          color: Colors.accents[index],
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Colors.accents[index]
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                filteredList[index].name,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        Colors.accents[index]),
                                              ),
                                            ),
                                            sizedHeight5,
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Colors
                                                    .accents[15 - index]
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                'RollNo : ${filteredList[index].rollNo}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        Colors.accents[index]),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: CircleAvatar(
                                          radius: 50,
                                          backgroundImage: FileImage(File(
                                              studentController
                                                  .studentList[index]
                                                  .photoUrl)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )),
                  );
                }
              })
            ],
          ),
          floatingActionButton: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green, width: 4.0),
              borderRadius: BorderRadius.circular(35.0),
            ),
            child: FloatingActionButton(
              onPressed: () {
                Get.to(() => AddStudentDetails());
              },
              child: const Icon(Icons.person_add),
            ),
          ),
        ),
      ),
    );
  }
}
