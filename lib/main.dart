import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wallpaper/page/wallpaper_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.dark,
          darkTheme: ThemeData(
            brightness: Brightness.dark,
          ),
          home: WallpaperPage(),
        );
      },
    );
  }
}
