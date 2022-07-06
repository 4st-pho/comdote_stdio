import 'package:flutter/material.dart';
import 'package:stdio_week_6/models/review.dart';
import 'package:stdio_week_6/pages/widgets/review_hotel_item.dart';
import 'package:stdio_week_6/pages/widgets/title_review.dart';

class ReviewHotel extends StatelessWidget {
  const ReviewHotel({
    Key? key,
    required this.hotelId,
    required this.hotelName,
    required this.reviews,
  }) : super(key: key);
  final String hotelId;
  final String hotelName;
  final List<Review> reviews;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: reviews.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index > 0) {
          return ReviewHotelItem(
            review: reviews[index - 1],
            hotelId: hotelId,
          );
        } else {
          return TitleReview(
            hotelId: hotelId,
            reviews: reviews,
            hotelName: hotelName,
          );
        }
      },
    );
  }
}
