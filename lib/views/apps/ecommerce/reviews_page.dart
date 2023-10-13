import 'package:core_erp/app_constant.dart';
import 'package:core_erp/controllers/apps/ecommerce/reviews_controller.dart';
import 'package:core_erp/models/reviews.dart';
import 'package:core_erp/services/theme/app_style.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:core_erp/utils/utils.dart';
import 'package:core_erp/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({Key? key}) : super(key: key);

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late ReviewsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ReviewsController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: FxSpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FxText.titleMedium(
                      "Reviews",
                      fontWeight: 600,
                      fontSize: 18,
                    ),
                    FxBreadcrumb(
                      children: [
                        FxBreadcrumbItem(name: "UI"),
                        FxBreadcrumbItem(name: "Reviews", active: true),
                      ],
                    ),
                  ],
                ),
              ),
              FxSpacing.height(flexSpacing),
              Padding(
                padding: FxSpacing.x(flexSpacing),
                child: FxResponsive(builder: (_, __, type) {
                  return Padding(
                    padding: FxSpacing.x((type == FxScreenMediaType.xl ||
                            type == FxScreenMediaType.xxl)
                        ? 150
                        : type == FxScreenMediaType.lg
                            ? 100
                            : 0),
                    child: Column(
                      children: [
                        FxFlex(
                          contentPadding: false,
                          children: [
                            FxFlexItem(
                              sizes: "lg-4",
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FxText.bodySmall(
                                    "Total Reviews",
                                    fontWeight: 600,
                                  ),
                                  FxSpacing.height(12),
                                  Row(
                                    children: [
                                      FxText.bodyLarge(
                                        "25.0k",
                                        fontSize: 24,
                                        fontWeight: 600,
                                      ),
                                      FxSpacing.width(8),
                                      FxContainer(
                                        color:
                                            contentTheme.primary.withAlpha(20),
                                        padding: FxSpacing.xy(8, 4),
                                        borderRadiusAll: 100,
                                        child: Row(
                                          children: [
                                            FxText.titleSmall(
                                              "21%",
                                              fontSize: 12,
                                              color: contentTheme.primary,
                                            ),
                                            Icon(
                                              Icons.moving_outlined,
                                              color: contentTheme.primary,
                                              size: 12,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  FxSpacing.height(12),
                                  FxText.bodySmall(
                                    "Growth in reviews on this year",
                                    muted: true,
                                    fontSize: 12,
                                  ),
                                ],
                              ),
                            ),
                            FxFlexItem(
                              sizes: "lg-4",
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FxText.bodySmall(
                                    "Average Reviews",
                                    fontWeight: 600,
                                  ),
                                  FxSpacing.height(12),
                                  Row(
                                    children: [
                                      FxText.bodyLarge(
                                        "4.5",
                                        fontSize: 24,
                                        fontWeight: 600,
                                      ),
                                      FxSpacing.width(8),
                                      FxStarRating(
                                        rating: 4.5,
                                        size: 20,
                                        activeColor: AppColors.star,
                                      ), // buildReviewStar(),
                                    ],
                                  ),
                                  FxSpacing.height(12),
                                  FxText.bodySmall(
                                    "Average Rating on This year",
                                    muted: true,
                                    fontSize: 12,
                                  ),
                                ],
                              ),
                            ),
                            FxFlexItem(
                              sizes: "lg-4",
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildReviewRatingChart(
                                      "5", 150, contentTheme.primary, "5.0k"),
                                  buildReviewRatingChart(
                                      "4", 120, contentTheme.title, "3.0k"),
                                  buildReviewRatingChart(
                                      "3", 90, contentTheme.warning, "400"),
                                  buildReviewRatingChart(
                                      "2", 15, contentTheme.success, "100"),
                                  buildReviewRatingChart(
                                      "1", 25, contentTheme.info, "4k"),
                                ],
                              ),
                            ),
                          ],
                        ),
                        FxSpacing.height(16),
                        Divider(),
                        FxSpacing.height(8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FxButton.outlined(
                              onPressed: () {
                                controller.pickDateRange();
                              },
                              borderColor: contentTheme.primary,
                              padding: FxSpacing.xy(16, 16),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(
                                    Icons.calendar_month_outlined,
                                    color: contentTheme.primary,
                                    size: 16,
                                  ),
                                  FxSpacing.width(10),
                                  FxText.labelMedium(
                                      controller.selectedDateTimeRange != null
                                          ? "${dateFormatter.format(controller.selectedDateTimeRange!.start)} - ${dateFormatter.format(controller.selectedDateTimeRange!.end)}"
                                          : "Date Between",
                                      fontWeight: 600,
                                      color: contentTheme.primary),
                                ],
                              ),
                            ),
                          ],
                        ),
                        FxSpacing.height(8),
                        SizedBox(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: controller.reviews.length,
                            itemBuilder: (context, index) {
                              return ReviewWidget(
                                review: controller.reviews[index],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider(
                                height: 36,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildReviewRatingChart(
      String number, double width, Color color, String ratingNumber) {
    return Row(
      children: [
        Icon(
          Icons.star,
          size: 16,
          color: contentTheme.onBackground.withAlpha(64),
        ),
        FxSpacing.width(8),
        FxText.bodyMedium(
          number,
          fontSize: 12,
        ),
        FxSpacing.width(8),
        FxContainer.none(
          width: width,
          paddingAll: 4,
          borderRadiusAll: 12,
          color: color,
        ),
        FxSpacing.width(8),
        FxText.titleMedium(
          ratingNumber,
          fontSize: 12,
        ),
      ],
    );
  }

  Widget buildButtons(String buttonText) {
    return FxButton.outlined(
      onPressed: () {},
      elevation: 0,
      padding: FxSpacing.xy(20, 16),
      borderColor: contentTheme.primary,
      splashColor: contentTheme.primary.withOpacity(0.1),
      borderRadiusAll: AppStyle.buttonRadius.medium,
      child: FxText.bodySmall(
        buttonText,
        color: contentTheme.primary,
      ),
    );
  }
}

class ReviewWidget extends StatefulWidget {
  final Review review;

  const ReviewWidget({required this.review, Key? key}) : super(key: key);

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> with UIMixin {
  late Review review;
  bool isLiked = false;
  int initialRating = -1;

  @override
  void initState() {
    super.initState();
    review = widget.review;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            FxContainer(
              paddingAll: 0,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.asset(
                review.image,
                height: 58,
                fit: BoxFit.cover,
              ),
            ),
            FxSpacing.width(16),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FxText.titleMedium(
                  review.name,
                  fontWeight: 600,
                  overflow: TextOverflow.ellipsis,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: 'Total Spend: ',
                          style: FxTextStyle.bodySmall()),
                      TextSpan(
                        text: "\$${review.totalSpend}",
                        style: FxTextStyle.bodyMedium(
                          fontWeight: 600,
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Total Review: ',
                        style: FxTextStyle.bodySmall(),
                      ),
                      TextSpan(
                        text: "${review.totalReview}",
                        style: FxTextStyle.bodyMedium(
                          fontWeight: 600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        FxSpacing.height(12),
        Row(
          children: [
            buildReviewStar(),
            FxSpacing.width(12),
            FxText.bodyMedium(
              '${Utils.getDateStringFromDateTime(review.date)}',
            ),
          ],
        ),
        FxSpacing.height(12),
        FxText.bodySmall(review.comment),
        FxSpacing.height(12),
        Row(
          children: [
            buildButtons("Public Comment"),
            FxSpacing.width(16),
            buildButtons("Direct Message"),
            FxSpacing.width(16),
            IconButton(
              onPressed: () {
                setState(() {
                  isLiked = !isLiked;
                });
              },
              icon: Icon(!isLiked ? Icons.favorite_outline : Icons.favorite,
                  size: 24, color: contentTheme.primary),
            ),
          ],
        )
      ],
    );
  }

  Widget buildReviewStar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < 5; i++)
          GestureDetector(
            onTap: () {
              setState(() {
                initialRating = i;
              });
            },
            child: i <= initialRating
                ? Icon(
                    Icons.star,
                    color: AppColors.star,
                  )
                : Icon(
                    Icons.star_outline,
                    color: AppColors.star,
                  ),
          ),
      ],
    );
  }

  Widget buildButtons(String buttonText) {
    return FxButton.outlined(
      onPressed: () {},
      elevation: 0,
      padding: FxSpacing.xy(20, 16),
      borderColor: contentTheme.primary,
      splashColor: contentTheme.primary.withOpacity(0.1),
      borderRadiusAll: AppStyle.buttonRadius.medium,
      child: FxText.bodySmall(
        buttonText,
        color: contentTheme.primary,
      ),
    );
  }
}
