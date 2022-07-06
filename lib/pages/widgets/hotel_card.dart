import 'package:flutter/material.dart';
import 'package:stdio_week_6/blocs/hotel_card_bloc.dart';
import 'package:stdio_week_6/models/hotel.dart';
import 'package:stdio_week_6/pages/hotel_detail_page.dart';
import 'package:stdio_week_6/pages/widgets/hotel_card_image.dart';
import 'package:stdio_week_6/pages/widgets/hotel_card_info.dart';
import 'package:stdio_week_6/services/cloud_firestore/hotel_firestore.dart';

class HotelCard extends StatefulWidget {
  const HotelCard({Key? key, required this.hotel}) : super(key: key);
  final Hotel hotel;

  @override
  State<HotelCard> createState() => _HotelCardState();
}

class _HotelCardState extends State<HotelCard> {
  final _cardBloc = HotelCardBloc();
  @override
  void dispose() {
    _cardBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HotelDetailPage(hotel: widget.hotel)));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 6,
                // offset: Offset(0, 7), // changes position of shadow
              ),
            ]),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            HotelcardImage(
                imagePath: widget.hotel.imagePath, hotelId: widget.hotel.id),
            const SizedBox(
              height: 18,
            ),
            StreamBuilder<Hotel>(
                stream: HotelFirestore().streamHotel(widget.hotel.id),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return HotelCardInfo(
                      hotelName: widget.hotel.name,
                      address: widget.hotel.address,
                      rating: widget.hotel.rating,
                    );
                  }
                  final hotel = snapshot.data!;
                  return HotelCardInfo(
                    hotelName: hotel.name,
                    address: hotel.address,
                    rating: hotel.rating,
                  );
                }),
          ],
        ),
      ),
    );
  }
}
