import 'package:flutter/material.dart';
import 'package:my_hdi/AMH105/02.dart';
import 'package:my_hdi/AMH105/03.dart';

class Screen01 extends StatefulWidget {
  const Screen01({super.key});

  @override
  State<Screen01> createState() => _Screen01State();
}

class _Screen01State extends State<Screen01> {
  final PageController _pageController = PageController();

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// LABEL 1 : BANNER
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 280,
                    child: Image.asset(
                      "assets/image/105/105_nen.png",
                      fit: BoxFit.cover,
                    ),
                  ),

                  Positioned(
                    top: 20,
                    left: 16,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 45,
                        height: 45,

                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),

                        child: const Icon(
                          Icons.arrow_back,
                          color: Color(0xffC69214),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    right: 16,
                    bottom: 20,

                    child: ElevatedButton.icon(
                      onPressed: () {},

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffC69214),

                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),

                      icon: const Icon(Icons.play_arrow),

                      label: const Text(
                        "Xem giới thiệu",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),

              /// LABEL 2 : CARD INFO
              Transform.translate(
                offset: const Offset(0, -20),

                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),

                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.05),
                      ),
                    ],
                  ),

                  child: SizedBox(
                    height: 370,

                    child: Column(
                      children: [
                        /// PAGEVIEW
                        Expanded(
                          child: PageView(
                            controller: _pageController,

                            onPageChanged: (index) {
                              setState(() {
                                currentPage = index;
                              });
                            },

                            children: [
                              /// ================= PAGE 1 =================
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// TITLE
                                  Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          "Bảo hiểm du lịch quốc tế",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),

                                      Image.asset(
                                        "assets/image/105/105_ic_3.png",
                                        width: 28,
                                        height: 28,
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 12),

                                  /// VECTOR
                                  Image.asset(
                                    "assets/image/105/105_vt_kengang.png",
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),

                                  const SizedBox(height: 20),

                                  /// ITEM 1
                                  itemInfo(
                                    icon: "assets/image/105/105_ic_4.png",

                                    child: const Text(
                                      "Bảo hiểm du lịch quốc tế sẽ là người bạn đồng hành không thể thiếu của bạn.",
                                      style: TextStyle(
                                        fontSize: 13,
                                        height: 1.5,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  /// ITEM 2
                                  itemInfo(
                                    icon: "assets/image/105/105_ic_4.png",

                                    child: const Text(
                                      "Được thiết kế phù hợp với khả năng tài chính và nhu cầu của bạn.",
                                      style: TextStyle(
                                        fontSize: 13,
                                        height: 1.5,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  /// ITEM 3
                                  itemInfo(
                                    icon: "assets/image/105/105_ic_4.png",

                                    child: const Text(
                                      "Bạn và gia đình sẽ an tâm tuyệt đối khi đi du lịch.",
                                      style: TextStyle(
                                        fontSize: 13,
                                        height: 1.5,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 24),

                                  /// BUTTON
                                  Center(
                                    child: TextButton.icon(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ChiTietSanPhamScreen(),
                                          ),
                                        );
                                      },

                                      style: TextButton.styleFrom(
                                        foregroundColor: const Color(
                                          0xffC69214,
                                        ),
                                      ),

                                      iconAlignment: IconAlignment.end,

                                      label: const Text(
                                        "Xem chi tiết sản phẩm",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),

                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              /// ================= PAGE 2 =================
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// TITLE
                                  Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          "Đối tượng tham gia bảo hiểm\n& Quy tắc bảo hiểm",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                            height: 1.4,
                                          ),
                                        ),
                                      ),

                                      Image.asset(
                                        "assets/image/105/105_ic_3.png",
                                        width: 28,
                                        height: 28,
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 12),

                                  /// VECTOR
                                  Image.asset(
                                    "assets/image/105/105_vt_kengang.png",
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),

                                  const SizedBox(height: 12),

                                  /// ITEM 1
                                  itemInfo(
                                    icon: "assets/image/105/105_ic_4.png",

                                    child: RichText(
                                      text: const TextSpan(
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black87,
                                          height: 1.3,
                                        ),

                                        children: [
                                          TextSpan(
                                            text:
                                                "Đối tượng tham gia bảo hiểm:\n",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff4F7F4F),
                                              fontSize: 13,
                                            ),
                                          ),

                                          TextSpan(
                                            text:
                                                "Công dân Việt Nam hoặc người mang quốc tịch nước ngoài nhập cảnh hợp pháp vào lãnh thổ Việt Nam từ đủ 14 ngày tuổi đến 80 tuổi có nhu cầu đi du lịch, công tác, thăm người thân hay học tập ở nước ngoài.",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 12),

                                  /// ITEM 2
                                  itemInfo(
                                    icon: "assets/image/105/105_ic_4.png",

                                    child: const Text(
                                      "Thời hạn bảo hiểm: tối đa 90 ngày",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff4F7F4F),
                                        height: 1.3,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 12),

                                  /// ITEM 3
                                  itemInfo(
                                    icon: "assets/image/105/105_ic_4.png",

                                    child: RichText(
                                      text: const TextSpan(
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black87,
                                          height: 1.3,
                                        ),

                                        children: [
                                          TextSpan(
                                            text: "Hình thức hợp đồng\n",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff4F7F4F),
                                              fontSize: 13,
                                            ),
                                          ),

                                          TextSpan(
                                            text:
                                                "Giấy chứng nhận bảo hiểm điện tử",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 12),

                                  /// FOOTER
                                  Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      const Text(
                                        "Quy tắc, điều khoản bảo hiểm. Tham khảo ",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black54,
                                        ),
                                      ),

                                      TextButton(
                                        onPressed: () {},

                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          minimumSize: const Size(0, 0),
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),

                                        child: const Text(
                                          "Tại đây",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xffC69214),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              /// ================= PAGE 3 =================
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// TITLE
                                  Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          "Đối tượng tham gia bảo hiểm\n& Quy tắc bảo hiểm",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                            height: 1.4,
                                          ),
                                        ),
                                      ),

                                      Image.asset(
                                        "assets/image/105/105_ic_3.png",
                                        width: 28,
                                        height: 28,
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 12),

                                  /// VECTOR
                                  Image.asset(
                                    "assets/image/105/105_vt_kengang.png",
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),

                                  const SizedBox(height: 12),

                                  /// ITEM 1
                                  itemInfo(
                                    icon: "assets/image/105/105_ic_4.png",

                                    child: RichText(
                                      text: const TextSpan(
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black87,
                                          height: 1.3,
                                        ),

                                        children: [
                                          TextSpan(
                                            text:
                                                "Đối tượng tham gia bảo hiểm:\n",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff4F7F4F),
                                              fontSize: 13,
                                            ),
                                          ),

                                          TextSpan(
                                            text:
                                                "Công dân Việt Nam hoặc người mang quốc tịch nước ngoài nhập cảnh hợp pháp vào lãnh thổ Việt Nam từ đủ 14 ngày tuổi đến 80 tuổi có nhu cầu đi du lịch, công tác, thăm người thân hay học tập ở nước ngoài.",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 12),

                                  /// ITEM 2
                                  itemInfo(
                                    icon: "assets/image/105/105_ic_4.png",

                                    child: const Text(
                                      "Thời hạn bảo hiểm: tối đa 90 ngày",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff4F7F4F),
                                        height: 1.3,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 12),

                                  /// ITEM 3
                                  itemInfo(
                                    icon: "assets/image/105/105_ic_4.png",

                                    child: RichText(
                                      text: const TextSpan(
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black87,
                                          height: 1.3,
                                        ),

                                        children: [
                                          TextSpan(
                                            text: "Hình thức hợp đồng\n",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff4F7F4F),
                                              fontSize: 13,
                                            ),
                                          ),

                                          TextSpan(
                                            text:
                                                "Giấy chứng nhận bảo hiểm điện tử",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 12),

                                  /// FOOTER
                                  Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      const Text(
                                        "Quy tắc, điều khoản bảo hiểm. Tham khảo ",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black54,
                                        ),
                                      ),

                                      TextButton(
                                        onPressed: () {},

                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          minimumSize: const Size(0, 0),
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),

                                        child: const Text(
                                          "Tại đây",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xffC69214),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// ================= INDICATOR =================
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: List.generate(
                            3,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),

                              margin: const EdgeInsets.symmetric(horizontal: 4),

                              width: currentPage == index ? 28 : 10,
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
                      ],
                    ),
                  ),
                ),
              ),

              /// LABEL 3 : BUTTONS
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),

                child: Row(
                  children: [
                    /// BUTTON BỒI THƯỜNG
                    Expanded(
                      child: actionButton(
                        iconPath: "assets/image/105/105_ic_1.png",
                        title: "Bồi thường",

                        onTap: () {
                          showModalBottomSheet(
                            context: context,

                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,

                            builder: (context) {
                              return DraggableScrollableSheet(
                                initialChildSize: 0.88,
                                minChildSize: 0.88,
                                maxChildSize: 0.88,

                                builder: (context, scrollController) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,

                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(28),
                                      ),
                                    ),

                                    child: SingleChildScrollView(
                                      controller: scrollController,

                                      child: Padding(
                                        padding: const EdgeInsets.all(20),

                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            /// THANH KÉO
                                            Container(
                                              width: 50,
                                              height: 5,

                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade300,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),

                                            const SizedBox(height: 20),

                                            /// HEADER
                                            Row(
                                              children: [
                                                const Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      "Bồi thường",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },

                                                  child: const Icon(
                                                    Icons.close,
                                                    size: 24,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            const SizedBox(height: 20),

                                            /// CONTENT BOX
                                            Container(
                                              padding: const EdgeInsets.all(14),

                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16),

                                                border: Border.all(
                                                  color: const Color(
                                                    0xffC69214,
                                                  ),
                                                ),
                                              ),

                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,

                                                children: [
                                                  /// TITLE
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,

                                                    children: [
                                                      const Text(
                                                        "Quy trình xử lý bồi thường",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.red,
                                                        ),
                                                      ),

                                                      const Icon(
                                                        Icons.keyboard_arrow_up,
                                                      ),
                                                    ],
                                                  ),

                                                  const SizedBox(height: 16),

                                                  /// ITEM 1
                                                  claimItem(
                                                    image:
                                                        "assets/image/105/105_ic_boithuong_1.png",

                                                    title:
                                                        "1. Thanh toán và thu thập",

                                                    content:
                                                        "Liên hệ thông báo tổn thất với HDI trong thời gian sớm nhất không muộn hơn 30 ngày xảy ra tai nạn.",
                                                  ),

                                                  const SizedBox(height: 10),

                                                  /// ITEM 2
                                                  claimItem(
                                                    image:
                                                        "assets/image/105/105_ic_boithuong_2.png",

                                                    title: "2. Nộp hồ sơ",

                                                    content:
                                                        "Nộp hồ sơ yêu cầu bồi thường trong vòng 30 ngày kể từ ngày khám chữa bệnh đầu tiên.",
                                                  ),

                                                  const SizedBox(height: 10),

                                                  /// ITEM 3
                                                  claimItem(
                                                    image:
                                                        "assets/image/105/105_ic_boithuong_3.png",

                                                    title:
                                                        "3. Giải quyết yêu cầu",

                                                    content:
                                                        "HDI giải quyết hồ sơ và hoàn trả chi phí khám chữa bệnh trong vòng 15 ngày làm việc.",
                                                  ),

                                                  const SizedBox(height: 10),

                                                  /// BUTTON
                                                  Center(
                                                    child: TextButton.icon(
                                                      onPressed: () {},

                                                      style:
                                                          TextButton.styleFrom(
                                                            foregroundColor:
                                                                const Color(
                                                                  0xffC69214,
                                                                ),
                                                          ),

                                                      iconAlignment:
                                                          IconAlignment.end,

                                                      label: const Text(
                                                        "Xem chi tiết",
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),

                                                      icon: const Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        size: 18,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),

                    const SizedBox(width: 16),

                    /// BUTTON CÂU HỎI
                    Expanded(
                      child: actionButton(
                        iconPath: "assets/image/105/105_ic_2.png",
                        title: "Câu hỏi",

                        onTap: () {
                          showModalBottomSheet(
                            context: context,

                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,

                            builder: (context) {
                              return DraggableScrollableSheet(
                                initialChildSize: 0.88,
                                minChildSize: 0.88,
                                maxChildSize: 0.88,

                                builder: (context, scrollController) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,

                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(28),
                                      ),
                                    ),

                                    child: Padding(
                                      padding: const EdgeInsets.all(20),

                                      child: Column(
                                        children: [
                                          /// THANH KÉO
                                          Container(
                                            width: 50,
                                            height: 5,

                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),

                                          const SizedBox(height: 20),

                                          /// HEADER
                                          Row(
                                            children: [
                                              const Expanded(
                                                child: Center(
                                                  child: Text(
                                                    "Câu hỏi",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },

                                                child: const Icon(
                                                  Icons.close,
                                                  size: 24,
                                                ),
                                              ),
                                            ],
                                          ),

                                          const SizedBox(height: 20),

                                          /// LIST
                                          Expanded(
                                            child: ListView(
                                              controller: scrollController,

                                              children: [
                                                /// ITEM 1
                                                questionItem(
                                                  title:
                                                      "Tôi có thể mua bảo hiểm với thời hạn bảo hiểm là bao lâu?",

                                                  content:
                                                      "Thời hạn của bảo hiểm này là 1 năm và sẽ được tái tục bảo hiểm hàng năm nếu Quý khách có nhu cầu. Trường hợp Quý khách muốn mua mua bảo hiểm với thời hạn bảo hiểm dưới 1 năm hoặc trên 1 năm, Quý khách vui lòng liên hệ trực tiếp với Bảo hiểm HD để được tư vấn.",
                                                ),

                                                const SizedBox(height: 12),

                                                questionItem(
                                                  title:
                                                      "Tôi có cần kiểm tra sức khỏe khi tham gia bảo hiểm không?",
                                                ),

                                                const SizedBox(height: 12),

                                                questionItem(
                                                  title:
                                                      "Tôi có thể mua bảo hiểm ở đâu?",
                                                ),

                                                const SizedBox(height: 12),

                                                questionItem(
                                                  title:
                                                      "Thời gian chờ trong bảo hiểm sức khỏe là gì?",
                                                ),

                                                const SizedBox(height: 12),

                                                questionItem(
                                                  title:
                                                      "Phí bảo hiểm có bị thay đổi trong thời hạn bảo hiểm không?",
                                                ),

                                                const SizedBox(height: 12),

                                                questionItem(
                                                  title:
                                                      "Tôi có phải đóng thêm khoản phụ lệ phí nào ngoài phí bảo hiểm không?",
                                                ),

                                                const SizedBox(height: 12),

                                                questionItem(
                                                  title:
                                                      "Phí bảo hiểm có bị thay đổi trong thời hạn bảo hiểm không?",
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// LABEL 4 : BUTTON
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),

                child: SizedBox(
                  width: double.infinity,
                  height: 45,

                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GoiBaoHiemScreen(),
                        ),
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffC69214),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),

                    child: const Text(
                      "Tham gia ngay",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  /// ================= ITEM INFO =================
  Widget itemInfo({required String icon, required Widget child}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(icon, width: 28, height: 28),

        const SizedBox(width: 14),

        Expanded(child: child),
      ],
    );
  }

  /// ================= BUTTON =================
  Widget actionButton({
    required String iconPath,
    required String title,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        height: 40,

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            Image.asset(iconPath, width: 26, height: 26),

            Expanded(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,

                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const Icon(Icons.arrow_forward, size: 18),
          ],
        ),
      ),
    );
  }

  /// ================= CLAIM ITEM =================
  Widget claimItem({
    required String image,
    required String title,
    required String content,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: const Color(0xffF7F7F7),
        borderRadius: BorderRadius.circular(14),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(image, width: 56, height: 56),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff4F7F4F),
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ================= QUESTION ITEM =================
  Widget questionItem({required String title, String? content}) {
    bool isExpand = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius: BorderRadius.circular(14),

            border: Border.all(color: Colors.grey.shade200),

            boxShadow: [
              BoxShadow(blurRadius: 6, color: Colors.black.withOpacity(0.03)),
            ],
          ),

          child: Column(
            children: [
              /// HEADER
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpand = !isExpand;
                  });
                },

                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),

                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,

                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff4F7F4F),
                            height: 1.5,
                          ),
                        ),
                      ),

                      Icon(
                        isExpand
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,

                        color: Colors.black87,
                      ),
                    ],
                  ),
                ),
              ),

              /// CONTENT
              if (isExpand && content != null)
                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),

                  child: Text(
                    "• $content",

                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black87,
                      height: 1.7,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
