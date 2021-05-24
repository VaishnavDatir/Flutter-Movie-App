import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../core/constants.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/themes.dart';
import '../../viewmodels/personinfo_screen_model.dart';
import '../widgets/custome_appbar.dart';

class PersonInfoScreen extends StatefulWidget {
  final int personId;
  PersonInfoScreen(this.personId);

  @override
  _PersonInfoScreenState createState() => _PersonInfoScreenState();
}

class _PersonInfoScreenState extends State<PersonInfoScreen> {
  ScrollController _controller = ScrollController();

  bool showTitle = false;
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        showTitle = (_controller.offset > 310) ? true : false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return ViewModelBuilder<PersonInfoScreenModel>.reactive(
      viewModelBuilder: () => PersonInfoScreenModel(),
      onModelReady: (model) =>
          model.initializePersonInfoScreen(widget.personId),
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
                  appBarTitle: AnimatedOpacity(
                    opacity: showTitle ? 1 : 0,
                    duration: Duration(milliseconds: 250),
                    child: Text(
                      model.personInfo.name,
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
            body: SingleChildScrollView(
              controller: _controller,
              physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: EdgeInsets.symmetric(
                  vertical: kLargeSpace, horizontal: kMediumSpace),
              child: Container(
                width: screenWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(kRadius / 4),
                      child: Container(
                        height: screenHeight / 3,
                        child: Image.network(
                          model.personInfo.profilePath == null
                              ? kNullImgURL
                              : (kbaseImgUrl +
                                  model.personInfo.profilePath.toString()),
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              margin:
                                  EdgeInsets.symmetric(horizontal: kXXLSpace),
                              child: Center(
                                child: CircularProgressIndicator(
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
                    SizedBox(height: kLargeSpace),
                    Text(
                      model.personInfo.name,
                      style: appTheme.textTheme.headline2,
                    ),
                    SizedBox(height: kLargeSpace),
                    Text(
                      model.personInfo.biography,
                      style: appTheme.textTheme.bodyText2,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: kLargeSpace),
                    Container(
                      width: screenWidth / 3,
                      height: kDividerSize,
                      color: kColorBlue,
                    ),
                    SizedBox(height: kLargeSpace),
                    (model.personMoviesList.length != 0)
                        ? Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Movies",
                                  style: appTheme.textTheme.headline3,
                                ),
                                SizedBox(height: kMediumSpace),
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
                                  itemCount: model.personMoviesList.length,
                                  itemBuilder: (context, index) {
                                    return ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(kRadius / 4),
                                      child: InkWell(
                                        onTap: () =>
                                            model.handlePersonMoviesTap(
                                                model.personMoviesList[index]),
                                        child: Container(
                                          child: Image.network(
                                            kbaseImgUrl +
                                                model.personMoviesList[index]
                                                    .posterPath,
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: kXXLSpace),
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
              ),
            ),
          );
        }
      },
    );
  }
}
