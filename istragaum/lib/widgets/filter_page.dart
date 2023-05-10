import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:istragaum/services/image_service.dart';
import 'package:istragaum/widgets/filters.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FilterPage extends StatefulWidget {
  XFile img;
  FilterPage({Key? key, required this.img}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final controller = PageController();
  final key = GlobalKey();
  final List<List<double>> filters = [
    noFilter,
    greyscaleMatrix,
    sepiaMatrix,
    vintageMatrix,
    sweetMatrix
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Image image = Image.file(
      File(widget.img.path),
      fit: BoxFit.cover,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Escolha um filtro'),
        centerTitle: true,
        backgroundColor: Colors.pink,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () async {
              double pixelRatio = MediaQuery.of(context).devicePixelRatio;
              final boundary = key.currentContext?.findRenderObject()
                  as RenderRepaintBoundary?;
              final image = await boundary?.toImage(pixelRatio: pixelRatio);
              final byteData =
                  await image?.toByteData(format: ImageByteFormat.png);
              final imageBytes = byteData?.buffer.asUint8List();

              ImageService service = ImageService();
              await service.saveImage(imageBytes);

              Navigator.pushNamed(context, '/home');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: RepaintBoundary(
                key: key,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: size.width,
                    maxHeight: size.width,
                  ),
                  child: PageView.builder(
                    controller: controller,
                    itemCount: filters.length,
                    itemBuilder: (context, index) {
                      return ColorFiltered(
                        colorFilter: ColorFilter.matrix(filters[index]),
                        child: image,
                      );
                    },
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            SmoothPageIndicator(
              controller: controller,
              count: filters.length,
              effect: const WormEffect(
                dotColor: Colors.grey,
                activeDotColor: Colors.pink,
              ),
              onDotClicked: (index) {},
            ),
          ],
        ),
      ),
    );
  }
}
