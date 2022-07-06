import 'package:flutter/material.dart';
import 'package:stdio_week_6/blocs/search_bloc.dart';
import 'package:stdio_week_6/models/hotel.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({
    Key? key,
    required this.data,
    required SearchBloc searchBloc,
  })  : _searchBloc = searchBloc,
        super(key: key);

  final List<Hotel> data;
  final SearchBloc _searchBloc;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(
        thickness: 2,
        // height: 40,
      ),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        final hotel = data[index];
        return InkWell(
          onTap: () => _searchBloc.goResultPage(context, suggest: hotel.name),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(mainAxisSize: MainAxisSize.max, children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(hotel.name),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
