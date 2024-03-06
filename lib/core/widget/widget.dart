import 'package:flutter/material.dart';
import 'package:getx_student_app/core/color/color.dart';
import 'package:google_fonts/google_fonts.dart';

//==================================================TextFormField====================================================================

class TextFormWidget extends StatelessWidget {
  const TextFormWidget({
    super.key,
    required this.label,
    this.controller,
    this.validator,
    required this.icon,
    this.suffixicon,
    this.suffixOnpress,
    this.obscurebool = false,
    this.onChanged,
    this.hintText,
    this.keyboardType,
  });
  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final IconData icon;
  final IconData? suffixicon;
  final void Function()? suffixOnpress;
  final void Function(String?)? onChanged;
  final bool obscurebool;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      style: const TextStyle(color: colorBlack),
      onChanged: onChanged,
      obscureText: obscurebool,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: colorWhite,
        suffixIcon: IconButton(
          onPressed: suffixOnpress,
          icon: Icon(suffixicon),
        ),
        prefixIcon: Icon(icon),
        labelText: label,
        hintText: hintText,
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff21209C),
            ),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))),
      ),
      validator: validator,
    );
  }
}

//============================================ElevatedBtn=========================================================

class ElevatedBtnWidget extends StatelessWidget {
  const ElevatedBtnWidget({
    super.key,
    required this.onPressed,
    required this.title,
  });
  final void Function()? onPressed;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        backgroundColor: colorAppColor,
      ),
      child: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class ImageUploadWidget extends StatelessWidget {
  const ImageUploadWidget({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
  });
  final void Function()? onTap;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.circular(21),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                blurRadius: 2,
                spreadRadius: 1)
          ],
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: colorAppColor.withOpacity(0.09),
              ),
              child: Icon(
                icon,
                size: 30,
                color: colorAppColor,
              ),
            ),
            Text(
              title,
              style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
