import 'package:flutter/material.dart';
import 'package:my_hdi/utils/app_styles.dart';

// ─────────────────────────────────────────────
//  Widget chính
// ─────────────────────────────────────────────
class ChiTietSanPham extends StatefulWidget {
  const ChiTietSanPham({super.key});

  @override
  State<ChiTietSanPham> createState() => _ChiTietSanPhamState();
}

class _ChiTietSanPhamState extends State<ChiTietSanPham> {
  final List<bool> _expanded = [false, false, false, false, false];

  // ── Feature cards ──────────────────────────
  final List<Map<String, dynamic>> _features = [
    {
      'icon': 'assets/image_BHNTN/icon_bhntn6.png',
      'title': 'An Tâm Tuyệt Đối',
      'desc':
          'Với thời hạn bảo hiểm 1 năm, bạn sẽ có sự an tâm tuyệt đối suốt cả năm, không cần lo lắng về rủi ro cho ngôi nhà của mình.',
    },
    {
      'icon': 'assets/image_BHNTN/icon_bhntn7.png',
      'title': 'Dịch Vụ Hỗ Trợ 24/7',
      'desc':
          'Dù bạn ở bất kỳ lý do nào, đội ngũ tư vấn luôn sẵn sàng hỗ trợ bạn giúp giải quyết mọi vấn đề nhanh chóng.',
    },
    {
      'icon': 'assets/image_BHNTN/icon_bhntn8.png',
      'title': 'Bảo Vệ Ngôi Nhà Và Tài Sản',
      'desc':
          'Bảo hiểm Nhà tư nhân không chỉ bảo vệ ngôi nhà mà còn đảm bảo an toàn cho gia đình và tài sản bên trong.',
    },
    {
      'icon': 'assets/image_BHNTN/icon_bhntn9.png',
      'title': 'Giấy Chứng Nhận Bảo Hiểm Điện Tử',
      'desc':
          'Giấy chứng nhận điện tử dễ dàng khôi phục, quản lý và gia hạn hợp đồng ngay trên website của HDI.',
    },
  ];

  // ── Accordion titles ───────────────────────
  final List<String> _accordionTitles = [
    'Đối tượng tham gia bảo hiểm',
    'Quyền lợi bảo hiểm',
    'Điểm loại trừ bảo hiểm',
    'Mức khấu trừ',
    'Tài liệu đính kèm',
  ];

