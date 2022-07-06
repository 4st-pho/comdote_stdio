import 'package:flutter/material.dart';
import 'package:stdio_week_6/constants/assets_icon.dart';
import 'package:stdio_week_6/constants/const_string.dart';
import 'package:stdio_week_6/constants/my_font.dart';
import 'package:stdio_week_6/models/review.dart';
import 'package:stdio_week_6/pages/add_review_page.dart';
import 'package:stdio_week_6/pages/review_page.dart';
import 'package:stdio_week_6/widgets/image_button.dart';

class TitleReview extends StatelessWidget {
  final String hotelName;
  final String hotelId;
  final List<Review> reviews;
  const TitleReview(
      {Key? key,
      required this.reviews,
      required this.hotelName,
      required this.hotelId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(ConstString.reviews, style: MyFont.blueTitle),
        InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ReviewPage(
                    hotelName: hotelName,
                    hotelId: hotelId,
                  ))),
          child: reviews.isEmpty
              ? ImageButton(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddReviewPage(
                          hotelId: hotelId,
                          hotelName: hotelName,
                          ratedQuantity: reviews.length))),
                  assetsIcon: AssetsIcon.add)
              : Text(
                  ConstString.seeMore,
                  style: MyFont.blackText
                      .copyWith(decoration: TextDecoration.underline),
                ),
        )
      ],
    );
  }
}
