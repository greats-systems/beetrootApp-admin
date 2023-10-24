import 'package:core_erp/services/auth_service.dart';
import 'package:core_erp/views/apps/beetroot/add_exhibit.dart';
import 'package:core_erp/views/apps/beetroot/add_exhibit_questionaire.dart';
import 'package:core_erp/views/apps/chat/chats_page.dart';
import 'package:core_erp/views/apps/ecommerce/customers.dart';
import 'package:core_erp/views/apps/ecommerce/edit_product.dart';
import 'package:core_erp/views/apps/ecommerce/orders/order_detail.dart';
import 'package:core_erp/views/apps/ecommerce/orders/orders.dart';
import 'package:core_erp/views/apps/ecommerce/products.dart';
import 'package:core_erp/views/apps/geza-admin/add_beauty_style.dart';
import 'package:core_erp/views/apps/geza-admin/beauty_style.dart';
import 'package:core_erp/views/apps/provider-admin/add_employee.dart';
import 'package:core_erp/views/apps/provider-admin/add_truck.dart';
import 'package:core_erp/views/apps/provider-admin/allocate_vehicle.dart';
import 'package:core_erp/views/apps/provider-admin/assign_task.dart';
import 'package:core_erp/views/apps/beetroot/exhibits.dart';
import 'package:core_erp/views/apps/provider-admin/job_vacancee_page.dart';
import 'package:core_erp/views/apps/nft/dashboard_page.dart';
import 'package:core_erp/views/apps/provider-admin/vehicles.dart';
import 'package:core_erp/views/auth/forgot_password.dart';
import 'package:core_erp/views/auth/locked.dart';
import 'package:core_erp/views/auth/login.dart';
import 'package:core_erp/views/auth/register.dart';
import 'package:core_erp/views/auth/reset_password.dart';
import 'package:core_erp/views/dashboards/admin_dashboard.dart';
import 'package:core_erp/views/dashboards/providers_dashboard.dart';
import 'package:core_erp/views/faqs_page.dart';
import 'package:core_erp/views/forms/basic.dart';
import 'package:core_erp/views/forms/form_mask.dart';
import 'package:core_erp/views/forms/validation.dart';
import 'package:core_erp/views/forms/wizard.dart';
import 'package:core_erp/views/other/basic_table.dart';
import 'package:core_erp/views/other/google_map.dart';
import 'package:core_erp/views/other/syncfusion_charts.dart';
import 'package:core_erp/views/starter.dart';
import 'package:core_erp/views/pages/coming_soon_page.dart';
import 'package:core_erp/views/pages/error_404_cover.dart';
import 'package:core_erp/views/pages/error_offline_page.dart';
import 'package:core_erp/views/landing_page.dart';
import 'package:core_erp/views/ui/buttons.dart';
import 'package:core_erp/views/ui/cards.dart';
import 'package:core_erp/views/ui/carousels.dart';
import 'package:core_erp/views/ui/dialogs.dart';
import 'package:core_erp/views/apps/provider-admin/hr_analytics.dart';
import 'package:core_erp/views/ui/drag_drop.dart';
import 'package:core_erp/views/apps/files/file_manager_page.dart';
import 'package:core_erp/views/apps/files/file_upload_page.dart';
import 'package:core_erp/views/apps/ecommerce/invoice_page.dart';
import 'package:core_erp/views/other/leaflet_page.dart';
import 'package:core_erp/views/forms/html_editor_page.dart';
import 'package:core_erp/views/pages/maintenance%20_page.dart';

import 'package:core_erp/views/ui/notifications.dart';
import 'package:core_erp/views/apps/ecommerce/product_detail.dart';
import 'package:core_erp/views/pages/profile_page.dart';
import 'package:core_erp/views/apps/ecommerce/reviews_page.dart';
import 'package:core_erp/views/pages/success_page.dart';
import 'package:core_erp/views/ui/tabs.dart';
import 'package:flutter/material.dart';

import 'package:core_erp/views/other/pricing_page.dart';
import 'package:get/get.dart';

import 'package:core_erp/views/pages/error_404_basic_page.dart';
import 'package:core_erp/views/pages/error_404_alt_page.dart';
import 'package:core_erp/views/pages/error_500_page.dart';

import 'views/apps/provider-admin/employees.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return AuthService.isLoggedIn ? null : RouteSettings(name: '/auth/login');
    // return AuthService.isLoggedIn ? null : RouteSettings(name: '/auth/login');
  }
}

