import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/themes.dart';
import '../../viewmodels/movie_video_screen_model.dart';
import '../widgets/custome_appbar.dart';

class MovieVideoScreen extends StatefulWidget {
  final Map<String, dynamic> movieVideoScreenData;
  MovieVideoScreen(this.movieVideoScreenData);

  @override
  _MovieVideoScreenState createState() => _MovieVideoScreenState();
}

class _MovieVideoScreenState extends State<MovieVideoScreen> {
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return ViewModelBuilder<MovieVideosScreenViewModel>.reactive(
      viewModelBuilder: () => MovieVideosScreenViewModel(),
      onModelReady: (model) =>
          model.initializeMovieVideoScreen(widget.movieVideoScreenData),
      builder: (context, model, child) {
        if (model.isBusy) {
          return Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Scaffold(
            appBar: PreferredSize(
                preferredSize: Size(screenWidth, 50),
                child: CustomeAppBar(
                  controller: _controller,
                  centerTitle: true,
                  appBarTitle: Text(
                    model.movieName,
                    style: appTheme.textTheme.headline3,
                  ),
                  leadingWidget: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: kColorWhite,
                    ),
                    onPressed: () => model.handleBackPress(),
                  ),
                )),
            body: SingleChildScrollView(
              controller: _controller,
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              padding: EdgeInsets.symmetric(
                  vertical: kLargeSpace, horizontal: kMediumSpace),
              child: Container(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: model.movieVideosList.length,
                  separatorBuilder: (context, index) => Container(
                    margin: EdgeInsets.symmetric(vertical: kLargeSpace),
                    height: kDividerSize,
                    width: screenWidth / 2,
                    color: kColorBlue,
                  ),
                  itemBuilder: (context, index) => Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          child: YoutubePlayerIFrame(
                            controller: YoutubePlayerController(
                              initialVideoId: model.movieVideosList[index].key,
                              params: YoutubePlayerParams(
                                  autoPlay: false, showFullscreenButton: true),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: kMediumSpace,
                        ),
                        Text(
                          model.movieVideosList[index].name,
                          style: appTheme.textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
