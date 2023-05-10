import "package:flutter/material.dart";
import "home.dart";

class MyColors extends StatelessWidget {
  const MyColors({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Colors",
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
