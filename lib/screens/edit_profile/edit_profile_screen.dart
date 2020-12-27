import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:wisata_aja/blocs/edit_profile/edit_profile_bloc.dart';
import 'package:wisata_aja/blocs/my_profile/my_profile_bloc.dart';
import 'package:wisata_aja/blocs/my_profile/my_profile_state.dart';
import 'package:wisata_aja/screens/edit_profile/widgets/form_edit_profile.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyProfileBloc, MyProfileState>(
      builder: (context, profileState) {
        if (profileState is MyProfileLoaded) {
          return BlocProvider(
            create: (context) => EditProfileBloc(
                context: context,
                setState: (data) {
                  if (mounted)
                    setState(() {
                      data();
                    });
                }),
            child: Builder(
              builder: (context) => Form(
                key: BlocProvider.of<EditProfileBloc>(context).key,
                child: Scaffold(
                  appBar: AppBar(
                    elevation: 2,
                    leading: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => Get.back(),
                      tooltip: "Close",
                    ),
                    title: Text('Edit Profil'),
                    actions: [
                      IconButton(
                        icon: const Icon(
                          Icons.check,
                          color: Colors.blue,
                        ),
                        onPressed: () => BlocProvider.of<EditProfileBloc>(context).onSubmit(),
                        tooltip: "Save",
                      ),
                    ],
                  ),
                  body: FormEditProfile(
                    profile: profileState.myProfile,
                  ),
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
