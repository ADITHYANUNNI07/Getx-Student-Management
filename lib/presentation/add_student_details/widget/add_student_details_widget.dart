import 'package:flutter/material.dart';
import 'package:getx_student_app/core/color/color.dart';
import 'package:getx_student_app/core/constant/constant.dart';
import 'package:getx_student_app/core/widget/widget.dart';

class AddStudentDetailsTextFormFieldWidget extends StatelessWidget {
  const AddStudentDetailsTextFormFieldWidget({
    super.key,
    required this.label,
    this.hintText,
    this.controller,
    this.validator,
    this.onChanged,
    required this.icon,
    this.keyboardType,
  });
  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final IconData icon;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: colorAppColor,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        sizedHeight10,
        TextFormWidget(
          label: label,
          icon: icon,
          keyboardType: keyboardType,
          hintText: hintText,
          controller: controller,
          validator: validator,
          onChanged: onChanged,
        )
      ],
    );
  }
}
