import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:wisata_aja/blocs/upload_posting/uploads_posting_bloc.dart';

class UploadsImage extends StatelessWidget {
  final UploadsPostingBloc uploadsPostingBloc;

  const UploadsImage({Key key, this.uploadsPostingBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (uploadsPostingBloc?.images != null && uploadsPostingBloc.images.length > 0) {
      return Expanded(
        child: GestureDetector(
            onTap: () => uploadsPostingBloc.loadAssets(),
            child: ImageCarousel(
              assets: uploadsPostingBloc.images,
            )),
      );
    }

    return Expanded(
      child: GestureDetector(
        onTap: () => uploadsPostingBloc.loadAssets(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SvgPicture.asset("assets/uploads_photo.svg"),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageCarousel extends StatefulWidget {
  final List<Asset> assets;

  const ImageCarousel({@required this.assets});

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int _current = 0;

  List<Widget> get getList {
    return widget.assets.map((item) {
      return AssetThumb(
        asset: item,
        height: Get.width < 500 ? 500 : Get.width.floor(),
        width: Get.width < 500 ? 500 : Get.width.floor(),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          child: CarouselSlider(
            items: getList,
            options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: false,
                enableInfiniteScroll: false,
                height: Get.width < 500 ? 500 : Get.width,
                scrollDirection: Axis.horizontal,
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
                viewportFraction: 1.0,
                initialPage: 0,
                disableCenter: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
        Positioned(
          bottom: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.assets.map((url) {
              int index = widget.assets.indexOf(url);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index ? Color.fromRGBO(0, 0, 0, 0.9) : Color.fromRGBO(0, 0, 0, 0.4),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
