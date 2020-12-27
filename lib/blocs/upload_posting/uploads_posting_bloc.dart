import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:wisata_aja/blocs/base_bloc/base_form_bloc/base_form_bloc.dart';
import 'package:wisata_aja/blocs/bottom_bar/bottom_bar_bloc.dart';
import 'package:wisata_aja/blocs/bottom_bar/bottom_bar_event.dart';
import 'package:wisata_aja/blocs/postings/postings_bloc.dart';
import 'package:wisata_aja/blocs/postings/postings_event.dart';
import 'package:wisata_aja/models/city_model.dart';
import 'package:wisata_aja/models/province_model.dart';
import 'package:wisata_aja/repositories/posting.dart';
import 'package:wisata_aja/services/service_locator.dart';
import 'package:wisata_aja/widgets/laoder.dart';

class UploadsPostingBloc extends BaseFormBloc {
  ProvinceDetail provinceSelected;
  CityDetail citySelected;
  String description;
  List<Asset> images = List<Asset>();

  PostingsBloc postingsBloc;

  BottomBarBloc bottomBarBloc;

  List<String> listCategoryId = [];
  List<String> listCategoryName = [];

  UploadsPostingBloc({this.context, this.setState}) {
    postingsBloc = BlocProvider.of<PostingsBloc>(context);
    bottomBarBloc = BlocProvider.of<BottomBarBloc>(context);
  }

  final PostingRepositories postingRepositories = sl.get<PostingRepositories>();

  final BuildContext context;
  final Function(Function()) setState;

  final controllerDescription = TextEditingController();
  final key = GlobalKey<FormState>();

  void loadPosting() {
    postingsBloc.add(LoadPosting());
  }

  void onSaveCategory({List<String> categoryId, List<String> categoryName}) {
    setState(() {
      listCategoryId = List.from(categoryId);
      listCategoryName = List.from(categoryName);
    });
  }

  void changeBottomNav() {
    bottomBarBloc.add(ChangeBottomBar(0));
  }

  @override
  close() {
    controllerDescription?.dispose();
    return super.close();
  }

  void onProvinceSelected(ProvinceDetail provinceDetail) {
    setState(() {
      provinceSelected = provinceDetail;
      citySelected = null;
    });
  }

  void onCitySelected(CityDetail cityDetail) {
    setState(() {
      citySelected = cityDetail;
    });
  }

  void updateDescription() {
    setState(() {
      description = controllerDescription.text;
      controllerDescription.clear();
    });
  }

  void onSubmit() async {
    try {
      Loader.show();
      final data = await postingRepositories.uploads(
          city: citySelected?.id, desc: description, files: images, prov: provinceSelected?.id, category: listCategoryId);
      if (data.status) {
        Loader.dismiss();
        Get.back();
        loadPosting();
        changeBottomNav();
      } else {
        throw Exception("failed upload");
      }
    } catch (_) {
      Loader.dismiss();
      print(_);
    }
  }

  Function get getSubmit {
    if (citySelected?.id == null || description == null || images.length == 0 || provinceSelected?.id == null) {
      return null;
    }
    return onSubmit;
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#1a1a1a",
          actionBarTitleColor: "#ffffff",
          statusBarColor: "#1a1a1a",
          lightStatusBar: false,
          actionBarTitle: "Select Image",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (_) {
      print(_);
    }
    if (resultList?.isEmpty == false) {
      setState(() {
        images = resultList;
      });
    }
  }
}
