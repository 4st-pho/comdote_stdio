import 'package:flutter/material.dart';
import 'package:stdio_week_6/constants/assets_icon.dart';
import 'package:stdio_week_6/constants/const_string.dart';
import 'package:stdio_week_6/constants/my_color.dart';
import 'package:stdio_week_6/constants/my_font.dart';

class ReviewPageBar extends StatelessWidget {
  final String hotelName;
  final int ratedQuantity;
  final bool isAddReviewPage;
  final VoidCallback onTap;
  const ReviewPageBar(
      {Key? key,
      required this.hotelName,
      required this.ratedQuantity,
      this.isAddReviewPage = false,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: MyColor.white,
        boxShadow: [
          const BoxShadow(
              color: Color.fromARGB(255, 243, 243, 243),
              offset: Offset(-5, -5),
              blurRadius: 15),
          BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(5, 5),
              blurRadius: 15),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Image.asset(
              AssetsIcon.arrowBack,
              width: 24,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Row(
              children: [
                Flexible(
                    child: Text(
                  hotelName,
                  style: MyFont.blackTitle,
                  overflow: TextOverflow.ellipsis,
                )),
                Text(
                  ratedQuantity == 0
                      ? ConstString.noReview
                      : ' ($ratedQuantity reviews)',
                  style: MyFont.blackTitle,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          isAddReviewPage
              ? const SizedBox()
              : IconButton(
                  onPressed: onTap,
                  icon: Image.asset(
                    AssetsIcon.add,
                    width: 24,
                  ))
        ],
      ),
    );
  }
}
