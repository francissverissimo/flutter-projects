import 'dart:io';

import 'package:flutter/material.dart';
import 'package:istragaum/services/image_service.dart';
import 'package:istragaum/widgets/camera_view.dart';
import 'package:istragaum/widgets/image_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<String>> images;

  @override
  void initState() {
    super.initState();
    ImageService service = ImageService();
    images = service.retrieveImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Istragaum',
          style: TextStyle(
            fontFamily: 'Billabong',
            color: Colors.black,
            fontSize: 35,
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: ClipRRect(
            child: const Image(
              image: AssetImage('images/default-profile.png'),
            ),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        elevation: 0,
        bottom: PreferredSize(
          child: Container(
            color: Colors.black26,
            height: 1,
          ),
          preferredSize: const Size.fromHeight(1),
        ),
      ),
      body: Container(
        height: 500,
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
        child: FutureBuilder(
          future: images,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<String>? imgList = snapshot.data as List<String>;

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                ),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ImagePage(imgList, index),
                      ),
                    );
                  },
                  child: Image.file(
                    File(imgList[index]),
                    fit: BoxFit.cover,
                  ),
                ),
                itemCount: imgList.length,
              );
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CameraView(),
            ),
          ),
        },
        tooltip: 'Tirar foto',
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
