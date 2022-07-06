import 'package:flutter/material.dart';
import 'package:stdio_week_6/constants/shimmer_loading.dart';
import 'package:stdio_week_6/models/hotel.dart';
import 'package:stdio_week_6/pages/widgets/discover_card.dart';
import 'package:stdio_week_6/services/cloud_firestore/hotel_firestore.dart';

class DiscoverTrending extends StatelessWidget {
  final List<Hotel> hotels;
  const DiscoverTrending({
    Key? key,
    required this.hotels,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<String>>(
        stream: HotelFirestore().getTrendingHotels,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return ShimmerLoading.listDiscoverCard;
          }
          final List<String> hotelIds = snapshot.data!;
          final hotelsFilter =
              hotels.where((element) => hotelIds.contains(element.id)).toList();
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, _) {
              return const SizedBox(
                width: 30,
              );
            },
            itemCount: hotelsFilter.length,
            itemBuilder: (BuildContext context, int index) {
              final hotel = hotelsFilter[index];
              return DiscoverCard(hotel: hotel);
            },
          );
        });
  }
}
