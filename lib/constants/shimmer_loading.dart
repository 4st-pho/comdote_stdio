import 'package:flutter/cupertino.dart';
import 'package:stdio_week_6/widgets/bookmark_card_shimmer.dart';
import 'package:stdio_week_6/widgets/discover_card_shimmer.dart';
import 'package:stdio_week_6/widgets/hotel_card_shimmer.dart';
import 'package:stdio_week_6/widgets/hotel_review_shimmer.dart';

class ShimmerLoading {
  static final listHotelCard = ListView(
    padding: const EdgeInsets.all(16),
    children: const [
      HotelCardShimmer(),
      HotelCardShimmer(),
      HotelCardShimmer(),
      HotelCardShimmer(),
    ],
  );
  static final listBookmarkCard = ListView(
    children: const [
      BookmarkCardShimmer(),
      BookmarkCardShimmer(),
      BookmarkCardShimmer(),
      BookmarkCardShimmer(),
    ],
  );
  static final listDiscoverCard = ListView(
    scrollDirection: Axis.horizontal,
    // padding: const EdgeInsets.all(16),
    children: const [
      DiscoverCardShimmer(),
      SizedBox(width: 30),
      DiscoverCardShimmer(),
      SizedBox(width: 30),
      DiscoverCardShimmer(),
      SizedBox(width: 30),
    ],
  );
  static final listReview = ListView(
    padding: const EdgeInsets.all(16),
    children: const [
      HotelReviewShimmer(),
      SizedBox(width: 30),
      HotelReviewShimmer(),
      SizedBox(width: 30),
      HotelReviewShimmer(),
      SizedBox(width: 30),
    ],
  );
}
