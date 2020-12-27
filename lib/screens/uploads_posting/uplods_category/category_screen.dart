import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:wisata_aja/blocs/category/category_bloc.dart';
import 'package:wisata_aja/blocs/category/category_event.dart';
import 'package:wisata_aja/blocs/category/category_state.dart';
import 'package:wisata_aja/blocs/upload_posting/uploads_posting_bloc.dart';
import 'package:wisata_aja/colors.dart';
import 'package:wisata_aja/models/category_model.dart';
import 'package:wisata_aja/utils/constant.dart';

class CategoryScreen extends StatefulWidget {
  final UploadsPostingBloc uploadsPostingBloc;

  const CategoryScreen({@required this.uploadsPostingBloc});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(builder: (context, stateCategory) {
      if (stateCategory is CategoryLoaded) {
        return ListCategory(
          stateCategory: stateCategory,
          uploadsPostingBloc: widget.uploadsPostingBloc,
        );
      }
      return Scaffold(
        appBar: AppBar(
          title: Text("Category"),
          leading: IconButton(icon: Icon(Icons.close), onPressed: () => Get.back()),
          actions: [
            FlatButton(
                padding: EdgeInsets.symmetric(horizontal: 20),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Text("Save"),
                onPressed: null),
          ],
        ),
        body: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    });
  }
}

class ListCategory extends StatefulWidget {
  final UploadsPostingBloc uploadsPostingBloc;
  final CategoryLoaded stateCategory;

  const ListCategory({this.stateCategory, this.uploadsPostingBloc});

  @override
  _ListCategoryState createState() => _ListCategoryState();
}

class _ListCategoryState extends State<ListCategory> {
  CategoryBloc categoryBloc;

  List<String> listCategoryId = [];
  List<String> listCategoryName = [];


  void loadCategory() {
    categoryBloc.add(LoadCategory());
  }

  @override
  void initState() {
    super.initState();
    categoryBloc = BlocProvider.of<CategoryBloc>(context);
    listCategoryId = List.from(widget.uploadsPostingBloc.listCategoryId);
    listCategoryName = List.from(widget.uploadsPostingBloc.listCategoryName);
    loadCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
        leading: IconButton(icon: Icon(Icons.close), onPressed: () => Get.back()),
        actions: [
          FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 20),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Text("Save"),
              onPressed: () {
                widget.uploadsPostingBloc.onSaveCategory(categoryId: listCategoryId, categoryName: listCategoryName);
                Get.back();
              }),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          value: CategoryModel.isExist(listCategoryId,widget.stateCategory.category.data[index].id),
          onChanged: (value) {
            if (value) {
              listCategoryId.add(widget.stateCategory.category.data[index].id);
              listCategoryName.add(widget.stateCategory.category.data[index].name);
            } else {
              listCategoryId.remove(widget.stateCategory.category.data[index].id);
              listCategoryName.remove(widget.stateCategory.category.data[index].name);
            }
            setState(() {});
          },
          title: Text(
            widget.stateCategory.category.data[index].name,
            style: TextStyle(
                color: ThemeColor.getInstance.get(context).primaryTextColor, fontSize: FontSizeResponsive.fontSize30, fontWeight: FontWeight.w500),
          ),
          activeColor: ThemeColor.getInstance.get(context).primaryColor,
        ),
        itemCount: widget.stateCategory.category.data.length,
      ),
    );
  }
}
