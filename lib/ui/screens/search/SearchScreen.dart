import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Assume it's saved separately
import 'package:real_estate_app/common/widgets/property/property_card_horizontal.dart';
import 'package:real_estate_app/ui/controller/search_controller.dart';
import 'package:real_estate_app/ui/screens/search/widget/filter_screen.dart';
import 'package:real_estate_app/ui/screens/search/widget/property_card.dart';
import 'package:real_estate_app/utils/responsiveSize.dart';

import '../../../common/widgets/appbar/appbar.dart';
import '../../../utils/constants/AppIcon.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/ui_utils.dart';

class SearchScreen extends StatelessWidget {
  final controller = Get.put(CustomSearchController());

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Expanded(
          child: TextField(
            onChanged: (val) => controller.searchText.value = val,
            decoration: InputDecoration(
              hintText: 'Search your house...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => Get.to(() => FilterScreen()),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 20),

              // Recent Searches
              if (controller.searchText.value.isEmpty) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Recent searches", style: TextStyle(fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () => controller.recentSearches.clear(),
                      child: Text("Clear", style: TextStyle(color: TColors.primary)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Column(
                  children: controller.recentSearches.map((item) {
                    return ListTile(
                      leading: Icon(Icons.history, color: Colors.grey),
                      title: Text(item),
                      trailing: IconButton(
                        icon: Icon(Icons.close, size: 18),
                        onPressed: () => controller.removeRecent(item),
                      ),
                    );
                  }).toList(),
                ),
              ],

              // Popular Properties
              if (controller.filteredProperties.isNotEmpty) ...[
                const SizedBox(height: 10),
                Text("Popular Properties", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
              ],
              Expanded(
                child: ListView.builder(
                  itemCount: controller.filteredProperties.length,
                  itemBuilder: (context, index) {
                    final item = controller.filteredProperties[index];
                    return TPropertyCardHorizontal(property: item);
                  },
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}


