import 'package:flutter/material.dart';
import 'package:stdio_week_6/constants/const_string.dart';
import 'package:stdio_week_6/constants/my_font.dart';
import 'package:stdio_week_6/pages/search_page.dart';
import 'package:stdio_week_6/pages/widgets/discover_fake_search.dart';
import 'package:stdio_week_6/pages/widgets/discover_tabbar.dart';

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
              const SizedBox(height: 20),
              const Text(ConstString.welcomeToComdote, style: MyFont.blackHeading),
              const SizedBox(height: 10),
              const Text(ConstString.aliveWithYourStyleOfLiving,
                  style: MyFont.blackTitle),
              const SizedBox(height: 32),
              InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SearchPage()));
                  },
                  child: const DiscoverFakeSearch()),
              const SizedBox(height: 32),
              const DiscoveTabbar(),
            ],
          ),
        ),
      ),
    );
  }
}
