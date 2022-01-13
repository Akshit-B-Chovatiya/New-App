import 'package:flutter/material.dart';
import 'package:news_app/src/config/api_endpoints.dart';
import 'package:news_app/src/screens/dashboard/tab_bar_provider.dart';
import 'package:news_app/src/screens/splash/splash_screen.dart';
import 'package:news_app/src/screens/tabs/filter_feed/filter_feed_provider.dart';
import 'package:news_app/src/screens/tabs/home_feed/home_feed_provider.dart';
import 'package:news_app/src/screens/tabs/search_feed/search_feed_provider.dart';
import 'package:news_app/src/utils/api_client.dart';
import 'package:news_app/src/utils/device_orientation.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main()async {
  setDeviceOrientationUp();
  await ApiClient.init(APIEndpoints.baseURL);
  runApp(MultiProvider(
    providers: providers,
    child: const NewsApp(),
  ),);
}


List<SingleChildWidget> providers = [
  ChangeNotifierProvider<TabBarProvider>(create: (_) => TabBarProvider()),
  ChangeNotifierProvider<HomeFeedProvider>(create: (_) => HomeFeedProvider()),
  ChangeNotifierProvider<SearchFeedProvider>(create: (_) => SearchFeedProvider()),
  ChangeNotifierProvider<FilterFeedProvider>(create: (_) => FilterFeedProvider()),
];

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}



