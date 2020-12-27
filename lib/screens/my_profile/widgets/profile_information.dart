import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wisata_aja/models/profile_model.dart';
import 'package:wisata_aja/widgets/photo_profile.dart';

class ProfileInformation extends StatelessWidget {
  final Profile profile;

  const ProfileInformation({@required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PhotoProfileWidget(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          width: 65,
          urlPhotoProfile: profile.data.foto,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            profile.data.name,
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        Text(
          profile.data.email,
          style: Theme.of(context).textTheme.subtitle1,
        )
      ],
    );
  }
}
