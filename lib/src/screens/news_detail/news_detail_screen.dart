import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/src/config/app_colors.dart';
import 'package:news_app/src/models/home_feed/news_model.dart' as nm;
import 'package:news_app/src/widgets/image_view.dart';
import 'package:news_app/src/widgets/text_view.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailScreen extends StatefulWidget {
  final nm.Articles? articles;

  const NewsDetailScreen({Key? key, @required this.articles}) : super(key: key);

  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News Details"),
        centerTitle: true,
        backgroundColor: AppColors.accentColor,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: imageView(
              context: context,
              imageURL: widget.articles!.urlToImage,
              title: widget.articles!.title,
              height: MediaQuery.of(context).size.height / 3.5,
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          textLarge(
            data: widget.articles!.title,
            maxLines: 2,
            leftPadding: 15,
            rightPadding: 15,
            topPadding: 20,
            bottomPadding: 20,
            fontWeight: FontWeight.w700,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: textLarge(
                  data: "Source : ${widget.articles!.source!.name}",
                  maxLines: 1,
                  leftPadding: 15,
                  bottomPadding: 20,
                  textColor: AppColors.backgroundColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              InkWell(
                onTap: _launchURL,
                child: textLarge(data: "Know More", textColor: AppColors.redColor, fontWeight: FontWeight.w500, fontSize: 12, rightPadding: 15),
              ),
            ],
          ),
          textLarge(
            data: "Publish Date : ${DateFormat.yMd().add_jm().format(DateTime.parse(widget.articles!.publishedAt!.toString()))}",
            maxLines: 2,
            leftPadding: 15,
            fontWeight: FontWeight.w700,
            textColor: AppColors.greyColor,
            fontSize: 12
          ),
          Container(width: double.infinity,height: 2,color: AppColors.greyColor.withOpacity(0.2),margin: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),),
          textLarge(
            data: widget.articles!.description ?? "--",
            maxLines: 20,
            leftPadding: 15,
            rightPadding: 15
          ),
          const SizedBox(
            height: 10,
          ),

        ],
      ),
    );
  }

  void _launchURL() async {
    if (!await launch(widget.articles!.url!)) throw 'Could not launch ${widget.articles!.url!}';
  }
}
