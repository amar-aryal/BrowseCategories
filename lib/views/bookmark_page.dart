import 'package:flutter/material.dart';

import 'package:intern_project/widgets/bookmark_upper_widget.dart';
import 'package:intern_project/widgets/labels_widget.dart';

class BookmarkPage extends StatefulWidget {
  final int catID;
  final String title;
  BookmarkPage({this.catID, this.title});
  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.orange[600],
        elevation: 0,
        title: Text(widget.title),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.notifications_outlined,
              size: MediaQuery.of(context).size.height * 0.035,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            UpperBookmarkWidget(),
            LabelsWidget(catID: widget.catID),
          ],
        ),
      ),
    );
  }
}
