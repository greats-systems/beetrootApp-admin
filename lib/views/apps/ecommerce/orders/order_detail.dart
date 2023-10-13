import 'package:auto_size_text/auto_size_text.dart';
import 'package:core_erp/controllers/apps/ecommerce/order_detail_controller.dart';
import 'package:core_erp/models/order.dart';
import 'package:core_erp/services/storage/local_storage.dart';
import 'package:core_erp/views/apps/ecommerce/orders/order_servicing.dart';
import 'package:get/get.dart';
import 'package:core_erp/controllers/apps/ecommerce/product_detail_controller.dart';
import 'package:core_erp/services/theme/app_style.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:core_erp/views/apps/ecommerce/edit_product.dart';
import 'package:core_erp/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

const List<Tab> tabs = <Tab>[
  Tab(text: 'Zeroth'),
  Tab(text: 'First'),
  Tab(text: 'Second'),
  Tab(text: '4th'),
];

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({Key? key}) : super(key: key);

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late OrderDetailController controller;
  late Order selectedOrder = Order();
  @override
  void initState() {
    controller = Get.put(OrderDetailController());
    LocalStorage.getCurrentSelectedOrder().then((value) => {
          if (value != null)
            {
              debugPrint('value != null ${value.orderID}'),
              controller.order.value = value,
              setState(() {
                selectedOrder = value;
              })
            }
          else
            {Get.toNamed('/apps/ecommerce/orders')}
        });
    debugPrint(
        'selectedOrder commodityWeight ${selectedOrder.commodityWeight}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return selectedOrder.orderID != null
        ? Layout(
            child: GetBuilder(
              init: controller,
              builder: (controller) {
                debugPrint(
                    'GetBuilder .order.value.commodityWeight ${controller.order.value.commodityWeight}');
                // if (controller.order.value.offerItem!.images != null) {
                //   controller.onChangeImage(
                //       controller.order.value.offerItem!.images![0].filename.toString());
                // }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: FxSpacing.x(flexSpacing),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // FxText.titleMedium(
                          //   "Product Detail",
                          //   fontWeight: 600,
                          // ),
                          FxBreadcrumb(
                            children: [
                              FxBreadcrumbItem(name: "services"),
                              FxBreadcrumbItem(
                                  name:
                                      "${controller.order.value.offerItem!.itemCategory}",
                                  active: true),
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
                            sizes: "lg-4 md-12",
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                FxContainer(
                                  borderRadiusAll: 8,
                                  paddingAll: 0,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: controller.order.value.offerItem!
                                          .images!.isNotEmpty
                                      ? Container(
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: ClipRRect(
                                            // borderRadius: BorderRadius.circular(50),
                                            child: Image.network(
                                              fit: BoxFit.cover,
                                              height: 450,
                                              controller.selectedOrderOfferItemImagePath !=
                                                      ''
                                                  ? '${controller.apiUrl}/offer-items/offerItems/${controller.selectedOrderOfferItemImagePath}'
                                                  : '${controller.apiUrl}/offer-items/offerItems/${controller.selectedOrderOfferItemImage.filename}',
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
                                                  size: 90,
                                                );
                                              },
                                              // fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      : const Icon(
                                          Icons.no_accounts,
                                          size: 50,
                                        ),
                                ),
                                FxSpacing.height(8),
                                Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    runSpacing: 12,
                                    spacing: 12,
                                    children: controller
                                        .order.value.offerItem!.images!
                                        .mapIndexed(
                                          (index, image) =>
                                              FxContainer.bordered(
                                            onTap: () {
                                              controller.onChangeImage(
                                                  image.filename.toString());
                                            },
                                            height: 100,
                                            bordered: image.filename ==
                                                controller
                                                    .selectedOrderOfferItemImagePath,
                                            border: Border.all(
                                                color: contentTheme.primary,
                                                width: 2),
                                            borderRadiusAll: 8,
                                            paddingAll: 0,
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            child: Image.network(
                                              '${controller.apiUrl}/offer-items/offerItems/${image.filename.toString()}',
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )
                                        .toList()),
                              ],
                            ),
                          ),
                          FxFlexItem(
                            sizes: "lg-8 md-12",
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FxText.bodyMedium(
                                  '${controller.order.value.offerItemCategory!.capitalizeFirst}',
                                  fontSize: 12,
                                  color: contentTheme.primary,
                                ),
                                FxSpacing.height(8),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: FxText(
                                        controller.order.value.offerItem!
                                            .itemName!.capitalizeFirst
                                            .toString()
                                            .tr,
                                        fontWeight: 600,
                                        fontSize: 28,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    FxSpacing.width(8),
                                    FxButton(
                                      onPressed: () {
                                        Get.to(const EditProduct());
                                      },
                                      elevation: 0,
                                      padding: FxSpacing.xy(8, 6),
                                      borderColor: contentTheme.primary,
                                      backgroundColor: contentTheme.primary
                                          .withOpacity(0.12),
                                      splashColor:
                                          contentTheme.primary.withOpacity(0.2),
                                      borderRadiusAll:
                                          AppStyle.buttonRadius.medium,
                                      child: FxText.bodySmall(
                                        'Edit',
                                        color: contentTheme.primary,
                                      ),
                                    ),
                                  ],
                                ),
                                FxSpacing.height(8),
                                FxSpacing.height(24),
                                FxFlex(
                                  wrapCrossAlignment: WrapCrossAlignment.start,
                                  runSpacing: 20,
                                  contentPadding: false,
                                  children: [
                                    FxFlexItem(
                                      sizes: "xl-3 md-6 sm-12",
                                      child: buildProductDetail(
                                          "Weight:",
                                          controller.order.value.commodityWeight
                                              .toString(),
                                          Icons.attach_money_outlined),
                                    ),
                                    FxFlexItem(
                                        sizes: "xl-3 md-6 sm-12",
                                        child: buildProductDetail(
                                            "Service Charge:",
                                            "\$ ${controller.order.value.commodityWeight.toString()}",
                                            Icons.delivery_dining_outlined)),
                                    FxFlexItem(
                                        sizes: "xl-3 md-6 sm-12",
                                        child: buildProductDetail(
                                            "Service In-Request:",
                                            "${controller.order.value.orderStatus.toString()}",
                                            Icons.layers_outlined)),
                                    FxFlexItem(
                                        sizes: "xl-3 md-6 sm-12",
                                        child: buildProductDetail(
                                            "Order Status:",
                                            "${controller.order.value.orderStatus.toString()}",
                                            Icons.history_outlined)),
                                  ],
                                ),
                                FxSpacing.height(20),
                                // Row(
                                //   children: [
                                //     FxText.titleSmall(
                                //       "Quantity",
                                //       fontWeight: 600,
                                //     ),
                                //     FxSpacing.width(16),
                                //     PopupMenuButton(
                                //         onSelected: controller.onSelectedQty,
                                //         itemBuilder: (BuildContext context) {
                                //           return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                                //               .map((behavior) {
                                //             return PopupMenuItem(
                                //               value: behavior,
                                //               height: 32,
                                //               child: FxText.bodySmall(
                                //                 behavior.toString(),
                                //                 color: theme.colorScheme.onBackground,
                                //                 fontWeight: 600,
                                //               ),
                                //             );
                                //           }).toList();
                                //         },
                                //         color: theme.cardTheme.color,
                                //         child: FxContainer.bordered(
                                //           padding: FxSpacing.xy(12, 8),
                                //           child: Row(
                                //             children: <Widget>[
                                //               FxText.labelMedium(
                                //                 controller.selectedQuntity.toString(),
                                //                 color: theme.colorScheme.onBackground,
                                //               ),
                                //               Container(
                                //                 margin: EdgeInsets.only(left: 4),
                                //                 child: Icon(
                                //                   Icons.expand_more_outlined,
                                //                   size: 22,
                                //                   color:
                                //                       theme.colorScheme.onBackground,
                                //                 ),
                                //               )
                                //             ],
                                //           ),
                                //         )),
                                //     FxSpacing.width(24),
                                //     FxText.titleSmall(
                                //       "Sizes",
                                //       fontWeight: 600,
                                //     ),
                                //     FxSpacing.width(16),
                                //     PopupMenuButton(
                                //         itemBuilder: (BuildContext context) {
                                //           return ["Small", "Medium", "Large", "XL"]
                                //               .map((behavior) {
                                //             return PopupMenuItem(
                                //               value: behavior,
                                //               height: 32,
                                //               child: FxText.bodySmall(
                                //                 behavior.toString(),
                                //                 color: theme.colorScheme.onBackground,
                                //                 fontWeight: 600,
                                //               ),
                                //             );
                                //           }).toList();
                                //         },
                                //         onSelected: controller.onSelectedSize,
                                //         color: theme.cardTheme.color,
                                //         child: FxContainer.bordered(
                                //           padding: FxSpacing.xy(12, 8),
                                //           child: Row(
                                //             children: <Widget>[
                                //               FxText.labelMedium(
                                //                 controller.selectSize.toString(),
                                //                 color: theme.colorScheme.onBackground,
                                //               ),
                                //               Container(
                                //                 margin: EdgeInsets.only(left: 4),
                                //                 child: Icon(
                                //                   Icons.expand_more_outlined,
                                //                   size: 22,
                                //                   color:
                                //                       theme.colorScheme.onBackground,
                                //                 ),
                                //               )
                                //             ],
                                //           ),
                                //         )),
                                //   ],
                                // ),
                                // FxSpacing.height(24),
                                // Row(
                                //   children: [
                                //     FxButton.outlined(
                                //       onPressed: () {},
                                //       elevation: 0,
                                //       padding: FxSpacing.xy(20, 16),
                                //       borderColor: contentTheme.primary,
                                //       splashColor:
                                //           contentTheme.primary.withOpacity(0.1),
                                //       borderRadiusAll: AppStyle.buttonRadius.medium,
                                //       child: FxText.bodySmall(
                                //         'ADD TO CART',
                                //         color: contentTheme.primary,
                                //       ),
                                //     ),
                                //     FxSpacing.width(16),
                                //     FxButton(
                                //       onPressed: () {},
                                //       elevation: 0,
                                //       padding: FxSpacing.xy(20, 16),
                                //       backgroundColor: contentTheme.primary,
                                //       borderRadiusAll: AppStyle.buttonRadius.medium,
                                //       child: FxText.bodySmall(
                                //         'BUY NOW',
                                //         color: contentTheme.onPrimary,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // FxSpacing.height(24),
                                // FxText.titleSmall(
                                //   "Description :",
                                //   fontWeight: 600,
                                // ),
                                // FxSpacing.height(8),
                                // FxText.bodySmall(
                                //   controller.dummyTexts[0],
                                //   maxLines: 2,
                                //   overflow: TextOverflow.ellipsis,
                                //   muted: true,
                                // ),
                                // FxSpacing.height(24),
                                // Row(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Expanded(
                                //       child: Column(
                                //         crossAxisAlignment: CrossAxisAlignment.start,
                                //         children: [
                                //           FxText.titleSmall(
                                //             "Features :",
                                //             fontWeight: 600,
                                //           ),
                                //           FxSpacing.height(8),
                                //           buildFeature("HDR Lights"),
                                //           FxSpacing.height(4),
                                //           buildFeature("Remote controlled"),
                                //           FxSpacing.height(4),
                                //           buildFeature("5+ Colors available"),
                                //         ],
                                //       ),
                                //     ),
                                //     Column(
                                //       mainAxisAlignment: MainAxisAlignment.start,
                                //       crossAxisAlignment: CrossAxisAlignment.start,
                                //       children: [
                                //         FxText.titleSmall(
                                //           "Services :",
                                //           fontWeight: 600,
                                //         ),
                                //         FxSpacing.height(8),
                                //         FxText.titleMedium(
                                //           "14 Days Replacement",
                                //           fontSize: 13,
                                //         ),
                                //         FxSpacing.height(4),
                                //         FxText.titleMedium(
                                //           "2 Year warranty",
                                //           fontSize: 13,
                                //         ),
                                //       ],
                                //     ),
                                //   ],
                                // ),
                                FxSpacing.height(24),
                                FxText.titleSmall(
                                  "Product Description :",
                                  fontWeight: 600,
                                ),
                                FxSpacing.height(8),
                                FxContainer.bordered(
                                    padding: FxSpacing.x(20),
                                    child: DefaultTabController(
                                      length: tabs.length,
                                      // The Builder widget is used to have a different BuildContext to access
                                      // closest DefaultTabController.
                                      child: Builder(
                                          builder: (BuildContext context) {
                                        final TabController tabController =
                                            DefaultTabController.of(context);
                                        tabController.addListener(() {
                                          if (!tabController.indexIsChanging) {
                                            // Your code goes here.
                                            // To get index of current tab use tabController.index
                                            controller.defaultIndex.value =
                                                tabController.index;
                                          }
                                        });
                                        return Obx(() => Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TabBar(
                                                    controller: tabController,
                                                    isScrollable: false,
                                                    tabs: [
                                                      Tab(
                                                        icon: FxText.bodyMedium(
                                                          "Order Service",
                                                          fontWeight: controller
                                                                      .defaultIndex
                                                                      .value ==
                                                                  0
                                                              ? 600
                                                              : 500,
                                                          color: tabController
                                                                      .index ==
                                                                  0
                                                              ? contentTheme
                                                                  .primary
                                                              : null,
                                                        ),
                                                      ),
                                                      Tab(
                                                        icon: FxText.bodyMedium(
                                                          "Order Detail",
                                                          fontWeight: controller
                                                                      .defaultIndex
                                                                      .value ==
                                                                  1
                                                              ? 600
                                                              : 500,
                                                          color: tabController
                                                                      .index ==
                                                                  1
                                                              ? contentTheme
                                                                  .primary
                                                              : null,
                                                        ),
                                                      ),
                                                      Tab(
                                                        icon: FxText.bodyMedium(
                                                          "Customer Detail",
                                                          fontWeight: controller
                                                                      .defaultIndex
                                                                      .value ==
                                                                  2
                                                              ? 600
                                                              : 500,
                                                          color: tabController
                                                                      .index ==
                                                                  2
                                                              ? contentTheme
                                                                  .primary
                                                              : null,
                                                        ),
                                                      ),
                                                      Tab(
                                                        icon: FxText.bodyMedium(
                                                          "Ledger Detail",
                                                          fontWeight: controller
                                                                      .defaultIndex
                                                                      .value ==
                                                                  3
                                                              ? 600
                                                              : 500,
                                                          color: controller
                                                                      .defaultIndex
                                                                      .value ==
                                                                  3
                                                              ? contentTheme
                                                                  .primary
                                                              : null,
                                                        ),
                                                      ),
                                                    ],
                                                    // controller: _tabController,
                                                    indicatorSize:
                                                        TabBarIndicatorSize.tab,
                                                  ),
                                                  FxSpacing.height(8),
                                                  SizedBox(
                                                    height: 560,
                                                    child: TabBarView(
                                                      controller: tabController,
                                                      children: [
                                                        // FxSpacing.height(4),
                                                        OrderServicingWidget(),
                                                        DataTable(
                                                          sortAscending: true,
                                                          onSelectAll:
                                                              (value) {},
                                                          headingRowColor:
                                                              MaterialStatePropertyAll(
                                                                  contentTheme
                                                                      .primary
                                                                      .withAlpha(
                                                                          40)),
                                                          dataRowMaxHeight: 50,
                                                          columns: [
                                                            DataColumn(
                                                              label: FxText
                                                                  .labelLarge(
                                                                "Info",
                                                                fontWeight: 600,
                                                                color:
                                                                    contentTheme
                                                                        .primary,
                                                              ),
                                                            ),
                                                            DataColumn(
                                                              label: FxText
                                                                  .labelLarge(
                                                                "Details",
                                                                color:
                                                                    contentTheme
                                                                        .primary,
                                                              ),
                                                            ),
                                                          ],
                                                          rows: [
                                                            buildDataRows(
                                                              "orderDate",
                                                              "${controller.order.value.offerItem!.itemCategory}",
                                                            ),
                                                            buildDataRows(
                                                                "orderStatus",
                                                                "${controller.order.value.offerItem!.itemCategory}"),
                                                            buildDataRows(
                                                              "Category",
                                                              "${controller.order.value.offerItem!.itemCategory}",
                                                            ),
                                                            buildDataRows(
                                                              "offerItemCategory",
                                                              "${controller.order.value.offerItem!.itemCategory}",
                                                            ),
                                                            buildDataRows(
                                                              "orderTrackerHash",
                                                              "${controller.order.value.offerItem!.itemCategory}",
                                                            ),
                                                            buildDataRows(
                                                              "Weight",
                                                              "${controller.order.value.commodityWeight}",
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            FxText.titleSmall(
                                                              "-----",
                                                              fontWeight: 600,
                                                              fontSize: 18,
                                                            ),
                                                            FxSpacing.height(
                                                                12),
                                                            FxText.bodySmall(
                                                              controller
                                                                  .dummyTexts[1],
                                                            ),
                                                            FxSpacing.height(8),
                                                            buildFeature(
                                                                "-----"),
                                                            FxSpacing.height(4),
                                                            buildFeature(
                                                                "--- controlled"),
                                                            FxSpacing.height(4),
                                                            buildFeature(
                                                                " available"),
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            FxText.titleSmall(
                                                              "Night Lamp (Yellow)",
                                                              fontWeight: 600,
                                                              fontSize: 18,
                                                            ),
                                                            FxSpacing.height(
                                                                12),
                                                            FxText.bodySmall(
                                                              controller
                                                                  .dummyTexts[1],
                                                            ),
                                                            FxSpacing.height(8),
                                                            buildFeature(
                                                                "HDR Lights"),
                                                            FxSpacing.height(4),
                                                            buildFeature(
                                                                "Remote controlled"),
                                                            FxSpacing.height(4),
                                                            buildFeature(
                                                                "5+ Colors available"),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ]));
                                      }),
                                    ))
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
          )
        : Column(
            children: [
              CircularProgressIndicator(
                color: theme.primaryColor,
              )
            ],
          );
  }

  buildProductDetail(
    String name,
    String value,
    IconData icon,
  ) {
    return FxDottedLine(
      strokeWidth: 0.2,
      corner: FxDottedLineCorner(
        leftBottomCorner: 2,
        leftTopCorner: 2,
        rightBottomCorner: 2,
        rightTopCorner: 2,
      ),
      child: Padding(
        padding: FxSpacing.xy(16, 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: contentTheme.success,
            ),
            FxSpacing.width(16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AutoSizeText(
                  name.tr,
                  minFontSize: 8,
                  maxFontSize: 12,
                  style: TextStyle(fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
                AutoSizeText(
                  value.tr,
                  minFontSize: 8,
                  maxFontSize: 12,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  buildFeature(String feature) {
    return Row(
      children: [
        Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(
            color: contentTheme.title,
            shape: BoxShape.circle,
          ),
        ),
        FxSpacing.width(12),
        Expanded(
          child: FxText.titleSmall(
            feature,
            fontSize: 13,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  buildDataRows(String attributes, String details) {
    return DataRow(
      cells: [
        DataCell(
          FxText.bodySmall(
            attributes,
            fontWeight: 600,
          ),
        ),
        DataCell(
          SizedBox(
            width: 500,
            child: FxText.bodySmall(
              details,
            ),
          ),
        ),
      ],
    );
  }
}
