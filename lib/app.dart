import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_doc_front/providers/chat_provider.dart';
import 'package:doc_doc_front/views/chats_view.dart';
import 'package:doc_doc_front/widgets/navigation/bottom_navigation_bar.dart';
import 'package:doc_doc_front/widgets/navigation/persistent_tabs.dart';
import 'package:doc_doc_front/views/user_view.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PageController pageController = PageController();
  late int _currentIndex;
  List<Widget> pages = [];
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  void setCurrentIndex(int val) {
    setState(() {
      _currentIndex = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    pages = <Widget>[
      const ChatsView(),
      const UserView(),
    ];
    return MultiProvider(
        providers: [
          Provider<ChatProvider>(
              create: (_) => ChatProvider(
                  firebaseStorage: firebaseStorage,
                  firebaseFirestore: firebaseFirestore))
        ],
        child: MaterialApp(
          color: const Color(0xFF00CEC9),
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: const Color(0xFF00CEC9),
            extendBody: true,
            body: PersistentTabs(
              currentTabIndex: _currentIndex,
              screenWidgets: pages,
            ),
            bottomNavigationBar: SafeArea(
              child: BottomNavigationComponent(
                index: _currentIndex,
                onTapFunction: setCurrentIndex,
              ),
            ),
          ),
          themeMode: ThemeMode.dark,
        ));
  }
}
