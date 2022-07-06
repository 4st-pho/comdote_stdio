import 'package:flutter/material.dart';
import 'package:stdio_week_6/constants/assets_icon.dart';
import 'package:stdio_week_6/constants/const_string.dart';
import 'package:stdio_week_6/constants/my_font.dart';

class DiscoverFakeSearch extends StatelessWidget {
  const DiscoverFakeSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: ConstString.search,
      child: Material(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
          child: SizedBox(
            height: 53,
            child: Row(
              children: [
                const SizedBox(width: 20),
                Image.asset(
                  AssetsIcon.searchActive,
                  height: 24,
                ),
                const SizedBox(width: 20),
                const Expanded(
                  child: Text(ConstString.searchHintText,
                      style: MyFont.greyTitle, overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(width: 20),
              ],
            ),
          )),
    );
  }
}
