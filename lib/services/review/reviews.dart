import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:stdio_week_6/models/review.dart';
import 'package:stdio_week_6/services/cloud_firestore/hotel_firestore.dart';

class Reviews {
  List<Review> _reviews = [];
  String _hotelId = '';
  final _controller = StreamController<List<Review>>();
  Stream<List<Review>> get stream => _controller.stream;
  Reviews(String hotelId) {
    init(hotelId);
  }
  void init(String hotelId) async {
    _hotelId = hotelId;
    _reviews = await HotelFirestore().getAllReview(hotelId);
    _controller.sink.add(_reviews);
  }

  Future addReview(Review review, BuildContext context) async {
    _reviews.insert(0, review);
    await HotelFirestore()
        .addReview(context: context, hotelId: _hotelId, review: review);
    _controller.sink.add(_reviews);
  }

  void like(int index) {
    _reviews[index].like++;
    _controller.sink.add(_reviews);
    HotelFirestore().likeReview(hotelId: _hotelId, review: _reviews[index]);
  }
}
