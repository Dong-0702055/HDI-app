import 'package:flutter/material.dart';
import '09.dart';
import '12.dart';
import '08.dart';
import '05.dart';
import 'insurance_package.dart';

class ThanhToanScreen extends StatefulWidget {
  final String buyerName;
  final String buyerBirth;
  final String buyerCccd;
  final String buyerPhone;
  final String buyerEmail;

  final List<InsuredPerson> insuredPersons;
  final dynamic selectedPackage;
  final List<InsurancePackage> packages;

  final String destination;
  final String dateRange;

  const ThanhToanScreen({
    super.key,
    required this.buyerName,
    required this.buyerBirth,
    required this.buyerCccd,
    required this.buyerPhone,
    required this.buyerEmail,
    required this.insuredPersons,
    required this.selectedPackage,
    required this.destination,
    required this.dateRange,
    required this.packages,
  });

  @override
  State<ThanhToanScreen> createState() => _ThanhToanScreenState();
}

class _ThanhToanScreenState extends State<ThanhToanScreen> {
  late String buyerName;
  late String buyerBirth;
  late String buyerCccd;
  late String buyerPhone;
  late String buyerEmail;

  late List<InsuredPerson> insuredPersons;

  late dynamic selectedPackage;
  late List<InsurancePackage> allPackages;
  late String destination;
  late String dateRange;

  @override
  void initState() {
    super.initState();

    buyerName = widget.buyerName;
    buyerBirth = widget.buyerBirth;
    buyerCccd = widget.buyerCccd;
    buyerPhone = widget.buyerPhone;
    buyerEmail = widget.buyerEmail;

    insuredPersons = List<InsuredPerson>.from(widget.insuredPersons);

    selectedPackage = widget.selectedPackage;
    allPackages = widget.packages;

    destination = widget.destination;
    dateRange = widget.dateRange;
  }

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
                            flex: 3,

