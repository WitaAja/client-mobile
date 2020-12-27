import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wisata_aja/blocs/category/category_event.dart';
import 'package:wisata_aja/blocs/category/category_state.dart';
import 'package:wisata_aja/models/category_model.dart';
import 'package:wisata_aja/repositories/region_repositories.dart';
import 'package:wisata_aja/services/service_locator.dart';

class CategoryBloc extends HydratedBloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial());

  final RegionRepositories regionRepositories = sl.get<RegionRepositories>();

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is LoadCategory) {
      yield* _mapEventLoadToState(event);
    }
  }

  Stream<CategoryState> _mapEventLoadToState(LoadCategory event) async* {
    try {
      final data = await regionRepositories.loadCategory();
      if(data.status){
        yield CategoryLoaded(category: data);
      }
    } catch (_) {
      print(_);
    }
  }

  @override
  CategoryState fromJson(Map<String, dynamic> json) {
    try {
      if (json['category'] != null) {
        return CategoryLoaded(category: CategoryModel.fromJson(json['category']));
      } else {
        return CategoryInitial();
      }
    } catch (err) {
      return CategoryInitial();
    }
  }

  @override
  Map<String, dynamic> toJson(CategoryState state) {
    if (state is CategoryLoaded) {
      try {
        return {'category': state.category};
      } catch (err) {
        return {'category': null};
      }
    } else {
      return {'category': null};
    }
  }
}
