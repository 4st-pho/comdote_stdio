import 'package:flutter/material.dart';
import 'package:stdio_week_6/blocs/bookmark_bloc.dart';
import 'package:stdio_week_6/constants/assets_image.dart';
import 'package:stdio_week_6/constants/shimmer_loading.dart';
import 'package:stdio_week_6/models/hotel.dart';
import 'package:stdio_week_6/pages/widgets/hotel_card.dart';
import 'package:stdio_week_6/services/cloud_firestore/user_firestore.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  final _bookmarkBloc = BookmarkBloc();

  @override
  void dispose() {
    _bookmarkBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<String>>(
        stream: UserFirestore().streamBookmark,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return ShimmerLoading.listBookmarkCard;
          }
          final hotelIds = snapshot.data!;
          _bookmarkBloc.init(hotelIds);
          return StreamBuilder<List<Hotel>>(
              stream: _bookmarkBloc.stream,
              builder: (context, snap) {
                if (!snap.hasData) {
                  return ShimmerLoading.listBookmarkCard;
                }
                final hotels = snap.data!;
                if (hotels.isEmpty) {
                  return Center(
                      child: Image.asset(
                    AssetsImage.emptyList,
                    fit: BoxFit.contain,
                  ));
                }
                return ListView.builder(
                  itemCount: hotels.length,
                  itemBuilder: (BuildContext context, int index) {
                    return HotelCard(hotel: hotels[index]);
                  },
                );
              });
        });
  }
}
