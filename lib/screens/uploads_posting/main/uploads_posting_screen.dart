import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:wisata_aja/blocs/upload_posting/uploads_posting_bloc.dart';
import 'package:wisata_aja/screens/uploads_posting/main/widgets/form_uploads_posting.dart';

class UploadsPostingScreen extends StatefulWidget {
  @override
  _UploadsPostingScreenState createState() => _UploadsPostingScreenState();
}

class _UploadsPostingScreenState extends State<UploadsPostingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UploadsPostingBloc(
          setState: (Function data) {
            if (mounted)
              setState(() {
                data();
              });
          },
          context: context),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text("Bagikan Posting"),
            leading: IconButton(icon: Icon(Icons.close), onPressed: () => Get.back()),
            actions: [
              FlatButton(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Text("Posting"),
                  onPressed: BlocProvider.of<UploadsPostingBloc>(context).getSubmit),
            ],
          ),
          body: FormUploadsPosting(),
        ),
      ),
    );
  }
}
