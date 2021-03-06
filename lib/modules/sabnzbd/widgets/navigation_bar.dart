import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SABnzbdNavigationBar extends StatelessWidget {
  static List<ScrollController> scrollControllers =
      List.generate(icons.length, (_) => ScrollController());
  final PageController pageController;

  static const List<IconData> icons = [
    LunaIcons.queue,
    LunaIcons.history,
  ];

  static const List<String> titles = [
    'Queue',
    'History',
  ];

  SABnzbdNavigationBar({
    Key key,
    @required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBottomNavigationBar(
      pageController: pageController,
      scrollControllers: scrollControllers,
      icons: icons,
      titles: titles,
    );
  }
}
