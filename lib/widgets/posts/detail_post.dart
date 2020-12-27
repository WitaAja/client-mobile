import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:wisata_aja/colors.dart';
import 'package:wisata_aja/models/postings/postings_model.dart';
import 'package:wisata_aja/utils/constant.dart';
import 'package:wisata_aja/utils/formatting/formatting_date.dart';
import 'package:wisata_aja/widgets/expandable_text.dart';

class DetailPost extends StatelessWidget {
  final PostingModel post;

  const DetailPost({this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: Colors.black,
          brightness: Brightness.dark,
          leading: BackButton(
            color: Colors.white,
            onPressed: () => Get.back(),
          ),
        ),
        preferredSize: Size(0.0, 0.0),
      ),
      backgroundColor: Colors.black,
      body: DetailPostWidget(
        post: post,
      ),
    );
  }
}

class DetailPostWidget extends StatefulWidget {
  final PostingModel post;

  const DetailPostWidget({this.post});

  @override
  _DetailPostWidgetState createState() => _DetailPostWidgetState();
}

class _DetailPostWidgetState extends State<DetailPostWidget> {
  bool isShowDetail = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isShowDetail = !isShowDetail;
        });
      },
      child: Stack(
        children: [
          Container(
            child: PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(widget.post.imageposts[index].urlImg),
                  initialScale: PhotoViewComputedScale.contained * 0.8,
                  heroAttributes: PhotoViewHeroAttributes(tag: widget.post.imageposts[index].urlImg),
                );
              },
              itemCount: widget.post.imageposts.length,
              loadingBuilder: (context, event) => Center(child: CupertinoActivityIndicator()),
            ),
          ),
          DescriptionPostDetail(isShowDetail, widget.post),
        ],
      ),
    );
  }
}

class DescriptionPostDetail extends StatelessWidget {
  final bool isShow;
  final PostingModel post;

  DescriptionPostDetail(this.isShow, this.post);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      width: Get.width,
      child: AnimatedOpacity(
        opacity: isShow ? 0.0 : 1.0,
        duration: Duration(milliseconds: 300),
        child: Container(
            color: Colors.black.withOpacity(0.5),
            padding: const EdgeInsets.only(bottom: 50, right: 25, left: 25, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    post.user.name,
                    style: TextStyle(fontSize: FontSizeResponsive.fontSize28, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                ),
                ExpandableText(
                  post?.description,
                  trimLines: 2,
                  textStyle: TextStyle(color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    DateFormatting.dateFormat(post.createdAt),
                    style: TextStyle(
                        fontSize: FontSizeResponsive.fontSize23,
                        fontWeight: FontWeight.w400,
                        color: ThemeColor.getInstance.get(context).secondaryTextColor),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
