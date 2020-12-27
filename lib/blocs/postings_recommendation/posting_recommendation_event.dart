import 'package:equatable/equatable.dart';

abstract class PostingsRecommendationEvent extends Equatable {}

class LoadRecommendationPosting extends PostingsRecommendationEvent {
  @override
  List<Object> get props => [];
}

class LoadRecommendedPosting extends PostingsRecommendationEvent {
  @override
  List<Object> get props => [];
}

class LoadSearchPosting extends PostingsRecommendationEvent {
  @override
  List<Object> get props => [];
}
