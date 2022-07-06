import 'dart:async';

class SwapShowHideBloc {
  bool isVisible = false;
  final _controller = StreamController<bool>();
  Stream<bool> get stream => _controller.stream;

  void toggleShow() {
    isVisible = !isVisible;
    _controller.sink.add(isVisible);
  }

  SwapShowHideBloc() {
    _controller.sink.add(isVisible);
  }
  void dispose() {
    _controller.close();
  }
}
