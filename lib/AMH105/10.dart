import 'package:flutter/material.dart';
import 'package:my_hdi/AMH105/11.dart';
import '09.dart';
import 'insurance_package.dart';

class CamKetThanhToanScreen extends StatefulWidget {
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

  const CamKetThanhToanScreen({
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
  State<CamKetThanhToanScreen> createState() => _CamKetThanhToanScreenState();
}

class _CamKetThanhToanScreenState extends State<CamKetThanhToanScreen> {
  bool selectedYes = false;
  bool selectedNo = true;

  bool isExpanded = false;

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
                        "Xác nhận thông tin",

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
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
                          active: true,
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

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),

                  child: Column(
                    children: [
                      /// CARD CÂU HỎI
                      Container(
                        width: double.infinity,

                        padding: const EdgeInsets.all(16),

                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(12),

                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8,
                              color: Colors.black.withOpacity(0.04),
                            ),
                          ],
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            const Text(
                              "Người tham gia bảo hiểm có thuộc một trong các đối tượng sau đây?",

                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            const SizedBox(height: 16),

                            buildQuestion(
                              "1. Người đang mắc bệnh tâm thần, bệnh ung thư, bệnh phổi",
                            ),

                            buildQuestion(
                              "2. Người bị thương tật vĩnh viễn từ 70% trở lên",
                            ),

                            buildQuestion(
                              "3. Người đang trong thời gian điều trị bệnh tật, thương tật",
                            ),

                            const SizedBox(height: 18),

                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedYes = true;

                                      selectedNo = false;
                                    });
                                  },

                                  child: Row(
                                    children: [
                                      buildRadio(selectedYes),

                                      const SizedBox(width: 8),

                                      const Text(
                                        "Có",

                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(width: 40),

                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedYes = false;

                                      selectedNo = true;
                                    });
                                  },

                                  child: Row(
                                    children: [
                                      buildRadio(selectedNo),

                                      const SizedBox(width: 8),

                                      const Text(
                                        "Không",

                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      /// CAM KẾT
                      Container(
                        width: double.infinity,

                        padding: const EdgeInsets.all(16),

                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(12),

                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8,
                              color: Colors.black.withOpacity(0.04),
                            ),
                          ],
                        ),

                        child: Column(
                          children: [
                            Text(
                              "Bằng việc nhấn nút 'TIẾP TỤC' đồng nghĩa với việc Bên mua bảo hiểm xác nhận và cam kết. A) Các thông tin được khai báo, cung cấp là đúng sự thật và hoàn toàn chịu trách nhiệm trước pháp luật. Đồng thời, Bên mua bảo hiểm đã đọc, hiểu và đồng ý với điều kiện, điều khoản và quy tắc của Bảo hiểm HD.",

                              maxLines: isExpanded ? null : 4,

                              overflow: isExpanded
                                  ? TextOverflow.visible
                                  : TextOverflow.ellipsis,

                              style: TextStyle(
                                fontSize: 13,
                                height: 1.5,
                                color: Colors.grey.shade700,
                              ),
                            ),

                            const SizedBox(height: 12),

                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  Text(
                                    isExpanded ? "Thu gọn" : "Xem tất cả",

                                    style: const TextStyle(
                                      color: Color(0xffC69214),

                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                  const SizedBox(width: 4),

                                  Icon(
                                    isExpanded
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,

                                    color: const Color(0xffC69214),
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
                        builder: (_) => ThanhToanScreen(
                          buyerName: widget.buyerName,
                          buyerBirth: widget.buyerBirth,
                          buyerCccd: widget.buyerCccd,
                          buyerPhone: widget.buyerPhone,
                          buyerEmail: widget.buyerEmail,
                          insuredPersons: widget.insuredPersons,
                          selectedPackage: widget.selectedPackage,
                          packages: widget.packages,
                          destination: widget.destination,
                          dateRange: widget.dateRange,
                        ),
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
                    "Tiếp tục",

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

  Widget buildQuestion(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),

      child: Text(text, style: const TextStyle(fontSize: 14, height: 1.5)),
    );
  }

  Widget buildRadio(bool selected) {
    return Container(
      width: 22,
      height: 22,

      decoration: BoxDecoration(
        shape: BoxShape.circle,

        border: Border.all(
          color: selected ? const Color(0xffC69214) : Colors.grey,

          width: 2,
        ),
      ),

      child: selected
          ? Center(
              child: Container(
                width: 10,
                height: 10,

                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffC69214),
                ),
              ),
            )
          : null,
    );
  }

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
}
