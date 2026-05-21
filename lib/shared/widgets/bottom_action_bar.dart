import 'package:flutter/material.dart';

/// Nút hành động ở cuối màn hình, dùng chung cho toàn bộ luồng.
///
/// - [label]: nhãn nút, mặc định là 'Tiếp tục'
/// - [onPressed]: null → nút bị disabled (màu xám)
/// - [topContent]: Widget tuỳ chọn hiển thị phía trên nút
///   (dùng kỹ thuật Slot Pattern cho insured_info screen có thêm hàng giá)
class BottomActionBar extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Widget? topContent; // ← "lỗ" tuỳ chọn phía trên nút

  const BottomActionBar({
    super.key,
    this.label = 'Tiếp tục',
    this.onPressed,
    this.topContent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Slot tuỳ chọn - chỉ render nếu có nội dung
            if (topContent != null) ...[
              topContent!,
              const SizedBox(height: 14),
            ],
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFBB8A0B),
                  disabledBackgroundColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
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
