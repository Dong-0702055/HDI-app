import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/comparison_data.dart';
import '../models/payment_data.dart';
import 'payment_result.dart';
import '../../../shared/widgets/hdi_app_bar.dart';
import '../../../shared/widgets/step_indicator.dart';
import '../../../shared/widgets/bottom_action_bar.dart';

class PaymentScreen extends StatefulWidget {
  final ComparisonPackage selectedPackage;

  const PaymentScreen({super.key, required this.selectedPackage});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedMethodIndex = 0;
  late int _remainingSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = PaymentData.initialCountdownSeconds;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _minutesStr =>
      (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
  String get _secondsStr => (_remainingSeconds % 60).toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      // ✅ Dùng HdiAppBar
      appBar: HdiAppBar(title: 'Thanh toán'),
      body: Column(
        children: [
          // ✅ Dùng StepIndicator - tất cả 4 bước active
          const StepIndicator(currentStep: 4),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Countdown + Amount card ──
                  _buildPaymentInfoCard(),
                  const SizedBox(height: 20),

                  // ── Payment methods ──
                  const Text(
                    'Phương thức thanh toán',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 12),

                  ...List.generate(
                    PaymentData.methods.length,
                    (i) => _buildMethodCard(i),
                  ),
                ],
              ),
            ),
          ),
          // ✅ Dùng BottomActionBar
          BottomActionBar(
            label: 'Thanh toán',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PaymentResultScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  // PAYMENT INFO CARD (countdown + amount)
  Widget _buildPaymentInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            margin: const EdgeInsets.only(bottom: 12),
            child: SvgPicture.asset('assets/icons/Payment.svg'),
          ),

          // Countdown row
          Row(
            children: [
              Expanded(
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 16, height: 1.4),
                    children: [
                      TextSpan(
                        text: 'Gói thanh toán bảo hiểm\nsẽ hết hạn sau',
                        style: TextStyle(color: Color(0xFF1565C0)),
                      ),
                    ],
                  ),
                ),
              ),
              // Timer display
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    _timerBox(_minutesStr),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        ':',
                        style: TextStyle(fontSize: 20, color: Colors.black87),
                      ),
                    ),
                    _timerBox(_secondsStr),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),
          const Divider(height: 1),
          const SizedBox(height: 14),

          // Amount row
          Row(
            children: [
              const Text(
                'Số tiền thanh toán',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const Spacer(),
              Text(
                widget.selectedPackage.price,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _timerBox(String value) {
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  // PAYMENT METHOD CARD
  Widget _buildMethodCard(int index) {
    final method = PaymentData.methods[index];
    final isSelected = _selectedMethodIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedMethodIndex = index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFFBB8A0B) : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            // Radio indicator
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF2F7D32)
                      : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF2F7D32),
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),

            // Label
            Expanded(
              child: Text(
                method.label,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),

            // Right icon / logos
            if (method.svgPath.isNotEmpty)
              SvgPicture.asset(
                method.svgPath,
                width: 28,
                height: 28,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF2F7D32),
                  BlendMode.srcIn,
                ),
              )
            else
              // Placeholder khi chưa có icon
              const SizedBox(width: 28, height: 28),
          ],
        ),
      ),
    );
  }

}
