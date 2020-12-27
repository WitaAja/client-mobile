import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wisata_aja/blocs/my_postings/my_postings_state.dart';

class MyPost extends StatelessWidget {
  final MyPostingsLoaded posts;

  const MyPost({this.posts});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 16 / 16,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          for (var data in posts.getListWithImage)
            Padding(
              padding: const EdgeInsets.only(left: 2, bottom: 2, right: 2, top: 2),
              child: FadeInImage.assetNetwork(
                placeholder: "assets/grey_placeholder.png",
                image: data.imageposts[0].urlImg,
                fit: BoxFit.cover,
              ),
            )
        ],
      ),
    );
  }
}
