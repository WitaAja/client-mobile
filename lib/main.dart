import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wisata_aja/blocs/auth/auth_bloc.dart';
import 'package:wisata_aja/blocs/auth/auth_state.dart';
import 'package:wisata_aja/blocs/bottom_bar/bottom_bar_bloc.dart';
import 'package:wisata_aja/blocs/category/category_bloc.dart';
import 'package:wisata_aja/blocs/category/category_event.dart';
import 'package:wisata_aja/blocs/my_postings/my_postings_bloc.dart';
import 'package:wisata_aja/blocs/my_profile/my_profile_bloc.dart';
import 'package:wisata_aja/blocs/my_profile/my_profile_event.dart';
import 'package:wisata_aja/blocs/postings/postings_bloc.dart';
import 'package:wisata_aja/blocs/postings_recommendation/posting_recommendation_bloc.dart';
import 'package:wisata_aja/blocs/region/region_bloc.dart';
import 'package:wisata_aja/colors.dart';
import 'package:wisata_aja/screens/home/home_screen.dart';
import 'package:wisata_aja/screens/login/login_screen.dart';
import 'package:wisata_aja/screens/my_profile/my_profile_screen.dart';
import 'package:wisata_aja/screens/uploads_posting/main/uploads_posting_screen.dart';
import 'package:wisata_aja/screens/where_do_you_want/where_do_you_want_screen.dart';
import 'package:wisata_aja/services/service_locator.dart';
import 'package:wisata_aja/theme.dart';
import 'package:wisata_aja/utils/constant.dart';
import 'package:wisata_aja/utils/precache_image.dart';
import 'blocs/bottom_bar/bottom_bar_event.dart';
import 'blocs/bottom_bar/bottom_bar_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedCubit.storage = await HydratedStorage.build();
  setUpLocators();
  PreCachePicture.loadCache();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, systemNavigationBarColor: Colors.black, systemNavigationBarIconBrightness: Brightness.light));
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => BottomBarBloc(),
        ),
        BlocProvider(
          create: (context) => MyProfileBloc(context)..add(LoadMyProfile()),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => RegionBloc(),
          lazy: false,
        ),
        BlocProvider(create: (context) => PostingsBloc()),
        BlocProvider(create: (context) => MyPostingsBloc()),
        BlocProvider(
          create: (context) => CategoryBloc()..add(LoadCategory()),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => PostingsRecommendationBloc(),
          lazy: false,
        ),
      ],
      child: ScreenUtilInit(designSize: const Size(750, 1334), allowFontScaling: false, child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Witaaja',
      enableLog: false,
      theme: themeLight(context),
      debugShowCheckedModeBanner: false,
      builder: (context, child) => child,
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          if (authState is AuthLoggedIn) {
            return MyHomePage();
          }
          return LoginScreen();
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  BottomBarBloc _bottomBarBloc;

  final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    WhereDoYouWant(),
    Container(),
    MyProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _bottomBarBloc = BlocProvider.of<BottomBarBloc>(context);
  }

  void _changeBottomBarNavigation(int index) {
    if (index == BottomNavigation.Upload) {
      Get.to(UploadsPostingScreen());
      return;
    }
    _bottomBarBloc.add(ChangeBottomBar(index));
  }

  static const Widget homeIcon = ImageIcon(AssetImage("assets/home.png"));
  static const Widget uploadIcon = ImageIcon(AssetImage("assets/upload.png"));
  static const Widget whereDouYouWantIcon = ImageIcon(AssetImage("assets/where_do_you_want.png"));
  static const Widget profileIcon = ImageIcon(AssetImage("assets/profile.png"));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomBarBloc, BottomBarState>(
      builder: (context, bottomBarState) => Scaffold(
        key: key,
        body: _widgetOptions[bottomBarState.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: ThemeColor.getInstance.get(context).iconUnselected,
          selectedItemColor: ThemeColor.getInstance.get(context).iconSelected,
          onTap: _changeBottomBarNavigation,
          currentIndex: bottomBarState.currentIndex,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: homeIcon,
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: whereDouYouWantIcon,
              label: "Where do you want",
            ),
            BottomNavigationBarItem(icon: uploadIcon, label: 'Upload'),
            BottomNavigationBarItem(icon: profileIcon, label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
