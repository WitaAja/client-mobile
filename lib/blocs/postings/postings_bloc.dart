import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wisata_aja/blocs/postings/postings_event.dart';
import 'package:wisata_aja/blocs/postings/postings_state.dart';
import 'package:wisata_aja/repositories/posting.dart';
import 'package:wisata_aja/services/service_locator.dart';

class PostingsBloc extends Bloc<PostingsEvent, PostingsState> {
  PostingsBloc() : super(PostingsInitial());

  final PostingRepositories postingRepositories = sl.get<PostingRepositories>();

  @override
  Stream<PostingsState> mapEventToState(PostingsEvent event) async* {
    if (event is LoadPosting) {
      yield* _mapEventLoadEventToState(event);
    }
  }

  Stream<PostingsState> _mapEventLoadEventToState(LoadPosting event) async* {
    try {
      final data = await postingRepositories.loadPostings();
      if (data.status) {
        yield PostingsLoaded(postings: data.data);
      }
    } catch (_) {}
  }
}
