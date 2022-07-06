import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stdio_week_6/constants/const_string.dart';
import 'package:stdio_week_6/constants/my_font.dart';

class Description extends StatefulWidget {
  const Description({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  late String firstHalf;
  late String secondHalf;
  bool isShow = false;
  @override
  void initState() {
    super.initState();
    int textLength = widget.text.length;
    if (textLength > 150) {
      firstHalf = widget.text.substring(0, 150);
      secondHalf = widget.text.substring(150, textLength);
    } else {
      firstHalf = widget.text;
      secondHalf = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(ConstString.description, style: MyFont.blueTitle),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Expanded(
              child: secondHalf == ''
                  ? Text(widget.text, style: MyFont.blackText)
                  : isShow
                      ? Text(widget.text, style: MyFont.blackText)
                      : RichText(
                          text: TextSpan(style: MyFont.blackText, children: [
                            TextSpan(text: '$firstHalf... ', children: [
                              TextSpan(
                                  text: ConstString.readMore,
                                  style: const TextStyle(
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      setState(() {
                                        isShow = !isShow;
                                      });
                                    })
                            ]),
                          ]),
                        ),
            )
          ],
        )
      ],
    );
  }
}
