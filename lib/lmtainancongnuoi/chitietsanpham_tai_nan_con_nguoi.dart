import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_hdi/lmtainancongnuoi/thongtinnguoibaohiem_tai_nan_con_nguoi.dart';
import 'goibaohiem_tai_nan_con_nguoi.dart';
class ChitietsanphamTaiNanConNguoi extends StatefulWidget {
  @override
  State<ChitietsanphamTaiNanConNguoi> createState()
  => _ChitietsanphamTaiNanConNguoiState();
}
class _ChitietsanphamTaiNanConNguoiState extends State<ChitietsanphamTaiNanConNguoi>{
  Map<String, dynamic>? goiDangMua;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHome(),
      body: SingleChildScrollView(
        child: ContentChiTietSanPham(
          onChonGoi: (goi){
            setState(() {
              goiDangMua = goi;
            });
          },
        ),
      ),
      bottomNavigationBar: BottomMuaHang(
        goiDangMua: goiDangMua,
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
        "Chi tiết quyền lợi các gói",
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
class ContentChiTietSanPham extends StatefulWidget {
  final Function(Map<String, dynamic>) onChonGoi;

  const ContentChiTietSanPham({
    super.key,
    required this.onChonGoi,
  });
  @override
  State<ContentChiTietSanPham> createState() => _ContentChiTietSanPhamState();

}
class _ContentChiTietSanPhamState extends State<ContentChiTietSanPham>{
  final List<Map<String, dynamic>> listGoiBaoHiem = [
    {
      "title": "Gói Đồng",
      "status": "Tiết kiệm",
      "price": "695.000 VNĐ/năm",
      "price2": "50.000.000 VND",
      "price3": "2.500.000VND"
    },
    {
      "title": "Gói Bạc",
      "status": "Phổ biến",
      "price": "695.000 VNĐ/năm",
      "price2": "100.000.000 VND",
      "price3": "5.000.000VND"
    },
    {
      "title": "Gói Vàng",
      "status": "Nên mua",
      "price": "695.000 VNĐ/năm",
      "price2": "150.000.000 VND",
      "price3": "7.500.000VND"
    },
    {
      "title": "Gói Titan",
      "status": "Bảo vệ tối đa",
      "price": "2.695.000 VNĐ/năm",
      "price2": "200.000.000 VND",
      "price3": "10.000.000 VND"
    },
    {
      "title": "Gói Bạch Kim",
      "status": "Cao cấp",
      "price": "2.695.000 VNĐ/năm",
      "price2": "250.000.000 VND",
      "price3": "12.500.000 VND"
    },
    {
      "title": "Gói Kim Cương",
      "status": "Siêu cao cấp",
      "price": "2.695.000 VNĐ/năm",
      "price2": "300.000.000 VND",
      "price3": "15.000.000 VND"
    },
  ];
  Map<String, dynamic>? goi1;
  Map<String, dynamic>? goi2;
  int viTriDangChon = 1;
  @override
  void initState() {
    super.initState();
    goi1 = listGoiBaoHiem[0];
    goi2 = listGoiBaoHiem[5];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onChonGoi(goi1!);
    });
  }
  void hienThiDanhSachGoi() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 24),
                  const Text(
                    "Gói bảo hiểm",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listGoiBaoHiem.length,
                itemBuilder: (context, index) {
                  final goi = listGoiBaoHiem[index];
                  bool isSelected = (viTriDangChon == 1 ? goi1 == goi : goi2 == goi);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (viTriDangChon == 1) {
                          goi1 = goi;
                          widget.onChonGoi(goi1!);
                        } else {
                          goi2 = goi;
                          widget.onChonGoi(goi2!);
                        }
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? Colors.orange : Colors.grey[200]!,
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                            color: isSelected ? Colors.orange : Colors.grey,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  goi["title"],
                                  style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                                ),
                                Text(
                                  goi["status"],
                                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          // Giá tiền
                          Text(
                            goi["price"],
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: hienThiDanhSachGoi,
                child: Row(
                  children: [
                    Text("Chọn gói so sánh khác  ",style: TextStyle(fontSize: 14,color: Color(0xFFBB8A0B))),
                    Icon(Icons.keyboard_arrow_down_outlined,color: Color(0xFFBB8A0B))
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: (){
                  setState(() {
                    viTriDangChon = 1;
                  });
                  widget.onChonGoi(goi1!);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: viTriDangChon == 1
                          ? Colors.orange
                          : Colors.transparent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _GoiSoSanh(
                    textTitle: goi1!["title"],
                    textStatus: goi1!["status"],
                    textPrice: goi1!["price"],
                    isSelected: viTriDangChon == 1,
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    viTriDangChon = 2;
                  });
                  widget.onChonGoi(goi2!);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: viTriDangChon == 2
                          ? Colors.orange
                          : Colors.transparent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _GoiSoSanh(
                    textTitle: goi2!["title"],
                    textStatus: goi2!["status"],
                    textPrice: goi2!["price"],
                    isSelected: viTriDangChon == 2,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                )
              ],
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Color(0xFFD8FFE4),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Text("I. Tử vong, thương tật thân thể do tai nạn",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),)
                  ])
                  ),
                Container(
                  height: 44,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            goi1!["price2"],
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),

                      Container(
                        width: 1,
                        height: 44,
                        color: Colors.grey,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            goi2!["price2"],
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                Text("1. Tử vong thương tật toàn bộ vĩnh viễn",style: TextStyle(fontSize: 14,color: Color(0xFF575757),)),
                Container(
                  height: 44,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Tối đa số tiền bảo hiểm",style: TextStyle(fontSize: 14,color: Color(0xFF2D2D2D),fontWeight: FontWeight.w500),),
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 44,
                        color: Colors.grey,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Tối đa số tiền bảo hiểm",style: TextStyle(fontSize: 14,color: Color(0xFF2D2D2D),fontWeight: FontWeight.w500),),
                        ],
                      ),
                    ],
                  ),
                ),
                Text("2. Thương tật bộ phận vĩnh viễn",style: TextStyle(fontSize: 14,color: Color(0xFF575757),)),
                Container(
                  height: 60,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Theo bảng tí lệ trả\ntiền bảo hiểm thương tật",textAlign: TextAlign.center,style: TextStyle(fontSize: 14,color: Color(0xFF2D2D2D),fontWeight: FontWeight.w500),),
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 35,
                        color: Colors.grey,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Theo bảng tí lệ trả\ntiền bảo hiểm thương tật",textAlign: TextAlign.center,style: TextStyle(fontSize: 14,color: Color(0xFF2D2D2D),fontWeight: FontWeight.w500),),
                        ],
                      ),
                    ],
                  ),
                ),
                Text("3. Thương tật tạm thời",style: TextStyle(fontSize: 14,color: Color(0xFF575757),)),
                Container(
                  height: 70,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Trả toàn bộ các chi phí\n"
                              "hợp lý phát sinh cho việc\n"
                              " điều trị thương tật",textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14,color: Color(0xFF2D2D2D),fontWeight: FontWeight.w500,),
                          ),
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 70,
                        color: Colors.grey,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Trả toàn bộ các chi phí\n"
                              "hợp lý phát sinh cho việc\n"
                              "điều trị thương tật",textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14,color: Color(0xFF2D2D2D),fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: "Tiền bồi dưỡng = ",
                                ),
                                TextSpan(
                                  text: "0,1% ×\n",
                                  style: TextStyle(
                                    color: Color(0xFFC58B00),

                                  ),
                                ),
                                TextSpan(
                                  text: "Số tiền bảo hiểm ×\n",
                                  style: TextStyle(
                                    color: Color(0xFFC58B00),

                                  ),
                                ),
                                TextSpan(
                                  text: "Số ngày nằm viện\n ",
                                  style: TextStyle(
                                    color: Color(0xFFC58B00),

                                  ),
                                ),
                                TextSpan(
                                  text: "(Tối đa không vượt quá 180\nngày/vụ)",
                                  style: TextStyle(
                                    color: Color(0xFFC58B00),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 100,
                        color: Colors.grey,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: "Tiền bồi dưỡng = ",
                                ),
                                TextSpan(
                                  text: "0,1% ×\n",
                                  style: TextStyle(
                                    color: Color(0xFFC58B00),

                                  ),
                                ),
                                TextSpan(
                                  text: "Số tiền bảo hiểm ×\n",
                                  style: TextStyle(
                                    color: Color(0xFFC58B00),

                                  ),
                                ),
                                TextSpan(
                                  text: "Số ngày nằm viện\n ",
                                  style: TextStyle(
                                    color: Color(0xFFC58B00),

                                  ),
                                ),
                                TextSpan(
                                  text: "(Tối đa không vượt quá 180\nngày/vụ)",
                                  style: TextStyle(
                                    color: Color(0xFFC58B00),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(" Trong mọi trường hợp\n"
                              "tổng số tiền chi trả \n"
                              "không vượt tỷ lệ %\n"
                              " thương tật trong Bảng\n"
                              " tỷ lệ trả tiền bảo hiểm",textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14,color: Color(0xFF2D2D2D),fontWeight: FontWeight.w500,),
                          ),
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 100,
                        color: Colors.grey,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(" Trong mọi trường hợp\n"
                              "tổng số tiền chi trả \n"
                              "không vượt tỷ lệ %\n"
                              " thương tật trong Bảng\n"
                              " tỷ lệ trả tiền bảo hiểm",textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14,color: Color(0xFF2D2D2D),fontWeight: FontWeight.w500,),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                    width: double.infinity,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Color(0xFFD8FFE4),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("II. Trợ cấp trong thời gian điều trị tai nạn",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),)
                        ])
                ),
                Container(
                  height: 44,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            goi1!["price3"],
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),

                      Container(
                        width: 1,
                        height: 44,
                        color: Colors.grey,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            goi2!["price3"],
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                Text("1. Quyền lợi một ngày nằm viện",style: TextStyle(fontSize: 14,color: Color(0xFF575757),)),
                Container(
                  height: 44,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("244.000VND"),
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 44,
                        color: Colors.grey,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("244.000VND"),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                    width: double.infinity,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Color(0xFFD8FFE4),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("II. Mở rộng BH ngộ độc thức ăn, đồ uống\nhít phải hơi độc, khí độc, chất độc",textAlign: TextAlign.center,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),)
                        ])
                ),
                Container(
                  height: 44,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("50.000.000VND"),
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 44,
                        color: Colors.grey,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("50.000.000VND"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget _GoiSoSanh({
    required textTitle,
    required textStatus,
    required textPrice,
    required bool isSelected,
  }) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 20,
            right: 20,
          ),
          height: 100,
          width: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 10,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textTitle,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0XFF090A0B),
                ),
              ),
              SizedBox(height: 7),
              Text(
                textStatus,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF575757),
                ),
              ),
              SizedBox(height: 7),
              Text(
                textPrice,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF1E552A),
                ),
              ),
            ],
          ),
        ),
        if (isSelected)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Color(0xFFBB8A0B),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(100),
                ),
              ),
              child: Icon(
                Icons.check,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }
}
class BottomMuaHang extends StatelessWidget {
  final Map<String, dynamic>? goiDangMua;
  const BottomMuaHang({
    super.key,
    required this.goiDangMua,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: "Gói bảo hiểm: ",
                      ),
                      TextSpan(
                        text: goiDangMua?["title"] ?? "",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: "Phí bảo hiểm: ",
                      ),
                      TextSpan(
                        text: goiDangMua?["price"] ?? "",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ThongtinnguoibaohiemTaiNanConNguoi(
                    sanPham: goiDangMua!,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFC58B00),
              padding: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 15,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              "Mua ngay",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}