import 'dart:async';

class MyBottomBarBloc {
  int index = 0;
  final _controller = StreamController<int>();
  Stream<int> get stream => _controller.stream;

  void selectPage(int pageIndex) {
    index = pageIndex;
    _controller.sink.add(index);
  }

  MyBottomBarBloc() {
    _controller.sink.add(index);
  }
  void dispose() {
    _controller.close();
  }
}
