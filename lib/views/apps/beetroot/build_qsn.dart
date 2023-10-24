import 'package:core_erp/models/beetroot/questionnaire.dart';
import 'package:core_erp/services/theme/admin_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:flutx/utils/spacing.dart';
import 'package:flutx/widgets/container/container.dart';

class BuildFAQItemWidget extends StatefulWidget {
  Question question;
  BuildFAQItemWidget({super.key, required this.question});

  @override
  State<BuildFAQItemWidget> createState() => _BuildFAQItemWidgetState();
}

class _BuildFAQItemWidgetState extends State<BuildFAQItemWidget> {
  ContentTheme get contentTheme => AdminTheme.theme.contentTheme;

  @override
  Widget build(BuildContext context) {
    return buildFAQItem(widget.question);
  }

  Widget buildFAQItem(Question question) {
    //  String description
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FxContainer.rounded(
          height: 30,
          width: 30,
          paddingAll: 0,
          color: contentTheme.primary.withOpacity(0.12),
          child: Center(
            child: FxText(
              'Q',
              color: contentTheme.primary,
              fontWeight: 600,
            ),
          ),
        ),
        FxSpacing.width(16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FxText.labelLarge(
                question.question!,
              ),
              FxSpacing.height(4),
              // FxText.bodySmall(
              //   description,
              //   maxLines: 2,
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
