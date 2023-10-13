import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:core_erp/controllers/auth/auth_controller.dart';
import 'package:core_erp/models/employee.dart';
import 'package:core_erp/models/order.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:core_erp/controllers/apps/ecommerce/edit_products_controller.dart';
import 'package:core_erp/controllers/apps/provider-admin/provider-admin_controller.dart';
import 'package:core_erp/controllers/pages/profile_controller.dart';
import 'package:core_erp/extensions/string.dart';
import 'package:core_erp/images.dart';
import 'package:core_erp/models/locations.dart';
import 'package:core_erp/services/theme/app_style.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:core_erp/utils/utils.dart';
import 'package:core_erp/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get_navigation/src/root/parse_route.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:image_picker/image_picker.dart';
import '../../../controllers/apps/files/file_upload_controller.dart';

class AssignTask extends StatefulWidget {
  const AssignTask({Key? key}) : super(key: key);

  @override
  State<AssignTask> createState() => _AssignTaskState();
}

class _AssignTaskState extends State<AssignTask>
    with SingleTickerProviderStateMixin, UIMixin {
  late ProviderAdminController controller;
  late FileUploadController fileUploadController;
  late AuthController authController;
  @override
  void initState() {
    super.initState();
    controller = Get.put(ProviderAdminController());
    fileUploadController = Get.put(FileUploadController());
    authController = Get.put(AuthController());
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
                    //   "Edit",
                    //   fontWeight: 600,
                    // ),
                    FxBreadcrumb(
                      children: [
                        // FxBreadcrumbItem(name: "UI"),
                        FxBreadcrumbItem(
                            name: "Assign Employee To Task", active: true),
                      ],
                    ),
                  ],
                ),
              ),
              FxSpacing.height(flexSpacing),
              Padding(
                padding: FxSpacing.x(flexSpacing / 2),
                child: FxFlex(
                  wrapAlignment: WrapAlignment.start,
                  wrapCrossAlignment: WrapCrossAlignment.start,
                  children: [
                    FxFlexItem(
                      sizes: "lg-8 md-12",
                      child: Column(
                        children: [
                          FxContainer.bordered(
                            paddingAll: 20,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: 400,
                                  ),
                                  child: FxCard(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shadow: FxShadow(
                                        elevation: 0.5,
                                        position: FxShadowPosition.bottom),
                                    paddingAll: 0,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          // width: double.infinity,
                                          color: colorScheme.primary
                                              .withOpacity(0.08),
                                          padding: FxSpacing.xy(16, 12),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        FeatherIcons.server,
                                                        color: contentTheme
                                                            .primary,
                                                        size: 8,
                                                      ),
                                                      FxSpacing.width(12),
                                                      FxText.titleMedium(
                                                        "assin_task".tr(),
                                                        fontWeight: 600,
                                                        color:
                                                            colorScheme.primary,
                                                      ),
                                                    ],
                                                  ),
                                                  Obx(() => controller
                                                              .selectedQueriedForTaskAssignmentEmpoyee
                                                              .value
                                                              .employeeID !=
                                                          null
                                                      ? Row(
                                                          children: [
                                                            Obx(() => controller
                                                                        .isSavingSuccess
                                                                        .value ==
                                                                    true
                                                                ? Center(
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        CircularProgressIndicator(
                                                                          strokeWidth:
                                                                              1.0,
                                                                          color:
                                                                              theme.primaryColor,
                                                                        ),
                                                                        FxSpacing.width(
                                                                            16),
                                                                        Text(
                                                                            'Saving ...')
                                                                      ],
                                                                    ),
                                                                  )
                                                                : Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      FxButton
                                                                          .text(
                                                                        onPressed:
                                                                            () {},
                                                                        padding: FxSpacing.xy(
                                                                            20,
                                                                            16),
                                                                        splashColor: contentTheme
                                                                            .secondary
                                                                            .withOpacity(0.1),
                                                                        child: FxText
                                                                            .bodySmall(
                                                                          'cancel'
                                                                              .tr(),
                                                                        ),
                                                                      ),
                                                                      FxSpacing
                                                                          .width(
                                                                              12),
                                                                      FxButton(
                                                                        onPressed:
                                                                            () {
                                                                          controller
                                                                              .onAssignTask();
                                                                        },
                                                                        elevation:
                                                                            0,
                                                                        padding: FxSpacing.xy(
                                                                            20,
                                                                            16),
                                                                        backgroundColor:
                                                                            contentTheme.primary,
                                                                        borderRadiusAll: AppStyle
                                                                            .buttonRadius
                                                                            .medium,
                                                                        child: FxText
                                                                            .bodySmall(
                                                                          'save'
                                                                              .tr(),
                                                                          color:
                                                                              contentTheme.onPrimary,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )),
                                                          ],
                                                        )
                                                      : Center(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              FxSpacing.width(
                                                                  16),
                                                              Text(
                                                                  'No employee selected. Select from appropriate department.')
                                                            ],
                                                          ),
                                                        ))
                                                ],
                                              ),
                                              FxSpacing.height(12),
                                              Row(
                                                children: [
                                                  Icon(
                                                    FeatherIcons.info,
                                                    color:
                                                        contentTheme.secondary,
                                                    size: 16,
                                                  ),
                                                  FxSpacing.width(12),
                                                  Expanded(
                                                    child: Obx(() => controller
                                                                .serverReponseError
                                                                .value ==
                                                            true
                                                        ? AutoSizeText(
                                                            "${controller.serverReponseErrorMessage}",
                                                            minFontSize: 8,
                                                            maxFontSize: 12,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          )
                                                        : controller.serverReponseSuccess
                                                                    .value ==
                                                                true
                                                            ? AutoSizeText(
                                                                "${controller.serverReponseSuccessMessage}",
                                                                minFontSize: 8,
                                                                maxFontSize: 12,
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              )
                                                            : controller.selectedJobRoleCategories
                                                                        .value ==
                                                                    'driver'
                                                                ? AutoSizeText(
                                                                    "Driver particulars are required. Please upload driver license, profile image and medical records for HR Review",
                                                                    minFontSize:
                                                                        8,
                                                                    maxFontSize:
                                                                        12,
                                                                    maxLines: 2,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  )
                                                                : AutoSizeText(
                                                                    "Use the  department and deploments paraters to filter the right task and employee",
                                                                    minFontSize:
                                                                        8,
                                                                    maxFontSize:
                                                                        12,
                                                                    maxLines: 2,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  )),
                                                  ),
                                                  // FxText.titleMedium(

                                                  //       .tr(),
                                                  //   fontWeight: 200,
                                                  //   color: colorScheme
                                                  //       .primary,
                                                  // ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              FxSpacing.xy(flexSpacing, 16),
                                          child: authController
                                                      .person.value.tradingAs ==
                                                  'transporter'
                                              ? transporterAssignOptions()
                                              : transporterAssignOptions(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          FxSpacing.height(20),
                        ],
                      ),
                    ),
                    FxFlexItem(
                      sizes: "lg-4 md-12",
                      child: Column(
                        children: [
                          FxContainer(
                            height: 600,
                            child: Column(
                              children: [
                                FxText.labelMedium(
                                  "${controller.selectedDepartment.name} Department Employees"
                                      .capitalize
                                      .capitalizeWords,
                                  fontSize: 18,
                                  style: TextStyle(color: Colors.black12),
                                ),
                                FxSpacing.height(18),
                                Obx(() => controller
                                        .queriedForTaskAssignmentEmpoyees
                                        .isEmpty
                                    ? Center(
                                        child: FxText.labelMedium(
                                        "Please select department with empoyees"
                                            .tr()
                                            .capitalizeWords,
                                      ))
                                    : buildDiscoveryJobs()),
                                FxSpacing.height(8),
                              ],
                            ),
                          ),
                          FxSpacing.height(20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  transporterAssignOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FxFlex(contentPadding: false, children: [
          FxFlexItem(
              sizes: 'lg-6 md-12',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FxText.labelMedium(
                    "Department".tr(),
                  ),
                  FxSpacing.height(8),
                  DropdownButtonFormField<LogisticsDepartment>(
                    dropdownColor: colorScheme.background,
                    menuMaxHeight: 200,
                    isDense: true,

                    // itemHeight: 40,
                    items: LogisticsDepartment.values
                        .map(
                          (category) => DropdownMenuItem<LogisticsDepartment>(
                            value: category,
                            child: FxText.labelMedium(
                              category.name.capitalize,
                            ),
                          ),
                        )
                        .toList(),
                    icon: Icon(
                      Icons.expand_more,
                      size: 20,
                    ),
                    decoration: InputDecoration(
                      hintText: "Select dept",
                      hintStyle: FxTextStyle.bodySmall(xMuted: true),
                      border: outlineInputBorder,
                      enabledBorder: outlineInputBorder,
                      focusedBorder: focusedInputBorder,
                      contentPadding: FxSpacing.all(14),
                      isCollapsed: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    onChanged: (value) {
                      controller.onChangeTaskDepartment(value);
                    },
                  )
                ],
              )),
          FxFlexItem(
              sizes: 'lg-6 md-12',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FxText.labelMedium(
                    "task_role".tr(),
                  ),
                  FxSpacing.height(8),
                  DropdownButtonFormField<String>(
                    dropdownColor: colorScheme.background,
                    menuMaxHeight: 200,
                    isDense: true,
                    items: controller.jobRoleCategories
                        .map(
                          (category) => DropdownMenuItem<String>(
                            value: category,
                            child: FxText.labelMedium(
                              category.capitalize,
                            ),
                          ),
                        )
                        .toList(),
                    icon: Icon(
                      Icons.expand_more,
                      size: 20,
                    ),
                    decoration: InputDecoration(
                      hintText: "Select level",
                      hintStyle: FxTextStyle.bodySmall(xMuted: true),
                      border: outlineInputBorder,
                      enabledBorder: outlineInputBorder,
                      focusedBorder: focusedInputBorder,
                      contentPadding: FxSpacing.all(14),
                      isCollapsed: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    onChanged: (value) {
                      controller.onChangeTaskJobRole(value);
                    },
                  )
                ],
              )),
        ]),
        FxSpacing.height(20),
        controller.selectedLogisticsDepartment.name == 'logistics'
            ? logisticsOptions(context)
            : controller.selectedLogisticsDepartment.name == 'sales'
                ? warehouseOptions(context)
                : Column(),
        FxSpacing.height(20),
        FxFlex(contentPadding: false, children: [
          FxFlexItem(
              sizes: 'lg-12 md-12',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FxText.labelMedium(
                    "task_notes".tr().capitalizeWords,
                  ),
                  FxSpacing.height(8),
                  TextFormField(
                    maxLines: 4,
                    validator:
                        controller.basicValidator.getValidation('task_notes'),
                    controller:
                        controller.basicValidator.getController('task_notes'),
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: "things to be:",
                      hintStyle: FxTextStyle.bodySmall(xMuted: true),
                      border: outlineInputBorder,
                      enabledBorder: outlineInputBorder,
                      focusedBorder: focusedInputBorder,
                      prefixIconConstraints: BoxConstraints(
                          maxHeight: 42, minWidth: 50, maxWidth: 50),
                      contentPadding: FxSpacing.all(16),
                      isCollapsed: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                ],
              )),
        ]),
        FxSpacing.height(20),
      ],
    );
  }

  Widget buildDiscoveryJobs() {
    return SizedBox(
      height: 500,
      child: Obx(() => ListView.separated(
            itemCount: controller.queriedForTaskAssignmentEmpoyees.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              Employee employee =
                  controller.queriedForTaskAssignmentEmpoyees[index];
              return InkWell(
                onTap: () {
                  controller.onSelectEmployee(employee);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FxContainer(
                      height: 120,
                      width: 200,
                      borderRadiusAll: 12,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FxContainer.none(
                                  borderRadiusAll: 26,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: employee.profile!.profileImage != null
                                      ? Container(
                                          height: 50,
                                          width: 50,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Image.network(
                                              '${controller.apiUrl}/users/avatars/${employee.profile!.profileImage}',
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes!
                                                        : null,
                                                  ),
                                                );
                                              },
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return const Icon(
                                                  Icons.no_accounts,
                                                  size: 50,
                                                );
                                              },
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      : const Icon(
                                          Icons.no_accounts,
                                          size: 50,
                                        )),
                              Column(
                                children: [
                                  FxText.titleMedium(
                                    employee.jobRole.toString().tr(),
                                    fontWeight: 600,
                                    fontSize: 16,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  FxText.titleMedium(
                                    '${employee.profile!.firstName!.capitalize}_${employee.profile!.lastName}'
                                        .tr(),
                                    fontWeight: 500,
                                    fontSize: 12,
                                    muted: true,
                                  ),
                                  FxSpacing.height(4),
                                  FxText.bodyMedium(
                                    "\$${employee.salary}/y",
                                    fontSize: 12,
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 16,
                child: Divider(height: 10, color: theme.primaryColor),
              );
            },
          )),
    );
  }

  warehouseOptions(BuildContext context) {
    return Column(
      children: [
        FxSpacing.height(20),
        FxFlex(contentPadding: false, children: [
          FxFlexItem(
              sizes: 'lg-6 md-12',
              child: Obx(
                () {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FxText.labelMedium(
                        "Select Order".tr(),
                      ),
                      FxSpacing.height(8),
                      DropdownButtonFormField<Order>(
                        onSaved: (newValue) {
                          debugPrint(
                              ' DropdownButtonFormField newValue, ${newValue}');
                        },
                        dropdownColor: colorScheme.background,
                        menuMaxHeight: 200,
                        isDense: true,

                        // itemHeight: 40,
                        items: controller.ordersController.orders.map(
                          (order) {
                            return DropdownMenuItem<Order>(
                              value: order,
                              child: FxText.labelMedium(
                                order.orderID!,
                              ),
                            );
                          },
                        ).toList(),
                        icon: Icon(
                          Icons.expand_more,
                          size: 20,
                        ),
                        decoration: InputDecoration(
                          hintText: "type order id",
                          hintStyle: FxTextStyle.bodySmall(xMuted: true),
                          border: outlineInputBorder,
                          enabledBorder: outlineInputBorder,
                          focusedBorder: focusedInputBorder,
                          contentPadding: FxSpacing.all(14),
                          isCollapsed: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),

                        onChanged: (value) {
                          controller.onSelectOrder(value);
                        },
                      )
                    ],
                  );
                },
              )),
          FxFlexItem(
              sizes: 'lg-6 md-12',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FxText.labelMedium(
                    "select_vehicle".tr().capitalizeWords,
                  ),
                  FxSpacing.height(8),
                  TextFormField(
                    validator: controller.basicValidator
                        .getValidation('contact_person'),
                    controller: controller.basicValidator
                        .getController('contact_person'),
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: "type vehicle id",
                      hintStyle: FxTextStyle.bodySmall(xMuted: true),
                      border: outlineInputBorder,
                      enabledBorder: outlineInputBorder,
                      focusedBorder: focusedInputBorder,
                      prefixIconConstraints: BoxConstraints(
                          maxHeight: 42, minWidth: 50, maxWidth: 50),
                      contentPadding: FxSpacing.all(16),
                      isCollapsed: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                ],
              ))
        ]),
        FxSpacing.height(30),
      ],
    );
  }

  logisticsOptions(BuildContext context) {
    return Column(
      children: [
        FxSpacing.height(20),
        FxFlex(contentPadding: false, children: [
          FxFlexItem(
              sizes: 'lg-6 md-12',
              child: Obx(
                () {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FxText.labelMedium(
                        "Select Order".tr(),
                      ),
                      FxSpacing.height(8),
                      DropdownButtonFormField<Order>(
                        onSaved: (newValue) {
                          debugPrint(
                              ' DropdownButtonFormField newValue, ${newValue}');
                        },
                        dropdownColor: colorScheme.background,
                        menuMaxHeight: 200,
                        isDense: true,

                        // itemHeight: 40,
                        items: controller.ordersController.orders.map(
                          (order) {
                            return DropdownMenuItem<Order>(
                              value: order,
                              child: FxText.labelMedium(
                                order.orderID!,
                              ),
                            );
                          },
                        ).toList(),
                        icon: Icon(
                          Icons.expand_more,
                          size: 20,
                        ),
                        decoration: InputDecoration(
                          hintText: "type order id",
                          hintStyle: FxTextStyle.bodySmall(xMuted: true),
                          border: outlineInputBorder,
                          enabledBorder: outlineInputBorder,
                          focusedBorder: focusedInputBorder,
                          contentPadding: FxSpacing.all(14),
                          isCollapsed: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),

                        onChanged: (value) {
                          controller.onSelectOrder(value);
                        },
                      )
                    ],
                  );
                },
              )),
          FxFlexItem(
              sizes: 'lg-6 md-12',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FxText.labelMedium(
                    "select_vehicle".tr().capitalizeWords,
                  ),
                  FxSpacing.height(8),
                  TextFormField(
                    validator: controller.basicValidator
                        .getValidation('contact_person'),
                    controller: controller.basicValidator
                        .getController('contact_person'),
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: "type vehicle id",
                      hintStyle: FxTextStyle.bodySmall(xMuted: true),
                      border: outlineInputBorder,
                      enabledBorder: outlineInputBorder,
                      focusedBorder: focusedInputBorder,
                      prefixIconConstraints: BoxConstraints(
                          maxHeight: 42, minWidth: 50, maxWidth: 50),
                      contentPadding: FxSpacing.all(16),
                      isCollapsed: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                ],
              ))
        ]),
        FxSpacing.height(30),
        FxFlex(contentPadding: false, children: [
          FxFlexItem(
              sizes: 'lg-4 md-12',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FxText.labelMedium(
                    "pickup_city".tr(),
                  ),
                  FxSpacing.height(8),
                  DropdownButtonFormField(
                    dropdownColor: colorScheme.background,
                    menuMaxHeight: 200,
                    isDense: true,

                    // itemHeight: 40,
                    items: populatedCities
                        .map(
                          (city) => DropdownMenuItem(
                            value: city,
                            child: FxText.labelMedium(
                              city.capitalize,
                            ),
                          ),
                        )
                        .toList(),
                    icon: Icon(
                      Icons.expand_more,
                      size: 20,
                    ),
                    decoration: InputDecoration(
                      hintText: "Select city",
                      hintStyle: FxTextStyle.bodySmall(xMuted: true),
                      border: outlineInputBorder,
                      enabledBorder: outlineInputBorder,
                      focusedBorder: focusedInputBorder,
                      contentPadding: FxSpacing.all(14),
                      isCollapsed: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    onChanged: (value) {
                      controller.onSelectedCity(value!);
                    },
                  )
                ],
              )),
          FxFlexItem(
              sizes: 'lg-4 md-12',
              child: Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FxText.labelMedium(
                        "pickup_area (${controller.populatedNeighbourhoodsNames.length})"
                            .tr(),
                      ),
                      FxSpacing.height(8),
                      controller.populatedNeighbourhoodsNames.isNotEmpty
                          ? DropdownButtonFormField<String>(
                              dropdownColor: colorScheme.background,
                              menuMaxHeight: 200,
                              isDense: true,

                              // itemHeight: 40,
                              items: controller.populatedNeighbourhoodsNames
                                  .map(
                                    (neighbourhood) => DropdownMenuItem<String>(
                                      value: neighbourhood,
                                      child: FxText.labelMedium(
                                        neighbourhood,
                                      ),
                                    ),
                                  )
                                  .toList(),
                              icon: Icon(
                                Icons.expand_more,
                                size: 20,
                              ),
                              decoration: InputDecoration(
                                hintText: "Select area e.g Mufakose",
                                hintStyle: FxTextStyle.bodySmall(xMuted: true),
                                border: outlineInputBorder,
                                enabledBorder: outlineInputBorder,
                                focusedBorder: focusedInputBorder,
                                contentPadding: FxSpacing.all(14),
                                isCollapsed: true,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                              ),
                              onChanged: (value) {
                                controller.onSelectedArea(value!);
                              },
                            )
                          : TextFormField(
                              validator: controller.basicValidator
                                  .getValidation('last_name'),
                              controller: controller.basicValidator
                                  .getController('last_name'),
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                hintText: "Kuyu",
                                hintStyle: FxTextStyle.bodySmall(xMuted: true),
                                border: outlineInputBorder,
                                enabledBorder: outlineInputBorder,
                                focusedBorder: focusedInputBorder,
                                prefixIconConstraints: BoxConstraints(
                                    maxHeight: 42, minWidth: 50, maxWidth: 50),
                                contentPadding: FxSpacing.all(16),
                                isCollapsed: true,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                              ),
                            )
                    ],
                  ))),
          FxFlexItem(
              sizes: 'lg-4 md-12',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FxText.labelMedium(
                    "contact_person".tr().capitalizeWords,
                  ),
                  FxSpacing.height(8),
                  TextFormField(
                    validator: controller.basicValidator
                        .getValidation('contact_person'),
                    controller: controller.basicValidator
                        .getController('contact_person'),
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: "+263777757600",
                      hintStyle: FxTextStyle.bodySmall(xMuted: true),
                      border: outlineInputBorder,
                      enabledBorder: outlineInputBorder,
                      focusedBorder: focusedInputBorder,
                      prefixIconConstraints: BoxConstraints(
                          maxHeight: 42, minWidth: 50, maxWidth: 50),
                      contentPadding: FxSpacing.all(16),
                      isCollapsed: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                ],
              ))
        ])
      ],
    );
  }

  itemImageField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GetBuilder(
            init: controller,
            builder: (controller) {
              return controller.queriedForTaskAssignmentEmpoyees.isNotEmpty
                  ? SizedBox(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 180,
                                childAspectRatio: 3 / 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                        itemCount: fileUploadController.files.length,
                        itemBuilder: (context, index) {
                          PlatformFile image =
                              fileUploadController.files[index];
                          return Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.memory(
                                    Uint8List.fromList(image.bytes!),
                                    height: 150,
                                    width: 150,
                                    // width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                    top: 0,
                                    child: FxContainer.roundBordered(
                                      onTap: () => fileUploadController
                                          .removeFile(image),
                                      paddingAll: 4,
                                      child: Icon(
                                        Icons.close,
                                        size: 16,
                                      ),
                                    ))
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  : Column();
            }),
      ],
    );
  }

  buildProfileDetail(String firstName, String lastName) {
    return Row(
      children: [
        FxText.titleSmall(
          firstName,
          fontWeight: 700,
          muted: true,
        ),
        FxSpacing.width(8),
        FxText.titleSmall(
          lastName,
          muted: true,
        ),
      ],
    );
  }

  buildTextField(String fieldTitle, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FxText.labelMedium(
          fieldTitle,
        ),
        FxSpacing.height(8),
        TextFormField(
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: FxTextStyle.bodySmall(xMuted: true),
            border: outlineInputBorder,
            contentPadding: FxSpacing.all(16),
            isCollapsed: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
        ),
      ],
    );
  }

  buildSocialTextField(
    String fieldTitle,
    String hintText,
    IconData icon,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FxText.labelMedium(
          fieldTitle,
        ),
        FxSpacing.height(8),
        TextFormField(
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: FxTextStyle.bodySmall(xMuted: true),
            border: outlineInputBorder,
            enabledBorder: outlineInputBorder,
            // focusedBorder: focusedInputBorder,
            prefixIcon: FxContainer.none(
              margin: FxSpacing.right(12),
              alignment: Alignment.center,
              color: contentTheme.primary.withAlpha(40),
              child: Icon(
                icon,
                color: contentTheme.primary,
                size: 18,
              ),
            ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 50,
              minWidth: 50,
              maxWidth: 50,
            ),
            contentPadding: FxSpacing.all(16),
            isCollapsed: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
        ),
      ],
    );
  }
}
