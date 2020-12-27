import 'package:equatable/equatable.dart';

abstract class PostingsEvent extends Equatable {}

class LoadPosting extends PostingsEvent {
  @override
  List<Object> get props => [];
}
