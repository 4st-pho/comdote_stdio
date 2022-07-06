import 'package:flutter/material.dart';
import 'package:stdio_week_6/constants/assets_icon.dart';
import 'package:stdio_week_6/constants/my_font.dart';
import 'package:stdio_week_6/helper/get_rating.dart';

class HotelCardInfo extends StatelessWidget {
  final String hotelName;
  final String address;
  final double rating;

  const HotelCardInfo(
      {Key? key,
      required this.hotelName,
      required this.address,
      required this.rating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Text(hotelName, style: MyFont.blackHeading, maxLines: 1)),
            const SizedBox(width: 20),
            ...getRating(rating),
            const SizedBox(width: 5),
            Text(rating.toStringAsFixed(1))
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          children: [
            Image.asset(AssetsIcon.location, height: 14),
            const SizedBox(width: 10),
            Expanded(
                child: Text(
              address,
              style: MyFont.greySubtitle,
              overflow: TextOverflow.ellipsis,
            ))
          ],
        )
      ],
    );
  }
}
