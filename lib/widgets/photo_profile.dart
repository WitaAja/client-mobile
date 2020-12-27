import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wisata_aja/colors.dart';

class PhotoProfileWidget extends StatelessWidget {
  final String urlPhotoProfile;
  final double width;
  final EdgeInsets padding;

  const PhotoProfileWidget({@required this.width, @required this.urlPhotoProfile, this.padding = EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    if (urlPhotoProfile == null) {
      return Padding(
        padding: padding,
        child: CircleAvatar(
            radius: width,
            backgroundColor: ThemeColor.getInstance.get(context).backgroundColor,
            child: SvgPicture.asset(
              "assets/profile.svg",
              width: width + 50,
              height: width + 50,
            )),
      );
    }

    return Padding(
      padding: padding,
      child: CircleAvatar(
        radius: width,
        backgroundColor: ThemeColor.getInstance.get(context).backgroundColor,
        child: CircleAvatar(
          backgroundColor: ThemeColor.getInstance.get(context).greyColor,
          radius: width - 5,
          backgroundImage: NetworkImage(urlPhotoProfile),
        ),
      ),
    );
  }
}
