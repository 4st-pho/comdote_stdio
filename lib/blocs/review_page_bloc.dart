import 'dart:async';
import 'package:stdio_week_6/models/review.dart';

class ReviewPageBloc {
  List<Review> reviews = [];
  List<Review> reviewsFilter = [];
  final _controller = StreamController<List<Review>>.broadcast();
  Stream<List<Review>> get stream => _controller.stream;
  void init(List<Review> reviewsParam, rating) {
    reviews = reviewsParam;
    _controller.add(reviews);
    filterRatingByReview(rating);
  }

  void filterRatingByReview(double rating) {
    if (rating <= 0) {
      _controller.sink.add(reviews);
      return;
    }
    reviewsFilter =
        reviews.where((e) => e.rating.round() == rating.round()).toList();
    _controller.sink.add(reviewsFilter);
  }

  void dispose() {
    _controller.close();
  }
}
