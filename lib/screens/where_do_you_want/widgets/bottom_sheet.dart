import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:wisata_aja/blocs/category/category_bloc.dart';
import 'package:wisata_aja/blocs/category/category_state.dart';
import 'package:wisata_aja/blocs/postings_recommendation/posting_recommendation_bloc.dart';
import 'package:wisata_aja/blocs/postings_recommendation/posting_recommendation_event.dart';
import 'package:wisata_aja/blocs/region/region_bloc.dart';
import 'package:wisata_aja/blocs/region/region_event.dart';
import 'package:wisata_aja/colors.dart';
import 'package:wisata_aja/models/category_model.dart';
import 'package:wisata_aja/models/city_model.dart';
import 'package:wisata_aja/models/province_model.dart';
import 'package:wisata_aja/widgets/buttons/button_rounded.dart';
import 'package:wisata_aja/widgets/search/search_city.dart';
import 'package:wisata_aja/widgets/search/search_province.dart';

class BottomSheetFilterLocation extends StatefulWidget {
  @override
  _BottomSheetFilterLocationState createState() => _BottomSheetFilterLocationState();
}

class _BottomSheetFilterLocationState extends State<BottomSheetFilterLocation> {
  RegionBloc regionBloc;
  ProvinceDetail provinceSelected;
  CityDetail citySelected;
  PostingsRecommendationBloc postingsRecommendationBloc;

  @override
  void initState() {
    regionBloc = BlocProvider.of<RegionBloc>(context);
    postingsRecommendationBloc = BlocProvider.of<PostingsRecommendationBloc>(context);
    citySelected = postingsRecommendationBloc.citySelected;
    provinceSelected = postingsRecommendationBloc.provinceSelected;
    super.initState();
  }

  void onFilter() {
    postingsRecommendationBloc.provinceSelected = provinceSelected;
    postingsRecommendationBloc.citySelected = citySelected;
    postingsRecommendationBloc.add(LoadSearchPosting());
    Get.back();
  }

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
    } else {
      _searchProvince();
    }
  }

  void loadProvince() {
    regionBloc.add(LoadProvince());
  }

  void loadCity(String id) {
    regionBloc.add(LoadCity(id: id));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: ThemeColor.getInstance.get(context).backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff0E2C71).withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 28,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FlatButton(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
              onPressed: () => _searchProvince(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provinceSelected?.name ?? "Provinsi",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Icon(
                    Icons.arrow_drop_down_sharp,
                    color: ThemeColor.getInstance.get(context).iconUnselected,
                  )
                ],
              ),
            ),
            Divider(),
            FlatButton(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
              onPressed: () => _searchCity(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    citySelected?.name ?? "Kota/Kabupaten",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Icon(
                    Icons.arrow_drop_down_sharp,
                    color: ThemeColor.getInstance.get(context).iconUnselected,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: RoundedOutlineButton(
                      margin: const EdgeInsets.only(right: 5),
                      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
                      text: "Cancel",
                      colorBorder: ThemeColor.getInstance.get(context).buttonOutlinePrimary,
                      onPressed: () => Get.back(),
                    ),
                  ),
                  Expanded(
                    child: RoundedFillButton(
                      margin: const EdgeInsets.only(left: 5),
                      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
                      text: "Filter",
                      colorBorder: ThemeColor.getInstance.get(context).buttonFillPrimary,
                      textStyle: TextStyle(color: ThemeColor.getInstance.get(context).buttonFillPrimaryText),
                      onPressed: () => onFilter(),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BottomSheetCategory extends StatefulWidget {
  @override
  _BottomSheetCategoryState createState() => _BottomSheetCategoryState();
}

class _BottomSheetCategoryState extends State<BottomSheetCategory> {
  PostingsRecommendationBloc postingsRecommendationBloc;
  List<String> listCategoryId = [];

  @override
  void initState() {
    postingsRecommendationBloc = BlocProvider.of<PostingsRecommendationBloc>(context);
    listCategoryId = List.from(postingsRecommendationBloc.listCategory);
    super.initState();
  }

  void onSave() {
    postingsRecommendationBloc.listCategory = List.from(listCategoryId);
    postingsRecommendationBloc.add(LoadSearchPosting());
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          color: ThemeColor.getInstance.get(context).backgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff0E2C71).withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 28,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, stateCategory) {
            if (stateCategory is CategoryLoaded) {
              return Padding(
                padding: EdgeInsets.zero,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          value: CategoryModel.isExist(listCategoryId, stateCategory.category.data[index].id),
                          onChanged: (value) {
                            if (value) {
                              listCategoryId.add(stateCategory.category.data[index].id);
                            } else {
                              listCategoryId.remove(stateCategory.category.data[index].id);
                            }
                            setState(() {});
                          },
                          title: Text(
                            stateCategory.category.data[index].name,
                            style: TextStyle(color: ThemeColor.getInstance.get(context).primaryTextColor, fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          activeColor: ThemeColor.getInstance.get(context).primaryColor,
                        ),
                        itemCount: stateCategory.category.data.length,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: RoundedOutlineButton(
                              margin: const EdgeInsets.only(right: 5),
                              padding: const EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
                              text: "Cancel",
                              colorBorder: ThemeColor.getInstance.get(context).buttonOutlinePrimary,
                              onPressed: () => Get.back(),
                            ),
                          ),
                          Expanded(
                            child: RoundedFillButton(
                              margin: const EdgeInsets.only(left: 5),
                              padding: const EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
                              text: "Save",
                              colorBorder: ThemeColor.getInstance.get(context).buttonFillPrimary,
                              textStyle: TextStyle(color: ThemeColor.getInstance.get(context).buttonFillPrimaryText),
                              onPressed: () => onSave(),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
            return Padding(
              padding: EdgeInsets.zero,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CupertinoActivityIndicator(),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: RoundedOutlineButton(
                            margin: const EdgeInsets.only(right: 5),
                            padding: const EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
                            text: "Cancel",
                            colorBorder: ThemeColor.getInstance.get(context).buttonOutlinePrimary,
                            onPressed: () => Get.back(),
                          ),
                        ),
                        Expanded(
                          child: RoundedFillButton(
                            margin: const EdgeInsets.only(left: 5),
                            padding: const EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
                            text: "Save",
                            colorBorder: ThemeColor.getInstance.get(context).buttonFillPrimary,
                            textStyle: TextStyle(color: ThemeColor.getInstance.get(context).buttonFillPrimaryText),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }
}
