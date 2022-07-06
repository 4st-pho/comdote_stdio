import 'dart:async';

import 'package:stdio_week_6/models/hotel.dart';
import 'package:stdio_week_6/services/cloud_firestore/hotel_firestore.dart';

class SearchResultPageBloc {
  List<Hotel> hotels = [];
  final _controller = StreamController<List<Hotel>>();
  Stream<List<Hotel>> get stream => _controller.stream;
  void init(String keywork) async {
    hotels = await HotelFirestore().getAllHotel();
    final List<Hotel> result = hotels
        .where(
            (hotel) => hotel.name.toLowerCase().contains(keywork.trim().toLowerCase()))
        .toList();
    _controller.sink.add(result);
  }

  void dispose() {
    _controller.close();
  }
}
