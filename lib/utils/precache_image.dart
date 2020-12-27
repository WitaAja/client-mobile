import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class PreCachePicture {
  static const String application_logo = "assets/aplication_logo.svg";
  static const String arrow = "assets/arrow.svg";
  static const String google_logo = "assets/google_logo.svg";

  static const String location = "assets/location.svg";
  static const String tag = "assets/tag.svg";
  static const String uploads_photo = "assets/uploads_photo.svg";

  static Future<void> loadCache() async {
    try {
      await precachePicture(
          ExactAssetPicture((SvgPicture.svgStringDecoder), application_logo), null);
      await precachePicture(
          ExactAssetPicture((SvgPicture.svgStringDecoder), arrow),
          null);
      await precachePicture(
          ExactAssetPicture((SvgPicture.svgStringDecoder), google_logo),
          null);
      await precachePicture(
          ExactAssetPicture((SvgPicture.svgStringDecoder), location),
          null);
      await precachePicture(
          ExactAssetPicture((SvgPicture.svgStringDecoder), tag),
          null);
      await precachePicture(
          ExactAssetPicture((SvgPicture.svgStringDecoder), uploads_photo),
          null);
    } catch (_) {
    }
  }
}
