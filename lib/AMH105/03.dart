import 'package:flutter/material.dart';
import 'package:my_hdi/AMH105/04.dart';
import 'package:my_hdi/AMH105/05.dart';
import 'package:my_hdi/AMH105/insurance_package.dart';

/// THÊM MODEL Ở ĐÂ

class GoiBaoHiemScreen extends StatefulWidget {
  const GoiBaoHiemScreen({super.key});

  @override
  State<GoiBaoHiemScreen> createState() => _GoiBaoHiemScreenState();
}

class _GoiBaoHiemScreenState extends State<GoiBaoHiemScreen> {
  String destination = "CH Dominica, Hàn Quốc, Ấn Độ.";
  String date = "10 ngày (28/12/2023 - 28/01/2024)";
  String people = "4";
  final List<InsurancePackage> packages = [
    /// ================= PHỔ THÔNG =================
    InsurancePackage(
      title: "Gói Phổ Thông",
      subTitle: "Tiết Kiệm",
      price: "188.000 VNĐ/chuyến",

      benefits: [
        InsuranceBenefit(
          title: "1. Tử vong do tai nạn",
          value: "1.250.000.000 VND",
        ),

        InsuranceBenefit(
          title: "2. Thương tật vĩnh viễn do tai nạn",
          value: "1.100.000.000 VND",
        ),

        InsuranceBenefit(
          title:
              "3. Tử vong do tai nạn khi sử dụng phương tiện vận tải công cộng",
          value: "2.200.000.000 VND",
        ),

        InsuranceBenefit(
          title: "1. Chi phí y tế cho tai nạn và ốm đau",
          value: "1.540.000.000 VND",
        ),

        InsuranceBenefit(
          title: "A. Chi phí điều trị nội trú",
          value: "2.200.000.000 VND",
        ),

        InsuranceBenefit(
          title: "B. Chi phí điều trị ngoại trú",
          value: "1.100.000.000 VND",
        ),

        InsuranceBenefit(
          title:
              "C. Chi phí điều trị cho các biến chứng thai sản phải nằm viện",
          value: "2.200.000.000 VND",
        ),

        InsuranceBenefit(
          title: "D. Chi phí điều trị tiếp theo",
          value: "220.000.000 VND",
        ),
      ],
    ),

    /// ================= CAO CẤP =================
    InsurancePackage(
      title: "Gói Cao Cấp",
      subTitle: "Tối Ưu",
      price: "1.425.000 VNĐ/chuyến",

      benefits: [
        InsuranceBenefit(
          title: "1. Tử vong do tai nạn",
          value: "4.400.000.000 VND",
        ),

        InsuranceBenefit(
          title: "2. Thương tật vĩnh viễn do tai nạn",
          value: "2.200.000.000 VND",
        ),

        InsuranceBenefit(
          title:
              "3. Tử vong do tai nạn khi sử dụng phương tiện vận tải công cộng",
          value: "4.400.000.000 VND",
        ),

        InsuranceBenefit(
          title: "1. Chi phí y tế cho tai nạn và ốm đau",
          value: "1.540.000.000 VND",
        ),

        InsuranceBenefit(
          title: "A. Chi phí điều trị nội trú",
          value: "4.400.000.000 VND",
        ),

        InsuranceBenefit(
          title: "B. Chi phí điều trị ngoại trú",
          value: "4.400.000.000 VND",
        ),

        InsuranceBenefit(
          title:
              "C. Chi phí điều trị cho các biến chứng thai sản phải nằm viện",
          value: "4.400.000.000 VND",
        ),

        InsuranceBenefit(
          title: "D. Chi phí điều trị tiếp theo",
          value: "220.000.000 VND",
        ),
      ],
    ),

    /// ================= THƯỢNG HẠNG =================
    InsurancePackage(
      title: "Gói Thượng Hạng",
      subTitle: "Toàn Diện",
      price: "6.685.000 VNĐ/chuyến",

      benefits: [
        InsuranceBenefit(
          title: "1. Tử vong do tai nạn",
          value: "8.800.000.000 VND",
        ),

        InsuranceBenefit(
          title: "2. Thương tật vĩnh viễn do tai nạn",
          value: "6.600.000.000 VND",
        ),

        InsuranceBenefit(
          title:
              "3. Tử vong do tai nạn khi sử dụng phương tiện vận tải công cộng",
          value: "8.800.000.000 VND",
        ),

        InsuranceBenefit(
          title: "1. Chi phí y tế cho tai nạn và ốm đau",
          value: "6.600.000.000 VND",
        ),

        InsuranceBenefit(
          title: "A. Chi phí điều trị nội trú",
          value: "8.800.000.000 VND",
        ),

        InsuranceBenefit(
          title: "B. Chi phí điều trị ngoại trú",
          value: "6.600.000.000 VND",
        ),

        InsuranceBenefit(
          title:
              "C. Chi phí điều trị cho các biến chứng thai sản phải nằm viện",
          value: "8.800.000.000 VND",
        ),

        InsuranceBenefit(
          title: "D. Chi phí điều trị tiếp theo",
          value: "880.000.000 VND",
        ),
      ],
    ),
  ];
  final PageController _pageController = PageController(viewportFraction: 0.88);

