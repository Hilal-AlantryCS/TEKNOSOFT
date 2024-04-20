import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teknosoft/core/data/modules/task.dart';
import 'package:teknosoft/core/enums/text_style_type.dart';
import 'package:teknosoft/ui/shared/custom_widgets/custom_task_details.dart';
import 'package:teknosoft/ui/shared/custom_widgets/custom_text.dart';
import 'package:teknosoft/ui/shared/custom_widgets/custom_text_field.dart';
import 'package:teknosoft/ui/shared/utils.dart';
import 'package:teknosoft/ui/views/search_view/search_controller.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    MySearchController controller = Get.put(MySearchController());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(
            "Search Page",
            type: TextStyleType.TITLE,
          ),
          centerTitle: true,
        ),
        body: Obx(
          () {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.all(screenWidth(20)),
                  child: CustomTextFormField(
                    onChanged: (value) {
                      controller.searchByString(value);
                    },
                    controller: controller.searchController.value,
                    label: "Search",
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.searchTasks.length,
                    itemBuilder: (context, index) {
                      Task myTask = controller.searchTasks[index];
                      return CustomTaskDetails(myTask: myTask);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
