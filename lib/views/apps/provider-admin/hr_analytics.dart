import 'package:core_erp/controllers/apps/provider-admin/provider-admin_controller.dart';
import 'package:core_erp/controllers/apps/provider-admin/job_discover_controller.dart';
import 'package:core_erp/extensions/extensions.dart';
import 'package:core_erp/images.dart';
import 'package:core_erp/models/employee.dart';
import 'package:core_erp/models/locations.dart';
import 'package:core_erp/models/person.dart';
import 'package:core_erp/services/theme/app_style.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:core_erp/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HRAnalytics extends StatefulWidget {
  const HRAnalytics({Key? key}) : super(key: key);

  @override
  State<HRAnalytics> createState() => _HRAnalyticsState();
}

class _HRAnalyticsState extends State<HRAnalytics>
    with SingleTickerProviderStateMixin, UIMixin {
  late DiscoverController controller;
  late ProviderAdminController providerAdminController;

  @override
  void initState() {
    super.initState();
    controller = Get.put(DiscoverController());
    providerAdminController = Get.put(ProviderAdminController());
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
                    //   "Discover",
                    //   fontWeight: 600,
                    //   fontSize: 18,
                    // ),
                    FxBreadcrumb(
                      children: [
                        FxBreadcrumbItem(
                            name: "human_resources_department".tr()),
                        FxBreadcrumbItem(name: "analytics".tr(), active: true),
                      ],
                    ),
                  ],
                ),
              ),
              FxSpacing.height(flexSpacing),
              Padding(
                padding: FxSpacing.x(flexSpacing),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FxFlex(
                      contentPadding: false,
                      children: [
                        FxFlexItem(
                          sizes: "lg-4",
                          child: buildLeftBarMatchingJob(),
                        ),
                        FxFlexItem(
                          sizes: "lg-8",
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FxText.titleMedium(
                                "Best Performing Agents",
                                fontWeight: 600,
                              ),
                              FxSpacing.height(8),
                              buildFeatureJobs(),

                              FxSpacing.height(36),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FxText.titleMedium(
                                    "Recently Recruited",
                                    fontWeight: 600,
                                  ),
                                  FxButton.text(
                                    onPressed: () {},
                                    padding: FxSpacing.xy(8, 8),
                                    splashColor:
                                        contentTheme.secondary.withOpacity(0.1),
                                    child: FxText.titleMedium(
                                      'See All',
                                      color: contentTheme.secondary,
                                    ),
                                  ),
                                ],
                              ),
                              // FxSpacing.height(8),
                              buildDiscoveryJobs(),

                              FxSpacing.height(36),
                              FxFlex(
                                contentPadding: false,
                                children: [
                                  FxFlexItem(
                                    sizes: "lg-12",
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: FxText.titleMedium(
                                                "Perfomance ",
                                                fontWeight: 600,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                FxText.titleSmall("Sort by :"),
                                                FxSpacing.width(8),
                                                PopupMenuButton(
                                                  itemBuilder:
                                                      (BuildContext context) {
                                                    return [
                                                      "Year",
                                                      "Month",
                                                      "Day",
                                                      "Hours"
                                                    ].map((behavior) {
                                                      return PopupMenuItem(
                                                        value: behavior,
                                                        height: 32,
                                                        child: FxText.bodySmall(
                                                          behavior.toString(),
                                                          color: theme
                                                              .colorScheme
                                                              .onBackground,
                                                          fontWeight: 600,
                                                        ),
                                                      );
                                                    }).toList();
                                                  },
                                                  onSelected:
                                                      controller.onSelectedTime,
                                                  color: theme.cardTheme.color,
                                                  child: Row(
                                                    children: <Widget>[
                                                      FxText.labelMedium(
                                                        controller.selectTime
                                                            .toString(),
                                                        color: theme.colorScheme
                                                            .onBackground,
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 4),
                                                        child: Icon(
                                                          Icons
                                                              .expand_more_outlined,
                                                          size: 22,
                                                          color: theme
                                                              .colorScheme
                                                              .onBackground,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                FxSpacing.width(8),
                                                Center(
                                                  child: IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      Icons.download_outlined,
                                                      // color:
                                                      //     contentTheme.primary,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        SfCartesianChart(
                                          primaryXAxis: CategoryAxis(
                                            majorGridLines:
                                                MajorGridLines(width: 0),
                                            axisLine: AxisLine(width: 0),
                                          ),
                                          primaryYAxis: CategoryAxis(
                                            majorGridLines:
                                                MajorGridLines(width: 0),
                                            axisLine: AxisLine(width: 0),
                                          ),
                                          tooltipBehavior:
                                              controller.tooltipBehavior,
                                          series: <ChartSeries>[
                                            SplineSeries<ChartData, String>(
                                              dataSource: controller.chartData,
                                              xValueMapper:
                                                  (ChartData data, _) => data.x,
                                              yValueMapper:
                                                  (ChartData data, _) => data.y,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
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

  Widget buildChip(String chipName) {
    return RawChip(
      label: FxText.bodyMedium(
        chipName,
      ),
      backgroundColor: contentTheme.primary.withAlpha(20),
      deleteIcon: Icon(Icons.add),
    );
  }

  Widget buildCardPills(String pillContent) {
    return FxContainer.none(
      borderRadiusAll: 16,
      padding: FxSpacing.xy(12, 4),
      color: contentTheme.light.withAlpha(180),
      child: Center(
        child: FxText.titleMedium(
          pillContent,
          fontSize: 14,
          fontWeight: 600,
          color: contentTheme.primary,
        ),
      ),
    );
  }

  Widget buildLeftBarMatchingJob() {
    return FxContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FxButton(
                onPressed: () {
                  providerAdminController.goToAssignTask();
                },
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
                      'assign_task'.tr().capitalizeWords,
                      color: contentTheme.onPrimary,
                    ),
                  ],
                ),
              ),
              FxButton(
                onPressed: () {
                  providerAdminController.goToCreateEmployee();
                },
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
                      'add_new_employee'.tr().capitalizeWords,
                      color: contentTheme.onPrimary,
                    ),
                  ],
                ),
              )
            ],
          ),
          FxSpacing.height(20),
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: contentTheme.primary.withOpacity(0.08),
              prefixIcon: Icon(
                Icons.search,
                size: 18,
                color: contentTheme.primary,
              ),
              isDense: true,
              hintText: "Search For Employee",
              hintStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
              contentPadding: FxSpacing.horizontal(20),
            ),
          ),
          FxSpacing.height(12),
          FxText.labelLarge(
            "Job Types",
            muted: true,
          ),
          FxSpacing.height(8),
          Wrap(
            children: [
              FxButton(
                onPressed: () {
                  setState(() {
                    controller.onSelected;
                  });
                },
                elevation: 0,
                padding: FxSpacing.xy(20, 16),
                borderColor: contentTheme.primary,
                backgroundColor: controller.selected == true
                    ? contentTheme.onPrimary
                    : contentTheme.primary,
                splashColor: contentTheme.primary.withOpacity(0.2),
                borderRadiusAll: 20,
                child: FxText.bodySmall('Full-Time', color: contentTheme.light),
              ),
              FxSpacing.width(8),
              FxButton(
                onPressed: () {
                  setState(() {
                    controller.isPartTime = !controller.isPartTime;
                  });
                },
                elevation: 0,
                padding: FxSpacing.xy(20, 16),
                borderColor: contentTheme.primary,
                backgroundColor: controller.isPartTime
                    ? contentTheme.info.withOpacity(0.12)
                    : contentTheme.secondary.withAlpha(10),
                splashColor: contentTheme.primary.withOpacity(0.2),
                borderRadiusAll: 20,
                child: FxText.bodySmall(
                  'Part-Time',
                  color: controller.isPartTime
                      ? contentTheme.info
                      : contentTheme.secondary,
                ),
              ),
              FxSpacing.width(8),
              FxButton(
                onPressed: () {
                  setState(() {
                    controller.isMobile = !controller.isMobile;
                  });
                },
                elevation: 0,
                padding: FxSpacing.xy(20, 16),
                borderColor: contentTheme.primary,
                backgroundColor: controller.isMobile
                    ? contentTheme.info.withOpacity(0.12)
                    : contentTheme.secondary.withAlpha(10),
                splashColor: contentTheme.primary.withOpacity(0.2),
                borderRadiusAll: 20,
                child: FxText.bodySmall(
                  'Mobile',
                  color: controller.isMobile
                      ? contentTheme.info
                      : contentTheme.secondary,
                ),
              ),
              FxSpacing.width(8),
              FxButton(
                onPressed: () {
                  setState(() {
                    controller.isContract = !controller.isContract;
                  });
                },
                elevation: 0,
                padding: FxSpacing.xy(20, 16),
                borderColor: contentTheme.primary,
                backgroundColor: controller.isContract
                    ? contentTheme.info.withOpacity(0.12)
                    : contentTheme.secondary.withAlpha(10),
                splashColor: contentTheme.primary.withOpacity(0.2),
                borderRadiusAll: 20,
                child: FxText.bodySmall(
                  'Contract',
                  color: controller.isContract
                      ? contentTheme.info
                      : contentTheme.secondary,
                ),
              ),
            ],
          ),
          FxSpacing.height(20),
          FxText.labelLarge(
            "Select Experience",
            muted: true,
          ),
          FxSpacing.height(8),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return ["Beginner", "Intermediate", "Expert"].map((behavior) {
                return PopupMenuItem(
                  value: behavior,
                  height: 28,
                  child: FxText.bodySmall(
                    behavior.toString(),
                    color: theme.colorScheme.onBackground,
                    fontWeight: 600,
                  ),
                );
              }).toList();
            },
            onSelected: controller.onSelectedExperience,
            color: theme.cardTheme.color,
            child: FxContainer.bordered(
              padding: FxSpacing.xy(12, 8),
              child: Row(
                children: <Widget>[
                  FxText.labelMedium(
                    controller.selectExperience.toString(),
                    color: theme.colorScheme.onBackground,
                  ),
                ],
              ),
            ),
          ),
          FxSpacing.height(20),
          FxText.labelLarge(
            "Select Location",
            muted: true,
          ),
          FxSpacing.height(8),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return populatedCities.map((behavior) {
                return PopupMenuItem(
                  value: behavior,
                  height: 28,
                  child: FxText.bodySmall(
                    behavior.toString(),
                    color: theme.colorScheme.onBackground,
                    fontWeight: 600,
                  ),
                );
              }).toList();
            },
            onSelected: controller.onSelectedLocation,
            color: theme.cardTheme.color,
            child: FxContainer.bordered(
              padding: FxSpacing.xy(12, 8),
              child: Row(
                children: <Widget>[
                  FxText.labelMedium(
                    controller.selectLocation.toString(),
                    color: theme.colorScheme.onBackground,
                  ),
                ],
              ),
            ),
          ),
          FxSpacing.height(20),
          buildHotJobs()
        ],
      ),
    );
  }

  Widget buildDiscoveryJobs() {
    return SizedBox(
      height: 170,
      child: Obx(() => ListView.separated(
            itemCount: providerAdminController.employees.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              Employee employee = providerAdminController.employees[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FxContainer(
                    height: 170,
                    width: 180,
                    borderRadiusAll: 12,
                    child: Column(
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
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        '${providerAdminController.apiUrl}/users/avatars/${employee.profile!.profileImage}',
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Center(
                                            child: CircularProgressIndicator(
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
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 16,
              );
            },
          )),
    );
  }

  Widget buildFeatureJobs() {
    return SizedBox(
      height: 180,
      child: Obx(() => ListView.separated(
            shrinkWrap: true,
            itemCount: providerAdminController.employees.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              Employee employee = providerAdminController.employees[index];
              return Column(
                children: [
                  Container(
                    height: 180,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                          Colors.blueGrey,
                          contentTheme.primary,
                          contentTheme.primary.withAlpha(200),
                          Colors.blueGrey
                        ],
                        tileMode: TileMode.mirror,
                      ),
                    ),
                    child: Padding(
                      padding:
                          FxSpacing.xy(flexSpacing / 1.5, flexSpacing / 1.5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              FxContainer.none(
                                borderRadiusAll: 8,
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
                                              BorderRadius.horizontal(),
                                          child: Image.network(
                                            '${providerAdminController.apiUrl}/users/avatars/${employee.profile!.profileImage}',
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
                                      ),
                              ),
                              FxSpacing.width(16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FxText.titleMedium(
                                      '${employee.profile!.firstName!.capitalize}_${employee.profile!.lastName}'
                                          .tr(),
                                      fontWeight: 600,
                                      fontSize: 16,
                                      color: contentTheme.onPrimary,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    FxText.titleMedium(
                                      employee.profile!.onlineStatus == null ||
                                              employee.profile!.onlineStatus ==
                                                  false
                                          ? 'Offline'
                                          : 'Online',
                                      color: contentTheme.onPrimary,
                                      muted: true,
                                      fontSize: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildCardPills("${employee.jobRole}".tr()),
                              // buildCardPills("Full-Time"),
                              // buildCardPills("Junior"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // FxText.bodyMedium(
                              //   "\/Year",
                              //   color: contentTheme.onPrimary,
                              // ),
                              FxText.bodyMedium(
                                '${employee.profile!.city} ${employee.profile!.neighbourhood}'
                                    .tr(),
                                color: contentTheme.onPrimary,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 16,
              );
            },
          )),
    );
  }

  Widget buildHotJobs() {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FxText.titleMedium(
              "Sales Agents (${providerAdminController.employees.length})",
              fontWeight: 600,
            ),
            FxSpacing.height(16),
            SizedBox(
              height: 400,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: providerAdminController.employees.length,
                itemBuilder: (context, index) {
                  Employee employee = providerAdminController.employees[index];

                  return FxContainer.none(
                    borderRadiusAll: 16,
                    paddingAll: 16,
                    child: Row(
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
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(
                                      '${providerAdminController.apiUrl}/users/avatars/${employee.profile!.profileImage}',
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
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
                                ),
                        ),
                        FxSpacing.width(16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FxText.bodyMedium(
                                '${employee.profile!.firstName} ${employee.profile!.lastName}',
                                fontWeight: 600,
                              ),
                              FxSpacing.height(4),
                              FxText.bodyMedium(
                                '${employee.profile!.accountType} ${employee.profile!.accountType}',
                                fontSize: 12,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            FxText.bodyMedium(
                              "\$/y",
                              fontWeight: 600,
                            ),
                            FxSpacing.height(4),
                            FxText.bodyMedium(
                              '${employee.profile!.city}, ${employee.profile!.neighbourhood}',
                              fontSize: 12,
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 16,
                  );
                },
              ),
            )
          ],
        ));
  }
}
