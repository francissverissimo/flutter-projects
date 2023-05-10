import "package:flutter/material.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Color?> barColorOptions;
  late List<Color?> textColorOptions;
  late List<Color?> backgroundColorOptions;
  late List<String> colors;
  late int currentOption;

  @override
  void initState() {
    super.initState();
    barColorOptions = [
      Colors.green[900],
      Colors.red[900],
      Colors.blue[900],
      Colors.orange[900],
      Colors.purple[900],
    ];

    textColorOptions = [
      Colors.green[800],
      Colors.red[800],
      Colors.blue[800],
      Colors.orange[800],
      Colors.purple[800],
    ];

    backgroundColorOptions = [
      Colors.green[50],
      Colors.red[50],
      Colors.blue[50],
      Colors.orange[50],
      Colors.purple[50],
    ];

    colors = ["Green", "Red", "Blue", "Orange", "Purple"];

    currentOption = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorOptions[currentOption],
      appBar: AppBar(
        title: const Text("Colors"),
        backgroundColor: barColorOptions[currentOption],
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              colors[currentOption],
              style: TextStyle(
                fontSize: 50,
                color: textColorOptions[currentOption],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  currentOption =
                      currentOption < colors.length - 1 ? ++currentOption : 0;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              child: const Text(
                "CHANGE",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
