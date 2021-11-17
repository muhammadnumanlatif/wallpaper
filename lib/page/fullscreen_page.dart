import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class FullScreenPage extends StatefulWidget {
  final String? imageUrl;
  const FullScreenPage({Key? key, this.imageUrl}) : super(key: key);

  @override
  _FullScreenPageState createState() => _FullScreenPageState();
}

class _FullScreenPageState extends State<FullScreenPage> {
  Future<void> setWallpaper() async {

    try {
      int location = WallpaperManager
          .BOTH_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(widget.imageUrl.toString());
      final bool result =
      await WallpaperManager.setWallpaperFromFile(file.path, location);

      print(result);
    } on PlatformException{
      print("Error");

    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: Padding(
          padding:  EdgeInsets.all(5.sp),
          child: Column(
            children: [
              Expanded(child: Container(child: Image.network(widget.imageUrl.toString()),)),
              MaterialButton(
                onPressed: () {
                  setWallpaper();
                  Navigator.pop(context);
                  },
                minWidth: double.infinity,
                height: 6.h,
                elevation: 25,
                color: Colors.deepOrangeAccent,
                // textColor: Colors.black,
                child: Text(
                  "Set Wallpaper",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
