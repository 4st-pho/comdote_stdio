import 'dart:async';

class LoadingBloc {
  bool isLoading = false;
  final _controller = StreamController<bool>();
  Stream<bool> get stream => _controller.stream;

  void toggleState() {
    isLoading = !isLoading;
    _controller.sink.add(isLoading);
  }

  LoadingBloc() {
    _controller.sink.add(isLoading);
  }
  void dispose() {
    _controller.close();
  }
}
