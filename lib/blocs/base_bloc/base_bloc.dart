import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wisata_aja/blocs/auth/auth_bloc.dart';
import 'package:wisata_aja/blocs/auth/auth_state.dart';

abstract class BaseBloc<K, V> extends HydratedBloc<K, V> {
  AuthBloc authBloc;

  BaseBloc(V state, BuildContext context) : super(state) {
    authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.listen((autState) {
      if (autState is AuthLoggedIn) {
        onLogin();
      }
      if (autState is AuthLoggedOut) {
        onLogout();
      }
    });
  }

  bool get isLoggedIn => authBloc?.state is AuthLoggedIn;

  void onLogin();

  void onLogout();
}
