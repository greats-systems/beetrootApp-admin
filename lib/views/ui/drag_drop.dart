import 'package:core_erp/controllers/ui/drag_and_drop_controller.dart';
import 'package:core_erp/extensions/extensions.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:core_erp/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class DragDropPage extends StatefulWidget {
  const DragDropPage({Key? key}) : super(key: key);

  @override
  State<DragDropPage> createState() => _DragDropPageState();
}

class _DragDropPageState extends State<DragDropPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late DragDropController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(DragDropController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: FxSpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FxText.titleMedium(
                      "${"drag".tr()} & ${"drop".tr()}",
                      fontWeight: 600,
                    ),
                    FxBreadcrumb(
                      children: [
                        FxBreadcrumbItem(name: 'ui'.tr()),
                        FxBreadcrumbItem(
                            name: "${"drag".tr()} & ${"drop".tr()}",
                            active: true),
                      ],
                    ),
                  ],
                ),
              ),
              FxSpacing.height(flexSpacing),
              Padding(
                  padding: FxSpacing.x(flexSpacing),
                  child: FxContainer.bordered(
                    width: MediaQuery.of(context).size.width,
                    padding: FxSpacing.xy(20, 20),
                    child: ReorderableListView(
                      proxyDecorator: (child, index, animation) {
                        return Material(
                          child: FxCard(
                            shadow: FxShadow(elevation: 0.5),
                            paddingAll: 0,
                            child: child,
                          ),
                        );
                      },
                      buildDefaultDragHandles: false,
                      shrinkWrap: true,
                      onReorder: controller.onReorder,
                      children: controller.customers
                          .mapIndexed((index, element) => ListTile(
                                key: Key('${index}'),
                                leading: ReorderableDragStartListener(
                                    index: index,
                                    child: MouseRegion(
                                        cursor: SystemMouseCursors.grabbing,
                                        child: Icon(
                                          Icons.drag_handle_outlined,
                                          size: 20,
                                        ))),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: FxText.labelMedium(
                                        ' ${element.fullName}',
                                      ),
                                    ),
                                    Expanded(
                                      child: FxText.labelMedium(
                                          ' ${element.phoneNumber}',
                                          textAlign: TextAlign.start),
                                    ),
                                    Expanded(
                                      child: FxText.labelMedium(
                                          ' ${element.balance}'),
                                    ),
                                    Container(
                                      constraints:
                                          BoxConstraints(maxWidth: 100),
                                      child: Icon(
                                        Icons.delete_outline,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  )),
            ],
          );
        },
      ),
    );
  }
}
//
// Widget buildDragAndDropItem(String title) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Icon(Icons.drag_handle_outlined),
//       FxText.labelSmall(
//         title,
//       ),
//       FxText.labelSmall(
//         "Survadhi@gamil.com",
//       ),
//       FxText.labelSmall(
//         "Business Developer",
//       ),
//       FxText.labelSmall(
//         "All Developer",
//       ),
//       Icon(Icons.delete_rounded)
//     ],
//   );
// }
