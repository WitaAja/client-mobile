import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'base_form_event.dart';
import 'base_form_state.dart';

abstract class BaseFormBloc extends Bloc<StatusEventBloc, StatusStateBloc> {
  BaseFormBloc() : super(StateInitial());

  @override
  Future<void> close() {
    return super.close();
  }

  @override
  void add(StatusEventBloc event) {
    super.add(event);
  }

  void emitLoading() {
    add(EventLoading());
  }

  void emitLoaded() {
    add(EventLoaded());
  }

  void emitFailed() {
    add(EventFailed());
  }

  @override
  Stream<StatusStateBloc> mapEventToState(StatusEventBloc event) async* {
    if (event is EventLoaded) {
      yield StateLoaded();
    }
    if (event is EventLoading) {
      yield StateLoading();
    }
    if (event is EventFailed) {
      yield StateFailed();
    }
  }
}
