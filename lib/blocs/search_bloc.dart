import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stdio_week_6/helper/debounce.dart';
import 'package:stdio_week_6/models/hotel.dart';
import 'package:stdio_week_6/pages/search_result_page.dart';
import 'package:stdio_week_6/services/cloud_firestore/hotel_firestore.dart';

class SearchBloc {
  final _controller = StreamController<List<Hotel>>();
  String keywork = '';
  List<Hotel> hotels = [];
  Stream<List<Hotel>> get stream => _controller.stream;

  final debounce = Debounce(milliseconds: 1000);
  void init() async {
    hotels = await HotelFirestore().getAllHotel();
    _controller.sink.add(hotels.take(7).toList());
  }

  void query(String content) {
    keywork = content.trim();
    content = content.toLowerCase().trim();
    debounce.run(() {
      final List<Hotel> result = hotels
          .where((hotel) => hotel.name.toLowerCase().contains(content))
          .take(7)
          .toList();
      _controller.sink.add(result);
    });
  }
  // query data from cloud firestore
  // void queryFromFirebase(String content) async {
  //   content = content.toLowerCase();
  //   debounce.run(() async {
  //     result = (await FirebaseFirestore.instance
  //             .collection(CollectionPath.hotels)
  //             .orderBy('name')
  //             .where('name', isGreaterThanOrEqualTo: content)
  //             .limit(7)
  //             .get())
  //         .docs
  //         .map((e) => Hotel.fromJson(e.data()))
  //         .toList();
  //     _controller.sink.add(result);
  //   });
  // }

  void goResultPage(BuildContext context, {String suggest = ''}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SearchResultPage(
          keywork: suggest.isNotEmpty ? suggest.trim() : keywork.trim(),
        ),
      ),
    );
  }

  SearchBloc() {
    init();
  }

  void dispose() {
    _controller.close();
    debounce.dispose();
  }
}
