import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:core_erp/controllers/apps/ecommerce/edit_products_controller.dart';
import 'package:core_erp/controllers/apps/provider-admin/provider-admin_controller.dart';
import 'package:core_erp/controllers/pages/profile_controller.dart';
import 'package:core_erp/extensions/string.dart';
import 'package:core_erp/images.dart';
import 'package:core_erp/models/locations.dart';
import 'package:core_erp/services/theme/app_style.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:core_erp/utils/utils.dart';
import 'package:core_erp/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:image_picker/image_picker.dart';
import '../../../controllers/apps/files/file_upload_controller.dart';

class DynamicWidget extends StatefulWidget {
  const DynamicWidget({super.key});

  @override
  State<DynamicWidget> createState() => _DynamicWidgetState();
}

class _DynamicWidgetState extends State<DynamicWidget>
    with SingleTickerProviderStateMixin, UIMixin {
  late ProviderAdminController providerAdminController;
  late FileUploadController fileUploadController;
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: new EdgeInsets.all(8.0),
      child: new TextField(
        controller: controller,
        decoration: new InputDecoration(hintText: 'Enter Data '),
      ),
    );
  }
}
