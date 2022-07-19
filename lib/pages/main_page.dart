import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stdio_week_6/blocs/main_page_bloc.dart';
import 'package:stdio_week_6/constants/assets_icon.dart';
import 'package:stdio_week_6/constants/const_string.dart';
import 'package:stdio_week_6/constants/my_color.dart';
import 'package:stdio_week_6/models/user.dart';
import 'package:stdio_week_6/pages/offline/offline_page.dart';
import 'package:stdio_week_6/services/network/network_service.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _mainPageBloc = MainPageBloc();
  final _pageController = PageController(initialPage: 0);

  BottomNavigationBarItem buildBottomNavigationBarItem(
      {required int index,
      required int curentIndex,
      required String icon,
      required String activeIcon,
      required String label}) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child:
            Image.asset(index == curentIndex ? activeIcon : icon, height: 24),
      ),
      label: label,
    );
  }

  @override
  void initState() {
    super.initState();
    resetUser();
  }

  @override
  void dispose() {
    super.dispose();
    _mainPageBloc.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final networkStatus = context.watch<NetworkStatus>();
    return Scaffold(
      body: networkStatus == NetworkStatus.online
          ? PageView(
            controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: _mainPageBloc.pages,
            )
          : const OfflinePage(),
      bottomNavigationBar: StreamBuilder<int>(
        stream: _mainPageBloc.stream,
        initialData: 0,
        builder: (context, snapshot) {
          final currentIndex = snapshot.data!;
          return BottomNavigationBar(
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            backgroundColor: MyColor.background,
            currentIndex: currentIndex,
            selectedItemColor: MyColor.blue,
            unselectedItemColor: MyColor.grey,
            selectedFontSize: 14,
            unselectedFontSize: 14,
            onTap: (pageIndex) {
              _mainPageBloc.selectPage(
                  pageIndex: pageIndex, pageController: _pageController);
            },
            items: _buildListBottomNavigationBarItem(currentIndex),
          );
        },
      ),
    );
  }

  List<BottomNavigationBarItem> _buildListBottomNavigationBarItem(
      int currentIndex) {
    return [
      buildBottomNavigationBarItem(
        index: 0,
        curentIndex: currentIndex,
        icon: AssetsIcon.home,
        activeIcon: AssetsIcon.homeActive,
        label: ConstString.home,
      ),
      buildBottomNavigationBarItem(
        index: 1,
        curentIndex: currentIndex,
        icon: AssetsIcon.search,
        activeIcon: AssetsIcon.searchActive,
        label: ConstString.discover,
      ),
      buildBottomNavigationBarItem(
        index: 2,
        curentIndex: currentIndex,
        icon: AssetsIcon.book,
        activeIcon: AssetsIcon.bookActive,
        label: ConstString.bookmark,
      ),
      buildBottomNavigationBarItem(
        index: 3,
        curentIndex: currentIndex,
        icon: AssetsIcon.user,
        activeIcon: AssetsIcon.userActive,
        label: ConstString.profile,
      ),
    ];
  }
}
