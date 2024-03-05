import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseCubit<State> extends Cubit<State> {
  BaseCubit(super.initialState);

  bool _isDisposed = false;

  @override
  Future<void> close() {
    _isDisposed = true;
    return super.close();
  }

  @override
  void emit(State state) {
    if (_isDisposed) {
      return;
    }
    super.emit(state);
  }
}
