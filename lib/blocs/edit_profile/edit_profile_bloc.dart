import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:wisata_aja/blocs/base_bloc/base_form_bloc/base_form_bloc.dart';
import 'package:wisata_aja/blocs/my_profile/my_profile_bloc.dart';
import 'package:wisata_aja/blocs/my_profile/my_profile_event.dart';
import 'package:wisata_aja/models/profile_model.dart';
import 'package:wisata_aja/repositories/profile_repository.dart';
import 'package:wisata_aja/services/service_locator.dart';
import 'package:wisata_aja/widgets/laoder.dart';

class EditProfileBloc extends BaseFormBloc {
  final BuildContext context;
  final Function(Function()) setState;
  MyProfileBloc myProfileBloc;

  final controllerName = TextEditingController();
  final controllerFullName = TextEditingController();
  final controllerAbout = TextEditingController();
  final key = GlobalKey<FormState>();

  final ProfileRepositories profileRepositories = sl.get<ProfileRepositories>();

  EditProfileBloc({@required this.context, @required this.setState}) {
    myProfileBloc = BlocProvider.of<MyProfileBloc>(context);
  }

  String validator(String value) {
    if (value.isNotEmpty) {
      return null;
    }
    return "Field tidak boleh kosong";
  }

  void onSubmit() async {
    try {
      Loader.show();
      final ProfileRequest profileRequest = ProfileRequest(name: controllerName.text, about: controllerAbout.text, fullname: controllerFullName.text);
      final data = await profileRepositories.editMyProfile(profileRequest);
      if (data.status == true) {
        Loader.dismiss();
        Get.back();
        Get.back();
        myProfileBloc.add(LoadMyProfile());
      } else {
        throw Exception("failed edit profile");
      }
    } catch (_) {
      Loader.dismiss();
    }
  }

  @override
  close() {
    controllerName?.dispose();
    controllerAbout?.dispose();
    controllerFullName?.dispose();
    return super.close();
  }
}
