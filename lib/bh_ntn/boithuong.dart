import 'package:flutter/material.dart';
import 'package:my_hdi/utils/app_styles.dart';

class BoiThuongScreen extends StatefulWidget {
  const BoiThuongScreen({super.key});

  @override
  State<BoiThuongScreen> createState() => _BoiThuongScreenState();
}

class _BoiThuongScreenState extends State<BoiThuongScreen> {
  // Trạng thái mở/đóng của các section
  bool _isClaimExpanded = true;
  bool _isGuaranteeExpanded = false; // Mặc định mở Quy trình xử lý bồi thường

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Bồi thường',
          style: AppStyles.n(size: 18, weight: FontWeight.w700, color: const Color(0xFF222222)),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, color: Colors.black),
          )
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 1. QUY TRÌNH XỬ LÝ BỒI THƯỜNG
            _buildExpansionSection(
              title: 'Quy trình xử lý bồi thường',
              isExpanded: _isClaimExpanded,
              onTap: () => setState(() {
                _isClaimExpanded = !_isClaimExpanded;
                if (_isClaimExpanded) _isGuaranteeExpanded = false; 
              }),
              children: [
                _buildStepItem(
                  img: 'assets/image_BHNTN/boithuong1.png',
                  title: '1. Thanh toán và thu thập',
                  desc: 'Thanh toán chi phí khám chữa bệnh, sau đó thu thập và khai báo hồ sơ yêu cầu bồi thường.',
                ),
                _buildStepItem(
                  img: 'assets/image_BHNTN/boithuong2.png',
                  title: '2. Nộp hồ sơ',
                  desc: 'Nộp hồ sơ yêu cầu bồi thường trong vòng 30 ngày kể từ ngày khám chữa bệnh đầu tiên.',
                ),
                _buildStepItem(
                  img: 'assets/image_BHNTN/boithuong3.png',
                  title: '3. Giải quyết yêu cầu',
                  desc: 'HDI giải quyết hồ sơ và hoàn trả chi phí khám chữa bệnh trong vòng 15 ngày làm việc.',
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 2. QUY TRÌNH BẢO LÃNH (CẬP NHẬT MỚI)
            _buildExpansionSection(
              title: 'Quy trình bảo lãnh',
              isExpanded: _isGuaranteeExpanded,
              onTap: () => setState(() {
                _isGuaranteeExpanded = !_isGuaranteeExpanded;
                if (_isGuaranteeExpanded) _isClaimExpanded = false;
              }),
              children: [
                _buildStepItem(
                  img: 'assets/image_BHNTN/baolanh1.png', // Icon thẻ bảo hiểm/ID
                  title: '1. Lựa chọn cơ sở y tế',
                  desc: 'Lựa chọn Cơ sở y tế, bệnh viện trong danh sách liên kết của HDI.',
                ),
                _buildStepItem(
                  img: 'assets/image_BHNTN/baolanh2.png', // Icon Folder tài liệu
                  title: '2. Xuất trình giấy tờ và làm thủ tục',
                  desc: 'Xuất trình giấy tờ và ký giấy yêu cầu bảo lãnh (do cơ sở y tế cung cấp).',
                ),
                _buildStepItem(
                  img: 'assets/image_BHNTN/baolanh3.png', // Icon Hồ sơ bệnh án
                  title: '3. Thanh toán chi phí phát sinh',
                  desc: 'Khách hàng thanh toán chi phí không được bảo lãnh (nếu có).',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpansionSection({
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isExpanded ? const Color(0xFFBB8A0B) : Colors.transparent,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: AppStyles.n(
                        size: 16,
                        weight: FontWeight.w700,
                        color: const Color(0xFFD32F2F), // Đỏ đặc trưng
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: const Color(0xFF666666),
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded) ...[
            const Divider(height: 1, color: Color(0xFFEEEEEE)),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(children: children),
            ),
            // Nút Xem chi tiết chuẩn Figma
            InkWell(
              onTap: () { /* Xử lý sự kiện */ },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Xem chi tiết',
                      style: AppStyles.n(
                        size: 14, 
                        weight: FontWeight.w700, 
                        color: const Color(0xFFBB8A0B)
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.keyboard_arrow_down, 
                      size: 20, 
                      color: Color(0xFFBB8A0B)
                    ),
                  ],
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildStepItem({required String img, required String title, required String desc}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Phần hình ảnh minh họa
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.asset(
              img,
              width: 64,
              height: 64,
              fit: BoxFit.contain,
              // Fallback nếu chưa có file ảnh thật
              errorBuilder: (context, error, stackTrace) => Container(
                width: 64,
                height: 64,
                color: Colors.white,
                child: const Icon(Icons.description_outlined, color: Color(0xFF1B5E20)),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppStyles.n(
                    size: 14,
                    weight: FontWeight.w700,
                    color: const Color(0xFF1B5E20), // Xanh lá đậm
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  desc,
                  style: AppStyles.n(
                    size: 13, 
                    color: const Color(0xFF666666), 
                    height: 1.5
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