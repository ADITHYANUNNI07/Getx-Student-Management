import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:getx_student_app/db/sqflite.dart';
import 'package:getx_student_app/presentation/student_list/screen_student_list.dart';
import 'package:getx_student_app/provider/image%20picker/imagepicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const MaterialColor customPrimaryColor =
        MaterialColor(0xff21209C, <int, Color>{
      50: Color(0xff21209C),
      100: Color(0xff21209C),
      200: Color(0xff21209C),
      300: Color(0xff21209C),
      400: Color(0xff21209C),
      500: Color(0xff21209C),
      600: Color(0xff21209C),
      700: Color(0xff21209C),
      800: Color(0xff21209C),
      900: Color(0xff21209C),
    });
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ImagePickerController(),
        )
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: customPrimaryColor,
          scaffoldBackgroundColor: Colors.grey.shade100,
          primaryColor: const Color(0xff21209C),
          focusColor: const Color(0xff21209C),
          textTheme: GoogleFonts.poppinsTextTheme()
              .apply(bodyColor: Colors.white, displayColor: Colors.white),
        ),
        home: const StudentListScrn(),
      ),
    );
  }
}
