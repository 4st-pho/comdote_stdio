import 'package:flutter/material.dart';
import 'package:stdio_week_6/constants/assets_image.dart';
import 'package:stdio_week_6/constants/my_font.dart';
import 'package:stdio_week_6/helper/get_rating.dart';
import 'package:stdio_week_6/models/hotel.dart';
import 'package:stdio_week_6/pages/hotel_detail_page.dart';

class DiscoverCard extends StatelessWidget {
  final Hotel hotel;
  const DiscoverCard({
    Key? key,
    required this.hotel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HotelDetailPage(hotel: hotel)));
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: FadeInImage.assetNetwork(
              image: hotel.imagePath,
              width: screenWidth / 2,
              height: double.infinity,
              fit: BoxFit.cover,
              placeholder: AssetsImage.fadeImage,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.white.withOpacity(0.3),
                  Colors.transparent,
                  Colors.black.withOpacity(0.3),
                ],
                tileMode: TileMode.mirror,
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Row(children: getRating(hotel.rating)),
          ),
          Positioned(
            bottom: 30,
            left: 20,
            child: SizedBox(
              height: 30,
              width: screenWidth / 2,
              child: Row(children: [
                Expanded(
                    child: Text(
                  hotel.name.length > 20
                      ? '${hotel.name.substring(0, 20)}...'
                      : hotel.name,
                  style: MyFont.whiteTitleB,
                ))
              ]),
            ),
          )
        ],
      ),
    );
  }
}
