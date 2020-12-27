import 'package:equatable/equatable.dart';

abstract class BottomBarEvent extends Equatable {
  const BottomBarEvent();
}

class ChangeBottomBar extends BottomBarEvent {
  final int indexChange;

  const ChangeBottomBar(this.indexChange);

  @override
  List<Object> get props => [indexChange];
}
