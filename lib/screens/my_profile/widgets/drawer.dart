import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:wisata_aja/blocs/auth/auth_bloc.dart';
import 'package:wisata_aja/blocs/auth/auth_event.dart';
import 'package:wisata_aja/models/profile_model.dart';
import 'package:wisata_aja/screens/edit_profile/edit_profile_screen.dart';

class DrawerMyProfile extends StatefulWidget {
  final Profile profile;

  const DrawerMyProfile({this.profile});

  @override
  _DrawerMyProfileState createState() => _DrawerMyProfileState();
}

class _DrawerMyProfileState extends State<DrawerMyProfile> {
  AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
  }

  void logOut() {
    authBloc.add(AuthLogout());
  }

  void editProfile() {
    Get.to(EditProfileScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 56, left: 20),
                      child: Text(
                        widget.profile.data.name,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    Divider(),
                    FlatButton(
                      onPressed: editProfile,
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Edit Profile',
                              style: Theme.of(context).textTheme.headline3,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                FlatButton(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.exit_to_app,
                          size: 20,
                        ),
                      ),
                      Text(
                        "Log out",
                        style: Theme.of(context).textTheme.headline3,
                      )
                    ],
                  ),
                  onPressed: logOut,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
