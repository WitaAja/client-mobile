import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wisata_aja/colors.dart';

class PostsWidgetShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: ThemeColor.getInstance.get(context).backgroundColor,
                          child: CircleAvatar(
                            backgroundColor: ThemeColor.getInstance.get(context).greyColor,
                            radius: 25,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 80,
                            height: 10,
                            color: Colors.white,
                            margin: EdgeInsets.only(bottom: 5),
                          ),
                          Container(
                            width: 40,
                            height: 10,
                            color: Colors.white,
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
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 5, top: 20),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 10),
                        child: SvgPicture.asset("assets/location.svg"),
                      ),
                      Container(
                        width: 80,
                        height: 10,
                        color: Colors.white,
                        margin: EdgeInsets.only(top: 5),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 20),
                  child: Container(
                    width: double.infinity,
                    height: 15,
                    color: Colors.white,
                    margin: EdgeInsets.only(bottom: 5, top: 10),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 40),
                  child: Container(
                    width: Get.width / 2,
                    height: 15,
                    color: Colors.white,
                    margin: EdgeInsets.only(bottom: 5, top: 5),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
