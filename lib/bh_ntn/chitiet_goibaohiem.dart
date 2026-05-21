import 'package:flutter/material.dart';
import 'package:my_hdi/bh_ntn/thongtinyeucaubh.dart';
import 'package:my_hdi/models/goi_data.dart';
import 'package:my_hdi/utils/app_styles.dart';

extension GoiDataExt on GoiData {
  String get tenNgan {
    if (id == 'đồng') return 'Gói Đồng';
    if (id == 'bạc') return 'Gói Bạc';
    if (id == 'vàng') return 'Gói Vàng';
    if (id == 'titan') return 'Gói Titan';
    return ten;
  }
}

// Danh sách gói nội bộ dùng trong màn chi tiết (id khớp với goibaohiem.dart)
final List<GoiData> _chiTietDanhSachGoi = [
  const GoiData(
    id: 'đồng',
    ten: 'Bảo hiểm gói Đồng',
    moTa: 'Không có quyền lợi mở rộng',
    gia: '4.000.000 VNĐ/năm',
    iconPath: 'assets/image_BHNTN/icon_dong.png',
    bgPath: 'assets/image_BHNTN/background_goibh.png',
    bgColor1: Color(0xFF2E7D32),
    bgColor2: Color(0xFF0A2E12),
    lienQuan: false,
    quyenLoi: [],
  ),
  const GoiData(
    id: 'bạc',
    ten: 'Bảo hiểm gói Bạc',
    moTa: 'Quyền lợi cơ bản mở rộng',
    gia: '5.000.000 VNĐ/năm',
    iconPath: 'assets/image_BHNTN/icon_bac.png',
    bgPath: 'assets/image_BHNTN/background_goibh.png',
    bgColor1: Color(0xFF455A64),
    bgColor2: Color(0xFF102027),
    lienQuan: false,
    quyenLoi: [],
  ),
  const GoiData(
    id: 'vàng',
    ten: 'Bảo hiểm gói Vàng',
    moTa: 'Cho rủi ro Cháy, Nổ, Sét đánh và quyền lợi mở rộng',
    gia: '6.000.000 VNĐ/năm',
    iconPath: 'assets/image_BHNTN/icon_vang.png',
    bgPath: 'assets/image_BHNTN/background_goibh.png',
    bgColor1: Color(0xFFF57C00),
    bgColor2: Color(0xFFBF360C),
    lienQuan: true,
    quyenLoi: [],
  ),
  const GoiData(
    id: 'titan',
    ten: 'Bảo hiểm gói Titan',
    moTa: 'Cho rủi ro Cháy, Nổ, Sét đánh và quyền lợi mở rộng',
    gia: '7.360.000 VNĐ/năm',
    iconPath: 'assets/image_BHNTN/icon_titan.png',
    bgPath: 'assets/image_BHNTN/background_goibh.png',
    bgColor1: Color(0xFF37474F),
    bgColor2: Color(0xFF000000),
    lienQuan: true,
    quyenLoi: [],
  ),
];

// ─────────────────────────────────────────────────────────────────────────────
// Models nội bộ cho bảng so sánh (chỉ dùng trong file này)
// ─────────────────────────────────────────────────────────────────────────────

class _MucSoSanh {
  final String tenMuc;
  final Map<String, bool> giaTriTheoGoi;
  final Map<String, String?> textOverride;
  final TextStyle? textStyle;

  const _MucSoSanh({
    required this.tenMuc,
    required this.giaTriTheoGoi,
    this.textOverride = const {},
    this.textStyle,
  });
}

class _NhomSoSanh {
  final String tieuDe;
  final Map<String, String>? headerRow;
  final List<_MucSoSanh> mucList;

