import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Ô "bấm để chọn" có icon SVG bên trái và mũi tên xuống bên phải.
/// Dùng cho: ngày sinh, giới tính, ngày bắt đầu, ngày kết thúc...
class TappableFieldTile extends StatelessWidget {
  final String svgPath;
  final String label;
  final String value;
  final VoidCallback onTap;

  const TappableFieldTile({
    super.key,
    required this.svgPath,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasValue = value.isNotEmpty;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            SvgPicture.asset(svgPath, width: 20, height: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                hasValue ? value : label,
                style: TextStyle(
                  fontSize: 14,
                  color: hasValue ? Colors.black87 : Colors.grey.shade500,
                ),
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, color: Colors.black, size: 22),
          ],
        ),
      ),
    );
  }
}
