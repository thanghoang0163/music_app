import 'package:flutter/material.dart';
import 'package:music_app/audio_player_circular_progress.dart';
import 'package:music_app/progress_bar_and_play_each.dart';
import 'package:music_app/register_page.dart';
import 'package:music_app/login_page.dart';
import 'package:music_app/blocs/auth_bloc.dart';
import 'package:music_app/my_app.dart';



/*void main() {
  runApp(MyApp(
      new AuthBloc(),
      MaterialApp(
        home: HomePage(),
      )));
}*/
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: //LoginPage(),
      AudioPlayerCircularProgress(),
      //PlayEachInPlaylist(),
    );
  }
}



