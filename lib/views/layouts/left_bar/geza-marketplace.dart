import 'package:core_erp/controllers/apps/ecommerce/orders_controller.dart';
import 'package:core_erp/controllers/auth/auth_controller.dart';
import 'package:core_erp/extensions/string.dart';
import 'package:core_erp/services/theme/app_style.dart';
import 'package:core_erp/services/theme/theme_customizer.dart';
import 'package:core_erp/services/url_service.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:core_erp/widgets/custom_pop_menu.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';

class GezaMarketplaceLeftBar extends StatefulWidget {
  final bool isCondensed;
  const GezaMarketplaceLeftBar({Key? key, this.isCondensed = false})
      : super(key: key);

  @override
  _GezaMarketplaceLeftBarState createState() => _GezaMarketplaceLeftBarState();
}

class _GezaMarketplaceLeftBarState extends State<GezaMarketplaceLeftBar>
    with SingleTickerProviderStateMixin, UIMixin {
  final ThemeCustomizer customizer = ThemeCustomizer.instance;
  late AuthController authController;
  late OrdersController ordersController;

  bool isCondensed = false;
  String path = UrlService.getCurrentUrl();

  @override
  void initState() {
    super.initState();
    authController = Get.put(AuthController());
    ordersController = Get.put(OrdersController());
  }

  @override
  Widget build(BuildContext context) {
    isCondensed = widget.isCondensed;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // NavigationItem(
        //   iconData: Icons.dashboard_outlined,
        //   title: "Company analytics".capitalizeWords,
        //   isCondensed: isCondensed,
        //   route: '/dashboard',
        // ),
        labelWidget("Admin Analytics".capitalizeWords),
        // Obx(
        //   () => NavigationItem(
        //     iconData: Icons.storefront_outlined,
        //     title: "users - ${ordersController.totalOrders}".capitalizeWords,
        //     route: '/users',
        //     isCondensed: isCondensed,
        //   ),
        // ),
        // NavigationItem(
        //   iconData: Icons.attach_money_outlined,
        //   title: "users".capitalizeWords,
        //   route: '/apps/ecommerce/customers',
        //   isCondensed: isCondensed,
        // ),
        // FxSpacing.height(32),
        labelWidget("Services".capitalizeWords),
        // NavigationItem(
        //   iconData: Icons.bookmark_add,
        //   title: "Beauty Styles".capitalizeWords,
        //   route: '/beauty-styles',
        //   isCondensed: isCondensed,
        // ),
        labelWidget("Exhibits".capitalizeWords),
        NavigationItem(
          iconData: Icons.bookmark_add,
          title: "Exhibits".capitalizeWords,
          route: '/exhibits',
          isCondensed: isCondensed,
        ),
        labelWidget("human_resources".capitalizeWords),
        NavigationItem(
          iconData: FeatherIcons.users,
          title: "Human Resource".capitalizeWords,
          route: '/hr_analytics',
          isCondensed: isCondensed,
        ),
        // NavigationItem(
        //   iconData: Icons.work_outline_rounded,
        //   title: "drivers".capitalizeWords,
        //   route: '/drivers_list',
        //   isCondensed: isCondensed,
        // ),
        // NavigationItem(
        //   iconData: Icons.work_outline_rounded,
        //   title: "add_driver".capitalizeWords,
        //   route: '/add_new_employee',
        //   isCondensed: isCondensed,
        // ),
        // NavigationItem(
        //   iconData: Icons.work_outline_rounded,
        //   title: "assign_truck".capitalizeWords,
        //   route: '/assign_truck',
        //   isCondensed: isCondensed,
        // ),
        // NavigationItem(
        //   iconData: Icons.attach_money_outlined,
        //   title: "invoices".capitalizeWords,
        //   route: '/apps/ecommerce/invoice',
        //   isCondensed: isCondensed,
        // ),
        // MenuWidget(
        //     iconData: Icons.create_new_folder_outlined,
        //     isCondensed: isCondensed,
        //     title: "files".capitalizeWords,
        //     children: [
        //       MenuItem(
        //         title: "manager".capitalizeWords,
        //         route: '/apps/files',
        //         isCondensed: widget.isCondensed,
        //       ),
        //       MenuItem(
        //         title: "upload".capitalizeWords,
        //         route: '/apps/files/upload',
        //         isCondensed: widget.isCondensed,
        //       ),
        //     ]),
        // NavigationItem(
        //   iconData: Icons.currency_exchange_outlined,
        //   title: "nft_dashboard".capitalizeWords,
        //   route: '/nft/dashboard',
        //   isCondensed: isCondensed,
        // ),
        // NavigationItem(
        //   iconData: Icons.question_answer_outlined,
        //   title: "chats".capitalizeWords,
        //   route: '/chats',
        //   isCondensed: isCondensed,
        // ),
        // labelWidget("pages".capitalizeWords),
        // MenuWidget(
        //   iconData: Icons.admin_panel_settings_outlined,
        //   isCondensed: isCondensed,
        //   title: "auth".capitalizeWords,
        //   children: [
        //     MenuItem(
        //       title: "login".capitalizeWords,
        //       route: '/auth/login',
        //       isCondensed: widget.isCondensed,
        //     ),
        //     MenuItem(
        //       title: "register".capitalizeWords,
        //       route: '/auth/register',
        //       isCondensed: widget.isCondensed,
        //     ),
        //     MenuItem(
        //       title: "forgot_password".capitalizeWords,
        //       route: '/auth/forgot_password',
        //       isCondensed: widget.isCondensed,
        //     ),
        //     MenuItem(
        //       title: "reset_password".capitalizeWords,
        //       route: '/auth/reset_password',
        //       isCondensed: widget.isCondensed,
        //     ),
        //     MenuItem(
        //       title: "locked".capitalizeWords,
        //       route: '/auth/locked',
        //       isCondensed: widget.isCondensed,
        //     ),
        //   ],
        // ),
        // MenuWidget(
        //   iconData: Icons.widgets_outlined,
        //   isCondensed: isCondensed,
        //   title: "widgets".capitalizeWords,
        //   children: [
        //     MenuItem(
        //       title: "buttons".capitalizeWords,
        //       route: '/ui/buttons',
        //       isCondensed: widget.isCondensed,
        //     ),
        //     MenuItem(
        //       title: "cards".capitalizeWords,
        //       route: '/ui/cards',
        //       isCondensed: widget.isCondensed,
        //     ),
        //     MenuItem(
        //       title: "tabs".capitalizeWords,
        //       route: '/ui/tabs',
        //       isCondensed: widget.isCondensed,
        //     ),
        //     MenuItem(
        //       title: "dialogs".capitalizeWords,
        //       route: '/ui/dialogs',
        //       isCondensed: widget.isCondensed,
        //     ),
        //     MenuItem(
        //       title: "carousels".capitalizeWords,
        //       route: '/ui/carousels',
        //       isCondensed: widget.isCondensed,
        //     ),
        //     MenuItem(
        //       title: "drag_drop".capitalizeWords,
        //       route: '/ui/drag_drop',
        //       isCondensed: widget.isCondensed,
        //     ),
        //     MenuItem(
        //       title: "notifications".capitalizeWords,
        //       route: '/ui/notifications',
        //       isCondensed: widget.isCondensed,
        //     ),
        //   ],
        // ),
        // MenuWidget(
        //   iconData: Icons.post_add_outlined,
        //   isCondensed: isCondensed,
        //   title: "form".capitalizeWords,
        //   children: [
        //     MenuItem(
        //       title: "basic".capitalizeWords,
        //       route: '/forms/basic',
        //       isCondensed: widget.isCondensed,
        //     ),
        //     MenuItem(
        //       title: "validations".capitalizeWords,
        //       route: '/forms/validation',
        //       isCondensed: widget.isCondensed,
        //     ),
        //     MenuItem(
        //       title: "html_editor".capitalizeWords,
        //       route: '/forms/html_editor',
        //       isCondensed: widget.isCondensed,
        //     ),
        //     MenuItem(
        //       title: "masks".capitalizeWords,
        //       route: '/forms/masks',
        //       isCondensed: widget.isCondensed,
        //     ),
        //     MenuItem(
        //       title: "wizard".capitalizeWords,
        //       route: '/forms/wizard',
        //       isCondensed: widget.isCondensed,
        //     ),
        //   ],
        // ),
        // MenuWidget(
        //   iconData: Icons.note_outlined,
        //   isCondensed: isCondensed,
        //   title: "extra".capitalizeWords,
        //   children: [
        //     MenuItem(
        //       title: "profile".capitalizeWords,
        //       route: '/pages/profile',
        //       isCondensed: widget.isCondensed,
        //     ),
        //     MenuItem(
        //       title: "success".capitalizeWords,
        //       route: '/pages/success',
        //       isCondensed: widget.isCondensed,
        //     ),
        //     MenuItem(
        //       title: "coming_soon".capitalizeWords,
        //       route: '/pages/coming-soon',
        //       isCondensed: widget.isCondensed,
        //     ),
        //     MenuItem(
        //       title: "error_404".capitalizeWords,
        //       route: '/pages/error-404',
        //       isCondensed: widget.isCondensed,
        //     ),
        //     MenuItem(
        //       title: "error_404_alt".capitalizeWords,
        //       route: '/pages/error-404-alt',
        //       isCondensed: widget.isCondensed,
        //     ),
        //     MenuItem(
        //       title: "error_404_cover".capitalizeWords,
        //       route: '/pages/error-404-cover',
        //       isCondensed: widget.isCondensed,
        //     ),
        //     MenuItem(
        //       title: "error_500".capitalizeWords,
        //       route: '/pages/error-500',
        //       isCondensed: widget.isCondensed,
        //     ),
        //     MenuItem(
        //       title: "offline".capitalizeWords,
        //       route: '/pages/offline',
        //       isCondensed: widget.isCondensed,
        //     ),
        //     MenuItem(
        //       title: "maintenance".capitalizeWords,
        //       route: '/pages/maintenance',
        //       isCondensed: widget.isCondensed,
        //     ),
        //   ],
        // ),
        // NavigationItem(
        //   iconData: Icons.attach_money_outlined,
        //   title: "pricing".capitalizeWords,
        //   route: '/pricing',
        //   isCondensed: isCondensed,
        // ),

        // NavigationItem(
        //   iconData: Icons.list_alt_rounded,
        //   title: "FAQs".capitalizeWords,
        //   route: '/faqs',
        //   isCondensed: isCondensed,
        // ),
        // NavigationItem(
        //   iconData: Icons.insert_drive_file_outlined,
        //   title: "starter".capitalizeWords,
        //   route: '/starter',
        //   isCondensed: isCondensed,
        // ),
        // labelWidget("other".capitalizeWords),
        // NavigationItem(
        //   iconData: Icons.table_chart_outlined,
        //   title: "basic_tables".capitalizeWords,
        //   route: '/other/basic_tables',
        //   isCondensed: isCondensed,
        // ),
        // NavigationItem(
        //   iconData: Icons.insert_chart_outlined,
        //   title: "syncfusion_chart".capitalizeWords,
        //   route: '/other/syncfusion_charts',
        //   isCondensed: isCondensed,
        // ),
        // MenuWidget(
        //   iconData: Icons.map_outlined,
        //   isCondensed: isCondensed,
        //   title: "maps".capitalizeWords,
        //   children: [
        //     MenuItem(
        //       title: "google_map".capitalizeWords,
        //       route: '/maps/google_maps',
        //       isCondensed: widget.isCondensed,
        //     ),
        //     MenuItem(
        //       title: "leaflet".capitalizeWords,
        //       route: '/maps/leaflet',
        //       isCondensed: widget.isCondensed,
        //     ),
        //   ],
        // ),
        // FxSpacing.height(16),
        // if (!isCondensed)
        //   Center(
        //     child: FxButton(
        //         borderRadiusAll: AppStyle.buttonRadius.small,
        //         elevation: 0,
        //         padding: FxSpacing.xy(12, 16),
        //         onPressed: () {
        //           UrlService.goToPurchase();
        //         },
        //         backgroundColor: colorScheme.primary,
        //         child: FxText.labelMedium(
        //           'purchase_now'.capitalizeWords,
        //           color: colorScheme.onPrimary,
        //         )),
        //   ),
      ],
    );
  }

  Widget labelWidget(String label) {
    return isCondensed
        ? FxSpacing.empty()
        : Container(
            padding: FxSpacing.xy(24, 8),
            child: FxText.labelSmall(
              label.toUpperCase(),
              color: leftBarTheme.labelColor,
              muted: true,
              maxLines: 1,
              overflow: TextOverflow.clip,
              fontWeight: 700,
            ),
          );
  }
}

