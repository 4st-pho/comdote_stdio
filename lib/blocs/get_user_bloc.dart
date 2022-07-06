import 'dart:async';

import 'package:stdio_week_6/models/user.dart';
import 'package:stdio_week_6/services/cloud_firestore/user_firestore.dart';

class GetUserBloc {
  String uid = '';
  final _controller = StreamController<User>();
  Stream<User> get stream => _controller.stream;
  void init(String uid) async {
    final user = await UserFirestore().getUser(uid: uid);
    _controller.sink.add(user);
  }

  void dispose() {
    _controller.close();
  }
}
