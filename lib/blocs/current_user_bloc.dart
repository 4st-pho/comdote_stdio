import 'dart:async';

import 'package:stdio_week_6/models/user.dart';
import 'package:stdio_week_6/services/cloud_firestore/user_firestore.dart';

class CurrentUserBloc {
  final _controller = StreamController<User>();
  Stream<User> get stream => _controller.stream;
  void init() async {
    final user = await UserFirestore().getUser(currenUser: true, uid: '');
    currenUser = user;
    _controller.sink.add(user);
  }

  CurrentUserBloc() {
    init();
  }

  void dispose() {
    _controller.close();
  }
}
