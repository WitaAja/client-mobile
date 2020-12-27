import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wisata_aja/blocs/postings/postings_bloc.dart';
import 'package:wisata_aja/blocs/postings/postings_event.dart';
import 'package:wisata_aja/blocs/postings/postings_state.dart';
import 'package:wisata_aja/colors.dart';
import 'package:wisata_aja/screens/uploads_posting/main/uploads_posting_screen.dart';
import 'package:wisata_aja/widgets/posts/posts_widget.dart';
import 'package:wisata_aja/widgets/posts/posts_widget_shimmer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PostingsBloc postingsBloc;

  Future<void> onRefresh() async {
    loadPostings();
    await Future.delayed(Duration(milliseconds: 800));
    return setState(() {});
  }

  void loadPostings() {
    postingsBloc.add(LoadPosting());
  }

  @override
  void initState() {
    super.initState();
    postingsBloc = BlocProvider.of<PostingsBloc>(context);
    loadPostings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: null,
          icon: SvgPicture.asset(
            "assets/aplication_logo.svg",
            width: 20,
            height: 20,
          ),
        ),
        title: Text("Wita Aja"),
        actions: [
          IconButton(
              icon: Icon(
                Icons.camera_alt_outlined,
                color: ThemeColor.getInstance.get(context).iconSelected,
              ),
              onPressed: () => Get.to(UploadsPostingScreen()))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: BlocBuilder<PostingsBloc, PostingsState>(
          builder: (context, statePostings) {
            if (statePostings is PostingsLoaded) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: statePostings.postings.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: PostsWidget(
                    post: statePostings.postings[index],
                  ),
                ),
              );
            }
            return Center(
              child: CupertinoActivityIndicator(),
            );
          },
        ),
      ),
    );
  }
}
