import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:stdio_week_6/constants/collection_path.dart';
import 'package:stdio_week_6/helper/show_snackbar.dart';
import 'package:stdio_week_6/models/hotel.dart';
import 'package:stdio_week_6/models/location.dart';
import 'package:stdio_week_6/models/review.dart';
import 'package:stdio_week_6/services/firebase_storage/storage_methods.dart';

class HotelFirestore {
  final _firestore = FirebaseFirestore.instance;

  // create hotel
  Future<void> createHotel({
    required String name,
    required String address,
    required String description,
    required File? file,
    required String collectionImagePath,
  }) async {
    final docHotel = _firestore.collection(CollectionPath.hotels).doc();
    final imagePath = file == null
        ? "https://lh3.googleusercontent.com/YwEI3NaAi6zzMMUBcM0wVJoggDYZwY2w-Y8lhyJFvnYD80mI6ubkY8C59BoWPmbubd4=w512"
        : await StorageMethos()
            .uploadAndGetImageLink(collectionImagePath, file);
    final hotel = Hotel(
        id: docHotel.id,
        name: name.trim(),
        address: address.trim(),
        location: Location(
          latitude: 16.46293594509449,
          longitude: 107.58844216217109,
        ),
        description: description,
        rating: 0,
        reviews: [],
        imagePath: imagePath,
        createdAt: DateTime.now());
    await docHotel.set(hotel.toJson());
  }

  //get all hotel in cloud firestore
  Future<List<Hotel>> getAllHotel() async {
    return (await FirebaseFirestore.instance
            .collection(CollectionPath.hotels)
            .get())
        .docs
        .map((e) => Hotel.fromJson(e.data()))
        .toList();
  }

//get stream  hotel in cloud firestore
  Stream<Hotel> streamHotel(String id) {
    return _firestore
        .collection(CollectionPath.hotels)
        .doc(id)
        .snapshots()
        .map((snapshot) => Hotel.fromJson(snapshot.data()!));
  }

//get stream all hotel in cloud firestore
  Stream<List<Hotel>> get streamHotels {
    return _firestore
        .collection(CollectionPath.hotels)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((e) => Hotel.fromJson(e.data())).toList());
  }

//get stream treding hotel in cloud firestore
  Stream<List<String>> get getTrendingHotels {
    return _firestore
        .collection(CollectionPath.trendingHotels)
        .limit(5)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((e) => e.data()['id'] as String).toList());
  }

//get stream popular hotel in cloud firestore
  Stream<List<String>> get getPopularHotels {
    return _firestore
        .collection(CollectionPath.popularHotels)
        .limit(5)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((e) => e.data()['id'] as String).toList());
  }

//get stream appreciate hotel in cloud firestore
  Stream<List<String>> get getHightRatedHotels {
    return _firestore
        .collection(CollectionPath.hightRatedHotels)
        .limit(5)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((e) => e.data()['id'] as String).toList());
  }

  Future addIdTo(String path) async {
    final hotels = await getAllHotel();
    for (var element in hotels) {
      _firestore.collection(path).add({'id': element.id});
    }
  }

// get all review
  Future<List<Review>> getAllReview(String hotelId) async {
    final json =
        (await _firestore.collection(CollectionPath.hotels).doc(hotelId).get())
            .data()!;
    return List<Review>.from(json["reviews"].map((e) => Review.fromJson(e)));
  }

// get stream all review
  Stream<List<Review>> streamReviews(String hotelId) {
    return _firestore
        .collection(CollectionPath.hotels)
        .doc(hotelId)
        .snapshots()
        .map((doc) => List<Review>.from(
            doc.data()?["reviews"].map((e) => Review.fromJson(e))));
  }

// add review
  Future addReview(
      {required BuildContext context,
      required String hotelId,
      required Review review}) async {
    final hotelDoc = _firestore.collection(CollectionPath.hotels).doc(hotelId);
    await hotelDoc.update({
      'reviews': FieldValue.arrayUnion([review.toJson()])
    }).then((value) {
      updateHotelRating(hotelId);
      showSnackBar(context: context, content: 'Add successfully!', title: 'Add review');
    }).onError((error, stackTrace) {
      showSnackBar(context: context, content: error.toString());
    });
  }

// update hotel rating
  void updateHotelRating(String hotelId) async {
    final List<Review> reviews = await getAllReview(hotelId);
    double newRating = 0;
    if (reviews.isNotEmpty) {
      newRating = reviews.fold<double>(
              0, (previousValue, element) => previousValue + element.rating) /
          reviews.length;
    }
    final docHotel = _firestore.collection(CollectionPath.hotels).doc(hotelId);
    await docHotel.update({'rating': newRating});
  }

// add reviews
  void addReviews({required String hotelId}) async {
    final review1 = Review(
        content: 'Awesome', rating: 2, uid: 'CYipb5ODAYZPoMkxRlQURlTI0XG3');
    final review2 =
        Review(content: 'Good', rating: 4, uid: 'NvFPVSSXUMNncxhDsqtOqv0GsNF2');
    final review3 = Review(
        content: 'Not bad', rating: 1, uid: 'baUgozb1bpfi0BtA5HcgVKQ9cgB2');
    final review4 = Review(
        content: 'Very good', rating: 3, uid: 'nMc9r1TxDcNN70dK0Opik6d1sFB2');
    final review5 =
        Review(content: 'Ok', rating: 5, uid: 'sWTMdBkM0vc0Xm5RYQOq0Stmat82');
    final docHotel = _firestore.collection(CollectionPath.hotels).doc(hotelId);
    await docHotel.update({
      "reviews": [
        review1.toJson(),
        review2.toJson(),
        review3.toJson(),
        review4.toJson(),
        review5.toJson()
      ]
    });
    updateHotelRating(hotelId);
  }

  void likeReview({required String hotelId, required Review review}) async{
    final docHotel = _firestore.collection(CollectionPath.hotels).doc(hotelId);
    await docHotel.update({
      'reviews': FieldValue.arrayRemove([review.toJson()])
    });
    review.like = review.like + 1;
    await docHotel.update({
      'reviews': FieldValue.arrayUnion([review.toJson()])
    });
  }
}
