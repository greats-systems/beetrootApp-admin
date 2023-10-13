import 'package:feather_icons/feather_icons.dart';
import 'package:core_erp/controllers/apps/ecommerce/product_detail_controller.dart';
import 'package:core_erp/controllers/apps/ecommerce/products_controller.dart';
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

class EcommerceProductsPage extends StatefulWidget {
  const EcommerceProductsPage({super.key});

  @override
  _EcommerceProductsPageState createState() => _EcommerceProductsPageState();
}

class _EcommerceProductsPageState extends State<EcommerceProductsPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late ProductsController controller;
  late ProductDetailController productDetailController;

  @override
  void initState() {
    super.initState();
    productDetailController = Get.put(ProductDetailController(this));
    controller = Get.put(ProductsController());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Layout(
        child: GetBuilder<ProductsController>(
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
                        //   "products (${controller.offerItemList.length})".tr(),
                        //   fontSize: 18,
                        //   fontWeight: 600,
                        // ),
                        FxBreadcrumb(
                          children: [
                            FxBreadcrumbItem(name: 'trading'.tr()),
                            FxBreadcrumbItem(
                                name: 'products'.tr(), active: true),
                          ],
                        ),
                      ],
                    ),
                  ),
                  FxSpacing.height(flexSpacing),
                  FxCard(
                      shadow: FxShadow(
                          elevation: 0.5, position: FxShadowPosition.bottom),
                      margin: FxSpacing.x(flexSpacing),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          FxButton(
                            onPressed: controller.goToCreateProduct,
                            elevation: 0,
                            padding: FxSpacing.xy(20, 16),
                            backgroundColor: contentTheme.primary,
                            borderRadiusAll: AppStyle.buttonRadius.medium,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.add_outlined,
                                  size: 20,
                                  color: contentTheme.onPrimary,
                                ),
                                FxSpacing.width(8),
                                FxText.labelMedium(
                                  'create_product'.tr().capitalizeWords,
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
                                : controller.offerItemList.isNotEmpty
                                    ? SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: FxContainer.none(
                                            borderRadiusAll: 4,
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            child: DataTable(
                                                sortAscending: false,
                                                onSelectAll: (_) => {
                                                      debugPrint(
                                                          'row-selected: $_}')
                                                    },
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
                                                  )),
                                                  DataColumn(
                                                      label: FxText.labelLarge(
                                                    'name'.tr(),
                                                    color: contentTheme.primary,
                                                  )),
                                                  DataColumn(
                                                      label: FxText.labelLarge(
                                                    'price'.tr(),
                                                    color: contentTheme.primary,
                                                  )),
                                                  DataColumn(
                                                      label: FxText.labelLarge(
                                                    'rating'.tr(),
                                                    color: contentTheme.primary,
                                                  )),
                                                  DataColumn(
                                                      label: FxText.labelLarge(
                                                    'sku'.tr(),
                                                    color: contentTheme.primary,
                                                  )),
                                                  DataColumn(
                                                      label: FxText.labelLarge(
                                                    'stock'.tr(),
                                                    color: contentTheme.primary,
                                                  )),
                                                  DataColumn(
                                                      label: FxText.labelLarge(
                                                    'orders'.tr(),
                                                    color: contentTheme.primary,
                                                  )),
                                                  DataColumn(
                                                      label: FxText.labelLarge(
                                                    'created_at'
                                                        .tr()
                                                        .capitalizeWords,
                                                    color: contentTheme.primary,
                                                  )),
                                                  DataColumn(
                                                      label: FxText.labelLarge(
                                                    'action'.tr(),
                                                    color: contentTheme.primary,
                                                  )),
                                                ],
                                                rows: controller.offerItemList
                                                    .mapIndexed((index, data) =>
                                                        // InkWell(child: ,)
                                                        DataRow(
                                                            onSelectChanged:
                                                                (bool?
                                                                    selected) {
                                                              if (selected ==
                                                                  true) {
                                                                debugPrint(
                                                                    'row-selected: $index}');
                                                                productDetailController
                                                                    .offerItem
                                                                    .value = data;
                                                                controller
                                                                    .goToProductDetail();
                                                              }
                                                            },
                                                            cells: [
                                                              DataCell(FxText
                                                                  .bodyMedium(
                                                                      '#${data.itemID!.substring(1, 8)}')),
                                                              DataCell(SizedBox(
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
                                                                        // borderRadiusAll: 10,
                                                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                                                        child: data.images!.isNotEmpty
                                                                            ? Container(
                                                                                height: size.height * 0.05,
                                                                                width: size.height * 0.05,
                                                                                decoration: const BoxDecoration(
                                                                                  shape: BoxShape.circle,
                                                                                ),
                                                                                child: ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(50),
                                                                                  child: Image.network(
                                                                                    '${controller.serverUrl}/offer-items/offerItems/${data.images![0].filename}',
                                                                                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                                                                      if (loadingProgress == null) {
                                                                                        return child;
                                                                                      }
                                                                                      return Center(
                                                                                        child: CircularProgressIndicator(
                                                                                          value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                    errorBuilder: (context, error, stackTrace) {
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
                                                                    FxSpacing
                                                                        .width(
                                                                            16),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        FxText.labelLarge(data
                                                                            .itemName
                                                                            .toString()),
                                                                        FxText
                                                                            .labelSmall(
                                                                          data.itemCategory
                                                                              .toString(),
                                                                          muted:
                                                                              true,
                                                                          letterSpacing:
                                                                              0,
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              )),
                                                              DataCell(FxText
                                                                  .bodyMedium(
                                                                      '\$${data.minimumPrice}')),
                                                              DataCell(Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .star_outline_rounded,
                                                                    color: AppColors
                                                                        .ratingStarColor,
                                                                    size: 20,
                                                                  ),
                                                                  FxSpacing
                                                                      .width(4),
                                                                  FxText.bodySmall(
                                                                      '${data.quantity} (${data.quantity})')
                                                                ],
                                                              )),
                                                              DataCell(FxText
                                                                  .bodyMedium(
                                                                      '${data.quantity}')),
                                                              DataCell(FxText
                                                                  .bodyMedium(
                                                                      '${data.quantity}')),
                                                              DataCell(FxText
                                                                  .bodyMedium(
                                                                      '${data.quantity}')),
                                                              DataCell(Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  FxText.labelLarge(
                                                                      '${Utils.formatDateTime(DateTime.parse(data.createdDate.toString()))}'),
                                                                  FxSpacing
                                                                      .width(4),
                                                                  FxText
                                                                      .bodySmall(
                                                                    '${Utils.formatTime(DateTime.parse(data.createdDate.toString()))}',
                                                                    muted: true,
                                                                    fontWeight:
                                                                        600,
                                                                  )
                                                                ],
                                                              )),
                                                              DataCell(InkWell(
                                                                onTap: () {
                                                                  controller
                                                                      .goToCreateProduct;
                                                                },
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: FxContainer
                                                                      .bordered(
                                                                    onTap: () =>
                                                                        {},
                                                                    padding:
                                                                        FxSpacing.xy(
                                                                            6,
                                                                            6),
                                                                    borderColor: contentTheme
                                                                        .primary
                                                                        .withAlpha(
                                                                            40),
                                                                    child: Icon(
                                                                      FeatherIcons
                                                                          .edit2,
                                                                      size: 12,
                                                                      color: contentTheme
                                                                          .primary,
                                                                    ),
                                                                  ),
                                                                ),
                                                              )),
                                                              // DataCell(FxText.bodyMedium('${DateTime.tryParse('2022-11-26T15:56:14Z')}')),
                                                            ]))
                                                    .toList())),
                                      )
                                    : Column(
                                        children: [Text('No Items')],
                                      ),
                          ),
                        ],
                      )),
                ],
              );
            }));
  }
}
