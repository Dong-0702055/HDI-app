import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'goibaohiem_tai_nan_con_nguoi.dart';
import 'nhaptaythontin_tai_nan_con_nguoi.dart';
import 'camera.dart';
class ThongtinnguoibaohiemTaiNanConNguoi extends StatelessWidget{
  final Map<String, dynamic> sanPham;

  const ThongtinnguoibaohiemTaiNanConNguoi({
    super.key,
    required this.sanPham,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHome(),
      body: ContentThongTinNguoiBaoHiem(
        sanPham: sanPham,
      ),
    );
  }
}
class AppBarHome extends StatelessWidget implements PreferredSizeWidget{
  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0A7029),
              Color(0xFF055E20),
            ],
          ),
        ),
      ),
      title: const Text(
        "Thông tin người được bảo hiểm",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      leading: IconButton(onPressed: (){
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context)=> GoibaohiemTaiNanConNguoi()));
      }, icon: Icon(Icons.arrow_back_ios_sharp),color: Colors.white,),
      elevation: 1,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60);

}
class ContentThongTinNguoiBaoHiem extends StatelessWidget {
  final Map<String, dynamic> sanPham;

  const ContentThongTinNguoiBaoHiem({
    super.key,
    required this.sanPham,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStepItem("1", "Chọn gói\nsức khoẻ", true),
              _buildLine(true),
              _buildStepItem("2", "Người được\nbảo hiểm", true),
              _buildLine(false),
              _buildStepItem("3", "Xác nhận\nthông tin", false),
              _buildLine(false),
              _buildStepItem("4", "Thanh toán", false),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(16),
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
              child: Column(
                children: [
                  _buildInputOption(
                    icon: "assets/icons/icon_camera.png",
                    label: "Chụp ảnh CMND/CCCD/Hộ chiếu",
                    onTap: () async {
                      // Gọi điều hướng sang màn hình scan camera tùy biến
                      final String? imagePath = await Navigator.push<String>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScanCameraScreen(),
                        ),
                      );

                      if (imagePath != null) {
                        print("Đã chụp thành công! Đường dẫn file ảnh: $imagePath");
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildInputOption(
                    icon: "assets/icons/icon_image_add.png",
                    label: "Tải lên ảnh CMND/CCCD/Hộ chiếu",
                    onTap: () {},
                  ),
                  const SizedBox(height: 16),
                  _buildInputOption(
                    icon: "assets/icons/icon_edit.png",
                    label: "Hoặc nhập tay",
                    showArrow: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NhapTayThongTinScreen(sanPham: sanPham),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Bảo hiểm chăm sóc sức", style: TextStyle(color: Colors.black54, fontSize: 13)),
                        Text("khỏe và tai nạn", style: TextStyle(color: Colors.black54, fontSize: 13)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("${sanPham['title'] } " , style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        Text(
                          "${sanPham['price'] } ",
                          style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB8860B), // Màu vàng đồng
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text("Tiếp tục", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildStepItem(String number, String title, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF0A7029) : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: isActive ? Colors.black87 : Colors.black38,
            height: 1.2,
          ),
        ),
      ],
    );
  }
  Widget _buildLine(bool isActive) {
    return Container(
      width: 40,
      height: 2,
      margin: const EdgeInsets.only(bottom: 20),
      color: isActive
          ? const Color(0xFF0A7029)
          : Colors.grey[300],
    );
  }
  Widget _buildInputOption({
    required String icon,
    required String label,
    bool showArrow = false,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF1E552A)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            ImageIcon(AssetImage(icon),color: Color(0xFF1E552A), size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ),
            if (showArrow) const Icon(Icons.arrow_forward, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}