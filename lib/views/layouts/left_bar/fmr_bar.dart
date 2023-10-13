import 'package:core_erp/extensions/string.dart';
import 'package:core_erp/services/theme/theme_customizer.dart';
import 'package:core_erp/services/url_service.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/route_manager.dart';

class FarmerLeftBar extends StatelessWidget {
  const FarmerLeftBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NavigationItem(
          iconData: Icons.dashboard_outlined,
          title: "Trading analytics".tr(),
          isCondensed: false,
          route: '/dashboard',
        ),
        // labelWidget("apps".tr()),
        labelWidget("trading".tr()),
        NavigationItem(
          iconData: Icons.storefront_outlined,
          title: "products".tr(),
          route: '/apps/ecommerce/products',
          isCondensed: false,
        ),
        NavigationItem(
          iconData: Icons.person_2_outlined,
          title: "add_product".tr(),
          route: '/apps/ecommerce/add_product',
          isCondensed: false,
        ),

        labelWidget("human_resources".tr()),
        NavigationItem(
          iconData: Icons.work_outline_rounded,
          title: "analytics".tr(),
          route: '/apps/hr/employees',
          isCondensed: false,
        ),
        labelWidget("sales".tr()),
        NavigationItem(
          iconData: Icons.attach_money_outlined,
          title: "Vendors".tr(),
          route: '/apps/ecommerce/customers',
          isCondensed: false,
        ),
        FxSpacing.height(32),
      ],
    );
  }

  Widget labelWidget(String label) {
    return Container(
      padding: FxSpacing.xy(24, 8),
      child: FxText.labelSmall(
        label.toUpperCase(),
        color: theme.primaryColor,
        muted: false,
        maxLines: 1,
        overflow: TextOverflow.clip,
        fontWeight: 700,
      ),
    );
  }
}

class NavigationItem extends StatefulWidget {
  final IconData? iconData;
  final String title;
  final bool isCondensed;
  final String? route;

  const NavigationItem(
      {Key? key,
      this.iconData,
      required this.title,
      this.isCondensed = false,
      this.route})
      : super(key: key);

  @override
  _NavigationItemState createState() => _NavigationItemState();
}

class _NavigationItemState extends State<NavigationItem> with UIMixin {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    bool isActive = UrlService.getCurrentUrl() == widget.route;
    return GestureDetector(
      onTap: () {
        if (widget.route != null) {
          Get.toNamed(widget.route!);
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (event) {
          setState(() {
            isHover = false;
          });
        },
        onExit: (event) {
          setState(() {
            isHover = false;
          });
        },
        child: FxContainer.transparent(
          margin: FxSpacing.fromLTRB(16, 0, 16, 8),
          color: isActive || isHover
              ? leftBarTheme.activeItemBackground
              : Colors.transparent,
          padding: FxSpacing.xy(8, 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.iconData != null)
                Center(
                  child: Icon(
                    widget.iconData,
                    color: (isHover || isActive)
                        ? leftBarTheme.activeItemColor
                        : leftBarTheme.onBackground,
                    size: 20,
                  ),
                ),
              if (!widget.isCondensed)
                Flexible(
                  fit: FlexFit.loose,
                  child: FxSpacing.width(16),
                ),
              if (!widget.isCondensed)
                Expanded(
                  flex: 3,
                  child: FxText.labelLarge(
                    widget.title,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    color: isActive || isHover
                        ? leftBarTheme.activeItemColor
                        : leftBarTheme.onBackground,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
