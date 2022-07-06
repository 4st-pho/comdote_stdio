import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stdio_week_6/constants/collection_path.dart';
import 'package:stdio_week_6/models/hotel.dart';

class BookmarkBloc {
  List<Hotel> hotels = [];
  final _controller = StreamController<List<Hotel>>();
  Stream<List<Hotel>> get stream => _controller.stream;

  void init(List<String> ids) async {
    if (ids.isEmpty) {
      _controller.sink.add([]);
      return;
    }
    hotels = (await FirebaseFirestore.instance
            .collection(CollectionPath.hotels)
            .where('id', whereIn: ids)
            .orderBy('createdAt', descending: true)
            .get())
        .docs
        .map((e) => Hotel.fromJson(e.data()))
        .toList();
    _controller.sink.add(hotels);
  }

  void dispose() {
    _controller.close();
  }
}
