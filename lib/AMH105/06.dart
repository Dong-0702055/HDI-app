import 'package:flutter/material.dart';
import 'package:my_hdi/AMH105/insurance_package.dart';
import 'package:my_hdi/AMH105/08.dart';
import '07.dart';

class NguoiDuocBaoHiemScreen extends StatelessWidget {
  final String destination;
  final String dateRange;
  final String people;
  final InsurancePackage selectedPackage;

  const NguoiDuocBaoHiemScreen({
    super.key,
    required this.selectedPackage,

    required this.destination,
    required this.dateRange,
    required this.people,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),

              child: Row(
                children: [
                  buildStep(
                    number: "1",
                    title: "Chọn gói\nsức khỏe",
                    active: true,
                  ),

                  buildLine(),

                  buildStep(
                    number: "2",
                    title: "Người được\nbảo hiểm",
                    active: true,
                  ),

                  buildLine(),

                  buildStep(
                    number: "3",
                    title: "Xác nhận\nthông tin",
                    active: false,
                  ),

                  buildLine(),

                  buildStep(number: "4", title: "Thanh toán", active: false),
                ],
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
    return Column(
      children: [
        CircleAvatar(
          radius: 10,

          backgroundColor: active
              ? const Color(0xff2F7D32)
              : Colors.grey.shade300,

          child: Text(
            number,

            style: TextStyle(
              color: active ? Colors.white : Colors.grey,

              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 6),

        SizedBox(
          width: 55,

          child: Text(
            title,

            textAlign: TextAlign.center,

            style: TextStyle(
              fontSize: 10,

              color: active ? Colors.black : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  /// ================= LINE =================
  Widget buildLine() {
    return Expanded(
      child: Container(
        height: 2,

        margin: const EdgeInsets.only(bottom: 28),

        color: const Color(0xff2F7D32),
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
