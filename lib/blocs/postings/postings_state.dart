import 'package:equatable/equatable.dart';
import 'package:wisata_aja/models/postings/postings_model.dart';

abstract class PostingsState extends Equatable {
  const PostingsState();
}

class PostingsLoaded extends PostingsState {

  final List<PostingModel> postings;

  const PostingsLoaded({this.postings});

  @override
  List<Object> get props => [postings];
}

class PostingsInitial extends PostingsState {
  @override
  List<Object> get props => [];
}

class PostingsFailed extends PostingsState {
  @override
  List<Object> get props => [];
}


class PostingsLoading extends PostingsState {
  @override
  List<Object> get props => [];
}