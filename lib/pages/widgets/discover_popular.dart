import 'package:flutter/material.dart';
import 'package:stdio_week_6/constants/shimmer_loading.dart';
import 'package:stdio_week_6/models/hotel.dart';
import 'package:stdio_week_6/pages/widgets/discover_card.dart';
import 'package:stdio_week_6/services/cloud_firestore/hotel_firestore.dart';

class DiscoverPopular extends StatelessWidget {
  final List<Hotel> hotels;
  const DiscoverPopular({
    Key? key,
    required this.hotels,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<String>>(
        stream: HotelFirestore().getPopularHotels,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return ShimmerLoading.listDiscoverCard;
          }
          final List<String> hotelIds = snapshot.data!;
          final popularHotel = hotels
              .where((element) => hotelIds.contains(element.id))
              .toList();
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, _) {
              return const SizedBox(
                width: 30,
              );
            },
            itemCount: popularHotel.length,
            itemBuilder: (BuildContext context, int index) {
              final hotel = popularHotel[index];
              return DiscoverCard(hotel: hotel);
            },
          );
        });
  }
}
