import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:wisata_aja/blocs/category/category_bloc.dart';
import 'package:wisata_aja/blocs/category/category_event.dart';
import 'package:wisata_aja/blocs/postings_recommendation/posting_recommendation_bloc.dart';
import 'package:wisata_aja/blocs/postings_recommendation/posting_recommendation_event.dart';
import 'package:wisata_aja/blocs/postings_recommendation/posting_recommendation_state.dart';
import 'package:wisata_aja/colors.dart';
import 'package:wisata_aja/screens/where_do_you_want/widgets/bottom_sheet.dart';
import 'package:wisata_aja/screens/where_do_you_want/widgets/shimmer_where_do_you_want_shimmer.dart';
import 'package:wisata_aja/widgets/posts/posts_widget.dart';

class WhereDoYouWant extends StatefulWidget {
  @override
  _WhereDoYouWantState createState() => _WhereDoYouWantState();
}

class _WhereDoYouWantState extends State<WhereDoYouWant> {
  PostingsRecommendationBloc postingsBloc;
  CategoryBloc categoryBloc;

  Future<void> onRefresh() async {
    loadPostings();
    await Future.delayed(Duration(milliseconds: 800));
    return setState(() {});
  }

  void loadPostings() {
    postingsBloc.add(LoadRecommendationPosting());
  }

  void loadCategory() {
    categoryBloc..add(LoadCategory());
  }

  @override
  void initState() {
    super.initState();
    postingsBloc = BlocProvider.of<PostingsRecommendationBloc>(context);
    categoryBloc = BlocProvider.of<CategoryBloc>(context);
    loadPostings();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostingsRecommendationBloc, PostingsRecommendationState>(
      builder: (context, statePostings) {
        if (statePostings is PostingsRecommendationLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Where do you want'),
              centerTitle: true,
              bottom: PreferredSize(
                child: Row(
                  children: [
                    Expanded(
                      child: OutlineButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
                        borderSide: BorderSide(width: 0.5, color: ThemeColor.getInstance.get(context).greyColor),
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                        highlightedBorderColor: ThemeColor.getInstance.get(context).greyColor,
                        onPressed: () {
                          loadCategory();
                          Get.bottomSheet(BottomSheetCategory());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Category",
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                            Icon(
                              Icons.arrow_drop_down_sharp,
                              color: ThemeColor.getInstance.get(context).iconUnselected,
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: OutlineButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        borderSide: BorderSide(width: 0.5, color: ThemeColor.getInstance.get(context).greyColor),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                        highlightedBorderColor: ThemeColor.getInstance.get(context).greyColor,
                        onPressed: () {
                          Get.bottomSheet(BottomSheetFilterLocation(), isScrollControlled: true);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Filter By Location",
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                            Icon(
                              Icons.tune,
                              color: ThemeColor.getInstance.get(context).iconUnselected,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                preferredSize: Size(double.infinity, 40),
              ),
            ),
            body: RefreshIndicator(
              onRefresh: onRefresh,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: statePostings.postings.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: PostsWidget(
                    post: statePostings.postings[index],
                  ),
                ),
              ),
            ),
          );
        }
        return WhereDoYouWantLoading();
      },
    );
  }
}
