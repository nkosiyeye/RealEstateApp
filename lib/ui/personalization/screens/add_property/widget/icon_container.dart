import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';

class TIconContainer extends StatelessWidget {
  const TIconContainer({
    super.key,
    required this.Icons,
  });

  final IconData? Icons;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(Icons, color: TColors.primary),
    );
  }
}