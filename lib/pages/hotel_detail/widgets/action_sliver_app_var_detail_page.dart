import 'package:flutter/material.dart';
import 'package:stdio_week_6/blocs/hotel_card_bloc.dart';
import 'package:stdio_week_6/constants/assets_icon.dart';
import 'package:stdio_week_6/models/hotel.dart';
import 'package:stdio_week_6/pages/map/map_page.dart';
import 'package:stdio_week_6/services/cloud_firestore/user_firestore.dart';

class ActionSliverAppBarDetailPage extends StatefulWidget {
  const ActionSliverAppBarDetailPage({Key? key, required this.hotel}) : super(key: key);
  final Hotel hotel;

  @override
  State<ActionSliverAppBarDetailPage> createState() => _ActionSliverAppBarDetailPageState();
}

class _ActionSliverAppBarDetailPageState extends State<ActionSliverAppBarDetailPage> {
  final _hotelCardBloc = HotelCardBloc();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    MapPage(location: widget.hotel.location)));
          },
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Image.asset(AssetsIcon.export, height: 24),
          ),
        ),
        InkWell(
          onTap: () {
            _hotelCardBloc.toggleSave(widget.hotel.id);
          },
          child: StreamBuilder<List<String>>(
            stream: UserFirestore().streamBookmark,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              }
              final data = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(6),
                child: data.contains(widget.hotel.id)
                    ? Image.asset(AssetsIcon.saveActive, height: 24)
                    : Image.asset(AssetsIcon.save, height: 24),
              );
            },
          ),
        ),
      ],
    );
  }
}
