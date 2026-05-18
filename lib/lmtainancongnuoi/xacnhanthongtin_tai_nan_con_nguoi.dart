import 'package:flutter/material.dart';
import 'package:my_hdi/lmtainancongnuoi/xacnhanthongtinlast.dart';

class XacNhanThongTinScreen extends StatefulWidget {
  final Map<String, dynamic> dataPacket; // Nhận gói dữ liệu truyền sang từ màn hình trước

  const XacNhanThongTinScreen({super.key, required this.dataPacket});

  @override
  State<XacNhanThongTinScreen> createState() => _XacNhanThongTinScreenState();
}

class _XacNhanThongTinScreenState extends State<XacNhanThongTinScreen> {
  bool isExpanded = false; // Trạng thái đóng / mở khối văn bản cam kết luật
  String selectedAnswer = ""; // Lưu trạng thái lựa chọn: "Có" hoặc "Không"

  @override
  Widget build(BuildContext context) {
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
          "Xác nhận thông tin",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Thanh trạng thái các bước (1 -> 4)
          _buildProgressStepBar(),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Khối câu hỏi khai báo sức khỏe ban đầu
                  _buildHealthQuestionCard(),
                  const SizedBox(height: 16),

                  // Khối text cam kết có thể đóng mở (Thu gọn / Xem tất cả)
                  _buildLegalCommitmentBlock(),
                ],
              ),
            ),
          ),

          // Nút tiếp tục cố định dưới chân trang (Chỉ bật khi chọn Có/Không)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade200)),
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: selectedAnswer.isNotEmpty ? () {
                    try {
                      // 1. Ép kiểu an toàn sâu cho gói dataPacket tổng thể
                      final Map<String, dynamic> cleanDataPacket = Map<String, dynamic>.from(widget.dataPacket);

                      // 2. Ép kiểu an toàn cho sub-map sanPham bên trong để không bị lỗi ở trang sau
                      if (cleanDataPacket['sanPham'] != null) {
                        cleanDataPacket['sanPham'] = Map<String, dynamic>.from(cleanDataPacket['sanPham']);
                      }

                      // 3. Nếu có dữ liệu hóa đơn dạng Map, ép kiểu an toàn luôn
                      if (cleanDataPacket['invoiceData'] != null && cleanDataPacket['invoiceData'] is Map) {
                        cleanDataPacket['invoiceData'] = Map<String, dynamic>.from(cleanDataPacket['invoiceData']);
                      }

                      // Đính kèm câu trả lời sức khỏe vào gói dữ liệu
                      cleanDataPacket['healthDeclaration'] = selectedAnswer;

                      // Điều hướng sang màn hình Thanh toán mà không sợ bị lỗi subtype
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => XacNhanThongTinThanhToan(
                            dataPacket: cleanDataPacket,
                          ),
                        ),
                      );
                    } catch (e) {
                      print("Lỗi đóng gói dữ liệu: $e");
                    }
                  } : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB8860B),
                    disabledBackgroundColor: Colors.grey.shade300,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text(
                    "Tiếp tục",
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
          _buildStepNode("3", "Xác nhận\nthông tin", isActive: true),
          _buildStepLine(isCompleted: false),
          _buildStepNode("4", "Thanh toán", isCompleted: false),
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
                : Text(number, style: TextStyle(color: isCompleted || isActive ? Colors.white : Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
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

  Widget _buildHealthQuestionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Người tham gia bảo hiểm có thuộc một trong các đối tượng sau đây?",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
          ),
          const SizedBox(height: 12),
          const Text(
            "1. Người đang mắc bệnh tâm thần, bệnh ung thư, bệnh phong\n"
                "2. Người bị thương tật vĩnh viễn từ 70% trở lên\n"
                "3. Người đang trong thời gian điều trị bệnh tật, thương tật",
            style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.5),
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              InkWell(
                onTap: () => setState(() => selectedAnswer = "Có"),
                child: Row(
                  children: [
                    Radio<String>(
                      value: "Có",
                      groupValue: selectedAnswer,
                      activeColor: const Color(0xFFB8860B),
                      onChanged: (val) => setState(() => selectedAnswer = val!),
                    ),
                    const Text("Có", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              const SizedBox(width: 40),
              InkWell(
                onTap: () => setState(() => selectedAnswer = "Không"),
                child: Row(
                  children: [
                    Radio<String>(
                      value: "Không",
                      groupValue: selectedAnswer,
                      activeColor: const Color(0xFFB8860B),
                      onChanged: (val) => setState(() => selectedAnswer = val!),
                    ),
                    const Text("Không", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLegalCommitmentBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            text: "Bằng việc nhấn nút ",
            style: TextStyle(color: Colors.black54, fontSize: 12, height: 1.4),
            children: [
              TextSpan(text: "“TIẾP TỤC”", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
              TextSpan(text: " đồng nghĩa với việc Bên mua bảo hiểm xác nhận và cam kết:"),
            ],
          ),
        ),
        const SizedBox(height: 8),

        AnimatedCrossFade(
          duration: const Duration(milliseconds: 200),
          crossFadeState: isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          firstChild: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRichTextSpan("a) Các thông tin được khai báo, cung cấp là đúng sự thật và hoàn toàn chịu trách nhiệm trước pháp luật. Đồng thời, Bên mua bảo hiểm đã đọc, hiểu và đồng ý với điều kiện, điều khoản và quy tắc của ", "Bảo hiểm HD."),
              const SizedBox(height: 8),
              _buildRichTextSpan("b) Người được bảo hiểm hoặc người đại diện hợp pháp của người được bảo hiểm đồng ý về nội dung yêu cầu bảo hiểm, số tiền bảo hiểm, người thụ hưởng theo quy định của pháp luật.", ""),
              const SizedBox(height: 8),
              _buildRichTextSpan("c) Tôi/chúng tôi cùng những người/các bên có quyền lợi và nghĩa vụ liên quan đồng ý các nội dung ", "Điều khoản và điều kiện chung về bảo vệ và xử lý dữ liệu cá nhân", " của Bảo hiểm HD."),
            ],
          ),
          secondChild: _buildRichTextSpan("a) Các thông tin được khai báo, cung cấp là đúng sự thật và hoàn toàn chịu trách nhiệm trước pháp luật. Đồng thời, Bên mua bảo hiểm đã đọc, hiểu và đồng ý với điều kiện, điều khoản và quy tắc...", ""),
        ),

        Center(
          child: TextButton.icon(
            onPressed: () => setState(() => isExpanded = !isExpanded),
            icon: Icon(
              isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: const Color(0xFFB8860B),
              size: 18,
            ),
            label: Text(
              isExpanded ? "Thu gọn" : "Xem tất cả",
              style: const TextStyle(color: Color(0xFFB8860B), fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRichTextSpan(String normalText, String highlightText, [String trailingText = ""]) {
    return RichText(
      text: TextSpan(
        text: normalText,
        style: const TextStyle(color: Colors.black54, fontSize: 12, height: 1.5),
        children: [
          if (highlightText.isNotEmpty)
            TextSpan(
              text: highlightText,
              style: const TextStyle(color: Color(0xFFB8860B), fontWeight: FontWeight.w500),
            ),
          if (trailingText.isNotEmpty)
            TextSpan(text: trailingText),
        ],
      ),
    );
  }
}