import 'package:stdio_week_6/models/user.dart';
import 'package:stdio_week_6/services/cloud_firestore/user_firestore.dart';

class HotelCardBloc {
  void toggleSave(String id) {
    int index = currenUser.follow.indexWhere((element) => element == id);
    if (index >= 0) {
      currenUser.follow.removeAt(index);
    } else {
      currenUser.follow.add(id);
    }
    UserFirestore().updateFollow(follow: currenUser.follow);
  }
}
