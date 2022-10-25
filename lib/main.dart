import 'package:doc_doc_front/app.dart';
import 'package:doc_doc_front/firebase_options.dart';
import 'package:doc_doc_front/views/home_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  runApp(token == null ? const HomeView() : const MyApp());
}
