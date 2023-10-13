import 'package:core_erp/controllers/auth/auth_controller.dart';
import 'package:core_erp/controllers/main_controller.dart';
import 'package:core_erp/controllers/starter_controller.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:get/get.dart';
import 'package:core_erp/extensions/string.dart';
import 'package:core_erp/images.dart';
import 'package:core_erp/services/localizations/language.dart';
import 'package:core_erp/services/theme/app_notifier.dart';
import 'package:core_erp/services/theme/app_style.dart';
import 'package:core_erp/services/theme/theme_customizer.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:core_erp/widgets/custom_pop_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:provider/provider.dart';

class TopBar extends StatefulWidget {
  const TopBar({
    super.key, // this.onMenuIconTap,
  });

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar>
    with SingleTickerProviderStateMixin, UIMixin {
  late StarterController controller;
  late AuthController authController;

  Function? languageHideFn;
  @override
  void initState() {
    super.initState();
    controller = Get.put(StarterController());
    authController = Get.put(AuthController());
  }

  @override
  Widget build(BuildContext context) {
    return FxCard(
      shadow: FxShadow(position: FxShadowPosition.bottomRight, elevation: 0.5),
      height: 60,
      borderRadiusAll: 0,
      padding: FxSpacing.x(24),
      color: topBarTheme.background.withAlpha(246),
      child: Row(
        children: [
          Row(
            children: [
              InkWell(
                  splashColor: colorScheme.onBackground,
                  highlightColor: colorScheme.onBackground,
                  onTap: () {
                    ThemeCustomizer.toggleLeftBarCondensed();
                  },
                  child: Icon(
                    Icons.menu,
                    color: topBarTheme.onBackground,
                  )),
              FxSpacing.width(24),
              SizedBox(
                width: 200,
                child: TextFormField(
                  maxLines: 1,
                  style: FxTextStyle.bodyMedium(),
                  decoration: InputDecoration(
                      hintText: "search".capitalizeFirst,
                      hintStyle: FxTextStyle.bodySmall(xMuted: true),
                      border: outlineInputBorder,
                      enabledBorder: outlineInputBorder,
                      focusedBorder: focusedInputBorder,
                      prefixIcon: Align(
                          alignment: Alignment.center,
                          child: Icon(
                            FeatherIcons.search,
                            size: 14,
                          )),
                      prefixIconConstraints: BoxConstraints(
                          minWidth: 36,
                          maxWidth: 36,
                          minHeight: 32,
                          maxHeight: 32),
                      contentPadding: FxSpacing.xy(16, 12),
                      isCollapsed: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never),
                ),
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Expanded(
                //   child: InkWell(
                //     onTap: () {
                //       ThemeCustomizer.setTheme(
                //           ThemeCustomizer.instance.theme == ThemeMode.dark
                //               ? ThemeMode.light
                //               : ThemeMode.dark);
                //     },
                //     child: Icon(
                //       ThemeCustomizer.instance.theme == ThemeMode.dark
                //           ? FeatherIcons.sun
                //           : FeatherIcons.moon,
                //       size: 18,
                //       color: topBarTheme.onBackground,
                //     ),
                //   ),
                // ),
                // FxSpacing.width(12),
                // CustomPopupMenu(
                //   backdrop: true,
                //   hideFn: (_) => languageHideFn = _,
                //   onChange: (_) {},
                //   offsetX: -36,
                //   menu: Padding(
                //     padding: FxSpacing.xy(8, 8),
                //     child: Center(
                //         child: ClipRRect(
                //             clipBehavior: Clip.antiAliasWithSaveLayer,
                //             borderRadius: BorderRadius.circular(2),
                //             child: Image.asset(
                //               'assets/lang/${ThemeCustomizer.instance.currentLanguage.locale.languageCode}.jpg',
                //               width: 24,
                //               height: 18,
                //               fit: BoxFit.cover,
                //             ))),
                //   ),
                //   menuBuilder: (_) => buildLanguageSelector(),
                // ),
                FxSpacing.width(6),
                Obx(() => CustomPopupMenu(
                      backdrop: true,
                      onChange: (_) {},
                      offsetX: -120,
                      menu: Padding(
                        padding: FxSpacing.xy(8, 8),
                        child: Center(
                          child: Row(
                            children: [
                              FxText.labelMedium(
                                authController.isonline.value == true
                                    ? "Online"
                                    : "Offline",
                                fontWeight: 600,
                                color: authController.isonline.value == true
                                    ? Color(0xFF006200)
                                    : Color(0xFFDF2600),
                              ),
                              FxSpacing.width(12),
                              Icon(
                                FeatherIcons.wifi,
                                size: 18,
                                color: authController.isonline.value == true
                                    ? Color(0xFF006200)
                                    : Color(0xFFDF2600),
                              ),
                            ],
                          ),
                        ),
                      ),
                      menuBuilder: (_) => buildNotifications(),
                    )),
                FxSpacing.width(4),
                CustomPopupMenu(
                  backdrop: true,
                  onChange: (_) {},
                  offsetX: -60,
                  offsetY: 8,
                  menu: Padding(
                    padding: FxSpacing.xy(8, 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FxContainer.rounded(
                            paddingAll: 0,
                            child: const Icon(
                              Icons.no_accounts,
                              size: 28,
                            )),
                        FxSpacing.width(8),
                        Obx(() => FxText.labelLarge(
                            "${authController.person.value.firstName}"))
                      ],
                    ),
                  ),
                  menuBuilder: (_) => buildAccountMenu(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildLanguageSelector() {
    return FxContainer.bordered(
      padding: FxSpacing.xy(8, 8),
      width: 125,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: Language.languages
            .map((language) => FxButton.text(
                  padding: FxSpacing.xy(8, 4),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  splashColor: contentTheme.onBackground.withAlpha(20),
                  onPressed: () async {
                    languageHideFn?.call();
                    // Language.changeLanguage(language);
                    await Provider.of<AppNotifier>(context, listen: false)
                        .changeLanguage(language, notify: true);
                    ThemeCustomizer.notify();
                    setState(() {});
                  },
                  child: Row(
                    children: [
                      ClipRRect(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          borderRadius: BorderRadius.circular(2),
                          child: Image.asset(
                            'assets/lang/${language.locale.languageCode}.jpg',
                            width: 18,
                            height: 14,
                            fit: BoxFit.cover,
                          )),
                      FxSpacing.width(8),
                      FxText.labelMedium(language.languageName)
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget buildNotifications() {
    Widget buildNotification(String title, String description) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FxText.labelLarge(title),
          FxSpacing.height(4),
          FxText.bodySmall(description)
        ],
      );
    }

    return FxContainer.bordered(
      paddingAll: 0,
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: FxSpacing.xy(16, 12),
            child: FxText.titleMedium("Notification", fontWeight: 600),
          ),
          FxDashedDivider(
              height: 1, color: theme.dividerColor, dashSpace: 4, dashWidth: 6),
          Padding(
            padding: FxSpacing.xy(16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildNotification("Your order is received",
                    "Order #1232 is ready to deliver"),
                FxSpacing.height(12),
                buildNotification("Account Security ",
                    "Your account password changed 1 hour ago"),
              ],
            ),
          ),
          FxDashedDivider(
              height: 1, color: theme.dividerColor, dashSpace: 4, dashWidth: 6),
          Padding(
            padding: FxSpacing.xy(16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FxButton.text(
                  onPressed: () {},
                  splashColor: contentTheme.primary.withAlpha(28),
                  child: FxText.labelSmall(
                    "View All",
                    color: contentTheme.primary,
                  ),
                ),
                FxButton.text(
                  onPressed: () {},
                  splashColor: contentTheme.danger.withAlpha(28),
                  child: FxText.labelSmall(
                    "Clear",
                    color: contentTheme.danger,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildAccountMenu() {
    return FxContainer.bordered(
      paddingAll: 0,
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: FxSpacing.xy(8, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FxButton(
                  onPressed: () => {},
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  borderRadiusAll: AppStyle.buttonRadius.medium,
                  padding: FxSpacing.xy(8, 4),
                  splashColor: colorScheme.onBackground.withAlpha(20),
                  backgroundColor: Colors.transparent,
                  child: Row(
                    children: [
                      Icon(
                        FeatherIcons.user,
                        size: 14,
                        color: contentTheme.onBackground,
                      ),
                      FxSpacing.width(8),
                      FxText.labelMedium(
                        "My Account",
                        fontWeight: 600,
                      )
                    ],
                  ),
                ),
                FxSpacing.height(4),
                FxButton(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPressed: () => {},
                  borderRadiusAll: AppStyle.buttonRadius.medium,
                  padding: FxSpacing.xy(8, 4),
                  splashColor: colorScheme.onBackground.withAlpha(20),
                  backgroundColor: Colors.transparent,
                  child: Row(
                    children: [
                      Icon(
                        FeatherIcons.settings,
                        size: 14,
                        color: contentTheme.onBackground,
                      ),
                      FxSpacing.width(8),
                      FxText.labelMedium(
                        "Settings",
                        fontWeight: 600,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          Padding(
            padding: FxSpacing.xy(8, 8),
            child: FxButton(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () => {authController.onHandleLogout()},
              borderRadiusAll: AppStyle.buttonRadius.medium,
              padding: FxSpacing.xy(8, 4),
              splashColor: contentTheme.danger.withAlpha(28),
              backgroundColor: Colors.transparent,
              child: Row(
                children: [
                  Icon(
                    FeatherIcons.logOut,
                    size: 14,
                    color: contentTheme.danger,
                  ),
                  FxSpacing.width(8),
                  FxText.labelMedium(
                    "Log out",
                    fontWeight: 600,
                    color: contentTheme.danger,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
