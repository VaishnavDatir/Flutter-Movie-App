import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../core/constants.dart';
import '../../core/models/movie_model.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/themes.dart';
import '../widgets/custome_appbar.dart';
import '../../viewmodels/home_screen_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double screenHeight, screenWidth;

  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return ViewModelBuilder<HomeScreenModel>.reactive(
      viewModelBuilder: () => HomeScreenModel(),
      onModelReady: (model) => model.initializeHomeScreen(),
      builder: (context, model, child) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
              preferredSize: Size(screenWidth, 50),
              child: CustomeAppBar(
                controller: _controller,
                appBarTitle: Text(
                  "Show Pickup",
                  style: appTheme.textTheme.headline2,
                ),
                actionWidgetList: [
                  IconButton(
                      onPressed: () => model.handleSearchTap(),
                      icon: Icon(
                        Icons.search,
                        color: kColorWhite,
                      ))
                ],
              )),
          body: model.isBusy
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : (model.trendingMovieList.isNotEmpty ||
                      model.trendingMovieList.length != 0 ||
                      model.topRatedMovieList.isNotEmpty ||
                      model.topRatedMovieList.length != 0 ||
                      model.popularMovieList.isNotEmpty ||
                      model.popularMovieList.length != 0)
                  ? Container(
                      child: SingleChildScrollView(
                        controller: _controller,
                        child: Column(
                          children: [
                            //Top Carousel
                            (model.trendingMovieList.isEmpty)
                                ? Container()
                                : Container(
                                    height: screenHeight / 1.5,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.only(
                                              bottom: screenHeight / 9),
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                height: double.infinity,
                                                child: Image.network(
                                                  kbaseImgUrl +
                                                      model
                                                          .trendingMovieList[
                                                              model.carIndex]
                                                          .posterPath,
                                                  fit: BoxFit.cover,
                                                  filterQuality:
                                                      FilterQuality.high,
                                                  loadingBuilder: (context,
                                                      child, loadingProgress) {
                                                    if (loadingProgress == null)
                                                      return child;
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        value: loadingProgress
                                                                    .expectedTotalBytes !=
                                                                null
                                                            ? loadingProgress
                                                                    .cumulativeBytesLoaded /
                                                                loadingProgress
                                                                    .expectedTotalBytes
                                                            : null,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Colors.black,
                                                      Colors.black38
                                                    ],
                                                    stops: [0.0, 1.0],
                                                    begin:
                                                        Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                  ),
                                                ),
                                              ),
                                              BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaX: 3, sigmaY: 3),
                                                child: Container(
                                                  width: screenWidth,
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: CarouselSlider.builder(
                                            itemCount: 5,
                                            options: CarouselOptions(
                                                autoPlay: true,
                                                // height: screenHeight / 2.5,
                                                viewportFraction: 0.65,
                                                aspectRatio: 4 / 4,
                                                onPageChanged: (index, reason) {
                                                  model.onCarousalChange(index);
                                                },
                                                enlargeCenterPage: true),
                                            itemBuilder:
                                                (context, index, realIndex) {
                                              return Container(
                                                height: double.infinity,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    kRadius /
                                                                        4),
                                                        child: InkWell(
                                                          onTap: () => model
                                                              .handleMovieTileTap(
                                                                  model.trendingMovieList[
                                                                      index]),
                                                          child: Container(
                                                            child:
                                                                Image.network(
                                                              kbaseImgUrl +
                                                                  model
                                                                      .trendingMovieList[
                                                                          index]
                                                                      .posterPath,
                                                              filterQuality:
                                                                  FilterQuality
                                                                      .high,
                                                              loadingBuilder:
                                                                  (context,
                                                                      child,
                                                                      loadingProgress) {
                                                                if (loadingProgress ==
                                                                    null)
                                                                  return child;
                                                                return Container(
                                                                  margin: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              kXXLSpace),
                                                                  child: Center(
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      value: loadingProgress.expectedTotalBytes !=
                                                                              null
                                                                          ? loadingProgress.cumulativeBytesLoaded /
                                                                              loadingProgress.expectedTotalBytes
                                                                          : null,
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: kMediumSpace,
                                                    ),
                                                    Text(
                                                      model
                                                          .trendingMovieList[
                                                              index]
                                                          .title,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: appTheme
                                                          .textTheme.bodyText1,
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                            //Divider
                            Container(
                              margin:
                                  EdgeInsets.symmetric(vertical: kLargeSpace),
                              height: kSmallSpace,
                              width: screenWidth / 3,
                              color: kColorBlue,
                            ),
                            SizedBox(height: kMediumSpace),
                            Container(
                              width: double.infinity,
                              height: 38,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: model.genresMovieList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () => model.handleGenreTap(
                                        model.genresMovieList[index]),
                                    child: Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: kSmallSpace,
                                            horizontal: kSmallSpace),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: kMediumSpace,
                                            vertical: kSmallSpace),
                                        color: kColorDarkBlue,
                                        child: Text(
                                            model.genresMovieList[index].name)),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: kLargeSpace),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: kMediumSpace),
                                height: kDividerSize,
                                width: screenWidth / 3,
                                color: kColorBlue,
                              ),
                            ),
                            SizedBox(height: kMediumSpace),

                            //Popular Movies
                            (model.popularMovieList.isEmpty)
                                ? Container()
                                : HorizontalMovieListWidget(
                                    title: "Popular movies",
                                    movieList: model.popularMovieList,
                                    onTap: model.handleMovieTileTap,
                                  ),
                            SizedBox(height: kLargeSpace),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.only(left: kMediumSpace),
                                width: screenWidth / 3,
                                height: kDividerSize,
                                color: kColorBlue,
                              ),
                            ),
                            SizedBox(height: kMediumSpace),
                            //Top Rated Movies
                            (model.topRatedMovieList.isEmpty)
                                ? Container()
                                : HorizontalMovieListWidget(
                                    title: "Top rated movies",
                                    movieList: model.topRatedMovieList,
                                    onTap: model.handleMovieTileTap,
                                  ),
                            SizedBox(height: kLargeSpace),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.only(left: kMediumSpace),
                                  width: screenWidth / 3,
                                  height: kDividerSize,
                                  color: kColorBlue,
                                )),
                            SizedBox(height: kMediumSpace),
                            //Trending Movies
                            (model.trendingMovieList.isEmpty)
                                ? Container()
                                : HorizontalMovieListWidget(
                                    title: "Trending movies",
                                    movieList: model.trendingMovieList,
                                    onTap: model.handleMovieTileTap,
                                  ),
                            SizedBox(height: kLargeSpace),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.only(left: kMediumSpace),
                                  width: screenWidth / 3,
                                  height: kDividerSize,
                                  color: kColorBlue,
                                )),
                            SizedBox(height: kMediumSpace),
                            //Trending Movies
                            (model.nowPlayingMovieList.isEmpty)
                                ? Container()
                                : HorizontalMovieListWidget(
                                    title: "Now playing movies",
                                    movieList: model.nowPlayingMovieList,
                                    onTap: model.handleMovieTileTap,
                                  ),
                            SizedBox(height: kLargeSpace),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.only(left: kMediumSpace),
                                  width: screenWidth / 3,
                                  height: kDividerSize,
                                  color: kColorBlue,
                                )),

                            SizedBox(height: kMediumSpace),

                            (model.upComingMovieList.isEmpty)
                                ? Container()
                                : HorizontalMovieListWidget(
                                    title: "Upcoming movies",
                                    movieList: model.upComingMovieList,
                                    onTap: model.handleMovieTileTap,
                                  ),
                            SizedBox(height: kLargeSpace),
                          ],
                        ),
                      ),
                    )
                  : BottomAlertBox(
                      isError: true,
                      title: "Uh oh!",
                      description:
                          "We could not get the movies.\nPlease try again later",
                      btnLeftText: "Exit",
                      btnLeftFun: model.handleBtnLftTap,
                      btnRightText: "Retry",
                      btnRightFun: model.handleBtnRgtTap,
                    ),
        );
      },
    );
  }
}

