import 'package:core_erp/controllers/apps/chat/chats_controller.dart';
import 'package:core_erp/images.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:core_erp/utils/utils.dart';
import 'package:core_erp/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late ChatsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ChatsController());
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
                      "Chat",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    FxBreadcrumb(
                      children: [
                        FxBreadcrumbItem(name: 'Apps'),
                        FxBreadcrumbItem(name: 'Chat', active: true),
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
                      child: FxContainer.bordered(
                        paddingAll: 0,
                        child: Padding(
                          padding: FxSpacing.all(flexSpacing),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  FxContainer.rounded(
                                    height: 40,
                                    width: 40,
                                    paddingAll: 0,
                                    child: Image.asset(
                                      Images.avatars[0],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  FxSpacing.width(16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FxText.labelLarge(
                                          "Den",
                                        ),
                                        FxSpacing.height(4),
                                        Row(
                                          children: [
                                            FxContainer.rounded(
                                              height: 10,
                                              width: 10,
                                              color: contentTheme.primary,
                                            ),
                                            FxSpacing.width(8),
                                            FxText.bodySmall(
                                              "Online",
                                              muted: true,
                                              fontWeight: 400,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(Icons.settings_outlined),
                                ],
                              ),
                              FxSpacing.height(22),
                              TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      contentTheme.primary.withOpacity(0.12),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: contentTheme.primary,
                                  ),
                                  hintText: "People,groups & messages...",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: FxSpacing.all(16),
                                ),
                              ),
                              FxSpacing.height(22),
                              FxText.titleMedium(
                                "GROUP CHAT",
                                color: contentTheme.title,
                                muted: true,
                                fontWeight: 600,
                              ),
                              FxSpacing.height(20),
                              Row(
                                children: [
                                  Icon(
                                    Icons.panorama_fish_eye_outlined,
                                    color: contentTheme.success,
                                    size: 16,
                                  ),
                                  FxSpacing.width(8),
                                  FxText.bodySmall(
                                    "App Development",
                                  ),
                                ],
                              ),
                              FxSpacing.height(8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.panorama_fish_eye_outlined,
                                    color: contentTheme.warning,
                                    size: 16,
                                  ),
                                  FxSpacing.width(8),
                                  FxText.bodySmall(
                                    "Office WOrk",
                                  ),
                                ],
                              ),
                              FxSpacing.height(22),
                              FxText.titleMedium(
                                "CONTACT",
                                color: contentTheme.title,
                                muted: true,
                                fontWeight: 600,
                              ),
                              FxSpacing.height(20),
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                FxText.labelLarge(
                                                  "${controller.chats[index].firstName}",
                                                ),
                                                FxText.bodySmall(
                                                  '${Utils.getTimeStringFromDateTime(controller.chats[index].sendAt, showSecond: false)}',
                                                  muted: true,
                                                  fontWeight: 600,
                                                )
                                              ],
                                            ),
                                            FxSpacing.height(4),
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
                                  return FxSpacing.height(12);
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    FxFlexItem(
                      sizes: "lg-8",
                      child: FxContainer.bordered(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                FxContainer.rounded(
                                  height: 40,
                                  width: 40,
                                  paddingAll: 0,
                                  child: Image.asset(
                                    Images.avatars[1],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                FxSpacing.width(16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FxText.labelLarge(
                                        "Lurette",
                                      ),
                                      FxSpacing.height(4),
                                      Row(
                                        children: [
                                          FxContainer.rounded(
                                            height: 10,
                                            width: 10,
                                            color: contentTheme.primary,
                                          ),
                                          FxSpacing.width(8),
                                          FxText.bodySmall(
                                            "Online",
                                            fontSize: 12,
                                            muted: true,
                                            fontWeight: 400,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.call_outlined),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.videocam_outlined),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.person_add_alt_outlined),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.delete_outline),
                                ),
                              ],
                            ),
                            Divider(),
                            Column(
                              children: [
                                messages(),
                                FxSpacing.height(8),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: FxContainer(
                                    height: 80,
                                    color: contentTheme.primary.withAlpha(30),
                                    padding: FxSpacing.x(20),
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: controller.message,
                                            autocorrect: false,
                                            decoration: InputDecoration(
                                              hintText: "type message here",
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.send_outlined),
                                          iconSize: 20.0,
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
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

  Widget messages() {
    return Padding(
      padding: FxSpacing.xy(16, 16),
      child: SizedBox(
        height: 500,
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: controller.chats.length,
          itemBuilder: (BuildContext context, int index) {
            return controller.chats[index].fromMe == false
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          FxContainer.rounded(
                            height: 32,
                            width: 32,
                            paddingAll: 0,
                            child: Image.asset(
                              Images.avatars[1],
                              fit: BoxFit.cover,
                            ),
                          ),
                          FxSpacing.height(4),
                          FxText.bodySmall(
                            '${Utils.getTimeStringFromDateTime(
                              controller.chats[index].sendAt,
                              showSecond: false,
                            )}',
                            muted: true,
                            fontWeight: 600,
                            fontSize: 8,
                          )
                        ],
                      ),
                      FxSpacing.width(12),
                      Wrap(
                        alignment: WrapAlignment.start,
                        children: [
                          FxContainer.none(
                            paddingAll: 8,
                            alignment: Alignment.bottomRight,
                            borderRadiusAll: 8,
                            color: contentTheme.primary.withAlpha(20),
                            child: FxText.titleMedium(
                              controller.chats[index].receiveMessage,
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                              color: contentTheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        alignment: WrapAlignment.end,
                        children: [
                          FxContainer.none(
                            paddingAll: 8,
                            alignment: Alignment.bottomLeft,
                            borderRadiusAll: 8,
                            color: contentTheme.primary.withAlpha(20),
                            child: FxText.titleMedium(
                              controller.chats[index].sendMessage,
                              fontSize: 12,
                              color: contentTheme.primary,
                            ),
                          ),
                        ],
                      ),
                      FxSpacing.width(12),
                      Column(
                        children: [
                          FxContainer.rounded(
                            height: 32,
                            width: 32,
                            paddingAll: 0,
                            child: Image.asset(
                              Images.avatars[8],
                              fit: BoxFit.cover,
                            ),
                          ),
                          FxSpacing.height(4),
                          FxText.bodySmall(
                            '${Utils.getTimeStringFromDateTime(
                              controller.chats[index].sendAt,
                              showSecond: false,
                            )}',
                            fontSize: 8,
                            muted: true,
                            fontWeight: 600,
                          ),
                        ],
                      ),
                    ],
                  );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 12,
            );
          },
        ),
      ),
    );
  }
}
