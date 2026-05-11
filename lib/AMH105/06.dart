import 'package:flutter/material.dart';
import 'package:my_hdi/AMH105/insurance_package.dart';
import 'package:my_hdi/AMH105/08.dart';
import '07.dart';

class NguoiDuocBaoHiemScreen extends StatelessWidget {
  final String destination;
  final String dateRange;
  final String people;
  final InsurancePackage selectedPackage;
  final List<InsurancePackage> packages;
  const NguoiDuocBaoHiemScreen({
    super.key,
    required this.selectedPackage,

    required this.destination,
    required this.dateRange,
    required this.people,
    required this.packages,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [
            /// ================= HEADER =================
            Container(
              height: 60,

              padding: const EdgeInsets.symmetric(horizontal: 16),

              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff3D9B3D), Color(0xff006B2D)],
                ),
              ),

              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },

                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),

                  const Expanded(
                    child: Center(
                      child: Text(
                        "Thông tin người được bảo hiểm",

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 20),
                ],
              ),
            ),

            /// ================= STEP =================
            Container(
              color: Colors.white,

              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 14,
                bottom: 10,
              ),

              child: SizedBox(
                height: 72,

                child: Stack(
                  alignment: Alignment.topCenter,

                  children: [
                    /// LINE FULL
                    Positioned(
                      top: 11,

                      left: 28,
                      right: 28,

                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,

                            child: Container(
                              height: 3,
                              color: const Color(0xff1B7D32),
                            ),
                          ),

                          Expanded(
                            flex: 2,

                            child: Container(
                              height: 3,
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// STEP ITEM
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        buildStep(
                          number: "1",
                          title: "Chọn gói\nsức khỏe",
                          active: true,
                        ),

                        buildStep(
                          number: "2",
                          title: "Người được\nbảo hiểm",
                          active: true,
                        ),

                        buildStep(
                          number: "3",
                          title: "Xác nhận\nthông tin",
                          active: false,
                        ),

                        buildStep(
                          number: "4",
                          title: "Thanh toán",
                          active: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            /// ================= CONTENT =================
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CameraCmndScreen(),
                          ),
                        );
                      },

                      child: buildUploadBox(
                        icon: "assets/image/105/camera.png",

                        title: "Chụp ảnh CMND/CCCD/Hộ chiếu",
                      ),
                    ),

                    const SizedBox(height: 14),

                    buildUploadBox(
                      icon: "assets/image/105/gallery-add.png",

                      title: "Tải lên ảnh CMND/CCCD/Hộ chiếu",
                    ),

                    const SizedBox(height: 14),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,

                          MaterialPageRoute(
                            builder: (_) => XacNhanThongTinScreen(
                              selectedPackage: selectedPackage,

                              destination: destination,

                              dateRange: dateRange,
                              people: people,
                              packages: packages,
                            ),
                          ),
                        );
                      },

                      child: buildUploadBox(
                        icon: "assets/image/105/edit.png",

                        title: "Hoặc nhập tay",

                        hasArrow: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// ================= BOTTOM =================
            Container(
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.white,

                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    color: Colors.black.withOpacity(0.05),
                  ),
                ],
              ),

              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const Expanded(
                        child: Text(
                          "Bảo hiểm du lịch\nQuốc tế",

                          style: TextStyle(fontSize: 13),
                        ),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,

                        children: [
                          Text(
                            selectedPackage.title,

                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            selectedPackage.price,

                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  SizedBox(
                    width: double.infinity,
                    height: 50,

                    child: ElevatedButton(
                      onPressed: () {},

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffC69214),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      child: const Text(
                        "Tiếp tục",

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
          ],
        ),
      ),
    );
  }

  /// ================= STEP =================
  Widget buildStep({
    required String number,
    required String title,
    required bool active,
  }) {
    return SizedBox(
      width: 74,

      child: Column(
        children: [
          Container(
            width: 24,
            height: 24,

            decoration: BoxDecoration(
              shape: BoxShape.circle,

              color: active ? const Color(0xff1B7D32) : Colors.grey.shade300,

              border: Border.all(
                color: active ? const Color(0xff1B7D32) : Colors.grey.shade300,
              ),
            ),

            child: Center(
              child: Text(
                number,

                style: TextStyle(
                  color: active ? Colors.white : Colors.grey.shade600,

                  fontWeight: FontWeight.w600,

                  fontSize: 12,
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            title,

            textAlign: TextAlign.center,

            style: TextStyle(
              fontSize: 11,
              height: 1.3,

              fontWeight: FontWeight.w500,

              color: active ? Colors.black87 : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  /// ================= BOX =================
  Widget buildUploadBox({
    required String icon,
    required String title,
    bool hasArrow = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),

        border: Border.all(color: const Color(0xff7FA67F)),
      ),

      child: Row(
        children: [
          Image.asset(icon, width: 28, height: 28),

          const SizedBox(width: 12),

          Expanded(child: Text(title, style: const TextStyle(fontSize: 14))),

          if (hasArrow) const Icon(Icons.arrow_forward),
        ],
      ),
    );
  }
}
