import 'package:flutter/material.dart';
import 'package:stdio_week_6/helper/get_rating.dart';

class ChoiceChipRating extends StatelessWidget {
  final double currentRating;
  final double rating;
  final Function(bool value) onSelected;
  const ChoiceChipRating(
      {Key? key,
      required this.currentRating,
      required this.rating,
      required this.onSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Wrap(
        children: getRating(rating, height: 12),
      ),
      selected: rating == currentRating ? true : false,
      onSelected: onSelected,
      selectedColor: Colors.deepPurple,
    );
  }
}
