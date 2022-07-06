import 'package:flutter/material.dart';
import 'package:stdio_week_6/blocs/current_user_bloc.dart';
import 'package:stdio_week_6/constants/assets_icon.dart';
import 'package:stdio_week_6/constants/const_string.dart';
import 'package:stdio_week_6/constants/my_font.dart';
import 'package:stdio_week_6/models/user.dart';
import 'package:stdio_week_6/pages/add_hotel_page.dart';
import 'package:stdio_week_6/widgets/image_button.dart';

class HomeBar extends StatefulWidget {
  final BuildContext context;
  const HomeBar({Key? key, required this.context}) : super(key: key);

  @override
  State<HomeBar> createState() => _HomeBarState();
}

class _HomeBarState extends State<HomeBar> {
  final _currenUserBloc = CurrentUserBloc();

  @override
  void dispose() {
    super.dispose();
    _currenUserBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                StreamBuilder<User>(
                    stream: _currenUserBloc.stream,
                    initialData: currenUser,
                    builder: (context, snapshot) {
                      final user = snapshot.data!;
                      return Text(
                        "Hello , ${user.name}",
                        style: MyFont.blackHeading,
                        overflow: TextOverflow.ellipsis,
                      );
                    }),
                RichText(
                    text: const TextSpan(style: MyFont.blackHeading, children: [
                  TextSpan(text: ConstString.explore),
                  TextSpan(text: ConstString.newHotel, style: MyFont.blueHeading),
                ])),
              ],
            ),
          ),
          ImageButton(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddHotelPage()));
              },
              assetsIcon: AssetsIcon.add)
        ],
      ),
    );
  }
}
