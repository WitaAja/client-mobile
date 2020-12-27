import 'package:equatable/equatable.dart';
import 'package:wisata_aja/models/postings/postings_model.dart';

abstract class PostingsRecommendationState extends Equatable {
  const PostingsRecommendationState();
}

class PostingsRecommendationLoaded extends PostingsRecommendationState {
  final List<PostingModel> postings;

  const PostingsRecommendationLoaded({this.postings});

  @override
  List<Object> get props => [postings];
}

class PostingsRecommendationInitial extends PostingsRecommendationState {
  @override
  List<Object> get props => [];
}

class PostingsRecommendationFailed extends PostingsRecommendationState {
  @override
  List<Object> get props => [];
}

class PostingsRecommendationLoading extends PostingsRecommendationState {
  @override
  List<Object> get props => [];
}
