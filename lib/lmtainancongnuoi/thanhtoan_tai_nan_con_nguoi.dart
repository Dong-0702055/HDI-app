import 'dart:async';
import 'package:flutter/material.dart';

class ThanhToanScreen extends StatefulWidget {
  // 👉 Nhận dữ liệu truyền sang từ bước trước
  final Map<String, dynamic> dataPacket;

  const ThanhToanScreen({super.key, required this.dataPacket});

  @override
  State<ThanhToanScreen> createState() => _ThanhToanScreenState();
}

class _ThanhToanScreenState extends State<ThanhToanScreen> {
  int selectedMethod = 0; // 0: Visa, 1: ATM, 2: Mobile App

  // Các biến phục vụ đếm ngược 30 phút (30 phút = 1800 giây)
  Timer? _timer;
  int _startSeconds = 1800;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Hủy bộ đếm khi thoát màn hình để tránh rò rỉ bộ nhớ (Memory Leak)
    super.dispose();
  }

  // Hàm khởi tạo bộ đếm ngược mỗi giây
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_startSeconds == 0) {
        setState(() {
          timer.cancel();
        });
        // Bạn có thể xử lý hành động khi hết giờ ở đây (Ví dụ: thông báo hết hạn, tự pop màn hình...)
      } else {
        setState(() {
          _startSeconds--;
        });
      }
    });
  }

  // Hàm định dạng số giây còn lại thành chuỗi Phút (MM) và Giây (SS)
  String _getFormattedMinutes() {
    int minutes = _startSeconds ~/ 60;
    return minutes.toString().padLeft(2, '0');
  }
  String _getFormattedSeconds() {
    int seconds = _startSeconds % 60;
    return seconds.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> safeData = Map<String, dynamic>.from(widget.dataPacket);
    final Map<String, dynamic> goiBaoHiem = Map<String, dynamic>.from(safeData['sanPham'] ?? {});
    // Lấy giá gói bảo hiểm truyền sang, nếu không tìm thấy sẽ mặc định hiển thị "1.695.000 VNĐ"
    final String soTienThanhToan = goiBaoHiem['price'] ?? "1.695.000 VNĐ";
    final String tenKhachHang = safeData['name'] ?? "Khách hàng";

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
          "Thanh toán đơn hàng",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 1. Thanh tiến trình (Bước 4 tiến trình hoàn tất)
          Container(
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
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Block hiển thị đếm ngược thời gian giữ chỗ đơn hàng và số tiền tự động cập nhật
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade100),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.account_balance_wallet_outlined,
                          size: 56,
                          color: Colors.orange,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Gói thanh toán bảo hiểm\nsẽ hết hạn sau ",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.blue, fontSize: 13, height: 1.4),
                            ),
                            // 👉 Đổ dữ liệu phút đếm ngược thực tế vào đây
                            _buildCountdownBox(_getFormattedMinutes()),
                            const Text(" : ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                            // 👉 Đổ dữ liệu giây đếm ngược thực tế vào đây
                            _buildCountdownBox(_getFormattedSeconds()),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Divider(height: 1, thickness: 1, color: Color(0xFFF5F5F5)),
                        const SizedBox(height: 12),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Khách hàng:", style: TextStyle(color: Colors.grey, fontSize: 13)),
                            Text(tenKhachHang, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Color(0xFF2D2D2D))),
                          ],
                        ),
                        const SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Số tiền thanh toán", style: TextStyle(color: Colors.grey, fontSize: 13)),
                            // 👉 Số tiền động đã lấy từ màn hình trước truyền sang thành công
                            Text(
                              soTienThanhToan,
                              style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  const Text(
                    "Phương thức thanh toán",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 12),
                  // Lựa chọn phương thức thanh toán
                  _buildPaymentMethodTile(
                    index: 0,
                    title: "Thẻ ghi nợ/Tín dụng",
                    subtitleWidget: Row(
                      children: [
                        const Text("Visa ", style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 12, color: Colors.blue)),
                        Text("mastercard ", style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 12, color: Colors.orange.shade800)),
                        const Text("PayPal", style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 12, color: Colors.blueAccent)),
                      ],
                    ),
                  ),
                  _buildPaymentMethodTile(
                    index: 1,
                    title: "Thẻ ATM/ Tài khoản ngân hàng",
                    trailingIcon: Icons.add_to_home_screen_outlined,
                  ),
                  _buildPaymentMethodTile(
                    index: 2,
                    title: "Ứng dụng di động",
                    trailingIcon: Icons.qr_code_scanner_outlined,
                  ),
                ],
              ),
            ),
          ),

          // Nút bấm thanh toán cuối cùng
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
                  onPressed: _startSeconds > 0 ? () {
                    print("--- BẮT ĐẦU TIẾN TRÌNH KẾT NỐI API PAY GATEWAY ---");
                    print("Khách hàng: $tenKhachHang");
                    print("Giá trị hóa đơn thanh toán: $soTienThanhToan");
                    print("Mã phương thức thanh toán lựa chọn: $selectedMethod");
                  } : null, // Vô hiệu hóa nút bấm nếu thời gian đếm ngược về 00:00
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFBB8A0B),
                    disabledBackgroundColor: Colors.grey.shade300,
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

  Widget _buildCountdownBox(String time) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFF90CAF9)),
      ),
      child: Text(
        time,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.blue),
      ),
    );
  }

  Widget _buildPaymentMethodTile({
    required int index,
    required String title,
    Widget? subtitleWidget,
    IconData? trailingIcon,
  }) {
    bool isSelected = selectedMethod == index;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: isSelected ? const Color(0xFFBB8A0B) : Colors.grey.shade200, width: 1.2),
      ),
      child: ListTile(
        onTap: () {
          setState(() {
            selectedMethod = index;
          });
        },
        leading: Radio<int>(
          value: index,
          groupValue: selectedMethod,
          activeColor: const Color(0xFFBB8A0B),
          onChanged: (value) {
            setState(() {
              selectedMethod = value!;
            });
          },
        ),
        title: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF2D2D2D))),
        subtitle: subtitleWidget,
        trailing: trailingIcon != null ? Icon(trailingIcon, color: const Color(0xFF0A7029), size: 20) : null,
      ),
    );
  }
}