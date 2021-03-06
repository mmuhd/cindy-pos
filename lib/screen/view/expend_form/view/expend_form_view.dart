import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_and_ecommerce/controller/home_controller.dart';
import 'package:pos_and_ecommerce/model/pos/expend.dart';
import 'package:pos_and_ecommerce/screen/view/expend_form/controller/expend_form_controller.dart';

import '../../../../utils/theme.dart';
import '../../../../widgets/pos/button/button.dart';
import '../../../../widgets/radio/stream_radio.dart';
import '../../../../widgets/textfield/textfield.dart';

class ExpendFormView extends StatelessWidget {
  final Expend? expend;
  const ExpendFormView({
    Key? key,
    this.expend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ExpendFormController _expendFormController = Get.find();
    final HomeController _homeController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Form"),
        actions: [
          if (!(expend == null)) ...[
            Padding(
              padding: const EdgeInsets.only(
                top: 12.0,
                bottom: 12.0,
                right: 12.0,
              ),
              child: ExButton(
                color: theme.primary,
                label: "Delete",
                onPressed: () => _expendFormController.delete(expend!),
              ),
            ),
          ],
          if (expend == null) ...[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ExButton(
                color: theme.primary,
                label: "Save",
                onPressed: () => _expendFormController.save(),
              ),
            ),
          ]
        ],
      ),
      body: Padding(
        padding: theme.normalPadding,
        child: Column(
          children: [
            ExTextField(
              id: "description",
              label: "Description",
              value: expend?.description ?? "",
              keyboardType: TextInputType.text,
              onChanged: (value) {},
              onSubmitted: (value) {},
              height: 90,
            ),
            ExTextField(
              id: "cost",
              label: "Cost",
              keyboardType: TextInputType.number,
              value: "${expend?.cost}",
              onSubmitted: (value) {},
              onChanged: (value) {},
              height: 90,
            ),
            Obx(() {
              return ExStreamRadio(
                id: "category_name",
                label: "Category",
                valueField: "category_name",
                labelField: "category_name",
                value: expend?.category ?? "",
                categoryList: _homeController.expendCategoryList
                    .map((element) => element.category)
                    .toList(),
                keyboardType: TextInputType.none,
                onChanged: (value) {},
              );
            }),
          ],
        ),
      ),
    );
  }
}
