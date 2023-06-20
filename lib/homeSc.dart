import 'dart:async';

import 'package:flutter/material.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  bool startwatch = true;
  bool splitwatch = true;
  bool retsetwatch = true;
  String stoptimetodisp = '00.00.00.00';
  var swatch = Stopwatch();
  final dur = const Duration(seconds: 1);
  List<String> splitTimes = [];
  bool isRunning = false;
  Color buttonColor = Colors.greenAccent;
  String buttonText = 'Start';

  void starttimer() {
    Timer(dur, keeprunning);
  }

  void keeprunning() {
    if (swatch.isRunning) {
      starttimer();
    }
    setState(() {
      stoptimetodisp = swatch.elapsed.inHours.toString().padLeft(2, "") +
          ":" +
          (swatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inSeconds % 60).toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inMicroseconds % 60).toString().padLeft(2, "0");
    });
  }

  void startstopwatch() {
    setState(() {
      splitwatch = false;
      startwatch = false;
      buttonText = 'Push';
      buttonColor = Colors.pinkAccent;
      isRunning = true;
    });
    swatch.start();
    starttimer();
  }

  void splitstopwatch() {
    setState(() {
      splitwatch = true;
      retsetwatch = false;
    });
    swatch.stop();
    splitTimes.add(swatch.elapsed.toString());
  }

  void resetstopwatch() {
    setState(() {
      startwatch = true;
      retsetwatch = true;
      buttonText = 'Start';
    });
    swatch.reset();
    stoptimetodisp = '00.00.00.00';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Text(
                stoptimetodisp,
                style: TextStyle(fontSize: 70, fontWeight: FontWeight.w900),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 150.0),
              child: Text(
                stoptimetodisp,
                style: TextStyle(
                    fontSize: 30, color: Color.fromARGB(255, 244, 157, 6)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (startwatch) {
                      startstopwatch();
                    } else {
                      swatch.stop();
                    }
                  },
                  // startwatch ? startstopwatch : null,
                  child: Text(
                    buttonText,
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.greenAccent),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.pinkAccent;
                        }
                        return null;
                      },
                    ),
                    fixedSize: MaterialStatePropertyAll(Size(110, 110)),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: splitwatch ? null : splitstopwatch,
                  child: Text(
                    'Split',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    // primary: const Color.fromARGB(255, 1, 105, 95),
                    primary: Colors.orangeAccent,
                    fixedSize: const Size(110, 110),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: retsetwatch ? null : resetstopwatch,
                  child: Text(
                    'Reset',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(110, 110),
                      primary: Colors.blueAccent),
                ),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: splitTimes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      '# ${index + 1}' + '            ' + splitTimes[index],
                      style: TextStyle(color: Colors.pinkAccent, fontSize: 24),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
