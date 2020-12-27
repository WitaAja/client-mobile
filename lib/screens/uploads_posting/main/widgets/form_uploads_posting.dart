import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wisata_aja/blocs/upload_posting/uploads_posting_bloc.dart';
import 'package:wisata_aja/colors.dart';
import 'package:wisata_aja/screens/uploads_posting/main/widgets/uploads_image.dart';
import 'package:wisata_aja/screens/uploads_posting/uploads_description/uploads_description_screen.dart';
import 'package:wisata_aja/screens/uploads_posting/uploads_location/uploads_location_screen.dart';
import 'package:wisata_aja/screens/uploads_posting/uplods_category/category_screen.dart';
import 'package:wisata_aja/utils/constant.dart';

class FormUploadsPosting extends StatefulWidget {
  @override
  _FormUploadsPostingState createState() => _FormUploadsPostingState();
}

class _FormUploadsPostingState extends State<FormUploadsPosting> {
  UploadsPostingBloc uploadsPostingBloc;

  @override
  void initState() {
    super.initState();
    uploadsPostingBloc = BlocProvider.of<UploadsPostingBloc>(context);
  }

  void onSubmit() {
    uploadsPostingBloc.onSubmit();
  }

  String get getTextLocation {
    final provinceSelected = uploadsPostingBloc?.provinceSelected?.name;
    final citySelected = uploadsPostingBloc?.citySelected?.name;

    if (provinceSelected == null) {
      return "Location";
    }
    if (citySelected == null) {
      return provinceSelected;
    }

    return "$provinceSelected, $citySelected";
  }

  String get getDescription {
    final description = uploadsPostingBloc?.description;
    if (description == null) {
      return "Description";
    }
    return description;
  }

  String get getCategory {
    try {
      String string = '';
      final category = uploadsPostingBloc?.listCategoryName;
      if (category == null || category.length < 1) {
        return "Category";
      }
      for (int i = 0; i < uploadsPostingBloc.listCategoryName.length; i++) {
        if (i != 0) {
          string += ' ,${uploadsPostingBloc.listCategoryName[i]}';
        } else {
          string += '${uploadsPostingBloc.listCategoryName[i]}';
        }
      }
      return string;
    } catch (_) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        UploadsImage(uploadsPostingBloc: uploadsPostingBloc),
        Container(
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
          padding: const EdgeInsets.only(bottom: 20, top: 20),
          child: Column(
            children: [
              FlatButton(
                onPressed: () => Get.to(UploadsLocation(uploadsPostingBloc: uploadsPostingBloc)),
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SvgPicture.asset("assets/location.svg"),
                    ),
                    Expanded(
                      flex: 11,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          getTextLocation,
                          style: TextStyle(color: ThemeColor.getInstance.get(context).primaryTextColor, fontSize: FontSizeResponsive.fontSize30),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      child: SvgPicture.asset("assets/arrow.svg"),
                      padding: const EdgeInsets.only(left: 10, right: 10),
                    ))
                  ],
                ),
              ),
              FlatButton(
                onPressed: () => Get.to(CategoryScreen(
                  uploadsPostingBloc: uploadsPostingBloc,
                )),
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SvgPicture.asset("assets/tag.svg"),
                    ),
                    Expanded(
                      flex: 11,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          getCategory,
                          style: TextStyle(color: ThemeColor.getInstance.get(context).primaryTextColor, fontSize: FontSizeResponsive.fontSize30),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      child: SvgPicture.asset("assets/arrow.svg"),
                      padding: const EdgeInsets.only(left: 10, right: 10),
                    ))
                  ],
                ),
              ),
              FlatButton(
                onPressed: () => Get.to(UploadsDescription(uploadsPostingBloc: uploadsPostingBloc)),
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SvgPicture.asset(
                        "assets/description.svg",
                        height: 15,
                      ),
                    ),
                    Expanded(
                      flex: 11,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          getDescription,
                          style: TextStyle(color: ThemeColor.getInstance.get(context).primaryTextColor, fontSize: FontSizeResponsive.fontSize30),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      child: SvgPicture.asset("assets/arrow.svg"),
                      padding: const EdgeInsets.only(left: 10, right: 10),
                    ))
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
