import 'package:doc_doc_front/views/chats_view.dart';
import 'package:doc_doc_front/widgets/navigation/bottom_navigation_bar.dart';
import 'package:doc_doc_front/widgets/navigation/persistent_tabs.dart';
import 'package:doc_doc_front/views/user_view.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PageController pageController = PageController();
  late int _currentIndex;
  List<Widget> pages = [];

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
    return MaterialApp(
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
    );
  }
}
