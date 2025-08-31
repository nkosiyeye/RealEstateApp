import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:real_estate_app/utils/constants/colors.dart';
import 'package:real_estate_app/utils/responsiveSize.dart';

import '../../../../../data/helper/design_configs.dart';
import '../../../../../utils/ui_utils.dart';
import '../../../model/category_model.dart';

class CategoryCard extends StatelessWidget {
  final bool? frontSpacing;
  final Function(CategoryModel category) onTapCategory;
  final CategoryModel category;
  const CategoryCard(
      {super.key,
      required this.frontSpacing,
      required this.onTapCategory,
      required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: frontSpacing == true ? 5.0 : 0,
        end: .0,
      ),
      child: GestureDetector(
        onTap: () {
          onTapCategory.call(category);
        },
        child: Row(
          children: <Widget>[
            Container(
              constraints: BoxConstraints(
                minWidth: 100.rw(context),
              ),
              height: 44.rh(context),
              alignment: Alignment.center,
              decoration: DesignConfig.boxDecorationBorder(
                color: TColors.textWhite,
                radius: 10,
                borderWidth: 1.5,
                borderColor: TColors.lightGrey,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.network(category.image,
                        width: 20,
                        height: 20,
                        color: TColors.primary,
                      fit: BoxFit.contain),
                    SizedBox(width: 12.rw(context)),
                    SizedBox(
                      child: Text(
                        category.name,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12.0, // Replace with the desired font size
                          color: Colors.black, // Replace with the desired text color
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
