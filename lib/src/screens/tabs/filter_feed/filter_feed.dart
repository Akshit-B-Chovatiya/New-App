import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/src/config/app_colors.dart';
import 'package:news_app/src/screens/news_detail/news_detail_screen.dart';
import 'package:news_app/src/screens/tabs/filter_feed/filter_feed_provider.dart';
import 'package:news_app/src/widgets/text_view.dart';
import 'package:provider/provider.dart';

class FilterFeed extends StatefulWidget {
  const FilterFeed({Key? key}) : super(key: key);

  @override
  _FilterFeedState createState() => _FilterFeedState();
}

class _FilterFeedState extends State<FilterFeed> {
  FilterFeedProvider? filterFeedProvider;

  @override
  void initState() {
    filterFeedProvider = Provider.of<FilterFeedProvider>(context, listen: false);
    filterFeedProvider!.getFilterFeedData(context: context, isPaginationAvailable: false);
    filterFeedProvider!.scrollController.addListener(() {
      if (filterFeedProvider!.scrollController.position.atEdge) {
        bool isTop = filterFeedProvider!.scrollController.position.pixels == 0;
        if (isTop) {
          debugPrint('At the top');
        } else {
          filterFeedProvider!.getFilterFeedData(context: context, isPaginationAvailable: true);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    filterFeedProvider = Provider.of<FilterFeedProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter News"),
        centerTitle: true,
        backgroundColor: AppColors.accentColor,
      ),
      body: ListView(
        controller: filterFeedProvider!.scrollController,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          textLarge(data: "Categories", leftPadding: 15, topPadding: 10, bottomPadding: 10, textColor: AppColors.greyColor, fontSize: 15),
          Container(
            height: MediaQuery.of(context).size.width / 7,
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: filterFeedProvider!.filterCategories.length,
                itemBuilder: (BuildContext context, int index) {
                  return tagView(
                      onPressed: () {
                        filterFeedProvider!.selectedCategoryIndex = index;
                        filterFeedProvider!.getFilterFeedData(
                          context: context,
                          isPaginationAvailable: false,
                        );
                      },
                      isSelected: filterFeedProvider!.selectedCategoryIndex == index,
                      title: filterFeedProvider!.filterCategories[index]);
                }),
          ),
          textLarge(data: "Sort By", leftPadding: 15, topPadding: 10, bottomPadding: 10, textColor: AppColors.greyColor, fontSize: 15),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            height: MediaQuery.of(context).size.width / 7,
            child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: filterFeedProvider!.sortList.length,
                itemBuilder: (BuildContext context, int index) {
                  return tagView(
                      onPressed: () {
                        filterFeedProvider!.selectedSortIndex = index;
                        filterFeedProvider!.getFilterFeedData(context: context, isPaginationAvailable: false);
                      },
                      isSelected: filterFeedProvider!.selectedSortIndex == index,
                      title: filterFeedProvider!.sortList[index]);
                }),
          ),
          filterFeedProvider!.articles!.isEmpty
              ? Container()
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filterFeedProvider!.articles!.length,
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.width / 4),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => NewsDetailScreen(
                                      articles: filterFeedProvider!.articles![index],
                                    )));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: AppColors.skinColor,
                          gradient: LinearGradient(
                            colors: [AppColors.greyColor, AppColors.iconColor],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        child: filterNewsFeedBox(index),
                      ),
                    );
                  }),
        ],
      ),
    );
  }

  InkWell tagView({String? title, Function()? onPressed, bool? isSelected}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.only(right: 6),
        decoration: BoxDecoration(
          color: isSelected! ? AppColors.accentColor : AppColors.greyColor.withOpacity(0.3),
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              title!,
              style: TextStyle(
                color: isSelected ? AppColors.whiteColor : AppColors.blackColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column filterNewsFeedBox(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 8,
        ),
        textLarge(
          data: filterFeedProvider!.articles![index].title,
          maxLines: 2,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(
          height: 10,
        ),
        textLarge(
          data: filterFeedProvider!.articles![index].description ?? "--`",
          maxLines: 2,
          fontWeight: FontWeight.w400,
        ),
        const SizedBox(
          height: 8,
        ),
        textLarge(
          data: "Publish Date : ${DateFormat.yMd().add_jm().format(DateTime.parse(filterFeedProvider!.articles![index].publishedAt!.toString()))}",
          maxLines: 2,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ],
    );
  }
}
