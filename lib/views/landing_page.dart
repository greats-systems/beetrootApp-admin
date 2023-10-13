import 'package:feather_icons/feather_icons.dart';
import 'package:get/get.dart';
import 'package:core_erp/controllers/landing_controller.dart';
import 'package:core_erp/images.dart';
import 'package:core_erp/services/theme/app_style.dart';
import 'package:core_erp/utils/mixins/ui_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin, UIMixin {
  late LandingController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(LandingController(this));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   bottom: TabBar(
      //     indicatorColor: Colors.yellow,
      //     controller: controller.defaultTabController,
      //     isScrollable: true,
      //     tabs: [
      //       Tab(
      //         icon: FxText.bodyMedium(
      //           "Home",
      //           fontWeight: controller.defaultIndex == 0 ? 600 : 500,
      //           color: controller.defaultIndex == 0 ? contentTheme.primary : null,
      //         ),
      //       ),
      //       Tab(
      //         icon: FxText.bodyMedium(
      //           "Feature",
      //           fontWeight: controller.defaultIndex == 1 ? 600 : 500,
      //           color: controller.defaultIndex == 1 ? contentTheme.primary : null,
      //         ),
      //       ),
      //       Tab(
      //         icon: FxText.bodyMedium(
      //           "ScreenShot",
      //           fontWeight: controller.defaultIndex == 2 ? 600 : 500,
      //           color: controller.defaultIndex == 2 ? contentTheme.primary : null,
      //         ),
      //       ),
      //       Tab(
      //         icon: FxText.bodyMedium(
      //           "Testimonial",
      //           fontWeight: controller.defaultIndex == 3 ? 600 : 500,
      //           color: controller.defaultIndex == 3 ? contentTheme.primary : null,
      //         ),
      //       ),
      //       Tab(
      //         icon: FxText.bodyMedium(
      //           "Pricing",
      //           fontWeight: controller.defaultIndex == 4 ? 600 : 500,
      //           color: controller.defaultIndex == 4 ? contentTheme.primary : null,
      //         ),
      //       ),
      //       Tab(
      //         icon: FxText.bodyMedium(
      //           "Contact Us",
      //           fontWeight: controller.defaultIndex == 5 ? 600 : 500,
      //           color: controller.defaultIndex == 5 ? contentTheme.primary : null,
      //         ),
      //       ),
      //     ],
      //     indicatorSize: TabBarIndicatorSize.tab,
      //   ),
      // ),
      body: SingleChildScrollView(
        child: GetBuilder(
          init: controller,
          builder: (controller) {
            return Stack(
              children: [
                Image.asset(
                  Images.landing[3],
                ),
                Column(
                  children: [
                    FxContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    Images.logoIcon,
                                    height: 84,
                                    fit: BoxFit.cover,
                                    color: contentTheme.primary,
                                  ),
                                  FxSpacing.width(8),
                                  Column(
                                    children: [
                                      FxSpacing.width(8),
                                      FxText.titleMedium(
                                        style: GoogleFonts.aleo(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 24,
                                            letterSpacing: 2,
                                            color: contentTheme.primary),
                                        "Geza Beauty",
                                        fontWeight: 600,
                                        fontSize: 24,
                                        letterSpacing: 2,
                                        color: contentTheme.primary,
                                      ),
                                      FxText.titleMedium(
                                        "Marketplace",
                                        fontWeight: 400,
                                        fontSize: 18,
                                        letterSpacing: 2,
                                        color: contentTheme.primary,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              FxSpacing.width(40),
                              TabBar(
                                indicatorColor: Colors.yellow,
                                controller: controller.defaultTabController,
                                isScrollable: true,
                                tabs: [
                                  Tab(
                                    icon: FxText.bodyMedium(
                                      "Home",
                                      fontWeight: controller.defaultIndex == 0
                                          ? 600
                                          : 500,
                                      color: controller.defaultIndex == 0
                                          ? contentTheme.primary
                                          : null,
                                    ),
                                  ),
                                  Tab(
                                    icon: FxText.bodyMedium(
                                      "Feature",
                                      fontWeight: controller.defaultIndex == 1
                                          ? 600
                                          : 500,
                                      color: controller.defaultIndex == 1
                                          ? contentTheme.primary
                                          : null,
                                    ),
                                  ),
                                  Tab(
                                    icon: FxText.bodyMedium(
                                      "ScreenShot",
                                      fontWeight: controller.defaultIndex == 2
                                          ? 600
                                          : 500,
                                      color: controller.defaultIndex == 2
                                          ? contentTheme.primary
                                          : null,
                                    ),
                                  ),
                                  Tab(
                                    icon: FxText.bodyMedium(
                                      "Testimonial",
                                      fontWeight: controller.defaultIndex == 3
                                          ? 600
                                          : 500,
                                      color: controller.defaultIndex == 3
                                          ? contentTheme.primary
                                          : null,
                                    ),
                                  ),
                                  Tab(
                                    icon: FxText.bodyMedium(
                                      "Pricing",
                                      fontWeight: controller.defaultIndex == 4
                                          ? 600
                                          : 500,
                                      color: controller.defaultIndex == 4
                                          ? contentTheme.primary
                                          : null,
                                    ),
                                  ),
                                  Tab(
                                    icon: FxText.bodyMedium(
                                      "Contact Us",
                                      fontWeight: controller.defaultIndex == 5
                                          ? 600
                                          : 500,
                                      color: controller.defaultIndex == 5
                                          ? contentTheme.primary
                                          : null,
                                    ),
                                  ),
                                ],
                                indicatorSize: TabBarIndicatorSize.tab,
                              ),
                              FxSpacing.width(40),
                              Row(
                                children: [
                                  FxButton(
                                    onPressed: () {
                                      Get.toNamed('/auth/login');
                                    },
                                    elevation: 0,
                                    padding: FxSpacing.xy(20, 16),
                                    backgroundColor: contentTheme.primary,
                                    borderRadiusAll:
                                        AppStyle.buttonRadius.medium,
                                    child: FxText.bodySmall(
                                      "LogIn",
                                      color: contentTheme.onPrimary,
                                    ),
                                  ),
                                  FxSpacing.width(8),
                                  FxButton(
                                    onPressed: () {
                                      Get.toNamed('/auth/register');
                                    },
                                    elevation: 0,
                                    padding: FxSpacing.xy(20, 16),
                                    backgroundColor: contentTheme.primary,
                                    borderRadiusAll:
                                        AppStyle.buttonRadius.medium,
                                    child: FxText.bodySmall(
                                      "Sign Up",
                                      color: contentTheme.onPrimary,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          FxSpacing.height(52),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Let's ",
                                  style: FxTextStyle.titleMedium(
                                    fontWeight: 600,
                                    fontSize: 44,
                                  ),
                                ),
                                TextSpan(
                                    text: 'Build Your Beauty Business',
                                    style: FxTextStyle.titleMedium(
                                        fontSize: 44,
                                        fontWeight: 600,
                                        color: contentTheme.primary)),
                                TextSpan(
                                  text: '\n With Geza Beauty Marketplace App.',
                                  style: FxTextStyle.titleMedium(
                                    fontWeight: 600,
                                    fontSize: 44,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          FxSpacing.height(40),
                          SizedBox(
                            width: 600,
                            child: FxText.bodySmall(
                              'Are you ready to transform the way you experience beauty business? Look no further than Geza Beauty Marketplace  – your all-in-one mobile app for everything beauty-related. Discover a world of stunning possibilities as we connect you with top-notch beauty products and services, all conveniently at your fingertips.',
                              textAlign: TextAlign.center,
                              maxLines: 5,
                              fontSize: 16,
                              fontWeight: 600,
                              muted: true,
                            ),
                          ),
                          FxSpacing.height(52),
                          FxButton(
                            onPressed: () {},
                            elevation: 0,
                            padding: FxSpacing.xy(20, 16),
                            backgroundColor: contentTheme.primary,
                            borderRadiusAll: AppStyle.buttonRadius.medium,
                            child: FxText.bodySmall(
                              "Let's Started",
                              color: contentTheme.onPrimary,
                            ),
                          ),
                          FxSpacing.height(100),
                          // Image.asset(
                          //   Images.landing[0],
                          // ),
                          FxSpacing.height(52),
                          buildLayoutTitle(
                            "How IT ",
                            "WORK",
                            "Why Choose Geza?",
                            "Whether you're looking to revamp your skincare regimen, book a pampering spa day, or simply explore the latest beauty trends, Geza is your ultimate companion on your beauty journey",
                          ),
                          FxSpacing.height(52),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            runSpacing: 16,
                            spacing: 32,
                            children: [
                              buildWork(Icons.list_outlined,
                                  "1.  Seamless Access to Beauty Services"),
                              buildWork(Icons.color_lens_outlined,
                                  "2.  Curated Product Selection"),
                              buildWork(Icons.layers_outlined,
                                  "3. Personalized Recommendations"),
                            ],
                          ),
                          FxSpacing.height(52),
                        ],
                      ),
                    ),
                    FxSpacing.height(40),
                    // Padding(
                    //   padding: FxSpacing.all(flexSpacing),
                    //   child: Column(
                    //     children: [
                    //       FxSpacing.height(52),
                    //       buildLayoutTitle(
                    //         "OUR ",
                    //         "FEATURES",
                    //         "Smart Solutions For Professional People",
                    //         controller.dummyTexts[2],
                    //       ),
                    //       FxSpacing.height(100),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Image.asset(
                    //             Images.landing[1],
                    //           ),
                    //           Expanded(
                    //             child: Column(
                    //               // mainAxisAlignment: MainAxisAlignment.center,
                    //               // crossAxisAlignment: CrossAxisAlignment.stretch,
                    //               children: [
                    //                 FxText.titleLarge(
                    //                   "Discover your destination",
                    //                   fontSize: 32,
                    //                   fontWeight: 600,
                    //                 ),
                    //                 FxSpacing.height(8),
                    //                 SizedBox(
                    //                   width: 300,
                    //                   child: Align(
                    //                     alignment: Alignment.center,
                    //                     child: FxText.bodySmall(
                    //                       controller.dummyTexts[3],
                    //                       maxLines: 2,
                    //                       letterSpacing: 2,
                    //                       muted: true,
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 FxSpacing.height(16),
                    //                 buildDiscoveryDestination(
                    //                   Icons.check_outlined,
                    //                   controller.dummyTexts[1],
                    //                 ),
                    //                 FxSpacing.height(16),
                    //                 buildDiscoveryDestination(
                    //                   Icons.layers_outlined,
                    //                   controller.dummyTexts[2],
                    //                 ),
                    //                 FxSpacing.height(16),
                    //                 buildDiscoveryDestination(
                    //                   Icons.lock_outline,
                    //                   controller.dummyTexts[2],
                    //                 ),
                    //               ],
                    //             ),
                    //           )
                    //         ],
                    //       ),
                    //       FxSpacing.height(flexSpacing),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Expanded(
                    //             child: Padding(
                    //               padding:
                    //                   FxSpacing.xy(flexSpacing, flexSpacing),
                    //               child: Column(
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: [
                    //                   FxText.titleLarge(
                    //                     "Connecting people, Places",
                    //                     fontSize: 32,
                    //                     fontWeight: 600,
                    //                   ),
                    //                   FxSpacing.height(8),
                    //                   SizedBox(
                    //                     width: 300,
                    //                     child: Align(
                    //                       alignment: Alignment.center,
                    //                       child: FxText.bodySmall(
                    //                         controller.dummyTexts[3],
                    //                         maxLines: 2,
                    //                         letterSpacing: 2,
                    //                         muted: true,
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   FxSpacing.height(16),
                    //                   buildDiscoveryDestination(
                    //                     Icons.check_outlined,
                    //                     controller.dummyTexts[1],
                    //                   ),
                    //                   FxSpacing.height(16),
                    //                   buildDiscoveryDestination(
                    //                     Icons.layers_outlined,
                    //                     controller.dummyTexts[2],
                    //                   ),
                    //                   FxSpacing.height(16),
                    //                   buildDiscoveryDestination(
                    //                     Icons.lock_outline,
                    //                     controller.dummyTexts[2],
                    //                   )
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //           Image.asset(
                    //             Images.landing[2],
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    FxContainer(
                      padding: FxSpacing.y(100),
                      width: double.infinity,
                      color: contentTheme.background,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.center,
                        runSpacing: 20,
                        spacing: 40,
                        children: [
                          buildContainer(
                              Icons.language_outlined, "452", "GLOBAL BRANDS"),
                          buildContainer(Icons.sentiment_satisfied_outlined,
                              "15000+", "HAPPY CLIENT"),
                          buildContainer(Icons.emoji_objects_outlined, "999+",
                              "CREATIVE IDEAS"),
                          buildContainer(
                              Icons.group_outlined, "5000+", "USER CLIENT"),
                        ],
                      ),
                    ),
                    FxSpacing.height(40),
                    // Padding(
                    //   padding: FxSpacing.all(flexSpacing),
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       FxSpacing.height(52),
                    //       buildLayoutTitle(
                    //         "OUR ",
                    //         "TESTIMONIAL",
                    //         "What Our Customers Say",
                    //         controller.dummyTexts[3],
                    //       ),
                    //       FxSpacing.height(52),
                    //       FxText.bodyMedium(
                    //         "“Taqueria earum us tenure sapiens deselect asperiores repellat.”",
                    //         muted: true,
                    //         fontWeight: 600,
                    //         textAlign: TextAlign.center,
                    //       ),
                    //       FxSpacing.height(8),
                    //       SizedBox(
                    //         width: 700,
                    //         child: Align(
                    //           alignment: Alignment.center,
                    //           child: FxText.bodySmall(
                    //             controller.dummyTexts[7],
                    //             maxLines: 3,
                    //             fontSize: 16,
                    //             fontWeight: 600,
                    //             muted: true,
                    //           ),
                    //         ),
                    //       ),
                    //       FxSpacing.height(40),
                    //       FxContainer.rounded(
                    //         paddingAll: 0,
                    //         height: 100,
                    //         width: 100,
                    //         child: Image.asset(
                    //           Images.avatars[5],
                    //         ),
                    //       ),
                    //       FxSpacing.height(16),
                    //       FxText.titleMedium(
                    //         "Donica Ainsley",
                    //         fontWeight: 600,
                    //       ),
                    //       FxText.titleMedium(
                    //         "Web Development, USA",
                    //         fontWeight: 600,
                    //         muted: true,
                    //       ),
                    //       FxSpacing.height(60),
                    //       Wrap(
                    //         spacing: 150,
                    //         runSpacing: 16,
                    //         children: [
                    //           Image.asset(
                    //             Images.brand[0],
                    //             width: 150,
                    //           ),
                    //           Image.asset(
                    //             Images.brand[1],
                    //             width: 150,
                    //           ),
                    //           Image.asset(
                    //             Images.brand[2],
                    //             width: 150,
                    //           ),
                    //           Image.asset(
                    //             Images.brand[3],
                    //             width: 150,
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // FxSpacing.height(40),
                    // FxContainer(
                    //   child: Column(
                    //     children: [
                    //       FxSpacing.height(52),
                    //       // buildLayoutTitle(
                    //       //   "OUR ",
                    //       //   "PRICING",
                    //       //   "Pricing Plan",
                    //       //   controller.dummyTexts[8],
                    //       // ),
                    //       Column(
                    //         children: [
                    //           RichText(
                    //             textAlign: TextAlign.center,
                    //             text: TextSpan(
                    //               children: [
                    //                 TextSpan(
                    //                   text: "OUR ",
                    //                   style: FxTextStyle.bodyMedium(
                    //                     fontSize: 22,
                    //                     muted: true,
                    //                   ),
                    //                 ),
                    //                 TextSpan(
                    //                   text: "PRICING",
                    //                   style: FxTextStyle.titleLarge(
                    //                     fontWeight: 600,
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),

                    //           // FxText.titleLarge(
                    //           //   subTitle,
                    //           //   fontSize: 26,
                    //           //   fontWeight: 600,
                    //           //   textAlign: TextAlign.center,
                    //           // ),
                    //           FxSpacing.height(16),
                    //           SizedBox(
                    //             width: 600,
                    //             child: Align(
                    //               child: FxText.bodySmall(
                    //                 controller.dummyTexts[5],
                    //                 textAlign: TextAlign.center,
                    //                 maxLines: 2,
                    //                 fontSize: 16,
                    //                 muted: true,
                    //               ),
                    //             ),
                    //           ),
                    //           FxSpacing.height(16),
                    //           FxText.titleLarge(
                    //             "Pricing Plan",
                    //             fontSize: 26,
                    //             fontWeight: 600,
                    //             textAlign: TextAlign.center,
                    //           ),
                    //         ],
                    //       ),
                    //       FxSpacing.height(40),
                    //       TabBar(
                    //         controller: controller.backgroundTabController,
                    //         isScrollable: true,

                    //         indicator: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(4),
                    //             color: contentTheme.primary),
                    //         tabs: [
                    //           Tab(
                    //             icon: FxText.bodyMedium(
                    //               "Monthly",
                    //               fontWeight: controller.backgroundIndex == 0
                    //                   ? 600
                    //                   : 500,
                    //               color: controller.backgroundIndex == 0
                    //                   ? contentTheme.onPrimary
                    //                   : null,
                    //             ),
                    //           ),
                    //           Tab(
                    //             icon: FxText.bodyMedium(
                    //               "Yearly",
                    //               fontWeight: controller.backgroundIndex == 1
                    //                   ? 600
                    //                   : 500,
                    //               color: controller.backgroundIndex == 1
                    //                   ? contentTheme.onPrimary
                    //                   : null,
                    //             ),
                    //           ),
                    //         ],
                    //         // controller: _tabController,
                    //         indicatorSize: TabBarIndicatorSize.tab,
                    //       ),
                    //       FxSpacing.height(16),
                    //       SizedBox(
                    //         height: 500,
                    //         child: TabBarView(
                    //           physics: FixedExtentScrollPhysics(),
                    //           controller: controller.backgroundTabController,
                    //           children: [
                    //             Wrap(
                    //               alignment: WrapAlignment.center,
                    //               spacing: 20,
                    //               runSpacing: 20,
                    //               children: [
                    //                 buildMonthlyPricing("Free", "\$00.0", "3",
                    //                     "600GB", "6", "/Month"),
                    //                 buildMonthlyPricing("Standard", "\$30.0",
                    //                     "15", "1TB", "10", "/Month"),
                    //                 buildMonthlyPricing("Enterprise", "\$60.0",
                    //                     "25", "3TB", "16", "/Month"),
                    //               ],
                    //             ),
                    //             Wrap(
                    //               alignment: WrapAlignment.center,
                    //               spacing: 20,
                    //               runSpacing: 20,
                    //               children: [
                    //                 buildMonthlyPricing("Free", "\$30.0", "13",
                    //                     "2TB", "12", "/Year"),
                    //                 buildMonthlyPricing("Standard", "\$55.0",
                    //                     "30", "8TB", "20", "/Year"),
                    //                 buildMonthlyPricing("Enterprise", "\$102.0",
                    //                     "50", "10TB", "35", "/Year"),
                    //               ],
                    //             ),
                    //           ],
                    //           // controller: _tabController,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // FxSpacing.height(40),
                    // Padding(
                    //   padding: FxSpacing.all(flexSpacing),
                    //   child: Column(
                    //     children: [
                    //       // FxSpacing.height(50),
                    //       buildLayoutTitle(
                    //         "OUR ",
                    //         "FAQs",
                    //         "Frequently Asked Questions",
                    //         controller.dummyTexts[5],
                    //       ),
                    //       FxSpacing.height(52),
                    //       Wrap(
                    //         runSpacing: 20,
                    //         spacing: 100,
                    //         children: [
                    //           Image.asset(
                    //             Images.landing[4],
                    //           ),
                    //           SizedBox(
                    //             width: 500,
                    //             child: Column(
                    //               children: [
                    //                 ExpansionPanelList.radio(
                    //                   expandedHeaderPadding: FxSpacing.zero,
                    //                   animationDuration:
                    //                       Duration(milliseconds: 600),
                    //                   children: controller.landing
                    //                       .mapIndexed(
                    //                         (index, data) =>
                    //                             ExpansionPanelRadio(
                    //                           value: data,
                    //                           canTapOnHeader: true,
                    //                           headerBuilder: (_, isExpanded) =>
                    //                               FxContainer(
                    //                             child: FxText.titleMedium(
                    //                                 data.title),
                    //                           ),
                    //                           body: FxContainer(
                    //                             child: FxText.titleMedium(
                    //                               controller.dummyTexts[2],
                    //                               maxLines: 3,
                    //                             ),
                    //                           ),
                    //                         ),
                    //                       )
                    //                       .toList(),
                    //                 )
                    //               ],
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    FxSpacing.height(40),
                    FxContainer(
                      padding: FxSpacing.y(68),
                      width: double.infinity,
                      child: Padding(
                        padding: FxSpacing.all(flexSpacing),
                        child: Column(
                          children: [
                            FxText.titleMedium(
                              "Available For Your\nSmartphone.",
                              textAlign: TextAlign.center,
                              fontWeight: 600,
                              fontSize: 40,
                            ),
                            FxSpacing.height(40),
                            SizedBox(
                              width: 600,
                              child: Align(
                                child: FxText.bodySmall(
                                  '',
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  letterSpacing: 2,
                                  muted: true,
                                ),
                              ),
                            ),
                            FxSpacing.height(40),
                            Wrap(
                              spacing: 20,
                              runSpacing: 20,
                              children: [
                                Image.asset(
                                  Images.brand[4],
                                ),
                                Image.asset(
                                  Images.brand[5],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    FxSpacing.height(40),
                    Padding(
                      padding: FxSpacing.all(flexSpacing),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildLayoutTitle(
                            "OUR ",
                            "CONTACT US",
                            "Get in Touch",
                            '',
                          ),
                          FxSpacing.height(52),
                          FxFlex(
                            children: [
                              FxFlexItem(
                                sizes: "lg-3 md-6",
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          Images.brand[6],
                                          height: 100,
                                        ),
                                        FxSpacing.width(16),
                                        FxText.titleLarge(
                                          "Say hello!",
                                          fontWeight: 600,
                                        ),
                                      ],
                                    ),
                                    FxSpacing.height(20),
                                    Row(
                                      children: [
                                        FxContainer.none(
                                          height: 40,
                                          width: 40,
                                          paddingAll: 0,
                                          color: contentTheme.primary
                                              .withOpacity(0.12),
                                          child: Center(
                                            child: Icon(
                                              Icons.mail_outline,
                                              size: 20,
                                              color: contentTheme.primary,
                                            ),
                                          ),
                                        ),
                                        FxSpacing.width(16),
                                        FxText.bodyMedium(
                                          "Email",
                                          fontSize: 20,
                                          fontWeight: 600,
                                        ),
                                      ],
                                    ),
                                    FxSpacing.height(20),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_right_alt_outlined,
                                        ),
                                        FxSpacing.width(8),
                                        FxText.bodyMedium("abc@gmail.com"),
                                      ],
                                    ),
                                    FxSpacing.height(20),
                                    Row(
                                      children: [
                                        FxContainer.none(
                                          height: 40,
                                          width: 40,
                                          paddingAll: 0,
                                          color: contentTheme.primary
                                              .withOpacity(0.12),
                                          child: Center(
                                            child: Icon(
                                              Icons.call_outlined,
                                              size: 20,
                                              color: contentTheme.primary,
                                            ),
                                          ),
                                        ),
                                        FxSpacing.width(16),
                                        FxText.bodyMedium(
                                          "Phone",
                                          fontSize: 20,
                                          fontWeight: 600,
                                        ),
                                      ],
                                    ),
                                    FxSpacing.height(20),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_right_alt_outlined,
                                        ),
                                        FxSpacing.width(8),
                                        FxText.bodyMedium("(+263) "),
                                      ],
                                    ),
                                    FxSpacing.height(20),
                                    Row(
                                      children: [
                                        FxContainer.none(
                                          height: 40,
                                          width: 40,
                                          paddingAll: 0,
                                          color: contentTheme.primary
                                              .withOpacity(0.12),
                                          child: Center(
                                            child: Icon(
                                              Icons.location_on_outlined,
                                              size: 20,
                                              color: contentTheme.primary,
                                            ),
                                          ),
                                        ),
                                        FxSpacing.width(16),
                                        FxText.bodyMedium(
                                          "Address",
                                          fontSize: 20,
                                          fontWeight: 600,
                                        ),
                                      ],
                                    ),
                                    FxSpacing.height(20),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_right_alt_outlined,
                                        ),
                                        FxSpacing.width(8),
                                        FxText.bodyMedium("Anguilla Office"),
                                      ],
                                    ),
                                    FxText.bodyMedium(
                                        "331 Maple Street, Harare"),
                                  ],
                                ),
                              ),
                              FxFlexItem(
                                sizes: "lg-4 md-6",
                                child: FxContainer(
                                  child: Column(
                                    children: [
                                      FxFlex(
                                        children: [
                                          FxFlexItem(
                                            sizes: "md-6 sm-12",
                                            child: buildTextField(
                                                'First Name', "Jim"),
                                          ),
                                          FxFlexItem(
                                            sizes: "md-6 sm-12",
                                            child: buildTextField(
                                                "Last Name", "Kuyu"),
                                          ),
                                        ],
                                      ),
                                      FxSpacing.height(20),
                                      FxFlex(
                                        children: [
                                          FxFlexItem(
                                            sizes: "md-6 sm-12",
                                            child: buildTextField(
                                                'Email Address',
                                                "info@core_erp.co.zw"),
                                          ),
                                          FxFlexItem(
                                            sizes: "md-6 sm-12",
                                            child: buildTextField(
                                                "Phone Number",
                                                "+263 123456789"),
                                          ),
                                        ],
                                      ),
                                      FxSpacing.height(20),
                                      FxFlex(
                                        children: [
                                          FxFlexItem(
                                            sizes: "md-12",
                                            child: buildTextField(
                                                "Subject", "Type Subject..."),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: FxSpacing.xy(12, 16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            FxText.bodyMedium(
                                              "Message",
                                              fontWeight: 600,
                                              muted: true,
                                            ),
                                            FxSpacing.height(8),
                                            TextFormField(
                                              keyboardType:
                                                  TextInputType.multiline,
                                              maxLines: 3,
                                              decoration: InputDecoration(
                                                hintText: "Write somethings...",
                                                hintStyle:
                                                    FxTextStyle.bodySmall(
                                                        xMuted: true),
                                                border: outlineInputBorder,
                                                enabledBorder:
                                                    outlineInputBorder,
                                                focusedBorder:
                                                    focusedInputBorder,
                                                contentPadding:
                                                    FxSpacing.all(16),
                                                isCollapsed: true,
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior.never,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: FxSpacing.x(12),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            FxButton(
                                              onPressed: () {},
                                              elevation: 0,
                                              padding: FxSpacing.xy(20, 16),
                                              backgroundColor:
                                                  contentTheme.primary,
                                              borderRadiusAll:
                                                  AppStyle.buttonRadius.medium,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    FeatherIcons.send,
                                                    size: 16,
                                                  ),
                                                  FxSpacing.width(8),
                                                  FxText.bodySmall(
                                                    'Send Message',
                                                    color:
                                                        contentTheme.onPrimary,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    FxSpacing.height(40),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        FxContainer.none(
                          padding: FxSpacing.y(52),
                          width: double.infinity,
                          color: contentTheme.dark,
                          child: Image.asset(
                            Images.brand[7],
                            height: 300,
                          ),
                        ),
                        Wrap(
                          spacing: 60,
                          runSpacing: 32,
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          children: [
                            SizedBox(
                              width: 280,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        Images.logoIcon,
                                        height: 84,
                                        fit: BoxFit.cover,
                                        color: contentTheme.onPrimary,
                                      ),
                                      FxSpacing.width(8),
                                      FxText.titleMedium(
                                        "Marketplace",
                                        fontWeight: 600,
                                        fontSize: 24,
                                        letterSpacing: 2,
                                        color: contentTheme.onPrimary,
                                      ),
                                    ],
                                  ),
                                  FxSpacing.height(16),
                                  FxText.bodyMedium(
                                    "example@core_erp.io",
                                    color: contentTheme.onPrimary,
                                  ),
                                  FxText.bodyMedium(
                                    "(+263) 1234 5678 00",
                                    color: contentTheme.onPrimary,
                                  ),
                                  FxSpacing.height(20),
                                  FxText.bodyMedium(
                                    "Follow Us On",
                                    fontWeight: 600,
                                    color: contentTheme.onPrimary,
                                  ),
                                  FxSpacing.height(16),
                                  Row(
                                    children: [
                                      buildSocialLogo(Icons.facebook_outlined),
                                      FxSpacing.width(8),
                                      buildSocialLogo(FeatherIcons.twitter),
                                      FxSpacing.width(8),
                                      buildSocialLogo(FeatherIcons.linkedin),
                                      FxSpacing.width(8),
                                      buildSocialLogo(Icons.duo_outlined),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildFooter(
                                  "About Us",
                                  "Support Center",
                                  "Customer Support",
                                  "About Us",
                                  "Copyright",
                                  "Popular Campaign",
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildFooter(
                                  "Our Information",
                                  "Return Policy",
                                  "Privacy Policy",
                                  "Terms & Conditions",
                                  "Site Map",
                                  "Store Hours",
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildFooter(
                                  "My Account",
                                  "Press Inquiries",
                                  "Social Media Directories",
                                  "Images & B-roll",
                                  "Permissions",
                                  "Speaker Requests",
                                ),
                              ],
                            ),
                            // Column(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     buildFooter(
                            //       "Policy",
                            //       "Application Security",
                            //       "Software Principles",
                            //       "Unwanted Software",
                            //       "Responsible Supply Chain",
                            //       "Speaker Requests",
                            //     ),
                            //   ],
                            // ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildWork(IconData icons, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FxContainer.rounded(
          height: 80,
          width: 80,
          paddingAll: 0,
          color: contentTheme.primary.withOpacity(0.12),
          child: Center(
              child: Icon(
            icons,
            color: contentTheme.primary,
            size: 40,
          )),
        ),
        FxSpacing.height(16),
        FxText.bodyMedium(
          title,
          fontSize: 20,
          fontWeight: 600,
        ),
        FxSpacing.height(8),
        SizedBox(
          width: 280,
          child: Align(
            alignment: Alignment.center,
            child: FxText.bodyMedium(
              controller.dummyTexts[1],
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
        )
      ],
    );
  }

  Widget buildDiscoveryDestination(IconData icons, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FxContainer.rounded(
          height: 32,
          width: 32,
          paddingAll: 0,
          color: contentTheme.primary.withOpacity(0.12),
          child: Center(
            child: Icon(
              icons,
              size: 16,
              color: contentTheme.primary,
            ),
          ),
        ),
        FxSpacing.width(16),
        Expanded(
          child: FxText.bodySmall(
            description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget buildContainer(IconData icons, String number, String text) {
    return FxContainer.bordered(
      padding: FxSpacing.xy(24, 16),
      height: 100,
      width: 250,
      color: contentTheme.primary.withAlpha(30),
      child: Row(
        children: [
          Icon(
            icons,
            size: 36,
            color: contentTheme.primary,
          ),
          FxSpacing.width(8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FxText.bodyMedium(
                number,
                fontSize: 26,
                fontWeight: 600,
                color: contentTheme.primary,
              ),
              FxText.bodyMedium(
                text,
                fontSize: 16,
                color: contentTheme.primary,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildLayoutTitle(
      String title1, String title2, String subTitle, String dummyText) {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: title1,
                style: FxTextStyle.bodyMedium(
                  fontSize: 22,
                  muted: true,
                ),
              ),
              TextSpan(
                text: title2,
                style: FxTextStyle.titleLarge(
                  fontWeight: 600,
                ),
              ),
            ],
          ),
        ),
        // FxSpacing.height(16),
        FxText.titleLarge(
          subTitle,
          fontSize: 26,
          fontWeight: 600,
          textAlign: TextAlign.center,
        ),
        FxSpacing.height(32),
        SizedBox(
          width: 600,
          child: Align(
            child: FxText.bodySmall(
              dummyText,
              textAlign: TextAlign.center,
              maxLines: 3,
              fontSize: 16,
              muted: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildMonthlyPricing(
      String monthlyPremiumType,
      String monthlyPremiumPrice,
      String project,
      String storage,
      String domain,
      String selectMonth) {
    return FxContainer.bordered(
      height: 450,
      width: 350,
      child: Column(
        children: [
          FxContainer(
            width: 300,
            color: contentTheme.primary.withAlpha(20),
            child: Column(
              children: [
                FxText.bodyMedium(
                  monthlyPremiumType,
                  fontSize: 20,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: monthlyPremiumPrice,
                        style: FxTextStyle.bodyMedium(
                          fontWeight: 600,
                          fontSize: 32,
                          color: contentTheme.primary,
                        ),
                      ),
                      TextSpan(
                        text: selectMonth,
                        style: FxTextStyle.titleMedium(
                          // fontSize: 44,
                          fontWeight: 600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          FxSpacing.height(32),
          Row(
            children: [
              Icon(
                Icons.check_outlined,
              ),
              FxSpacing.width(8),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: project,
                      style: FxTextStyle.bodyLarge(fontWeight: 600),
                    ),
                    TextSpan(
                        text: " Project",
                        style: FxTextStyle.bodyMedium(muted: true)),
                  ],
                ),
              ),
            ],
          ),
          FxSpacing.height(16),
          Row(
            children: [
              Icon(
                Icons.check_outlined,
              ),
              FxSpacing.width(8),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: storage,
                      style: FxTextStyle.bodyLarge(fontWeight: 600),
                    ),
                    TextSpan(
                        text: " Storage",
                        style: FxTextStyle.bodyMedium(muted: true)),
                  ],
                ),
              ),
            ],
          ),
          FxSpacing.height(16),
          Row(
            children: [
              Icon(
                Icons.check_outlined,
              ),
              FxSpacing.width(8),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Unlimited ",
                      style: FxTextStyle.bodyLarge(fontWeight: 600),
                    ),
                    TextSpan(
                        text: "Contacts",
                        style: FxTextStyle.bodyMedium(muted: true)),
                  ],
                ),
              ),
            ],
          ),
          FxSpacing.height(16),
          Row(
            children: [
              Icon(
                Icons.check_outlined,
              ),
              FxSpacing.width(8),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: domain,
                      style: FxTextStyle.bodyLarge(fontWeight: 600),
                    ),
                    TextSpan(
                        text: " Domains",
                        style: FxTextStyle.bodyMedium(muted: true)),
                  ],
                ),
              ),
            ],
          ),
          FxSpacing.height(16),
          Row(
            children: [
              Icon(
                Icons.check_outlined,
              ),
              FxSpacing.width(8),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Free Support ",
                      style: FxTextStyle.bodyMedium(
                        muted: true,
                      ),
                    ),
                    TextSpan(
                        text: "24/7",
                        style: FxTextStyle.bodyLarge(
                          fontWeight: 600,
                        )),
                  ],
                ),
              ),
            ],
          ),
          FxSpacing.height(36),
          FxButton(
            onPressed: () {},
            elevation: 0,
            padding: FxSpacing.xy(20, 16),
            backgroundColor: contentTheme.primary,
            borderRadiusAll: AppStyle.buttonRadius.medium,
            child: FxText.bodySmall(
              "Choose Plan",
              color: contentTheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String fieldTitle, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FxText.labelMedium(
          fieldTitle,
        ),
        FxSpacing.height(8),
        TextFormField(
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: FxTextStyle.bodySmall(xMuted: true),
            border: outlineInputBorder,
            contentPadding: FxSpacing.all(16),
            isCollapsed: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
        ),
      ],
    );
  }

  Widget buildFooter(
    String footerTitle,
    String footerItem1,
    String footerItem2,
    String footerItem3,
    String footerItem4,
    String footerItem5,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FxText.titleLarge(
          footerTitle,
          fontWeight: 600,
          color: contentTheme.onPrimary,
        ),
        FxSpacing.height(8),
        FxText.bodyMedium(
          footerItem1,
          muted: true,
          color: contentTheme.onPrimary,
        ),
        FxSpacing.height(8),
        FxText.bodyMedium(
          footerItem2,
          muted: true,
          color: contentTheme.onPrimary,
        ),
        FxSpacing.height(8),
        FxText.bodyMedium(
          footerItem3,
          muted: true,
          color: contentTheme.onPrimary,
        ),
        FxSpacing.height(8),
        FxText.bodyMedium(
          footerItem4,
          muted: true,
          color: contentTheme.onPrimary,
        ),
        FxSpacing.height(8),
        FxText.bodyMedium(
          footerItem5,
          muted: true,
          color: contentTheme.onPrimary,
        ),
      ],
    );
  }

  Widget buildSocialLogo(IconData icons) {
    return FxContainer.none(
      height: 32,
      width: 32,
      alignment: Alignment.center,
      color: contentTheme.onPrimary.withAlpha(40),
      child: Icon(
        icons,
        color: contentTheme.onPrimary,
        size: 20,
      ),
    );
  }
}