  // ── Accordion content ──────────────────────
  final List<List<Map<String, dynamic>>> _accordionContent = [
    // 0 – Đối tượng tham gia bảo hiểm
    [
      {
        'heading': '1. Bảo hiểm ngôi nhà',
        'bullets': [
          {
            'text':
                'Ngôi nhà thuộc quyền sở hữu của Người được bảo hiểm hoặc Người được bảo hiểm có trách nhiệm pháp lý trong coi quản lý. Gồm:',
            'sub': [
              {
                'text': 'a. Nhà chung cư với các điều kiện:',
                'sub': [
                  {'text': 'Chiều cao từ 5 tầng trở lên;'},
                  {
                    'text':
                        'Thời gian kể từ khi hoàn thiện xây dựng và đưa vào sử dụng không quá 30 năm cho đến ngày đơn bảo hiểm bắt đầu có hiệu lực.',
                  },
                ],
              },
              {
                'text': 'b. Nhà liền kề, biệt thự với các điều kiện:',
                'sub': [
                  {'text': 'Đường vào nhà rộng tối thiểu 4m;'},
                  {
                    'text':
                        'Thời gian kể từ khi hoàn thiện xây dựng và đưa vào sử dụng không quá 30 năm cho đến ngày đơn bảo hiểm bắt đầu có hiệu lực.',
                  },
                ],
              },
            ],
          },
        ],
      },
      {
        'heading': '2. Bảo hiểm tài sản trong nhà',
        'bullets': [
          {
            'text':
                'Là toàn bộ tài sản nằm trong khu vực ngôi nhà thuộc địa điểm bảo hiểm được ghi trên giấy chứng nhận bảo hiểm.',
          },
          {
            'text':
                'Tài sản phải thuộc sở hữu hoặc thuộc quyền trông coi quản lý của Người được bảo hiểm và không thuộc tài sản bị loại trừ dưới đây.',
          },
          {
            'text': 'Tài sản không được bảo hiểm',
            'sub': [
              {
                'text':
                    'Các tài sản đã được bảo hiểm theo một loại hình/ hợp đồng bảo hiểm khác;',
              },
              {
                'text':
                    'Các tài sản đã đổ bộ, cất giữ trong kho, hết giá trị sử dụng;',
              },
              {
                'text':
                    'Vàng bạc, trang sức, đá quý, tác phẩm nghệ thuật, bản thảo, bản kế hoạch, tranh ảnh hoặc bản vẽ thiết kế, mô hình, khuôn mẫu, huân chương, tiền xu hoặc sách quý, chứng khoán, tiền mặt, hối phiếu ngân hàng, séc, séc du lịch, lệnh chuyển tiền, vật nuôi;',
              },
              {
                'text':
                    'Tài sản cá nhân bao gồm quần áo và các đồ vật cá nhân được thiết kế để mặc, sử dụng hoặc mang theo người (bao gồm nhưng không giới hạn ở điện thoại di động và máy tính xách tay).',
              },
            ],
          },
        ],
      },
    ],

    // 1 – Quyền lợi bảo hiểm
    [
      {
        'heading': '1. Bồi thường thiệt hại vật chất',
        'bullets': [
          {'text': 'Hỏa hoạn, sét đánh, nổ do khí đốt dùng trong sinh hoạt;'},
          {'text': 'Lũ lụt, bão, lốc xoáy, mưa đá, sụt lún đất;'},
          {'text': 'Trộm cắp có đột nhập;'},
          {'text': 'Va chạm của phương tiện giao thông;'},
        ],
      },
      {
        'heading': '2. Chi phí phát sinh',
        'bullets': [
          {'text': 'Chi phí dọn dẹp hiện trường sau sự cố;'},
          {
            'text':
                'Chi phí thuê nhà tạm thời trong thời gian sửa chữa (tối đa 3 tháng);',
          },
        ],
      },
    ],

    // 2 – Điểm loại trừ bảo hiểm
    [
      {
        'heading': 'Các rủi ro không được bảo hiểm',
        'bullets': [
          {'text': 'Chiến tranh, bạo loạn, đình công, khủng bố;'},
          {'text': 'Hành vi cố ý của Người được bảo hiểm hoặc người đại diện;'},
          {'text': 'Hao mòn tự nhiên, ăn mòn, rỉ sét theo thời gian;'},
          {'text': 'Thiệt hại do mối mọt, côn trùng gây ra;'},
          {
            'text':
                'Thiệt hại do sửa chữa, thi công cải tạo không đúng kỹ thuật;',
          },
        ],
      },
    ],

    // 3 – Mức khấu trừ
    [
      {
        'heading': 'Mức khấu trừ áp dụng',
        'bullets': [
          {
            'text':
                'Mức khấu trừ 0% áp dụng cho rủi ro hỏa hoạn, sét đánh, nổ;',
          },
          {
            'text':
                'Mức khấu trừ 10% giá trị bồi thường, tối thiểu 500.000 VNĐ áp dụng cho các rủi ro còn lại;',
          },
          {
            'text':
                'Mức khấu trừ 20% áp dụng riêng cho rủi ro lũ lụt, bão, lốc xoáy.',
          },
        ],
      },
    ],

    // 4 – Tài liệu đính kèm
    // 4 – Tài liệu đính kèm
    [
      {
        'type': 'file',
        'title':
            'Hướng dẫn yêu cầu bồi thường bảo hiểm bắt buộc TNDS xe cơ giới',
      },
      {
        'type': 'file',
        'title':
            'Hướng dẫn yêu cầu bồi thường bảo hiểm bắt buộc TNDS xe cơ giới',
      },
      {
        'type': 'file',
        'title':
            'Hướng dẫn yêu cầu bồi thường bảo hiểm bắt buộc TNDS xe cơ giới',
      },
      {
        'type': 'file',
        'title':
            'Hướng dẫn yêu cầu bồi thường bảo hiểm bắt buộc TNDS xe cơ giới',
      },
      {
        'type': 'file',
        'title':
            'Hướng dẫn yêu cầu bồi thường bảo hiểm bắt buộc TNDS xe cơ giới',
      },
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Section title ──────────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                    child: Text(
                      'Tại sao nên chọn Bảo hiểm Nhà tư nhân?',
                      style: AppStyles.n(
                        size: 18,
                        weight: FontWeight.w700,
                        color: Color(0xFFDA2128),
                        height: 1.3,
                      ),
                    ),
                  ),

                  // ── 2×2 Feature grid ───────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _features.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            childAspectRatio: 0.65,
                          ),
                      itemBuilder: (_, i) => _buildFeatureCard(_features[i]),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ── Accordion section title ─
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                      'Thông tin chi tiết sản phẩm',
                      style: AppStyles.n(
                        size: 17,
                        weight: FontWeight.w700,
                        color: Color(0xFFDA2128),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // ── Accordions ─────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: List.generate(
                        _accordionTitles.length,
                        (i) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: _buildAccordion(i),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Header
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [ AppStyles.green2, AppStyles.green1],
        ),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 4,
        bottom: 14,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 4,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
          // Title căn giữa
          Text(
            'Chi tiết sản phẩm',
            style: AppStyles.n(size: 17, weight: FontWeight.w700, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // ── Feature card (bo góc, shadow nhẹ) ───────
  Widget _buildFeatureCard(Map<String, dynamic> f) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF0F0F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 65,
            height: 65,
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              f['icon'],
              fit: BoxFit.contain,
              errorBuilder: (_, _, _) =>
                  const Icon(Icons.home_outlined, color: AppStyles.green1, size: 24),
            ),
          ),

