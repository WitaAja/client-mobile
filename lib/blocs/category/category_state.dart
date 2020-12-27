import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:wisata_aja/models/category_model.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
}

class CategoryLoaded extends CategoryState {
  final CategoryModel category;

  const CategoryLoaded({@required this.category});

  @override
  List<Object> get props => [category];
}

class CategoryInitial extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryLoading extends CategoryState {
  @override
  List<Object> get props => [];
}