                            child: Container(
                              height: 3,
                              color: const Color(0xff1B7D32),
                            ),
                          ),

                          Expanded(
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
                        buildStep("1", "Chọn gói\nsức khỏe", true),

                        buildStep("2", "Người được\nbảo hiểm", true),

                        buildStep("3", "Xác nhận\nthông tin", true),

                        buildStep("4", "Thanh toán", false),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12),

                  child: Column(
                    children: [
                      buildPackageCard(),

                      const SizedBox(height: 12),

                      /// THÔNG TIN CHUYẾN ĐI
                      buildInfoSection(
                        title: "Thông tin chuyến đi",

                        onEdit: () async {
                          final result = await Navigator.push(
                            context,

                            MaterialPageRoute(
                              builder: (_) => XacNhanThongTinScreen(
                                destination: destination,

                                dateRange: dateRange,

                                people: insuredPersons.length.toString(),

                                selectedPackage: selectedPackage,
                                packages: allPackages,

                                buyerName: buyerName,
                                buyerBirth: buyerBirth,
                                buyerCccd: buyerCccd,
                                buyerPhone: buyerPhone,
                                buyerEmail: buyerEmail,

                                initialPersons: insuredPersons,

                                isEditMode: true,
                              ),
                            ),
                          );

                          if (result != null) {
                            setState(() {
                              buyerName = result["buyerName"];
                              buyerBirth = result["buyerBirth"];
                              buyerCccd = result["buyerCccd"];
                              buyerPhone = result["buyerPhone"];
                              buyerEmail = result["buyerEmail"];

                              insuredPersons = List<InsuredPerson>.from(
                                result["insuredPersons"],
                              );

                              destination = result["destination"];
                              dateRange = result["dateRange"];

                              /// UPDATE BUYER TRONG DS NGƯỜI BH
                              int buyerIndex = insuredPersons.indexWhere(
                                (e) => e.isBuyer,
                              );

                              if (buyerIndex != -1) {
                                insuredPersons[buyerIndex] = InsuredPerson(
                                  name: buyerName,
                                  birth: buyerBirth,
                                  cccd: buyerCccd,
                                  isBuyer: true,
                                );
                              }
                            });
                          }
                        },

                        children: [
                          buildInfoRow("Điểm đến:", destination),

                          buildInfoRow("Thời gian:", dateRange),
                        ],
                      ),

                      const SizedBox(height: 12),

                      /// BÊN MUA BH
                      buildInfoSection(
                        title: "Bên mua bảo hiểm",

                        onEdit: () async {
                          final result = await Navigator.push(
                            context,

                            MaterialPageRoute(
                              builder: (_) => XacNhanThongTinScreen(
                                destination: destination,

                                dateRange: dateRange,

                                people: insuredPersons.length.toString(),

                                selectedPackage: selectedPackage,
                                packages: allPackages,
                                buyerName: buyerName,
                                buyerBirth: buyerBirth,
                                buyerCccd: buyerCccd,
                                buyerPhone: buyerPhone,
                                buyerEmail: buyerEmail,

                                initialPersons: insuredPersons,

                                isEditMode: true,
                              ),
                            ),
                          );

                          if (result != null) {
                            setState(() {
                              buyerName = result["buyerName"];
                              buyerBirth = result["buyerBirth"];
                              buyerCccd = result["buyerCccd"];
                              buyerPhone = result["buyerPhone"];
                              buyerEmail = result["buyerEmail"];

                              insuredPersons = List<InsuredPerson>.from(
                                result["insuredPersons"],
                              );

                              destination = result["destination"];
                              dateRange = result["dateRange"];

                              /// UPDATE BUYER TRONG DS NGƯỜI BH
                              int buyerIndex = insuredPersons.indexWhere(
                                (e) => e.isBuyer,
                              );

                              if (buyerIndex != -1) {
                                insuredPersons[buyerIndex] = InsuredPerson(
                                  name: buyerName,
                                  birth: buyerBirth,
                                  cccd: buyerCccd,
                                  isBuyer: true,
                                );
                              }
                            });
                          }
                        },

                        children: [
                          buildInfoRow("Họ tên:", buyerName),

                          buildInfoRow("Ngày sinh:", buyerBirth),

                          buildInfoRow("CMND/CCCD/Hộ chiếu:", buyerCccd),

                          buildInfoRow("Số điện thoại:", buyerPhone),

                          buildInfoRow("Email:", buyerEmail),
                        ],
                      ),

                      const SizedBox(height: 12),

                      /// DS NGƯỜI BH
                      buildInfoSection(
                        title: "Người được bảo hiểm (${insuredPersons.length})",

                        onEdit: () async {
                          final result = await Navigator.push(
                            context,

                            MaterialPageRoute(
                              builder: (_) => DanhSachNguoiBHScreen(
                                people: insuredPersons.length,

                                initialPersons: insuredPersons,
                              ),
                            ),
                          );

                          if (result != null) {
                            setState(() {
                              insuredPersons = List<InsuredPerson>.from(
                                result["persons"],
                              );

                              /// TÌM BUYER TRONG DS
                              final buyer = insuredPersons.firstWhere(
                                (e) => e.isBuyer,
                                orElse: () => InsuredPerson(
                                  name: "",
                                  birth: "",
                                  cccd: "",
                                ),
                              );

                              /// UPDATE FORM BÊN MUA
                              if (buyer.name.isNotEmpty) {
                                buyerName = buyer.name;
                                buyerBirth = buyer.birth;
                                buyerCccd = buyer.cccd;
                              }
                            });
                          }
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
                        builder: (_) =>
                            KetQuaGiaoDichScreen(buyerName: buyerName),
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

  Widget buildPackageCard() {
    String iconPath = "assets/image/105/105_bh_3.png";

    if (selectedPackage.title.contains("Phổ thông")) {
      iconPath = "assets/image/105/105_bh_2.png";
    } else if (selectedPackage.title.contains("Thượng Hạng")) {
      iconPath = "assets/image/105/105_bh_4.png";
    }

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(14),

        boxShadow: [
          BoxShadow(blurRadius: 8, color: Colors.black.withOpacity(0.04)),
        ],
      ),

      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              /// ICON
              Container(
                width: 80,
                height: 80,

                padding: const EdgeInsets.all(6),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),

                  color: const Color(0xffF5F5F5),
                ),

                child: Image.asset(iconPath, fit: BoxFit.contain),
              ),

              const SizedBox(width: 12),

              /// INFO
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const Text(
                      "Bảo hiểm du lịch Quốc tế",

                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff1B5E20),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "x1 ${selectedPackage.title}",

                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,

                              MaterialPageRoute(
                                builder: (_) => ChiTietGoiScreen(
                                  selectedPackage: selectedPackage,

                                  packages: allPackages,

                                  destination: destination,
                                  date: dateRange,
                                  people: insuredPersons.length.toString(),

                                  isViewOnly: true,
                                ),
                              ),
                            );
                          },

                          child: const Text(
                            "Chi tiết quyền lợi",

                            style: TextStyle(
                              color: Color(0xffC69214),
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "${selectedPackage.price}",

                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Divider(color: Colors.grey.shade300, height: 1),
        ],
      ),
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
    return SizedBox(
      width: 72,

      child: Column(
        children: [
          Container(
            width: 24,
            height: 24,

            decoration: BoxDecoration(
              shape: BoxShape.circle,

              color: active ? const Color(0xff1B7D32) : Colors.grey.shade300,
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
              height: 1.35,

              fontWeight: FontWeight.w500,

              color: active ? Colors.black87 : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
