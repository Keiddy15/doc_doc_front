import 'package:flutter/material.dart';

class PersistentTabs extends StatelessWidget {
  const PersistentTabs({
    Key? key,
    required this.screenWidgets,
    required this.currentTabIndex,
  }) : super(key: key);

  final int currentTabIndex;
  final List<Widget> screenWidgets;

  List<Widget> _buildOffstageWidgets() {
    return screenWidgets
        .map(
          (widget) => Offstage(
            offstage: currentTabIndex != screenWidgets.indexOf(widget),
            child: Navigator(
              onGenerateRoute: (routeSettings) {
                return MaterialPageRoute(builder: (_) => widget);
              },
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _buildOffstageWidgets(),
    );
  }
}
