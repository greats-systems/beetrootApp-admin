import 'package:core_erp/controllers/apps/files/file_manager_controller.dart';
import 'package:core_erp/images.dart';
import 'package:core_erp/services/theme/app_style.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:core_erp/utils/utils.dart';
import 'package:core_erp/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class FileManagerPage extends StatefulWidget {
  const FileManagerPage({Key? key}) : super(key: key);

  @override
  State<FileManagerPage> createState() => _FileManagerPageState();
}

class _FileManagerPageState extends State<FileManagerPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late FileManagerController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(
      FileManagerController(),
    );
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
                      "File Manager",
                      fontWeight: 600,
                    ),
                    FxBreadcrumb(
                      children: [
                        FxBreadcrumbItem(name: "Extra Pages"),
                        FxBreadcrumbItem(name: "File Manager", active: true),
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
                      sizes: "xxl-2 xl-3 lg-4  md-4 sm-12",
                      child: FxCard(
                        shadow: FxShadow(
                            elevation: 0.5, position: FxShadowPosition.bottom),
                        paddingAll: 0,
                        child: Padding(
                          padding: FxSpacing.all(flexSpacing),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FxButton(
                                onPressed: () {},
                                elevation: 0,
                                padding: FxSpacing.xy(20, 16),
                                backgroundColor: contentTheme.primary,
                                borderRadiusAll: AppStyle.buttonRadius.medium,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add),
                                    FxSpacing.width(8),
                                    FxText.bodySmall(
                                      'Create New',
                                      color: contentTheme.onPrimary,
                                    ),
                                  ],
                                ),
                              ),
                              FxSpacing.height(24),
                              buildCreateNew("My File", Icons.folder_outlined),
                              FxSpacing.height(16),
                              buildCreateNew(
                                  "Google Drive", Icons.add_to_drive),
                              FxSpacing.height(16),
                              buildCreateNew("Share With Me",
                                  Icons.folder_shared_outlined),
                              FxSpacing.height(16),
                              buildCreateNew(
                                  "Recent", Icons.access_time_outlined),
                              FxSpacing.height(16),
                              buildCreateNew("Starred", Icons.star_border),
                              FxSpacing.height(16),
                              buildCreateNew(
                                  "Delete File", Icons.auto_delete_outlined),
                              FxSpacing.height(40),
                              FxText.bodySmall(
                                "STORAGE",
                                fontWeight: 700,
                              ),
                              FxSpacing.height(14),
                              FxProgressBar(
                                  width: 200,
                                  progress: 0.5,
                                  height: 3,
                                  radius: 4,
                                  inactiveColor: theme.dividerColor,
                                  activeColor: colorScheme.primary),
                              FxSpacing.height(14),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '7.02 GB ',
                                      style: FxTextStyle.bodyMedium(
                                        fontWeight: 700,
                                      ),
                                    ),
                                    TextSpan(text: '(46%) of  '),
                                    TextSpan(
                                      text: '15 GB',
                                      style: FxTextStyle.bodyMedium(
                                        fontWeight: 700,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' used',
                                    ),
                                  ],
                                ),
                              ),
                              FxSpacing.height(20),
                              Center(
                                child: FxButton(
                                  onPressed: () {},
                                  elevation: 0,
                                  padding: FxSpacing.xy(20, 16),
                                  borderColor: contentTheme.primary,
                                  backgroundColor:
                                      contentTheme.primary.withAlpha(28),
                                  splashColor:
                                      contentTheme.primary.withAlpha(28),
                                  borderRadiusAll: 20,
                                  child: FxText.bodyMedium(
                                    'UPGRADE',
                                    color: contentTheme.primary,
                                    fontWeight: 600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    FxFlexItem(
                      sizes: "xxl-10 xl-9 lg-8 md-8 sm-12",
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FxCard(
                            shadow: FxShadow(
                                elevation: 0.5,
                                position: FxShadowPosition.bottom),
                            paddingAll: 22,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FxContainer.none(
                                      width: 250,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: contentTheme.primary
                                              .withOpacity(0.08),
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
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            borderSide: BorderSide.none,
                                          ),
                                          contentPadding:
                                              FxSpacing.horizontal(20),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        FxContainer.bordered(
                                          paddingAll: 5,
                                          child: Icon(
                                            Icons.list_outlined,
                                            size: 18,
                                          ),
                                        ),
                                        FxSpacing.width(6),
                                        FxContainer.bordered(
                                          paddingAll: 5,
                                          child: Icon(
                                            Icons.window_outlined,
                                            size: 18,
                                          ),
                                        ),
                                        FxSpacing.width(6),
                                        FxContainer.bordered(
                                          paddingAll: 5,
                                          child: Icon(
                                            Icons.error_outline,
                                            size: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                FxSpacing.height(16),
                                FxText.bodyMedium(
                                  "Quick Access",
                                  fontWeight: 600,
                                ),
                                FxSpacing.height(16),
                                Wrap(
                                  spacing: 16,
                                  runSpacing: 16,
                                  children: [
                                    buildFile(Icons.folder_outlined,
                                        "Flatten - Zip", 458631),
                                    buildFile(Icons.folder_zip_outlined,
                                        "Compile Version", 1458631),
                                    buildFile(Icons.folder_special_outlined,
                                        "My Admin", 4358631),
                                    buildFile(Icons.folder_shared_outlined,
                                        "Documentation.pdf", 4586531),
                                    buildFile(Icons.source_outlined,
                                        "License-details.pdf", 8456312),
                                    buildFile(Icons.folder_outlined,
                                        "Purchase Verification", 47856),
                                    buildFile(Icons.folder_zip_outlined,
                                        "Flatten Integrations", 125789),
                                  ],
                                ),
                                FxSpacing.height(18),
                                FxText.bodyMedium(
                                  "Recent",
                                  fontWeight: 600,
                                ),
                                FxSpacing.height(18),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: FxContainer.none(
                                    borderRadiusAll: 4,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: DataTable(
                                      sortAscending: true,
                                      onSelectAll: (_) => {},
                                      headingRowColor: MaterialStatePropertyAll(
                                          contentTheme.primary.withAlpha(40)),
                                      dataRowHeight: 60,
                                      showBottomBorder: false,
                                      columns: [
                                        DataColumn(
                                          label: FxText.labelLarge(
                                            "Name",
                                            color: contentTheme.primary,
                                          ),
                                        ),
                                        DataColumn(
                                          label: FxText.labelLarge(
                                            "Last Modified",
                                            color: contentTheme.primary,
                                          ),
                                        ),
                                        DataColumn(
                                          label: FxText.labelLarge(
                                            "Size",
                                            color: contentTheme.primary,
                                          ),
                                        ),
                                        DataColumn(
                                          label: FxText.labelLarge(
                                            "Owner",
                                            color: contentTheme.primary,
                                          ),
                                        ),
                                        DataColumn(
                                          label: FxText.labelLarge(
                                            "Members",
                                            color: contentTheme.primary,
                                          ),
                                        ),
                                        DataColumn(
                                          label: FxText.labelLarge(
                                            "Action",
                                            color: contentTheme.primary,
                                          ),
                                        ),
                                      ],
                                      rows: [
                                        buildDataRows(
                                          "Flutter Design Files",
                                          DateTime.utc(2023, 1, 25),
                                          "Andrew",
                                          134217728,
                                          "Danielle Thompson",
                                          Icons.folder_outlined,
                                          [
                                            Images.avatars[0],
                                            Images.avatars[1],
                                            Images.avatars[2],
                                            Images.avatars[3],
                                          ],
                                        ),
                                        buildDataRows(
                                          "Sketch File",
                                          DateTime.utc(2020, 2, 13),
                                          "Getappui",
                                          546308096,
                                          "Coder Themes",
                                          Icons.insert_drive_file_outlined,
                                          [
                                            Images.avatars[0],
                                            Images.avatars[2],
                                            Images.avatars[3],
                                          ],
                                        ),
                                        buildDataRows(
                                          "Flatten Requirement.pdf",
                                          DateTime.utc(2020, 2, 13),
                                          "Alejandro",
                                          7549747,
                                          "Gary Coley",
                                          Icons.text_snippet_outlined,
                                          [
                                            Images.avatars[5],
                                            Images.avatars[4],
                                            Images.avatars[1],
                                          ],
                                        ),
                                        buildDataRows(
                                          "Wireframes",
                                          DateTime.utc(2023, 1, 25),
                                          "Dunkle",
                                          56832819,
                                          "Jasper Rigg",
                                          Icons.folder_outlined,
                                          [
                                            Images.avatars[0],
                                            Images.avatars[1],
                                            Images.avatars[2],
                                            Images.avatars[3],
                                          ],
                                        ),
                                        buildDataRows(
                                          "Documentation.docs",
                                          DateTime.utc(2020, 2, 13),
                                          "Justin",
                                          8703180,
                                          "Cooper Sharwood",
                                          Icons.text_snippet_outlined,
                                          [
                                            Images.avatars[4],
                                            Images.avatars[1],
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
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

  buildCreateNew(String fileName, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 24,
        ),
        FxSpacing.width(16),
        FxText.bodyMedium(
          fileName,
          fontWeight: 600,
        ),
      ],
    );
  }

  buildDataRows(
    String name,
    DateTime modifyAt,
    String author,
    int bytes,
    String owner,
    IconData? icon,
    List<String> images,
  ) {
    return DataRow(
      cells: [
        DataCell(
          SizedBox(
            width: 250,
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 22,
                ),
                FxSpacing.width(16),
                FxText.bodyMedium(
                  name,
                  fontWeight: 600,
                ),
              ],
            ),
          ),
        ),
        DataCell(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FxText.bodyMedium(
                '${Utils.getDateStringFromDateTime(modifyAt, showMonthShort: true)}',
              ),
              FxText.bodySmall(
                "by $author",
                muted: true,
              ),
            ],
          ),
        ),
        DataCell(
          FxText.bodyMedium(
            Utils.getStorageStringFromByte(bytes),
          ),
        ),
        DataCell(
          FxText.bodyMedium(owner),
        ),
        DataCell(
          SizedBox(
            width: 130,
            child: Stack(
                alignment: Alignment.centerRight,
                children: images
                    .mapIndexed((index, image) => Positioned(
                          left: (18 + (20 * index)).toDouble(),
                          child: FxContainer.rounded(
                            bordered: true,
                            paddingAll: 0,
                            child: Image.asset(
                              image,
                              height: 28,
                              width: 28,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ))
                    .toList()),
          ),
        ),
        DataCell(FxContainer.none(
          paddingAll: 8,
          borderRadiusAll: 5,
          color: contentTheme.primary.withOpacity(0.05),
          child: PopupMenuButton(
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                  padding: FxSpacing.xy(16, 8),
                  height: 10,
                  child: Row(
                    children: [
                      Icon(
                        Icons.share_outlined,
                        size: 16,
                      ),
                      FxSpacing.width(8),
                      FxText.bodySmall("Share")
                    ],
                  )),
              PopupMenuItem(
                  padding: FxSpacing.xy(16, 8),
                  height: 10,
                  child: Row(
                    children: [
                      Icon(
                        Icons.link_outlined,
                        size: 16,
                      ),
                      FxSpacing.width(8),
                      FxText.bodySmall("Get Sharable Link")
                    ],
                  )),
              PopupMenuItem(
                  padding: FxSpacing.xy(16, 8),
                  height: 10,
                  child: Row(
                    children: [
                      Icon(
                        Icons.create_outlined,
                        size: 16,
                      ),
                      FxSpacing.width(8),
                      FxText.bodySmall("Rename")
                    ],
                  )),
              PopupMenuItem(
                  padding: FxSpacing.xy(16, 8),
                  height: 10,
                  child: Row(
                    children: [
                      Icon(
                        Icons.download_outlined,
                        size: 16,
                      ),
                      FxSpacing.width(8),
                      FxText.bodySmall("Download")
                    ],
                  )),
              PopupMenuItem(
                  padding: FxSpacing.xy(16, 8),
                  height: 10,
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete_outline,
                        size: 16,
                      ),
                      FxSpacing.width(8),
                      FxText.bodySmall("Remove")
                    ],
                  ))
            ],
            child: Icon(
              Icons.more_horiz_outlined,
              size: 18,
            ),
          ),
        )),
      ],
    );
  }

  Widget buildFile(IconData icon, String name, int bytes) {
    return FxContainer.bordered(
      paddingAll: 8,
      width: 220,
      child: Row(
        children: [
          FxContainer(
            color: contentTheme.onBackground.withAlpha(28),
            paddingAll: 8,
            child: Icon(
              icon,
              size: 20,
            ),
          ),
          FxSpacing.width(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FxText.bodyMedium(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: 600,
                ),
                FxText.bodySmall(Utils.getStorageStringFromByte(bytes)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
