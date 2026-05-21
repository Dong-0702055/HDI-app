import 'package:flutter/material.dart';
import 'package:my_hdi/BH_NTN/chitiet_goibaohiem.dart';
import 'package:my_hdi/bh_ntn/thanhtoan.dart';
import 'package:my_hdi/bh_ntn/thongtinngoinha.dart';
import 'package:my_hdi/bh_ntn/xacnhanthongtin.dart';
import 'package:my_hdi/models/goi_data.dart';
import 'package:my_hdi/models/ngoinhadata.dart';
import 'package:my_hdi/utils/app_styles.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Màn hình: Thông tin yêu cầu bảo hiểm
// ─────────────────────────────────────────────────────────────────────────────

class ThongTinYeuCauBaoHiem extends StatefulWidget {
  final GoiData selectedGoi;

  const ThongTinYeuCauBaoHiem({super.key, required this.selectedGoi});

  @override
  State<ThongTinYeuCauBaoHiem> createState() => _ThongTinYeuCauBaoHiemState();
}

class _ThongTinYeuCauBaoHiemState extends State<ThongTinYeuCauBaoHiem> {
  // ── Controllers ────────────────────────────────────────────────────────────
  final _tenNguoiDuocBaoHiemCtrl = TextEditingController();
  final _cmndCtrl = TextEditingController();
  final _sdtCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _diaChiLienHeCtrl = TextEditingController();
  final _tenNguoiThuHuongCtrl = TextEditingController();
  final _diaChiThuHuongCtrl = TextEditingController();

  // ── State ──────────────────────────────────────────────────────────────────
  String? _quyenSoHuu;
  DateTime? _ngayBatDau;
  DateTime? _ngayHetHieu;
  bool _muonHoaDonDienTu = false;
  NgoiNhaData? _ngoiNhaData;

  final List<String> _quyenSoHuuOptions = ['Chủ sở hữu', 'Nhà cho thuê'];
  static const _colorRed = Color(0xFFDA2128);
  static const _colorBorder = Color(0xFFE0E0E0);
  static const _colorText = Color(0xFF2D2D2D);
  static const _colorHint = Color(0xFFAAAAAA);
  static const _colorBg = Color(0xFFF5F5F5);

  @override
  void dispose() {
    _tenNguoiDuocBaoHiemCtrl.dispose();
    _cmndCtrl.dispose();
    _sdtCtrl.dispose();
    _emailCtrl.dispose();
    _diaChiLienHeCtrl.dispose();
    _tenNguoiThuHuongCtrl.dispose();
    _diaChiThuHuongCtrl.dispose();
    super.dispose();
  }

  // ── Date picker ────────────────────────────────────────────────────────────

