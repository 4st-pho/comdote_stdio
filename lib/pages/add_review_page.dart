import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stdio_week_6/blocs/loading_bloc.dart';
import 'package:stdio_week_6/constants/const_string.dart';
import 'package:stdio_week_6/constants/my_font.dart';
import 'package:stdio_week_6/helper/build_text_form_field.dart';
import 'package:stdio_week_6/helper/hide_keyboard.dart';
import 'package:stdio_week_6/helper/show_snackbar.dart';
import 'package:stdio_week_6/models/review.dart';
import 'package:stdio_week_6/models/user.dart';
import 'package:stdio_week_6/pages/widgets/review_page_bar.dart';
import 'package:stdio_week_6/services/cloud_firestore/hotel_firestore.dart';
import 'package:stdio_week_6/widgets/custom_button.dart';

class AddReviewPage extends StatefulWidget {
  final String hotelId;
  final String hotelName;
  final int ratedQuantity;
  const AddReviewPage(
      {Key? key,
      required this.hotelId,
      required this.hotelName,
      required this.ratedQuantity})
      : super(key: key);

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  late final TextEditingController _contentController;
  double rating = 0;
  final _loadingBloc = LoadingBloc();
  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          hideKeyboard(context: context);
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildReviewPageBar(),
                _buildRatingInput(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: StreamBuilder<bool>(
                      stream: _loadingBloc.stream,
                      initialData: false,
                      builder: (context, snapshot) {
                        final isLoading = snapshot.data!;
                        return CustomButton(
                          text: ConstString.add,
                          onPressed: isLoading
                              ? null
                              : () async {
                                  hideKeyboard(context: context);
                                  if (rating == 0) {
                                    _loadingBloc.toggleState();
                                    showSnackBar(
                                        context: context,
                                        content: ConstString.requiredRate,
                                        error: true);
                                    _loadingBloc.toggleState();
                                    return;
                                  }
                                  _loadingBloc.toggleState();
                                  await HotelFirestore().addReview(
                                      context: context,
                                      hotelId: widget.hotelId,
                                      review: Review(
                                          content:
                                              _contentController.text.trim(),
                                          rating: rating,
                                          uid: currenUser.id));
                                  await Future.delayed(
                                      const Duration(seconds: 1));
                                  if (!mounted) return;
                                  Navigator.of(context).pop();
                                },
                          color: Colors.deepPurple,
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded _buildRatingInput() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: Row(
                children: const [
                  Expanded(
                      child: Text(
                    'Rating',
                    textAlign: TextAlign.center,
                    style: MyFont.blackHeading,
                  ))
                ],
              ),
            ),
            RatingBar.builder(
                itemBuilder: (context, _) =>
                    const Icon(Icons.star, color: Colors.amber),
                onRatingUpdate: (value) => rating = value),
            const SizedBox(height: 32),
            BuildTextFormFeild(
                controller: _contentController,
                title: ConstString.content,
                type: TextInputType.multiline),
          ],
        ),
      ),
    );
  }

  ReviewPageBar _buildReviewPageBar() {
    return ReviewPageBar(
        hotelName: widget.hotelName,
        ratedQuantity: widget.ratedQuantity,
        onTap: () {},
        isAddReviewPage: true);
  }
}
