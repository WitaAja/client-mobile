import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wisata_aja/blocs/region/region_bloc.dart';
import 'package:wisata_aja/blocs/region/region_state.dart';
import 'package:wisata_aja/colors.dart';
import 'package:wisata_aja/models/province_model.dart';
import 'package:wisata_aja/utils/constant.dart';

class SearchProvince extends SearchDelegate<String> {

  final Function(ProvinceDetail) onSelected;

  SearchProvince(this.onSelected);

  @override
  String get searchFieldLabel => "Search Province";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = "",
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<RegionBloc, RegionState>(
      builder: (context, stateProvince) {
        if (stateProvince is ProvinceState) {
          final data = stateProvince.getListByFilter(query);
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (content, index) => FlatButton(
              onPressed: () {
                close(context, null);
                onSelected(data[index]);
              },
              child: ListTile(
                title: Text(
                  data[index].name,
                  style: TextStyle(
                      color: ThemeColor.getInstance.get(context).primaryTextColor,
                      fontSize: FontSizeResponsive.fontSize30,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
