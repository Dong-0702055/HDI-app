import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_hdi/BH_NTN/goibaohiem.dart';
import 'package:my_hdi/utils/app_styles.dart';

class NhapGiaTriModal extends StatefulWidget {
  const NhapGiaTriModal({super.key});

  @override
  State<NhapGiaTriModal> createState() => _NhapGiaTriModalState();
}

class _NhapGiaTriModalState extends State<NhapGiaTriModal> {
  final TextEditingController _giaTriController = TextEditingController();
  bool _isButtonEnabled = false; // Trạng thái của nút Tiếp tục

  @override
  void initState() {
    super.initState();
    // Lắng nghe thay đổi của TextField để bật/tắt nút
    _giaTriController.addListener(() {
      setState(() {
        _isButtonEnabled = _giaTriController.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _giaTriController.dispose();
    super.dispose();
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor:
            Colors.transparent, // Phải để trong suốt để thấy nút nằm ngoài
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 40,
        ), // Thu hẹp chiều rộng Modal
        child: Stack(
          clipBehavior:
              Clip.none, // Quan trọng: Cho phép nút hiển thị tràn ra ngoài viền
          children: [
            // 1. Thân chính của Dialog
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header (Tiêu đề + Divider)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.help_outline,
                          color: Color(0xFFBB8A0B),
                          size: 22,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Giới hạn bồi thường Ngôi nhà',
                          style: AppStyles.n(
                            size: 15,
                            weight: FontWeight.w700,
                            color: const Color(0xFF1B5E20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Color(0xFFEEEEEE),
                    thickness: 1,
                  ),

                  // Content
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                    child: Text(
                      'Quý khách vui lòng nhập giá trị ngôi nhà từ\n 300.000.000 VNĐ - 5.000.000.000VND',
                      style: AppStyles.n(
                        size: 13,
                        color: const Color.fromARGB(255, 0, 0, 0),
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),

            // 2. Nút Cancel nằm trên Border (Góc trên bên phải)
            Positioned(
              right: -10, // Đẩy lấn sang phải
              top: -10, // Đẩy lấn lên trên
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(
                      255,
                      0,
                      0,
                      0,
                    ), // Màu nền nút x xám đậm
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: const Icon(Icons.close, color: Colors.white, size: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        top: 12,
        left: 20,
        right: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Thanh kéo ngang trên đầu modal
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 32),
              Text(
                'Nhập giá trị ngôi nhà',
                style: AppStyles.n(size: 16, weight: FontWeight.w700),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // TextField với style giống Figma
          TextField(
            controller: _giaTriController,
            keyboardType: TextInputType.number,
            style: AppStyles.n(size: 15, weight: FontWeight.w600),
            decoration: InputDecoration(
              // 1. Luôn giữ label nổi lên trên khi có dữ liệu hoặc focus
              floatingLabelBehavior: FloatingLabelBehavior.auto,

              labelText: 'Giới hạn bồi thường ngôi nhà (VNĐ) *',

              // 2. Định dạng cho Label khi nó đang "bay" ở trên
              floatingLabelStyle: AppStyles.n(
                size: 14,
                color: const Color(0xFF9E9E9E), // Màu xám nhạt như trong ảnh
                weight: FontWeight.w500,
              ),

              // 3. Định dạng cho Label khi nó đang nằm bên trong TextField (Hint)
              labelStyle: AppStyles.n(size: 14, color: const Color(0xFF9E9E9E)),

              prefixIcon: const Icon(Icons.home_rounded, color: Colors.grey),
              suffixIcon: IconButton(
                onPressed: _showHelpDialog,
                icon: const Icon(Icons.help_outline, color: Color(0xFFBB8A0B)),
              ),

              // 4. Border khi không focus (màu xám nhạt mờ)
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFF5F5F5),
                  width: 1,
                ),
              ),

              // 5. Border khi đang nhập liệu (màu vàng)
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFBB8A0B),
                  width: 1.5,
                ),
              ),

              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
          const SizedBox(height: 12),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Vui lòng nhập giá trị ngôi nhà và nhấn ',
                  style: AppStyles.n(
                    size: 12,
                    color: const Color(0xFFDA2128),
                  ), // Kiểu chữ bình thường
                ),
                TextSpan(
                  text: '"Tiếp tục"',
                  style: AppStyles.n(size: 12, color: const Color(0xFFDA2128))
                      .copyWith(
                        fontWeight: FontWeight.bold, // In đậm ở đây
                      ),
                ),
                TextSpan(
                  text: ' để xem phí bảo hiểm ngôi nhà chính xác.',
                  style: AppStyles.n(
                    size: 12,
                    color: const Color(0xFFD94F1E),
                  ), // Kiểu chữ bình thường
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          // Box thông báo hỗ trợ
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10, // Thêm độ nhòe
                  offset: const Offset(0, 4), // Hướng đổ bóng
                ),
              ],
              border: Border.all(color: const Color(0xFFE8F5E9)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/image_BHNTN/icon_bhntn5.png',
                  width: 50,
                  height: 50,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: AppStyles.n(
                        size: 12,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                      children: [
                        const TextSpan(
                          text: 'Nếu giá trị ngôi nhà nằm ngoài khoảng ',
                        ),
                        TextSpan(
                          text: '300.000.000 VND - 5.000.000.000 VND',
                          style: AppStyles.n(
                            weight: FontWeight.bold,
                            color: const Color(0xFF2E7D32),
                          ),
                        ),
                        const TextSpan(
                          text:
                              ', Quý khách vui lòng liên hệ trực tuyến hoặc gọi hotline ',
                        ),
                        TextSpan(
                          text: '1900 068898',
                          style: AppStyles.n(
                            weight: FontWeight.bold,
                            color: const Color(0xFFBB8A0B),
                          ).copyWith(decoration: TextDecoration.underline),
                          // Thêm nhận diện hành động click
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              //print('Đang gọi hotline: 1900 068898');
                            },
                        ),
                        const TextSpan(
                          text: ', để nhận tư vấn gói bảo hiểm phù hợp.',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Nút tiếp tục có xử lý disable
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _isButtonEnabled
                  ? () {
                      // Lấy giá trị từ TextField
                      int soTien =
                          int.tryParse(
                            _giaTriController.text.replaceAll('.', ''),
                          ) ??
                          0;

                      // Thực hiện chuyển trang
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => GoiBaoHiem(giaTriNgoiNha: soTien),
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFBB8A0B),
                disabledBackgroundColor:
                    Colors.grey[300], // Màu khi nút bị khóa
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                'Tiếp tục',
                style:
                    AppStyles.n(
                      weight: FontWeight.w800,
                      size: 16,
                    ).copyWith(
                      color: _isButtonEnabled ? Colors.white : Colors.grey[600],
                    ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
