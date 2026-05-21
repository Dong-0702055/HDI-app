// ─────────────────────────────────────────────────────────────────────────────
// Model: dữ liệu ngôi nhà được bảo hiểm
// Dùng chung giữa ThongTinNgoiNha và ThongTinYeuCauBaoHiem
// ─────────────────────────────────────────────────────────────────────────────

class NgoiNhaData {
  final String loaiNha;
  final String mucDichSuDung;
  final String gioiHanBoiThuong;
  final String dienTich;
  final String diaChi; // địa chỉ đầy đủ: số nhà + tỉnh/huyện/xã
  final String gioiHanBoiThuongTrongNha; // giá trị chip được chọn

  const NgoiNhaData({
    required this.loaiNha,
    required this.mucDichSuDung,
    required this.gioiHanBoiThuong,
    required this.dienTich,
    required this.diaChi,
    required this.gioiHanBoiThuongTrongNha,
  });
}