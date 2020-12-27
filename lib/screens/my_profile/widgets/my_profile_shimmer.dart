import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wisata_aja/blocs/my_profile/my_profile_bloc.dart';
import 'package:wisata_aja/blocs/my_profile/my_profile_event.dart';
import 'package:wisata_aja/colors.dart';

class MyProfileShimmer extends StatefulWidget {
  @override
  _MyProfileShimmerState createState() => _MyProfileShimmerState();
}

class _MyProfileShimmerState extends State<MyProfileShimmer> {
  MyProfileBloc myProfileBloc;

  Future<void> onRefresh() async {
    loadPostings();
    await Future.delayed(Duration(milliseconds: 800));
    return setState(() {});
  }

  void loadPostings() {
    myProfileBloc.add(LoadMyProfile());
  }

  @override
  void initState() {
    super.initState();
    myProfileBloc = BlocProvider.of<MyProfileBloc>(context);
    loadPostings();
  }

  List<Widget> get getList {
    List<Widget> newWidget = [];
    for (int i = 0; i < 9; i++) {
      newWidget.add(Padding(
        padding: const EdgeInsets.only(left: 2, bottom: 2, right: 2, top: 2),
        child: Container(
          color: Colors.white,
        ),
      ));
    }
    return newWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: null,
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 10, bottom: 20),
                child: CircleAvatar(
                  radius: 65,
                  backgroundColor: ThemeColor.getInstance.get(context).backgroundColor,
                  child: CircleAvatar(
                    backgroundColor: ThemeColor.getInstance.get(context).greyColor,
                    radius: 25,
                  ),
                ),
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 10,
                        color: Colors.white,
                        margin: EdgeInsets.only(bottom: 10, top: 5),
                      ),
                      Container(
                        width: 100,
                        height: 10,
                        color: Colors.white,
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 10),
                child: GridView.count(
                  crossAxisCount: 3,
                  childAspectRatio: 16 / 16,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: getList,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyProfileLoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: null,
          )
        ],
      ),
      body: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
