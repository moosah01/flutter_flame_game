// TODO Implement this library.import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flame_game/animationloader.dart';
import 'package:flutter_flame_game/game/game.dart';
import 'package:provider/provider.dart';
import 'main_game_runner.dart';

// void main() {
//   runApp(const MyAppGame());
// }
void main() {
  runApp(const MyApp());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);

  SystemChrome.setEnabledSystemUIOverlays([
    SystemUiOverlay.bottom,
    //  SystemUiOverlay.top, //This line is used for showing the bottom bar
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(child: animationLoader()),
    );
  }
}

// void main() {
//   runApp(const MyApp());

//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.landscapeRight,
//     DeviceOrientation.landscapeLeft,
//   ]);

//   SystemChrome.setEnabledSystemUIOverlays([
//     SystemUiOverlay.bottom,
//     //  SystemUiOverlay.top, //This line is used for showing the bottom bar
//   ]);
// }