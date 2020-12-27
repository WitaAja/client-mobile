import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wisata_aja/blocs/my_postings/my_postings_event.dart';
import 'package:wisata_aja/blocs/my_postings/my_postings_state.dart';
import 'package:wisata_aja/blocs/postings/postings_event.dart';
import 'package:wisata_aja/blocs/postings/postings_state.dart';
import 'package:wisata_aja/repositories/posting.dart';
import 'package:wisata_aja/services/service_locator.dart';

class MyPostingsBloc extends Bloc<MyPostingsEvent, MyPostingsState> {
  MyPostingsBloc() : super(MyPostingsInitial());

  final PostingRepositories postingRepositories = sl.get<PostingRepositories>();

  @override
  Stream<MyPostingsState> mapEventToState(MyPostingsEvent event) async* {
    if (event is LoadMyPosting) {
      yield* _mapEventLoadEventToState(event);
    }
  }

  Stream<MyPostingsState> _mapEventLoadEventToState(LoadMyPosting event) async* {
    try {
      final data = await postingRepositories.loadMyPostings();
      if (data.status) {
        yield MyPostingsLoaded(myPostings: data.data);
      }
    } catch (_) {}
  }
}
