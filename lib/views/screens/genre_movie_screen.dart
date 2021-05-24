import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../core/constants.dart';
import '../../core/models/genre_model.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/themes.dart';
import '../../viewmodels/genre_screen_model.dart';
import '../widgets/custome_appbar.dart';

class GenreMoveScreen extends StatefulWidget {
  final Genres genre;
  GenreMoveScreen(this.genre);

  @override
  _GenreMoveScreenState createState() => _GenreMoveScreenState();
}

class _GenreMoveScreenState extends State<GenreMoveScreen> {
  ScrollController _controller = ScrollController();

  bool showTitle = false;
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        showTitle = (_controller.offset > 50) ? true : false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return ViewModelBuilder<GenreScreenModel>.reactive(
      viewModelBuilder: () => GenreScreenModel(),
      onModelReady: (model) => model.initializeGenreScreen(widget.genre.id),
      builder: (context, model, child) {
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: Size(screenWidth, 50),
              child: CustomeAppBar(
                controller: _controller,
                centerTitle: true,
                appBarTitle: AnimatedOpacity(
                  opacity: showTitle ? 1 : 0,
                  duration: Duration(milliseconds: 250),
                  child: Text(
                    widget.genre.name + " movies",
                    style: appTheme.textTheme.headline3,
                  ),
                ),
                leadingWidget: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: kColorWhite,
                  ),
                  onPressed: () => model.handleBackPress(),
                ),
              )),
          body: model.isBusy
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  controller: _controller,
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  padding: EdgeInsets.symmetric(
                      vertical: kLargeSpace, horizontal: kMediumSpace),
                  child: Container(
                    width: screenWidth,
                    child: Column(
                      children: [
                        Text(
                          widget.genre.name.toString() + " movies",
                          style: appTheme.textTheme.headline3,
                        ),
                        SizedBox(height: kMediumSpace),
                        Container(
                          width: screenWidth / 3,
                          height: kDividerSize,
                          color: kColorBlue,
                        ),
                        SizedBox(height: kLargeSpace),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 4 / 6,
                                  crossAxisSpacing: kMediumSpace,
                                  mainAxisSpacing: kMediumSpace),
                          itemCount: model.genreMovieList.length,
                          itemBuilder: (context, index) => ClipRRect(
                            borderRadius: BorderRadius.circular(kRadius / 4),
                            child: InkWell(
                              onTap: () => model
                                  .handleMovieTap(model.genreMovieList[index]),
                              child: Container(
                                child: Image.network(
                                  kbaseImgUrl +
                                      model.genreMovieList[index].posterPath,
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
                                                  loadingProgress
                                                      .expectedTotalBytes
                                              : null,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                /* child: FadeInImage(
                                                      placeholder: AssetImage(
                                                          "assets/images/ShowPickupTrans.png"),
                                                      image: NetworkImage(
                                                          kbaseImgUrl +
                                                              model
                                                                  .similarMoviesList[
                                                                      index]
                                                                  .posterPath),
                                                    ), */
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
