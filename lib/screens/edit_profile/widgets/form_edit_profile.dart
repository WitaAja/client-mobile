import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wisata_aja/blocs/edit_profile/edit_profile_bloc.dart';
import 'package:wisata_aja/models/profile_model.dart';
import 'package:wisata_aja/widgets/textfileds/textfield.dart';

class FormEditProfile extends StatefulWidget {
  final Profile profile;

  const FormEditProfile({this.profile});

  @override
  _FormEditProfileState createState() => _FormEditProfileState();
}

class _FormEditProfileState extends State<FormEditProfile> {
  EditProfileBloc editProfileBloc;

  @override
  void initState() {
    super.initState();
    editProfileBloc = BlocProvider.of<EditProfileBloc>(context);
    editProfileBloc.controllerName.text = widget.profile.data.name;
    editProfileBloc.controllerFullName.text = widget.profile.data.fullname;
    editProfileBloc.controllerAbout.text = widget.profile.data.about;
  }

  void submit() {
    editProfileBloc.onSubmit();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldWidget(
            controller: editProfileBloc.controllerName,
            label: "Name",
            padding: const EdgeInsets.symmetric(vertical: 10),
            validator: editProfileBloc.validator,
          ),
          TextFieldWidget(
            controller: editProfileBloc.controllerFullName,
            label: "Full Name",
            padding: const EdgeInsets.symmetric(vertical: 10),
          ),
          TextFieldWidget(
            controller: editProfileBloc.controllerAbout,
            label: "About",
            padding: const EdgeInsets.symmetric(vertical: 10),
          ),
        ],
      ),
    );
  }
}
