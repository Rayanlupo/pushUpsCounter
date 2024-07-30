import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Are you ready to work out??",
                style: const TextStyle(fontSize: 50),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 20),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Counter()),
                  );
                },
                child: const Text("Start",
                    style: TextStyle(fontSize: 40),
                    textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _upCounter = 0;
  final player = AudioPlayer();
  void _incrementUp() {
    setState(() {
      _upCounter++;
    });
    _playSound();
  }

  void _playSound() async {
    // Load and play the audio file
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
