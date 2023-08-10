import 'package:flutter/material.dart';
import 'package:pong/pixel/first.dart';

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
    return const FirstFlame();
    // return Scaffold(
    //   body: Center(
    //     child: SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           MaterialButton(
    //             onPressed: () {
    //               Navigator.of(context)
    //                   .push(MaterialPageRoute(builder: (BuildContext ctx) {
    //                 return const FirstFlame();
    //               }));
    //             },
    //             child: const Text('First Game'),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
