import 'package:flutter/material.dart';
import 'package:stdio_week_6/widgets/shimmer_widget.dart';

class HotelCardShimmer extends StatelessWidget {
  const HotelCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 6,
                // offset: Offset(0, 7), // changes position of shadow
              ),
            ]),
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ShimmerWidget(
            height: 162,
            width: screenWidth,
            shapeBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerWidget(
                width: screenWidth / 2,
                height: 20,
              ),
              ShimmerWidget(
                width: screenWidth / 4,
                height: 20,
              ),
            ],
          ),
          const SizedBox(height: 8),
          ShimmerWidget(
            width: screenWidth / 2,
            height: 20,
          )
        ]));
  }
}
