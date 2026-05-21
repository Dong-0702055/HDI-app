import 'package:flutter/material.dart';

/// Thanh tiến trình 4 bước dùng chung.
///
/// [currentStep] là bước đang hiện tại (1-indexed):
///   - 1 = Chọn gói sức khoẻ
///   - 2 = Người được bảo hiểm
///   - 3 = Xác nhận thông tin
///   - 4 = Thanh toán
///
/// Tất cả step <= currentStep sẽ được tô màu xanh (active).
class StepIndicator extends StatelessWidget {
  final int currentStep;

  static const _labels = [
    'Chọn gói\nsức khoẻ',
    'Người được\nbảo hiểm',
    'Xác nhận\nthông tin',
    'Thanh toán',
  ];

  static const _activeColor = Color(0xFF2F7D32);

  const StepIndicator({super.key, required this.currentStep})
    : assert(currentStep >= 1 && currentStep <= 4);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          // Row 1: Circles + connector lines
          Row(
            children: [
              for (int i = 0; i < _labels.length; i++) ...[
                _buildCircle(i + 1),
                if (i < _labels.length - 1) _buildConnector(i + 2),
              ],
            ],
          ),
          const SizedBox(height: 6),
          // Row 2: Labels
          Row(
            children: [
              for (int i = 0; i < _labels.length; i++) ...[
                SizedBox(
                  width: 50,
                  child: Text(
                    _labels[i],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      height: 1.3,
                      color: (i + 1) <= currentStep
                          ? Colors.black87
                          : Colors.grey,
                    ),
                  ),
                ),
                if (i < _labels.length - 1) const Expanded(child: SizedBox()),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircle(int stepNumber) {
    final isActive = stepNumber <= currentStep;
    return CircleAvatar(
      radius: 10,
      backgroundColor: isActive ? _activeColor : Colors.grey.shade300,
      child: Text(
        '$stepNumber',
        style: TextStyle(
          color: isActive ? Colors.white : Colors.grey,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// [nextStep] là số thứ tự của step bên phải đường kẻ.
  Widget _buildConnector(int nextStep) {
    return Expanded(
      child: Container(
        height: 2,
        color: nextStep <= currentStep ? _activeColor : Colors.grey.shade300,
      ),
    );
  }
}
