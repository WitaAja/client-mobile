import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_bar_event.dart';
import 'bottom_bar_state.dart';

class BottomBarBloc extends Bloc<BottomBarEvent, BottomBarState> {
  BottomBarBloc() : super(BottomBarState(0));

  @override
  Stream<BottomBarState> mapEventToState(BottomBarEvent event) async* {
    if (event is ChangeBottomBar) {
      yield BottomBarState(event.indexChange);
    }
  }
}
