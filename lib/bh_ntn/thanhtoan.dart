import 'package:flutter/material.dart';
import 'package:my_hdi/bh_ntn/chitiet_goibaohiem.dart';
import 'package:my_hdi/bh_ntn/giaodich.dart';
import 'package:my_hdi/utils/app_styles.dart';
import 'package:my_hdi/models/goi_data.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Model tổng hợp tất cả thông tin xác nhận
// ─────────────────────────────────────────────────────────────────────────────

class XacNhanInfo {
  final String quyenSoHuu;
  final String tenNguoiDuocBaoHiem;
  final String hoCieu;
  final String soDienThoai;
  final String email;
  final String diaChiLienHe;
  final String tenNguoiThuHuong;
  final String diaChiThuHuong;
  final String loaiNha;
  final String mucDichSuDung;
  final String gioiHanBoiThuong;
  final String dienTich;
  final String diaChiCuThe;
  final String thoiHanBaoHiem;

  const XacNhanInfo({
    required this.quyenSoHuu,
    required this.tenNguoiDuocBaoHiem,
    required this.hoCieu,
    required this.soDienThoai,
    required this.email,
    required this.diaChiLienHe,
    required this.tenNguoiThuHuong,
    required this.diaChiThuHuong,
    required this.loaiNha,
    required this.mucDichSuDung,
    required this.gioiHanBoiThuong,
    required this.dienTich,
    required this.diaChiCuThe,
    required this.thoiHanBaoHiem,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// Màn hình: Thanh toán — xác nhận thông tin trước khi thanh toán
// ─────────────────────────────────────────────────────────────────────────────

class ThanhToan extends StatelessWidget {
  final GoiData selectedGoi;
  final XacNhanInfo info;

  const ThanhToan({super.key, required this.selectedGoi, required this.info});

  static const _colorText = Color(0xFF2D2D2D);
  static const _colorLabel = Color(0xFF888888);
  static const _colorDivider = Color(0xFFF0F0F0);
  static const _colorBg = Color(0xFFF5F5F5);
  static const _colorRed = Color(0xFFDA2128);
  static const _colorSectionTitle = Color(0xFF1A1A1A);

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
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGoiCard(context),
                  const SizedBox(height: 12),
                  _buildSectionCard(
                    context: context,
                    title: 'Thông tin người được bảo hiểm',
                    onEdit: () {},
                    rows: [
                      _InfoRow('Quyền sở hữu:', info.quyenSoHuu),
                      _InfoRow(
                        'Người được bảo hiểm:',
                        info.tenNguoiDuocBaoHiem,
                      ),
                      _InfoRow('Hộ chiếu:', info.hoCieu),
                      _InfoRow('Số điện thoại:', info.soDienThoai),
                      _InfoRow('Email:', info.email),
                      _InfoRow('Địa chỉ liên hệ:', info.diaChiLienHe),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildSectionCard(
                    context: context,
                    title: 'Người thụ hưởng',
                    onEdit: () {},
                    rows: [
                      _InfoRow('Tên người thụ hưởng :', info.tenNguoiThuHuong),
                      _InfoRow('Địa chỉ:', info.diaChiThuHuong),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildSectionCard(
                    context: context,
                    title: 'Ngôi nhà được bảo hiểm',
                    onEdit: () {},
                    rows: [
                      _InfoRow('Loại nhà:', info.loaiNha),
                      _InfoRow('Mục đích sử dụng:', info.mucDichSuDung),
                      _InfoRow(
                        'Giới hạn bồi thường\nngôi nhà:',
                        info.gioiHanBoiThuong,
                      ),
                      _InfoRow('Diện tích sử dụng (m2):', info.dienTich),
                      _InfoRow('Địa chỉ cụ thể:', info.diaChiCuThe),
                      _InfoRow('Thời hạn bảo hiểm:', info.thoiHanBaoHiem),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildXemGiayButton(context),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────

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
            'Thông tin yêu cầu bảo hiểm',
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

  // ── Step indicator ────────────────────────────────────────────────────────

  Widget _buildStepIndicator() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _stepItem('1', 'Chọn gói\nsản phẩm', isDone: true, isActive: false),
          _stepLine(isDone: true),
          _stepItem('2', 'Người được\nbảo hiểm', isDone: true, isActive: false),
          _stepLine(isDone: true),
          _stepItem('3', 'Xác nhận\nthông tin', isDone: false, isActive: true),
          _stepLine(isDone: false),
          _stepItem('4', 'Thanh toán', isDone: false, isActive: false),
        ],
      ),
    );
  }

  Widget _stepItem(
    String num,
    String label, {
    required bool isDone,
    required bool isActive,
  }) {
    final bgColor = (isDone || isActive)
        ? AppStyles.green2
        : const Color(0xFFE0E0E0);
    final numColor = (isDone || isActive)
        ? Colors.white
        : const Color(0xFF999999);
    final labelColor = isActive
        ? AppStyles.green2
        : isDone
        ? const Color(0xFF555555)
        : const Color(0xFF999999);
    final labelWeight = isActive ? FontWeight.w700 : FontWeight.w400;

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(shape: BoxShape.circle, color: bgColor),
            child: Center(
              child: Text(
                num,
                style: AppStyles.n(
                  size: 12,
                  weight: FontWeight.w700,
                  color: numColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppStyles.n(
              size: 10,
              color: labelColor,
              weight: labelWeight,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _stepLine({required bool isDone}) {
    return Container(
      width: 28,
      height: 2,
      margin: const EdgeInsets.only(top: 12),
      color: isDone ? AppStyles.green2 : const Color(0xFFE0E0E0),
    );
  }

  // ── Card gói bảo hiểm ────────────────────────────────────────────────────

  Widget _buildGoiCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Image(
                image: AssetImage('assets/image_BHNTN/icon_dong.png'),
                width: 26,
                height: 26,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bảo hiểm nhà tư nhân',
                  style: AppStyles.n(
                    size: 14,
                    weight: FontWeight.w700,
                    color: _colorText,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      'x1 ${selectedGoi.tenNgan}',
                      style: AppStyles.n(
                        size: 13,
                        weight: FontWeight.w500,
                        color: const Color(0xFF555555),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Chi tiết quyền lợi',
                        style: AppStyles.n(
                          size: 12,
                          weight: FontWeight.w600,
                          color: AppStyles.gold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  selectedGoi.gia,
                  style: AppStyles.n(
                    size: 15,
                    weight: FontWeight.w700,
                    color: _colorRed,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Section card ──────────────────────────────────────────────────────────

  Widget _buildSectionCard({
    required BuildContext context,
    required String title,
    required VoidCallback onEdit,
    required List<_InfoRow> rows,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppStyles.n(
                    size: 14,
                    weight: FontWeight.w700,
                    color: _colorSectionTitle,
                  ),
                ),
                GestureDetector(
                  onTap: onEdit,
                  child: Text(
                    'Chỉnh sửa',
                    style: AppStyles.n(
                      size: 13,
                      weight: FontWeight.w600,
                      color: AppStyles.gold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: _colorDivider),
          ...rows.asMap().entries.map((entry) {
            final i = entry.key;
            final row = entry.value;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 11,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                          row.label,
                          style: AppStyles.n(
                            size: 13,
                            color: _colorLabel,
                            weight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          row.value,
                          textAlign: TextAlign.right,
                          style: AppStyles.n(
                            size: 13,
                            color: _colorText,
                            weight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (i < rows.length - 1)
                  const Divider(
                    height: 1,
                    indent: 16,
                    endIndent: 16,
                    color: _colorDivider,
                  ),
              ],
            );
          }),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  // ── Xem giấy chứng nhận mẫu ──────────────────────────────────────────────

  Widget _buildXemGiayButton(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.description_outlined,
              color: Color(0xFF555555),
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Xem giấy chứng nhận mẫu',
                style: AppStyles.n(
                  size: 14,
                  weight: FontWeight.w500,
                  color: _colorText,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward, color: Color(0xFF555555), size: 18),
          ],
        ),
      ),
    );
  }

  // ── Bottom bar ────────────────────────────────────────────────────────────

  Widget _buildBottomBar(BuildContext context) {
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => KetQuaGiaoDich(
                  tenNguoiMua: 'Đinh Duy Tường', 
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppStyles.gold,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Thanh toán',
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

// ─────────────────────────────────────────────────────────────────────────────
// Model nội bộ
// ─────────────────────────────────────────────────────────────────────────────

class _InfoRow {
  final String label;
  final String value;
  const _InfoRow(this.label, this.value);
}
