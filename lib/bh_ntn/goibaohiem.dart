import 'package:flutter/material.dart';
import 'package:my_hdi/BH_NTN/chitiet_goibaohiem.dart';
import 'package:my_hdi/bh_ntn/thongtinyeucaubh.dart';
import 'package:my_hdi/models/goi_data.dart';
import 'package:my_hdi/utils/app_styles.dart';

final _danhSachGoi = [
  GoiData(
    id: 'đồng',
    ten: 'Bảo hiểm gói Đồng',
    moTa: 'Cho rủi ro Cháy, Nổ, Sét đánh',
    gia: '4.000.000 VNĐ/năm',
    iconPath: 'assets/image_BHNTN/icon_dong.png',
    bgPath: 'assets/image_BHNTN/background_goibh.png',
    bgColor1: Color(0xFFA5D6A7),
    bgColor2: Color(0xFF66BB6A),

    lienQuan: false,
    quyenLoi: [
      QuyenLoiRow(
        label: 'Bảo hiểm cho ngôi nhà',
        value: 'Được bảo hiểm',
        isGreen: true,
      ),
      QuyenLoiRow(
        label: 'Bảo hiểm cho tài sản\ntrong nhà',
        value: 'Không bảo hiểm',
        isGreen: false,
      ),
      QuyenLoiRow(
        label: 'Phạm vi bảo hiểm\ncơ bản',
        value: 'Được bảo hiểm',
        isGreen: true,
      ),
      QuyenLoiRow(
        label: 'Phạm vi bảo hiểm mở\nrộng',
        value: 'Không bảo hiểm',
        isGreen: false,
      ),
    ],
  ),
  GoiData(
    id: 'bạc',
    ten: 'Bảo hiểm gói Bạc',
    moTa: 'Cho rủi ro Cháy, Nổ, Sét đánh',
    gia: '5.000.000 VNĐ/năm',
    iconPath: 'assets/image_BHNTN/icon_bac.png',
    bgPath: 'assets/image_BHNTN/background_goibh.png',
    bgColor1: Color(0xFF90CAF9),
    bgColor2: Color(0xFF42A5F5),
    lienQuan: false,
    quyenLoi: [
      QuyenLoiRow(
        label: 'Bảo hiểm cho ngôi nhà',
        value: 'Được bảo hiểm',
        isGreen: true,
      ),
      QuyenLoiRow(
        label: 'Bảo hiểm cho tài sản\ntrong nhà',
        value: 'Được bảo hiểm',
        isGreen: true,
      ),
      QuyenLoiRow(
        label: 'Phạm vi bảo hiểm\ncơ bản',
        value: 'Được bảo hiểm',
        isGreen: true,
      ),
      QuyenLoiRow(
        label: 'Phạm vi bảo hiểm mở\nrộng',
        value: 'Không bảo hiểm',
        isGreen: false,
      ),
    ],
  ),
  GoiData(
    id: 'vàng',
    ten: 'Bảo hiểm gói Vàng',
    moTa: 'Cho rủi ro Cháy, Nổ, Sét đánh và quyền lợi mở rộng',
    gia: '6.000.000 VNĐ/năm',
    iconPath: 'assets/image_BHNTN/icon_vang.png',
    bgPath: 'assets/image_BHNTN/background_goibh.png',
    bgColor1: Color(0xFFFFCC80),
    bgColor2: Color(0xFFFFA726),
    lienQuan: true,
    quyenLoi: [
      QuyenLoiRow(
        label: 'Bảo hiểm cho ngôi nhà',
        value: 'Được bảo hiểm',
        isGreen: true,
      ),
      QuyenLoiRow(
        label: 'Bảo hiểm cho tài sản\ntrong nhà',
        value: 'Không bảo hiểm',
        isGreen: false,
      ),
      QuyenLoiRow(
        label: 'Phạm vi bảo hiểm\ncơ bản',
        value: 'Được bảo hiểm',
        isGreen: true,
      ),
      QuyenLoiRow(
        label: 'Phạm vi bảo hiểm mở\nrộng',
        value: 'Được bảo hiểm',
        isGreen: true,
      ),
    ],
  ),
  GoiData(
    id: 'titan',
    ten: 'Bảo hiểm gói Titan',
    moTa: 'Cho rủi ro Cháy, Nổ, Sét đánh và quyền lợi mở rộng',
    gia: '7.360.000 VNĐ/năm',
    iconPath: 'assets/image_BHNTN/icon_titan.png',
    bgPath: 'assets/image_BHNTN/background_goibh.png',
    bgColor1: Color(0xFFBDBDBD),
    bgColor2: Color(0xFF757575),
    lienQuan: true,
    quyenLoi: [
      QuyenLoiRow(
        label: 'Bảo hiểm cho ngôi nhà',
        value: 'Được bảo hiểm',
        isGreen: true,
      ),
      QuyenLoiRow(
        label: 'Bảo hiểm cho tài sản\ntrong nhà',
        value: 'Được bảo hiểm',
        isGreen: true,
      ),
      QuyenLoiRow(
        label: 'Phạm vi bảo hiểm\ncơ bản',
        value: 'Được bảo hiểm',
        isGreen: true,
      ),
      QuyenLoiRow(
        label: 'Phạm vi bảo hiểm mở\nrộng',
        value: 'Được bảo hiểm',
        isGreen: true,
      ),
    ],
  ),
];

