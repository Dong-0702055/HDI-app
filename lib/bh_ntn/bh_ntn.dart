import 'package:flutter/material.dart';
import 'package:my_hdi/BH_NTN/boithuong.dart';
import 'package:my_hdi/BH_NTN/cauhoi.dart';
import 'package:my_hdi/BH_NTN/chitietsanpham.dart';
import 'package:my_hdi/BH_NTN/thamgia.dart';
import 'package:my_hdi/utils/app_styles.dart';

// ═══════════════════════════════════════════════════════════════
//  MAIN SCREEN
// ═══════════════════════════════════════════════════════════════
class BH_NTN extends StatefulWidget {
  const BH_NTN({super.key});
  @override
  State<BH_NTN> createState() => _BH_NTNState();
}

class _BH_NTNState extends State<BH_NTN> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  final List<Map<String, dynamic>> _pages = [
    {
      'title': 'Bảo hiểm nhà tư nhân',
      'type': 'description',
      'items': [
        'Bảo hiểm HD nhận thức được rằng ngôi nhà không chỉ quý về vật chất mà còn là nơi gìn giữ những kỷ niệm và giá trị tinh thần của mỗi gia đình.',
        'Với Bảo hiểm nhà tư nhân, chúng tôi đồng hành cùng bạn bảo vệ trước các rủi ro bất ngờ như cháy, nổ, giông, bão, lũ lụt, trộm cướp,...',
        'Bởi với chúng tôi, không chỉ tài sản, mà mỗi khoảnh khắc quý giá của gia đình cũng cần được bảo vệ tận tâm.',
      ],
    },
    {
      'title': 'Đối tượng tham gia bảo hiểm',
      'type': 'detail',
      'items': [
        {
          'label': 'Đối tượng tham gia bảo hiểm:',
          'value': 'Bảo hiểm ngôi nhà, tài sản trong nhà',
        },
        {'label': 'Thời hạn bảo hiểm:', 'value': '1 Năm'},
        {
          'label': 'Hình thức hợp đồng',
          'value': 'Giấy chứng nhận bảo hiểm điện tử',
        },
      ],
      'note': 'Quy tắc, điều khoản bảo hiểm. Tham khảo ',
      'linkText': 'Tại đây',
    },
    {
      'title': 'Bảo hiểm nhà tư nhân',
      'type': 'description',
      'items': [
        'Bảo hiểm HD nhận thức được rằng ngôi nhà không chỉ quý về vật chất mà còn là nơi gìn giữ những kỷ niệm và giá trị tinh thần của mỗi gia đình.',
        'Với Bảo hiểm nhà tư nhân, chúng tôi đồng hành cùng bạn bảo vệ trước các rủi ro bất ngờ như cháy, nổ, giông, bão, lũ lụt, trộm cướp,...',
        'Bởi với chúng tôi, không chỉ tài sản, mà mỗi khoảnh khắc quý giá của gia đình cũng cần được bảo vệ tận tâm.',
      ],
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              _buildHeroSection(context),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  transform: Matrix4.translationValues(0, -20, 0),
                  child: Column(
                    children: [
                      Expanded(
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: _pages.length,
                          onPageChanged: (i) =>
                              setState(() => _currentPage = i),
                          itemBuilder: (ctx, i) => _buildPageContent(_pages[i]),
                        ),
                      ),
                      _buildFixedBottom(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomButton()),
        ],
      ),
    );
  }

  // ── Hero ─────────────────────────────────────────────────────
  Widget _buildHeroSection(BuildContext context) {
    return SizedBox(
      height: 240,
      width: double.infinity,
      child: Stack(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 240,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  image: DecorationImage(
                    image: AssetImage('assets/image/home_4.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Positioned(
                right: 5,
                bottom: 17,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/image_BHNTN/background1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 240,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black.withOpacity(0.25), Colors.transparent],
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 16,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFBB8A0B).withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Color(0xFFBB8A0B),
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Page content ─────────────────────────────────────────────
  Widget _buildPageContent(Map<String, dynamic> page) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  page['title'],
                  style: AppStyles.n(
                    size: 22,
                    weight: FontWeight.w800,
                    color: const Color(0xFFD94F1E),
                    height: 1.3,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {},
                child: Image.asset("assets/image_BHNTN/icon_bhntn2.png"),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(color: Color(0xFFEEEEEE), thickness: 1),
          const SizedBox(height: 14),

          if (page['type'] == 'description')
            _buildDescriptionPage(page)
          else
            _buildDetailPage(page),

          if (page['type'] == 'description') ...[
            const SizedBox(height: 4),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChiTietSanPham()),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Xem chi tiết sản phẩm',
                    style: AppStyles.n(
                      size: 14,
                      weight: FontWeight.w700,
                      color: const Color(0xFFBB8A0B),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFFBB8A0B),
                    size: 20,
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildDescriptionPage(Map<String, dynamic> page) {
    return Column(
      children: List<String>.from(page['items']).map(_buildDescItem).toList(),
    );
  }

  Widget _buildDetailPage(Map<String, dynamic> page) {
    final items = List<Map<String, String>>.from(
      (page['items'] as List).map((e) => Map<String, String>.from(e)),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...items.map(
          (item) => _buildDetailItem(item['label']!, item['value']!),
        ),
        const SizedBox(height: 16),
        RichText(
          text: TextSpan(
            style: AppStyles.n(size: 13, color: const Color(0xFF555555)),
            children: [
              TextSpan(text: page['note'] ?? ''),
              TextSpan(
                text: page['linkText'] ?? '',
                style: AppStyles.n(
                  size: 13,
                  weight: FontWeight.w700,
                  color: const Color(0xFFBB8A0B),
                ),
              ),
            ],
            
          ),
        ),
      ],
    );
  }

  Widget _buildDescItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Image.asset(
              'assets/image_BHNTN/icon_bhntn1.png',
              width: 22,
              height: 22,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: AppStyles.n(size: 13.5, height: 1.6))),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Image.asset(
              'assets/image_BHNTN/icon_bhntn1.png',
              width: 22,
              height: 22,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppStyles.n(
                    size: 14,
                    weight: FontWeight.w700,
                    color: const Color(0xFF222222),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: AppStyles.n(
                    size: 13.5,
                    color: const Color(0xFF555555),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Fixed bottom ─────────────────────────────────────────────
  Widget _buildFixedBottom() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 88),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_pages.length, (i) {
              return GestureDetector(
                onTap: () => _pageController.animateToPage(
                  i,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: i == _currentPage ? 22 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: i == _currentPage
                        ? const Color(0xFFBB8A0B)
                        : const Color(0xFFDDDDDD),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 18),
          const Divider(color: Color(0xFFEEEEEE), thickness: 1),
          const SizedBox(height: 12),
          Row(
            children: [
              // --- Ô MỤC BỒI THƯỜNG ---
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      showDragHandle:
                          true, // Tự động thêm thanh kéo nhỏ ở đầu modal
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) => FractionallySizedBox(
                        heightFactor: 0.85,
                        child: const BoiThuongScreen(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(
                      10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/image_BHNTN/icon_bhntn3.png',
                          width: 36,
                          height: 36,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Bồi thường',
                            style: AppStyles.n(
                              size: 14,
                              weight: FontWeight.w600,
                              color: const Color(0xFF222222),
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          color: Color(0xFF999999),
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12), 
              // --- Ô MỤC CÂU HỎI ---
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      showDragHandle:
                          true, // Tự động thêm thanh kéo nhỏ ở đầu modal
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) => FractionallySizedBox(
                        heightFactor: 0.85,
                        child: const CauHoiScreen(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/image_BHNTN/icon_bhntn4.png',
                          width: 36,
                          height: 36,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Câu hỏi',
                            style: AppStyles.n(
                              size: 14,
                              weight: FontWeight.w600,
                              color: const Color(0xFF222222),
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          color: Color(0xFF999999),
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Bottom CTA ───────────────────────────────────────────────
  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true, // Cho phép modal co dãn theo bàn phím
              backgroundColor:
                  Colors.transparent, // Để thấy bo góc của Container
              builder: (context) => const NhapGiaTriModal(),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFBB8A0B),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: Text(
            'Tham gia ngay',
            style: AppStyles.n(size: 16, weight: FontWeight.w800, color: Colors.white),
          ),
        ),
      ),
    );
  }
}