import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(StopwatchApp());

class StopwatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StopwatchHomePage(),
    );
  }
}

class StopwatchHomePage extends StatefulWidget {
  @override
  _StopwatchHomePageState createState() => _StopwatchHomePageState();
}

class _StopwatchHomePageState extends State<StopwatchHomePage> {
  Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  List<String> _splitTimes = [];

  void _startTimer() {
    _stopwatch.start();
    _timer = Timer.periodic(Duration(milliseconds: 10), (_) {
      setState(() {});
    });
  }

  void _splitTimer() {
    _splitTimes.add(_stopwatch.elapsed.toString());
  }

  void _stopTimer() {
    _stopwatch.stop();
    _timer?.cancel();
    _splitTimes.clear();
  }

  @override
  void dispose() {
    _stopwatch.stop();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime =
        (_stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, '0') +
            ':' +
            (_stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0') +
            '.' +
            (_stopwatch.elapsed.inMilliseconds % 1000 ~/ 10)
                .toString()
                .padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(16.0),
            child: Text(
              formattedTime,
              style: TextStyle(fontSize: 48.0),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: _stopwatch.isRunning ? null : _startTimer,
                child: Text('Start'),
              ),
              ElevatedButton(
                onPressed: _stopwatch.isRunning ? _splitTimer : null,
                child: Text('Split'),
              ),
              ElevatedButton(
                onPressed: _stopwatch.isRunning ? _stopTimer : null,
                child: Text('Stop'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _splitTimes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Split ${index + 1}'),
                  subtitle: Text(_splitTimes[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
