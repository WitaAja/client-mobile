import 'package:equatable/equatable.dart';
import 'package:wisata_aja/models/auth_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthLoggedIn extends AuthState {
  final Auth authLogin;
  const AuthLoggedIn({this.authLogin});

  @override
  List<Object> get props => [authLogin];
}

class AuthLoggedOut extends AuthState {
  @override
  List<Object> get props => [];
}
