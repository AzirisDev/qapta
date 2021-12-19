import 'package:ad_drive/app_colors.dart';
import 'package:flutter/material.dart';

class TestMainScreen extends StatefulWidget {
  @override
  _TestMainScreenState createState() => _TestMainScreenState();
}

class _TestMainScreenState extends State<TestMainScreen> {
  // Properties & Variables needed

  int currentTab = 0; // to keep track of active tab index
  Widget currentScreen = Scaffold(
    body: Text("center"),
  ); // Our first view in viewport

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentScreen,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.PRIMARY_BLUE,
        child: Icon(Icons.map_rounded, color: AppColors.MONO_WHITE),
        onPressed: () {
          setState(() {
            currentTab = 1;
            currentScreen = Scaffold(
              body: Text("center"),
            ); // if user taps on this dashboard tab will be active
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: MaterialButton(
                  minWidth: 40,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      currentScreen = Scaffold(
                        body: Text("1"),
                      ); // if user taps on this dashboard tab will be active
                      currentTab = 0;
                    });
                  },
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 2,
                        top: 3,
                        child: Icon(
                          Icons.home_outlined,
                          color: currentTab == 0 ? Colors.black12 : Colors.transparent,
                          size: 35,
                        ),
                      ),
                      Icon(
                        Icons.home_outlined,
                        color: AppColors.PRIMARY_BLUE,
                        size: 35,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(flex: 1,child: Container()),
              Expanded(
                flex: 2,
                child: MaterialButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentScreen = Scaffold(
                        body: Text("2"),
                      ); // if user taps on this dashboard tab will be active
                      currentTab = 2;
                    });
                  },
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        right: 2,
                        top: 3,
                        child: Icon(
                          Icons.person_outline_rounded,
                          color: currentTab == 2 ? Colors.black12 : Colors.transparent,
                          size: 35,
                        ),
                      ),
                      Icon(
                        Icons.person_outline_rounded,
                        color: AppColors.PRIMARY_BLUE,
                        size: 35,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
