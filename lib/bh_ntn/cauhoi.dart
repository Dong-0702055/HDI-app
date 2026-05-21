import 'package:flutter/material.dart';
import 'package:my_hdi/utils/app_styles.dart';

class CauHoiScreen extends StatefulWidget {
  const CauHoiScreen({super.key});
  @override
  State<CauHoiScreen> createState() => _CauHoiScreenState();
}

class _CauHoiScreenState extends State<CauHoiScreen> {
  // Lưu index của câu hỏi đang được mở (-1 là đóng hết)
  int _expandedIndex = -1; // Mặc định mở câu đầu tiên như Figma

  final List<Map<String, String>> _faqData = [
    {
      'question': 'Tôi có thể mua bảo hiểm với thời hạn bảo hiểm là bao lâu?',
      'answer':
          'Thời hạn chuẩn của bảo hiểm này là 1 năm và sẽ được tái tục bảo hiểm hàng năm nếu Quý khách có nhu cầu. Trường hợp Quý khách muốn mua bảo hiểm với thời hạn dưới 1 năm hoặc trên 1 năm, Quý khách vui lòng liên hệ trực tiếp với Bảo hiểm HD để được tư vấn.',
    },
    {
      'question': 'Tôi có cần kiểm tra sức khỏe khi tham gia bảo hiểm không?',
      'answer': 'Khách hàng không cần kiểm tra sức khỏe khi tham gia bảo hiểm này. Tuy nhiên, tùy theo từng trường hợp cụ thể, HDI có thể yêu cầu bổ sung thông tin.',
    },
    {
      'question': 'Tôi có thể mua bảo hiểm ở đâu?',
      'answer': 'Quý khách có thể mua bảo hiểm trực tuyến qua website chính thức của HDI, qua ứng dụng di động, hoặc liên hệ trực tiếp các văn phòng/đại lý của HDI trên toàn quốc.',
    },
    {
      'question': 'Thời gian chờ trong bảo hiểm sức khoẻ là gì?',
      'answer': 'Thời gian chờ là khoảng thời gian kể từ khi hợp đồng có hiệu lực đến khi quyền lợi bảo hiểm được áp dụng. Đối với các bệnh đặc biệt, thời gian chờ có thể khác nhau.',
    },
    {
      'question': 'Phí bảo hiểm có bị thay đổi trong thời hạn bảo hiểm không?',
      'answer': 'Phí bảo hiểm sẽ không thay đổi trong suốt thời hạn hợp đồng 1 năm. Khi tái tục, phí có thể được điều chỉnh dựa trên chính sách hiện hành của HDI.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text('Câu hỏi', style: AppStyles.n(size: 18, weight: FontWeight.w700, color: Colors.black)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, color: Colors.black,)
            ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        itemCount: _faqData.length,
        itemBuilder: (context, index) {
          final isExpanded = _expandedIndex == index;
          return _buildFaqItem(index, isExpanded);
        },
      ),
    );
  }

  Widget _buildFaqItem(int index, bool isExpanded) {
    final item = _faqData[index];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // Viền vàng xuất hiện khi mở rộng
        border: Border.all(
          color: isExpanded ? const Color(0xFFBB8A0B) : Colors.transparent,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Phần tiêu đề câu hỏi
          InkWell(
            onTap: () {
              setState(() {
                _expandedIndex = isExpanded ? -1 : index;
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      item['question']!,
                      style: AppStyles.n(
                        size: 15,
                        weight: FontWeight.w700,
                        color: const Color(0xFF1B5E20), // Màu xanh đậm Figma
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: isExpanded ? const Color(0xFFBB8A0B) : const Color(0xFF666666),
                  ),
                ],
              ),
            ),
          ),
          // Phần nội dung trả lời (Animated)
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Dấu chấm đầu dòng (Bullet)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(
                        color: Color(0xFF444444),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Nội dung text
                  Expanded(
                    child: Text(
                      item['answer']!,
                      style: AppStyles.n(
                        size: 14,
                        color: const Color(0xFF666666),
                        height: 1.6,
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
}