import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stdio_week_6/blocs/map_bloc.dart';
import 'package:stdio_week_6/constants/assets_icon.dart';
import 'package:stdio_week_6/constants/const_string.dart';
import 'package:stdio_week_6/constants/json/map_json.dart';
import 'package:stdio_week_6/constants/my_font.dart';
import 'package:stdio_week_6/models/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({
    Key? key,
    required this.location,
  }) : super(key: key);
  final Location location;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final _mapBloc = MapBloc();
  @override

  @override
  void dispose() {
    super.dispose();
    _mapBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _mapBloc.init(widget.location);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(context),
      body: StreamBuilder<Set<Marker>>(
          stream: _mapBloc.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final data = snapshot.data!;
            return GoogleMap(
                markers: data,
                onMapCreated: (controller) {
                  controller.setMapStyle(MapJson.json);
                },
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                      widget.location.latitude,
                      widget.location.longitude,
                    ),
                    zoom: 16));
          }),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        ConstString.hotelAddress,
        style: MyFont.blackHeading,
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
          icon: Image.asset(
            AssetsIcon.arrowBack,
            height: 24,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          }),
    );
  }
}
