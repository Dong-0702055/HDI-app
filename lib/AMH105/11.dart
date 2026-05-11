import 'package:flutter/material.dart';
import '09.dart';
import '12.dart';
import '08.dart';

class ThanhToanScreen extends StatelessWidget {
  final String buyerName;
  final String buyerBirth;
  final String buyerCccd;
  final String buyerPhone;
  final String buyerEmail;

  final List<InsuredPerson> insuredPersons;
  final dynamic selectedPackage;

  const ThanhToanScreen({
    super.key,
    required this.buyerName,
    required this.buyerBirth,
    required this.buyerCccd,
    required this.buyerPhone,
    required this.buyerEmail,
    required this.insuredPersons,
    required this.selectedPackage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      body: SafeArea(
        child: Column(
          children: [
            /// HEADER
            Container(
              height: 80,

              padding: const EdgeInsets.symmetric(horizontal: 16),

              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff2E7D32), Color(0xff66BB6A)],
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
                    ),
                  ),

                  const Expanded(
                    child: Center(
                      child: Text(
                        "Thông tin người được bảo hiểm",

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 24),
                ],
              ),
            ),

            /// STEP
            Container(
              color: Colors.white,

              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),

              child: Row(
                children: [
                  buildStep("1", "Chọn gói\nsức khỏe", true),

                  buildLine(),

                  buildStep("2", "Người được\nbảo hiểm", true),

                  buildLine(),

                  buildStep("3", "Xác nhận\nthông tin", true),

                  buildLine(),

                  buildStep("4", "Thanh toán", true),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12),

                  child: Column(
                    children: [
                      /// PACKAGE
                      buildSection(
                        child: Row(
                          children: [
                            Container(
                              width: 58,
                              height: 58,

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),

                                color: Colors.grey.shade100,
                              ),

                              child: Padding(
                                padding: const EdgeInsets.all(6),

                                child: Image.asset(
                                  "assets/image/105/105_bh_3.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  const Text(
                                    "Bảo hiểm Du lịch Quốc tế",

                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,

                                      fontSize: 14,
                                    ),
                                  ),

                                  const SizedBox(height: 4),

                                  const Text(
                                    "Gói Cao Cấp",

                                    style: TextStyle(
                                      color: Color(0xffC69214),

                                      fontSize: 13,
                                    ),
                                  ),

                                  const SizedBox(height: 4),

                                  Text(
                                    "12.595.000 VNĐ/chuyến",

                                    style: TextStyle(
                                      color: Colors.red.shade400,

                                      fontWeight: FontWeight.w600,

                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// THÔNG TIN CHUYẾN ĐI
                      buildInfoSection(
                        title: "Thông tin chuyến đi",

                        onEdit: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => XacNhanThongTinScreen(
                                destination: "Hàn Quốc, Hà Lan, Việt Nam",

                                dateRange: "10 ngày (28/12/2023 - 28/01/2024)",

                                people: insuredPersons.length.toString(),

                                selectedPackage: selectedPackage,
                              ),
                            ),
                          );
                        },

                        children: [
                          buildInfoRow(
                            "Điểm đến:",
                            "Hàn Quốc, Hà Lan, Việt Nam",
                          ),

                          buildInfoRow(
                            "Thời gian:",
                            "10 ngày (28/12/2023 - 28/01/2024)",
                          ),

                          buildInfoRow("Ngày về:", "28/10/2023"),
                        ],
                      ),

                      const SizedBox(height: 12),

                      /// BÊN MUA BH
                      buildInfoSection(
                        title: "Bên mua bảo hiểm",

                        onEdit: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => XacNhanThongTinScreen(
                                destination: "Hàn Quốc, Hà Lan, Việt Nam",

                                dateRange: "10 ngày (28/12/2023 - 28/01/2024)",

                                people: insuredPersons.length.toString(),

                                selectedPackage: selectedPackage,
                              ),
                            ),
                          );
                        },

                        children: [
                          buildInfoRow("Họ tên:", buyerName),

                          buildInfoRow("Ngày sinh:", buyerBirth),

                          buildInfoRow("CMND/CCCD/Hộ Chiếu:", buyerCccd),

                          buildInfoRow("Số điện thoại:", buyerPhone),

                          buildInfoRow("Email:", buyerEmail),
                        ],
                      ),

                      const SizedBox(height: 12),

                      /// DS NGƯỜI BH
                      buildInfoSection(
                        title: "Người được bảo hiểm (${insuredPersons.length})",
                        onEdit: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DanhSachNguoiBHScreen(
                                people: insuredPersons.length,
                                initialPersons: insuredPersons,
                              ),
                            ),
                          );
                        },

                        children: insuredPersons
                            .map((person) => buildPersonCard(person))
                            .toList(),
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),

            /// BUTTON
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

              child: SizedBox(
                width: double.infinity,
                height: 50,

                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const KetQuaGiaoDichScreen(),
                      ),
                    );
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffC69214),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  child: const Text(
                    "Thanh toán",

                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSection({required Widget child}) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(12),

        boxShadow: [
          BoxShadow(blurRadius: 8, color: Colors.black.withOpacity(0.04)),
        ],
      ),

      child: child,
    );
  }

  Widget buildInfoSection({
    required String title,
    required List<Widget> children,
    VoidCallback? onEdit,
  }) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(12),

        boxShadow: [
          BoxShadow(blurRadius: 8, color: Colors.black.withOpacity(0.04)),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,

                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),

              GestureDetector(
                onTap: onEdit,

                child: const Text(
                  "Chỉnh sửa",

                  style: TextStyle(
                    color: Color(0xffC69214),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          ...children,
        ],
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          SizedBox(
            width: 120,

            child: Text(
              label,

              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ),

          Expanded(
            child: Text(
              value,

              textAlign: TextAlign.right,

              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPersonCard(InsuredPerson person) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),

      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),

        border: Border.all(color: Colors.grey.shade200),
      ),

      child: Column(
        children: [
          buildInfoRow("Họ tên:", person.name),

          buildInfoRow("Ngày sinh:", person.birth),

          buildInfoRow("CMND/CCCD/\nHộ chiếu:", person.cccd),
        ],
      ),
    );
  }

  Widget buildStep(String number, String title, bool active) {
    return Column(
      children: [
        Container(
          width: 22,
          height: 22,

          decoration: BoxDecoration(
            shape: BoxShape.circle,

            color: active ? const Color(0xff1B7D32) : Colors.grey.shade300,
          ),

          child: Center(
            child: Text(
              number,

              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),

        const SizedBox(height: 6),

        SizedBox(
          width: 70,

          child: Text(
            title,

            textAlign: TextAlign.center,

            style: const TextStyle(fontSize: 11),
          ),
        ),
      ],
    );
  }

  Widget buildLine() {
    return Expanded(
      child: Container(
        height: 2,

        margin: const EdgeInsets.only(bottom: 28),

        color: const Color(0xff1B7D32),
      ),
    );
  }
}
