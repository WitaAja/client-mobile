import 'package:equatable/equatable.dart';

abstract class MyProfileEvent extends Equatable {}

class LoadMyProfile extends MyProfileEvent{

  @override
  List<Object> get props => [];
}
