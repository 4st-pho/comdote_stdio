import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stdio_week_6/pages/bookmark/bookmark_page.dart';
import 'package:stdio_week_6/pages/discover/discover_page.dart';
import 'package:stdio_week_6/pages/home/home_page.dart';
import 'package:stdio_week_6/pages/profile/profile_page.dart';

class MainPageBloc {
  int index = 0;
  final List<Widget> pages = const [
    HomePage(),
    DiscoverPage(),
    BookmarkPage(),
    ProfilePage()
  ];
  final _controller = StreamController<int>();
  Stream<int> get stream => _controller.stream;

  void selectPage(
      {required int pageIndex, required PageController pageController}) {
    index = pageIndex;
    _controller.sink.add(index);
    pageController.jumpToPage(pageIndex);
  }

  MainPageBloc() {
    _controller.sink.add(index);
  }
  void dispose() {
    _controller.close();
  }
}
