import 'package:flutter/material.dart';
import 'package:stdio_week_6/blocs/discover_page_bloc.dart';
import 'package:stdio_week_6/constants/my_color.dart';
import 'package:stdio_week_6/models/hotel.dart';
import 'package:stdio_week_6/pages/widgets/discover_hight_rated.dart';
import 'package:stdio_week_6/pages/widgets/discover_popular.dart';
import 'package:stdio_week_6/pages/widgets/discover_trending.dart';

class DiscoveTabbar extends StatefulWidget {
  const DiscoveTabbar({Key? key}) : super(key: key);

  @override
  State<DiscoveTabbar> createState() => _DiscoveTabbarState();
}

class _DiscoveTabbarState extends State<DiscoveTabbar> {
  final _discoverPageBloc = DiscoverPageBloc();
  @override
  void dispose() {
    super.dispose();
    _discoverPageBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Expanded(
        child: Column(
          children: [
            const TabBar(
              isScrollable: false,
              unselectedLabelColor: MyColor.grey,
              labelColor: MyColor.blue,
              labelPadding: EdgeInsets.symmetric(horizontal: 8),
              tabs: [
                Tab(text: 'Trending'),
                Tab(text: 'Popular'),
                Tab(text: 'Hight rated'),
              ],
            ),
            const SizedBox(height: 32),
            Flexible(
                child: SizedBox(
              height: 300,
              child: StreamBuilder<List<Hotel>>(
                  stream: _discoverPageBloc.stream,
                  initialData: const [],
                  builder: (context, snapshot) {
                    final hotels = snapshot.data!;
                    return TabBarView(children: [
                      DiscoverTrending(
                        hotels: hotels,
                      ),
                      DiscoverPopular(hotels: hotels),
                      DiscoverHightRated(hotels: hotels),
                    ]);
                  }),
            ))
          ],
        ),
      ),
    );
  }
}
