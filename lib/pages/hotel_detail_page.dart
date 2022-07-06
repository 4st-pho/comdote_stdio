import 'package:flutter/material.dart';
import 'package:stdio_week_6/constants/my_color.dart';
import 'package:stdio_week_6/constants/my_decoration.dart';
import 'package:stdio_week_6/models/hotel.dart';
import 'package:stdio_week_6/pages/widgets/review_hotel.dart';
import 'package:stdio_week_6/pages/widgets/description.dart';
import 'package:stdio_week_6/pages/widgets/detail_hotel_bar.dart';
import 'package:stdio_week_6/pages/widgets/hotel_info.dart';
import 'package:stdio_week_6/services/cloud_firestore/hotel_firestore.dart';

class HotelDetailPage extends StatelessWidget {
  const HotelDetailPage({Key? key, required this.hotel}) : super(key: key);
  final Hotel hotel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        _buildSliverAppBar(),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: StreamBuilder<Hotel>(
                stream: HotelFirestore().streamHotel(hotel.id),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox();
                  }
                  final hotelStream = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HotelInfo(
                        reviewsQuantity: hotelStream.reviews.length,
                        name: hotelStream.name,
                        address: hotelStream.address,
                        rating: hotelStream.rating,
                      ),
                      const SizedBox(height: 28),
                      Description(text: hotelStream.description),
                      const SizedBox(height: 28),
                      ReviewHotel(
                        hotelId: hotelStream.id,
                        hotelName: hotelStream.name,
                        reviews: hotelStream.reviews,
                      ),
                    ],
                  );
                }),
          ),
        ),
      ]),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
        pinned: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: DetailHotelBar(hotel: hotel),
        toolbarHeight: 60,
        backgroundColor: MyColor.grey,
        expandedHeight: 300,
        flexibleSpace: FlexibleSpaceBar(
          background: Stack(
            children: [
              Image.network(
                hotel.imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Container(decoration: MyDecoration.boxDecoration),
            ],
          ),
        ),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(32),
            child: Container(
              width: double.infinity,
              height: 32,
              decoration: const BoxDecoration(
                  color: MyColor.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  )),
            )),
      );
  }
}
