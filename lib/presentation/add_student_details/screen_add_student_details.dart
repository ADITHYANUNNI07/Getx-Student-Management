// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_student_app/core/constant/constant.dart';
import 'package:getx_student_app/core/widget/widget.dart';
import 'package:getx_student_app/db/sqflite.dart';
import 'package:getx_student_app/provider/image%20picker/imagepicker.dart';
import 'package:getx_student_app/getx/snackbar/snackbar.dart';
import 'package:getx_student_app/model/student_model.dart';
import 'package:getx_student_app/presentation/add_student_details/functions/add_student_details_functions.dart';
import 'package:getx_student_app/presentation/add_student_details/widget/add_student_details_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

ValueNotifier<File?> imagevaluenotifier = ValueNotifier<File?>(null);

class AddStudentDetails extends StatelessWidget {
  final StudentModel? studentModel;
  AddStudentDetails({super.key, this.studentModel}) {
    if (studentModel != null) {
      int phone = studentModel!.phoneNo.toInt();
      nameeditingController.text = studentModel!.name;
      admissioneditingController.text = studentModel!.admissionNo.toString();
      rollNoeditingController.text = studentModel!.rollNo.toString();
      classeditingController.text = studentModel!.className;
      phoneNoeditingController.text = phone.toString();
      imagevaluenotifier.value = File(studentModel!.photoUrl);
    } else {
      imagevaluenotifier.value = null;
    }
  }
  GlobalKey<FormState> formKey = GlobalKey();
  final nameeditingController = TextEditingController();
  final admissioneditingController = TextEditingController();
  final rollNoeditingController = TextEditingController();
  final classeditingController = TextEditingController();
  final phoneNoeditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: const Color(0xff21209C),
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(studentModel == null
              ? 'Add Student Details'
              : 'Edit Student Details'),
        ),
        body: Consumer<ImagePickerController>(
          builder: (context, imageProviderModel, child) =>
              SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Container(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      ValueListenableBuilder(
                          valueListenable: imagevaluenotifier,
                          builder: (context, image, _) {
                            return Stack(
                              children: [
                                CircleAvatar(
                                    radius: size.width / 4,
                                    backgroundImage:
                                        image != null ? FileImage(image) : null,
                                    child: image == null
                                        ? const Icon(Icons.person)
                                        : null),
                                Positioned(
                                    bottom: 0,
                                    right: 10,
                                    child: InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          context: context,
                                          builder: (context) {
                                            return SizedBox(
                                              height: size.height / 3.5,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(18.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Select the Options',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 19,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                    const SizedBox(height: 15),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        ImageUploadWidget(
                                                          title: 'Gallery',
                                                          icon:
                                                              Icons.photo_album,
                                                          onTap: () async {
                                                            // final ImagePickerControllerClass
                                                            //     imagePickerControllerClass =
                                                            //     Get.put(
                                                            //         ImagePickerControllerClass());
                                                            // imagevaluenotifier
                                                            //         .value =
                                                            //     await imagePickerControllerClass
                                                            //         .selectImageFromGallaryOrCamera(
                                                            //             ImageSource
                                                            //                 .gallery);
                                                            imagevaluenotifier
                                                                    .value =
                                                                await imageProviderModel
                                                                    .selectImageFromGalleryOrCamera(
                                                              ImageSource
                                                                  .gallery,
                                                            );
                                                            Get.back();
                                                          },
                                                        ),
                                                        ImageUploadWidget(
                                                          title: 'Camera',
                                                          icon:
                                                              Icons.camera_alt,
                                                          onTap: () async {
                                                            imagevaluenotifier
                                                                    .value =
                                                                await imageProviderModel
                                                                    .selectImageFromGalleryOrCamera(
                                                                        ImageSource
                                                                            .camera);
                                                            Get.back();
                                                          },
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: const CircleAvatar(
                                        radius: 27,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: 25,
                                          child: Icon(Icons.camera),
                                        ),
                                      ),
                                    ))
                              ],
                            );
                          }),
                      AddStudentDetailsTextFormFieldWidget(
                        label: 'Name',
                        icon: Icons.person,
                        hintText: 'Eg. Alex F Mathew',
                        controller: nameeditingController,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please Enter the Name';
                          } else if (!RegExp(r'^[a-zA-Z ]+$')
                                  .hasMatch(value.trim()) ||
                              value.trim().length < 5) {
                            return 'Please Enter a Valid Name';
                          } else {
                            return null;
                          }
                        },
                      ),
                      AddStudentDetailsTextFormFieldWidget(
                        label: 'Admission No.',
                        icon: Icons.dynamic_feed,
                        hintText: 'Eg. 4156',
                        controller: admissioneditingController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please Enter the Admission No.';
                          } else if (!RegExp(r'^[0-9]+$')
                                  .hasMatch(value.trim()) ||
                              value.trim().length < 4) {
                            return 'Please Enter a Valid Admission No.';
                          } else {
                            return null;
                          }
                        },
                      ),
                      AddStudentDetailsTextFormFieldWidget(
                        label: 'Roll No.',
                        icon: Icons.data_array,
                        hintText: 'Eg. 1-50',
                        controller: rollNoeditingController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please Enter the Roll No.';
                          } else if (!RegExp(r'^[0-9]+$')
                              .hasMatch(value.trim())) {
                            return 'Please Enter a Valid Roll No.';
                          } else {
                            return null;
                          }
                        },
                      ),
                      AddStudentDetailsTextFormFieldWidget(
                        label: 'Class',
                        icon: Icons.class_,
                        hintText: 'Eg. 9A',
                        controller: classeditingController,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please Enter the Class';
                          } else if (value.trim().length < 2) {
                            return 'Please Enter a Valid Class name';
                          } else {
                            return null;
                          }
                        },
                      ),
                      AddStudentDetailsTextFormFieldWidget(
                        label: 'Phone No.',
                        icon: Icons.phone,
                        hintText: 'Eg. 9600012304',
                        controller: phoneNoeditingController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please Enter Phone No.';
                          } else if (!RegExp(r'^[0-9]+$')
                                  .hasMatch(value.trim()) ||
                              value.trim().length != 10) {
                            return 'Please Enter a Valid Phone No.';
                          } else {
                            return null;
                          }
                        },
                      ),
                      sizedHeight20,
                      SizedBox(
                        width: size.width,
                        height: 50,
                        child: ElevatedBtnWidget(
                            onPressed: () async {
                              if (imagevaluenotifier.value != null) {
                                if (formKey.currentState!.validate()) {
                                  final model = StudentModel(
                                      uid: studentModel == null
                                          ? const Uuid().v4()
                                          : studentModel!.uid,
                                      name: nameeditingController.text.trim(),
                                      admissionNo: int.parse(
                                          admissioneditingController.text
                                              .trim()),
                                      rollNo: int.parse(
                                          rollNoeditingController.text.trim()),
                                      className:
                                          classeditingController.text.trim(),
                                      phoneNo:
                                          phoneNoeditingController.text.trim(),
                                      photoUrl: imagevaluenotifier.value!.path);
                                  if (studentModel == null) {
                                    Get.back();
                                    await addstudentDetailsFN(formKey, model);
                                  } else {
                                    Get.back();
                                    await updateStudentListFormDB(model);
                                  }
                                }
                              } else {
                                SnackBarControllerClass().showSnackBar(
                                    title: 'Image',
                                    content: 'Please Select the Image',
                                    errorcolor: Colors.red);
                              }
                            },
                            title: studentModel == null
                                ? 'Add Student'.toUpperCase()
                                : 'Edit Student'.toUpperCase()),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      )),
    );
  }
}
