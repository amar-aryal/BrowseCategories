import 'package:flutter/material.dart';
import 'package:intern_project/models/item.dart';
import 'package:intern_project/view_models/item_view_model.dart';
import 'package:provider/provider.dart';

class ItemsListView extends StatefulWidget {
  const ItemsListView({Key key, @required this.items}) : super(key: key);

  final List<Item> items;

  @override
  _ItemsListViewState createState() => _ItemsListViewState();
}

class _ItemsListViewState extends State<ItemsListView> {
  int elevatedItemIndex;
  String elevatedItemName;

  _onSelected(int index, String name) {
    setState(() {
      elevatedItemIndex = index;
      elevatedItemName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            InkWell(
              onTap: () => _onSelected(index, widget.items[index].title),
              child: Container(
                decoration: elevatedItemIndex == index &&
                        elevatedItemName == widget.items[index].title
                    ? elevatedEffect()
                    : noElevatedEffect(),
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.02,
                    vertical: MediaQuery.of(context).size.height * 0.01),
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.height * 0.01),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.025),
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          widget.items[index].image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.items[index].title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                widget.items[index].isBookmarked
                                    ? widget.items[index].isBookmarked = false
                                    : widget.items[index].isBookmarked = true;
                                Provider.of<ItemModel>(context, listen: false)
                                    .updateItem(widget.items[index]);
                              },
                              icon: Icon(
                                Icons.notifications,
                                size: MediaQuery.of(context).size.height * 0.04,
                                color: widget.items[index].isBookmarked
                                    ? Colors.tealAccent[400]
                                    : Colors.orange[100],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                widget.items[index].isFavorite
                                    ? widget.items[index].isFavorite = false
                                    : widget.items[index].isFavorite = true;
                                Provider.of<ItemModel>(context, listen: false)
                                    .updateItem(widget.items[index]);
                              },
                              icon: Icon(
                                Icons.star_rounded,
                                size: MediaQuery.of(context).size.height * 0.04,
                                color: widget.items[index].isFavorite
                                    ? Colors.tealAccent[400]
                                    : Colors.orange[100],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.08),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.036,
              right: MediaQuery.of(context).size.height * 0.02,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.tealAccent[400],
                    radius: MediaQuery.of(context).size.width * 0.05,
                    child: IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.sensor_door_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: MediaQuery.of(context).size.width * 0.05,
                    child: IconButton(
                      onPressed: () {
                        Provider.of<ItemModel>(context, listen: false)
                            .deleteItem(widget.items[index]);
                      },
                      icon: Icon(
                        Icons.delete_outline,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  BoxDecoration elevatedEffect() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.orange.withOpacity(0.1),
          spreadRadius: 2,
          blurRadius: 2,
          offset: Offset(0, 3), // changes position of shadow
        )
      ],
    );
  }
}

BoxDecoration noElevatedEffect() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(15),
  );
}
