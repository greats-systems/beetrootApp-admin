import 'package:core_erp/controllers/auth/auth_controller.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:core_erp/controllers/apps/ecommerce/customers_controller.dart';
import 'package:core_erp/extensions/extensions.dart';
import 'package:core_erp/images.dart';
import 'package:core_erp/services/theme/app_style.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:core_erp/utils/utils.dart';
import 'package:core_erp/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class CustomersPage extends StatefulWidget {
  const CustomersPage({Key? key}) : super(key: key);

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late CustomersController controller;
  late AuthController authController;

  @override
  void initState() {
    super.initState();
    controller = Get.put(CustomersController());
    authController = Get.put(AuthController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder<CustomersController>(
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
                      "customers".tr(),
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    FxBreadcrumb(
                      children: [
                        FxBreadcrumbItem(name: 'ecommerce'.tr()),
                        FxBreadcrumbItem(name: 'customers'.tr(), active: true),
                      ],
                    ),
                  ],
                ),
              ),
              FxSpacing.height(flexSpacing),
              Padding(
                padding: FxSpacing.x(flexSpacing),
                child: FxCard(
                  shadow: FxShadow(
                      elevation: 0.5, position: FxShadowPosition.bottom),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: FxContainer.none(
                      borderRadiusAll: 4,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          FxButton(
                            onPressed: controller.goToDashboard,
                            elevation: 0,
                            padding: FxSpacing.xy(20, 16),
                            backgroundColor: contentTheme.primary,
                            borderRadiusAll: AppStyle.buttonRadius.medium,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  FeatherIcons.monitor,
                                  size: 18,
                                  color: contentTheme.onPrimary,
                                ),
                                FxSpacing.width(8),
                                FxText.labelMedium(
                                  'dashboard'.tr(),
                                  color: contentTheme.onPrimary,
                                ),
                              ],
                            ),
                          ),
                          FxSpacing.height(16),
                          Obx(
                            () => controller.isLoading == true
                                ? Center(
                                    child: Container(
                                      height: 100,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(
                                            strokeWidth: 1.0,
                                            color: theme.primaryColor,
                                          ),
                                          FxSpacing.width(16),
                                          Text('Loading Items')
                                        ],
                                      ),
                                    ),
                                  )
                                : authController.serviceProviders.isNotEmpty
                                    ? SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: FxContainer.none(
                                          borderRadiusAll: 4,
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: DataTable(
                                            sortColumnIndex: 1,
                                            sortAscending: true,
                                            onSelectAll: (_) => {},
                                            headingRowColor:
                                                MaterialStatePropertyAll(
                                                    contentTheme.primary
                                                        .withAlpha(40)),
                                            dataRowHeight: 60,
                                            showBottomBorder: false,
                                            columns: [
                                              DataColumn(
                                                label: FxText.labelLarge(
                                                  'id'.tr(),
                                                  color: contentTheme.primary,
                                                ),
                                              ),
                                              DataColumn(
                                                label: FxText.labelLarge(
                                                  'name'.tr(),
                                                  color: contentTheme.primary,
                                                ),
                                              ),
                                              DataColumn(
                                                label: FxText.labelLarge(
                                                  'phone'.tr(),
                                                  color: contentTheme.primary,
                                                ),
                                              ),
                                              DataColumn(
                                                label: FxText.labelLarge(
                                                  'balance'.tr(),
                                                  color: contentTheme.primary,
                                                ),
                                              ),
                                              DataColumn(
                                                label: FxText.labelLarge(
                                                  'orders'.tr(),
                                                  color: contentTheme.primary,
                                                ),
                                              ),
                                              DataColumn(
                                                label: FxText.labelLarge(
                                                  'last_order_at'
                                                      .tr()
                                                      .capitalizeWords,
                                                  color: contentTheme.primary,
                                                ),
                                              ),
                                              DataColumn(
                                                  label: FxText.labelLarge(
                                                'action'.tr(),
                                                color: contentTheme.primary,
                                              ))
                                            ],
                                            rows: authController
                                                .serviceProviders
                                                .mapIndexed(
                                                  (index, data) => DataRow(
                                                    cells: [
                                                      DataCell(FxText.bodyMedium(
                                                          "#${data.provider.userID!.substring(1, 8)}")),
                                                      DataCell(
                                                        SizedBox(
                                                          width: 300,
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              FxContainer.none(
                                                                borderRadiusAll:
                                                                    20,
                                                                clipBehavior: Clip
                                                                    .antiAliasWithSaveLayer,
                                                                child: data.provider
                                                                            .profileImage !=
                                                                        null
                                                                    ? Container(
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            50,
                                                                        decoration:
                                                                            const BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(50),
                                                                          child:
                                                                              Image.network(
                                                                            '${controller.serverUrl}/users/avatars/${data.provider.profileImage}',
                                                                            loadingBuilder: (BuildContext context,
                                                                                Widget child,
                                                                                ImageChunkEvent? loadingProgress) {
                                                                              if (loadingProgress == null) {
                                                                                return child;
                                                                              }
                                                                              return Center(
                                                                                child: CircularProgressIndicator(
                                                                                  value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                                                                                ),
                                                                              );
                                                                            },
                                                                            errorBuilder: (context,
                                                                                error,
                                                                                stackTrace) {
                                                                              return const Icon(
                                                                                Icons.no_accounts,
                                                                                size: 50,
                                                                              );
                                                                            },
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : const Icon(
                                                                        Icons
                                                                            .no_accounts,
                                                                        size:
                                                                            50,
                                                                      ),
                                                              ),
                                                              FxSpacing.width(
                                                                  15),
                                                              FxText.labelLarge(
                                                                data.provider
                                                                    .firstName
                                                                    .toString(),
                                                              ),
                                                              FxSpacing.width(
                                                                  5),
                                                              FxText.labelLarge(
                                                                data.provider
                                                                    .lastName
                                                                    .toString(),
                                                                // muted: true,
                                                                // letterSpacing: 0,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      DataCell(FxText.bodyMedium(
                                                          '${data.provider.phone}')),
                                                      DataCell(
                                                          FxText.bodyMedium(
                                                              '\$0')),
                                                      DataCell(FxText.bodyMedium(
                                                          '${data.offerItems.length}')),
                                                      DataCell(Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          FxText.labelLarge(
                                                              '${Utils.formatDateTime(DateTime.parse(data.provider.createdDate.toString()))}'),
                                                          FxSpacing.width(4),
                                                          FxText.bodySmall(
                                                            '${Utils.formatTime(DateTime.parse(data.provider.createdDate.toString()))}',
                                                            muted: true,
                                                            fontWeight: 600,
                                                          )
                                                        ],
                                                      )),
                                                      DataCell(
                                                        Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: FxContainer
                                                              .bordered(
                                                            onTap: () => {},
                                                            padding:
                                                                FxSpacing.xy(
                                                                    6, 6),
                                                            borderColor:
                                                                contentTheme
                                                                    .primary
                                                                    .withAlpha(
                                                                        40),
                                                            child: Icon(
                                                              FeatherIcons
                                                                  .edit2,
                                                              size: 12,
                                                              color:
                                                                  contentTheme
                                                                      .primary,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ),
                                      )
                                    : Column(
                                        children: [Text('No Items')],
                                      ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