  String _fmtDate(DateTime? d) {
    if (d == null) return '';
    return '${d.day.toString().padLeft(2, '0')}/'
        '${d.month.toString().padLeft(2, '0')}/'
        '${d.year}';
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _colorBg,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── 1. Thông tin người được bảo hiểm ──────────────────────
                  _sectionTitle('Thông tin người được bảo hiểm'),
                  const SizedBox(height: 12),
                  _dropdownField(
                    icon: Icons.home_outlined,
                    hint: 'Quyền sở hữu',
                    isRequired: true,
                    value: _quyenSoHuu,
                    items: _quyenSoHuuOptions,
                    onChanged: (v) => setState(() => _quyenSoHuu = v),
                    hasLabelAbove: true,
                  ),
                  const SizedBox(height: 10),
                  _inputField(
                    icon: Icons.person_outline,
                    hint: 'Người được bảo hiểm',
                    isRequired: true,
                    controller: _tenNguoiDuocBaoHiemCtrl,
                    keyboardType: TextInputType.name,
                    hasLabelAbove: true,
                  ),
                  const SizedBox(height: 10),
                  _inputField(
                    icon: Icons.badge_outlined,
                    hint: 'CMND/CCCD/Hộ chiếu',
                    isRequired: true,
                    controller: _cmndCtrl,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  _inputField(
                    icon: Icons.phone_outlined,
                    hint: 'Số điện thoại',
                    isRequired: true,
                    controller: _sdtCtrl,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 10),
                  _inputField(
                    icon: Icons.email_outlined,
                    hint: 'Email',
                    isRequired: false,
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 10),
                  _inputField(
                    icon: Icons.location_on_outlined,
                    hint: 'Địa chỉ liên hệ',
                    isRequired: false,
                    controller: _diaChiLienHeCtrl,
                    keyboardType: TextInputType.streetAddress,
                  ),

                  const SizedBox(height: 24),

                  // ── 2. Thông tin người thụ hưởng ──────────────────────────
                  _sectionTitle('Thông tin người thụ hưởng'),
                  const SizedBox(height: 16),
                  _inputField(
                    icon: Icons.person_outline,
                    hint: 'Tên người thụ hưởng',
                    isRequired: true,
                    controller: _tenNguoiThuHuongCtrl,
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 10),
                  _inputField(
                    icon: Icons.location_on_outlined,
                    hint: 'Địa chỉ',
                    isRequired: true,
                    controller: _diaChiThuHuongCtrl,
                    keyboardType: TextInputType.streetAddress,
                  ),

                  const SizedBox(height: 24),

                  // ── 3. Thông tin ngôi nhà được bảo hiểm ───────────────────
                  _sectionTitle('Thông tin ngôi nhà được bảo hiểm'),
                  const SizedBox(height: 12),
                  _themNgoiNhaButton(),

                  // Hiển thị thêm thông tin ngắn nếu đã nhập dữ liệu
                  if (_ngoiNhaData != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFE0E0E0),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Tiêu đề dòng đầu + Nút sửa đổi bên phải
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: _buildSummaryRow(
                                    'Loại nhà:',
                                    _ngoiNhaData!.loaiNha,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _dieuHuongSuaThongTinNha,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Sửa',
                                        style: AppStyles.n(
                                          size: 13,
                                          weight: FontWeight.w600,
                                          color: AppStyles.gold,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      const Icon(
                                        Icons.edit_outlined,
                                        color: AppStyles.gold,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // Các hàng thông tin tiếp theo
                            _buildSummaryRow(
                              'Mục đích sử dụng:',
                              _ngoiNhaData!.mucDichSuDung,
                            ),
                            const SizedBox(height: 8),

                            _buildSummaryRow(
                              'GHBT ngôi nhà:',
                              '${_ngoiNhaData!.gioiHanBoiThuong} VNĐ',
                            ),
                            const SizedBox(height: 8),

                            _buildSummaryRow(
                              'Diện tích sử dụng:',
                              _ngoiNhaData!.dienTich,
                            ),
                            const SizedBox(height: 8),

                            _buildSummaryRow(
                              'Địa chỉ nhà BH:',
                              _ngoiNhaData!.diaChi,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 24),

                  // ── 4. Thời hạn bảo hiểm ──────────────────────────────────
                  _sectionTitle('Thời hạn bảo hiểm'),
                  const SizedBox(height: 12),
                  _dateField(
                    icon: Icons.calendar_month_outlined,
                    hint: 'Ngày bắt đầu hiệu lực',
                    isRequired: true,
                    value: _fmtDate(_ngayBatDau),
                    onTap: () => _showCustomDatePicker(isStart: true),
                  ),
                  const SizedBox(height: 10),
                  _dateField(
                    icon: Icons.calendar_month_outlined,
                    hint: 'Ngày hết hiệu lực',
                    isRequired: true,
                    value: _fmtDate(_ngayHetHieu),
                    onTap: () => _showCustomDatePicker(isStart: false),
                  ),

                  const SizedBox(height: 20),

                  // ── Toggle hoá đơn điện tử ────────────────────────────────
                  _hoaDonToggle(),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
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

  // ── Section title — text đỏ, không nền ───────────────────────────────────

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: AppStyles.n(
        size: 16,
        weight: FontWeight.w700,
        color: Color(0xFFDA2128),
      ),
    );
  }

  // ── Card trắng bo góc dùng chung cho tất cả field ────────────────────────

  Widget _fieldCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _colorBorder, width: 1),
      ),
      child: child,
    );
  }

  // ── Hint text (có hoặc không có dấu * đỏ) ────────────────────────────────

  Widget _hintText(String hint, bool isRequired) {
    if (!isRequired) {
      return Text(hint, style: AppStyles.n(size: 13, color: _colorHint));
    }
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: hint,
            style: AppStyles.n(size: 13, color: _colorHint),
          ),
          TextSpan(
            text: ' *',
            style: AppStyles.n(
              size: 13,
              weight: FontWeight.w700,
              color: _colorRed,
            ),
          ),
        ],
      ),
    );
  }

  // ── Input field ───────────────────────────────────────────────────────────

  Widget _inputField({
    required IconData icon,
    required String hint,
    required bool isRequired,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    bool hasLabelAbove = true,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      constraints: const BoxConstraints(minHeight: 70),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Icon(icon, color: _colorHint, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _hintText(hint, isRequired),
                  const SizedBox(height: 2),
                  TextField(
                    controller: controller,
                    keyboardType: keyboardType,
                    style: AppStyles.n(
                      size: 15,
                      color: _colorText,
                      weight: FontWeight.w600,
                    ),
                    decoration: const InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Dropdown field ────────────────────────────────────────────────────────

  Widget _dropdownField({
    required IconData icon,
    required String hint,
    required bool isRequired,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    bool hasLabelAbove = false,
  }) {
    return GestureDetector(
      onTap: () => _showQuyenSoHuuBottomSheet(items, value, onChanged),
      child: _fieldCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            children: [
              Icon(icon, color: _colorHint, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (hasLabelAbove) _hintText(hint, isRequired),
                    const SizedBox(height: 4),
                    value != null
                        ? Text(
                            value,
                            style: AppStyles.n(
                              size: 14,
                              color: _colorText,
                              weight: FontWeight.w600,
                            ),
                          )
                        : (!hasLabelAbove
                              ? _hintText(hint, isRequired)
                              : const SizedBox.shrink()),
                  ],
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down,
                color: _colorHint,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showQuyenSoHuuBottomSheet(
    List<String> items,
    String? currentVal,
    ValueChanged<String?> onChanged,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Quyền sở hữu',
                style: AppStyles.n(size: 18, weight: FontWeight.w800),
              ),
              const SizedBox(height: 20),
              ...items.map((item) {
                bool isSelected = (item == currentVal);
                return GestureDetector(
                  onTap: () {
                    onChanged(item);
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      // Thêm viền vàng nếu được chọn
                      border: Border.all(
                        color: isSelected ? AppStyles.gold : Colors.transparent,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item,
                          style: AppStyles.n(
                            size: 16,
                            weight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: isSelected ? AppStyles.gold : _colorText,
                          ),
                        ),
                        if (isSelected)
                          const Icon(Icons.check_circle, color: AppStyles.gold)
                        else
                          Icon(Icons.radio_button_off, color: Colors.grey[300]),
                      ],
                    ),
                  ),
                );
              }).toList(),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
  // ── Date field ────────────────────────────────────────────────────────────

  Widget _dateField({
    required IconData icon,
    required String hint,
    required bool isRequired,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        constraints: const BoxConstraints(
          minHeight: 65,
        ), // Độ cao đồng bộ với input
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment
                .center, // Căn giữa icon và text theo chiều dọc
            children: [
              Icon(icon, color: _colorHint, size: 22),
              const SizedBox(width: 12),
              Expanded(
                // Dùng Center hoặc Alignment để ép nội dung luôn nằm giữa trục dọc
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: value.isNotEmpty
                      ? Text(
                          value,
                          style: AppStyles.n(
                            size: 15,
                            color: _colorText,
                            weight: FontWeight.w600,
                          ),
                        )
                      : (isRequired
                            ? RichText(
                                text: TextSpan(
                                  text: hint,
                                  style: AppStyles.n(
                                    size: 14,
                                    color: _colorHint,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Text(
                                hint,
                                style: AppStyles.n(size: 14, color: _colorHint),
                              )),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down,
                color: _colorHint,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCustomDatePicker({required bool isStart}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Cho phép tùy chỉnh chiều cao
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height:
              MediaQuery.of(context).size.height *
              0.7, // Chiều cao 70% màn hình
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Thanh gạch ngang nhỏ trên đầu
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Header: Tiêu đề và nút X
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 32),
                    Text(
                      isStart
                          ? 'Ngày bắt đầu hiệu lực bảo hiểm'
                          : 'Ngày kết thúc hiệu lực bảo hiểm',
                      style: AppStyles.n(size: 16, weight: FontWeight.w700),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),

              // Tab chọn Ngày bắt đầu / Ngày kết thúc (như Figma)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    _buildDateTab(
                      'Ngày bắt đầu',
                      _fmtDate(_ngayBatDau),
                      isStart,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text('-'),
                    ),
                    _buildDateTab(
                      'Ngày kết thúc',
                      _fmtDate(_ngayHetHieu),
                      !isStart,
                    ),
                  ],
                ),
              ),

              // Phần Lịch (Calendar)
              Expanded(
                child: CalendarDatePicker(
                  initialDate:
                      (isStart ? _ngayBatDau : _ngayHetHieu) ?? DateTime.now(),
                  firstDate: DateTime.now().subtract(const Duration(days: 365)),
                  lastDate: DateTime.now().add(const Duration(days: 3650)),
                  onDateChanged: (date) {
                    setState(() {
                      if (isStart)
                        _ngayBatDau = date;
                      else
                        _ngayHetHieu = date;
                    });
                  },
                ),
              ),

              // Nút Xác nhận
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppStyles.gold,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Xác nhận',
                      style: AppStyles.n(
                        color: Colors.white,
                        weight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  // Widget phụ trợ cho cái Tab chọn ngày trong Bottom Sheet
  Widget _buildDateTab(String label, String date, bool isActive) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFFFF9E7) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isActive ? AppStyles.gold : Colors.grey[300]!,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(label, style: AppStyles.n(size: 12, color: Colors.grey)),
            Text(
              date.isNotEmpty ? date : '--/--/----',
              style: AppStyles.n(size: 14, weight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  // ── Nút "Thêm thông tin ngôi nhà" — border + text + icon vàng ────────────

  Widget _themNgoiNhaButton() {
    return GestureDetector(
      onTap: () async {
        // 1. Chuyển hướng sang màn hình ThongTinNgoiNha và chờ kết quả trả về
        final result = await Navigator.push<NgoiNhaData>(
          context,
          MaterialPageRoute(
            builder: (context) => ThongTinNgoiNha(
              // Nếu đã từng nhập rồi thì truyền data cũ sang để hiển thị lại
              initialData: _ngoiNhaData,
            ),
          ),
        );

        // 2. Nếu người dùng bấm "Xác nhận" và trả về dữ liệu (không phải bấm Back)
        if (result != null) {
          setState(() {
            _ngoiNhaData = result;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppStyles.gold, width: 1.5),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                // Thay đổi text linh hoạt để người dùng biết đã nhập hay chưa
                _ngoiNhaData != null
                    ? 'Sửa thông tin ngôi nhà'
                    : 'Thêm thông tin ngôi nhà',
                style: AppStyles.n(
                  size: 14,
                  weight: FontWeight.w600,
                  color: AppStyles.gold,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: AppStyles.gold, size: 22),
          ],
        ),
      ),
    );
  }

  // ── Toggle "Tôi muốn nhận Hoá đơn điện tử" ───────────────────────────────

  Widget _hoaDonToggle() {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Tôi muốn nhận Hoá đơn điện tử',
            style: AppStyles.n(size: 13, color: _colorText),
          ),
        ),
        Switch(
          value: _muonHoaDonDienTu,
          onChanged: (v) => setState(() => _muonHoaDonDienTu = v),
          activeColor: Colors.white,
          activeTrackColor: AppStyles.green2,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: const Color(0xFFCCCCCC),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
        ),
      ],
    );
  }

  // ── Bottom bar ────────────────────────────────────────────────────────────

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Thông tin gói "Bảo hiểm nhà tư nhân",
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Bảo hiểm\nnhà tư nhân',
                style: AppStyles.n(
                  size: 12,
                  color: const Color(0xFF555555),
                  height: 1.5,
                ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.selectedGoi.tenNgan,
                    style: AppStyles.n(
                      size: 13,
                      weight: FontWeight.w700,
                      color: _colorText,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.selectedGoi.gia,
                    style: AppStyles.n(
                      size: 13,
                      weight: FontWeight.w700,
                      color: _colorRed,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Nút Tiếp tục — full width, nền vàng
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                if (_ngoiNhaData == null ||
                    _quyenSoHuu == null ||
                    _tenNguoiDuocBaoHiemCtrl.text == '' ||
                    _cmndCtrl.text == '' ||
                    _sdtCtrl.text == '' ||
                    _tenNguoiThuHuongCtrl.text == '' ||
                    _diaChiThuHuongCtrl.text == '' || _ngayBatDau == null || _ngayHetHieu == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Vui lòng điền đầy đủ thông tin bắt buộc'),
                    ),
                  );
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => XacNhanThongTin(
                      selectedGoi: widget.selectedGoi,
                      info: XacNhanInfo(
                        quyenSoHuu: _quyenSoHuu ?? '',
                        tenNguoiDuocBaoHiem: _tenNguoiDuocBaoHiemCtrl.text,
                        hoCieu: _cmndCtrl.text,
                        soDienThoai: _sdtCtrl.text,
                        email: _emailCtrl.text,
                        diaChiLienHe: _diaChiLienHeCtrl.text,
                        tenNguoiThuHuong: _tenNguoiThuHuongCtrl.text,
                        diaChiThuHuong: _diaChiThuHuongCtrl.text,
                        loaiNha: _ngoiNhaData?.loaiNha ?? '',
                        mucDichSuDung: _ngoiNhaData?.mucDichSuDung ?? '',
                        gioiHanBoiThuong: _ngoiNhaData?.gioiHanBoiThuong ?? '',
                        dienTich: _ngoiNhaData?.dienTich ?? '',
                        diaChiCuThe: _ngoiNhaData?.diaChi ?? '',
                        thoiHanBaoHiem:
                            '${_fmtDate(_ngayBatDau)} - ${_fmtDate(_ngayHetHieu)}',
                      ),
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
                'Tiếp tục',
                style: AppStyles.n(
                  size: 16,
                  weight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Hàm bổ trợ tạo dòng thông tin 2 cột song song (Cột nhãn xám - Cột giá trị đen)
  Widget _buildSummaryRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width:
              125, // Độ rộng cố định cho nhãn bên trái giúp các dòng thẳng hàng tăm tắp
          child: Text(
            label,
            style: AppStyles.n(
              size: 13,
              color: const Color(0xFF777777),
              weight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppStyles.n(
              size: 13,
              color: const Color(0xFF2D2D2D),
              weight: FontWeight.w600,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // Hàm xử lý mở lại màn hình sửa đổi dữ liệu ngôi nhà
  void _dieuHuongSuaThongTinNha() async {
    final result = await Navigator.push<NgoiNhaData>(
      context,
      MaterialPageRoute(
        builder: (_) => ThongTinNgoiNha(
          initialData:
              _ngoiNhaData, // Truyền ngược data cũ sang để hiển thị lại trên các ô nhập
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _ngoiNhaData =
            result; // Cập nhật lại giao diện tóm tắt mới sau khi sửa xong
      });
    }
  }
}
