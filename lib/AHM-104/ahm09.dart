import 'package:flutter/material.dart';
import 'package:my_hdi/home.dart';

class Ahm09 extends StatelessWidget {
  final String buyerName;

  const Ahm09({super.key, required this.buyerName});

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
            colors: [
              Color(0xFF1B5E20),
              Color(0xFF388E3C),
              Color(0xFF8BC34A),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Decorative circles background
            Positioned(
              top: -60,
              left: -60,
              child: _decorCircle(200, Colors.white.withValues(alpha: 0.05)),
            ),
            Positioned(
              top: 80,
              right: -80,
              child: _decorCircle(220, Colors.white.withValues(alpha: 0.04)),
            ),
            Positioned(
              bottom: 100,
              left: -40,
              child: _decorCircle(160, Colors.white.withValues(alpha: 0.04)),
            ),

            // App bar area
            SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Kết quả giao dịch',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 48),

                  // Card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topCenter,
                      children: [
                        // White card with zigzag bottom
                        ClipPath(
                          clipper: _ZigzagClipper(),
                          child: Container(
                            width: double.infinity,
                            color: Colors.white,
                            padding: const EdgeInsets.fromLTRB(24, 56, 24, 48),
                            child: Column(
                              children: [
                                const Text(
                                  'Thanh toán thành công',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Chào mừng ${buyerName.isNotEmpty ? buyerName : "quý khách"}\nđã tham gia Bảo hiểm HD',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Để xem giấy chứng nhận bảo hiểm của bạn, vui lòng đăng nhập vào Cổng thông tin khách hàng hoặc kiểm tra email đã đăng ký',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                    height: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 28),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Xóa toàn bộ stack, push về Home
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(builder: (_) => const Home()),
                                        (route) => false,
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFBB8A0B),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: const Text(
                                      'Quay về trang chủ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Green check circle on top
                        Positioned(
                          top: -30,
                          child: Container(
                            width: 64,
                            height: 64,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF43A047),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x441B5E20),
                                  blurRadius: 12,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(Icons.check, color: Colors.white, size: 36),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _decorCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 40),
      ),
    );
  }
}

// Zigzag clipper cho viền răng cưa dưới card
class _ZigzagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 20);

    // Zigzag bottom
    double x = 0;
    const toothW = 12.0;
    const toothH = 10.0;
    bool up = true;
    while (x < size.width) {
      x += toothW;
      path.lineTo(x.clamp(0, size.width), size.height - (up ? 0 : toothH));
      up = !up;
    }
    path.lineTo(size.width, size.height - 20);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_ZigzagClipper oldClipper) => false;
}
