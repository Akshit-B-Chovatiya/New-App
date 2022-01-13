import 'package:flutter/material.dart';
import 'package:news_app/src/models/home_feed/news_model.dart' as nm;
import 'package:news_app/src/utils/api_client.dart';

class HomeFeedProvider extends ChangeNotifier {
  List<nm.Articles>? articles = [];
  final scrollController = ScrollController();

  int pageCount = 0;
  Future getHomeFeedData({@required BuildContext? context}) async {
    pageCount++;
    nm.NewsModel? response = await callApi(context!, ApiClient.instance.getHomeFeedData(pageCount: pageCount),(){
      Navigator.pop(context);
      getHomeFeedData(context: context);
    });
    articles!.addAll(response!.articles!);
    debugPrint("LIST -- ${articles!.length} -- $articles");
    notifyListeners();
  }
}