  const _NhomSoSanh({
    required this.tieuDe,
    this.headerRow,
    required this.mucList,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// Dữ liệu bảng so sánh
// ─────────────────────────────────────────────────────────────────────────────

List<_NhomSoSanh> _buildNhomData() => [
  const _NhomSoSanh(
    tieuDe: 'I. Bảo hiểm cho ngôi nhà',
    headerRow: {
      'đồng': 'Cho rủi ro Cháy,\nNổ, Sét đánh',
      'bạc': 'Cho rủi ro Cháy,\nNổ, Sét đánh',
      'vàng': 'Cho rủi ro Cháy, Nổ,\nSét đánh và quyền lợi mở rộng',
      'titan': 'Cho rủi ro Cháy, Nổ,\nSét đánh và quyền lợi mở rộng',
    },
    mucList: [
      _MucSoSanh(
        tenMuc: '',
        giaTriTheoGoi: {'đồng': true, 'bạc': true, 'vàng': true, 'titan': true},
        textOverride: {
          'đồng': 'Tối đa đến giới hạn bồi thường',
          'bạc': 'Tối đa đến giới hạn bồi thường',
          'vàng': 'Tối đa đến giới hạn bồi thường',
          'titan': 'Tối đa đến giới hạn bồi thường',
        },
        textStyle: TextStyle(fontSize: 12, color: Color(0xFF2D2D2D)),
      ),
    ],
  ),
  const _NhomSoSanh(
    tieuDe: 'II. Bảo hiểm cho tài sản trong nhà',
    mucList: [
      _MucSoSanh(
        tenMuc: '',
        giaTriTheoGoi: {
          'đồng': false,
          'bạc': true,
          'vàng': false,
          'titan': true,
        },
        textOverride: {
          'đồng': 'Không bảo hiểm',
          'bạc': '20% Giới hạn bồi thường\ncủa ngôi nhà',
          'vàng': 'Không bảo hiểm',
          'titan': '20% Giới hạn bồi thường\ncủa ngôi nhà',
        },
      ),
    ],
  ),
  const _NhomSoSanh(
    tieuDe: 'III. Phạm vi bảo hiểm cơ bản',
    headerRow: {
      'đồng': 'Được bảo hiểm',
      'bạc': 'Được bảo hiểm',
      'vàng': 'Được bảo hiểm',
      'titan': 'Được bảo hiểm',
    },
    mucList: [
      _MucSoSanh(
        tenMuc: '1. Cháy, sét đánh, nổ',
        giaTriTheoGoi: {'đồng': true, 'bạc': true, 'vàng': true, 'titan': true},
      ),
    ],
  ),
  const _NhomSoSanh(
    tieuDe: 'IV. Phạm vi bảo hiểm mở rộng',
    headerRow: {
      'đồng': 'Không bảo hiểm',
      'bạc': 'Không bảo hiểm',
      'vàng': 'Được bảo hiểm',
      'titan': 'Được bảo hiểm',
    },
    mucList: [
      _MucSoSanh(
        tenMuc: '1. Mở rộng 1: Giông, Bão, Lũ lụt\n(Bao gồm nước biển tràn)',
        giaTriTheoGoi: {
          'đồng': false,
          'bạc': false,
          'vàng': true,
          'titan': true,
        },
      ),
      _MucSoSanh(
        tenMuc:
            '2. Mở rộng 2: Vỡ tràn nước từ bể chứa,\nthiết bị hoặc đường ống dẫn nước',
        giaTriTheoGoi: {
          'đồng': false,
          'bạc': false,
          'vàng': true,
          'titan': true,
        },
      ),
      _MucSoSanh(
        tenMuc: '3. Mở rộng 3: Va chạm với ngôi nhà',
        giaTriTheoGoi: {
          'đồng': false,
          'bạc': false,
          'vàng': true,
          'titan': true,
        },
      ),
      _MucSoSanh(
        tenMuc: '4. Mở rộng 4: Trộm cướp',
        giaTriTheoGoi: {
          'đồng': false,
          'bạc': false,
          'vàng': true,
          'titan': true,
        },
      ),
      _MucSoSanh(
        tenMuc: '5. Chi phí thuê nhà tạm thời',
        giaTriTheoGoi: {
          'đồng': false,
          'bạc': false,
          'vàng': true,
          'titan': true,
        },
        textOverride: {
          'đồng': null,
          'bạc': null,
          'vàng':
              'Giới hạn 5% Số tiền\nbảo hiểm ngôi nhà và\nkhông vượt quá 60 ngày',
          'titan':
              'Giới hạn 5% Số tiền\nbảo hiểm ngôi nhà và\nkhông vượt quá 60 ngày',
        },
      ),
    ],
  ),
];

class ChiTietGoiBaoHiem extends StatefulWidget {
  final String selectedGoiId;

  const ChiTietGoiBaoHiem({super.key, required this.selectedGoiId});

  @override
  State<ChiTietGoiBaoHiem> createState() => _ChiTietGoiBaoHiemState();
}

class _ChiTietGoiBaoHiemState extends State<ChiTietGoiBaoHiem> {
  late String _leftId;
  late String _rightId;

  @override
  void initState() {
    super.initState();
    _rightId = widget.selectedGoiId;
    _leftId = _chiTietDanhSachGoi.firstWhere((g) => g.id != _rightId).id;
  }

  GoiData get _leftGoi =>
      _chiTietDanhSachGoi.firstWhere((g) => g.id == _leftId);
  GoiData get _rightGoi =>
      _chiTietDanhSachGoi.firstWhere((g) => g.id == _rightId);

  // ── Mở bottom sheet chọn gói ──────────────────────────────────────────────

  void _chonGoi(bool isLeft) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true, // Cho phép vượt quá nửa màn hình
      useSafeArea: true, // Tránh đè lên phần tai thỏ/thanh trạng thái
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.85, // Đẩy cao lên chiếm 90% chiều cao màn hình
        child: _BottomSheetChonGoi(
          currentId: isLeft ? _leftId : _rightId,
          otherSelectedId: isLeft ? _rightId : _leftId,
          onSelected: (id) => setState(() {
            if (isLeft) {
              _leftId = id;
            } else {
              _rightId = id;
            }
          }),
        ),
      ),
    );
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildHeader(context),
          _buildCotHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Column(
                        children: [..._buildNhomData().map(_buildNhom)],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  // ── App bar gradient với nút "Chọn gói so sánh khác" ở góc phải ──────────

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
          // Nút back
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
          // Tiêu đề căn giữa
          Text(
            'Chi tiết quyền lợi các gói',
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

  // ── Header 2 cột ──────────────────────────────────────────────────────────

  Widget _buildCotHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Chip "Chọn gói so sánh khác" — căn phải, text + icon vàng, nền trắng
          GestureDetector(
            onTap: () => _chonGoi(false),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Chọn gói so sánh khác',
                    style: AppStyles.n(
                      size: 13,
                      weight: FontWeight.w600,
                      color: Color(0xFFBB8A0B),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppStyles.gold,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
          // 2 cột gói
          Row(
            children: [
              _buildGoiHeaderCell(_leftGoi, isSelected: false, isLeft: true),
              const SizedBox(width: 12),
              _buildGoiHeaderCell(_rightGoi, isSelected: true, isLeft: false),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildGoiHeaderCell(
    GoiData goi, {
    required bool isSelected,
    required bool isLeft,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _chonGoi(isLeft),
        child: Container(
          margin: const EdgeInsets.all(1), // Tạo khoảng cách giữa 2 box
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? AppStyles.gold : const Color(0xFFE0E0E0),
              width: isSelected ? 1.5 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          // --- GIẢI PHÁP CHÍNH: Bọc ClipRRect ở đây ---
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              10,
            ), // Phải khớp với BorderRadius của Container
            child: Stack(
              children: [
                // Nội dung chính của Card
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 10,
                  ),
                  child: Column(
                    mainAxisSize:
                        MainAxisSize.min, // Giúp card co giãn theo nội dung
                    crossAxisAlignment: CrossAxisAlignment
                        .stretch, // Cho text chiếm hết chiều ngang
                    children: [
                      Text(
                        goi.tenNgan,
                        style: AppStyles.n(
                          size: 14,
                          weight: FontWeight.w700,
                          color: const Color(0xFF2D2D2D),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        (goi.id == 'đồng' || goi.id == 'bạc')
                            ? 'Không có quyền lợi mở rộng'
                            : 'Có quyền lợi mở rộng',
                        style: AppStyles.n(
                          size: 11,
                          color: const Color(
                            0xFF888888,
                          ), // Màu xám nhẹ hơn cho tinh tế
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        goi.gia,
                        style: AppStyles.n(
                          size: 12,
                          weight: FontWeight.w700,
                          color: isSelected
                              ? AppStyles.green2
                              : const Color(0xFF555555),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                // Badge tam giác vàng
                if (isSelected)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: CustomPaint(
                      size: const Size(
                        28,
                        28,
                      ), // Thu nhỏ lại một chút cho thanh thoát
                      painter: _CornerBadgePainter(color: AppStyles.gold),
                      child: const SizedBox(
                        width: 28,
                        height: 28,
                        child: Align(
                          alignment: Alignment(0.6, -0.6),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Nhóm (section) ────────────────────────────────────────────────────────

  Widget _buildNhom(_NhomSoSanh nhom) {
    return Column(
      children: [
        // Tiêu đề nhóm — căn giữa, nền xanh nhạt
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          color: const Color(0xFFD8FFE4),
          child: Text(
            nhom.tieuDe,
            style: AppStyles.n(
              size: 13,
              weight: FontWeight.w600,
              color: const Color(0xFF2D2D2D),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        // Dòng header mô tả (nếu có)
        if (nhom.headerRow != null) _buildHeaderRow(nhom.headerRow!),
        // Các mục
        ...nhom.mucList.map(_buildMucRow),
      ],
    );
  }

  // Dòng text mô tả ("Được bảo hiểm" / "Không bảo hiểm" / text dài)
  Widget _buildHeaderRow(Map<String, String> headerRow) {
    final leftText = headerRow[_leftId] ?? '';
    final rightText = headerRow[_rightId] ?? '';

    final isStatus = leftText.contains('Không') || leftText.contains('Được');

    Color _textColor(String text) {
      if (!isStatus) return const Color(0xFF2D2D2D);
      return text.contains('Không')
          ? const Color(0xFFDA2128)
          : const Color(0xFF09B03E);
    }

    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  leftText,
                  style: AppStyles.n(
                    size: 12,
                    weight: FontWeight(500),
                    color: _textColor(leftText),
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(width: 1, color: const Color(0xFFEEEEEE)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  rightText,
                  style: AppStyles.n(
                    size: 12,
                    weight: FontWeight(500),
                    color: _textColor(rightText),
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Dòng mục: label full-width + 2 ô check/cross hoặc text override
  Widget _buildMucRow(_MucSoSanh muc) {
    final leftVal = muc.giaTriTheoGoi[_leftId] ?? false;
    final rightVal = muc.giaTriTheoGoi[_rightId] ?? false;
    final leftOverride = muc.textOverride[_leftId];
    final rightOverride = muc.textOverride[_rightId];

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFAFAFA),
        border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Label (full width)
          if (muc.tenMuc.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 8, 14, 4),
              child: Text(
                muc.tenMuc,
                style: AppStyles.n(size: 12, color: const Color(0xFF2D2D2D)),
                textAlign: TextAlign.center,
              ),
            ),
          // 2 ô giá trị
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _buildCell(
                    isTrue: leftVal,
                    textOverride: leftOverride,
                    customStyle: muc.textStyle,
                  ),
                ),
                Container(width: 1, color: const Color(0xFFEEEEEE)),
                Expanded(
                  child: _buildCell(
                    isTrue: rightVal,
                    textOverride: rightOverride,
                    customStyle: muc.textStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCell({
    required bool isTrue,
    String? textOverride,
    TextStyle? customStyle,
  }) {
    if (textOverride != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Text(
          textOverride,
          style: AppStyles.n(
            size: 12,
            weight: FontWeight.w600,
            color:
                customStyle?.color ??
                (isTrue ? const Color(0xFF09B03E) : const Color(0xFFDA2128)),
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: isTrue
            ? const Icon(Icons.check, color: Color(0xFF09B03E), size: 22)
            : const Icon(Icons.close, color: Color(0xFFDA2128), size: 22),
      ),
    );
  }

  // ── Bottom bar ─────────────────────────────────────────────────────────────

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      child: Row(
        children: [
          // Thông tin gói cột phải — theo đúng Figma: "Gói bảo hiểm:" + tên, "Phí bảo hiểm:" + giá
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Gói bảo hiểm: ',
                      style: AppStyles.n(
                        size: 12,
                        color: const Color(0xFF2D2D2D),
                      ),
                    ),
                    TextSpan(
                      text: _rightGoi.tenNgan,
                      style: AppStyles.n(
                        size: 12,
                        weight: FontWeight.w700,
                        color: const Color(0xFFDA2128),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Phí bảo hiểm: ',
                      style: AppStyles.n(
                        size: 12,
                        color: const Color(0xFF2D2D2D),
                      ),
                    ),
                    TextSpan(
                      text: _rightGoi.gia,
                      style: AppStyles.n(
                        size: 13,
                        weight: FontWeight.w700,
                        color: const Color(0xFFDA2128),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          // Nút mua ngay
          SizedBox(
            height: 44,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ThongTinYeuCauBaoHiem(selectedGoi: _rightGoi),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppStyles.gold,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Mua ngay',
                style: AppStyles.n(
                  size: 15,
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
}

// ─────────────────────────────────────────────────────────────────────────────
// Painter: tam giác badge góc trên phải
// ─────────────────────────────────────────────────────────────────────────────

class _CornerBadgePainter extends CustomPainter {
  final Color color;
  const _CornerBadgePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CornerBadgePainter old) => old.color != color;
}

// ─────────────────────────────────────────────────────────────────────────────
// Bottom sheet chọn gói để đổi cột
// ─────────────────────────────────────────────────────────────────────────────

class _BottomSheetChonGoi extends StatefulWidget {
  final String currentId;
  final String otherSelectedId;
  final ValueChanged<String> onSelected;

  const _BottomSheetChonGoi({
    required this.currentId,
    required this.otherSelectedId,
    required this.onSelected,
  });

  @override
  State<_BottomSheetChonGoi> createState() => _BottomSheetChonGoiState();
}

class _BottomSheetChonGoiState extends State<_BottomSheetChonGoi> {
  late String _selectedId;

  @override
  void initState() {
    super.initState();
    _selectedId = widget.currentId;
  }

  String _moTaGoi(GoiData goi) {
    if (goi.id == 'đồng' || goi.id == 'bạc') {
      return 'Cho rủi ro Cháy, Nổ, Sét đánh';
    }
    return 'Cho rủi ro Cháy, Nổ, Sét đánh\nvà quyền lợi mở rộng';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          const SizedBox(height: 10),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 14),
          // Title row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Gói bảo hiểm',
                  style: AppStyles.n(
                    size: 17,
                    weight: FontWeight.w700,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.close,
                    color: Color(0xFF555555),
                    size: 22,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Danh sách gói
          ..._chiTietDanhSachGoi.map((goi) {
            final isSelected = goi.id == _selectedId;
            final isOther = goi.id == widget.otherSelectedId;

            return GestureDetector(
              onTap: isOther
                  ? null
                  : () {
                      setState(() => _selectedId = goi.id);
                      widget.onSelected(goi.id);
                      Navigator.pop(context);
                    },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected
                        ? AppStyles.gold
                        : const Color(0xFFEEEEEE),
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    // Radio icon
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? AppStyles.gold
                              : const Color(0xFFCCCCCC),
                          width: 2,
                        ),
                        color: Colors.white,
                      ),
                      child: isSelected
                          ? Center(
                              child: Container(
                                width: 11,
                                height: 11,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppStyles.gold,
                                ),
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(width: 12),
                    // Tên gói
                    Expanded(
                      child: Text(
                        goi.tenNgan,
                        style: AppStyles.n(
                          size: 14,
                          weight: FontWeight.w600,
                          color: isOther
                              ? const Color(0xFFAAAAAA)
                              : const Color(0xFF1A1A1A),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Giá + mô tả (cột phải)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          goi.gia,
                          style: AppStyles.n(
                            size: 13,
                            weight: FontWeight.w700,
                            color: isOther
                                ? const Color(0xFFCCCCCC)
                                : const Color(0xFFDA2128),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _moTaGoi(goi),
                          style: AppStyles.n(
                            size: 11,
                            color: isOther
                                ? const Color(0xFFCCCCCC)
                                : const Color(0xFF888888),
                            height: 1.4,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
