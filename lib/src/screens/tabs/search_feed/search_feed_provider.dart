import 'package:flutter/material.dart';
import 'package:news_app/src/models/home_feed/news_model.dart' as nm;
import 'package:news_app/src/utils/api_client.dart';

class SearchFeedProvider extends ChangeNotifier {
  List<nm.Articles>? articles = [];


  TextEditingController searchController = TextEditingController();
  String query = "Top-Headlines";

  int pageCount = 0;
  final scrollController = ScrollController();
  Future getSearchFeedData({@required BuildContext? context,@required isPaginationAvailable}) async {
    pageCount++;
    nm.NewsModel? response = await callApi(
        context!, ApiClient.instance.getSearchFeedData(query: searchController.text.isNotEmpty ? searchController.text : "Top-Headlines",pageCount: pageCount), () {
      Navigator.pop(context);
      getSearchFeedData(context: context,isPaginationAvailable: isPaginationAvailable);
    });
    if(isPaginationAvailable)
    {
      articles!.addAll(response!.articles!);
    }
    else
    {
      articles!.clear();
      articles!.addAll(response!.articles!);
    }
    notifyListeners();
  }
}
