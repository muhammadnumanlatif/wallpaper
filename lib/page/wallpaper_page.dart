import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper/page/fullscreen_page.dart';

class WallpaperPage extends StatefulWidget {
  const WallpaperPage({Key? key}) : super(key: key);

  @override
  _WallpaperPageState createState() => _WallpaperPageState();
}

class _WallpaperPageState extends State<WallpaperPage> {
  List images = [];
  int page = 1;
  String url = 'https://api.pexels.com/v1/curated?per_page=8';
  //  String url = 'https://api.pexels.com/videos/popular?per_page=8';


  String YOUR_KEY = '563492ad6f91700001000001ecc0ac4872114e46bffde2dea20d3c16';
  @override
  void initState() {
    super.initState();
    fetchapi();
  }

  fetchapi() async {
    await http.get(Uri.parse(url), headers: {'Authorization': YOUR_KEY}).then(
        (value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result['photos'];
      });
      print(images[0]);
    });
  }

  loadmore() async {
    setState(() {
      page = page + 1;
    });
    await http.get(Uri.parse(url + "&page=" + page.toString()),
        headers: {'Authorization': YOUR_KEY}).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result['photos']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MaterialButton(
              onPressed: () {},
              minWidth: double.infinity,
              height: 6.h,
              elevation: 25,
              color: Colors.deepOrangeAccent,
              // textColor: Colors.black,
              child: Text(
                "Wallpapers",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: images.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 3,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FullScreenPage(
                                  imageUrl: images[index]['src']['large2x'])));
                    },
                    child: Container(
                      color: Colors.deepOrange,
                      child: Image.network(
                        images[index]['src']['tiny'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            MaterialButton(
              onPressed: () => loadmore(),
              minWidth: double.infinity,
              height: 6.h,
              elevation: 25,
              color: Colors.deepOrangeAccent,
              // textColor: Colors.black,
              child: Text(
                "Load More...",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
