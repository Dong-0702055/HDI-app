import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'ahm02.dart';
import 'ahm03.dart';

class Ahm01 extends StatefulWidget {
  const Ahm01({super.key});

  @override
  State<Ahm01> createState() => _Ahm01State();
}

class _Ahm01State extends State<Ahm01> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Stack(
        children: [
          // 1. Fixed Header Image
          Column(
            children: [
              SizedBox(
                height: screenHeight * 0.28,
                width: double.infinity,
                child: Image.asset(
                  "assets/image/AHM-104/1.png",
                  fit: BoxFit.cover,
                ),
              ),

              // Main Content Card
              Expanded(
                child: Transform.translate(
                  offset: const Offset(0, -30),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Swipable Content
                        Expanded(
                          child: PageView(
                            controller: _pageController,
                            onPageChanged: (index) =>
                                setState(() => _currentPage = index),
                            children: [
                              _buildPage01(),
                              _buildPage02(),
                              _buildPage03(),
                            ],
                          ),
                        ),

                        // Dots
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              3,
                              (index) => _buildDot(index),
                            ),
                          ),
                        ),

                        // Tooltip
                      ],
                    ),
                  ),
                ),
              ),

              // Bottom Buttons Row
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => _showBoiThuongSheet(context),
                        child: _buildSecondaryButton(
                          "Bồi thường",
                          "assets/image/AHM-104/icon1.svg",
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: InkWell(
                        onTap: () => _showCauHoiSheet(context),
                        child: _buildSecondaryButton(
                          "Câu hỏi",
                          "assets/image/AHM-104/icon2.svg",
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Fixed Participation Button
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 25),
                child: SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Ahm03()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFBB8A0B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 2,
                    ),
                    child: const Text(
                      "Tham gia ngay",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Back Button
          Positioned(
            top: 50,
            left: 20,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 18,
                child: Icon(Icons.arrow_back, color: Colors.black, size: 20),
              ),
            ),
          ),

          // Video Label
          Positioned(
            top: screenHeight * 0.22,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Row(
                children: [
                  Icon(Icons.play_arrow, color: Colors.white, size: 14),
                  SizedBox(width: 4),
                  Text(
                    "Xem video",
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Page 1 Content ---
  Widget _buildPage01() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  "Bảo hiểm du lịch Việt Nam",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD32F2F),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 4, left: 10),
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.grey,
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Divider(thickness: 1),
          const SizedBox(height: 15),
          _buildFeatureItem(
            "Bảo hiểm du lịch Việt Nam sẽ là người bạn đồng hành không thể thiếu của bạn trong mọi chuyến tham quan, nghỉ mát, thăm viếng, tham gia hội thảo trong lãnh thổ Việt Nam.",
          ),
          const SizedBox(height: 15),
          _buildFeatureItem(
            "Được thiết kế phù hợp với khả năng tài chính và nhu cầu của bạn, với quyền lợi bảo hiểm đa dạng, phạm vi bảo vệ toàn diện, bảo vệ bạn trước những rủi ro xảy ra trong chuyến đi như tai nạn, ốm đau, bệnh tật.",
          ),
          const Spacer(),
          Center(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Ahm02()),
                );
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Xem chi tiết sản phẩm",
                    style: TextStyle(
                      color: Color(0xFFBB8A0B),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFFBB8A0B),
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  // --- Page 2 Content ---
  Widget _buildPage02() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  "Đối tượng tham gia bảo hiểm & Quy tắc bảo hiểm",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD32F2F),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 4, left: 10),
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.grey,
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Divider(thickness: 1),
          const SizedBox(height: 15),
          _buildFeatureItem(
            "Đối tượng tham gia bảo hiểm:",
            subtitle:
                "Là công dân Việt Nam hoặc người mang quốc tịch nước ngoài nhập cảnh hợp pháp vào lãnh thổ Việt Nam. Cho người đi tham quan, nghỉ mát, thăm viếng, tham gia hội thảo trong phạm vi lãnh thổ Việt Nam.",
            isTitleGreen: true,
          ),
          _buildFeatureItem(
            "Thời hạn bảo hiểm: tối đa 30 ngày",
            isTitleGreen: true,
          ),
          const SizedBox(height: 12),
          _buildFeatureItem(
            "Hình thức hợp đồng",
            subtitle: "Giấy chứng nhận bảo hiểm điện tử",
            isTitleGreen: true,
          ),
          const Spacer(),
          const Center(
            child: Text.rich(
              TextSpan(
                text: "Quy tắc, điều khoản bảo hiểm. Tham khảo ",
                style: TextStyle(color: Colors.black, fontSize: 13),
                children: [
                  TextSpan(
                    text: "Tại đây",
                    style: TextStyle(
                      color: Color(0xFFBB8A0B),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  // --- Page 3 Content ---
  Widget _buildPage03() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  "Tổng kết thông tin",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD32F2F),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 4, left: 10),
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.grey,
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Divider(thickness: 1),
          const SizedBox(height: 15),
          _buildFeatureItem(
            "Vui lòng kiểm tra kỹ các thông tin về quyền lợi và phạm vi bảo hiểm trước khi nhấn nút Tham gia ngay.",
          ),
          const SizedBox(height: 15),
          _buildFeatureItem(
            "Mọi thắc mắc vui lòng nhấn vào nút Câu hỏi hoặc liên hệ Hotline để được hỗ trợ 24/7.",
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(
    String text, {
    String? subtitle,
    bool isTitleGreen = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          "assets/image/AHM-104/icon3.svg",
          width: 22,
          height: 22,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  color: isTitleGreen
                      ? const Color(0xFF4CAF50)
                      : const Color(0xFF444444),
                  fontWeight: isTitleGreen || subtitle != null
                      ? FontWeight.bold
                      : FontWeight.normal,
                  height: 1.4,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF444444),
                    height: 1.4,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDot(int index) {
    bool isActive = _currentPage == index;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      height: 5,
      width: isActive ? 20 : 5,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFBB8A0B) : const Color(0xFFD0D0D0),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  Widget _buildTooltip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF333333),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 10),
      ),
    );
  }

  // --- Bottom Sheets ---

  void _showBoiThuongSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildSheetContainer(
        context,
        "Bồi thường",
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFBB8A0B), width: 1.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Quy trình xử lý bồi thường",
                        style: TextStyle(
                          color: Color(0xFFD32F2F),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_up, color: Colors.grey),
                    ],
                  ),
                  const SizedBox(height: 15),
                  _buildBoiThuongStep(
                    "1. Thanh toán và thu thập",
                    "Liên hệ thông báo tổn thất với HDI trong thời gian sớm nhất không muộn hơn 30 ngày xảy ra tai nạn.",
                    "assets/image/AHM-104/4.png",
                  ),
                  const SizedBox(height: 10),
                  _buildBoiThuongStep(
                    "2. Nộp hồ sơ",
                    "Nộp hồ sơ yêu cầu bồi thường trong vòng 30 ngày kể từ ngày khám chữa bệnh đầu tiên.",
                    "assets/image/AHM-104/2.png",
                  ),
                  const SizedBox(height: 10),
                  _buildBoiThuongStep(
                    "3. Giải quyết yêu cầu",
                    "HDI giải quyết hồ sơ và hoàn trả chi phí khám chữa bệnh trong vòng 15 ngày làm việc.",
                    "assets/image/AHM-104/3.png",
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Xem chi tiết",
                        style: TextStyle(
                          color: Color(0xFFBB8A0B),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down, color: Color(0xFFBB8A0B)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCauHoiSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildSheetContainer(
        context,
        "Câu hỏi",
        Column(
          children: [
            _buildFAQItem(
              "Tôi có thể mua bảo hiểm với thời hạn bảo hiểm là bao lâu?",
              answer:
                  "Thời hạn chuẩn của bảo hiểm này là 1 năm và sẽ được tái tục bảo hiểm hàng năm nếu Quý khách có nhu cầu. Trường hợp Quý khách muốn mua mua bảo hiểm với thời hạn bảo hiểm dưới 1 năm hoặc trên 1 năm, Quý khách vui lòng liên hệ trực tiếp với Bảo hiểm HD để được tư vấn.",
              isExpanded: true,
            ),
            _buildFAQItem(
              "Tôi có cần kiểm tra sức khỏe khi tham gia bảo hiểm không?",
            ),
            _buildFAQItem("Tôi có thể mua bảo hiểm ở đâu?"),
            _buildFAQItem("Thời gian chờ trong bảo hiểm sức khoẻ là gì?"),
            _buildFAQItem(
              "Phí bảo hiểm có bị thay đổi trong thời hạn bảo hiểm không?",
            ),
            _buildFAQItem(
              "Tôi có phải đóng thêm khoản phí/ lệ phí nào ngoài phí bảo hiểm không?",
            ),
            _buildFAQItem(
              "Phí bảo hiểm có bị thay đổi trong thời gian bảo hiểm không ?",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSheetContainer(
    BuildContext context,
    String title,
    Widget content,
  ) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 24),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                controller: controller,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [content],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBoiThuongStep(String title, String desc, String icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 65,
            height: 65,
            child: Image.asset(
              icon,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Icon(Icons.error_outline, color: Colors.red, size: 24),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4CAF50),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  desc,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF666666),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem(
    String question, {
    String? answer,
    bool isExpanded = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: isExpanded ? Border.all(color: const Color(0xFFBB8A0B)) : null,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5),
        ],
      ),
      child: ExpansionTile(
        initiallyExpanded: isExpanded,
        title: Text(
          question,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        textColor: const Color(0xFF4CAF50),
        iconColor: const Color(0xFF4CAF50),
        collapsedTextColor: const Color(0xFF333333),
        collapsedIconColor: Colors.grey,
        children: [
          if (answer != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                answer,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF666666),
                  height: 1.5,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSecondaryButton(String title, String svgAsset) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SvgPicture.asset(svgAsset, width: 22, height: 22),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 10),
        ],
      ),
    );
  }
}
