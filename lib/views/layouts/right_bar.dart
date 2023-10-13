import 'package:core_erp/controllers/auth/auth_controller.dart';
import 'package:core_erp/services/theme/theme_customizer.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:core_erp/widgets/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/instance_manager.dart';

// typedef void OnLeftBarColorSchemeChange(LeftBarThemeType leftBarThemeType);
// typedef void OnTopBarColorSchemeChange(TopBarThemeType topBarThemeType);
// typedef void OnRightBarColorSchemeChange(RightBarThemeType topBarThemeType);
// typedef void OnContentSchemeChange(ContentThemeType contentThemeType);

class RightBar extends StatefulWidget {
  // final RightBarThemeType rightBarThemeType;
  // final LeftBarThemeType leftBarThemeType;
  // final TopBarThemeType topBarThemeType;
  // final ContentThemeType contentThemeType;
  // final OnLeftBarColorSchemeChange onLeftBarColorSchemeChange;
  // final OnTopBarColorSchemeChange onTopBarColorSchemeChange;
  // final OnRightBarColorSchemeChange onRightBarColorSchemeChange;
  // final OnContentSchemeChange onContentSchemeChange;

  const RightBar({
    Key? key, // this.leftBarThemeType,
    // this.topBarThemeType,
    // this.contentThemeType,
    // this.onLeftBarColorSchemeChange,
    // this.onTopBarColorSchemeChange,
    // this.onContentSchemeChange,
    // this.onRightBarColorSchemeChange
  }) : super(key: key);

  @override
  _RightBarState createState() => _RightBarState();
}

