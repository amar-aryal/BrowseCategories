import 'package:flutter/material.dart';
import 'package:intern_project/widgets/bottom_nav_bar.dart';
import 'package:intern_project/widgets/categories_widget.dart';
import 'package:intern_project/widgets/home_upper_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[600],
        elevation: 0,
        actions: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.notifications_outlined,
                  size: MediaQuery.of(context).size.height * 0.035,
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.008,
                right: MediaQuery.of(context).size.height * 0.015,
                child: CircleAvatar(
                  backgroundColor: Colors.lightGreenAccent[400],
                  radius: MediaQuery.of(context).size.height * 0.007,
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomePageUpperWidget(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            CategoriesWidget(),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: null,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
