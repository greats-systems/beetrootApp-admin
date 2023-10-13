import 'package:core_erp/app_constant.dart';
import 'package:core_erp/controllers/apps/ecommerce/edit_products_controller.dart';
import 'package:core_erp/controllers/apps/ecommerce/order_detail_controller.dart';
import 'package:core_erp/controllers/apps/provider-admin/provider-admin_controller.dart';
import 'package:core_erp/controllers/auth/auth_controller.dart';
import 'package:core_erp/controllers/forms/basic_controller.dart';
import 'package:core_erp/extensions/date_time_extension.dart';
import 'package:core_erp/extensions/string.dart';
import 'package:core_erp/models/vendor.dart';
import 'package:core_erp/services/theme/app_style.dart';
import 'package:core_erp/widgets/stepper.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';

import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

class OrderServicingWidget extends StatelessWidget with UIMixin {
  OrderServicingWidget({super.key});
  OrderDetailController orderDetailController =
      Get.put(OrderDetailController());
  AuthController authController = Get.put(AuthController());
  AuthController providerAdminController = Get.put(AuthController());
  BasicFormsController basicFormsController = Get.put(BasicFormsController());
  final List<String> titles = [
    'request',
    'new',
    'intransit',
    'on-dock',
    'weighed',
    'stored',
    'quequed',
    'graded',
    'certified',
    'receippted',
    'rejected',
  ];
  final int _curStep = 0;
  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            FxSpacing.height(15),
            StepProgressView(
              color: theme.primaryColor,
              curStep: _curStep,
              titles: titles,
              width: MediaQuery.of(context).size.width,
            ),
            FxSpacing.height(24),
            orderDetailController.order.value.orderStatus ==
                        'transport-request-order' ||
                    orderDetailController.order.value.orderStatus ==
                        'grading-request-order'
                ? respondToOrderButtons()
                : Column(),
            FxSpacing.height(24),
            orderDetailController.orderRequestResponse.value == 'accepted'
                ? respondToOrder()
                : Column(),
            authController.person.value.tradingAs == 'warehouse' &&
                    orderDetailController.order.value.orderStatus ==
                        'grading-request-accepted'
                ? serviceOrder()
                : Column(),
            FxSpacing.height(25),
          ],
        ));
  }

  respondToOrderButtons() {
    return Row(
      children: [
        FxButton.outlined(
          onPressed: () {
            orderDetailController.respondToOrderRequest('accepted');
            orderDetailController.getTradeProviders('transporter');
          },
          elevation: 0,
          padding: FxSpacing.xy(20, 16),
          borderColor: contentTheme.primary,
          splashColor: contentTheme.primary.withOpacity(0.1),
          borderRadiusAll: AppStyle.buttonRadius.medium,
          child: FxText.bodySmall(
            'Aceept Order Request',
            color: contentTheme.primary,
          ),
        ),
        FxSpacing.width(16),
        FxButton(
          onPressed: () {
            orderDetailController.respondToOrderRequest('rejected');
          },
          elevation: 0,
          padding: FxSpacing.xy(20, 16),
          backgroundColor: contentTheme.primary,
          borderRadiusAll: AppStyle.buttonRadius.medium,
          child: FxText.bodySmall(
            'Reject Order Request',
            color: contentTheme.onPrimary,
          ),
        ),
      ],
    );
  }

  gradingCommodityActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FxButton.outlined(
          onPressed: () {
            orderDetailController.respondToOrderRequest('accepted');
            orderDetailController.getTradeProviders('transporter');
          },
          elevation: 0,
          padding: FxSpacing.xy(20, 16),
          borderColor: contentTheme.primary,
          splashColor: contentTheme.primary.withOpacity(0.1),
          borderRadiusAll: AppStyle.buttonRadius.medium,
          child: FxText.bodySmall(
            'Grade Commodity',
            color: contentTheme.primary,
          ),
        ),
        FxSpacing.width(16),
        FxButton(
          onPressed: () {
            orderDetailController.respondToOrderRequest('rejected');
          },
          elevation: 0,
          padding: FxSpacing.xy(20, 16),
          backgroundColor: contentTheme.primary,
          borderRadiusAll: AppStyle.buttonRadius.medium,
          child: FxText.bodySmall(
            'Declared Graded',
            color: contentTheme.onPrimary,
          ),
        ),
        FxSpacing.width(16),
        FxButton(
          onPressed: () {
            orderDetailController.respondToOrderRequest('rejected');
          },
          elevation: 0,
          padding: FxSpacing.xy(20, 16),
          backgroundColor: contentTheme.lightPrimary,
          borderRadiusAll: AppStyle.buttonRadius.medium,
          child: FxText.bodySmall(
            'Issue Receipt',
            color: contentTheme.onPrimary,
          ),
        ),
      ],
    );
  }

  respondToOrder() {
    return FxContainer.bordered(
      paddingAll: 0,
      child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: colorScheme.primary.withOpacity(0.08),
                padding: FxSpacing.xy(flexSpacing, 12),
                child: Row(
                  children: [
                    Icon(
                      FeatherIcons.layers,
                      color: colorScheme.primary,
                      size: 16,
                    ),
                    FxSpacing.width(12),
                    FxText.titleMedium(
                      "order_request".tr().capitalizeWords,
                      fontWeight: 600,
                      color: colorScheme.primary,
                    ),
                  ],
                ),
              ),
              orderDetailController.orderRequestResponse.value == 'accepted' &&
                      authController.person.value.tradingAs == 'warehouse'
                  ? gradingResponse()
                  : orderDetailController.orderRequestResponse.value ==
                              'accepted' &&
                          authController.person.value.tradingAs == 'transporter'
                      ? transporterPickupResponse()
                      : Column()
            ],
          )),
    );
  }

  serviceOrder() {
    return FxContainer.bordered(
      paddingAll: 0,
      child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: colorScheme.primary.withOpacity(0.08),
                padding: FxSpacing.xy(flexSpacing, 12),
                child: Row(
                  children: [
                    Icon(
                      FeatherIcons.layers,
                      color: colorScheme.primary,
                      size: 16,
                    ),
                    FxSpacing.width(12),
                    FxText.titleMedium(
                      "order_services".tr().capitalizeWords,
                      fontWeight: 600,
                      color: colorScheme.primary,
                    ),
                  ],
                ),
              ),
              FxSpacing.height(30),
              authController.person.value.tradingAs == 'warehouse' &&
                      orderDetailController.order.value.orderStatus ==
                          'grading-request-accepted'
                  ? gradingCommodityActions()
                  : Column(),
              FxSpacing.height(30),
            ],
          )),
    );
  }

  gradingResponse() {
    return Padding(
      padding: FxSpacing.all(flexSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FxSpacing.height(25),
          FxFlex(contentPadding: false, children: [
            FxFlexItem(
                sizes: 'lg-6 md-12',
                child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FxText.labelMedium(
                          "Select Transporter ${authController.queriedServiceProviders.length}"
                              .tr(),
                        ),
                        FxSpacing.height(8),
                        DropdownButtonFormField<Provider>(
                          dropdownColor: colorScheme.background,
                          menuMaxHeight: 200,
                          isDense: true,

                          // itemHeight: 40,
                          items: authController.queriedServiceProviders
                              .map(
                                (provider) => DropdownMenuItem<Provider>(
                                  value: provider,
                                  child: FxText.labelMedium(
                                    provider.provider.firstName!.capitalize,
                                  ),
                                ),
                              )
                              .toList(),
                          icon: Icon(
                            Icons.expand_more,
                            size: 20,
                          ),
                          decoration: InputDecoration(
                            hintText: "Select transport",
                            hintStyle: FxTextStyle.bodySmall(xMuted: true),
                            border: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                            focusedBorder: focusedInputBorder,
                            contentPadding: FxSpacing.all(14),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                          onChanged: (value) =>
                              authController.onSelectedProvider(value!),
                        )
                      ],
                    ))),
          ]),
          FxSpacing.height(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FxButton.outlined(
                onPressed: () {
                  orderDetailController.respondToGradingOrder('accepted');
                },
                elevation: 0,
                padding: FxSpacing.xy(20, 16),
                borderColor: contentTheme.primary,
                splashColor: contentTheme.primary.withOpacity(0.1),
                borderRadiusAll: AppStyle.buttonRadius.medium,
                child: FxText.bodySmall(
                  'Continue',
                  color: contentTheme.primary,
                ),
              ),
              FxSpacing.width(16),
              FxButton(
                onPressed: () {
                  orderDetailController.respondToGradingOrder('rejected');
                },
                elevation: 0,
                padding: FxSpacing.xy(20, 16),
                backgroundColor: Colors.red,
                borderRadiusAll: AppStyle.buttonRadius.medium,
                child: FxText.bodySmall(
                  'Cancel',
                  color: contentTheme.onPrimary,
                ),
              ),
            ],
          ),
          FxSpacing.height(25),
        ],
      ),
    );
  }

  transporterPickupResponse() {
    return Padding(
      padding: FxSpacing.all(flexSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FxText.labelLarge("order_pickup_date".tr().capitalizeWords),
          FxSpacing.height(12),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              FxButton.outlined(
                onPressed: () {
                  basicFormsController.pickDateTime();
                },
                borderColor: colorScheme.primary,
                padding: FxSpacing.xy(16, 16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.event_available_outlined,
                      color: colorScheme.primary,
                      size: 16,
                    ),
                    FxSpacing.width(10),
                    FxText.labelMedium(
                        basicFormsController.selectedDateTime != null
                            ? "${dateFormatter.format(basicFormsController.selectedDateTime!)} ${timeFormatter.format(basicFormsController.selectedDateTime!)}"
                            : "select_date_&_time".tr().capitalizeWords,
                        fontWeight: 600,
                        color: colorScheme.primary),
                  ],
                ),
              ),
            ],
          ),
          FxSpacing.height(25),
          FxFlex(contentPadding: false, children: [
            FxFlexItem(
                sizes: 'lg-6 md-12',
                child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FxText.labelMedium(
                          "Assign Truck ${authController.queriedServiceProviders.length}"
                              .tr(),
                        ),
                        FxSpacing.height(8),
                        DropdownButtonFormField<Provider>(
                          dropdownColor: colorScheme.background,
                          menuMaxHeight: 200,
                          isDense: true,

                          // itemHeight: 40,
                          items: providerAdminController.queriedServiceProviders
                              .map(
                                (provider) => DropdownMenuItem<Provider>(
                                  value: provider,
                                  child: FxText.labelMedium(
                                    provider.provider.firstName!.capitalize,
                                  ),
                                ),
                              )
                              .toList(),
                          icon: Icon(
                            Icons.expand_more,
                            size: 20,
                          ),
                          decoration: InputDecoration(
                            hintText: "Select transport",
                            hintStyle: FxTextStyle.bodySmall(xMuted: true),
                            border: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                            focusedBorder: focusedInputBorder,
                            contentPadding: FxSpacing.all(14),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                          onChanged: (value) =>
                              authController.onSelectedProvider(value!),
                        )
                      ],
                    ))),
          ]),
          FxSpacing.height(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FxButton.outlined(
                onPressed: () {
                  orderDetailController.respondToGradingOrder('accepted');
                },
                elevation: 0,
                padding: FxSpacing.xy(20, 16),
                borderColor: contentTheme.primary,
                splashColor: contentTheme.primary.withOpacity(0.1),
                borderRadiusAll: AppStyle.buttonRadius.medium,
                child: FxText.bodySmall(
                  'Continue',
                  color: contentTheme.primary,
                ),
              ),
              FxSpacing.width(16),
              FxButton(
                onPressed: () {
                  orderDetailController.respondToGradingOrder('rejected');
                },
                elevation: 0,
                padding: FxSpacing.xy(20, 16),
                backgroundColor: Colors.red,
                borderRadiusAll: AppStyle.buttonRadius.medium,
                child: FxText.bodySmall(
                  'Cancel',
                  color: contentTheme.onPrimary,
                ),
              ),
            ],
          ),
          FxSpacing.height(25),
        ],
      ),
    );
  }

  gradeCommodity() {
    return Padding(
      padding: FxSpacing.all(flexSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FxText.labelLarge("order_pickup_date".tr().capitalizeWords),
          FxSpacing.height(12),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              FxButton.outlined(
                onPressed: () {
                  basicFormsController.pickDateTime();
                },
                borderColor: colorScheme.primary,
                padding: FxSpacing.xy(16, 16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.event_available_outlined,
                      color: colorScheme.primary,
                      size: 16,
                    ),
                    FxSpacing.width(10),
                    FxText.labelMedium(
                        basicFormsController.selectedDateTime != null
                            ? "${dateFormatter.format(basicFormsController.selectedDateTime!)} ${timeFormatter.format(basicFormsController.selectedDateTime!)}"
                            : "select_date_&_time".tr().capitalizeWords,
                        fontWeight: 600,
                        color: colorScheme.primary),
                  ],
                ),
              ),
            ],
          ),
          FxSpacing.height(25),
          FxFlex(contentPadding: false, children: [
            FxFlexItem(
                sizes: 'lg-6 md-12',
                child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FxText.labelMedium(
                          "Select Transporter ${authController.queriedServiceProviders.length}"
                              .tr(),
                        ),
                        FxSpacing.height(8),
                        DropdownButtonFormField<Provider>(
                          dropdownColor: colorScheme.background,
                          menuMaxHeight: 200,
                          isDense: true,

                          // itemHeight: 40,
                          items: authController.queriedServiceProviders
                              .map(
                                (provider) => DropdownMenuItem<Provider>(
                                  value: provider,
                                  child: FxText.labelMedium(
                                    provider.provider.firstName!.capitalize,
                                  ),
                                ),
                              )
                              .toList(),
                          icon: Icon(
                            Icons.expand_more,
                            size: 20,
                          ),
                          decoration: InputDecoration(
                            hintText: "Select transport",
                            hintStyle: FxTextStyle.bodySmall(xMuted: true),
                            border: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                            focusedBorder: focusedInputBorder,
                            contentPadding: FxSpacing.all(14),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                          onChanged: (value) =>
                              authController.onSelectedProvider(value!),
                        )
                      ],
                    ))),
          ]),
          FxSpacing.height(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FxButton.outlined(
                onPressed: () {
                  orderDetailController.respondToGradingOrder('accepted');
                },
                elevation: 0,
                padding: FxSpacing.xy(20, 16),
                borderColor: contentTheme.primary,
                splashColor: contentTheme.primary.withOpacity(0.1),
                borderRadiusAll: AppStyle.buttonRadius.medium,
                child: FxText.bodySmall(
                  'Continue',
                  color: contentTheme.primary,
                ),
              ),
              FxSpacing.width(16),
              FxButton(
                onPressed: () {
                  orderDetailController.respondToGradingOrder('rejected');
                },
                elevation: 0,
                padding: FxSpacing.xy(20, 16),
                backgroundColor: Colors.red,
                borderRadiusAll: AppStyle.buttonRadius.medium,
                child: FxText.bodySmall(
                  'Cancel',
                  color: contentTheme.onPrimary,
                ),
              ),
            ],
          ),
          FxSpacing.height(25),
        ],
      ),
    );
  }
}
