import 'package:flutter/material.dart';
import 'package:pong/pixel/pixel.dart';
import 'package:pong/pong/pong.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // return const PongFlame();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MaterialButton(
                color: Colors.greenAccent,
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext ctx) {
                    return const PixelFlame();
                  }));
                },
                child: const Text('Pixel Game'),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                color: Colors.amberAccent,
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext ctx) {
                    return const PongFlame();
                  }));
                },
                child: const Text('Pong Game'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
