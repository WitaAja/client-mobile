import 'package:flutter/material.dart';
import 'package:wisata_aja/blocs/base_bloc/base_bloc.dart';
import 'package:wisata_aja/blocs/my_profile/my_profile_event.dart';
import 'package:wisata_aja/blocs/my_profile/my_profile_state.dart';
import 'package:wisata_aja/repositories/profile_repository.dart';
import 'package:wisata_aja/services/service_locator.dart';

class MyProfileBloc extends BaseBloc<MyProfileEvent, MyProfileState> {
  MyProfileBloc(BuildContext context) : super(MyProfileInitial(), context);

  final ProfileRepositories profileRepositories = sl.get<ProfileRepositories>();

  @override
  Stream<MyProfileState> mapEventToState(MyProfileEvent event) async* {
    if (event is LoadMyProfile && isLoggedIn) {
      yield* _mapEventToMyProfile(event);
    }
  }

  Stream<MyProfileState> _mapEventToMyProfile(LoadMyProfile event) async* {
    try {
      final data = await profileRepositories.loadMyProfile();
      yield MyProfileLoaded(myProfile: data);
    } catch (_) {}
  }

  @override
  MyProfileState fromJson(Map<String, dynamic> json) {
    return MyProfileInitial();
  }

  @override
  Map<String, dynamic> toJson(state) {
    return null;
  }

  @override
  void onLogin() {
    add(LoadMyProfile());
  }

  @override
  void onLogout() {}
}
