import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intern_project/views/bookmark_page.dart';
import 'package:intern_project/widgets/toast.dart';

class CategoriesWidget extends StatefulWidget {
  @override
  _CategoriesWidgetState createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  final catURL = "http://192.168.1.107:3000/categories";

  Future<List<dynamic>> getCategories() async {
    var data;

    try {
      http.Response response = await http.get(catURL);

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
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              "Categories",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.03,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Expanded(
            child: FutureBuilder(
              future: getCategories(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List categories = snapshot.data;
                  return GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: MediaQuery.of(context).size.width * 0.03,
                    children: List.generate(categories.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookmarkPage(
                                catID: categories[index]["id"],
                                title: categories[index]["category"],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.01),
                          decoration: BoxDecoration(
                            color: getColor(categories[index]["category"]),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  radius: MediaQuery.of(context).size.height *
                                      0.065,
                                  backgroundColor: Colors.white,
                                  child:
                                      getIcon(categories[index]["category"])),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Text(
                                categories[index]["category"],
                                style: TextStyle(
                                  color: getTextColor(
                                      categories[index]["category"]),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Color getColor(String category) {
    if (category == "Programming") {
      return Colors.amber[100];
    } else if (category == "Cooking") {
      return Colors.pink[100];
    } else if (category == "Music") {
      return Colors.blue[100];
    } else {
      return Colors.green[100];
    }
  }

  Color getTextColor(String category) {
    if (category == "Programming") {
      return Colors.amber;
    } else if (category == "Cooking") {
      return Colors.pink;
    } else if (category == "Music") {
      return Colors.blue;
    } else {
      return Colors.green;
    }
  }

  Icon getIcon(String category) {
    if (category == "Programming") {
      return Icon(
        Icons.desktop_windows_outlined,
        size: MediaQuery.of(context).size.height * 0.065,
        color: getColor(category),
      );
    } else if (category == "Cooking") {
      return Icon(
        Icons.fastfood_outlined,
        size: MediaQuery.of(context).size.height * 0.065,
        color: getColor(category),
      );
    } else if (category == "Music") {
      return Icon(
        Icons.music_note_outlined,
        size: MediaQuery.of(context).size.height * 0.065,
        color: getColor(category),
      );
    } else {
      return Icon(
        Icons.lightbulb,
        size: MediaQuery.of(context).size.height * 0.065,
        color: getColor(category),
      );
    }
  }
}
