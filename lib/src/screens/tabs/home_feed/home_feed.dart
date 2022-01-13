import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/src/config/app_colors.dart';
import 'package:news_app/src/screens/news_detail/news_detail_screen.dart';
import 'package:news_app/src/screens/tabs/home_feed/home_feed_provider.dart';
import 'package:news_app/src/widgets/image_view.dart';
import 'package:news_app/src/widgets/text_view.dart';
import 'package:provider/provider.dart';

class HomeFeed extends StatefulWidget {
  const HomeFeed({Key? key}) : super(key: key);

  @override
  _HomeFeedState createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> {
  HomeFeedProvider? homeFeedProvider;

  @override
  void initState() {
    homeFeedProvider = Provider.of<HomeFeedProvider>(context, listen: false);
    homeFeedProvider!.getHomeFeedData(context: context);
    homeFeedProvider!.scrollController.addListener(() {
      if (homeFeedProvider!.scrollController.position.atEdge) {
        bool isTop = homeFeedProvider!.scrollController.position.pixels == 0;
        if (isTop) {
          debugPrint('At the top');
        } else {
          homeFeedProvider!.getHomeFeedData(context: context);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    homeFeedProvider = Provider.of<HomeFeedProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily News"),
        centerTitle: true,
        backgroundColor: AppColors.accentColor,
      ),
      body: homeFeedProvider!.articles!.isEmpty
          ? Container()
          : ListView.builder(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.width / 4),
              controller: homeFeedProvider!.scrollController,
              itemCount: homeFeedProvider!.articles!.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => NewsDetailScreen(
                                  articles: homeFeedProvider!.articles![index],
                                )));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppColors.skinColor,
                      gradient: LinearGradient(
                        colors: [AppColors.whiteColor, AppColors.iconColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: newsFeedCard(context, index),
                  ),
                );
              }),
    );
  }

  Column newsFeedCard(BuildContext context, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        imageView(
          context: context,
          imageURL: homeFeedProvider!.articles![index].urlToImage,
          title: homeFeedProvider!.articles![index].title,
          height: MediaQuery.of(context).size.height / 3.5,
          width: MediaQuery.of(context).size.width,
        ),
        const SizedBox(
          height: 8.0,
        ),
        textLarge(
          data: homeFeedProvider!.articles![index].title,
          maxLines: 2,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(
          height: 10,
        ),
        textLarge(
          data: homeFeedProvider!.articles![index].description ?? "--",
          maxLines: 2,
          fontWeight: FontWeight.w400,
        ),
        const SizedBox(
          height: 8.0,
        ),
        textLarge(
            data: "Publish Date : ${DateFormat.yMd().add_jm().format(DateTime.parse(homeFeedProvider!.articles![index].publishedAt!.toString()))}",
            maxLines: 2,
            fontWeight: FontWeight.w700,
            fontSize: 12),
      ],
    );
  }
}
