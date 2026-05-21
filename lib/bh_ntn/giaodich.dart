import 'package:flutter/material.dart';
import 'package:my_hdi/home.dart';
import 'package:my_hdi/utils/app_styles.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Màn hình: Kết quả giao dịch — Thanh toán thành công
// ─────────────────────────────────────────────────────────────────────────────

class KetQuaGiaoDich extends StatelessWidget {
  /// Tên người mua để hiển thị lời chào
  final String tenNguoiMua;

  const KetQuaGiaoDich({super.key, required this.tenNguoiMua});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ── Nền ảnh background toàn màn hình ────────────────────────────
          Positioned.fill(
            child: Image.asset(
              'assets/image_BHNTN/background2.png',
              fit: BoxFit.cover,
            ),
          ),

          // ── Nội dung ─────────────────────────────────────────────────────
          SafeArea(
            child: Column(
              children: [
                // Tiêu đề "Kết quả giao dịch"
                const SizedBox(height: 20),
                Text(
                  'Kết quả giao dịch',
                  style: AppStyles.n(
                    size: 18,
                    weight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 40),

                // ── Card trắng trung tâm ────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children: [
                      // Khối nền: Sử dụng ảnh nền asset có răng cưa làm background
                      Positioned.fill(
                        child: Image.asset(
                          'assets/image_BHNTN/background_giaodich.png',
                          fit: BoxFit
                              .fill, // Giúp ảnh tự co giãn khít theo chiều cao của nội dung chữ bên trong
                        ),
                      ),

                      // Khối nội dung: Nằm đè lên ảnh nền
                      Column(
                        mainAxisSize: MainAxisSize
                            .min, // Tự co giãn chiều cao theo nội dung
                        children: [
                          // Khoảng trống cho icon check nổi lên trên đỉnh
                          const SizedBox(height: 44),

                          // Tiêu đề thành công
                          Text(
                            'Thanh toán thành công',
                            style: AppStyles.n(
                              size: 18,
                              weight: FontWeight.w600,
                              color: const Color(0xFF1A1A1A),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),

                          // Lời chào
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              'Chào mừng ông $tenNguoiMua\nđã tham gia Bảo hiểm HD',
                              style: AppStyles.n(
                                size: 14,
                                weight: FontWeight.w600,
                                color: const Color(0xFF2D2D2D),
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Mô tả hướng dẫn
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              'Để xem giấy chứng nhận bảo hiểm của bạn, vui lòng đăng nhập vào Cổng thông tin khách hàng hoặc kiểm tra email đã đăng ký',
                              style: AppStyles.n(
                                size: 13,
                                color: const Color(0xFF777777),
                                height: 1.6,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Nút Quay về trang chủ
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: SizedBox(
                              width: double.infinity,
                              height: 46,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const Home(),
                                    ),
                                    (route) => false,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppStyles.gold,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'Quay về trang chủ',
                                  style: AppStyles.n(
                                    size: 15,
                                    weight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Khoảng cách đệm phía dưới cùng trước khi kết thúc răng cưa hình ảnh
                          const SizedBox(height: 24),
                        ],
                      ),

                      // Icon check xanh nổi lên trên đỉnh card (Giữ nguyên từ bản cũ)
                      Positioned(
                        top: -30,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2ECC71),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
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
    );
  }
}