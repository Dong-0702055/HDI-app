import 'package:flutter/material.dart';
import '../../models/comparison_data.dart';

class PackageSelectorBottomSheet extends StatelessWidget {
  final List<ComparisonPackage> packages;
  final ComparisonPackage leftPackage;
  final ComparisonPackage rightPackage;
  final bool isLeftSelected; // true = đang chọn gói trái, false = gói phải
  final ValueChanged<ComparisonPackage> onPackageSelected;

  const PackageSelectorBottomSheet({
    super.key,
    required this.packages,
    required this.leftPackage,
    required this.rightPackage,
    required this.isLeftSelected,
    required this.onPackageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Title row
          Row(
            children: [
              const Spacer(),
              const Text(
                'Gói bảo hiểm',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close, color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // List of packages
          ...packages.map((pkg) {
            final isSelected = isLeftSelected
                ? leftPackage.title == pkg.title
                : rightPackage.title == pkg.title;

            // Gói trùng với phía còn lại → disable
            final isDisabled = isLeftSelected
                ? pkg.title == rightPackage.title
                : pkg.title == leftPackage.title;

            return GestureDetector(
              onTap: isDisabled
                  ? null
                  : () {
                      onPackageSelected(pkg);
                      Navigator.pop(context);
                    },
              child: Opacity(
                opacity: isDisabled ? 0.4 : 1.0,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFFBB8A0B)
                          : Colors.grey.shade300,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isSelected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off,
                        color: isSelected
                            ? const Color(0xFFBB8A0B)
                            : Colors.grey,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pkg.title,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              pkg.subtitle,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        pkg.price,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
