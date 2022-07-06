import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stdio_week_6/constants/collection_path.dart';
import 'package:stdio_week_6/models/hotel.dart';

class HomePageBloc {
  List<Hotel> hotelList = [];
  bool hasMore = true;
  List<DocumentSnapshot> documentList = [];
  final _controller = StreamController<List<Hotel>>();
  Stream<List<Hotel>> get stream => _controller.stream;

  void init() async {
    try {
      documentList = (await FirebaseFirestore.instance
              .collection(CollectionPath.hotels)
              .orderBy('createdAt', descending: true)
              .limit(5)
              .get())
          .docs;
      if (documentList.length < 5) hasMore = false;
      hotelList = documentList
          .map((e) => Hotel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
      _controller.sink.add(hotelList);
    } on SocketException {
      _controller.sink
          .addError(const SocketException("No Internet Connection"));
    } catch (e) {
      _controller.sink.addError(e);
    }
  }

  void fetchNextHotels() async {
    try {
      List<DocumentSnapshot> newDocumentList = (await FirebaseFirestore.instance
              .collection(CollectionPath.hotels)
              .orderBy('createdAt', descending: true)
              .startAfterDocument(documentList[documentList.length - 1])
              .limit(5)
              .get())
          .docs;
      if (newDocumentList.length < 5) hasMore = false;
      documentList.addAll(newDocumentList);
      hotelList = documentList
          .map((e) => Hotel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
      _controller.sink.add(hotelList);
    } on SocketException {
      _controller.sink
          .addError(const SocketException("No Internet Connection"));
    } catch (e) {
      _controller.sink.addError(e);
    }
  }

  HomePageBloc() {
    init();
  }

  void dispose() {
    _controller.close();
  }
}
