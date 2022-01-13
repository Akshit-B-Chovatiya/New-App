import 'package:flutter/material.dart';
import 'package:news_app/src/models/home_feed/news_model.dart' as nm;
import 'package:news_app/src/utils/api_client.dart';

class FilterFeedProvider extends ChangeNotifier {
  List<nm.Articles>? articles = [];

  List<String> filterCategories = [
    "business",
    "entertainment",
    "general",
    "health",
    "science",
    "sports",
    "technology",
  ];

  List<String> sortList = [
    "popularity",
    "relevancy",
  ];

  int selectedCategoryIndex = 0;
  int selectedSortIndex = 0;

  int pageCount = 0;
  final scrollController = ScrollController();
  Future getFilterFeedData({@required BuildContext? context,@required isPaginationAvailable}) async {
    pageCount++;
    nm.NewsModel? response =
        await callApi(context!, ApiClient.instance.getFilterFeedData(category: filterCategories[selectedCategoryIndex],sortBy: sortList[selectedSortIndex],pageCount: pageCount), () {
      Navigator.pop(context);
      getFilterFeedData(context: context,isPaginationAvailable: isPaginationAvailable);
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