// ── Screen ─────────────────────────────────────
class GoiBaoHiem extends StatefulWidget {
  final int giaTriNgoiNha;
  const GoiBaoHiem({super.key, required this.giaTriNgoiNha});

  @override
  State<GoiBaoHiem> createState() => _GoiBaoHiemState();
}

class _GoiBaoHiemState extends State<GoiBaoHiem> {
  final PageController _pageCtrl = PageController(viewportFraction: 0.88);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final goi = _danhSachGoi[_currentPage];

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
                  const SizedBox(height: 40),

                  // ── PageView cards ──────────
                  SizedBox(
                    height: 480,
                    child: PageView.builder(
                      controller: _pageCtrl,
                      clipBehavior: Clip.none,
                      itemCount: _danhSachGoi.length,
                      onPageChanged: (i) => setState(() => _currentPage = i),
                      itemBuilder: (_, i) =>
                          _buildGoiCard(_danhSachGoi[i], i == _currentPage),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ── Dot indicator ───────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_danhSachGoi.length, (i) {
                      final active = i == _currentPage;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: active ? 20 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: active
                              ? AppStyles.gold
                              : const Color(0xFFDDDDDD),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 24),

                  // ── Sản phẩm section ────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          goi.lienQuan ? 'Sản phẩm liên quan' : 'Sản phẩm khác',
                          style: AppStyles.n(
                            size: 18,
                            weight: FontWeight.w700,
                            color: const Color(0xFFDA2128),
                          ),
                        ),
                        Text(
                          'Xem tất cả',
                          style: AppStyles.n(
                            size: 14,
                            color: AppStyles.gold,
                            weight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Sản phẩm khác list
                  SizedBox(
                    height: 130,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          _buildItemScroll(
                            context,
                            'assets/image_BHNTN/icon_spkhac.png',
                            'Bảo hiểm tai\nnạn con người',
                          ),
                          const SizedBox(width: 12),
                          _buildItemScroll(
                            context,
                            'assets/image_BHNTN/icon_spkhac.png',
                            'Bảo hiểm du\nlịch Việt Nam',
                          ),
                          const SizedBox(width: 12),
                          _buildItemScroll(
                            context,
                            'assets/image_BHNTN/icon_spkhac.png',
                            'Bảo hiểm du\nlịch quốc tế',
                          ),
                          const SizedBox(width: 12),
                          _buildItemScroll(
                            context,
                            'assets/image_BHNTN/icon_spkhac.png',
                            'Bảo hiểm CSSK\nvà TN cá nhân',
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemScroll(BuildContext context, String icon, String title) {
    // Tính toán chiều rộng để hiển thị 2 sản phẩm + khoảng cách
    double itemWidth = (MediaQuery.of(context).size.width - 32 - 12) / 2.05;

    return SizedBox(width: itemWidth, child: _buildSanPhamKhac(icon, title));
  }

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
          Text(
            'Gói bảo hiểm',
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

  Widget _buildGoiCard(GoiData goi, bool isActive) {
    return AnimatedScale(
      scale: isActive ? 1.0 : 0.95,
      duration: const Duration(milliseconds: 250),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none, // Cho phép icon hiển thị lấn ra ngoài border
          alignment: Alignment.topCenter,
          children: [
            // --- LỚP 1: NỘI DUNG CHÍNH CỦA CARD ---
            Column(
              children: [
                // ── Card header (gradient) ────────
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(16, 45, 16, 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [goi.bgColor1, goi.bgColor2],
                    ),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    image: DecorationImage(
                      image: AssetImage(goi.bgPath),
                      fit: BoxFit.cover,
                      opacity: 0.15,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        goi.ten,
                        style: AppStyles.n(
                          size: 18,
                          weight: FontWeight.w700,
                          color: Color(0xFFDA2128),
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        goi.moTa,
                        style: AppStyles.n(
                          size: 12,
                          color: Color(0xFF2D2D2D),
                          height: 1.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        goi.gia,
                        style: AppStyles.n(
                          size: 15,
                          weight: FontWeight.w700,
                          color: Color(0xFF1E552A),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                // ── Bảng quyền lợi ───────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                  child: Column(
                    children: [
                      // Header row
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Bảo hiểm cho\n ngôi nhà',
                              style: AppStyles.n(
                                size: 13,
                                weight: FontWeight.w700,
                                color: const Color(0xFF444444),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Tối đa đên giới hạn\n bồi thường',
                              style: AppStyles.n(
                                size: 13,
                                weight: FontWeight.w700,
                                color: const Color(0xFF444444),
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 12, color: Color(0xFFEEEEEE)),
                      ...goi.quyenLoi.map((row) => _buildQuyenLoiRow(row)),
                    ],
                  ),
                ),

                // ── Xem chi tiết ─────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChiTietGoiBaoHiem(
                            selectedGoiId: goi.id, // truyền id gói hiện tại
                          ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Xem chi tiết sản phẩm',
                          style: AppStyles.n(
                            size: 13,
                            weight: FontWeight.w600,
                            color: AppStyles.gold,
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: AppStyles.gold,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),

                // ── Nút Mua ngay ─────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        final selectedGoi = _danhSachGoi[_currentPage];
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ThongTinYeuCauBaoHiem(selectedGoi: selectedGoi),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppStyles.gold,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
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
                ),
              ],
            ),

            // --- LỚP 2: ICON NẰM LƠ LỬNG TRÊN BORDER ---
            Positioned(
              top: -35, // Đẩy icon nhô lên trên border
              child: Container(
                width: 70,
                height: 70,
                padding: const EdgeInsets.all(4),
                child: Image.asset(
                  goi.iconPath,
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) =>
                      const Icon(Icons.shield, color: AppStyles.gold, size: 40),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuyenLoiRow(QuyenLoiRow row) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cột 1: Chiếm 50% bên trái
          Expanded(
            flex: 1,
            child: Text(
              row.label,
              style: AppStyles.n(
                size: 12,
                color: const Color(0xFF666666),
                height: 1.4,
              ),
            ),
          ),
          // Cột 2: Chiếm 50% bên phải
          Expanded(
            flex: 1,
            child: Text(
              row.value,
              style: AppStyles.n(
                size: 12,
                weight: FontWeight.w700,
                color: row.isGreen
                    ? const Color(0xFF09B03E)
                    : const Color(0xFFDA2128),
                height: 1.4,
              ),
              textAlign: TextAlign.right, // Căn lề phải
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSanPhamKhac(String iconPath, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFEEEEEE)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              width: 36,
              height: 36,
              errorBuilder: (_, _, _) => Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.health_and_safety_outlined,
                  color: AppStyles.green1,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: AppStyles.n(
                  size: 12,
                  color: const Color(0xFF333333),
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
