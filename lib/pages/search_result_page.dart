import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stdio_week_6/blocs/search_result_page_bloc.dart';
import 'package:stdio_week_6/blocs/switch_list_type_bloc.dart';
import 'package:stdio_week_6/constants/assets_icon.dart';
import 'package:stdio_week_6/constants/assets_image.dart';
import 'package:stdio_week_6/constants/my_color.dart';
import 'package:stdio_week_6/constants/my_font.dart';
import 'package:stdio_week_6/models/hotel.dart';
import 'package:stdio_week_6/pages/hotel_detail_page.dart';
import 'package:stdio_week_6/pages/offline_page.dart';
import 'package:stdio_week_6/pages/widgets/search_result_item.dart';
import 'package:stdio_week_6/widgets/custom_loading.dart';

import '../services/network/network_service.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({Key? key, required this.keywork}) : super(key: key);
  final String keywork;

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage>
    with TickerProviderStateMixin {
  final _switchListTypeBloc = SwitchListTypeBloc();
  late AnimationController _animationController;
  final _searchResultPageBloc = SearchResultPageBloc();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _switchListTypeBloc.dispose();
    _searchResultPageBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final networkStatus = context.watch<NetworkStatus>();
    _searchResultPageBloc.init(widget.keywork);
    return StreamBuilder<bool>(
      stream: _switchListTypeBloc.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CustomLoading();
        }
        final isGrid = snapshot.data!;

        return Scaffold(
          appBar: _buildAppBar(context, isGrid),
          body: StreamBuilder<List<Hotel>>(
            stream: _searchResultPageBloc.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CustomLoading();
              }
              final hotels = snapshot.data!;
              if (networkStatus == NetworkStatus.offline) {
                return const OfflinePage();
              }
              if (hotels.isEmpty) {
                return Center(
                    child: Image.asset(
                  AssetsImage.noResultFound,
                  fit: BoxFit.contain,
                ));
              }
              return _buildContent(hotels, isGrid);
            },
          ),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context, bool isGrid) {
    return AppBar(
      leading: IconButton(
          icon: Image.asset(
            AssetsIcon.arrowBack,
            height: 24,
          ),
          onPressed: () => Navigator.of(context).pop()),
      title: Text(
        'Results for "${widget.keywork.trim()}"',
        style: MyFont.blackTitle,
      ),
      actions: [
        Align(
          child: InkWell(
            onTap: () {
              if (isGrid) {
                _animationController.reverse();
                _switchListTypeBloc.toggleListType();
              } else {
                _animationController.forward();
                _switchListTypeBloc.toggleListType();
              }
            },
            child: AnimatedIcon(
                icon: AnimatedIcons.list_view, progress: _animationController),
          ),
        ),
        const SizedBox(width: 18)
      ],
      foregroundColor: MyColor.black,
      backgroundColor: MyColor.background,
      elevation: 0,
      centerTitle: true,
    );
  }

  GridView _buildContent(List<Hotel> hotels, bool isGrid) {
    return GridView.builder(
        itemCount: hotels.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isGrid ? 2 : 1,
          childAspectRatio: isGrid ? 2 / 3 : 3 / 2,
        ),
        itemBuilder: (context, index) {
          final hotel = hotels[index];
          return Padding(
            padding: const EdgeInsets.all(16),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HotelDetailPage(hotel: hotel)));
              },
              child: SearchResutItem(
                  name: hotel.name,
                  isGrid: _switchListTypeBloc.isGrid,
                  address: hotel.address,
                  rating: hotel.rating,
                  imagePath: hotel.imagePath),
            ),
          );
        });
  }
}
