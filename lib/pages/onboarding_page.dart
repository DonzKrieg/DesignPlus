import 'package:designplus/shared/theme.dart';
import 'package:designplus/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int currentPage = 0;

  final List<String> images = [
    'assets/images/onboarding1.png',
    'assets/images/onboarding2.png',
    'assets/images/onboarding3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            onPageChanged: (index) {
              setState(() => currentPage = index);
            },
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(images[index], fit: BoxFit.cover),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0XFFd9d9d9).withOpacity(0.01),
                            Color(0XFFd9d9d9).withOpacity(0.8),
                            kWhiteColor,
                            kWhiteColor,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Designplus.",
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                      ),
                      Container(
                        width: 79,
                        height: 42,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: kGreyColor.withOpacity(0.2),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "ID",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: kBlackColor,
                              ),
                            ),
                            SizedBox(width: 16),
                            Image.asset(
                              'assets/images/flag_idn.png',
                              width: 26,
                              height: 26,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 40,
                    left: 30,
                    right: 30,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Solusi Cetak Profesional dan Terpercaya",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Lorem ipsum dolor sit amet consectetur adipiscing elit quisque faucibus ex sapien vitae pellentesque sem placerat in id cursus mi.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: kGreyColor, fontSize: 12),
                      ),
                      SizedBox(height: 37),
                      if (currentPage < images.length - 1) ...[
                        SmoothPageIndicator(
                          controller: _controller,
                          count: images.length,
                          effect: WormEffect(
                            activeDotColor: kPrimaryColor,
                            dotColor: kSecondaryColor,
                            dotHeight: 5,
                            dotWidth: 37,
                          ),
                        ),
                      ] else ...[
                        CustomButton(
                          text: 'Mulai Sekarang',
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          size: Size(double.infinity, 49),
                          color: kPrimaryColor,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