class _RightBarState extends State<RightBar>
    with SingleTickerProviderStateMixin, UIMixin {
  ThemeCustomizer customizer = ThemeCustomizer.instance;
  late AuthController authController;
  @override
  void initState() {
    super.initState();
    authController = Get.put(AuthController());
  }

  @override
  Widget build(BuildContext context) {
    customizer = ThemeCustomizer.instance;
    return Container(
      width: 280,
      color: colorScheme.background,
      child: Column(
        children: [
          Container(
            height: 60,
            alignment: Alignment.centerLeft,
            padding: FxSpacing.x(24),
            color: colorScheme.primaryContainer,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: FxText.labelLarge(
                    "Settings",
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.close,
                    size: 18,
                    color: colorScheme.onPrimaryContainer,
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
            padding: FxSpacing.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FxText.labelMedium("Color Scheme"),
                Divider(),
                FxSpacing.height(8),
                Row(
                  children: [
                    CustomSwitch.small(
                      value: customizer.theme == ThemeMode.light,
                      onChanged: (value) {
                        ThemeCustomizer.setTheme(ThemeMode.light);
                      },
                    ),
                    FxSpacing.width(12),
                    Text(
                      "Light",
                    )
                  ],
                ),
                FxSpacing.height(8),
                Row(
                  children: [
                    CustomSwitch.small(
                      value: customizer.theme == ThemeMode.dark,
                      onChanged: (value) {
                        ThemeCustomizer.setTheme(ThemeMode.dark);
                      },
                    ),
                    FxSpacing.width(12),
                    Text(
                      "Dark",
                    )
                  ],
                ),
                // Spacing.height(8),
                // Row(
                //   children: [
                //     CustomSwitch.small(
                //       value: widget.contentThemeType == ContentThemeType.dark,
                //       activeBorderColor: rightBarTheme.activeSwitchBorderColor,
                //       inactiveBorderColor: rightBarTheme.inactiveSwitchBorderColor,
                //       inactiveTrackColor: rightBarTheme.disabled,
                //       activeTrackColor: rightBarTheme.primary,
                //       inactiveThumbColor: rightBarTheme.onDisabled,
                //       activeThumbColor: rightBarTheme.onPrimary,
                //       onChanged: (value) {
                //         if (value && widget.onContentSchemeChange != null) {
                //           widget.onContentSchemeChange(ContentThemeType.dark);
                //         }
                //       },
                //     ),
                //     Spacing.width(12),
                //     Text(
                //       "Dark",
                //       style: AppTheme.getTextStyle(themeData.textTheme.bodyText2,
                //           color: rightBarTheme.onBackground),
                //     )
                //   ],
                // ),
                // Spacing.height(36),
                // Text("Left Bar",
                //     style: AppTheme.getTextStyle(themeData.textTheme.bodyText1,
                //         color: rightBarTheme.onBackground, fontWeight: 600)),
                Divider(),
                // Spacing.height(8),
                // Row(
                //   children: [
                //     CustomSwitch.small(
                //       value: widget.leftBarThemeType == LeftBarThemeType.light,
                //       activeBorderColor: rightBarTheme.activeSwitchBorderColor,
                //       inactiveBorderColor: rightBarTheme.inactiveSwitchBorderColor,
                //       inactiveTrackColor: rightBarTheme.disabled,
                //       activeTrackColor: rightBarTheme.primary,
                //       inactiveThumbColor: rightBarTheme.onDisabled,
                //       activeThumbColor: rightBarTheme.onPrimary,
                //       onChanged: (value) {
                //         if (value && widget.onLeftBarColorSchemeChange != null) {
                //           widget.onLeftBarColorSchemeChange(LeftBarThemeType.light);
                //         }
                //       },
                //     ),
                //     Spacing.width(12),
                //     Text(
                //       "Light",
                //       style: AppTheme.getTextStyle(themeData.textTheme.bodyText2,
                //           color: rightBarTheme.onBackground),
                //     )
                //   ],
                // ),
                // Spacing.height(8),
                // Row(
                //   children: [
                //     CustomSwitch.small(
                //       value: widget.leftBarThemeType == LeftBarThemeType.dark,
                //       activeBorderColor: rightBarTheme.activeSwitchBorderColor,
                //       inactiveBorderColor: rightBarTheme.inactiveSwitchBorderColor,
                //       inactiveTrackColor: rightBarTheme.disabled,
                //       activeTrackColor: rightBarTheme.primary,
                //       inactiveThumbColor: rightBarTheme.onDisabled,
                //       activeThumbColor: rightBarTheme.onPrimary,
                //       onChanged: (value) {
                //         if (value && widget.onLeftBarColorSchemeChange != null) {
                //           widget.onLeftBarColorSchemeChange(LeftBarThemeType.dark);
                //         }
                //       },
                //     ),
                //     Spacing.width(12),
                //     Text(
                //       "Dark",
                //       style: AppTheme.getTextStyle(themeData.textTheme.bodyText2,
                //           color: rightBarTheme.onBackground),
                //     )
                //   ],
                // ),
                // Spacing.height(36),
                Text("Top Bar"),
                Divider(),
                // Spacing.height(8),
                // Row(
                //   children: [
                //     CustomSwitch.small(
                //       value: widget.topBarThemeType == TopBarThemeType.light,
                //       inactiveTrackColor: rightBarTheme.disabled,
                //       activeBorderColor: rightBarTheme.activeSwitchBorderColor,
                //       inactiveBorderColor: rightBarTheme.inactiveSwitchBorderColor,
                //       activeTrackColor: rightBarTheme.primary,
                //       inactiveThumbColor: rightBarTheme.onDisabled,
                //       activeThumbColor: rightBarTheme.onPrimary,
                //       onChanged: (value) {
                //         if (value && widget.onTopBarColorSchemeChange != null) {
                //           widget.onTopBarColorSchemeChange(TopBarThemeType.light);
                //         }
                //       },
                //     ),
                //     Spacing.width(12),
                //     Text(
                //       "Light",
                //       style: AppTheme.getTextStyle(themeData.textTheme.bodyText2,
                //           color: rightBarTheme.onBackground),
                //     )
                //   ],
                // ),
                // Spacing.height(8),
                // Row(
                //   children: [
                //     CustomSwitch.small(
                //       value: widget.topBarThemeType == TopBarThemeType.dark,
                //       inactiveTrackColor: rightBarTheme.disabled,
                //       activeBorderColor: rightBarTheme.activeSwitchBorderColor,
                //       inactiveBorderColor: rightBarTheme.inactiveSwitchBorderColor,
                //       activeTrackColor: rightBarTheme.primary,
                //       inactiveThumbColor: rightBarTheme.onDisabled,
                //       activeThumbColor: rightBarTheme.onPrimary,
                //       onChanged: (value) {
                //         if (value && widget.onTopBarColorSchemeChange != null) {
                //           widget.onTopBarColorSchemeChange(TopBarThemeType.dark);
                //         }
                //       },
                //     ),
                //     Spacing.width(12),
                //     Text(
                //       "Dark",
                //       style: AppTheme.getTextStyle(themeData.textTheme.bodyText2,
                //           color: rightBarTheme.onBackground),
                //     )
                //   ],
                // ),
                // Spacing.height(36),
                // Text("Right Bar",
                //     style: AppTheme.getTextStyle(themeData.textTheme.bodyText1,
                //         color: rightBarTheme.onBackground, fontWeight: 600)),
                // Divider(),
                // Spacing.height(8),
                // Row(
                //   children: [
                //     CustomSwitch.small(
                //       value: widget.rightBarThemeType == RightBarThemeType.light,
                //       inactiveTrackColor: rightBarTheme.disabled,
                //       activeBorderColor: rightBarTheme.activeSwitchBorderColor,
                //       inactiveBorderColor: rightBarTheme.inactiveSwitchBorderColor,
                //       activeTrackColor: rightBarTheme.primary,
                //       inactiveThumbColor: rightBarTheme.onDisabled,
                //       activeThumbColor: rightBarTheme.onPrimary,
                //       onChanged: (value) {
                //         if (value && widget.onRightBarColorSchemeChange != null) {
                //           widget.onRightBarColorSchemeChange(RightBarThemeType.light);
                //         }
                //       },
                //     ),
                //     Spacing.width(12),
                //     Text(
                //       "Light",
                //       style: AppTheme.getTextStyle(themeData.textTheme.bodyText2,
                //           color: rightBarTheme.onBackground),
                //     )
                //   ],
                // ),
                // Spacing.height(8),
                // Row(
                //   children: [
                //     CustomSwitch.small(
                //       value: widget.rightBarThemeType == RightBarThemeType.dark,
                //       inactiveTrackColor: rightBarTheme.disabled,
                //       activeBorderColor: rightBarTheme.activeSwitchBorderColor,
                //       inactiveBorderColor: rightBarTheme.inactiveSwitchBorderColor,
                //       activeTrackColor: rightBarTheme.primary,
                //       inactiveThumbColor: rightBarTheme.onDisabled,
                //       activeThumbColor: rightBarTheme.onPrimary,
                //       onChanged: (value) {
                //         if (value && widget.onRightBarColorSchemeChange != null) {
                //           widget.onRightBarColorSchemeChange(RightBarThemeType.dark);
                //         }
                //       },
                //     ),
                //     Spacing.width(12),
                //     Text(
                //       "Dark",
                //       style: AppTheme.getTextStyle(themeData.textTheme.bodyText2,
                //           color: rightBarTheme.onBackground),
                //     )
                //   ],
                // ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
