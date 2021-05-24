import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../core/constants.dart';
import '../../core/models/movie_model.dart';
import '../../core/util.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/themes.dart';
import '../../viewmodels/movie_detail_model.dart';
import '../widgets/custome_appbar.dart';
import '../widgets/custome_star_rating.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieModel movieModel;
  MovieDetailScreen(this.movieModel);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  ScrollController _controller = ScrollController();

  bool showTitle = false;
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        showTitle = (_controller.offset > 500) ? true : false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight, screenWidth;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: ViewModelBuilder<MovieDetailModel>.reactive(
        viewModelBuilder: () => MovieDetailModel(),
        onModelReady: (model) =>
            model.initializeMovieDetailScreen(widget.movieModel),
        builder: (context, model, child) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: PreferredSize(
                preferredSize: Size(screenWidth, 50),
                child: CustomeAppBar(
                  controller: _controller,
                  centerTitle: true,
                  appBarTitle: AnimatedOpacity(
                    opacity: showTitle ? 1 : 0,
                    duration: Duration(milliseconds: 250),
                    child: Text(
                      widget.movieModel.title,
                      style: appTheme.textTheme.headline3,
                    ),
                  ),
                  actionWidgetList: [
                    IconButton(
                      icon: Icon(
                        Icons.share,
                        color: kColorWhite,
                      ),
                      onPressed: () => model.handleBackPress(),
                    )
                  ],
                  leadingWidget: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: kColorWhite,
                    ),
                    onPressed: () => model.handleBackPress(),
                  ),
                )),
            body: model.isBusy
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    controller: _controller,
                    child: Column(
                      children: [
                        //Top Container
                        Container(
                          child: Stack(
                            children: [
                              Container(
                                width: screenHeight,
                                height: screenHeight / 2.2,
                              ),
                              Container(
                                child: Stack(
                                  children: [
                                    Container(
                                      width: screenWidth,
                                      height: screenHeight / 3.5,
                                      child: Image.network(
                                        kbaseImgUrl +
                                            "${(widget.movieModel.backdropPath == null) ? widget.movieModel.posterPath.toString() : widget.movieModel.backdropPath.toString()}",
                                        fit: BoxFit.cover,
                                        filterQuality: FilterQuality.high,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Center(
                                            child: CircularProgressIndicator(
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
                                      height: screenHeight / 3.5,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.black,
                                            Colors.transparent,
                                            Colors.transparent,
                                            Colors.black54,
                                          ],
                                          stops: [0.0, 0.3, 0.7, 1.0],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 2,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 130,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: kLargeSpace),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: kColorWhite, width: 2)),
                                        child: Image.network(
                                          kbaseImgUrl +
                                              widget.movieModel.posterPath,
                                          filterQuality: FilterQuality.high,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
                                            return Center(
                                              child: CircularProgressIndicator(
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
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: kSmallSpace,
                                      ),
                                      child: Column(
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                "Release date",
                                              ),
                                              Text(
                                                widget.movieModel.releaseDate
                                                    .toString(),
                                                style: appTheme
                                                    .textTheme.bodyText1
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                          (model.curMovieDetails.runtime != 0)
                                              ? Column(
                                                  children: [
                                                    SizedBox(height: kXLSpace),
                                                    Text("Length"),
                                                    Text(
                                                      "${durationToString(model.curMovieDetails.runtime)}",
                                                      style: appTheme
                                                          .textTheme.bodyText1
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                  ],
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              model.isVidoeAvailable
                                  ? Positioned(
                                      bottom: 5,
                                      right: kSmallIconSize,
                                      child: FloatingActionButton(
                                        onPressed: () =>
                                            model.handlePlayBtnTap(),
                                        child: Icon(
                                          Icons.play_arrow_rounded,
                                          size: kIconSize + 4,
                                        ),
                                      ))
                                  : Container(),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: kLargeSpace, vertical: kLargeSpace),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              (model.curMovieDetails.spokenLanguages.length !=
                                      0)
                                  ? Container(
                                      width: double.infinity,
                                      child: Wrap(
                                        spacing: kSmallSpace,
                                        runSpacing: kMediumSpace,
                                        children: List<Widget>.generate(
                                            model.curMovieDetails
                                                .spokenLanguages.length,
                                            (index) => Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: kMediumSpace,
                                                    vertical: kSmallSpace),
                                                color: kColorBlue,
                                                child: Text(model
                                                    .curMovieDetails
                                                    .spokenLanguages[index]
                                                    .englishName))),
                                      ),
                                    )
                                  : Container(),
                              SizedBox(height: kMediumSpace),
                              (widget.movieModel.voteAverage != 0.0)
                                  ? Row(
                                      children: [
                                        Text(widget.movieModel.voteAverage
                                                .toString() +
                                            "/10  •  "),
                                        StarDisplayWidget(
                                          value:
                                              (widget.movieModel.voteAverage /
                                                      2)
                                                  .round(),
                                        ),
                                      ],
                                    )
                                  : Container(),
                              SizedBox(height: kMediumSpace),
                              Container(
                                width: double.infinity,
                                child: Wrap(
                                  spacing: kSmallSpace,
                                  runSpacing: kMediumSpace,
                                  children: List<Widget>.generate(
                                      model.curMovieDetails.genres.length,
                                      (index) => InkWell(
                                            onTap: () => model.handleGenreTap(
                                                model.curMovieDetails
                                                    .genres[index]),
                                            child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: kMediumSpace,
                                                    vertical: kSmallSpace),
                                                color: kColorGrey,
                                                child: Text(model
                                                    .curMovieDetails
                                                    .genres[index]
                                                    .name)),
                                          )),
                                ),
                              ),
                              SizedBox(height: kMediumSpace),
                              Text(
                                widget.movieModel.title,
                                style: appTheme.textTheme.headline3,
                              ),
                              SizedBox(height: kMediumSpace),
                              Text(
                                widget.movieModel.overview,
                                style: appTheme.textTheme.bodyText2,
                              ),
                              SizedBox(height: kLargeSpace),
                              Container(
                                width: screenWidth / 3,
                                height: kDividerSize,
                                color: kColorBlue,
                              ),
                              SizedBox(height: kMediumSpace),
                              (model.curMovieCast.length != 0)
                                  ? Container(
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Cast",
                                            style: appTheme.textTheme.headline3,
                                          ),
                                          SizedBox(height: kSmallSpace),
                                          Container(
                                            height: 205,
                                            width: double.infinity,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount:
                                                  model.curMovieCast.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    model.handlePersonTap(model
                                                        .curMovieCast[index]
                                                        .id);
                                                  },
                                                  child: Container(
                                                    width: 130,
                                                    margin: EdgeInsets.only(
                                                        right: kMediumSpace),
                                                    padding: EdgeInsets.all(
                                                        kSmallSpace),
                                                    decoration: BoxDecoration(
                                                        color: kColorGrey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    kRadius /
                                                                        4)),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          height: 150,
                                                          width: 130,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        kRadius /
                                                                            4),
                                                            child:
                                                                Image.network(
                                                              /* kbaseImgUrl +
                                                                  model
                                                                      .curMovieCast[
                                                                          index]
                                                                      .profilePath
                                                                      .toString(), */
                                                              model
                                                                          .curMovieCast[
                                                                              index]
                                                                          .profilePath ==
                                                                      null
                                                                  ? kNullImgURL
                                                                  : (kbaseImgUrl +
                                                                      model
                                                                          .curMovieCast[
                                                                              index]
                                                                          .profilePath
                                                                          .toString()),
                                                              filterQuality:
                                                                  FilterQuality
                                                                      .high,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: kSmallSpace,
                                                        ),
                                                        Text(
                                                          model
                                                              .curMovieCast[
                                                                  index]
                                                              .name,
                                                          style: appTheme
                                                              .textTheme
                                                              .bodyText2
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        Text(
                                                          model
                                                              .curMovieCast[
                                                                  index]
                                                              .character,
                                                          style: appTheme
                                                              .textTheme
                                                              .bodyText2,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.center,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(height: kMediumSpace),
                                        ],
                                      ),
                                    )
                                  : Container(),
                              SizedBox(height: kLargeSpace),
                              Container(
                                width: screenWidth / 3,
                                height: kDividerSize,
                                color: kColorBlue,
                              ),
                              SizedBox(height: kLargeSpace),
                              (model.similarMoviesList.length != 0)
                                  ? Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Similar movies",
                                            style: appTheme.textTheme.headline3,
                                          ),
                                          SizedBox(height: kMediumSpace),
                                          GridView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3,
                                                    childAspectRatio: 4 / 6,
                                                    crossAxisSpacing:
                                                        kMediumSpace,
                                                    mainAxisSpacing:
                                                        kMediumSpace),
                                            itemCount:
                                                model.similarMoviesList.length,
                                            itemBuilder: (context, index) {
                                              return ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        kRadius / 4),
                                                child: InkWell(
                                                  onTap: () => model
                                                      .handleSimilarMoviesTap(
                                                          model.similarMoviesList[
                                                              index]),
                                                  child: Container(
                                                    child: Image.network(
                                                      kbaseImgUrl +
                                                          model
                                                              .similarMoviesList[
                                                                  index]
                                                              .posterPath,
                                                      loadingBuilder: (context,
                                                          child,
                                                          loadingProgress) {
                                                        if (loadingProgress ==
                                                            null) return child;
                                                        return Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      kXXLSpace),
                                                          child: Center(
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
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
