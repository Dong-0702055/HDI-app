import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../models/insurance_data.dart';
import 'dots_tooltip.dart';

class InfoCard extends StatefulWidget {
  const InfoCard({super.key});

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  int _activeIndex = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _activeIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _activeIndex = index;
                });
              },
              itemCount: InsuranceData.steps.length,
              itemBuilder: (context, index) {
                final stepData = InsuranceData.steps[index];

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _TitleRow(title: stepData.title),
                      const SizedBox(height: 12),
                      const _DashedDivider(),
                      const SizedBox(height: 12),
                      ...stepData.benefits.map((b) => _BenefitRow(item: b)),
                      const SizedBox(height: 24),
                      _buildBottomHint(index),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          DotsWithTooltip(
            activeIndex: _activeIndex,
            dotCount: InsuranceData.steps.length,
            labels: InsuranceData.steps.map((s) => s.tooltipLabel).toList(),
            onDotTap: (i) {
              _pageController.animateToPage(
                i,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomHint(int index) {
    if (index == 0) {
      return GestureDetector(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Xem chi tiết sản phẩm',
              style: TextStyle(
                color: Color(0xFFBB8A0B),
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Color(0xFFBB8A0B),
              size: 20,
            ),
          ],
        ),
      );
    } else if (index == 1) {
      return Center(
        child: Text.rich(
          TextSpan(
            text: 'Quy tắc, điều khoản bảo hiểm. Tham khảo ',
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 13,
              color: Color(0xFF444444),
            ),
            children: const [
              TextSpan(
                text: 'Tại đây',
                style: TextStyle(
                  color: Color(0xFFBB8A0B),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return Center(
        child: Text.rich(
          TextSpan(
            text: 'Xem chi tiết ',
            style: const TextStyle(fontSize: 13, color: Color(0xFF444444)),
            children: const [
              TextSpan(
                text: 'Bảng minh họa quyền lợi',
                style: TextStyle(
                  color: Color(0xFF1B8A4E),
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

class _TitleRow extends StatelessWidget {
  final String title;
  const _TitleRow({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Color(0xFFCC0000),
              fontSize: 19,
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.all(6),
          child: const Icon(
            Icons.favorite_border,
            color: Color(0xFF000000),
            size: 24,
          ),
        ),
      ],
    );
  }
}

class _DashedDivider extends StatelessWidget {
  const _DashedDivider();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 1,
      child: CustomPaint(painter: _DashedLinePainter()),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFDDDDDD)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    const dashWidth = 6.0;
    const dashSpace = 4.0;
    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BenefitRow extends StatelessWidget {
  final BenefitItem item;
  const _BenefitRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: SvgPicture.asset(
              'assets/icons/icon_safety.svg',
              width: 25,
              height: 25,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  if (item.title != null)
                    TextSpan(
                      text: item.title,
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1B8A4E),
                        height: 1.6,
                      ),
                    ),
                  TextSpan(
                    text: item.content,
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 14,
                      color: Color(0xFF444444),
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
