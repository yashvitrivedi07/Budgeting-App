import 'package:budget_tracker_app/pages/get_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main()
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => child!,
      child: GetMaterialApp(
        theme: ThemeData(
          colorSchemeSeed: Colors.white
        ),
        debugShowCheckedModeBanner: false,
        getPages: GetPages.pages,
      ),
    );
  }
}