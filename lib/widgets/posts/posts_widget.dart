import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wisata_aja/colors.dart';
import 'package:wisata_aja/models/category_model.dart';
import 'package:wisata_aja/models/postings/postings_model.dart';
import 'package:wisata_aja/utils/constant.dart';
import 'package:wisata_aja/utils/formatting/formatting_date.dart';
import 'package:wisata_aja/widgets/expandable_text.dart';
import 'package:wisata_aja/widgets/photo_profile.dart';

class PostsWidget extends StatelessWidget {
  final PostingModel post;

  const PostsWidget({@required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 10),
      child: Column(
        children: [ProfileInformation(post), DescriptionPost(post)],
      ),
    );
  }
}

class ProfileInformation extends StatelessWidget {
  final PostingModel post;

  const ProfileInformation(this.post);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              PhotoProfileWidget(
                width: 30,
                urlPhotoProfile: post.user.foto,
                padding: const EdgeInsets.only(right: 10),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.user.name,
                    style: TextStyle(fontSize: FontSizeResponsive.fontSize30, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    DateFormatting.dateFormat(post.createdAt),
                    style: TextStyle(
                        fontSize: FontSizeResponsive.fontSize23,
                        fontWeight: FontWeight.w400,
                        color: ThemeColor.getInstance.get(context).secondaryTextColor),
                  ),
                ],
              )
            ],
          ),
          Icon(
            Icons.more_vert,
            color: ThemeColor.getInstance.get(context).iconUnselected,
          ),
        ],
      ),
    );
  }
}

class DescriptionPost extends StatelessWidget {
  final PostingModel post;

  const DescriptionPost(this.post);

  String get getLocation {
    if (post?.asKota?.name == null) {
      return post.asProvinsi.name;
    }
    return '${post.asProvinsi.name}, ${post.asKota.name}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: PostImages(
            imagesPosts: post.imageposts,
          ),
        ),
        Builder(builder: (context) {
          if (post.postCategory.length > 0) {
            return Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 10),
                    child: SvgPicture.asset("assets/tag.svg"),
                  ),
                  for (final data in post.postCategory)
                    Container(
                      decoration: BoxDecoration(
                        color: CategoryModel.getColorCategory,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 3, top: 2),
                      margin: const EdgeInsets.only(right: 5),
                      child: Text(
                        data.asCategory.name,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                ],
              ),
            );
          }
          return Container();
        }),
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 5, top: 5),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 10),
                child: SvgPicture.asset("assets/location.svg"),
              ),
              Text(
                getLocation,
                style: TextStyle(fontSize: FontSizeResponsive.fontSize25, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 5),
          child: ExpandableText(
            post?.description,
            trimLines: 2,
          ),
        ),
      ],
    );
  }
}

class PostImages extends StatefulWidget {
  final List<Imageposts> imagesPosts;

  const PostImages({@required this.imagesPosts});

  @override
  _PostImagesState createState() => _PostImagesState();
}

class _PostImagesState extends State<PostImages> {
  int _current = 0;

  List<Widget> get getList {
    return widget.imagesPosts.map((item) {
      return FadeInImage.assetNetwork(
        placeholder: "assets/grey_placeholder.png",
        image: item.urlImg,
        fit: BoxFit.cover,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: CarouselSlider(
            items: getList,
            options: CarouselOptions(
                enableInfiniteScroll: false,
                autoPlay: false,
                enlargeCenterPage: false,
                height: 300,
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
        widget.imagesPosts.length < 2
            ? Container()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.imagesPosts.map((url) {
                  int index = widget.imagesPosts.indexOf(url);
                  return Container(
                    width: 5.0,
                    height: 5.0,
                    margin: EdgeInsets.only(top: 10.0, right: 2.0, left: 2.0, bottom: 0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index ? Color.fromRGBO(0, 0, 0, 0.9) : Color.fromRGBO(0, 0, 0, 0.4),
                    ),
                  );
                }).toList(),
              ),
      ],
    );
  }
}
