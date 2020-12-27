import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wisata_aja/blocs/region/region_event.dart';
import 'package:wisata_aja/blocs/region/region_state.dart';
import 'package:wisata_aja/repositories/region_repositories.dart';
import 'package:wisata_aja/services/service_locator.dart';

class RegionBloc extends Bloc<RegionEvent, RegionState> {
  RegionBloc() : super(RegionInitial());

  final RegionRepositories regionRepositories = sl.get<RegionRepositories>();

  @override
  Stream<RegionState> mapEventToState(RegionEvent event) async* {
    if (event is LoadProvince) {
      yield* _mapEventLoadProvinceToState(event);
    }
    if (event is LoadCity) {
      yield* _mapEventLoadCityToState(event);
    }
  }

  Stream<RegionState> _mapEventLoadProvinceToState(LoadProvince event) async* {
    try {
      final data = await regionRepositories.loadProvince();
      if (data?.status == true) {
        yield ProvinceState(provinces: data);
      }
    } catch (_) {}
  }

  Stream<RegionState> _mapEventLoadCityToState(LoadCity event) async* {
    try {
      final data = await regionRepositories.loadCity(id: event.id);
      if (data?.status == true) {
        yield CityState(city: data);
      }
    } catch (_) {}
  }
}
