import 'package:flutter/material.dart';
import 'package:stdio_week_6/models/review.dart';
import 'package:stdio_week_6/pages/widgets/review_hotel_item.dart';

class FilterReview extends StatelessWidget {
  final List<Review> reviews;
  final String hotelId;
  const FilterReview({Key? key, required this.reviews, required this.hotelId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: reviews.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: ReviewHotelItem(review: reviews[index], hotelId: hotelId,),
        );
      },
    );
  }
}
