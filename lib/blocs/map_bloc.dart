import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stdio_week_6/constants/assets_icon.dart';
import 'package:stdio_week_6/models/location.dart';

class MapBloc {
  Set<Marker> marker = {};
  late Uint8List customMarker;

  Future<Uint8List?> getBytesFromAsset(
      {required String path, required int width}) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }

  final _controller = StreamController<Set<Marker>>();
  Stream<Set<Marker>> get stream => _controller.stream;

  void init(Location location) async {
    customMarker = (await getBytesFromAsset(path: AssetsIcon.pin, width: 150))!;
    marker.add(Marker(
        markerId: const MarkerId('01'),
        icon: BitmapDescriptor.fromBytes(customMarker),
        position: LatLng(
          location.latitude,
          location.longitude,
        )));
    _controller.sink.add(marker);
  }

  void dispose() {
    _controller.close();
  }
}