          const SizedBox(height: 10),
          // Title
          Text(
            f['title'] as String,
            style: AppStyles.n(
              size: 16,
              weight: FontWeight.w400,
              color: Color(0xFF2D2D2D),
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 6),

          // Description
          Expanded(
            child: Text(
              f['desc'] as String,
              style: AppStyles.n(size: 14, color: Color(0xFF2D2D2D), height: 1.5),
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  // ── Accordion item ───────────────────────────
  Widget _buildAccordion(int i) {
    final isOpen = _expanded[i];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isOpen ? const Color(0xFF2E9E52) : const Color(0xFFE0E0E0),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _expanded[i] = !isOpen),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      _accordionTitles[i],
                      style: AppStyles.n(
                        size: 15,
                        weight: FontWeight.w600,
                        color: const Color(0xFF222222),
                        height: 1.3,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: isOpen ? 0.5 : 0,
                    duration: const Duration(milliseconds: 250),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: isOpen
                          ? const Color(0xFF2E9E52)
                          : const Color(0xFF888888),
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isOpen)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(height: 1, color: Color(0xFFEEEEEE)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                  child: _buildRichContent(_accordionContent[i]),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildRichContent(List<Map<String, dynamic>> sections) {
    if (sections.isNotEmpty && sections.first['type'] == 'file') {
      return _buildFileList(sections);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sections.map((section) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (section['heading'] != null) ...[
              Text(
                section['heading'] as String,
                style: AppStyles.n(
                  size: 13.5,
                  weight: FontWeight.w700,
                  color: const Color(0xFF222222),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 6),
            ],
            if (section['bullets'] != null)
              ..._buildBullets(
                (section['bullets'] as List).cast<Map<String, dynamic>>(),
                level: 0,
              ),
            const SizedBox(height: 8),
          ],
        );
      }).toList(),
    );
  }

  List<Widget> _buildBullets(
    List<Map<String, dynamic>> bullets, {
    int level = 0,
  }) {
    return bullets.map((b) {
      final text = b['text'] as String;
      final sub = b['sub'] as List?;
      final leftPad = level * 14.0;

      return Padding(
        padding: EdgeInsets.only(bottom: 5, left: leftPad),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6, right: 7),
                  child: Container(
                    width: level == 0 ? 5 : 4,
                    height: level == 0 ? 5 : 4,
                    decoration: BoxDecoration(
                      color: level == 0
                          ? const Color(0xFF2E9E52)
                          : const Color(0xFF999999),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    text,
                    style: AppStyles.n(
                      size: 13,
                      color: level == 0
                          ? const Color(0xFF333333)
                          : const Color(0xFF666666),
                      height: 1.55,
                    ),
                  ),
                ),
              ],
            ),
            if (sub != null && sub.isNotEmpty)
              ..._buildBullets(
                sub.cast<Map<String, dynamic>>(),
                level: level + 1,
              ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildFileList(List<Map<String, dynamic>> files) {
    return Column(
      children: files.map((f) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              // Icon file 
              Image.asset(
                'assets/image_BHNTN/icon_bhntn10.png',
                width: 36,
                height: 36,
                errorBuilder: (_, _, _) => Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8A020),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.description,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Tên file
              Expanded(
                child: Text(
                  f['title'] as String,
                  style: AppStyles.n(
                    size: 14,
                    color: const Color(0xFF333333),
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Nút tải 
              GestureDetector(
                onTap: () {
                  // TODO: xử lý tải file
                },
                child: Column(
                  children: [
                    Image.asset(
                      'assets/image_BHNTN/icon_bhntn11.png',
                      width: 24,
                      height: 24,
                      errorBuilder: (_, _, _) => const Icon(
                        Icons.download_rounded,
                        color: Color(0xFFE8A020),
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Tải tài liệu',
                      style: AppStyles.n(
                        size: 11,
                        weight: FontWeight.w700,
                        color: const Color(0xFFE8A020),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
