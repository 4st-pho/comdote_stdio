import 'package:flutter/material.dart';
import 'package:stdio_week_6/constants/const_string.dart';
import 'package:stdio_week_6/constants/my_font.dart';
import 'package:stdio_week_6/pages/search/search_page.dart';
import 'package:stdio_week_6/pages/discover/widgets/discover_fake_search.dart';
import 'package:stdio_week_6/pages/discover/widgets/discover_tabbar.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Scrollbar(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextContent(),
              const SizedBox(height: 32),
              _buildFakeSearch(context),
              const SizedBox(height: 32),
              const DiscoveTabbar(),
            ],
          ),
        ),
      ),
    );
  }

  InkWell _buildFakeSearch(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SearchPage()));
        },
        child: const DiscoverFakeSearch());
  }

  Column _buildTextContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(height: 20),
        Text(ConstString.welcomeToComdote, style: MyFont.blackHeading),
        SizedBox(height: 10),
        Text(ConstString.aliveWithYourStyleOfLiving,
            style: MyFont.blackTitle),
      ],
    );
  }
}
