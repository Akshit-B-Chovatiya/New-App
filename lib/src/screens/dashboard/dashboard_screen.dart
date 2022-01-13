import 'package:flutter/material.dart';
import 'package:news_app/src/screens/dashboard/tab_bar_provider.dart';
import 'package:news_app/src/screens/tabs/filter_feed/filter_feed.dart';
import 'package:news_app/src/screens/tabs/home_feed/home_feed.dart';
import 'package:news_app/src/screens/tabs/search_feed/search_feed.dart';
import 'package:news_app/src/widgets/bottom_bar_view.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  TabBarProvider? tabBarProvider;

  @override
  void initState() {
    tabBarProvider = Provider.of<TabBarProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    tabBarProvider = Provider.of<TabBarProvider>(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          tabBarProvider!.tabIndex == 1
              ? const HomeFeed()
              : tabBarProvider!.tabIndex == 2
                  ? const SearchFeed()
                  : tabBarProvider!.tabIndex == 3
                      ? const FilterFeed()
                      : Container(
                          color: Colors.black,
                        ),
          bottomBarView(
            index: tabBarProvider!.tabIndex,
            onOnePressed: () {
              tabBarProvider!.changeTab(context: context, index: 1);
            },
            onSecondPressed: () {
              tabBarProvider!.changeTab(context: context, index: 2);
            },
            onThirdPressed: () {
              tabBarProvider!.changeTab(context: context, index: 3);
            },
          )
        ],
      ),
    );
  }
}
