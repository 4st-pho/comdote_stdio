import 'package:flutter/material.dart';
import 'package:stdio_week_6/blocs/hotel_card_bloc.dart';
import 'package:stdio_week_6/constants/assets_icon.dart';
import 'package:stdio_week_6/models/hotel.dart';
import 'package:stdio_week_6/pages/map_page.dart';
import 'package:stdio_week_6/widgets/image_button.dart';

class DetailHotelBar extends StatefulWidget {
  const DetailHotelBar({Key? key, required this.hotel}) : super(key: key);
  final Hotel hotel;

  @override
  State<DetailHotelBar> createState() => _DetailHotelBarState();
}

class _DetailHotelBarState extends State<DetailHotelBar> {
  final _hotelCardBloc = HotelCardBloc();

  @override
  void dispose() {
    super.dispose();
    _hotelCardBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageButton(
          onTap: () {
            Navigator.of(context).pop();
          },
          assetsIcon: AssetsIcon.back,
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    MapPage(location: widget.hotel.location)));
          },
          child: Image.asset(AssetsIcon.export, height: 24),
        ),
        const SizedBox(width: 13),
        InkWell(
          onTap: () {
            _hotelCardBloc.toggleSave(widget.hotel.id);
          },
          child: StreamBuilder<List<String>>(
              stream: _hotelCardBloc.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                }
                final data = snapshot.data!;
                return data.contains(widget.hotel.id)
                    ? Image.asset(AssetsIcon.saveActive, height: 24)
                    : Image.asset(AssetsIcon.save, height: 24);
              }),
        ),
      ],
    );
  }
}
