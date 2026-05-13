import 'package:flutter/material.dart';
import '../../models/comparison_data.dart';

class ComparisonTable extends StatelessWidget {
  final ComparisonPackage leftPackage;
  final ComparisonPackage rightPackage;

  const ComparisonTable({
    super.key,
    required this.leftPackage,
    required this.rightPackage,
  });

  @override
  Widget build(BuildContext context) {
    final sections = ComparisonData.getSections(leftPackage, rightPackage);

    return Column(
      children: sections.map((section) {
        return Column(
          children: [
            _buildSectionHeader(section.sectionTitle),
            ...section.benefits.map((benefit) => _buildCompareRow(
                  left: benefit.leftValue,
                  right: benefit.rightValue,
                  title: benefit.title,
                )),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14),
      color: const Color(0xFFDDF5E3),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildCompareRow({
    required String left,
    required String right,
    required String title,
  }) {
    const valueStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      color: Colors.black87,
    );

    return Column(
      children: [
        // Values row
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 12, right: 12),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Text(
                    left,
                    textAlign: TextAlign.center,
                    style: valueStyle,
                  ),
                ),
                VerticalDivider(
                  color: Colors.grey.shade300,
                  thickness: 1,
                  width: 1,
                ),
                Expanded(
                  child: Text(
                    right,
                    textAlign: TextAlign.center,
                    style: valueStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Title (label) centered below values
        Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 16, left: 20, right: 20),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}