typedef LeftbarMenuFunction = void Function(String key);

class LeftbarObserver {
  static Map<String, LeftbarMenuFunction> observers = {};

  static attachListener(String key, LeftbarMenuFunction fn) {
    observers[key] = fn;
  }

  static detachListener(String key) {
    observers.remove(key);
  }

  static notifyAll(String key) {
    for (var fn in observers.values) {
      fn(key);
    }
  }
}

class MenuWidget extends StatefulWidget {
  final IconData iconData;
  final String title;
  final bool isCondensed;
  final bool active;
  final List<MenuItem> children;

  const MenuWidget(
      {super.key,
      required this.iconData,
      required this.title,
      this.isCondensed = false,
      this.active = false,
      this.children = const []});

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget>
    with UIMixin, SingleTickerProviderStateMixin {
  bool isHover = false;
  bool isActive = false;
  late Animation<double> _iconTurns;
  late AnimationController _controller;
  bool popupShowing = true;
  Function? hideFn;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _iconTurns = _controller.drive(Tween<double>(begin: 0.0, end: 0.5)
        .chain(CurveTween(curve: Curves.easeIn)));
    LeftbarObserver.attachListener(widget.title, onChangeMenuActive);
  }

  void onChangeMenuActive(String key) {
    if (key != widget.title) {
      // onChangeExpansion(false);
    }
  }

