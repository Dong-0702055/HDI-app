import 'package:flutter/material.dart';
import 'package:my_hdi/AMH105/insurance_package.dart';
import 'package:my_hdi/AMH105/06.dart';

class ChiTietGoiScreen extends StatefulWidget {
  final String destination;
  final String date;
  final String people;
  final InsurancePackage selectedPackage;
  final List<InsurancePackage> packages;
  final bool isViewOnly;

  const ChiTietGoiScreen({
    super.key,
    required this.selectedPackage,
    required this.packages,
    required this.destination,
    required this.date,
    required this.people,
    this.isViewOnly = false,
  });

  @override
  State<ChiTietGoiScreen> createState() => _ChiTietGoiScreenState();
}

class _ChiTietGoiScreenState extends State<ChiTietGoiScreen> {
  late InsurancePackage currentPackage;
  late InsurancePackage comparePackage;

  bool isLeftSelected = true;

  @override
  void initState() {
    super.initState();

    currentPackage = widget.selectedPackage;

    comparePackage = widget.packages.firstWhere(
      (e) => e.title != currentPackage.title,
    );
  }

  /// ================= CHANGE PACKAGE =================
  void showComparePackageBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),

      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// TITLE
              Row(
                children: [
                  const Spacer(),

                  const Text(
                    "Gói bảo hiểm",

                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const Spacer(),

                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },

                    child: const Icon(Icons.close),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              ...widget.packages.map((e) {
                bool isSelected = isLeftSelected
                    ? currentPackage.title == e.title
                    : comparePackage.title == e.title;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      /// LEFT ACTIVE
                      if (isLeftSelected) {
                        if (e.title == comparePackage.title) {
                          return;
                        }

                        currentPackage = e;
                      } else {
                        /// RIGHT ACTIVE
                        if (e.title == currentPackage.title) {
                          return;
                        }

                        comparePackage = e;
                      }
                    });

                    Navigator.pop(context);
                  },

                  child: Container(
                    margin: const EdgeInsets.only(bottom: 14),

                    padding: const EdgeInsets.all(16),

                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(16),

                      border: Border.all(
                        color: isSelected
                            ? const Color(0xffC69214)
                            : Colors.grey.shade300,

                        width: isSelected ? 2 : 1,
                      ),
                    ),

                    child: Row(
                      children: [
                        Icon(
                          isSelected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,

                          color: isSelected
                              ? const Color(0xffC69214)
                              : Colors.grey,
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text(
                                e.title,

                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                e.subTitle,

                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),

                        Text(
                          e.price,

                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

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
                        "Chi tiết quyền lợi các gói",

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

            Expanded(
              child: Column(
                children: [
                  /// ================= BUTTON =================
                  Padding(
                    padding: const EdgeInsets.only(right: 16, top: 16),

                    child: Align(
                      alignment: Alignment.centerRight,

                      child: GestureDetector(
                        onTap: showComparePackageBottomSheet,

                        child: const Row(
                          mainAxisSize: MainAxisSize.min,

                          children: [
                            Text(
                              "Chọn gói so sánh khác",

                              style: TextStyle(
                                color: Color(0xffC69214),

                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            Icon(
                              Icons.keyboard_arrow_down,

                              color: Color(0xffC69214),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// ================= TOP PACKAGE =================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),

                    child: Row(
                      children: [
                        /// LEFT
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isLeftSelected = true;
                              });
                            },

                            child: buildPackageBox(
                              package: currentPackage,

                              isSelected: isLeftSelected,
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        /// RIGHT
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isLeftSelected = false;
                              });
                            },

                            child: buildPackageBox(
                              package: comparePackage,

                              isSelected: !isLeftSelected,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// ================= TABLE =================
                  /// ================= TABLE =================
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          /// ================= I =================
                          sectionTitle("I. Tử vong, thương tật vĩnh viễn"),

                          compareRow(
                            currentPackage.benefits[0].value,
                            comparePackage.benefits[0].value,
                            currentPackage.benefits[0].title,
                          ),

                          compareRow(
                            currentPackage.benefits[1].value,
                            comparePackage.benefits[1].value,
                            currentPackage.benefits[1].title,
                          ),

                          compareRow(
                            currentPackage.benefits[2].value,
                            comparePackage.benefits[2].value,
                            currentPackage.benefits[2].title,
                          ),

                          /// ================= II =================
                          sectionTitle("II. Chi phí y tế"),

                          compareRow(
                            currentPackage.benefits[3].value,
                            comparePackage.benefits[3].value,
                            currentPackage.benefits[3].title,

                            isRed: true,
                          ),

                          compareRow(
                            currentPackage.benefits[4].value,
                            comparePackage.benefits[4].value,
                            currentPackage.benefits[4].title,
                          ),

                          compareRow(
                            currentPackage.benefits[5].value,
                            comparePackage.benefits[5].value,
                            currentPackage.benefits[5].title,
                          ),

                          compareRow(
                            currentPackage.benefits[6].value,
                            comparePackage.benefits[6].value,
                            currentPackage.benefits[6].title,
                          ),

                          compareRow(
                            currentPackage.benefits[7].value,
                            comparePackage.benefits[7].value,
                            currentPackage.benefits[7].title,
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

                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text(
                                "Gói bảo hiểm: ${isLeftSelected ? currentPackage.title : comparePackage.title}",

                                style: const TextStyle(fontSize: 13),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                "Phí bảo hiểm: ${isLeftSelected ? currentPackage.price : comparePackage.price}",

                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          width: 140,
                          height: 48,

                          child: ElevatedButton(
                            // onPressed: () {
                            //   Navigator.push(
                            //     context,

                            //     MaterialPageRoute(
                            //       builder: (_) => NguoiDuocBaoHiemScreen(
                            //         selectedPackage: isLeftSelected
                            //             ? currentPackage
                            //             : comparePackage,

                            //         destination: widget.destination,
                            //         dateRange: widget.date,
                            //         people: widget.people,
                            //       ),
                            //     ),
                            //   );
                            // },
                            onPressed: () {
                              /// CHẾ ĐỘ XEM
                              if (widget.isViewOnly) {
                                Navigator.pop(context);
                                return;
                              }

                              /// FLOW MUA BÌNH THƯỜNG
                              Navigator.push(
                                context,

                                MaterialPageRoute(
                                  builder: (_) => NguoiDuocBaoHiemScreen(
                                    selectedPackage: isLeftSelected
                                        ? currentPackage
                                        : comparePackage,
                                    packages: widget.packages,
                                    destination: widget.destination,
                                    dateRange: widget.date,
                                    people: widget.people,
                                  ),
                                ),
                              );
                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffC69214),

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),

                            child: Text(
                              widget.isViewOnly ? "Quay lại" : "Mua ngay",

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
          ],
        ),
      ),
    );
  }

  /// ================= PACKAGE BOX =================
  Widget buildPackageBox({
    required InsurancePackage package,
    required bool isSelected,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(14),

        border: Border.all(
          color: isSelected ? const Color(0xffC69214) : Colors.grey.shade300,

          width: isSelected ? 2 : 1,
        ),
      ),

      child: Stack(
        children: [
          if (isSelected)
            const Positioned(
              top: 0,
              right: 0,

              child: Icon(
                Icons.check_circle,
                color: Color(0xffC69214),
                size: 18,
              ),
            ),

          Column(
            children: [
              Text(
                package.title,

                textAlign: TextAlign.center,

                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 4),

              Text(
                package.subTitle,

                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),

              const SizedBox(height: 10),

              Text(
                package.price,

                textAlign: TextAlign.center,

                style: const TextStyle(
                  color: Color(0xff4F7F4F),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// ================= SECTION =================
  Widget sectionTitle(String text) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.symmetric(vertical: 14),

      color: const Color(0xffDDF5E3),

      child: Text(
        text,

        textAlign: TextAlign.center,

        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  /// ================= ROW =================
  Widget compareRow(
    String left,
    String right,
    String title, {
    bool isRed = false,
  }) {
    return Column(
      children: [
        /// VALUE
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 12, right: 12),

          child: Row(
            children: [
              Expanded(
                child: Text(
                  left,

                  textAlign: TextAlign.center,

                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),

              Expanded(
                child: Text(
                  right,

                  textAlign: TextAlign.center,

                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),

        /// TITLE
        Padding(
          padding: const EdgeInsets.only(
            top: 12,
            bottom: 16,
            left: 20,
            right: 20,
          ),

          child: Text(
            title,

            textAlign: TextAlign.center,

            style: TextStyle(
              fontSize: 13,

              color: isRed ? Colors.red : Colors.black54,

              fontWeight: isRed ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
