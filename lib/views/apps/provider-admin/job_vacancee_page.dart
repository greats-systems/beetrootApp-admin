import 'package:feather_icons/feather_icons.dart';
import 'package:core_erp/controllers/apps/provider-admin/job_vacancee_controller.dart';
import 'package:core_erp/models/job_vacancee.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:core_erp/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class JobVacanciesPage extends StatefulWidget {
  const JobVacanciesPage({Key? key}) : super(key: key);

  @override
  State<JobVacanciesPage> createState() => _JobVacanciesPageState();
}

class _JobVacanciesPageState extends State<JobVacanciesPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late JobVacanceeController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(JobVacanceeController());
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
                      "Job Vacancee",
                      fontWeight: 600,
                      fontSize: 18,
                    ),
                    FxBreadcrumb(
                      children: [
                        FxBreadcrumbItem(name: "UI"),
                        FxBreadcrumbItem(name: "Job Vacancee", active: true),
                      ],
                    ),
                  ],
                ),
              ),
              FxSpacing.height(flexSpacing),
              Padding(
                padding: FxSpacing.x(flexSpacing),
                child: FxFlex(
                  children: [
                    FxFlexItem(
                      sizes: "lg-4",
                      child: FxContainer.none(
                        paddingAll: 16,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FxText.labelLarge(
                                  "Filter",
                                  fontSize: 16,
                                ),
                                FxButton.outlined(
                                  onPressed: () {},
                                  elevation: 0,
                                  padding: FxSpacing.xy(20, 16),
                                  borderColor: contentTheme.primary,
                                  splashColor:
                                      contentTheme.primary.withOpacity(0.1),
                                  borderRadiusAll: 20,
                                  child: FxText.bodySmall(
                                    'Reset',
                                    color: contentTheme.primary,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 24,
                            ),
                            ExpansionTile(
                              childrenPadding: FxSpacing.y(16),
                              tilePadding: FxSpacing.zero,
                              title: Row(
                                children: [
                                  FxText.labelLarge(
                                    "Salary Range",
                                  ),
                                ],
                              ),
                              children: [
                                RangeSlider(
                                  values: controller.rangeSlider,
                                  min: 0,
                                  max: 100,
                                  divisions: 10,
                                  labels: RangeLabels(
                                      controller.rangeSlider.start
                                          .floor()
                                          .toString(),
                                      controller.rangeSlider.end
                                          .floor()
                                          .toString()),
                                  onChanged: controller.onChangeRangeSlider,
                                  activeColor:
                                      theme.sliderTheme.activeTrackColor,
                                  inactiveColor:
                                      theme.sliderTheme.inactiveTrackColor,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FxContainer.bordered(
                                      width: 100,
                                      child: FxText.titleMedium(
                                          "Min. ${controller.rangeSlider.start}"),
                                    ),
                                    FxContainer.bordered(
                                      width: 100,
                                      child: FxText.titleMedium(
                                          "Max. ${controller.rangeSlider.end}"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            FxSpacing.height(16),
                            ExpansionTile(
                              childrenPadding: FxSpacing.zero,
                              tilePadding: FxSpacing.zero,
                              title: Row(
                                children: [
                                  FxText.labelLarge("JobType"),
                                ],
                              ),
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: controller.jobType.length,
                                  itemBuilder: (context, index) {
                                    return CheckboxListTile(
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      title: Text(
                                          '${controller.jobType[index].name}'),
                                      value:
                                          controller.jobType[index].isChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          controller.jobType[index].isChecked =
                                              value!;
                                        });
                                      },
                                    );
                                  },
                                )
                              ],
                            ),
                            FxSpacing.height(16),
                            Row(
                              children: [
                                Expanded(
                                  child: FxText.labelLarge(
                                    "Open to remote",
                                  ),
                                ),
                                Switch(
                                  value: controller.isSwitch,
                                  onChanged: (value) {
                                    setState(() {
                                      controller.isSwitch = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            FxSpacing.height(16),
                            ExpansionTile(
                              childrenPadding: FxSpacing.zero,
                              tilePadding: FxSpacing.zero,
                              title: Row(
                                children: [
                                  FxText.labelLarge(
                                    "Job Categories",
                                  ),
                                ],
                              ),
                              children: [
                                TextFormField(
                                  maxLines: 1,
                                  style: FxTextStyle.bodyMedium(),
                                  decoration: InputDecoration(
                                      hintText: "search",
                                      hintStyle:
                                          FxTextStyle.bodySmall(xMuted: true),
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
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: controller.jobCategories.length,
                                  itemBuilder: (context, index) {
                                    return CheckboxListTile(
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      title: Text(
                                          '${controller.jobCategories[index].name}'),
                                      value: controller
                                          .jobCategories[index].isChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          controller.jobCategories[index]
                                              .isChecked = value!;
                                        });
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                            FxSpacing.height(16),
                            ExpansionTile(
                              childrenPadding: FxSpacing.zero,
                              tilePadding: FxSpacing.zero,
                              title: Row(
                                children: [
                                  FxText.labelLarge(
                                    "Experience",
                                  ),
                                ],
                              ),
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: controller.jobExperience.length,
                                  itemBuilder: (context, index) {
                                    return CheckboxListTile(
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      title: Text(
                                          '${controller.jobExperience[index].name}'),
                                      value: controller
                                          .jobExperience[index].isChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          controller.jobExperience[index]
                                              .isChecked = value!;
                                        });
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    FxFlexItem(
                      sizes: "lg-8",
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 350,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          mainAxisExtent: 230,
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        itemCount: controller.jobVacancee.length,
                        itemBuilder: (BuildContext context, int index) {
                          return JobVacanceeWidget(
                            jobVacancee: controller.jobVacancee[index],
                          );
                        },
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
}

class JobVacanceeWidget extends StatefulWidget {
  final JobVacancee jobVacancee;

  const JobVacanceeWidget({
    required this.jobVacancee,
    Key? key,
  }) : super(key: key);

  @override
  State<JobVacanceeWidget> createState() => _JobVacanceeWidgetState();
}

class _JobVacanceeWidgetState extends State<JobVacanceeWidget> with UIMixin {
  late JobVacancee jobVacancee;
  bool isSave = false;

  @override
  void initState() {
    super.initState();
    jobVacancee = widget.jobVacancee;
  }

  @override
  Widget build(BuildContext context) {
    return FxContainer.none(
      paddingAll: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              FxContainer.none(
                borderRadiusAll: 22,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.asset(
                  jobVacancee.image,
                  height: 44,
                  width: 44,
                  fit: BoxFit.cover,
                ),
              ),
              FxSpacing.width(12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FxText.bodyMedium(
                      jobVacancee.companyName,
                      fontSize: 16,
                    ),
                    FxText.bodySmall(
                      jobVacancee.appName,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isSave = !isSave;
                      });
                    },
                    icon: Icon(
                        !isSave
                            ? Icons.bookmark_outline
                            : Icons.bookmark_outlined,
                        size: 24,
                        color: contentTheme.primary),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 20,
              ),
              FxSpacing.width(8),
              FxText.bodyMedium(
                jobVacancee.location,
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.business_center_outlined,
                size: 20,
              ),
              FxSpacing.width(8),
              FxText.bodyMedium(
                "${jobVacancee.years} Years",
                overflow: TextOverflow.ellipsis,
              ),
              FxSpacing.width(16),
              Icon(
                Icons.monetization_on_outlined,
                size: 20,
              ),
              FxSpacing.width(8),
              FxText.bodyMedium(
                "\$${jobVacancee.amount} - \$${jobVacancee.amount}",
              ),
            ],
          ),
          FxProgressBar(
            width: 300,
            progress: jobVacancee.progress,
            height: 3,
            radius: 4,
            inactiveColor: theme.dividerColor,
            activeColor: colorScheme.primary,
          ),
          Row(
            children: [
              Expanded(
                child: FxText.bodyMedium(
                  "6 of 15 Filled",
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              FxText.bodyMedium(
                "Upload ${jobVacancee.years} Hours ago",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
