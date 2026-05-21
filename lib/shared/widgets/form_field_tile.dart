import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Ô nhập liệu văn bản có icon SVG bên trái.
/// Dùng cho: họ tên, CCCD, số điện thoại, email...
class FormFieldTile extends StatelessWidget {
  final String svgPath;
  final String label;
  final TextEditingController controller;
  final String? hint;
  final TextInputType keyboardType;

  const FormFieldTile({
    super.key,
    required this.svgPath,
    required this.label,
    required this.controller,
    this.hint,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          SvgPicture.asset(svgPath, width: 20, height: 20),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint ?? label,
                hintStyle:
                    TextStyle(fontSize: 14, color: Colors.grey.shade500),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
