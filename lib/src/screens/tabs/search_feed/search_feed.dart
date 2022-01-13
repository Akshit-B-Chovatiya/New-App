import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/src/config/app_colors.dart';
import 'package:news_app/src/screens/news_detail/news_detail_screen.dart';
import 'package:news_app/src/screens/tabs/search_feed/search_feed_provider.dart';
import 'package:news_app/src/widgets/text_view.dart';
import 'package:provider/provider.dart';

class SearchFeed extends StatefulWidget {
  const SearchFeed({Key? key}) : super(key: key);

  @override
  _SearchFeedState createState() => _SearchFeedState();
}

class _SearchFeedState extends State<SearchFeed> {
  SearchFeedProvider? searchFeedProvider;

  @override
  void initState() {
    searchFeedProvider =
        Provider.of<SearchFeedProvider>(context, listen: false);
    searchFeedProvider!
        .getSearchFeedData(context: context, isPaginationAvailable: false);
    searchFeedProvider!.scrollController.addListener(() {
      if (searchFeedProvider!.scrollController.position.atEdge) {
        bool isTop = searchFeedProvider!.scrollController.position.pixels == 0;
        if (isTop) {
          debugPrint('At the top');
        } else {
          searchFeedProvider!
              .getSearchFeedData(context: context, isPaginationAvailable: true);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    searchFeedProvider = Provider.of<SearchFeedProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search News"),
        centerTitle: true,
        backgroundColor: AppColors.accentColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(
              10.0,
            ),
            child: TextField(
              decoration: const InputDecoration(
                fillColor: Colors.grey,
                focusColor: Colors.grey,
                labelText: 'Search News Here!',
                labelStyle: TextStyle(color: AppColors.accentColor),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.accentColor,
                    width: 10.0,
                  ),
                ),
              ),
              controller: searchFeedProvider!.searchController,
              onSubmitted: (v) {
                searchFeedProvider!.getSearchFeedData(
                    context: context, isPaginationAvailable: false);
              },
            ),
          ),
          Expanded(
            child: searchFeedProvider!.articles!.isEmpty
                ? Container()
                : ListView.builder(
                    controller: searchFeedProvider!.scrollController,
                    itemCount: searchFeedProvider!.articles!.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.width / 4),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => NewsDetailScreen(
                                        articles: searchFeedProvider!
                                            .articles![index],
                                      )));
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: AppColors.skinColor,
                            gradient: LinearGradient(
                              colors: [
                                AppColors.greyColor,
                                AppColors.iconColor
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: searchNewsCard(index),
                        ),
                      );
                    }),
          ),
        ],
      ),
    );
  }

  Column searchNewsCard(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 8,
        ),
        textLarge(
          data: searchFeedProvider!.articles![index].title,
          maxLines: 2,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(
          height: 10,
        ),
        textLarge(
          data: searchFeedProvider!.articles![index].description,
          maxLines: 2,
          fontWeight: FontWeight.w400,
        ),
        const SizedBox(
          height: 8,
        ),
        textLarge(
          data: "Publish Date : ${DateFormat.yMd().add_jm().format(DateTime.parse(searchFeedProvider!.articles![index].publishedAt!.toString()))}",
          maxLines: 2,
          fontWeight: FontWeight.w700,
          fontSize: 12
        ),
      ],
    );
  }
}