  int currentPage = 0;

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

                  Expanded(
                    child: Center(
                      child: Text(
                        "Gói bảo hiểm",

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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /// ================= LOCATION =================
                    Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(14),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(16),

                        boxShadow: [
                          BoxShadow(
                            blurRadius: 6,
                            color: Colors.black.withOpacity(0.05),
                          ),
                        ],
                      ),

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Image.asset(
                            "assets/image/105/105_bh_1.png",
                            width: 42,
                            height: 42,
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  "Điểm đến:",

                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black54,
                                  ),
                                ),

                                SizedBox(height: 2),

                                Text(
                                  destination,

                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),

                                SizedBox(height: 8),

                                Text(
                                  "Ngày đi: $date",

                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),

                                SizedBox(height: 4),

                                Text(
                                  "Số người: $people người",

                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          GestureDetector(
                            onTap: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const ThongTinChuyenDiScreen(),
                                ),
                              );

                              if (result != null && result is TripInfo) {
                                setState(() {
                                  destination = result.destination;
                                  date = result.date;
                                  people = result.people;
                                });
                              }
                            },

                            child: Text(
                              "Thay đổi",

                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffC69214),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// ================= PAGEVIEW =================
                    SizedBox(
                      height: 660,

                      child: PageView(
                        controller: _pageController,

                        onPageChanged: (index) {
                          setState(() {
                            currentPage = index;
                          });
                        },

                        children: [
                          packageCard(
                            index: 0,
                            bg: "assets/image/105/dong.png",

                            icon: "assets/image/105/105_bh_2.png",

                            title: "Bảo hiểm Phổ thông",

                            subTitle: "Tiết kiệm",

                            price: "145.000 VNĐ/chuyến",

                            bgColor: const Color(0xffDFF6E4),
                          ),

                          packageCard(
                            index: 1,
                            bg: "assets/image/105/bac.png",

                            icon: "assets/image/105/105_bh_3.png",

                            title: "Bảo hiểm gói Cao Cấp",

                            subTitle: "Tối ưu",

                            price: "695.000 VNĐ/chuyến",

                            bgColor: const Color(0xffE6EEF9),
                          ),

                          packageCard(
                            index: 2,
                            bg: "assets/image/105/vang.png",

                            icon: "assets/image/105/105_bh_4.png",

                            title: "Bảo hiểm gói Thượng Hạng",

                            subTitle: "Toàn Diện",

                            price: "695.000 VNĐ/chuyến",

                            bgColor: const Color(0xffFFF3C9),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// ================= INDICATOR =================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: List.generate(
                        3,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),

                          margin: const EdgeInsets.symmetric(horizontal: 4),

                          width: currentPage == index ? 26 : 10,

                          height: 10,

                          decoration: BoxDecoration(
                            color: currentPage == index
                                ? const Color(0xffC69214)
                                : Colors.grey.shade300,

                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// ================= OTHER =================
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          const Text(
                            "Sản phẩm khác",

                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),

                          TextButton(
                            onPressed: () {},

                            child: const Text(
                              "Xem tất cả",

                              style: TextStyle(color: Color(0xffC69214)),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      height: 110,

                      child: ListView(
                        scrollDirection: Axis.horizontal,

                        padding: const EdgeInsets.symmetric(horizontal: 16),

                        children: [
                          otherItem(),

                          const SizedBox(width: 12),

                          otherItem(),

                          const SizedBox(width: 12),

                          otherItem(),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ================= PACKAGE CARD =================
  Widget packageCard({
    required int index,
    required String bg,
    required String icon,
    required String title,
    required String subTitle,
    required String price,
    required Color bgColor,
  }) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 45, 10, 0),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(blurRadius: 8, color: Colors.black.withOpacity(0.06)),
        ],
      ),

      child: Column(
        children: [
          /// TOP
          /// TOP
          Stack(
            clipBehavior: Clip.none,

            children: [
              /// BACKGROUND
              Container(
                height: 160,

                decoration: BoxDecoration(
                  color: bgColor,

                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),

                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),

                  child: Image.asset(
                    bg,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),

              /// ICON LỒI
              Positioned(
                top: -35,
                left: 0,
                right: 0,

                child: Center(child: Image.asset(icon, width: 82, height: 82)),
              ),

              /// TEXT
              Positioned(
                top: 50,
                left: 0,
                right: 0,

                child: Column(
                  children: [
                    Text(
                      title,

                      textAlign: TextAlign.center,

                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      subTitle,

                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      price,

                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff4F7F4F),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          /// TABLE
          Padding(
            padding: const EdgeInsets.all(18),

            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Quyền lợi bảo hiểm",

                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,

                      children: [
                        const Text(
                          "Số tiền bảo hiểm",

                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          "Đơn vị: Việt Nam Đồng",

                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                tableRow("Tử vong, thương tật vĩnh viễn:", "1,25 tỷ"),

                tableRow("Chi phí y tế:", "Lên đến\n1,25 tỷ"),

                tableRow("Trợ cứu y tế:", "1,1 tỷ"),

                tableRow("Bảo hiểm trợ ngại khách", "1,1 tỷ"),

                const SizedBox(height: 16),

                /// DETAIL BUTTON
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChiTietGoiScreen(
                          selectedPackage: packages[index],
                          packages: packages,
                          destination: destination,
                          date: date,
                          people: people,
                        ),
                      ),
                    );
                  },

                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xffC69214),
                  ),

                  iconAlignment: IconAlignment.end,

                  label: const Text(
                    "Xem chi tiết sản phẩm",

                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),

                  icon: const Icon(Icons.keyboard_arrow_right),
                ),

                const SizedBox(height: 8),

                /// BUY BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 50,

                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChiTietGoiScreen(
                            selectedPackage: packages[index],
                            packages: packages,
                            destination: destination,
                            date: date,
                            people: people,
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

                    child: const Text(
                      "Mua ngay",

                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ================= TABLE ROW =================
  Widget tableRow(String left, String right) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),

      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),

      child: Row(
        children: [
          Expanded(
            child: Text(
              left,

              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ),

          Text(
            right,
            textAlign: TextAlign.right,

            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xff4F7F4F),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= OTHER ITEM =================
  Widget otherItem() {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(14),

        border: Border.all(color: Colors.grey.shade200),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Image.asset("assets/image/105/105_bh_5.png", width: 32, height: 32),

          const SizedBox(height: 10),

          const Text(
            "Bảo hiểm tai nạn con người",

            textAlign: TextAlign.center,

            style: TextStyle(fontSize: 13, height: 1.4),
          ),
        ],
      ),
    );
  }
}
