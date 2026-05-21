import 'package:flutter/material.dart';
import 'package:my_hdi/bh_ntn/thanhtoan.dart';
import 'package:my_hdi/models/goi_data.dart';
import 'package:my_hdi/utils/app_styles.dart';

class XacNhanThongTin extends StatefulWidget {
  final GoiData selectedGoi;
  final XacNhanInfo info;
  const XacNhanThongTin({
    super.key,
    required this.selectedGoi,
    required this.info,
  });

  @override
  State<XacNhanThongTin> createState() => _XacNhanThongTinState();
}

class _XacNhanThongTinState extends State<XacNhanThongTin> {
  // State: 0 là chưa chọn, 1 là Có, 2 là Không
  int _selectedCondition = 1;
  bool _isExpanded = false;

  static const _colorText = Color(0xFF2D2D2D);
  static const _colorHint = Color(0xFF777777);
  static const _colorBg = Color(0xFFF5F5F5);
  static const _colorBorder = Color(0xFFE0E0E0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _colorBg,
      body: Column(
        children: [
          _buildHeader(context),
          _buildStepIndicator(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Khối điều kiện ngôi nhà
                  _buildConditionCard(),
                  const SizedBox(height: 24),

                  // 2. Khối cam kết & Xem tất cả
                  _buildDisclaimerSection(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  // ── Header Gradient ────────────────────────────────────────────────────────
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppStyles.green1, AppStyles.green2],
        ),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 4,
        bottom: 14,
        left: 4,
        right: 12,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
          Text(
            'Xác nhận thông tin',
            style: AppStyles.n(
              size: 17,
              weight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // ── Step Indicator (1 - 2 - 3 - 4) ──────────────────────────────────────────
  // ── Step Indicator chuẩn Figma ──────────────────────────────────────────
  Widget _buildStepIndicator() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepItem('1', 'Chọn gói', isDone: true, isActive: false),
          _buildStepLine(isDone: true),
          _buildStepItem(
            '2',
            'Người được\nbảo hiểm',
            isDone: true,
            isActive: false,
          ),
          _buildStepLine(isDone: true),
          _buildStepItem(
            '3',
            'Xác nhận\nthông tin',
            isDone: true,
            isActive: true,
          ),
          _buildStepLine(isDone: false),
          _buildStepItem('4', 'Thanh toán', isDone: false, isActive: false),
        ],
      ),
    );
  }

  // Widget thành phần: Mỗi bước gồm vòng tròn số và nhãn chữ bên dưới
  Widget _buildStepItem(
    String num,
    String label, {
    required bool isDone,
    required bool isActive,
  }) {
    // Màu sắc động dựa theo trạng thái bước
    final circleColor = (isActive || isDone)
        ? AppStyles.green2
        : const Color(0xFFF0F0F0);
    final textColor = (isActive || isDone)
        ? Colors.white
        : const Color(0xFF888888);
    final labelColor = isActive ? AppStyles.green2 : const Color(0xFF777777);
    final labelWeight = isActive ? FontWeight.w700 : FontWeight.w500;

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: circleColor,
            ),
            child: Center(
              child: Text(
                num,
                style: AppStyles.n(
                  size: 12,
                  weight: FontWeight.w700,
                  color: textColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppStyles.n(
              size: 11,
              color: labelColor,
              weight: labelWeight,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  // Widget đường nối: Căn giữa chính xác trục ngang của vòng tròn số
  Widget _buildStepLine({required bool isDone}) {
    return Container(
      width:
          32, // Độ rộng đường nối, có thể co giãn nhẹ theo màn hình bằng cách bỏ bọc Expanded cho các cột chữ
      height: 2,
      margin: const EdgeInsets.only(
        top: 11,
      ), // Đẩy xuống 11px để nằm chuẩn chính giữa tâm vòng tròn cao 24px (24 / 2 - 2 / 2)
      color: isDone ? AppStyles.green2 : const Color(0xFFE0E0E0),
    );
  }

  // ── Card Điều kiện ──────────────────────────────────────────────────────────
  Widget _buildConditionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _colorBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ngôi nhà được bảo hiểm đáp ứng các điều kiện sau đây:',
            style: AppStyles.n(
              size: 14,
              weight: FontWeight.w500,
              color: _colorText,
            ),
          ),
          const SizedBox(height: 12),
          _bulletItem(
            'Thời gian kể từ khi hoàn thiện xây dựng và đưa vào sử dụng không quá 30 năm cho đến ngày bảo hiểm bắt đầu có hiệu lực.',
          ),
          _bulletItem(
            'Chỉ sử dụng với mục đích để ở và phục vụ các nhu cầu sinh hoạt của hộ gia đình.',
          ),
          _bulletItem('Được xây bằng gạch, đá và xi măng.'),
          const SizedBox(height: 16),
          Row(
            children: [
              _radioOption('Có', 1),
              const SizedBox(width: 32),
              _radioOption('Không', 2),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bulletItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 5,
            height: 5,
            decoration: const BoxDecoration(
              color: _colorText,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: AppStyles.n(
                size: 14,
                color: _colorText,
                height: 1.4,
                weight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _radioOption(String label, int value) {
    bool isSelected = _selectedCondition == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedCondition = value),
      child: Row(
        children: [
          Icon(
            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: isSelected ? AppStyles.gold : _colorHint,
            size: 22,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: AppStyles.n(
              size: 15,
              weight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: _colorText,
            ),
          ),
        ],
      ),
    );
  }

  // ── Khối cam kết & Xem tất cả ───────────────────────────────────────────────
  Widget _buildDisclaimerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: AppStyles.n(size: 13, color: _colorHint, height: 1.5),
            children: [
              const TextSpan(text: 'Bằng việc nhấn nút '),
              TextSpan(
                text: '"TIẾP TỤC"',
                style: AppStyles.n(
                  size: 13,
                  weight: FontWeight.w700,
                  color: _colorText,
                ),
              ),
              const TextSpan(
                text:
                    ' đồng nghĩa với việc Bên mua bảo hiểm xác nhận và cam kết:\n',
              ),
              const TextSpan(
                text:
                    'a) Các thông tin được khai báo, cung cấp là đúng sự thật và hoàn toàn chịu trách nhiệm trước pháp luật. Đồng thời, Bên mua bảo hiểm đã đọc, hiểu và đồng ý với điều kiện, điều khoản và quy tắc của Bảo hiểm HDI.',
              ),
            ],
          ),
        ),
        if (_isExpanded)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'b) Tôi cam kết rằng ngôi nhà không nằm trong khu vực đang bị tranh chấp, giải tỏa hoặc có quyết định phá dỡ của cơ quan chức năng.\nc) Tôi đồng ý để HDI sử dụng thông tin này cho việc cấp đơn và quản lý bồi thường sau này.',
              style: AppStyles.n(size: 13, color: _colorHint, height: 1.5),
            ),
          ),
        const SizedBox(height: 8),
        Center(
          child: TextButton(
            onPressed: () => setState(() => _isExpanded = !_isExpanded),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _isExpanded ? 'Thu gọn' : 'Xem tất cả',
                  style: AppStyles.n(
                    size: 14,
                    weight: FontWeight.w700,
                    color: AppStyles.gold,
                  ),
                ),
                Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: AppStyles.gold,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── Bottom Bar ─────────────────────────────────────────────────────────────
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed: () {
            if (_selectedCondition != 1) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Ngôi nhà cần đáp ứng đủ điều kiện để tham gia bảo hiểm',
                  ),
                ),
              );
              return;
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ThanhToan(
                  selectedGoi: widget.selectedGoi,
                  info: widget.info, // truyền thẳng info đã nhận
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppStyles.gold,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Tiếp tục',
            style: AppStyles.n(
              size: 16,
              weight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
