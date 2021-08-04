import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intern_project/widgets/toast.dart';

import 'items_list.dart';

class LabelsWidget extends StatefulWidget {
  final int catID;

  LabelsWidget({this.catID});

  @override
  _LabelsWidgetState createState() => _LabelsWidgetState();
}

class _LabelsWidgetState extends State<LabelsWidget> {
  int selectedLabelID;

  @override
  void initState() {
    super.initState();
    selectedLabelID = 0;
  }

  final labelURL = "http://192.168.1.107:3000/labels";

  Future<List<dynamic>> getLabels(int catID) async {
    var data;
    try {
      http.Response response = await http.get(labelURL + "?catId=$catID");

      if (response.statusCode == 200) {
        data = json.decode(response.body);
      } else {
        toastMsg("Could not fetch data. Try again!");
      }
    } catch (e) {
      toastMsg(e.toString());
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(15.0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              "Labels",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.03,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
                child: FutureBuilder(
                  future: getLabels(widget.catID),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List labels = snapshot.data;

                      return ListView.builder(
                        itemCount: labels.length + 1,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5, left: 10),
                                  child: FlatButton(
                                      onPressed: () {},
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: Colors.orangeAccent[100]),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.orangeAccent[100],
                                      )),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5, left: 10),
                                  child: FlatButton(
                                    onPressed: () {
                                      setState(() {
                                        // when All is selected label id is put 0
                                        selectedLabelID = 0;
                                      });
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    color: selectedLabelID == 0
                                        ? Colors.orange[600]
                                        : Colors.orangeAccent[100],
                                    child: Text(
                                      "All",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          index--;
                          return Padding(
                            padding: EdgeInsets.only(bottom: 5, left: 10),
                            child: FlatButton(
                              onPressed: () {
                                setState(() {
                                  selectedLabelID = labels[index]["id"];
                                });
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              color: selectedLabelID == labels[index]["id"]
                                  ? Colors.orange[600]
                                  : Colors.orangeAccent[100],
                              child: Text(
                                labels[index]["name"],
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        ItemsList(
          catID: widget.catID,
          labelID: selectedLabelID,
        ),
      ],
    );
  }
}
