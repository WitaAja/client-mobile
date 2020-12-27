import 'package:equatable/equatable.dart';
import 'package:wisata_aja/models/city_model.dart';
import 'package:wisata_aja/models/province_model.dart';

abstract class RegionState extends Equatable {
  const RegionState();
}

class ProvinceState extends RegionState {
  final Province provinces;

  const ProvinceState({this.provinces});

  List<ProvinceDetail> getListByFilter(String filter) {
    try {
      if (filter == null || filter == "") {
        return provinces.data;
      } else {
        List<ProvinceDetail> newList = provinces.data.where((item) => item.name.toLowerCase().contains(filter.toLowerCase()) == true).toList();
        return newList;
      }
    } catch (_) {
      return [];
    }
  }

  @override
  List<Object> get props => [provinces];
}

class CityState extends RegionState {
  final City city;

  const CityState({this.city});

  List<CityDetail> getListByFilter(String filter) {
    try {
      if (filter == null || filter == "") {
        return city.data;
      } else {
        List<CityDetail> newList = city.data.where((item) => item.name.toLowerCase().contains(filter.toLowerCase()) == true).toList();
        return newList;
      }
    } catch (_) {
      return [];
    }
  }

  @override
  List<Object> get props => [city];
}

class RegionLoading extends RegionState {
  @override
  List<Object> get props => [];
}

class RegionInitial extends RegionState {
  @override
  List<Object> get props => [];
}
