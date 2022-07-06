import 'package:flutter/material.dart';
import 'package:stdio_week_6/blocs/hotel_card_bloc.dart';
import 'package:stdio_week_6/constants/assets_image.dart';
import 'package:stdio_week_6/constants/assets_icon.dart';

class HotelcardImage extends StatefulWidget {
  final String imagePath;
  final String hotelId;

  const HotelcardImage(
      {Key? key, required this.imagePath, required this.hotelId})
      : super(key: key);

  @override
  State<HotelcardImage> createState() => _HotelcardImageState();
}

class _HotelcardImageState extends State<HotelcardImage> {
  final _cardBloc = HotelCardBloc();
  @override
  void dispose() {
    _cardBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: FadeInImage.assetNetwork(
            image: widget.imagePath,
            height: 162,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: AssetsImage.fadeImage,
          ),
        ),
        StreamBuilder<List<String>>(
            stream: _cardBloc.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final data = snapshot.data!;
              return Positioned(
                top: 12,
                right: 12,
                child: InkWell(
                  onTap: () {
                    _cardBloc.toggleSave(widget.hotelId);
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.2)),
                    child: Padding(
                      padding: const EdgeInsets.all(7),
                      child: data.contains(widget.hotelId)
                          ? Image.asset(
                              AssetsIcon.saveActive,
                              height: 16,
                            )
                          : Image.asset(
                              AssetsIcon.save,
                              height: 16,
                            ),
                    ),
                  ),
                ),
              );
            })
      ],
    );
  }
}
