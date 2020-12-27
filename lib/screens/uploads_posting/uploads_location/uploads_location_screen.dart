import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wisata_aja/blocs/region/region_bloc.dart';
import 'package:wisata_aja/blocs/region/region_event.dart';
import 'package:wisata_aja/blocs/upload_posting/uploads_posting_bloc.dart';
import 'package:wisata_aja/colors.dart';
import 'package:wisata_aja/models/city_model.dart';
import 'package:wisata_aja/models/province_model.dart';
import 'package:wisata_aja/utils/constant.dart';
import 'package:wisata_aja/widgets/search/search_city.dart';
import 'package:wisata_aja/widgets/search/search_province.dart';

class UploadsLocation extends StatefulWidget {
  final UploadsPostingBloc uploadsPostingBloc;

  const UploadsLocation({@required this.uploadsPostingBloc});

  @override
  _UploadsLocationState createState() => _UploadsLocationState();
}

class _UploadsLocationState extends State<UploadsLocation> {
  RegionBloc regionBloc;
  ProvinceDetail provinceSelected;
  CityDetail citySelected;

  Future<void> _searchProvince() async {
    loadProvince();
    showSearch(
      context: context,
      delegate: SearchProvince((data) {
        setState(() {
          provinceSelected = data;
          citySelected = null;
        });
      }),
    );
  }

  Future<void> _searchCity() async {
    final String id = provinceSelected?.id;
    if (id != null) {
      loadCity(id);
      showSearch(
        context: context,
        delegate: SearchCity((data) {
          setState(() {
            citySelected = data;
          });
        }),
      );
    }
  }

  void loadProvince() {
    regionBloc.add(LoadProvince());
  }

  void loadCity(String id) {
    regionBloc.add(LoadCity(id: id));
  }

  void onSave() {
    if (provinceSelected != null && citySelected != null) {
      widget.uploadsPostingBloc.onProvinceSelected(provinceSelected);
      widget.uploadsPostingBloc.onCitySelected(citySelected);
      Get.back();
    }
  }

  @override
  void initState() {
    regionBloc = BlocProvider.of<RegionBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
        leading: IconButton(icon: Icon(Icons.close), onPressed: () => Get.back()),
        actions: [
          FlatButton(
            padding: EdgeInsets.symmetric(horizontal: 20),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Text("Save"),
            onPressed: (provinceSelected == null || citySelected == null) ? null : () => onSave(),
          )
        ],
      ),
      body: Column(
        children: [
          FlatButton(
            onPressed: () => _searchProvince(),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Text(
                        provinceSelected?.name ?? "pilih Provinsi",
                        style: TextStyle(color: ThemeColor.getInstance.get(context).primaryTextColor, fontSize: FontSizeResponsive.fontSize30),
                      ),
                    ),
                  ],
                ),
                Padding(
                  child: SvgPicture.asset("assets/arrow.svg"),
                  padding: const EdgeInsets.only(left: 10),
                )
              ],
            ),
          ),
          FlatButton(
            onPressed: () => _searchCity(),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Text(
                        citySelected?.name ?? "pilih Kota/Kabupaten",
                        style: TextStyle(color: ThemeColor.getInstance.get(context).primaryTextColor, fontSize: FontSizeResponsive.fontSize30),
                      ),
                    ),
                  ],
                ),
                Padding(
                  child: SvgPicture.asset("assets/arrow.svg"),
                  padding: const EdgeInsets.only(left: 10),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
