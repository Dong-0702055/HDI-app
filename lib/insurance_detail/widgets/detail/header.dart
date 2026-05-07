import 'package:flutter/material.dart';
import '../../models/insurance_data.dart';
import 'info_card.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  static const double _coverHeight = 210.0;
  static const double _cardOverlap = 10.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _coverHeight + 434 - _cardOverlap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const _CoverImage(height: _coverHeight),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: const _BackButton(),
            ),
          ),
          Positioned(
            top: _coverHeight - _cardOverlap,
            left: 16,
            right: 16,
            child: const SizedBox(height: 434, child: InfoCard()),
          ),
        ],
      ),
    );
  }
}

class _CoverImage extends StatelessWidget {
  final double height;
  const _CoverImage({required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          InsuranceData.coverImage,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: const Color(0xFF1A6B3A),
            child: const Center(
              child: Icon(
                Icons.health_and_safety,
                size: 80,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.95),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(
          Icons.arrow_back_ios_new,
          size: 18,
          color: Color(0xFF333333),
        ),
      ),
    );
  }
}
