import 'package:flutter/material.dart';
import 'package:stdio_week_6/blocs/get_user_bloc.dart';
import 'package:stdio_week_6/constants/assets_icon.dart';
import 'package:stdio_week_6/constants/assets_image.dart';
import 'package:stdio_week_6/constants/my_font.dart';
import 'package:stdio_week_6/helper/get_rating.dart';
import 'package:stdio_week_6/models/review.dart';
import 'package:stdio_week_6/models/user.dart';
import 'package:stdio_week_6/services/cloud_firestore/hotel_firestore.dart';
import 'package:stdio_week_6/widgets/hotel_review_shimmer.dart';

class ReviewHotelItem extends StatefulWidget {
  final Review review;
  final String hotelId;
  const ReviewHotelItem({
    Key? key,
    required this.review,
    required this.hotelId,
  }) : super(key: key);
  @override
  State<ReviewHotelItem> createState() => _ReviewHotelItemState();
}

class _ReviewHotelItemState extends State<ReviewHotelItem> {
  final _getUserBloc = GetUserBloc();
  @override
  void dispose() {
    _getUserBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _getUserBloc.init(widget.review.uid);
    return StreamBuilder<User>(
        stream: _getUserBloc.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const HotelReviewShimmer();
          }
          final user = snapshot.data!;
          return Column(
            children: [
              const Divider(thickness: 1, height: 32),
              Row(children: [
                ClipOval(
                  child: FadeInImage.assetNetwork(
                    placeholder: AssetsImage.fadeImage,
                    image: user.avatar,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: MyFont.blackTextSmall,
                      ),
                      Row(
                        children: getRating(widget.review.rating, height: 10),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                widget.review.like > 0
                    ? Text(
                        '${widget.review.like}',
                        style: MyFont.greySubtitle,
                      )
                    : const SizedBox(),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () => HotelFirestore().likeReview(
                      hotelId: widget.hotelId, review: widget.review),
                  child: Image.asset(
                    AssetsIcon.like,
                    height: 20,
                  ),
                )
              ]),
              const SizedBox(height: 16),
              Row(children: [
                Expanded(
                    child: Text(
                  widget.review.content,
                  style: MyFont.blackTextSmall,
                ))
              ])
            ],
          );
        });
  }
}
