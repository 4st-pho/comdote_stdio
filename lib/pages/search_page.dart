import 'package:flutter/material.dart';
import 'package:stdio_week_6/blocs/search_bloc.dart';
import 'package:stdio_week_6/constants/assets_icon.dart';
import 'package:stdio_week_6/constants/const_string.dart';
import 'package:stdio_week_6/constants/my_color.dart';
import 'package:stdio_week_6/helper/hide_keyboard.dart';
import 'package:stdio_week_6/models/hotel.dart';
import 'package:stdio_week_6/pages/widgets/search_item.dart';
import 'package:stdio_week_6/pages/widgets/search_text_field.dart';
import 'package:stdio_week_6/widgets/image_button.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final TextEditingController controller;
  final FocusNode _textFocusNode = FocusNode();
  final _searchBloc = SearchBloc();

  @override
  void initState() {
    controller = TextEditingController();
    _textFocusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    _searchBloc.dispose();
    _textFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => hideKeyboard(context: context),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                _buildSearchBar(context),
                const SizedBox(height: 12),
                Expanded(
                  child: _buildSearchResult(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  StreamBuilder<List<Hotel>> _buildSearchResult() {
    return StreamBuilder<List<Hotel>>(
      stream: _searchBloc.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        }
        final data = snapshot.data!;
        return SearchItem(data: data, searchBloc: _searchBloc);
      },
    );
  }

  Padding _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          ImageButton(
            assetsIcon: AssetsIcon.arrowBack,
            onTap: () => Navigator.of(context).pop(),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Hero(
              tag: ConstString.search,
              child: Material(
                color: MyColor.white,
                elevation: 10,
                borderRadius: BorderRadius.circular(32),
                child: SearchTextField(
                    controller: controller,
                    textFocusNode: _textFocusNode,
                    searchBloc: _searchBloc),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
