import 'package:feather_icons/feather_icons.dart';
import 'package:core_erp/controllers/pages/profile_controller.dart';
import 'package:core_erp/images.dart';
import 'package:core_erp/services/theme/app_style.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:core_erp/utils/utils.dart';
import 'package:core_erp/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin, UIMixin {
  late ProfileController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ProfileController(this));
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
                      "Profile",
                      fontWeight: 600,
                    ),
                    FxBreadcrumb(
                      children: [
                        FxBreadcrumbItem(name: "UI"),
                        FxBreadcrumbItem(name: "Profile", active: true),
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
                        children: [
                          FxContainer.bordered(
                            paddingAll: 20,
                            child: Column(
                              children: [
                                FxContainer.rounded(
                                  height: 80,
                                  width: 80,
                                  paddingAll: 0,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Image.asset(
                                    Images.avatars[0],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // FxSpacing.height(16),
                                FxText.titleSmall(
                                  "Den Doe",
                                  fontWeight: 700,
                                  fontSize: 16,
                                  muted: true,
                                ),
                                FxText.titleSmall(
                                  "Founder",
                                  fontSize: 12,
                                  muted: true,
                                ),
                                FxSpacing.height(8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FxButton(
                                      onPressed: () {},
                                      elevation: 0,
                                      padding: FxSpacing.xy(20, 16),
                                      backgroundColor: contentTheme.success,
                                      borderRadiusAll:
                                          AppStyle.buttonRadius.medium,
                                      child: FxText.bodySmall(
                                        'Follow',
                                        color: contentTheme.onSuccess,
                                      ),
                                    ),
                                    FxSpacing.width(flexSpacing / 3),
                                    FxButton(
                                      onPressed: () {},
                                      elevation: 0,
                                      padding: FxSpacing.xy(20, 16),
                                      backgroundColor: contentTheme.primary,
                                      borderRadiusAll:
                                          AppStyle.buttonRadius.medium,
                                      child: FxText.bodySmall(
                                        'Message',
                                        color: contentTheme.onPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                                FxSpacing.height(16),
                                Row(
                                  children: [
                                    FxText.titleSmall(
                                      "ABOUT ME:",
                                      fontWeight: 700,
                                      muted: true,
                                    )
                                  ],
                                ),
                                FxSpacing.height(8),
                                FxText.titleSmall(
                                  controller.dummyTexts[0],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  muted: true,
                                ),
                                FxSpacing.height(8),
                                buildProfileDetail(
                                    "Full Name :", "Denish Navadiya"),
                                FxSpacing.height(8),
                                buildProfileDetail(
                                    "Mobile :", "(123) 123 1234"),
                                FxSpacing.height(8),
                                buildProfileDetail("Email :", "demo@abc.com"),
                                FxSpacing.height(8),
                                buildProfileDetail("Location :", "INDIA")
                              ],
                            ),
                          ),
                          FxSpacing.height(20),
                          FxContainer.bordered(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FxText.titleSmall(
                                      "Message",
                                      fontWeight: 700,
                                      muted: true,
                                    ),
                                    PopupMenuButton(
                                      elevation: 2,
                                      itemBuilder: (BuildContext context) => [
                                        PopupMenuItem(
                                          padding: FxSpacing.all(8),
                                          height: 10,
                                          child: FxText.bodySmall(
                                            "Setting",
                                          ),
                                        ),
                                        PopupMenuItem(
                                          padding: FxSpacing.all(8),
                                          height: 10,
                                          child: FxText.bodySmall(
                                            "Action",
                                          ),
                                        ),
                                      ],
                                      iconSize: 16,
                                    )
                                  ],
                                ),
                                ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: controller.chats.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        FxContainer.rounded(
                                          height: 40,
                                          width: 40,
                                          paddingAll: 0,
                                          child: Image.asset(
                                            Images.avatars[
                                                index % Images.avatars.length],
                                            height: 40,
                                            width: 40,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        FxSpacing.width(16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: FxText.bodyMedium(
                                                      "${controller.chats[index].firstName}",
                                                    ),
                                                  ),
                                                  FxButton.text(
                                                    borderRadiusAll: 0,
                                                    padding: FxSpacing.xy(0, 0),
                                                    onPressed: () {},
                                                    child: FxText.bodySmall(
                                                      'Reply',
                                                      color:
                                                          contentTheme.primary,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              FxText.bodySmall(
                                                "${controller.chats[index].message}",
                                                muted: true,
                                                fontWeight: 400,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return Divider();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
                                FxText.titleMedium(
                                  "Orders & Revenue",
                                  fontWeight: 700,
                                  muted: true,
                                ),
                                FxSpacing.height(16),
                                SizedBox(
                                  height: 334,
                                  child: SfCartesianChart(
                                    primaryXAxis: NumericAxis(
                                      majorGridLines: MajorGridLines(width: 0),
                                      axisLine: AxisLine(width: 0),
                                    ),
                                    primaryYAxis: NumericAxis(
                                      majorGridLines: MajorGridLines(width: 0),
                                      axisLine: AxisLine(width: 0),
                                    ),
                                    tooltipBehavior: controller.tooltipBehavior,
                                    series: <ChartSeries<ChartData, double>>[
                                      ColumnSeries<ChartData, double>(
                                        width: 0.6,
                                        dataSource: controller.chartData,
                                        xValueMapper: (ChartData data, _) =>
                                            data.x,
                                        yValueMapper: (ChartData data, _) =>
                                            data.y,
                                      ),
                                      ColumnSeries<ChartData, double>(
                                        width: 0.6,
                                        dataSource: controller.chartData,
                                        xValueMapper: (ChartData data, _) =>
                                            data.x,
                                        yValueMapper: (ChartData data, _) =>
                                            data.y1,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          FxSpacing.height(20),
                          FxContainer.bordered(
                            paddingAll: 20,
                            child: Column(
                              children: [
                                TabBar(
                                  indicatorPadding: FxSpacing.y(4),
                                  isScrollable: false,
                                  controller: controller.fullWidthTabController,
                                  indicator: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color:
                                          contentTheme.primary.withAlpha(40)),
                                  tabs: [
                                    Tab(
                                      icon: FxText.labelMedium(
                                        "About",
                                        fontWeight:
                                            controller.fullWidthIndex == 0
                                                ? 600
                                                : 500,
                                        color: controller.fullWidthIndex == 0
                                            ? contentTheme.primary
                                            : null,
                                      ),
                                    ),
                                    Tab(
                                      icon: FxText.labelMedium(
                                        "Timeline",
                                        fontWeight:
                                            controller.fullWidthIndex == 1
                                                ? 600
                                                : 500,
                                        color: controller.fullWidthIndex == 1
                                            ? contentTheme.primary
                                            : null,
                                      ),
                                    ),
                                    Tab(
                                      icon: FxText.labelMedium(
                                        "Settings",
                                        fontWeight:
                                            controller.fullWidthIndex == 2
                                                ? 600
                                                : 500,
                                        color: controller.fullWidthIndex == 2
                                            ? contentTheme.primary
                                            : null,
                                      ),
                                    ),
                                  ],
                                  indicatorSize: TabBarIndicatorSize.tab,
                                ),
                                FxSpacing.height(flexSpacing),
                                SizedBox(
                                  height: 1000,
                                  child: TabBarView(
                                    controller:
                                        controller.fullWidthTabController,
                                    children: [
                                      tabAbout(),
                                      tabTimeLine(),
                                      tabSettings(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
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

  Widget tabAbout() {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.business_center_outlined,
              size: 16,
            ),
            FxSpacing.width(8),
            FxText.titleMedium(
              "PROJECT",
              muted: true,
              fontSize: 16,
              fontWeight: 700,
            )
          ],
        ),
        FxSpacing.height(26),
        FxContainer.none(
          borderRadiusAll: 4,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: DataTable(
            sortColumnIndex: 1,
            sortAscending: true,
            onSelectAll: (_) => {},
            headingRowColor:
                MaterialStatePropertyAll(contentTheme.primary.withAlpha(40)),
            dataRowMaxHeight: 60,
            showBottomBorder: true,
            columns: [
              DataColumn(
                label: FxText.labelLarge(
                  "Id",
                  color: contentTheme.primary,
                ),
              ),
              DataColumn(
                label: FxText.labelLarge(
                  "Client",
                  color: contentTheme.primary,
                ),
              ),
              DataColumn(
                label: FxText.labelLarge(
                  "Project's",
                  color: contentTheme.primary,
                ),
              ),
              DataColumn(
                label: FxText.labelLarge(
                  "Start Date",
                  color: contentTheme.primary,
                ),
              ),
              DataColumn(
                label: FxText.labelLarge(
                  "Due Date",
                  color: contentTheme.primary,
                ),
              ),
              DataColumn(
                label: FxText.labelLarge(
                  "Status",
                  color: contentTheme.primary,
                ),
              ),
            ],
            rows: controller.chats
                .mapIndexed(
                  (index, data) => DataRow(
                    cells: [
                      DataCell(
                        FxText.bodyMedium(
                          "#${controller.customers[index].id}",
                        ),
                      ),
                      DataCell(
                        Row(
                          children: [
                            FxContainer.rounded(
                              height: 40,
                              width: 40,
                              paddingAll: 0,
                              child: Image.asset(
                                Images.avatars[index % Images.avatars.length],
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                            FxSpacing.width(8),
                            FxText.labelLarge(
                              "${controller.chats[index].firstName}",
                            ),
                          ],
                        ),
                      ),
                      DataCell(
                        FxText.labelLarge(
                          "${controller.customers[index].projectName}",
                        ),
                      ),
                      DataCell(FxText.bodySmall(
                        '${Utils.getDateStringFromDateTime(
                          controller.chats[index].sendAt,
                          showMonthShort: false,
                        )}',
                        muted: true,
                        fontWeight: 600,
                      )),
                      DataCell(FxText.bodySmall(
                        '${Utils.getDateStringFromDateTime(
                          controller.chats[index].sendAt,
                          showMonthShort: false,
                        )}',
                        muted: true,
                        fontWeight: 600,
                      )),
                      DataCell(FxText.bodySmall(
                        '${Utils.getTimeStringFromDateTime(
                          controller.customers[index].lastOrder,
                          showSecond: false,
                        )}',
                        muted: true,
                        fontWeight: 600,
                      )),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
        FxSpacing.height(26),
        Row(
          children: [
            Icon(
              Icons.monitor_outlined,
              size: 16,
            ),
            FxSpacing.width(8),
            FxText.titleMedium(
              "EXPERIENCE",
              muted: true,
              fontSize: 16,
              fontWeight: 700,
            )
          ],
        ),
        FxSpacing.height(26),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.radio_button_checked_rounded,
              color: contentTheme.primary,
              size: 22,
            ),
            FxSpacing.width(8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FxText.titleSmall(
                  "Lead designer / Developer",
                ),
                FxText.titleSmall(
                  "website.com Year: 2015 - 18",
                  muted: true,
                  fontSize: 10,
                ),
              ],
            ),
          ],
        ),
        FxSpacing.height(4),
        Padding(
          padding: FxSpacing.x(30),
          child: FxText.bodySmall(
            controller.dummyTexts[0],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            muted: true,
          ),
        ),
        FxSpacing.height(24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.radio_button_checked_rounded,
              color: contentTheme.primary,
              size: 22,
            ),
            FxSpacing.width(8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FxText.titleSmall(
                  "Senior Graphic Designer",
                ),
                FxText.titleSmall(
                  "Software Inc. Year: 2012 - 15",
                  muted: true,
                  fontSize: 10,
                ),
              ],
            ),
          ],
        ),
        FxSpacing.height(4),
        Padding(
          padding: FxSpacing.x(30),
          child: FxText.bodySmall(
            controller.dummyTexts[0],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            muted: true,
          ),
        ),
        FxSpacing.height(24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.radio_button_checked_rounded,
              color: contentTheme.primary,
              size: 22,
            ),
            FxSpacing.width(8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FxText.titleSmall(
                  "Graphic Designer",
                ),
                FxText.titleSmall(
                  "Coderthemes Design LLP Year: 2010 - 12",
                  muted: true,
                  fontSize: 10,
                ),
              ],
            ),
          ],
        ),
        FxSpacing.height(4),
        Padding(
          padding: FxSpacing.x(30),
          child: FxText.bodySmall(
            controller.dummyTexts[0],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            muted: true,
          ),
        ),
      ],
    );
  }

  Widget tabTimeLine() {
    return Column(
      children: [
        FxContainer.bordered(
          paddingAll: 0,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(style: BorderStyle.none),
                  ),
                  hintText: "Write somethings...",
                  hintStyle: FxTextStyle.bodySmall(xMuted: true),
                  contentPadding: FxSpacing.all(16),
                  isCollapsed: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
              ),
              FxContainer.none(
                color: colorScheme.primary.withOpacity(0.08),
                padding: FxSpacing.xy(16, 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.portrait_outlined,
                              color: contentTheme.primary,
                              size: 16,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.location_on_outlined,
                              color: contentTheme.primary,
                              size: 16,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.camera_alt_outlined,
                              color: contentTheme.primary,
                              size: 16,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.sentiment_very_satisfied_outlined,
                              color: contentTheme.primary,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FxButton(
                      onPressed: () {},
                      elevation: 0,
                      padding: FxSpacing.xy(16, 12),
                      backgroundColor: contentTheme.primary,
                      borderRadiusAll: AppStyle.buttonRadius.medium,
                      child: FxText.bodySmall(
                        'Post',
                        color: contentTheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        FxSpacing.height(flexSpacing),
        FxContainer.bordered(
          paddingAll: 0,
          child: Column(
            children: [
              FxContainer.none(
                padding: FxSpacing.xy(flexSpacing, 12),
                color: colorScheme.primary.withOpacity(0.08),
                child: Row(
                  children: [
                    FxContainer.rounded(
                      height: 36,
                      width: 36,
                      paddingAll: 0,
                      child: Image.asset(
                        Images.avatars[0],
                        fit: BoxFit.cover,
                      ),
                    ),
                    FxSpacing.width(12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FxText.titleMedium(
                          "Denish Navadiya",
                          fontWeight: 700,
                          fontSize: 12,
                        ),
                        FxText.titleMedium(
                          "${Utils.getTimeStringFromDateTime(
                            DateTime.now(),
                            showSecond: false,
                          )} Minutes Ago",
                          fontWeight: 700,
                          fontSize: 10,
                          muted: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              FxContainer(
                alignment: Alignment.center,
                child: FxText.bodySmall(
                  controller.dummyTexts[0],
                  maxLines: 2,
                  style: TextStyle(fontStyle: FontStyle.italic),
                  overflow: TextOverflow.ellipsis,
                  fontSize: 20,
                  muted: true,
                ),
              ),
              FxContainer(
                padding: FxSpacing.xy(36, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FxContainer.rounded(
                      height: 36,
                      width: 36,
                      paddingAll: 0,
                      child: Image.asset(
                        Images.avatars[0],
                        fit: BoxFit.cover,
                      ),
                    ),
                    FxSpacing.width(16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            FxText.bodyMedium(
                              "Kevina Levered ",
                              fontWeight: 600,
                            ),
                            FxText.bodySmall(
                              "about 2 minutes ago",
                              fontSize: 10,
                              muted: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        FxText.bodyMedium(
                          "Nice work, makes me think of The Money Pit.",
                          fontWeight: 600,
                          fontSize: 12,
                          muted: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        FxSpacing.height(16),
                        Row(
                          children: [
                            Icon(
                              Icons.reply_outlined,
                              size: 16,
                            ),
                            FxSpacing.width(8),
                            FxText.bodySmall(
                              "Reply",
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget tabSettings() {
    return Column(
      children: [
        FxContainer.none(
          color: colorScheme.primary.withOpacity(0.08),
          padding: FxSpacing.xy(16, 8),
          child: Row(
            children: [
              Icon(
                Icons.portrait_outlined,
                color: contentTheme.primary,
                size: 16,
              ),
              FxSpacing.width(12),
              FxText.titleMedium(
                "PERSONAL INFO",
                fontWeight: 600,
                color: colorScheme.primary,
              ),
            ],
          ),
        ),
        FxSpacing.height(24),
        FxFlex(
          children: [
            FxFlexItem(
              sizes: "md-6 sm-12",
              child: buildTextField('First Name', "Denish"),
            ),
            FxFlexItem(
              sizes: "md-6 sm-12",
              child: buildTextField(
                "Last Name",
                "Navadiya",
              ),
            ),
          ],
        ),
        Padding(
          padding: FxSpacing.xy(12, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FxText.bodyMedium(
                "Bio",
                fontWeight: 600,
                muted: true,
              ),
              FxSpacing.height(8),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Write somethings...",
                  hintStyle: FxTextStyle.bodySmall(xMuted: true),
                  border: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  focusedBorder: focusedInputBorder,
                  contentPadding: FxSpacing.all(16),
                  isCollapsed: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
              ),
            ],
          ),
        ),
        FxFlex(
          children: [
            FxFlexItem(
              sizes: "md-6 sm-12",
              child: buildTextField(
                "Email Address",
                "demo@abc.com",
              ),
            ),
            FxFlexItem(
              sizes: "md-6 sm-12",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FxText.labelMedium(
                    'Password',
                  ),
                  FxSpacing.height(8),
                  TextFormField(
                    obscureText: controller.showPassword,
                    decoration: InputDecoration(
                      hintText: "********",
                      hintStyle: FxTextStyle.bodySmall(xMuted: true),
                      border: outlineInputBorder,
                      contentPadding: FxSpacing.all(16),
                      isCollapsed: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      suffixIcon: InkWell(
                        onTap: controller.onChangeShowPassword,
                        child: Icon(
                          controller.showPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        FxSpacing.height(24),
        FxContainer.none(
          color: colorScheme.primary.withOpacity(0.08),
          padding: FxSpacing.xy(16, 8),
          child: Row(
            children: [
              Icon(
                Icons.domain_outlined,
                color: contentTheme.primary,
                size: 16,
              ),
              FxSpacing.width(12),
              FxText.titleMedium(
                "COMPANY INFO",
                fontWeight: 600,
                color: colorScheme.primary,
              ),
            ],
          ),
        ),
        FxSpacing.height(24),
        FxFlex(
          children: [
            FxFlexItem(
              sizes: "md-6 sm-12",
              child: buildTextField('Company Name', "GetAppUi"),
            ),
            FxFlexItem(
              sizes: "md-6 sm-12",
              child: buildTextField(
                "Website",
                "WWW.example.com",
              ),
            ),
          ],
        ),
        FxSpacing.height(24),
        FxContainer.none(
          color: colorScheme.primary.withOpacity(0.08),
          padding: FxSpacing.xy(16, 8),
          child: Row(
            children: [
              Icon(
                FeatherIcons.globe,
                color: contentTheme.primary,
                size: 16,
              ),
              FxSpacing.width(12),
              FxText.titleMedium(
                "SOCIAL",
                fontWeight: 600,
                color: colorScheme.primary,
              ),
            ],
          ),
        ),
        FxSpacing.height(24),
        FxFlex(
          children: [
            FxFlexItem(
              sizes: "md-6 sm-12",
              child: buildSocialTextField(
                "Facebook",
                'facebook.com/username',
                Icons.facebook_outlined,
              ),
            ),
            FxFlexItem(
              sizes: "md-6 sm-12",
              child: buildSocialTextField(
                "Twitter",
                'twitter.com/username',
                FeatherIcons.twitter,
              ),
            ),
          ],
        ),
        FxSpacing.height(24),
        FxFlex(
          children: [
            FxFlexItem(
              sizes: "md-6 sm-12",
              child: buildSocialTextField(
                "Instagram",
                'instagram.com/username',
                FeatherIcons.instagram,
              ),
            ),
            FxFlexItem(
              sizes: "md-6 sm-12",
              child: buildSocialTextField(
                "LinkedIn",
                'linkedIn.com/username',
                FeatherIcons.linkedin,
              ),
            ),
          ],
        ),
        FxSpacing.height(24),
        FxFlex(
          children: [
            FxFlexItem(
              sizes: "md-6 sm-12",
              child: buildSocialTextField(
                "Duo",
                'duo',
                Icons.duo_outlined,
              ),
            ),
            FxFlexItem(
              sizes: "md-6 sm-12",
              child: buildSocialTextField(
                "GitHub",
                'github.com/username',
                FeatherIcons.github,
              ),
            ),
          ],
        ),
        FxSpacing.height(24),
        Padding(
          padding: FxSpacing.x(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FxButton(
                onPressed: () {},
                elevation: 0,
                padding: FxSpacing.xy(20, 16),
                backgroundColor: contentTheme.primary,
                borderRadiusAll: AppStyle.buttonRadius.medium,
                child: Row(
                  children: [
                    Icon(
                      FeatherIcons.save,
                      size: 18,
                    ),
                    FxSpacing.width(8),
                    FxText.bodySmall(
                      'Save',
                      color: contentTheme.onPrimary,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
