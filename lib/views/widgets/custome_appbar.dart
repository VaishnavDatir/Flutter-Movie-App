import 'package:flutter/material.dart';

class CustomeAppBar extends StatefulWidget {
  final ScrollController controller;
  final Widget appBarTitle;
  final Widget leadingWidget;
  final bool centerTitle;
  final List<Widget> actionWidgetList;
  CustomeAppBar(
      {this.controller,
      this.appBarTitle,
      this.actionWidgetList,
      this.leadingWidget,
      this.centerTitle = false});
  @override
  _CustomeAppBarState createState() => _CustomeAppBarState();
}

class _CustomeAppBarState extends State<CustomeAppBar> {
  double scrollOffset = 0.0;
  void initState() {
    widget.controller.addListener(() {
      setState(() {
        scrollOffset = widget.controller.offset;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: widget.appBarTitle,
      centerTitle: widget.centerTitle,
      backgroundColor: Colors.black
          .withOpacity((scrollOffset / 350).clamp(0, 0.85).toDouble()),
      actions: widget.actionWidgetList,
      leading: widget.leadingWidget,
    );
  }
}