getPageRoute() {
  AuthService.getAuthUserAccountType();
  var routes = [
    GetPage(
        name: '/',
        page: () => AuthService.accountType != 'admin'
            ? ProviderDashboardPage()
            : AdminDashboardPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/provider-dashboard',
        page: () => ProviderDashboardPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/admin-dashboard',
        page: () => AdminDashboardPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/starter',
        page: () => StarterPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(name: '/faqs', page: () => FAQsPage()),
    GetPage(name: '/auth/login', page: () => LoginPage()),
    GetPage(
        name: '/auth/forgot_password',
        page: () => ForgotPasswordPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/auth/reset_password',
        page: () => ResetPasswordPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/auth/register',
        page: () => RegisterPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/pricing',
        page: () => PricingPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/auth/locked',
        page: () => LockedPage(),
        middlewares: [AuthMiddleware()]),

    ///========== Apps =================///
    ///Geza
    GetPage(
        name: '/beauty-styles',
        page: () => BeautyStylePage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/beauty-styles/add_beauty-style',
        page: () => AddBeautyStyle(),
        middlewares: [AuthMiddleware()]),
    // Beetroot
    GetPage(
        name: '/exhibits',
        page: () => ExhibitsPage(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/exhibits/add_exhibit_questionaire',
        page: () => AddExhibitQuestionaire(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/exhibits/add_exhibit',
        page: () => AddExhibit(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/exhibits/assign_exhibit_editing',
        page: () => AssignTask(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/apps/ecommerce/products',
        page: () => EcommerceProductsPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/apps/ecommerce/services',
        page: () => EcommerceProductsPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/apps/ecommerce/add_product',
        page: () => EditProduct(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/apps/ecommerce/customers',
        page: () => CustomersPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/apps/ecommerce/product-detail',
        page: () => ProductDetailPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/apps/ecommerce/product-reviews',
        page: () => ReviewsPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/apps/ecommerce/invoice',
        page: () => InvoicePage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/orders',
        page: () => OrdersPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/apps/ecommerce/add_order',
        page: () => EditProduct(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/apps/ecommerce/order-detail',
        page: () => OrderDetailPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/apps/chats',
        page: () => ChatsPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/apps/files',
        page: () => FileManagerPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/apps/files/upload',
        page: () => FileUploadPage(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/apps/hr/employees',
        page: () => Employees(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/hr_analytics',
        page: () => HRAnalytics(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/drivers_list',
        page: () => CustomersPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/add_new_employee',
        page: () => AddNewEmployee(),
        middlewares: [AuthMiddleware()]),
    //TRUCKS
    GetPage(
        name: '/trucks_list',
        page: () => OrdersPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/transporter/add_vehicle',
        page: () => AddTruck(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/transporter/allocate_vehicle',
        page: () => AllocateVehicle(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/assign_task',
        page: () => AssignTask(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/vehicles',
        page: () => VehiclesPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/apps/jobs/discover',
        page: () => Employees(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/apps/jobs/candidates',
        page: () => Employees(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/apps/jobs/vacancies',
        page: () => JobVacanciesPage(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/nft/dashboard',
        page: () => NFTDashboardPage(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/landing',
        page: () => LandingPage(),
        middlewares: [AuthMiddleware()]),

    ///========== UI =================///

    GetPage(
        name: '/ui/buttons',
        page: () => ButtonsPage(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/ui/cards',
        page: () => CardsPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/ui/tabs',
        page: () => TabsPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/ui/dialogs',
        page: () => DialogsPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/ui/carousels',
        page: () => CarouselsPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/ui/drag_drop',
        page: () => DragDropPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/ui/notifications',
        page: () => NotificationsPage(),
        middlewares: [AuthMiddleware()]),

    ///========== Forms =================///

    GetPage(
        name: '/forms/basic',
        page: () => BasicFormsPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/forms/validation',
        page: () => ValidationFormsPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/forms/html_editor',
        page: () => HtmlEditorPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/forms/wizard',
        page: () => WizardPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/forms/masks',
        page: () => FormMaskPage(),
        middlewares: [AuthMiddleware()]),

    ///========== Others =================///

    GetPage(
        name: '/other/basic_tables',
        page: () => BasicTablesPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/other/syncfusion_charts',
        page: () => SyncfusionChartsPage(),
        middlewares: [AuthMiddleware()]),

    ///========== Maps =================///

    GetPage(
        name: '/maps/google_maps',
        page: () => GoogleMapPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/maps/leaflet',
        page: () => LeafletPage(),
        middlewares: [AuthMiddleware()]),

    ///========== Pages =================///
    ///
    GetPage(
        name: '/pages/profile',
        page: () => ProfilePage(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/pages/success',
        page: () => SuccessPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/pages/coming-soon',
        page: () => ComingSoon(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/pages/error-404',
        page: () => Error404BasicPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/pages/error-404-alt',
        page: () => Error404AltPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/pages/error-404-cover',
        page: () => Error404CoverPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/pages/error-500',
        page: () => Error500Page(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/pages/offline',
        page: () => ErrorOfflinePage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/pages/maintenance',
        page: () => MaintenancePage(),
        middlewares: [AuthMiddleware()]),
  ];

  return routes
      .map((e) => GetPage(
          name: e.name,
          page: e.page,
          middlewares: e.middlewares,
          transition: Transition.noTransition))
      .toList();
}
