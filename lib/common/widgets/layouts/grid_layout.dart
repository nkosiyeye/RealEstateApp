import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class TGridLayout extends StatelessWidget {
  const TGridLayout({
    super.key, required this.itemCount, this.mainAxisExtent = 270, required this.itemBuilder, this.crossAxisSpacing = TSizes.gridViewSpacing, this.mainAxisSpacing = TSizes.gridViewSpacing, this.crossAxisCount = 2,
  });
  final int itemCount;
  final double? mainAxisExtent;
  final double? crossAxisSpacing;
  final double? mainAxisSpacing ;
  final int? crossAxisCount;
  final Widget? Function(BuildContext, int) itemBuilder;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: itemCount,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount!,
          mainAxisSpacing: mainAxisSpacing!,
          crossAxisSpacing: crossAxisSpacing!,
          mainAxisExtent: mainAxisExtent,
        ),
        itemBuilder: itemBuilder
    );
  }
}