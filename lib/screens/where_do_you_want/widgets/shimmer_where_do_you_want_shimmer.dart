import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wisata_aja/blocs/postings/postings_bloc.dart';
import 'package:wisata_aja/blocs/postings/postings_event.dart';
import 'package:wisata_aja/colors.dart';
import 'package:wisata_aja/widgets/posts/posts_widget_shimmer.dart';

class WhereDoYouWantShimmer extends StatefulWidget {
  @override
  _WhereDoYouWantShimmerState createState() => _WhereDoYouWantShimmerState();
}

class _WhereDoYouWantShimmerState extends State<WhereDoYouWantShimmer> {
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
        title: Text('Where do you want'),
        centerTitle: true,
        bottom: PreferredSize(
          child: Row(
            children: [
              Expanded(
                child: OutlineButton(
                  onPressed: null,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                  highlightedBorderColor: ThemeColor.getInstance.get(context).greyColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Category",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
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
                  onPressed: null,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                  highlightedBorderColor: ThemeColor.getInstance.get(context).greyColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Filter By Location",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
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
          itemCount: 30,
          itemBuilder: (context, index) => PostsWidgetShimmer(),
        ),
      ),
    );
  }
}

class WhereDoYouWantLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Where do you want'),
        centerTitle: true,
        bottom: PreferredSize(
          child: Row(
            children: [
              Expanded(
                child: OutlineButton(
                  onPressed: null,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                  highlightedBorderColor: ThemeColor.getInstance.get(context).greyColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Category",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
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
                  onPressed: null,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                  highlightedBorderColor: ThemeColor.getInstance.get(context).greyColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Filter By Location",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
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
      body: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
