import 'package:core_erp/controllers/apps/ecommerce/invoice_controller.dart';
import 'package:core_erp/images.dart';
import 'package:core_erp/services/theme/app_style.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:core_erp/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({Key? key}) : super(key: key);

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage>
    with SingleTickerProviderStateMixin, UIMixin {
  late InvoiceController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(InvoiceController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: FxSpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FxText.titleMedium(
                      "Invoice",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    FxBreadcrumb(
                      children: [
                        FxBreadcrumbItem(name: "Extra Pages"),
                        FxBreadcrumbItem(name: "Invoice", active: true),
                      ],
                    ),
                  ],
                ),
              ),
              FxSpacing.height(flexSpacing),
              Padding(
                padding: FxSpacing.x(flexSpacing / 4),
                child: FxFlex(
                  wrapAlignment: WrapAlignment.start,
                  wrapCrossAlignment: WrapCrossAlignment.start,
                  children: [
                    FxFlexItem(
                      sizes: "md-12",
                      child: FxContainer(
                        paddingAll: 0,
                        child: Padding(
                          padding: FxSpacing.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        Images.logoIcon,
                                        height: 16,
                                      ),
                                      FxSpacing.width(8),
                                      FxText.titleMedium("Flatten"),
                                    ],
                                  ),
                                  FxText.titleMedium("Invoice"),
                                ],
                              ),
                              FxSpacing.height(40),
                              FxFlexItem(
                                sizes: "lg-6 md-12",
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FxText.bodyMedium(
                                      "Hello, Denish Navadiya",
                                      fontWeight: 600,
                                    ),
                                    Wrap(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                FxText.bodySmall(
                                                  "Order Date :",
                                                  fontWeight: 600,
                                                ),
                                                FxSpacing.height(8),
                                                FxText.bodySmall(
                                                  "Order Status :",
                                                  fontWeight: 600,
                                                ),
                                                FxSpacing.height(8),
                                                FxText.bodySmall(
                                                  "Order No. :",
                                                  fontWeight: 600,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                FxText.bodySmall(
                                                  "May 10, 2023",
                                                ),
                                                FxSpacing.height(8),
                                                FxContainer(
                                                  paddingAll: 2,
                                                  color: contentTheme.primary,
                                                  child: FxText.bodySmall(
                                                    "Paid",
                                                    fontSize: 10,
                                                    color:
                                                        contentTheme.onPrimary,
                                                  ),
                                                ),
                                                FxSpacing.height(8),
                                                FxText.bodySmall(
                                                  "#000047",
                                                  fontWeight: 600,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              FxSpacing.height(30),
                              FxFlexItem(
                                sizes: "lg-6 md-12",
                                child: Wrap(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            FxText.bodyMedium(
                                              "Billing Address",
                                              fontWeight: 600,
                                            ),
                                            FxSpacing.height(4),
                                            FxText.bodySmall("Apple Head"),
                                            FxSpacing.height(4),
                                            FxText.bodySmall(
                                                "4006 S Lamar Blvd #650"),
                                            FxSpacing.height(4),
                                            FxText.bodySmall(
                                                "Austin, Austin 78704"),
                                            FxSpacing.height(4),
                                            FxText.bodySmall(
                                                "P: (512) 474-5433"),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            FxText.bodyMedium(
                                              "Shipping Address",
                                              fontWeight: 600,
                                            ),
                                            FxSpacing.height(4),
                                            FxText.bodySmall("Denish Navadiya"),
                                            FxSpacing.height(4),
                                            FxText.bodySmall("75 E Ramapo Ave"),
                                            FxSpacing.height(4),
                                            FxText.bodySmall(
                                                "Mahwah, New Mexico 07430"),
                                            FxSpacing.height(4),
                                            FxText.bodySmall(
                                                "P: (201) 512-1141"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              FxSpacing.height(40),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: FxContainer.none(
                                  borderRadiusAll: 0,
                                  child: DataTable(
                                    sortAscending: true,
                                    dataRowHeight: 80,
                                    columns: [
                                      DataColumn(
                                        label: FxText.labelLarge(
                                          "#",
                                          color: contentTheme.primary,
                                        ),
                                      ),
                                      DataColumn(
                                        label: FxText.labelLarge(
                                          "Item",
                                          color: contentTheme.primary,
                                        ),
                                      ),
                                      DataColumn(
                                        label: FxText.labelLarge(
                                          "Hours",
                                          color: contentTheme.primary,
                                        ),
                                      ),
                                      DataColumn(
                                        label: FxText.labelLarge(
                                          "Hours Rate",
                                          color: contentTheme.primary,
                                        ),
                                      ),
                                      DataColumn(
                                        label: FxText.labelLarge(
                                          "Total",
                                          color: contentTheme.primary,
                                        ),
                                      ),
                                    ],
                                    rows: [
                                      DataRow(
                                        cells: [
                                          DataCell(
                                            FxText(
                                              "1",
                                            ),
                                          ),
                                          DataCell(
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                FxText.bodyMedium(
                                                  "Flutter Admin",
                                                  fontWeight: 600,
                                                ),
                                                FxText.bodySmall(
                                                    "2 Pages static website - core_erp"),
                                              ],
                                            ),
                                          ),
                                          DataCell(
                                            FxText(
                                              "10",
                                            ),
                                          ),
                                          DataCell(
                                            FxText(
                                              "\$28",
                                            ),
                                          ),
                                          DataCell(
                                            FxText(
                                              "\$280",
                                            ),
                                          ),
                                        ],
                                      ),
                                      DataRow(
                                        cells: [
                                          DataCell(
                                            FxText(
                                              "2",
                                            ),
                                          ),
                                          DataCell(
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                FxText.bodyMedium(
                                                  "Flutter Development",
                                                  fontWeight: 600,
                                                ),
                                                FxText.bodySmall(
                                                    "It's invoice web"),
                                              ],
                                            ),
                                          ),
                                          DataCell(
                                            FxText(
                                              "45",
                                            ),
                                          ),
                                          DataCell(
                                            FxText(
                                              "\$12",
                                            ),
                                          ),
                                          DataCell(
                                            FxText(
                                              "\$540",
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              FxSpacing.height(22),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FxText.bodySmall(
                                        "Sub Total:",
                                        fontWeight: 600,
                                      ),
                                      FxSpacing.width(12),
                                      FxText.bodySmall(
                                        "Discount (20%):",
                                        fontWeight: 600,
                                      ),
                                    ],
                                  ),
                                  FxSpacing.height(12),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      FxText.bodySmall(
                                        "\$820",
                                        fontWeight: 600,
                                      ),
                                      FxSpacing.width(12),
                                      FxText.bodySmall(
                                        "\$164",
                                        fontWeight: 600,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              FxSpacing.height(12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FxText(
                                    "\$656 USD",
                                    fontWeight: 700,
                                    fontSize: 22,
                                  ),
                                ],
                              ),
                              FxSpacing.height(22),
                              FxText.bodySmall(
                                "Notes:",
                                fontWeight: 600,
                              ),
                              Row(
                                children: [
                                  FxContainer.none(
                                    width: 250,
                                    child: FxText.bodySmall(
                                      controller.dummyTexts[1],
                                      maxLines: 2,
                                      muted: true,
                                    ),
                                  ),
                                ],
                              ),
                              FxSpacing.height(22),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FxButton(
                                    onPressed: () {},
                                    elevation: 0,
                                    padding: FxSpacing.xy(20, 16),
                                    backgroundColor: contentTheme.primary,
                                    borderRadiusAll:
                                        AppStyle.buttonRadius.medium,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.print,
                                          size: 14,
                                        ),
                                        FxSpacing.width(8),
                                        FxText.bodySmall(
                                          'Print',
                                          color: contentTheme.onPrimary,
                                        ),
                                      ],
                                    ),
                                  ),
                                  FxSpacing.width(8),
                                  FxButton(
                                    onPressed: () {},
                                    elevation: 0,
                                    padding: FxSpacing.xy(20, 16),
                                    backgroundColor: contentTheme.success,
                                    borderRadiusAll:
                                        AppStyle.buttonRadius.medium,
                                    child: FxText.bodySmall(
                                      'Submit',
                                      color: contentTheme.onPrimary,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
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
}
