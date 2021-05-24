import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';

import '../../core/constants.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/themes.dart';
import '../../viewmodels/movie_search_screen_model.dart';
import '../widgets/custome_appbar.dart';

class MovieSearchScreen extends StatefulWidget {
  MovieSearchScreen({Key key}) : super(key: key);

  @override
  _MovieSearchScreenState createState() => _MovieSearchScreenState();
}

class _MovieSearchScreenState extends State<MovieSearchScreen> {
  double screenHeight, screenWidth;

  ScrollController _controller = ScrollController();

  FocusNode _textFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((Duration _) {
      print("object");
      FocusScope.of(context).requestFocus(_textFocusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return ViewModelBuilder<MovieSearchScreenModel>.reactive(
      viewModelBuilder: () => MovieSearchScreenModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: Size(screenWidth, 50),
              child: CustomeAppBar(
                controller: _controller,
                appBarTitle: Text(
                  "Search movie",
                  style: appTheme.textTheme.headline2,
                ),
                leadingWidget: IconButton(
                    onPressed: () => model.handleBackPress(),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: kColorWhite,
                    )),
              )),
          body: Column(
            children: [
              Container(
                width: screenWidth,
                margin: EdgeInsets.symmetric(
                    vertical: kLargeSpace, horizontal: kMediumSpace),
                decoration: BoxDecoration(
                  color: kColorGrey,
                  borderRadius: BorderRadius.circular(kRadius / 4),
                ),
                child: TextField(
                  focusNode: _textFocusNode,
                  onSubmitted: (String val) {
                    if (val.isEmpty) {
                      model.emptyList();
                    } else {
                      model.searchMovies(val);
                    }
                  },
                  maxLines: 1,
                  cursorColor: kColorBlue,
                  style: appTheme.textTheme.bodyText1,
                  keyboardType: TextInputType.text,
                  buildCounter: (BuildContext context,
                          {int currentLength, int maxLength, bool isFocused}) =>
                      null,
                  decoration: InputDecoration(
                    labelText: "Movie name",
                    labelStyle: appTheme.textTheme.bodyText1
                        .copyWith(color: kColorTextWhite),
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                    contentPadding: EdgeInsets.only(
                        left: kLargeSpace,
                        right: kMediumSpace,
                        top: kMediumSpace,
                        bottom: kMediumSpace),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: model.isBusy
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          child: SingleChildScrollView(
                            padding:
                                EdgeInsets.symmetric(horizontal: kMediumSpace),
                            physics: BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            child: ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                      onTap: () => model.handleMovieTileTap(
                                          model.searchMovieList[index]),
                                      child: Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: screenWidth / 4,
                                              child: Image.network(
                                                kbaseImgUrl +
                                                    model.searchMovieList[index]
                                                        .posterPath,
                                                loadingBuilder: (context, child,
                                                    loadingProgress) {
                                                  if (loadingProgress == null)
                                                    return child;
                                                  return Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
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
                                            SizedBox(width: kMediumSpace),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    model.searchMovieList[index]
                                                        .title,
                                                    style: appTheme
                                                        .textTheme.headline4,
                                                  ),
                                                  SizedBox(
                                                      height: kMediumSpace),
                                                  Text(
                                                    model.searchMovieList[index]
                                                        .overview,
                                                    style: appTheme
                                                        .textTheme.bodyText2,
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                separatorBuilder: (context, index) => Container(
                                      height: kDividerSize,
                                      width: double.infinity,
                                      color: kColorBlue,
                                      margin: EdgeInsets.symmetric(
                                          vertical: kMediumSpace),
                                    ),
                                itemCount: model.searchMovieList.length),
                          ),
                        ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
