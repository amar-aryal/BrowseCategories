import 'package:flutter/material.dart';
import 'package:intern_project/models/item.dart';
import 'package:intern_project/view_models/item_view_model.dart';
import 'package:provider/provider.dart';

import 'item_list_view.dart';

class ItemsList extends StatefulWidget {
  final int catID;
  final int labelID;

  //note that both may not be required to be passed in some cases (ex: filtering by "All" option)

  ItemsList({this.catID, this.labelID});

  @override
  _ItemsListState createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  final itemsURL = "http://192.168.1.107:3000/items";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Bookmarks",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.03,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              Row(
                children: [
                  Icon(Icons.arrow_upward, color: Colors.orange[600]),
                  Icon(Icons.arrow_downward, color: Colors.orange[600]),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Icon(Icons.bookmark_border_outlined,
                      color: Colors.orangeAccent[100]),
                  Consumer<ItemModel>(builder: (context, itemModel, child) {
                    return Container(
                      child: FutureBuilder(
                        /* 0 labelId means All so if id is 0 then no need to filter by label */
                        future: widget.labelID == 0
                            ? Provider.of<ItemModel>(context, listen: false)
                                .getItemsByCat(widget.catID)
                            : Provider.of<ItemModel>(context, listen: false)
                                .getItemsByCatAndLabel(
                                    widget.catID, widget.labelID),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Item> items = snapshot.data;

                            return Text(
                              items.length.toString(),
                              style: TextStyle(color: Colors.orangeAccent[400]),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    );
                  }),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.018,
              ),
              Consumer<ItemModel>(builder: (context, itemModel, child) {
                return Container(
                  child: FutureBuilder(
                    /* 0 labelId means All so if id is 0 then no need to filter by label */
                    future: widget.labelID == 0
                        ? itemModel.getItemsByCat(widget.catID)
                        : itemModel.getItemsByCatAndLabel(
                            widget.catID, widget.labelID),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Item> items = snapshot.data;

                        if (items.length == 0) {
                          return Center(
                            heightFactor:
                                MediaQuery.of(context).size.height * 0.02,
                            child: Text(
                              "No Bookmarks Found",
                              style: TextStyle(
                                  color: Colors.orangeAccent[100],
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.02),
                            ),
                          );
                        } else {
                          return ItemsListView(items: items);
                        }
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
