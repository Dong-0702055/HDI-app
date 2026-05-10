import 'package:flutter/material.dart';

class ChiTietSanPhamScreen extends StatefulWidget {
  const ChiTietSanPhamScreen({super.key});

  @override
  State<ChiTietSanPhamScreen> createState() => _ChiTietSanPhamScreenState();
}

class _ChiTietSanPhamScreenState extends State<ChiTietSanPhamScreen> {
  bool isExpand1 = false;
  bool isExpand2 = false;
  bool isExpand3 = false;
  bool isExpand4 = false;

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
                        "Chi tiết sản phẩm",
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

            /// ================= BODY =================
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    /// TITLE
                    const Text(
                      "Tại sao nên mua Bảo hiểm tai nạn con người?",

                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// GRID
                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,

                      shrinkWrap: true,

                      physics: const NeverScrollableScrollPhysics(),

                      childAspectRatio: 0.7,

                      children: [
                        detailItem(
                          image: "assets/image/105/105_chitiet_1.png",

                          title: "Quyền Lợi Vượt Trội Mức Phí Ưu Đãi",

                          content:
                              "An tâm tuyệt đối khi du lịch nước ngoài với quyền lợi bảo vệ phạm vi bảo vệ cao, bảo vệ cả về sức khỏe, tính mạng và tài sản.",
                        ),

                        detailItem(
                          image: "assets/image/105/105_chitiet_2.png",

                          title: "Linh hoạt với giá",

                          content:
                              "Bảo hiểm được áp dụng theo nhu cầu chuyến đi, theo số lần hoặc theo thời hạn bảo hiểm.",
                        ),

                        detailItem(
                          image: "assets/image/105/105_chitiet_3.png",

                          title: "Bồi Thường Đơn Giản Nhanh Chóng",

                          content:
                              "Giải quyết bồi thường trực tuyến thông qua nền tảng số.",
                        ),

                        detailItem(
                          image: "assets/image/105/105_chitiet_4.png",

                          title: "Tư vấn 24/7",

                          content: "Đội ngũ tư vấn hỗ trợ khách hàng mọi lúc.",
                        ),

                        detailItem(
                          image: "assets/image/105/105_chitiet_5.png",

                          title: "Giải Pháp Trực Tuyến Đơn Giản",

                          content:
                              "Mua bảo hiểm nhanh chóng ngay trên website.",
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    /// TITLE 2
                    const Text(
                      "Thông tin chi tiết sản phẩm",

                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// ITEM 1
                    infoTile(
                      title: "Đối tượng tham gia bảo hiểm",

                      isExpand: isExpand1,

                      onTap: () {
                        setState(() {
                          isExpand1 = !isExpand1;
                        });
                      },

                      child: const Text(
                        "Nội dung đang cập nhật...",

                        style: TextStyle(fontSize: 13, height: 1.7),
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// ITEM 2
                    infoTile(
                      title: "Quyền lợi bảo hiểm",

                      isExpand: isExpand2,

                      onTap: () {
                        setState(() {
                          isExpand2 = !isExpand2;
                        });
                      },

                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black87,
                            height: 1.8,
                          ),

                          children: [
                            TextSpan(
                              text:
                                  "a. Quyền lợi bảo hiểm ốm đau, bệnh tật\n\n",

                              style: TextStyle(
                                color: Color(0xff4F7F4F),

                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            TextSpan(
                              text:
                                  "• Chi trả toàn bộ số tiền bảo hiểm cho trường hợp tử vong, thương tật toàn bộ vĩnh viễn;\n\n",
                            ),

                            TextSpan(
                              text:
                                  "• Trợ lý thương tật cho trường hợp thương tật bộ phận vĩnh viễn theo Bảng tỷ lệ trả tiền bảo hiểm kèm theo Quy tắc;\n\n",
                            ),

                            TextSpan(
                              text:
                                  "• Trả chi phí y tế cho trường hợp thương tật tạm thời do tai nạn;\n\n",
                            ),

                            TextSpan(
                              text:
                                  "• Chi trả trợ cấp trong thời gian nằm viện điều trị thương tật do tai nạn.\n\n",
                            ),

                            TextSpan(
                              text:
                                  "• Quý khách vui lòng tham khảo quyền lợi bảo hiểm chi tiết của từng gói bảo hiểm.",

                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// ITEM 3
                    infoTile(
                      title: "Điểm loại trừ bảo hiểm",

                      isExpand: isExpand3,

                      onTap: () {
                        setState(() {
                          isExpand3 = !isExpand3;
                        });
                      },

                      child: const Text(
                        "Nội dung đang cập nhật...",

                        style: TextStyle(fontSize: 13, height: 1.7),
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// ITEM 4
                    infoTile(
                      title: "Tài liệu đính kèm",

                      isExpand: isExpand4,

                      onTap: () {
                        setState(() {
                          isExpand4 = !isExpand4;
                        });
                      },

                      child: Column(
                        children: List.generate(
                          5,
                          (index) => Container(
                            margin: const EdgeInsets.only(bottom: 12),

                            padding: const EdgeInsets.all(14),

                            decoration: BoxDecoration(
                              color: const Color(0xffF7F7F7),

                              borderRadius: BorderRadius.circular(14),
                            ),

                            child: Row(
                              children: [
                                /// ICON
                                Image.asset(
                                  "assets/image/105/105_tailieu.png",
                                  width: 28,
                                  height: 28,
                                ),

                                const SizedBox(width: 14),

                                /// TEXT
                                const Expanded(
                                  child: Text(
                                    "Hướng dẫn yêu cầu bồi thường bảo hiểm bắt buộc TNDS xe cơ giới",

                                    style: TextStyle(
                                      fontSize: 13,
                                      height: 1.5,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 10),

                                /// BUTTON
                                GestureDetector(
                                  onTap: () {},

                                  child: const Column(
                                    children: [
                                      Icon(
                                        Icons.download_outlined,
                                        color: Color(0xffC69214),
                                        size: 28,
                                      ),

                                      SizedBox(height: 4),

                                      Text(
                                        "Tải tài liệu",

                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xffC69214),
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
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ================= GRID ITEM =================
  Widget detailItem({
    required String image,
    required String title,
    required String content,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(14),

        border: Border.all(color: Colors.grey.shade200),

        boxShadow: [
          BoxShadow(blurRadius: 6, color: Colors.black.withOpacity(0.04)),
        ],
      ),

      child: Column(
        children: [
          Image.asset(image, width: 55, height: 55),

          const SizedBox(height: 12),

          Text(
            title,
            textAlign: TextAlign.center,

            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xff4F7F4F),
              height: 1.4,
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: Text(
              content,
              textAlign: TextAlign.center,

              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= INFO TILE =================
  Widget infoTile({
    required String title,
    required bool isExpand,
    required VoidCallback onTap,
    Widget? child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(12),

        border: Border.all(color: Colors.grey.shade200),

        boxShadow: [
          BoxShadow(blurRadius: 5, color: Colors.black.withOpacity(0.03)),
        ],
      ),

      child: Column(
        children: [
          /// HEADER
          GestureDetector(
            onTap: onTap,

            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),

              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,

                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  Icon(
                    isExpand
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                ],
              ),
            ),
          ),

          /// CONTENT
          if (isExpand && child != null)
            Container(
              width: double.infinity,

              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),

              padding: const EdgeInsets.all(14),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),

                border: Border.all(color: const Color(0xffC69214)),
              ),

              child: child,
            ),
        ],
      ),
    );
  }
}
