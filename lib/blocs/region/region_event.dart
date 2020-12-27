import 'package:equatable/equatable.dart';

abstract class RegionEvent extends Equatable {
  const RegionEvent();
}

class LoadProvince extends RegionEvent {
  @override
  List<Object> get props => [];
}

class LoadCity extends RegionEvent {
  final String id;

  const LoadCity({this.id});

  @override
  List<Object> get props => [id];
}
