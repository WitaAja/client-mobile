import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wisata_aja/blocs/my_postings/my_postings_bloc.dart';
import 'package:wisata_aja/blocs/my_postings/my_postings_event.dart';
import 'package:wisata_aja/blocs/my_postings/my_postings_state.dart';
import 'package:wisata_aja/blocs/my_profile/my_profile_bloc.dart';
import 'package:wisata_aja/blocs/my_profile/my_profile_event.dart';
import 'package:wisata_aja/blocs/my_profile/my_profile_state.dart';
import 'package:wisata_aja/colors.dart';
import 'package:wisata_aja/screens/my_profile/widgets/drawer.dart';
import 'package:wisata_aja/screens/my_profile/widgets/my_post.dart';
import 'package:wisata_aja/screens/my_profile/widgets/my_profile_shimmer.dart';
import 'package:wisata_aja/screens/my_profile/widgets/profile_information.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  MyProfileBloc myProfileBloc;
  MyPostingsBloc myPostingsBloc;

  Future<void> onRefresh() async {
    loadPostings();
    loadMyPostings();
    await Future.delayed(Duration(milliseconds: 800));
    return setState(() {});
  }

  void loadPostings() {
    myProfileBloc.add(LoadMyProfile());
  }

  void loadMyPostings() {
    myPostingsBloc.add(LoadMyPosting());
  }

  @override
  void initState() {
    super.initState();
    myProfileBloc = BlocProvider.of<MyProfileBloc>(context);
    myPostingsBloc = BlocProvider.of<MyPostingsBloc>(context);
    loadPostings();
    loadMyPostings();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyPostingsBloc, MyPostingsState>(builder: (context, stateMyPostings) {
      return BlocBuilder<MyProfileBloc, MyProfileState>(builder: (context, stateMyProfile) {
        if (stateMyProfile is MyProfileLoaded && stateMyPostings is MyPostingsLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: Text("My Profile"),
            ),
            endDrawer: DrawerMyProfile(
              profile: stateMyProfile.myProfile,
            ),
            body: RefreshIndicator(
              onRefresh: onRefresh,
              child: ListView(
                children: [
                  ProfileInformation(
                    profile: stateMyProfile.myProfile,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30,bottom: 0),
                    child: Divider(
                      color: ThemeColor.getInstance.get(context).greyColor,
                      thickness: 1,
                      height: 10,
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      if (stateMyPostings.myPostings.length > 0) {
                        return MyPost(posts: stateMyPostings);
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          );
        }
        return MyProfileLoadingScreen();
      });
    });
  }
}
