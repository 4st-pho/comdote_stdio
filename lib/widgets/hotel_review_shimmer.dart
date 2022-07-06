import 'package:flutter/material.dart';
import 'package:stdio_week_6/widgets/shimmer_widget.dart';

class HotelReviewShimmer extends StatelessWidget {
  const HotelReviewShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(thickness: 1, height: 32),
        Row(children: [
          const ShimmerWidget.circular(width: 40, height: 40),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerWidget(width: screenWidth / 5, height: 16),
              const SizedBox(height: 8),
              ShimmerWidget(width: screenWidth / 5, height: 16),
            ],
          ),
          const Spacer(),
          const ShimmerWidget(width: 20, height: 16),
        ]),
        const SizedBox(height: 16),
        ShimmerWidget(width: screenWidth , height: 16),
      ],
    );
  }
}
