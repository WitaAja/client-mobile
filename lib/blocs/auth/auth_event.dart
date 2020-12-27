import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {

}

class AuthLogin extends AuthEvent{
  @override
  List<Object> get props => [];
}

class AuthLogout extends AuthEvent{
  @override
  List<Object> get props => [];
}