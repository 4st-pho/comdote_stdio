import 'dart:async';

import 'package:stdio_week_6/models/hotel.dart';
import 'package:stdio_week_6/services/cloud_firestore/hotel_firestore.dart';

class DiscoverPageBloc {
  List<Hotel> hotels = [];

  final _controller = StreamController<List<Hotel>>();
  Stream<List<Hotel>> get stream => _controller.stream;
  void init() async {
    hotels = await HotelFirestore().getAllHotel();
    _controller.add(hotels);
  }

  DiscoverPageBloc() {
    init();
  }
  void dispose() {
    _controller.close();
  }
}
