import 'package:flutter/material.dart';
import '../../models/package_data.dart';
import 'package_card.dart';

class PackageCarousel extends StatefulWidget {
  const PackageCarousel({super.key});

  @override
  State<PackageCarousel> createState() => _PackageCarouselState();
}

class _PackageCarouselState extends State<PackageCarousel> {
  late final PageController _pageController;
  int _currentPage = 0; // Initial page (Gói Đồng)

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentPage,
      viewportFraction: 0.85, // Shows edges of adjacent cards
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 580, // Reduced to bring dots closer
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemCount: PackageData.packages.length,
            itemBuilder: (context, index) {
              final package = PackageData.packages[index];
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value = 1.0;
                  if (_pageController.position.haveDimensions) {
                    value = _pageController.page! - index;
                    value = (1 - (value.abs() * 0.2)).clamp(0.8, 1.0);
                  } else {
                    // Fallback before layout
                    value = index == _currentPage ? 1.0 : 0.8;
                  }
                  return Center(
                    child: SizedBox(
                      height: Curves.easeOut.transform(value) * 544,
                      width: Curves.easeOut.transform(value) * 350,
                      child: child,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                  ), // Top margin for icon overflow
                  child: PackageCard(
                    package: package,
                    isActive: index == _currentPage,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 0),
        // Pagination dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            PackageData.packages.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 6,
              width: index == _currentPage ? 24 : 6,
              decoration: BoxDecoration(
                color: index == _currentPage
                    ? const Color(0xFFBB8A0B)
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
