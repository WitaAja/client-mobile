import 'package:equatable/equatable.dart';

abstract class MyPostingsEvent extends Equatable {}

class LoadMyPosting extends MyPostingsEvent {
  @override
  List<Object> get props => [];
}
