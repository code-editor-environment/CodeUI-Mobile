import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'splash_screen/splash_demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        useInheritedMediaQuery: false,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const MyHomePage(),
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x001c1c1c),
      body: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors
              .transparent, // Set the button background color to transparent
          elevation: 0, // Remove the button shadow
          padding: EdgeInsets.zero, // Remove default button padding
          // Reduce the button's tap target size
        ),
        onPressed: () {
          Get.to(FakeSplashWidget());
        },
        child: Center(
          child: Image.asset("assets/images/logo.png"),
        ),
      ),
    );
  }
}