  void onChangeExpansion(value) {
    isActive = value;
    if (isActive) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var route = UrlService.getCurrentUrl();
    isActive = widget.children.any((element) => element.route == route);
    onChangeExpansion(isActive);
    if (hideFn != null) {
      hideFn!();
    }
    // popupShowing = false;
  }

  @override
  Widget build(BuildContext context) {
    // var route = Uri.base.fragment;
    // isActive = widget.children.any((element) => element.route == route);

    if (widget.isCondensed) {
      return CustomPopupMenu(
        backdrop: true,
        show: popupShowing,
        hideFn: (_) => hideFn = _,
        onChange: (_) {
          // popupShowing = _;
        },
        placement: CustomPopupMenuPlacement.right,
        menu: MouseRegion(
          cursor: SystemMouseCursors.click,
          onHover: (event) {
            setState(() {
              isHover = true;
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
            child: Center(
              child: Icon(
                widget.iconData,
                color: (isHover || isActive)
                    ? leftBarTheme.activeItemColor
                    : leftBarTheme.onBackground,
                size: 20,
              ),
            ),
          ),
        ),
        menuBuilder: (_) => FxContainer.bordered(
          paddingAll: 8,
          width: 190,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: widget.children,
          ),
        ),
      );
    } else {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (event) {
          setState(() {
            isHover = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHover = false;
          });
        },
        child: FxContainer.transparent(
          margin: FxSpacing.fromLTRB(24, 0, 16, 0),
          paddingAll: 0,
          child: ListTileTheme(
            contentPadding: EdgeInsets.all(0),
            dense: true,
            horizontalTitleGap: 0.0,
            minLeadingWidth: 0,
            child: ExpansionTile(
                tilePadding: FxSpacing.zero,
                initiallyExpanded: isActive,
                maintainState: true,
                onExpansionChanged: (_) {
                  LeftbarObserver.notifyAll(widget.title);
                  onChangeExpansion(_);
                },
                trailing: RotationTransition(
                  turns: _iconTurns,
                  child: Icon(
                    Icons.expand_more,
                    size: 18,
                    color: leftBarTheme.onBackground,
                  ),
                ),
                iconColor: leftBarTheme.activeItemColor,
                childrenPadding: FxSpacing.x(12),
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      widget.iconData,
                      size: 20,
                      color: isHover || isActive
                          ? leftBarTheme.activeItemColor
                          : leftBarTheme.onBackground,
                    ),
                    FxSpacing.width(18),
                    Expanded(
                      child: FxText.labelLarge(
                        widget.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        color: isHover || isActive
                            ? leftBarTheme.activeItemColor
                            : leftBarTheme.onBackground,
                      ),
                    ),
                  ],
                ),
                collapsedBackgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.transparent),
                ),
                backgroundColor: Colors.transparent,
                children: widget.children),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    // LeftbarObserver.detachListener(widget.title);
  }
}

class MenuItem extends StatefulWidget {
  final IconData? iconData;
  final String title;
  final bool isCondensed;
  final String? route;

  const MenuItem({
    Key? key,
    this.iconData,
    required this.title,
    this.isCondensed = false,
    this.route,
  }) : super(key: key);

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> with UIMixin {
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
            isHover = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHover = false;
          });
        },
        child: FxContainer.transparent(
          margin: FxSpacing.fromLTRB(4, 0, 8, 4),
          color: isActive || isHover
              ? leftBarTheme.activeItemBackground
              : Colors.transparent,
          width: MediaQuery.of(context).size.width,
          padding: FxSpacing.xy(18, 7),
          child: FxText.bodySmall(
            "${widget.isCondensed ? "" : "- "}  ${widget.title}",
            overflow: TextOverflow.clip,
            maxLines: 1,
            textAlign: TextAlign.left,
            fontSize: 12.5,
            color: isActive || isHover
                ? leftBarTheme.activeItemColor
                : leftBarTheme.onBackground,
            fontWeight: isActive || isHover ? 600 : 500,
          ),
        ),
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
            isHover = true;
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
