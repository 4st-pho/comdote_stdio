import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';

enum NetworkStatus { online, offline }

class NetWorkService {
  final _controller = StreamController<NetworkStatus>();
  Stream<NetworkStatus> get stream => _controller.stream;
  NetWorkService() {
    InternetConnectionChecker().onStatusChange.listen((event) {
      final connected = event == InternetConnectionStatus.connected;
      final networkStatus =
          connected ? NetworkStatus.online : NetworkStatus.offline;
      _controller.add(networkStatus);
    });
  }
  Future checkNetwork() async {
    final connected = await InternetConnectionChecker().hasConnection;
    if (!connected) return;
    _controller.add(NetworkStatus.online);
  }
}
