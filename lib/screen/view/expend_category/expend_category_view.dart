import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pos_and_ecommerce/model/pos/expend_category.dart';
import 'package:pos_and_ecommerce/utils/theme.dart';

import '../../../controller/home_controller.dart';
import '../../../widgets/pos/button/button.dart';
import '../../../widgets/pos/input/input.dart';
import '../../../widgets/textfield/textfield.dart';

class ExpendCategoryView extends StatelessWidget {
  const ExpendCategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController _homeController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expend Category"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
        ),
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: ExTextField(
                      id: "category_name",
                      label: "Category Name",
                      keyboardType: TextInputType.text,
                      onSubmitted: (value) {},
                      onChanged: (value) {},
                      height: 90,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 22.0),
                    child: ExButton(
                      color: theme.primary,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      label: "Add",
                      height: 36.0,
                      onPressed: () {
                        _homeController.addExpendCategory(
                          category: ExpendCategory(
                              category: Input.get("category_name")),
                        );
                        textFieldController["category_name"]?.text = "";
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () {
                  if (_homeController.expendCategoryList.isEmpty) {
                    return const Center(
                        child: Text(
                      "No category yet....",
                    ));
                  }

                  return ListView.builder(
                    itemCount: _homeController.expendCategoryList.length,
                    itemBuilder: (context, index) {
                      var item = _homeController.expendCategoryList[index];

                      return InkWell(
                        child: Card(
                          color: Colors.white,
                          child: Container(
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Text(item.category),
                                Spacer(),
                                InkWell(
                                  onTap: () async {
                                    await _homeController.deleteExpendCategory(
                                        pathID: item.id!);
                                  },
                                  child: const Text(
                                    "Delete",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
