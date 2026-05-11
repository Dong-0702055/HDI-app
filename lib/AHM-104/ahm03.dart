import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'ahm04.dart';
import 'ahm05.dart';

class Ahm03 extends StatefulWidget {
  const Ahm03({super.key});

  @override
  State<Ahm03> createState() => _Ahm03State();
}

class _Ahm03State extends State<Ahm03> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPackage = 0;
  String _dateRangeText = "28/12/2023 - 28/01/2024";
  int _peopleCount = 10;

  final List<Map<String, dynamic>> _packages = [
    {
      "title": "Bảo hiểm gói Đồng",
      "subtitle": "Cơ bản",
      "price": "145.000 VNĐ/chuyến",
      "benefits": [
        {"name": "Tử vong, thương tật vĩnh viễn:", "value": "100 triệu"},
        {"name": "Chi phí y tế khẩn cấp:", "value": "60 triệu"},
        {"name": "Quyền lợi bảo hiểm bổ sung:", "value": "26 triệu"},
      ],
      "bgImage": "assets/image/AHM-104/đồng.png",
      "badgeColor": const Color(0xFF4CAF50),
      "badge": "assets/image/AHM-104/13.png",
    },
    {
      "title": "Bảo hiểm gói Bạc",
      "subtitle": "Tiêu chuẩn",
      "price": "695.000 VNĐ/chuyến",
      "benefits": [
        {"name": "Tử vong, thương tật vĩnh viễn:", "value": "200 triệu"},
        {"name": "Chi phí y tế khẩn cấp:", "value": "120 triệu"},
        {"name": "Quyền lợi bảo hiểm bổ sung:", "value": "49 triệu"},
      ],
      "bgImage": "assets/image/AHM-104/bạc.png",
      "badgeColor": const Color(0xFF2196F3),
      "badge": "assets/image/AHM-104/11.png",
    },
    {
      "title": "Bảo hiểm gói Vàng",
      "subtitle": "Cao Cấp",
      "price": "695.000 VNĐ/chuyến",
      "benefits": [
        {"name": "Tử vong, thương tật vĩnh viễn:", "value": "1,25 tỷ"},
        {"name": "Chi phí y tế khẩn cấp:", "value": "1,25 tỷ"},
        {"name": "Quyền lợi bảo hiểm bổ sung:", "value": "1,1 tỷ"},
      ],
      "bgImage": "assets/image/AHM-104/Vàng.png",
      "badgeColor": const Color(0xFFFFC107),
      "badge": "assets/image/AHM-104/12.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF007A3E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Gói bảo hiểm",
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Travel Info Card
            _buildTravelInfoCard(),

            const SizedBox(height: 10),

            // Package Swiper
            SizedBox(
              height: 520, // Tăng chiều cao để không bị mất logo ở trên
              child: PageView.builder(
                controller: _pageController,
                itemCount: _packages.length,
                onPageChanged: (index) => setState(() => _currentPackage = index),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 30), // Tạo khoảng trống phía trên cho logo
                    child: _buildPackageCard(_packages[index]),
                  );
                },
              ),
            ),

            // Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _packages.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPackage == index ? 20 : 8,
                  height: 4,
                  decoration: BoxDecoration(
                    color: _currentPackage == index ? const Color(0xFFBB8A0B) : Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Other Products Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Sản phẩm khác",
                    style: TextStyle(color: Color(0xFFD32F2F), fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text("Xem tất cả", style: TextStyle(color: Color(0xFFBB8A0B), fontSize: 12)),
                  ),
                ],
              ),
            ),

            _buildOtherProductsList(),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildTravelInfoCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(10)),
            child: Image.asset("assets/image/AHM-104/14.png", width: 24, height: 24, errorBuilder: (context, error, stackTrace) => const Icon(Icons.luggage, color: Color(0xFF4CAF50))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Thông tin chuyến đi:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    GestureDetector(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Ahm04()),
                        );
                        if (result != null && result is Map) {
                          setState(() {
                            _dateRangeText = result['dateRange'];
                            _peopleCount = result['count'];
                          });
                        }
                      },
                      child: const Text("Thay đổi", style: TextStyle(color: Color(0xFFBB8A0B), fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text("Số ngày: $_dateRangeText", style: const TextStyle(fontSize: 12, color: Color(0xFF666666))),
                Text("Số người: $_peopleCount người", style: const TextStyle(fontSize: 12, color: Color(0xFF666666))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPackageCard(Map<String, dynamic> package) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 15, offset: const Offset(0, 8)),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              // Header Gradient Background
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(package['bgImage']),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 35), // Tăng khoảng cách để không bị đè bởi logo
                          Text(package['title'], style: const TextStyle(color: Color(0xFFD32F2F), fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(package['subtitle'], style: const TextStyle(color: Color(0xFF444444), fontSize: 12)),
                          const SizedBox(height: 4),
                          Text(package['price'], style: const TextStyle(color: Color(0xFF007A3E), fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Benefits Section
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Quyền lợi bảo hiểm", style: TextStyle(color: Color(0xFF666666), fontSize: 12)),
                        Text("Số tiền bảo hiểm", style: TextStyle(color: Color(0xFF666666), fontSize: 12)),
                      ],
                    ),
                    const Divider(),
                    ...package['benefits'].map<Widget>((benefit) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text(benefit['name'], style: const TextStyle(fontSize: 12, color: Color(0xFF333333)))),
                            Text(benefit['value'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF007A3E))),
                          ],
                        ),
                      );
                    }).toList(),
                    
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Ahm05(initialPackageIndex: _currentPackage)),
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text("Chi tiết", style: TextStyle(color: Color(0xFFBB8A0B), fontSize: 12, fontWeight: FontWeight.bold)),
                            Icon(Icons.arrow_forward_ios, color: Color(0xFFBB8A0B), size: 12),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Ahm05(initialPackageIndex: _currentPackage)),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFBB8A0B),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text("Mua ngay", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          // Badge Icon Overlapping
          Positioned(
            top: -25,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                ),
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(4), // Thêm padding để icon không bị to quá và không bị mất phần
                    child: Image.asset(
                      package['badge'],
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Icon(Icons.stars, color: package['badgeColor'], size: 45),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherProductsList() {
    return SizedBox(
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 16),
        children: [
          _buildOtherProductItem("Bảo hiểm tai nạn con người", "assets/image/AHM-104/icon4.svg"),
          _buildOtherProductItem("Bảo hiểm du lịch Việt Nam", "assets/image/AHM-104/icon4.svg"),
          _buildOtherProductItem("Bảo hiểm ô tô", "assets/image/AHM-104/icon4.svg"),
        ],
      ),
    );
  }

  Widget _buildOtherProductItem(String title, String imagePath) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: imagePath.endsWith('.svg')
                ? SvgPicture.asset(
                    imagePath,
                    colorFilter: const ColorFilter.mode(Color(0xFFBB8A0B), BlendMode.srcIn),
                  )
                : Image.asset(
                    imagePath,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.category, color: Color(0xFFBB8A0B), size: 24),
                  ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
