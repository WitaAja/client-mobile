import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:wisata_aja/models/profile_model.dart';

abstract class MyProfileState extends Equatable {
  const MyProfileState();
}

class MyProfileLoaded extends MyProfileState {
  final Profile myProfile;

  const MyProfileLoaded({@required this.myProfile});

  @override
  List<Object> get props => [myProfile];
}

class MyProfileInitial extends MyProfileState {

  @override
  List<Object> get props => [];
}

class MyProfileLoading extends MyProfileState {

  @override
  List<Object> get props => [];
}
