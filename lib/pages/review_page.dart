import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stdio_week_6/blocs/review_page_bloc.dart';
import 'package:stdio_week_6/blocs/select_rating_bloc.dart';
import 'package:stdio_week_6/constants/const_string.dart';
import 'package:stdio_week_6/models/review.dart';
import 'package:stdio_week_6/pages/add_review_page.dart';
import 'package:stdio_week_6/pages/offline_page.dart';
import 'package:stdio_week_6/pages/widgets/filter_review.dart';
import 'package:stdio_week_6/pages/widgets/review_page_bar.dart';
import 'package:stdio_week_6/services/cloud_firestore/hotel_firestore.dart';
import 'package:stdio_week_6/widgets/choice_chip_rating.dart';

import '../services/network/network_service.dart';

class ReviewPage extends StatefulWidget {
  final String hotelName;
  final String hotelId;
  const ReviewPage({Key? key, required this.hotelName, required this.hotelId})
      : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final _selectRatingBloc = SelectRatingBloc();
  final _reviewPageBloc = ReviewPageBloc();

  @override
  void dispose() {
    super.dispose();
    _selectRatingBloc.dispose();
    _reviewPageBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final networkStatus = context.watch<NetworkStatus>();
    return Scaffold(
      body: networkStatus == NetworkStatus.offline
          ? const OfflinePage()
          : StreamBuilder<double>(
              stream: _selectRatingBloc.stream,
              initialData: -1,
              builder: (context, snapshot) {
                final rating = snapshot.data!;
                
                return StreamBuilder<List<Review>>(
                    initialData: const [],
                    stream: HotelFirestore().streamReviews(widget.hotelId),
                    builder: (context, snapshot) {
                      final reviews = snapshot.data;
                      _reviewPageBloc.init(reviews ?? [], rating);
                      return SafeArea(
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                child: _buildReviewPageBar(
                                    context, reviews!.length)),
                            SizedBox(
                              height: 80,
                              child: _buildSelectFilterRating(rating),
                            ),
                            Expanded(
                              child: StreamBuilder(
                                stream: _reviewPageBloc.stream,
                                initialData: reviews,
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  final data = snapshot.data!;
                                  return FilterReview(
                                    reviews: data,
                                    hotelId: widget.hotelId,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              }),
    );
  }

  ReviewPageBar _buildReviewPageBar(BuildContext context, int ratedQuantity) {
    return ReviewPageBar(
      hotelName: widget.hotelName,
      ratedQuantity: ratedQuantity,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddReviewPage(
              hotelId: widget.hotelId,
              hotelName: widget.hotelName,
              ratedQuantity: ratedQuantity,
            ),
          ),
        );
      },
    );
  }

  ListView _buildSelectFilterRating(double rating) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ChoiceChip(
              label: Text(ConstString.all,
                  style: TextStyle(color: Colors.yellow.shade700)),
              selected: rating <= 0 ? true : false,
              selectedColor: Colors.deepPurple,
              onSelected: (value) {
                _selectRatingBloc.chooseRating(-1);
                _reviewPageBloc.filterRatingByReview(-1);
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ChoiceChipRating(
              currentRating: rating,
              rating: 5,
              onSelected: (value) {
                _selectRatingBloc.chooseRating(5);
                _reviewPageBloc.filterRatingByReview(5);
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ChoiceChipRating(
              currentRating: rating,
              rating: 4,
              onSelected: (value) {
                _selectRatingBloc.chooseRating(4);
                _reviewPageBloc.filterRatingByReview(4);
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ChoiceChipRating(
              currentRating: rating,
              rating: 3,
              onSelected: (value) {
                _selectRatingBloc.chooseRating(3);
                _reviewPageBloc.filterRatingByReview(3);
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ChoiceChipRating(
              currentRating: rating,
              rating: 2,
              onSelected: (value) {
                _selectRatingBloc.chooseRating(2);
                _reviewPageBloc.filterRatingByReview(2);
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ChoiceChipRating(
              currentRating: rating,
              rating: 1,
              onSelected: (value) {
                _selectRatingBloc.chooseRating(1);
                _reviewPageBloc.filterRatingByReview(1);
              }),
        ),
      ],
    );
  }
}
