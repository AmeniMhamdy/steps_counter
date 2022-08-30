import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steps_counter/providers/count.dart';
import 'package:steps_counter/tapbar.dart';

Future main() async {
  //WidgetsFlutterBinding.ensureInitialized;
  //Firebase.initializeApp;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Count()),
      ],
      child: MaterialApp(
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
        title: "Foot step Counter",
      ),
    ),
  );
}
