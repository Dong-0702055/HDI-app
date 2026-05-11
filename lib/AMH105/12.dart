import 'package:flutter/material.dart';

class KetQuaGiaoDichScreen extends StatelessWidget {
  const KetQuaGiaoDichScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff1B5E20), Color(0xffA5D63F)],
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),

              const Text(
                "Kết quả giao dịch",

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 80),

              Stack(
                clipBehavior: Clip.none,

                alignment: Alignment.topCenter,

                children: [
                  /// CARD
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,

                    padding: const EdgeInsets.fromLTRB(20, 70, 20, 24),

                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(16),
                    ),

                    child: Column(
                      children: [
                        const Text(
                          "Thanh toán thành công",

                          textAlign: TextAlign.center,

                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff333333),
                          ),
                        ),

                        const SizedBox(height: 16),

                        const Text(
                          "Chào mừng ông Đinh Duy Tùng\nđã tham gia Bảo hiểm HDI",

                          textAlign: TextAlign.center,

                          style: TextStyle(
                            fontSize: 15,
                            height: 1.5,
                            color: Color(0xff555555),
                          ),
                        ),

                        const SizedBox(height: 16),

                        Text(
                          "Để xem giấy chứng nhận bảo hiểm của bạn, vui lòng đăng nhập vào Cổng thông tin khách hàng hoặc kiểm tra email đã đăng ký",

                          textAlign: TextAlign.center,

                          style: TextStyle(
                            fontSize: 13,
                            height: 1.5,
                            color: Colors.grey.shade600,
                          ),
                        ),

                        const SizedBox(height: 28),

                        SizedBox(
                          width: double.infinity,
                          height: 48,

                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.popUntil(
                                context,
                                (route) => route.isFirst,
                              );
                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffC69214),

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),

                            child: const Text(
                              "Quay về trang chủ",

                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// ICON CHECK
                  Positioned(
                    top: -45,

                    child: Container(
                      width: 90,
                      height: 90,

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),

                      child: Container(
                        margin: const EdgeInsets.all(8),

                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff00C853),
                        ),

                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 45,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
