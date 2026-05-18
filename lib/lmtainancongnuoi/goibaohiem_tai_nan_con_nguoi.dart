import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_tai_nan_con_nguoi.dart';
import 'chitietsanpham_tai_nan_con_nguoi.dart';
import 'thongtinnguoibaohiem_tai_nan_con_nguoi.dart';
class GoibaohiemTaiNanConNguoi extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarHome(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GoiBaoHiem(),
          ],
        ),
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
        "Gói bảo hiểm",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      leading: IconButton(onPressed: (){
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context)=> HomeTaiNanConNguoi()));
      }, icon: Icon(Icons.arrow_back_ios_sharp),color: Colors.white,),
      elevation: 1,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60);

}
class GoiBaoHiem extends StatefulWidget {
  @override
  State<GoiBaoHiem> createState() => _GoiBaoHiemState();
}
class _GoiBaoHiemState extends State<GoiBaoHiem>{
  int _activerPage = 0;
  final List<Map<String, dynamic>> listGoiBaoHiem = [
    {
      "image":"assets/image/baohiem1.png",
      "title": "Bảo hiểm gói Đồng",
      "status": "Tiết kiệm",
      "price": "695.000 VNĐ/năm",
      "colors": [Color(0xFFACEDAC), Color(0xFFC3F4C3), Color(0xFFACEDAC)],
      "price2": "50 triệu",
      "price3": "2 triệu"
    },
    {
      "image":"assets/image/baohiem2.png",
      "title": "Bảo hiểm gói Bạc",
      "status": "Phổ biến",
      "price": "695.000 VNĐ/năm",
      "colors": [Color(0xFFABBDFF), Color(0xFFB5C1F1), Color(0xFFABBDFF)],
      "price2": "100 triệu",
      "price3": "5 triệu"
    },
    {
      "image":"assets/image/baohiem3.png",
      "title": "Bảo hiểm gói Vàng",
      "status": "Nên mua",
      "price": "695.000 VNĐ/năm",
      "colors": [Color(0xFFF1E77F), Color(0xFFFDFBB3), Color(0xFFF1E77F)],
      "price2": "150 triệu",
      "price3": "7,5 triệu"
    },
    {
      "image":"assets/image/baohiem4.png",
      "title": "Bảo hiểm gói Titan",
      "status": "Bảo vệ tối đa",
      "price": "2.695.000 VNĐ/năm",
      "colors": [Color(0xFFF3C971), Color(0xFFF6D79B), Color(0xFFF3C971)],
      "price2": "200 triệu",
      "price3": "10 triệu"
    },
    {
      "image":"assets/image/baohiem5.png",
      "title": "Bảo hiểm gói Bạch Kim",
      "status": "Cao cấp",
      "price": "2.695.000 VNĐ/năm",
      "colors": [Color(0xFF76D3D8), Color(0xFFA3E9ED), Color(0xFF76D3D8)],
      "price2": "250 triệu",
      "price3": "12,5 triệu"
    },
    {
      "image":"assets/image/baohiem6.png",
      "title": "Bảo hiểm gói Kim Cương",
      "status": "Siêu cao cấp",
      "price": "2.695.000 VNĐ/năm",
      "colors": [Color(0xFF8199FA), Color(0xFFA5B7F6), Color(0xFF8199FA)],
      "price2": "250 triệu",
      "price3": "15 triệu"
    },

  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 600,
          child: CarouselSlider(
            options: CarouselOptions(
              height: 700,
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              viewportFraction: 0.75,
              enlargeFactor: 0.3,
              enlargeStrategy: CenterPageEnlargeStrategy.scale,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {
                  _activerPage = index;
                });
              },
            ),
            items: listGoiBaoHiem.map((item) {
              return _BuildBaoHiemCard(
                gradientColors: item['colors'],
                image1: item['image'],
                textTitle: item['title'],
                textStatus: item['status'],
                textPrice1: item['price'],
                textPrice2: item['price2'],
                textPrice3: item['price3'],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ThongtinnguoibaohiemTaiNanConNguoi(
                        // Ép kiểu Map một cách tường minh ngay tại điểm bắt đầu
                        sanPham: Map<String, dynamic>.from(item),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: listGoiBaoHiem.asMap().entries.map((entry) {
            return Container(
              width: _activerPage == entry.key ? 30.0 : 10.0,
              height: 10.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: _activerPage == entry.key
                    ? const Color(0xFFBB8A0B)
                    : Colors.grey.withOpacity(0.3),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.only(left: 10,right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Sản phẩm khác",style: TextStyle(color: Colors.red,fontSize: 18)),
              TextButton(onPressed: (){}, child: Text("Xem tất cả",style: TextStyle(color:Color(0xFFBB8A0B) ),))
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TextButton.icon(
                onPressed: () {
                },
                icon: Image.asset(
                  'assets/image/icon_baohiemtainanconnguoi.png',
                  width: 40,
                  height: 40,
                ),
                label: const Text(
                  "Bảo hiểm tai\nnạn con người",
                  style: TextStyle(color: Color(0xFF2D2D2D),fontWeight: FontWeight(400)),
                ),
                style: TextButton.styleFrom(
                    minimumSize: const Size(100, 45),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10)
                  )
                ),
              ),
              TextButton.icon(
                onPressed: () {
                },
                icon: Image.asset(
                  'assets/image/icon_baohiemtainanconnguoi.png',
                  width: 40,
                  height: 40,
                ),
                label: const Text(
                  "Bảo hiểm tai\nnạn con người",
                  style: TextStyle(color: Color(0xFF2D2D2D),fontWeight: FontWeight(400)),
                ),
                style: TextButton.styleFrom(
                    minimumSize: const Size(100, 45),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10)
                    )
                ),
              ),
              TextButton.icon(
                onPressed: () {
                },
                icon: Image.asset(
                  'assets/image/icon_baohiemtainanconnguoi.png',
                  width: 40,
                  height: 40,
                ),
                label: const Text(
                  "Bảo hiểm tai\nnạn con người",
                  style: TextStyle(color: Color(0xFF2D2D2D),fontWeight: FontWeight(400)),
                ),
                style: TextButton.styleFrom(
                    minimumSize: const Size(100, 45),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10)
                    )
                ),
              ),
              TextButton.icon(
                onPressed: () {
                },
                icon: Image.asset(
                  'assets/image/icon_baohiemtainanconnguoi.png',
                  width: 40,
                  height: 40,
                ),
                label: const Text(
                  "Bảo hiểm tai\nnạn con người",
                  style: TextStyle(color: Color(0xFF2D2D2D),fontWeight: FontWeight(400)),
                ),
                style: TextButton.styleFrom(
                    minimumSize: const Size(100, 45),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10)
                    )
                ),
              ),
            ],
          ),
        )

      ],
    );
  }
  Widget _BuildBaoHiemCard ({
    required List<Color> gradientColors,
    required image1,
    required textTitle,
    required textStatus,
    required textPrice1,
    required textPrice2,
    required textPrice3,
    required onTap,
  }){
    return Stack(
      alignment: Alignment(0, -1),
      children:[
        Container(
          margin: EdgeInsets.only(top: 70),
          width: double.infinity,
          child: Column(
            children: [
              Container(
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: gradientColors,
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
               child: Stack(
                  children: [
                    Image.asset("assets/image/kehoabaohiem.png",fit: BoxFit.cover,),
                    Container(
                      margin: EdgeInsets.only(top: 40),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Text(textTitle,style: TextStyle(color: Colors.red,fontSize: 18)),
                          Text(textStatus,style: TextStyle(color: Color(0xFF2D2D2D),fontSize: 12),),
                          Text(textPrice1,style: TextStyle(color: Color(0xFF1E552A),fontSize: 14,fontWeight: FontWeight.bold),)
                        ],
                      ),
                    )
                  ],
               ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)
                  ),
                  boxShadow: [BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, 5),
                  )]
                  ),
                child: Column(
                    children: [
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Quyền lợi bảo hiểm",style: TextStyle(fontSize: 14,color: Color(0xFF2D2D2D),fontWeight: FontWeight(500)),),
                          Text("Số tiền bảo hiểm",style: TextStyle(fontSize: 14,color: Color(0xFF2D2D2D),fontWeight: FontWeight(500)),),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Tử vong, thương tật thân\nthể do tai nạn",style: TextStyle(fontSize: 14,color: Color(0xFF2D2D2D)),),
                          Text(textPrice2,style: TextStyle(fontSize: 14,color: Color(0xFF2D2D2D)),),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(thickness: 1,color: Color(0xFFEEEEEE)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Trợ cấp trong thời gian điều\ntrị tai nạn",style: TextStyle(fontSize: 14,color: Color(0xFF2D2D2D)),),
                          Text(textPrice3,style: TextStyle(fontSize: 14,color: Color(0xFF2D2D2D)),),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(thickness: 1,color: Color(0xFFEEEEEE)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Mở rộng bảo hiểm Ngộ độc\nthức ăn, đồ uống hoặc hít phải\nhơi độc, khí độc, chất độc",style: TextStyle(fontSize: 14,color: Color(0xFF2D2D2D)),),
                          Text("v",style: TextStyle(fontSize: 14,color: Color(0xFF2D2D2D)),),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(thickness: 1,color: Color(0xFFEEEEEE)),
                      TextButton(onPressed: (){
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context)=>ChitietsanphamTaiNanConNguoi())
                        );
                      },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Xem chi tiết sản phẩm ", style: TextStyle(color: Color(0xFFBB8A0B)),
                              ),
                              Icon(Icons.arrow_forward_ios,size: 16,color: Color(0xFFBB8A0B),)
                            ],
                          )
                      ),
                      SizedBox(height: 30),
                      TextButton(onPressed: onTap,
                        child: Text("Mua ngay",style: TextStyle(fontSize: 14,color: Colors.white)),
                        style: TextButton.styleFrom(
                            minimumSize: const Size(double.infinity, 45),
                            backgroundColor: Color(0xFFBB8A0B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(10)
                            )
                        ),
                      )
                    ],
                ),
                ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 30),
          child:Image.asset(
            image1,
            fit: BoxFit.cover,
          ),
        ),
      ]
    );
  }
}