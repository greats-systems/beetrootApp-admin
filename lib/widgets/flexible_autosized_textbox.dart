import 'package:auto_size_text/auto_size_text.dart';
import 'package:core_erp/extensions/extensions.dart';
import 'package:flutter/material.dart';

class FlexibleAutoSizedText extends StatelessWidget {
  final String _title;

  FlexibleAutoSizedText({
    super.key,
    required String title,
  }) : _title = title;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        width: 50.0,
        height: 20.0,
        child: AutoSizeText(
          maxLines: 1,
          _title.tr(),
        ),
      ),
    );
  }
}
