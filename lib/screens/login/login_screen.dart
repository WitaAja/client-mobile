import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wisata_aja/blocs/auth/auth_bloc.dart';
import 'package:wisata_aja/blocs/auth/auth_event.dart';
import 'package:wisata_aja/colors.dart';
import 'package:wisata_aja/utils/constant.dart';
import 'package:wisata_aja/widgets/buttons/button_rounded.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
  }

  void _login() {
    // authBloc.add(AuthLogout());
    authBloc.add(AuthLogin());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(),
        preferredSize: Size(0.0, 0.0),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                child: SvgPicture.asset("assets/aplication_logo.svg"),
                padding: EdgeInsets.symmetric(vertical: 30),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: RoundedOutlineButton(
                  colorBorder: ThemeColor.getInstance.get(context).greyColor,
                  onPressed: () => _login(),
                  text: "Sign in with Google",
                  textStyle: TextStyle(color: ThemeColor.getInstance.get(context).secondaryTextColor, fontSize: FontSizeResponsive.fontSize35),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: SvgPicture.asset("assets/google_logo.svg"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
