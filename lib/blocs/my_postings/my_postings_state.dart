import 'package:equatable/equatable.dart';
import 'package:wisata_aja/models/postings/postings_model.dart';

abstract class MyPostingsState extends Equatable {
  const MyPostingsState();
}

class MyPostingsLoaded extends MyPostingsState {
  final List<PostingModel> myPostings;

  const MyPostingsLoaded({this.myPostings});

  List<PostingModel> get getListWithImage{
    final List<PostingModel> data = myPostings.where((element) => element.imageposts.length > 0).toList();
    return data;
  }

  @override
  List<Object> get props => [myPostings];
}

class MyPostingsInitial extends MyPostingsState {
  @override
  List<Object> get props => [];
}

class MyPostingsFailed extends MyPostingsState {
  @override
  List<Object> get props => [];
}

class PostingsLoading extends MyPostingsState {
  @override
  List<Object> get props => [];
}
