import 'package:flutter/material.dart';
import 'thanhtoan_tai_nan_con_nguoi.dart';
class XacNhanThongTinThanhToan extends StatelessWidget {
  final Map<String, dynamic> dataPacket; // Nhận gói dữ liệu từ các bước trước truyền sang

  const XacNhanThongTinThanhToan({super.key, required this.dataPacket});

  // 🧠 HÀM HỖ TRỢ ĐỊNH DẠNG DATETIME SANG STRING AN TOÀN
  String _formatDynamicDate(dynamic dateKey) {
    if (dateKey == null) return "Chưa nhập";
    if (dateKey is DateTime) {
      // Nếu dữ liệu là object DateTime, bóc tách và định dạng lại thành chuỗi DD/MM/YYYY
      return "${dateKey.day.toString().padLeft(2, '0')}/${dateKey.month.toString().padLeft(2, '0')}/${dateKey.year}";
    }
    return dateKey.toString(); // Nếu đã là chuỗi sẵn rồi thì trả về luôn
  }

  @override
  Widget build(BuildContext context) {
    // Ép kiểu an toàn sâu để tránh hoàn toàn lỗi subtype từ các bước trước gửi sang
    final Map<String, dynamic> safeData = Map<String, dynamic>.from(dataPacket);
    final Map<String, dynamic> goiBaoHiem = Map<String, dynamic>.from(safeData['sanPham'] ?? {});

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0A7029), Color(0xFF055E20)],
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Thông tin người được bảo hiểm",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Thanh trạng thái các bước (1 -> 4) - Bước 4 Active
          _buildProgressStepBar(),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // 1. Thẻ hiển thị gói bảo hiểm đã chọn
                  _buildProductSummaryCard(goiBaoHiem),
                  const SizedBox(height: 16),

                  // 2. Thẻ hiển thị chi tiết thông tin người được bảo hiểm
                  _buildCustomerDetailsCard(context, safeData),
                  const SizedBox(height: 12),

                  // 3. Thanh xem giấy chứng nhận mẫu
                  _buildSampleCertificateRow(),
                ],
              ),
            ),
          ),

          // Nút Thanh toán cố định ở chân trang
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade200)),
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    // 👉 2. XỬ LÝ ĐIỀU HƯỚNG: Chuyển màn hình và truyền kèm dataPacket sang trang thanh toán
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ThanhToanScreen(
                          dataPacket: safeData, // Truyền gói dữ liệu an toàn sang
                        ),
                      ),
                    );
                    print("Bắt đầu xử lý thanh toán cho đơn hàng của: ${safeData['name']}");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFBB8A0B),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text(
                    "Thanh toán",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressStepBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Row(
        children: [
          _buildStepNode("1", "Chọn gói\nsức khoẻ", isCompleted: true),
          _buildStepLine(isCompleted: true),
          _buildStepNode("2", "Người được\nbảo hiểm", isCompleted: true),
          _buildStepLine(isCompleted: true),
          _buildStepNode("3", "Xác nhận\nthông tin", isCompleted: true),
          _buildStepLine(isCompleted: true),
          _buildStepNode("4", "Thanh toán", isActive: true),
        ],
      ),
    );
  }

  Widget _buildStepNode(String number, String title, {bool isCompleted = false, bool isActive = false}) {
    Color circleColor = Colors.grey.shade300;
    Color textColor = Colors.black87;
    if (isCompleted || isActive) circleColor = const Color(0xFF0A7029);
    if (isActive) textColor = const Color(0xFF0A7029);

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: circleColor,
            child: isCompleted
                ? const Icon(Icons.check, color: Colors.white, size: 14)
                : Text(number, style: TextStyle(color: isActive ? Colors.white : Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10, color: textColor, fontWeight: isActive ? FontWeight.bold : FontWeight.w400, height: 1.2),
          ),
        ],
      ),
    );
  }

  Widget _buildStepLine({required bool isCompleted}) {
    return Container(
      width: 30,
      height: 1.5,
      margin: const EdgeInsets.only(bottom: 24),
      color: isCompleted ? const Color(0xFF0A7029) : Colors.grey.shade300,
    );
  }

  Widget _buildProductSummaryCard(Map<String, dynamic> goiBaoHiem) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              goiBaoHiem['image'] ?? 'assets/image/baohiem6.png',
              width: 48,
              height: 48,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 48,
                height: 48,
                color: Colors.blue.shade100,
                child: const Icon(Icons.shield, color: Colors.blue),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Bảo hiểm tai nạn con người",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF2D2D2D)),
                ),
                const SizedBox(height: 4),
                Text(
                  "x1 ${goiBaoHiem['title'] ?? 'Gói cơ bản'}",
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  goiBaoHiem['price'] ?? "0 VNĐ",
                  style: const TextStyle(fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerDetailsCard(BuildContext context, Map<String, dynamic> personalData) {
    // Gộp chuỗi thời hạn bảo hiểm một cách an toàn bằng hàm định dạng hỗ trợ chuyên sâu
    String thoiHanBaoHiem = "Chưa xác định";
    if (personalData['startDate'] != null && personalData['endDate'] != null) {
      String start = _formatDynamicDate(personalData['startDate']);
      String end = _formatDynamicDate(personalData['endDate']);
      thoiHanBaoHiem = "$start - $end";
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Người được bảo hiểm",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Quay lại bước trước để chỉnh sửa dữ liệu
                  },
                  child: const Text(
                    "Chỉnh sửa",
                    style: TextStyle(fontSize: 13, color: Color(0xFFBB8A0B), fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF5F5F5)),

          // Tất cả các dòng thông tin đều được xử lý và kiểm tra dữ liệu an toàn trước khi in ra giao diện
          _buildInfoRow("Họ tên:", personalData['name'] ?? "Chưa nhập"),
          _buildInfoRow("Ngày sinh:", _formatDynamicDate(personalData['birthDate'])),
          _buildInfoRow("Giới tính:", personalData['gender'] ?? "Chưa nhập"),
          _buildInfoRow("CMND/CCCD/Hộ Chiếu:", personalData['idNumber'] ?? "Chưa nhập"),
          _buildInfoRow("Số điện thoại:", personalData['phone'] ?? "Chưa nhập"),
          _buildInfoRow("Email:", personalData['email'] ?? "Chưa nhập"),
          _buildInfoRow("Thời hạn bảo hiểm:", thoiHanBaoHiem),

          const Divider(height: 1, thickness: 1, color: Color(0xFFF5F5F5)),

          // Nút xem chi tiết quyền lợi gói
          InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Xem chi tiết quyền lợi ",
                    style: TextStyle(color: Color(0xFFBB8A0B), fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 12, color: Color(0xFFBB8A0B)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 13, color: Color(0xFF2D2D2D), fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSampleCertificateRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Image.asset('assets/icons/icon_doc.png', width: 20, height: 20, errorBuilder: (c, e, s) => const Icon(Icons.description, color: Colors.grey, size: 20)),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              "Xem giấy chứng nhận mẫu",
              style: TextStyle(fontSize: 13, color: Color(0xFF2D2D2D), fontWeight: FontWeight.w500),
            ),
          ),
          const Icon(Icons.arrow_forward, size: 18, color: Colors.grey),
        ],
      ),
    );
  }
}