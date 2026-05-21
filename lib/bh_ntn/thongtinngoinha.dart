import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_hdi/utils/app_styles.dart';
import 'package:my_hdi/models/ngoinhadata.dart';

// ─────────────────────────────────────────────────────────────────────────────
// MÀN HÌNH CHÍNH: THÔNG TIN NHÀ ĐƯỢC BẢO HIỂM
// ─────────────────────────────────────────────────────────────────────────────
class ThongTinNgoiNha extends StatefulWidget {
  final NgoiNhaData? initialData;

  const ThongTinNgoiNha({super.key, this.initialData});

  @override
  State<ThongTinNgoiNha> createState() => _ThongTinNgoiNhaState();
}

class _ThongTinNgoiNhaState extends State<ThongTinNgoiNha> {
  // Màu sắc hệ thống
  static const _colorRed = Color(0xFFDA2128);
  static const _colorBorder = Color(0xFFE0E0E0);
  static const _colorText = Color(0xFF2D2D2D);
  static const _colorHint = Color(0xFFAAAAAA);
  static const _colorBg = Color(0xFFF5F5F5);

  // Danh sách Options dữ liệu mẫu
  static const _loaiNhaOptions = ['Nhà liền kề /Nhà phố', 'Chung Cư', 'Biệt thự', 'Nhà cấp 4'];
  static const _mucDichOptions = ['Để ở', 'Cho thuê', 'Kinh doanh'];
  static const _gioiHanChips = ['90.000.000VNĐ', '190.000.000VNĐ', '290.000.000VNĐ', '390.000.000VNĐ'];

  // Các biến State lưu giá trị người dùng chọn
  String? _loaiNha;
  String? _mucDich;
  String? _tinh; // Lưu text hiển thị: "Tỉnh, Quận, Xã"
  String? _selectedChip;

