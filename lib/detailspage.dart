// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';

class DetailsPage extends StatelessWidget {
  final String imgUrl;
  const DetailsPage({super.key, required this.imgUrl});

  void _share(String imgUrl) {}

  void _setHomeScreen(String imgUrl) {}

  void _setLockScreen(String imgUrl) async {
    try {
      var location = WallpaperManager.LOCK_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(imgUrl);

      await WallpaperManager.setWallpaperFromFile(file.path, location);
      Fluttertoast.showToast(msg: "Saved Successfully ");
    } catch (e) {}
  }

  Future<void> _download(String url) async {
  //  try {
      // var imageId =
      //     await ImageDownloader.downloadImage(imgUrl).catchError((error) {
      //   if (error is PlatformException) {
      //     var path = "";
      //     if (error.code == "404") {
      //       Fluttertoast.showToast(msg: 'Image Not Found');
      //     } else if (error.code == "unsupported_file") {
      //       Fluttertoast.showToast(msg: 'Unsupported File');
      //     }
      //   }
      // });
      // if (imageId == null) {
      //   return;
      // } else {
      //   var path = await ImageDownloader.findPath(imageId);
      //   Fluttertoast.showToast(msg: 'Image saved to : $path');
      // }
    //} catch (e) {
    //  Fluttertoast.showToast(msg: 'failed');
  //  }

 try {
      var imageId =
          await ImageDownloader.downloadImage(url).catchError((error) {
        if (error is PlatformException) {
          var path = "";
          if (error.code == "404") {
            Fluttertoast.showToast(msg: 'Not Found Error.');
          } else if (error.code == "unsupported_file") {
            Fluttertoast.showToast(msg: 'UnSupported FIle Error.');
            path = error.details["unsupported_file_path"];
          }
        }
      });
      if (imageId == null) {
        return;
      } else {
        var path = await ImageDownloader.findPath(imageId);
        Fluttertoast.showToast(msg: 'image saved to: $path');
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'failed',
      );
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
      ),
      body: Column(
        children: [
          Text("Details Page"),
          Expanded(child: Center(child: Image(image: AssetImage(imgUrl)))),
        ],
      ),
      floatingActionButton: SpeedDial(
        speedDialChildren: [
          SpeedDialChild(
              label: "Download",
              child: Icon(
                Icons.download,
                color: Colors.red,
              ),
              onPressed: () {
                _download(imgUrl);
              }),
          SpeedDialChild(
              label: 'Share',
              child: Icon(
                Icons.share,
                color: Colors.red,
              ),
              onPressed: () {
                _share(imgUrl);
              }),
          SpeedDialChild(
              label: 'Set as HomeScreen',
              child: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              onPressed: () {
                _setHomeScreen(imgUrl);
              }),
          SpeedDialChild(
              label: 'Set as LockScreen',
              child: Icon(
                Icons.screen_lock_landscape,
                color: Colors.red,
              ),
              onPressed: () {
                _setLockScreen(imgUrl);
              })
        ],
        child: Icon(Icons.add),
      ),
    );
  }
}
