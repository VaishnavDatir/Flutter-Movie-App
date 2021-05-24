import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class StarDisplayWidget extends StatelessWidget {
  final int value;

  const StarDisplayWidget({
    Key key,
    this.value = 0,
  })  : assert(value != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    final Widget filledStar = Icon(
      Icons.star,
      color: kColorYellow,
    );
    final Widget unfilledStar = Icon(
      Icons.star_border,
      color: kColorYellow,
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return index < value ? filledStar : unfilledStar;
      }),
    );
  }
}

class StarDisplay extends StarDisplayWidget {
  const StarDisplay({Key key, int value = 0})
      : super(
          key: key,
          value: value,
        );
}
