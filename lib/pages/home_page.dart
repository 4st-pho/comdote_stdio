import 'package:flutter/material.dart';
import 'package:stdio_week_6/blocs/home_page_bloc.dart';
import 'package:stdio_week_6/constants/assets_image.dart';
import 'package:stdio_week_6/constants/const_string.dart';
import 'package:stdio_week_6/constants/my_color.dart';
import 'package:stdio_week_6/constants/shimmer_loading.dart';
import 'package:stdio_week_6/models/hotel.dart';
import 'package:stdio_week_6/pages/widgets/home_bar.dart';
import 'package:stdio_week_6/pages/widgets/hotel_card.dart';
import 'package:stdio_week_6/widgets/hotel_card_shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homePageBloc = HomePageBloc();
  ScrollController controller = ScrollController();
  void _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      _homePageBloc.fetchNextHotels();
    }
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    _homePageBloc.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [_buildSliverAppBar(context)];
      },
      body: StreamBuilder<List<Hotel>>(
        stream: _homePageBloc.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return ShimmerLoading.listHotelCard;
          }
          List<Hotel> listHotel = snapshot.data!;
          if (listHotel.isEmpty) {
            return Center(
                child: Image.asset(
              AssetsImage.emptyList,
              fit: BoxFit.contain,
            ));
          }
          return RefreshIndicator(
            onRefresh: () async => _homePageBloc.init(),
            child: ListView.builder(
              controller: controller,
              padding: const EdgeInsets.all(16),
              itemCount: listHotel.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == _homePageBloc.hotelList.length) {
                  return _homePageBloc.hasMore
                      ? const HotelCardShimmer()
                      : const Text(
                          ConstString.noMoreDataToLoad,
                          textAlign: TextAlign.center,
                        );
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: HotelCard(hotel: listHotel[index]),
                );
              },
            ),
          );
        },
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      title: HomeBar(context: context),
      toolbarHeight: 80,
      pinned: true,
      backgroundColor: MyColor.background,
    );
  }
}
