import 'dart:math';
import 'package:flutter/material.dart';
import '../../home.dart';

class PaymentResultScreen extends StatefulWidget {
  const PaymentResultScreen({super.key});

  @override
  State<PaymentResultScreen> createState() => _PaymentResultScreenState();
}

class _PaymentResultScreenState extends State<PaymentResultScreen> {
  // Random 50/50 khi màn hình được tạo
  final bool _isSuccess = Random().nextBool();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1B5E20), Color(0xFFA5D63F)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 24),

              // Title
              const Text(
                'Kết quả giao dịch',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 80),

              // Result card
              _isSuccess ? _buildSuccessCard(context) : _buildFailCard(context),
            ],
          ),
        ),
      ),
    );
  }

  // ══════════════════════════════════════════
  // SUCCESS CARD
  // ══════════════════════════════════════════
  Widget _buildSuccessCard(BuildContext context) {
    return _buildResultCard(
      context: context,
      iconColor: const Color(0xFF00C853),
      icon: Icons.check,
      title: 'Thanh toán thành công',
      subtitle: 'Chào mừng ông Đinh Duy Tường\nđã tham gia Bảo hiểm HD',
      description:
          'Để xem giấy chứng nhận bảo hiểm của bạn, vui lòng đăng nhập vào '
          'Cổng thông tin khách hàng hoặc kiểm tra email đã đăng ký.',
      buttonLabel: 'Quay về trang chủ',
      onPressed: () => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const Home()),
        (route) => route.isFirst,
      ),
    );
  }

  // ══════════════════════════════════════════
  // FAIL CARD
  // ══════════════════════════════════════════
  Widget _buildFailCard(BuildContext context) {
    return _buildResultCard(
      context: context,
      iconColor: Colors.red,
      icon: Icons.close,
      title: 'Thanh toán thất bại',
      subtitle: 'Vui lòng thử thực hiện giao dịch khác.',
      description:
          'Bấm Khám phá bảo hiểm HD để tiếp tục mua bảo hiểm. '
          'Chúng tôi rất hân hạnh được phục vụ quý khách hàng!',
      buttonLabel: 'Thanh toán lại',
      onPressed: () => Navigator.pop(context),
    );
  }

  // ══════════════════════════════════════════
  // SHARED CARD BUILDER
  // ══════════════════════════════════════════
  Widget _buildResultCard({
    required BuildContext context,
    required Color iconColor,
    required IconData icon,
    required String title,
    required String subtitle,
    required String description,
    required String buttonLabel,
    required VoidCallback onPressed,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        // White card with zigzag bottom
        ClipPath(
          clipper: _ZigzagClipper(),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.88,
            padding: const EdgeInsets.fromLTRB(24, 72, 24, 48),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 14),

                // Subtitle
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: Color(0xFF555555),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),

                // Description
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 28),

                // Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: onPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFBB8A0B),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      buttonLabel,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Floating circle icon (overlaps top of card)
        Positioned(
          top: -45,
          child: Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconColor,
              ),
              child: Icon(icon, color: Colors.white, size: 44),
            ),
          ),
        ),
      ],
    );
  }
}

// ══════════════════════════════════════════
// ZIGZAG BOTTOM CLIPPER
// ══════════════════════════════════════════
class _ZigzagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const toothWidth = 14.0;
    const toothHeight = 10.0;

    final path = Path()
      ..lineTo(0, size.height - toothHeight)
      ..moveTo(0, 0);

    // Vẽ phần thân card (trên và 2 bên)
    path
      ..lineTo(0, size.height - toothHeight)
      ..lineTo(size.width, size.height - toothHeight)
      ..lineTo(size.width, 0)
      ..close();

    // Vẽ lại với zigzag phía dưới
    final path2 = Path();
    path2.moveTo(0, 0);
    path2.lineTo(0, size.height - toothHeight);

    double x = 0;
    bool goUp = true;
    while (x < size.width) {
      x += toothWidth;
      if (x > size.width) x = size.width;
      if (goUp) {
        path2.lineTo(x - toothWidth / 2, size.height);
        path2.lineTo(x, size.height - toothHeight);
      } else {
        path2.lineTo(x - toothWidth / 2, size.height - toothHeight * 2);
        path2.lineTo(x, size.height - toothHeight);
      }
      goUp = !goUp;
    }

    path2.lineTo(size.width, 0);
    path2.close();

    return path2;
  }

  @override
  bool shouldReclip(_ZigzagClipper oldClipper) => false;
}
