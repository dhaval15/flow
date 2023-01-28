import 'package:flutter/material.dart';

/* class CustomOptionView extends MultiChildLayoutDelegate {
  static const String idPrefix = 'OPTION';
  final List<int> countsPerRow;
  final int itemCount;

   CustomOptionView({
    required this.itemCount,
    required this.countsPerRow,
  });

  @override
  void performLayout(Size size) {
    int total = 0;
    for(int i=0; i < countsPerRow.length; i++){
      final count = countsPerRow[i];
      final rowSize = Size(size.width/ count, size.height);
      for(int j = total; j < count; j++){
        final layoutId = '$idPrefix$j';
        if(hasChild(layoutId)){
          final Size optionSize =
            layoutChild(layoutId, BoxConstraints.loose(rowSize));
          positionChild(
          layoutId,
          Offset(),
        );
        }
      }
      total = total + count;
    }
    for (int i = 0; i < itemCount; i++) {
      final String layoutId = '$idPrefix$i';
      if (hasChild(layoutId)) {
        final Size optionSize =
            layoutChild(layoutId, BoxConstraints.loose(size));
        final double itemAngle = _calculateItemAngle(i);

        positionChild(
          actionButtonId,
          Offset(
            (center.dx - buttonSize.width / 2) + (radius) * Math.cos(itemAngle),
            (center.dy - buttonSize.height / 2) +
                (radius) * Math.sin(itemAngle),
          ),
        );
      }
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    // TODO: implement shouldRelayout
    throw UnimplementedError();
  }
}
 */
