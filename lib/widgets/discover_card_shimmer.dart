import 'package:flutter/material.dart';
import 'package:stdio_week_6/widgets/shimmer_widget.dart';

class DiscoverCardShimmer extends StatelessWidget {
  const DiscoverCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ShimmerWidget(
      height: double.infinity,
      width: screenWidth/2,
      shapeBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
    );
  }
}
