import 'package:core_erp/controllers/apps/provider-admin/provider-admin_controller.dart';
import 'package:core_erp/extensions/string.dart';
import 'package:core_erp/images.dart';
import 'package:core_erp/services/theme/app_style.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:core_erp/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class Employees extends StatefulWidget {
  const Employees({Key? key}) : super(key: key);

  @override
  State<Employees> createState() => _EmployeesState();
}

class _EmployeesState extends State<Employees>
    with SingleTickerProviderStateMixin, UIMixin {
  late ProviderAdminController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ProviderAdminController());
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
                    // FxText.titleMedium(
                    //   "all_employees",
                    //   fontWeight: 600,
                    //   fontSize: 18,
                    // ),
                    FxBreadcrumb(
                      children: [
                        FxBreadcrumbItem(
                            name: "human_resources_department".tr()),
                        FxBreadcrumbItem(name: "employees".tr(), active: true),
                      ],
                    ),
                  ],
                ),
              ),
              FxSpacing.height(flexSpacing),
              Padding(
                padding: FxSpacing.x(flexSpacing),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      runAlignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      runSpacing: 16,
                      spacing: 16,
                      children: [
                        FxContainer.none(
                          width: 250,
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: contentTheme.primary.withAlpha(30),
                              prefixIcon: Icon(
                                Icons.search,
                                size: 18,
                                color: contentTheme.primary,
                              ),
                              isDense: true,
                              hintText: "Search Files",
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: contentTheme.primary,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: FxSpacing.horizontal(20),
                            ),
                          ),
                        ),
                        FxContainer.none(
                          width: 250,
                          child: PopupMenuButton(
                              onSelected: controller.onSelectedJob,
                              itemBuilder: (BuildContext context) {
                                return [
                                  "Select Job",
                                  "Engineer",
                                  "Developer",
                                  "Artist",
                                  "Lawyer"
                                ].map((behavior) {
                                  return PopupMenuItem(
                                    value: behavior,
                                    height: 32,
                                    child: FxText.bodySmall(
                                      behavior.toString(),
                                      color: contentTheme.primary,
                                      fontWeight: 600,
                                    ),
                                  );
                                }).toList();
                              },
                              color: theme.cardTheme.color,
                              child: FxContainer.none(
                                color: contentTheme.primary.withAlpha(30),
                                padding: FxSpacing.xy(12, 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    FxText.labelMedium(
                                      controller.selectJob.toString(),
                                      color: contentTheme.primary,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 4),
                                      child: Icon(
                                        Icons.expand_more_outlined,
                                        size: 22,
                                        color: contentTheme.primary,
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ),
                        FxContainer.none(
                          width: 250,
                          child: PopupMenuButton(
                              onSelected: controller.onSelectedRating,
                              itemBuilder: (BuildContext context) {
                                return [
                                  "Select Rating",
                                  "Ok",
                                  "Good",
                                  "Better",
                                  "Best",
                                  "Excellent",
                                ].map((behavior) {
                                  return PopupMenuItem(
                                    value: behavior,
                                    height: 32,
                                    child: FxText.bodySmall(
                                      behavior.toString(),
                                      color: contentTheme.primary,
                                      fontWeight: 600,
                                    ),
                                  );
                                }).toList();
                              },
                              color: theme.cardTheme.color,
                              child: FxContainer.none(
                                color: contentTheme.primary.withAlpha(30),
                                padding: FxSpacing.xy(12, 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    FxText.labelMedium(
                                      controller.selectRating.toString(),
                                      color: contentTheme.primary,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 4),
                                      child: Icon(
                                        Icons.expand_more_outlined,
                                        size: 22,
                                        color: contentTheme.primary,
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                    FxSpacing.height(flexSpacing),
                    GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 255,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        mainAxisExtent: 220,
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      itemCount: controller.jobCandidate.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            FxContainer.none(
                              paddingAll: 0,
                            ),
                            Padding(
                              padding: FxSpacing.xy(16, 16),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: FxContainer.none(
                                  borderRadiusAll: 22,
                                  width: 45,
                                  height: 20,
                                  color: contentTheme.primary.withAlpha(40),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.star_outline,
                                        size: 16,
                                        color: AppColors.star,
                                      ),
                                      FxSpacing.width(4),
                                      FxText.bodyMedium(
                                        "${controller.jobCandidate[index].rating}",
                                        fontSize: 12,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: FxSpacing.y(26),
                              child: Column(
                                children: [
                                  FxContainer.rounded(
                                    paddingAll: 0,
                                    // borderRadiusAll: 25,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Image.asset(
                                      Images.avatars[
                                          index % Images.avatars.length],
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  FxSpacing.height(12),
                                  FxText.titleSmall(
                                    controller.jobCandidate[index].jobTitle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  FxSpacing.height(8),
                                  FxText.titleSmall(
                                    controller.jobCandidate[index].appName,
                                  ),
                                  FxSpacing.height(12),
                                  FxButton(
                                    onPressed: () {},
                                    elevation: 0,
                                    padding: FxSpacing.xy(20, 16),
                                    backgroundColor: contentTheme.primary,
                                    borderRadiusAll:
                                        AppStyle.buttonRadius.medium,
                                    child: FxText.bodySmall(
                                      'View Detail',
                                      color: contentTheme.onPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