class HorizontalMovieListWidget extends StatelessWidget {
  final String title;
  final List<MovieModel> movieList;
  final Function onTap;

  HorizontalMovieListWidget({
    this.title,
    this.movieList,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kMediumSpace),
            child: Text(
              title,
              style: appTheme.textTheme.headline2,
            ),
          ),
          SizedBox(height: kMediumSpace),
          Container(
            width: double.infinity,
            height: 200,
            child: ListView.builder(
              itemCount: movieList.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return (movieList[index].posterPath == null)
                    ? Container()
                    : Container(
                        margin: EdgeInsets.symmetric(horizontal: kSmallSpace),
                        height: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(kRadius / 4),
                          child: InkWell(
                            onTap: () => onTap(movieList[index]),
                            child: Image.network(
                              kbaseImgUrl + movieList[index].posterPath,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: kXXLSpace),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress
                                                  .expectedTotalBytes !=
                                              null
                                          ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes
                                          : null,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
              },
            ),
          )
        ],
      ),
    );
  }
}

class BottomAlertBox extends StatelessWidget {
  final bool isError;
  final String title;
  final String description;
  final String btnLeftText;
  final String btnRightText;
  final Function btnLeftFun;
  final Function btnRightFun;

  BottomAlertBox({
    @required this.isError,
    @required this.title,
    @required this.description,
    this.btnLeftText,
    this.btnRightText,
    this.btnLeftFun,
    this.btnRightFun,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Spacer(),
          Card(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(
                  kLargeSpace, kLargeSpace, kLargeSpace, kSmallSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: appTheme.textTheme.headline2
                        .copyWith(color: isError ? kColorRed : kColorGreen),
                  ),
                  SizedBox(height: kMediumSpace),
                  Text(
                    description,
                    style: appTheme.textTheme.bodyText1,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: (btnLeftText != null)
                            ? TextButton(
                                onPressed: btnLeftFun, child: Text(btnLeftText))
                            : Container(),
                      ),
                      Expanded(
                        child: (btnRightText != null)
                            ? TextButton(
                                onPressed: btnRightFun,
                                child: Text(btnRightText))
                            : Container(),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
