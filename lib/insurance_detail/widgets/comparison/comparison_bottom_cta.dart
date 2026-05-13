import 'package:flutter/material.dart';
import '../../models/comparison_data.dart';

class ComparisonBottomCTA extends StatelessWidget {
  final ComparisonPackage selectedPackage;
  final VoidCallback onBuyNow;

  const ComparisonBottomCTA({
    super.key,
    required this.selectedPackage,
    required this.onBuyNow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            offset: const Offset(0, -2),
            blurRadius: 8,
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Left info
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 13, color: Colors.black87),
                      children: [
                        const TextSpan(text: 'Gói bảo hiểm: '),
                        TextSpan(
                          text: selectedPackage.title,
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 13, color: Colors.black87),
                      children: [
                        const TextSpan(text: 'Phí bảo hiểm: '),
                        TextSpan(
                          text: selectedPackage.price,
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // Buy now button
            SizedBox(
              width: 130,
              height: 48,
              child: ElevatedButton(
                onPressed: onBuyNow,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFBB8A0B),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Mua ngay',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
