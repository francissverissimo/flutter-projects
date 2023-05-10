import 'dart:io';
import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget {
  final List<String> imgList;
  final int index;
  ImagePage(this.imgList, this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.file(File(imgList[index])),
      ),
    );
  }
}
