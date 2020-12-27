import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wisata_aja/blocs/upload_posting/uploads_posting_bloc.dart';
import 'package:wisata_aja/widgets/textfileds/textfield.dart';

class UploadsDescription extends StatefulWidget {
  final UploadsPostingBloc uploadsPostingBloc;

  const UploadsDescription({@required this.uploadsPostingBloc});

  @override
  _UploadsDescriptionState createState() => _UploadsDescriptionState();
}

class _UploadsDescriptionState extends State<UploadsDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text("Description"),
        leading: IconButton(icon: Icon(Icons.close), onPressed: () => Get.back()),
        actions: [
          FlatButton(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Text("Save"),
            onPressed:
                (widget.uploadsPostingBloc.controllerDescription.text.isEmpty)
                    ? null
                    : () {
                        Get.back();
                        widget.uploadsPostingBloc.updateDescription();
                      },
          )
        ],
      ),
      body: TextFieldWidget(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        label: "Description",
        onChanged: (text) {
          setState(() {});
        },
        controller: widget.uploadsPostingBloc.controllerDescription,
      ),
    );
  }
}
