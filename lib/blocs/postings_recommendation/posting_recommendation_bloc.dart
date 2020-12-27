import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wisata_aja/blocs/postings_recommendation/posting_recommendation_event.dart';
import 'package:wisata_aja/blocs/postings_recommendation/posting_recommendation_state.dart';
import 'package:wisata_aja/models/city_model.dart';
import 'package:wisata_aja/models/postings/posting_searh_request.dart';
import 'package:wisata_aja/models/province_model.dart';
import 'package:wisata_aja/repositories/posting.dart';
import 'package:wisata_aja/services/service_locator.dart';

class PostingsRecommendationBloc extends Bloc<PostingsRecommendationEvent, PostingsRecommendationState> {
  PostingsRecommendationBloc() : super(PostingsRecommendationInitial());

  final PostingRepositories postingRepositories = sl.get<PostingRepositories>();

  List<String> listCategory = [];
  ProvinceDetail provinceSelected;
  CityDetail citySelected;

  @override
  Stream<PostingsRecommendationState> mapEventToState(PostingsRecommendationEvent event) async* {
    if (event is LoadRecommendationPosting) {
      yield* _mapEventLoadEventToState(event);
    }
    if (event is LoadSearchPosting) {
      yield* _mapEventSearchEventToState(event);
    }
  }

  Stream<PostingsRecommendationState> _mapEventLoadEventToState(LoadRecommendationPosting event) async* {
    try {
      listCategory = [];
      citySelected = null;
      provinceSelected = null;
      final data = await postingRepositories.loadPostings();
      if (data.status) {
        yield PostingsRecommendationLoaded(postings: data.data);
      }
    } catch (_) {}
  }

  Stream<PostingsRecommendationState> _mapEventSearchEventToState(LoadSearchPosting event) async* {
    try {
      final PostingSearchRequest postingSearchRequest =
          PostingSearchRequest(category: listCategory, prov: provinceSelected?.id, kota: citySelected?.id);
      final data = await postingRepositories.loadPostingSearch(postingSearchRequest: postingSearchRequest);
      if (data.status) {
        yield PostingsRecommendationLoaded(postings: data.data);
      }
    } catch (_) {
      print(_);
    }
  }
}
