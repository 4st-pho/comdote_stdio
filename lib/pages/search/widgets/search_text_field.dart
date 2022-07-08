import 'package:flutter/material.dart';
import 'package:stdio_week_6/blocs/search_bloc.dart';
import 'package:stdio_week_6/constants/const_string.dart';
import 'package:stdio_week_6/constants/my_font.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key? key,
    required this.controller,
    required FocusNode textFocusNode,
    required SearchBloc searchBloc,
  }) : _textFocusNode = textFocusNode, _searchBloc = searchBloc, super(key: key);

  final TextEditingController controller;
  final FocusNode _textFocusNode;
  final SearchBloc _searchBloc;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        focusNode: _textFocusNode,
        onChanged: _searchBloc.query,
        textAlignVertical: TextAlignVertical.center,
        style:
            const TextStyle(fontSize: 16, height: 1.53),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 20),
          isDense: true,
          suffixIcon: IconButton(
            icon: const Icon(Icons.search,
                color: Colors.blueAccent, size: 20),
            onPressed: () =>
                _searchBloc.goResultPage(context),
          ),
          hintText: ConstString.searchHintText,
          labelStyle: MyFont.greyTitle,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        onSubmitted: (value) =>
            _searchBloc.goResultPage(context));
  }
}
