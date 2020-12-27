import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wisata_aja/models/auth_model.dart';
import 'package:wisata_aja/repositories/auth_repository.dart';
import 'package:wisata_aja/services/service_locator.dart';
import 'package:wisata_aja/utils/api_client/api_client.dart';
import 'package:wisata_aja/utils/print_development.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthLoggedOut());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final AuthRepositories authRepositories = sl.get<AuthRepositories>();
  final ApiClient apiClient = sl.get<ApiClient>();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthLogin) {
      yield* _mapEventToLoginState(event);
    }
    if (event is AuthLogout) {
      yield* _mapEventToLogoutState(event);
    }
  }

  Stream<AuthState> _mapEventToLoginState(AuthLogin event) async* {
    try {
      final authGoogle = await signInWithGoogle();
      if (authGoogle != null) {
        final data = await authRepositories.login(email: authGoogle.email, fullName: "", name: authGoogle.displayName, urlPhoto: authGoogle.photoURL);
        apiClient.setToken(data.data.token);
        yield AuthLoggedIn(authLogin: Auth(token: data.data.token));
      } else {
        add(AuthLogout());
      }
    } catch (_) {
      Console.log(_);
      add(AuthLogout());
    }
  }

  Stream<AuthState> _mapEventToLogoutState(AuthLogout event) async* {
    signOutGoogle();
    clear();
    apiClient.removeToken();
    yield AuthLoggedOut();
  }

  Future<User> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final authResult = await _auth.signInWithCredential(credential);
      final user = authResult.user;
      await user.getIdToken();
      return user;
    } catch (e) {
      add(AuthLogout());
      throw Exception("failed login");
    }
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();
    print("User Sign Out");
  }

  @override
  Map<String, dynamic> toJson(AuthState state) {
    if (state is AuthLoggedIn) {
      try {
        return {'token': state.authLogin.token};
      } catch (_) {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  AuthState fromJson(Map<String, dynamic> json) {
    try {
      if (json['token'] != null) {
        final String token = json['token'];
        apiClient.setToken(token);
        return AuthLoggedIn(authLogin: Auth(token: token));
      } else {
        return AuthLoggedOut();
      }
    } catch (err) {
      return AuthLoggedOut();
    }
  }
}
