import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Push-ups counter')),
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: 100.0, left: 20.0, right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Are you ready to work out??",
                style: const TextStyle(fontSize: 40),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StandardCounter()),
                  );
                },
                child: const Text("Start",
                    style: TextStyle(fontSize: 40),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: 20),
              TextButton(
                  style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 30)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TimerCounter()),
                    );
                  },
                  child: const Text(
                    "Paused push-ups ",
                    style: TextStyle(fontSize: 40),
                    textAlign: TextAlign.center,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class StandardCounter extends StatefulWidget {
  const StandardCounter({Key? key}) : super(key: key);

  @override
  State<StandardCounter> createState() => _CounterState();
}

class _CounterState extends State<StandardCounter> {
  int _upCounter = 0;
  final player = AudioPlayer();
  void _incrementUp() {
    setState(() {
      _upCounter++;
    });
    _playSound();
  }

  void _playSound() async {
    
    await player.play(AssetSource('sound.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Counter")),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          GestureDetector(
              onTap: _incrementUp,
              child: Container(
                width: 3000,
                height: 500,
                child: Container(
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      '$_upCounter',
                      style: TextStyle(fontSize: 100, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ))
        ])));
  }
}

class TimerCounter extends StatefulWidget {
  const TimerCounter({Key? key}) : super(key: key);

  @override
  State<TimerCounter> createState() => _TimerState();
}

class _TimerState extends State<TimerCounter> {
  int _upCounter = 0;
  late Timer _timer;
  int _timerDuration = 5;

  int _currentSeconds = 0;

  int _currentCentiseconds = 0;
  Color _currentColor = Colors.red;
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  final player = AudioPlayer();
  void _incrementUp() {
    setState(() {
      _upCounter++;
    });
    _playSound();
  }

  void _startTimer() {
    _timer?.cancel(); 

    setState(() {
      _currentColor = Colors.red;
      _currentSeconds = _timerDuration;
      _currentCentiseconds = 0;
    });

    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      if (_currentSeconds > 0 || _currentCentiseconds > 0) {
        setState(() {
          if (_currentCentiseconds > 0) {
            _currentCentiseconds--;
          } else {
            _currentCentiseconds = 99;
            _currentSeconds--;
          }
        });
      } else {
        _changeColor();
        _timer?.cancel(); 
      }
    });
  }

  void _changeColor() {
    setState(() {
      _currentColor = Colors.green;
    });
  }

  void _playSound() async {
    
    await player.play(AssetSource('sound.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Counter")),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Time: ${_currentSeconds}s',
            style: TextStyle(fontSize: 40, color: Colors.black),
          ),
          const SizedBox(height: 20),
          GestureDetector(
              onTap: _incrementUp,
              child: Container(
                width: 3000,
                height: 500,
                child: Container(
                  color: Colors.red,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Time: ${_currentSeconds}:${_currentCentiseconds.toString().padLeft(2, '0')}',
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                        SizedBox(height: 20),
                        Text(
                          '$_upCounter',
                          style: TextStyle(fontSize: 100, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ))
        ])));
  }
}
