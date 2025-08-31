import 'package:flutter/material.dart';
import 'package:real_estate_app/ui/theme/theme.dart';
import 'package:real_estate_app/utils/constants/colors.dart';
import 'package:real_estate_app/utils/extensions/build_context.dart';
import 'package:real_estate_app/utils/extensions/textWidgetExtention.dart';

import '../../../utils/ui_utils.dart';

enum PromoteCardType { text, icon }

class PromotedCard extends StatelessWidget {
  final PromoteCardType type;
  final Color? color;
  const PromotedCard({super.key, required this.type, this.color});

  @override
  Widget build(BuildContext context) {
    if (type == PromoteCardType.icon) {
      return Container(
        width: 64,
        height: 24,
        decoration: BoxDecoration(
            color: color ?? TColors.accent,
            borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Center(
            child: Text("featured")
                .color(
                  TColors.white,
                )
                .bold()
                .size(context.font.smaller),
          ),
        ),
      );
    }

    return Container(
      width: 64,
      height: 24,
      decoration: BoxDecoration(
          color: TColors.accent,
          borderRadius: BorderRadius.circular(4)),
      child: Center(
        child: Text("featured")
            .color(
              TColors.white,
            )
            .bold()
            .size(context.font.smaller),
      ),
    );
  }
}