  final _gioiHanCtrl = TextEditingController();
  final _dienTichCtrl = TextEditingController();
  final _diaChiCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final d = widget.initialData;
    if (d != null) {
      _loaiNha = d.loaiNha;
      _mucDich = d.mucDichSuDung;
      _gioiHanCtrl.text = d.gioiHanBoiThuong;
      _dienTichCtrl.text = d.dienTich.replaceAll(' m2', '');
      _diaChiCtrl.text = d.diaChi.split(',').first.trim();
      _selectedChip = d.gioiHanBoiThuongTrongNha;
    }
  }

  @override
  void dispose() {
    _gioiHanCtrl.dispose();
    _dienTichCtrl.dispose();
    _diaChiCtrl.dispose();
    super.dispose();
  }

  // Bottom Sheet đơn giản hiển thị danh sách để Chọn Loại nhà / Mục đích sử dụng
  void _showSimpleBottomSheet({
    required String title,
    required List<String> options,
    required String? current,
    required ValueChanged<String> onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 32),
                    Text(title, style: AppStyles.n(size: 16, weight: FontWeight.w700, color: _colorText)),
                    IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
                  ],
                ),
              ),
              const Divider(height: 1, color: _colorBorder),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: options.length,
                  itemBuilder: (context, i) {
                    final opt = options[i];
                    final isSelected = current == opt;
                    return ListTile(
                      onTap: () {
                        onSelected(opt);
                        Navigator.pop(context);
                      },
                      leading: Icon(
                        isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                        color: isSelected ? AppStyles.gold : _colorHint,
                      ),
                      title: Text(
                        opt,
                        style: AppStyles.n(size: 15, weight: isSelected ? FontWeight.w600 : FontWeight.w400, color: _colorText),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Hàm kiểm tra và đóng màn hình trả kết quả về màn hình trước
  void _xacNhan() {
    if (_loaiNha == null || _mucDich == null || _gioiHanCtrl.text.isEmpty || _dienTichCtrl.text.isEmpty || _tinh == null || _diaChiCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng điền đầy đủ thông tin bắt buộc')),
      );
      return;
    }
    final result = NgoiNhaData(
      loaiNha: _loaiNha!,
      mucDichSuDung: _mucDich!,
      gioiHanBoiThuong: _gioiHanCtrl.text,
      dienTich: '${_dienTichCtrl.text} m2',
      diaChi: '${_diaChiCtrl.text}, $_tinh',
      gioiHanBoiThuongTrongNha: _selectedChip ?? '',
    );
    Navigator.pop(context, result);
  }

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
                  // 1. Loại nhà
                  _pushField(
                    icon: Icons.home_outlined,
                    hint: 'Loại nhà',
                    isRequired: true,
                    value: _loaiNha,
                    onTap: () => _showSimpleBottomSheet(
                      title: 'Loại nhà',
                      options: _loaiNhaOptions,
                      current: _loaiNha,
                      onSelected: (v) => setState(() => _loaiNha = v),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // 2. Mục đích sử dụng
                  _pushField(
                    icon: Icons.dashboard_outlined,
                    hint: 'Mục đích sử dụng',
                    isRequired: true,
                    value: _mucDich,
                    onTap: () => _showSimpleBottomSheet(
                      title: 'Mục đích sử dụng',
                      options: _mucDichOptions,
                      current: _mucDich,
                      onSelected: (v) => setState(() => _mucDich = v),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // 3. Giới hạn bồi thường
                  _fieldCard(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 2), child: Icon(Icons.attach_money_outlined, color: _colorHint, size: 20)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _hintText('Giới hạn bồi thường ngôi nhà', true),
                                TextField(
                                  controller: _gioiHanCtrl,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly, _ThousandFormatter()],
                                  style: AppStyles.n(size: 14, weight: FontWeight.w600, color: _colorText),
                                  decoration: const InputDecoration(isDense: true, border: InputBorder.none, contentPadding: EdgeInsets.zero),
                                ),
                              ],
                            ),
                          ),
                          _helpIcon(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // 4. Diện tích sử dụng
                  _fieldCard(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 2), child: Icon(Icons.square_foot_outlined, color: _colorHint, size: 20)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _hintText('Diện tích sử dụng (m2)', true),
                                TextField(
                                  controller: _dienTichCtrl,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  style: AppStyles.n(size: 14, weight: FontWeight.w600, color: _colorText),
                                  decoration: const InputDecoration(isDense: true, border: InputBorder.none, contentPadding: EdgeInsets.zero),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // 5. Chọn địa chỉ (Tỉnh / Huyện / Xã) dạng BottomSheet 3 bước liên tiếp như Figma
                  _pushField(
                    icon: Icons.location_city_outlined,
                    hint: 'Tỉnh/Thành phố – Quận/Huyện – Phường/Xã',
                    isRequired: true,
                    value: _tinh,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => _AddressPickerBottomSheet(
                          onSelected: (tinh, quan, xa) {
                            setState(() {
                              _tinh = '$tinh, $quan, $xa';
                            });
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),

                  // 6. Địa chỉ cụ thể
                  _fieldCard(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 2), child: Icon(Icons.location_on_outlined, color: _colorHint, size: 20)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _hintText('Địa chỉ cụ thể', true),
                                TextField(
                                  controller: _diaChiCtrl,
                                  style: AppStyles.n(size: 14, weight: FontWeight.w600, color: _colorText),
                                  decoration: const InputDecoration(isDense: true, border: InputBorder.none, contentPadding: EdgeInsets.zero),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Phần lựa chọn tài sản trong nhà (Chips)
                  Row(
                    children: [
                      Expanded(child: Text('Bảo hiểm cho tài sản trong ngôi nhà', style: AppStyles.n(size: 14, weight: FontWeight.w700, color: _colorText))),
                      const SizedBox(width: 4),
                      _helpIcon(),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text('Giới hạn bồi thường ngôi nhà', style: AppStyles.n(size: 12, color: _colorHint)),
                      const SizedBox(width: 4),
                      _helpIcon(),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _gioiHanChips.map((chip) {
                      final isSelected = _selectedChip == chip;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedChip = chip),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: isSelected ? AppStyles.gold : _colorBorder, width: isSelected ? 1.5 : 1),
                              ),
                              child: Text(chip, style: AppStyles.n(size: 13, weight: isSelected ? FontWeight.w600 : FontWeight.w400, color: _colorText)),
                            ),
                            if (isSelected)
                              Positioned(
                                top: 0,
                                right: 0,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(topRight: Radius.circular(8)),
                                  child: CustomPaint(
                                    size: const Size(22, 22),
                                    painter: _CornerBadgePainter(color: AppStyles.gold),
                                    child: const SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: Align(
                                        alignment: Alignment(0.65, -0.65),
                                        child: Icon(Icons.check, color: Colors.white, size: 11),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  // Các Widget Helper xây dựng giao diện thành phần
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [AppStyles.green1, AppStyles.green2]),
      ),
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 4, bottom: 14, left: 4, right: 12),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.chevron_left, color: Colors.white, size: 28),
            ),
          ),
          Text('Thông tin nhà được bảo hiểm', style: AppStyles.n(size: 17, weight: FontWeight.w700, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
      decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Color(0xFFEEEEEE)))),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed: _xacNhan,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppStyles.gold,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text('Xác nhận', style: AppStyles.n(size: 16, weight: FontWeight.w700, color: Colors.white)),
        ),
      ),
    );
  }

  Widget _fieldCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: _colorBorder, width: 1)),
      child: child,
    );
  }

  Widget _hintText(String hint, bool isRequired) {
    if (!isRequired) return Text(hint, style: AppStyles.n(size: 12, color: _colorHint));
    return RichText(
      text: TextSpan(children: [
        TextSpan(text: hint, style: AppStyles.n(size: 12, color: _colorHint)),
        TextSpan(text: ' *', style: AppStyles.n(size: 12, weight: FontWeight.w700, color: _colorRed)),
      ]),
    );
  }

  Widget _helpIcon() {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppStyles.gold, width: 1.5)),
      child: Center(child: Text('?', style: AppStyles.n(size: 10, weight: FontWeight.w700, color: AppStyles.gold))),
    );
  }

  Widget _pushField({
    required IconData icon,
    required String hint,
    required bool isRequired,
    required String? value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
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
                    _hintText(hint, isRequired),
                    if (value != null) ...[
                      const SizedBox(height: 2),
                      Text(value, style: AppStyles.n(size: 14, weight: FontWeight.w600, color: _colorText), maxLines: 1, overflow: TextOverflow.ellipsis),
                    ],
                  ],
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, color: _colorHint, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// COMPONENT: BỘ CHỌN ĐỊA CHỈ 3 CẤP (TỈNH -> QUẬN -> XÃ) THEO FIGMA
// ─────────────────────────────────────────────────────────────────────────────
class _AddressPickerBottomSheet extends StatefulWidget {
  final Function(String tinh, String quan, String xa) onSelected;

  const _AddressPickerBottomSheet({required this.onSelected});

  @override
  State<_AddressPickerBottomSheet> createState() => _AddressPickerBottomSheetState();
}

class _AddressPickerBottomSheetState extends State<_AddressPickerBottomSheet> {
  int _currentTab = 0; // 0: Tỉnh, 1: Huyện, 2: Xã

  String? _selectedTinh;
  String? _selectedQuan;
  String? _selectedXa;

  String _searchQuery = '';
  final _searchCtrl = TextEditingController();

  // Mock Data dữ liệu
  final List<String> _tinhs = ['Thành phố Hà Nội', 'Thành phố Hồ Chí Minh', 'Đà Nẵng', 'Cần Thơ', 'Hải Phòng'];
  final List<String> _quans = ['Huyện Ba Vì', 'Huyện Chương Mỹ', 'Huyện Gia Lâm', 'Huyện Hoài Đức', 'Huyện Mê Linh'];
  final List<String> _xas = ['Thị trấn Tây Đằng', 'Xã Ba Trại', 'Xã Ba Vì', 'Xã Cam Thượng', 'Xã Chu Minh'];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<String> _getCurrentList() {
    List<String> list = [];
    if (_currentTab == 0) list = _tinhs;
    if (_currentTab == 1) list = _quans;
    if (_currentTab == 2) list = _xas;

    if (_searchQuery.isEmpty) return list;
    return list.where((item) => item.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
  }

  String _getSearchHint() {
    if (_currentTab == 0) return 'Tìm kiếm Tỉnh/Thành phố';
    if (_currentTab == 1) return 'Tìm kiếm Quận/Huyện';
    return 'Tìm kiếm Phường/Xã';
  }

  @override
  Widget build(BuildContext context) {
    final currentList = _getCurrentList();

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 32),
                Text('Tỉnh/Thành phố', style: AppStyles.n(size: 16, weight: FontWeight.w700)),
                IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
              ],
            ),
          ),
          const Divider(height: 1),
          // Các Tab chuyển cấp địa chỉ độc lập
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                _buildTabItem(title: _selectedTinh ?? 'Chọn Tỉnh/TP', index: 0),
                if (_selectedTinh != null) ...[
                  const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
                  _buildTabItem(title: _selectedQuan ?? 'Chọn Quận/Huyện', index: 1),
                ],
                if (_selectedQuan != null) ...[
                  const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
                  _buildTabItem(title: _selectedXa ?? 'Chọn Phường/Xã', index: 2),
                ],
              ],
            ),
          ),
          // Ô Tìm kiếm lọc dữ liệu
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Container(
              decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFE0E0E0))),
              child: TextField(
                controller: _searchCtrl,
                onChanged: (v) => setState(() => _searchQuery = v),
                decoration: InputDecoration(
                  hintText: _getSearchHint(),
                  hintStyle: AppStyles.n(size: 14, color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: currentList.length,
              itemBuilder: (context, i) {
                final item = currentList[i];
                bool isSelected = false;
                if (_currentTab == 0) isSelected = _selectedTinh == item;
                if (_currentTab == 1) isSelected = _selectedQuan == item;
                if (_currentTab == 2) isSelected = _selectedXa == item;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _searchCtrl.clear();
                      _searchQuery = '';
                      if (_currentTab == 0) {
                        _selectedTinh = item;
                        _selectedQuan = null;
                        _selectedXa = null;
                        _currentTab = 1; // Chọn tỉnh xong tự nhảy sang chọn Huyện
                      } else if (_currentTab == 1) {
                        _selectedQuan = item;
                        _selectedXa = null;
                        _currentTab = 2; // Chọn huyện xong tự nhảy sang chọn Xã
                      } else if (_currentTab == 2) {
                        _selectedXa = item;
                        widget.onSelected(_selectedTinh!, _selectedQuan!, _selectedXa!);
                        Navigator.pop(context); // Chọn xong cả 3 cấp thì tự động đóng sheet
                      }
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: isSelected ? AppStyles.gold : const Color(0xFFE0E0E0), width: isSelected ? 1.5 : 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item, style: AppStyles.n(size: 14, weight: isSelected ? FontWeight.w600 : FontWeight.w400, color: const Color(0xFF2D2D2D))),
                        Icon(isSelected ? Icons.radio_button_checked : Icons.radio_button_off, color: isSelected ? AppStyles.gold : const Color(0xFFCCCCCC), size: 20),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem({required String title, required int index}) {
    final isActive = _currentTab == index;
    return GestureDetector(
      onTap: () {
        if (index == 0 || (index == 1 && _selectedTinh != null) || (index == 2 && _selectedQuan != null)) {
          setState(() {
            _currentTab = index;
            _searchCtrl.clear();
            _searchQuery = '';
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: isActive ? AppStyles.gold : Colors.transparent, width: 2))),
        child: Text(title, style: AppStyles.n(size: 14, weight: isActive ? FontWeight.w700 : FontWeight.w500, color: isActive ? AppStyles.gold : const Color(0xFF777777))),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// UTILS: CÁC LỚP ĐỊNH DẠNG TIỀN TỆ VÀ VẼ BADGE
// ─────────────────────────────────────────────────────────────────────────────
class _ThousandFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;
    final digits = newValue.text.replaceAll('.', '');
    final number = int.tryParse(digits);
    if (number == null) return oldValue;
    final formatted = _format(number);
    return newValue.copyWith(text: formatted, selection: TextSelection.collapsed(offset: formatted.length));
  }

  String _format(int n) {
    final s = n.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
      buf.write(s[i]);
    }
    return buf.toString();
  }
}

class _CornerBadgePainter extends CustomPainter {
  final Color color;
  const _CornerBadgePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()..moveTo(0, 0)..lineTo(size.width, 0)..lineTo(size.width, size.height)..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CornerBadgePainter old) => old.color != color;
}