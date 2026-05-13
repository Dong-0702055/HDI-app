import 'package:flutter/material.dart';
import '../../models/comparison_data.dart';

class ComparisonHeader extends StatelessWidget {
  final ComparisonPackage leftPackage;
  final ComparisonPackage rightPackage;
  final bool isLeftSelected;
  final VoidCallback onChoosePackage;
  final ValueChanged<bool> onSideSelected; // true = left, false = right

  const ComparisonHeader({
    super.key,
    required this.leftPackage,
    required this.rightPackage,
    required this.isLeftSelected,
    required this.onChoosePackage,
    required this.onSideSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // "Chọn gói so sánh khác" button
        GestureDetector(
          onTap: onChoosePackage,
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 16.0, bottom: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Chọn gói so sánh khác',
                  style: TextStyle(
                    color: Color(0xFFBB8A0B),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFFBB8A0B),
                  size: 20,
                ),
              ],
            ),
          ),
        ),

        // Package Cards Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => onSideSelected(true),
                  child: _buildPackageCard(
                    package: leftPackage,
                    isSelected: isLeftSelected,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () => onSideSelected(false),
                  child: _buildPackageCard(
                    package: rightPackage,
                    isSelected: !isLeftSelected,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPackageCard({
    required ComparisonPackage package,
    required bool isSelected,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isSelected ? const Color(0xFFBB8A0B) : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Stack(
        children: [
          if (isSelected)
            const Positioned(
              top: 0,
              right: 0,
              child: Icon(
                Icons.check_circle,
                color: Color(0xFFBB8A0B),
                size: 18,
              ),
            ),
          Column(
            children: [
              Text(
                package.title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const SizedBox(height: 4),
              Text(
                package.subtitle,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                package.price,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF1B8A4E),
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
