import 'dart:async';

class SelectRatingBloc {
  double rating = -1;
  final _controller = StreamController<double>.broadcast();
  Stream<double> get stream => _controller.stream;
  void chooseRating(double ratingParam) {
    rating = ratingParam;
    _controller.sink.add(rating);
  }

  SelectRatingBloc() {
    _controller.sink.add(rating);
  }
  void dispose() {
    _controller.close();
  }
}
