import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:intern_project/widgets/toast.dart';

class HomePageUpperWidget extends StatelessWidget {
  final userURL = "http://192.168.1.107:3000/userDetails";

  Future<List<dynamic>> getUser() async {
    var data;
    try {
      http.Response response = await http.get(userURL);

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
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.22,
      decoration: BoxDecoration(
        color: Colors.orange[600],
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
            future: getUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                String name =
                    snapshot.data[0]["fullName"].toString().split(" ")[0];
                print(name);
                return Text(
                  "Hi $name",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height * 0.025),
                );
              } else {
                return Container();
              }
            },
          ),
          Text(
            "Welcome Back !!!",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.height * 0.03),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Opacity(
            opacity: 0.99,
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                filled: true,
                hintStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height * 0.016),
                hintText: "What bookmarks are you searching for?",
                fillColor: Colors.white54,
              ),
            ),
          )
        ],
      ),
    );
  }
}
