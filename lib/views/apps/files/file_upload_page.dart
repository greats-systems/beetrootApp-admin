import 'package:core_erp/controllers/apps/files/file_upload_controller.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:core_erp/utils/utils.dart';
import 'package:core_erp/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class FileUploadPage extends StatefulWidget {
  const FileUploadPage({Key? key}) : super(key: key);

  @override
  State<FileUploadPage> createState() => _FileUploadPageState();
}

class _FileUploadPageState extends State<FileUploadPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late FileUploadController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(FileUploadController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: FxSpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FxText.titleMedium(
                      "File Upload",
                      fontWeight: 600,
                    ),
                    FxBreadcrumb(
                      children: [
                        FxBreadcrumbItem(name: "UI"),
                        FxBreadcrumbItem(name: "File Upload", active: true),
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
                      elevation: 0.75, position: FxShadowPosition.bottom),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FxText.bodyMedium(
                        "Please upload any file to see a previews",
                        fontSize: 12,
                        fontWeight: 600,
                      ),
                      FxSpacing.height(16),
                      InkWell(
                        onTap: controller.pickFile,
                        child: FxDottedLine(
                          strokeWidth: 0.2,
                          color: contentTheme.onBackground,
                          corner: FxDottedLineCorner(
                            leftBottomCorner: 2,
                            leftTopCorner: 2,
                            rightBottomCorner: 2,
                            rightTopCorner: 2,
                          ),
                          child: Center(
                            heightFactor: 1.5,
                            child: Padding(
                              padding: FxSpacing.all(8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.cloud_upload_outlined, size: 22),
                                  FxContainer(
                                    width: 340,
                                    alignment: Alignment.center,
                                    paddingAll: 0,
                                    child: FxText.titleMedium(
                                      "Drop files here or click to upload.",
                                      fontWeight: 600,
                                      muted: true,
                                      fontSize: 18,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  FxContainer(
                                    alignment: Alignment.center,
                                    width: 610,
                                    child: FxText.titleMedium(
                                      "(This is just a demo dropzone. Selected files are not actually uploaded.)",
                                      muted: true,
                                      fontWeight: 500,
                                      fontSize: 16,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (controller.files.isNotEmpty) ...[
                        FxSpacing.height(16),
                        Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: controller.files
                              .mapIndexed((index, file) => FxContainer.bordered(
                                    paddingAll: 8,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        FxContainer(
                                          color: contentTheme.onBackground
                                              .withAlpha(28),
                                          paddingAll: 8,
                                          child: Icon(
                                            Icons.insert_drive_file_outlined,
                                            size: 20,
                                          ),
                                        ),
                                        FxSpacing.width(16),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            FxText.bodyMedium(
                                              file.name,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: 600,
                                            ),
                                            FxText.bodySmall(
                                                Utils.getStorageStringFromByte(
                                                    file.bytes?.length ?? 0)),
                                          ],
                                        ),
                                        FxSpacing.width(32),
                                        FxContainer.roundBordered(
                                          onTap: () =>
                                              controller.removeFile(file),
                                          paddingAll: 4,
                                          child: Icon(
                                            Icons.close,
                                            size: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        )
                      ],
                    ],
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
