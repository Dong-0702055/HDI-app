import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Ahm02 extends StatefulWidget {
  const Ahm02({super.key});

  @override
  State<Ahm02> createState() => _Ahm02State();
}

class _Ahm02State extends State<Ahm02> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF007A3E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Chi tiết sản phẩm",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: Why should buy
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Tại sao nên mua Bảo hiểm tai nạn con người?",
                    style: TextStyle(
                      color: Color(0xFFD32F2F),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Benefit Grid (2x2)
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.85,
                    children: [
                      _buildBenefitCard(
                        "Quyền Lợi Vượt Trội Mức Phí Ưu Đãi",
                        "An tâm tuyệt đối khi du lịch nước ngoài với quyền lợi đa dạng, phạm vi bảo vệ cao, bảo vệ cả về sức khỏe, tính mạng và tài sản.",
                        "assets/image/AHM-104/5.png", // Placeholder
                      ),
                      _buildBenefitCard(
                        "Linh hoạt thời gian",
                        "Bảo hiểm được áp dụng theo thời hạn chuyến đi, tối đa lên tới 90 ngày, giúp bạn linh hoạt trong kế hoạch cho chuyến đi dài hạn",
                        "assets/image/AHM-104/6.png", // Placeholder
                      ),
                      _buildBenefitCard(
                        "Bồi Thường Đơn Giản, Nhanh Chóng",
                        "Giải quyết bồi thường trực tuyến thuận tiện và nhanh chóng trong vòng 15 ngày làm việc.",
                        "assets/image/AHM-104/7.png", // Placeholder
                      ),
                      _buildBenefitCard(
                        "Tư vấn 24/7",
                        "Dù bạn ở bất kỳ nơi đâu, bất kỳ lúc nào, đội ngũ tư vấn luôn sẵn sàng hỗ trợ bạn giải quyết mọi vấn đề nhanh chóng",
                        "assets/image/AHM-104/8.png", // Placeholder
                      ),
                      _buildFullWidthBenefitCard(
                        "Giải Pháp Trực Tuyến Đơn Giản, Dễ Hiểu",
                        "Số hóa giấy chứng nhận điện tử, quản lý và gia hạn hợp đồng ngay trên website của Bảo Hiểm HD",
                        "assets/image/AHM-104/9.png", // Placeholder
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(thickness: 8, color: Color(0xFFF5F5F5)),

            // Section: Detailed Info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: const Text(
                "Thông tin chi tiết sản phẩm",
                style: TextStyle(
                  color: Color(0xFFD32F2F),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            _buildExpansionTile("Đối tượng tham gia bảo hiểm", [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Là công dân Việt Nam hoặc người mang quốc tịch nước ngoài đang sinh sống và làm việc hợp pháp tại Việt Nam.",
                  style: TextStyle(fontSize: 14, color: Color(0xFF444444)),
                ),
              ),
            ]),

            _buildExpansionTile("Quyền lợi bảo hiểm", [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "a. Quyền lợi bảo hiểm ốm đau, bệnh tật:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF007A3E),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildBulletPoint(
                      "Chi trả toàn bộ số tiền bảo hiểm cho trường hợp tử vong, thương tật toàn bộ vĩnh viễn;",
                    ),
                    _buildBulletPoint(
                      "Trả tỷ lệ thương tật cho trường hợp thương tật bộ phận vĩnh viễn theo Bảng tỷ lệ trả tiền bảo hiểm kèm theo Quy tắc;",
                    ),
                    _buildBulletPoint(
                      "Trả chi phí y tế cho trường hợp thương tật tạm thời do tai nạn;",
                    ),
                    _buildBulletPoint(
                      "Chi trả tiền trợ cấp trong thời gian nằm viện điều trị thương tật do tai nạn.",
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "● Quý khách vui lòng tham khảo quyền lợi bảo hiểm chi tiết của từng gói bảo hiểm.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ], isExpanded: true),

            _buildExpansionTile("Điểm loại trừ bảo hiểm", [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Nội dung điểm loại trừ bảo hiểm..."),
              ),
            ]),

            _buildExpansionTile("Tài liệu đính kèm", [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    _buildFileDownloadItem(
                      "Hướng dẫn yêu cầu bồi thường bảo hiểm bắt buộc TNDS xe cơ giới",
                    ),
                    _buildFileDownloadItem(
                      "Hướng dẫn yêu cầu bồi thường bảo hiểm bắt buộc TNDS xe cơ giới",
                    ),
                    _buildFileDownloadItem(
                      "Hướng dẫn yêu cầu bồi thường bảo hiểm bắt buộc TNDS xe cơ giới",
                    ),
                    _buildFileDownloadItem(
                      "Hướng dẫn yêu cầu bồi thường bảo hiểm bắt buộc TNDS xe cơ giới",
                    ),
                    _buildFileDownloadItem(
                      "Hướng dẫn yêu cầu bồi thường bảo hiểm bắt buộc TNDS xe cơ giới",
                    ),
                  ],
                ),
              ),
            ]),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitCard(String title, String description, String iconPath) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            iconPath,
            height: 45,
            width: 45,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.security, color: Color(0xFF007A3E), size: 40),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF007A3E),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF666666),
                fontSize: 10,
                height: 1.3,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullWidthBenefitCard(
    String title,
    String description,
    String iconPath,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            iconPath,
            height: 45,
            width: 45,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.computer, color: Color(0xFF007A3E), size: 40),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF007A3E),
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF666666),
              fontSize: 11,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpansionTile(
    String title,
    List<Widget> children, {
    bool isExpanded = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isExpanded ? const Color(0xFFBB8A0B) : const Color(0xFFEEEEEE),
        ),
      ),
      child: ExpansionTile(
        initiallyExpanded: isExpanded,
        shape: const RoundedRectangleBorder(side: BorderSide.none),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        iconColor: Colors.grey,
        collapsedIconColor: Colors.grey,
        children: children,
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("● ", style: TextStyle(fontSize: 12)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF444444),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFileDownloadItem(String fileName) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.description, color: Color(0xFFBB8A0B), size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              fileName,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF444444),
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          Column(
            children: const [
              Icon(
                Icons.file_download_outlined,
                color: Color(0xFFBB8A0B),
                size: 20,
              ),
              Text(
                "Tải tài liệu",
                style: TextStyle(fontSize: 8, color: Color(0xFFBB8A0B)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
