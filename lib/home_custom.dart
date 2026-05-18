import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeCustom extends StatelessWidget{
  const HomeCustom({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: HomeAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ContainerHome(),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(),
      );
  }

}
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Padding(padding: EdgeInsets.only(left:16),
          child: Image.asset('assets/image/logo.png')),
      actions: [
        Row(

        ),
        TextButton.icon(onPressed: (){},
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 4), // Thu nhỏ padding của nút
              tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Thu nhỏ vùng bấm
            ),
            icon: Icon(Icons.person_2_outlined, color: Colors.green,),
            label: Text("Đăng nhập", style: TextStyle(fontSize: 18, color: Colors.green))
        ),
        IconButton(
          icon: Icon(Icons.search, color: Colors.green),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.notifications_none, color: Colors.green),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.format_list_bulleted, color: Colors.green),
          onPressed: () {},
        ),
      ],

    );
  }

  @override
  // TODO: implement preferredSize
  final Size preferredSize = const Size.fromHeight(60.0);

  const HomeAppBar({super.key});
}
class ContainerHome extends StatelessWidget{
  final List<String> imgList1 = [
    'assets/image/title1.png',
    'assets/image/title.png',
  ];
  final List<String> imgList2 = [
    'assets/image/slide1.png',
    'assets/image/slide2.png',
  ];

   ContainerHome({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          CarouselSlider(
              options: CarouselOptions(
              height: 350.0,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                viewportFraction: 1.0,
                enlargeCenterPage: false,
              ),
              items: imgList1.map((item) => Container(
              child: Image.asset(
              item,
              fit: BoxFit.cover,
              width: double.infinity,
              ),
              )).toList(),
              ),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 285),
                  padding: EdgeInsets.only(top:45),
                  alignment: Alignment.topCenter,
                  decoration: const BoxDecoration(
                  image: DecorationImage(
                  image: AssetImage("assets/image/bg_home_1.png"),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  ),
                ),
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      Column(
                        children: [
                          Text("Bảo hiểm trực tuyến",
                          style: TextStyle(
                          fontSize: 28,

                          color: Colors.white
                          ),
                          ),
                          SizedBox(height: 20),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  padding: EdgeInsets.all(5),
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset("assets/image/home_1.png",
                                        height: 150,
                                        width: 200,
                                        fit: BoxFit.fitWidth,),
                                      Text(
                                        "Bảo hiểm",
                                        style: TextStyle(
                                          fontSize: 23,
                                        ),
                                      ),
                                      Text(
                                        "Chăm sóc sức khỏe và tai nạn",
                                        style: TextStyle(
                                            fontSize: 15,
                                            overflow: TextOverflow.ellipsis
                                        ),
                                      ),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Chỉ từ ',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                              ),
                                            ),
                                            TextSpan(
                                              text: '1.695.000',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'VNĐ/năm',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      OutlinedButton(
                                          onPressed: (){},
                                          style: OutlinedButton.styleFrom(
                                              foregroundColor:  Color(0xFFBB8A0B),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadiusGeometry.circular(1),
                                              ),
                                              side: BorderSide(
                                                  color: Color(0xFFBB8A0B)
                                              )
                                          ),
                                          child: Text("Mua ngay")),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  margin: EdgeInsets.only(left: 10),
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset("assets/image/home_2.png",
                                        height: 150,
                                        width: 200,
                                        fit: BoxFit.fitWidth,),
                                      Text(
                                        "Bảo hiểm",
                                        style: TextStyle(
                                          fontSize: 23,
                                        ),
                                      ),
                                      Text(
                                        "Tai nạn và con người",
                                        style: TextStyle(
                                            fontSize: 15,
                                            overflow: TextOverflow.ellipsis
                                        ),
                                      ),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Chỉ từ ',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                              ),
                                            ),
                                            TextSpan(
                                              text: '1.695.000',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'VNĐ/năm',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      OutlinedButton(
                                          onPressed: (){},
                                          style: OutlinedButton.styleFrom(
                                              foregroundColor:  Color(0xFFBB8A0B),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadiusGeometry.circular(1),
                                              ),
                                              side: BorderSide(
                                                  color: Color(0xFFBB8A0B)
                                              )
                                          ),
                                          child: Text("Mua ngay")),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  margin: EdgeInsets.only(left: 10),
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset("assets/image/home_3.png",
                                        height: 150,
                                        width: 200,
                                        fit: BoxFit.fitWidth,),
                                      Text(
                                        "Bảo hiểm",
                                        style: TextStyle(
                                          fontSize: 23,

                                        ),
                                      ),
                                      Text(
                                        "Du lịch Việt Nam",
                                        style: TextStyle(
                                            fontSize: 15,
                                            overflow: TextOverflow.ellipsis
                                        ),
                                      ),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Chỉ từ ',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                              ),
                                            ),
                                            TextSpan(
                                              text: '39.000',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'VNĐ/năm',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      OutlinedButton(
                                          onPressed: (){},
                                          style: OutlinedButton.styleFrom(
                                              foregroundColor:  Color(0xFFBB8A0B),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadiusGeometry.circular(1),
                                              ),
                                              side: BorderSide(
                                                  color: Color(0xFFBB8A0B)
                                              )
                                          ),
                                          child: Text("Mua ngay")),

                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 180,
                            margin: EdgeInsets.only(top:20),
                            child: OutlinedButton(
                                onPressed: (){},
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadiusGeometry.circular(5),
                                    ),
                                    side: BorderSide(
                                        color: Color(0xFFBB8A0B)
                                    )
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      "Xem thêm",
                                      style: TextStyle(fontSize: 20, color: Color(0xFFBB8A0B)),
                                    ),
                                    const SizedBox(width: 15),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 18,
                                      color: Color(0xFFBB8A0B),
                                    ),
                                  ],
                                )
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top:30),
                            child: Text("Dịch vụ khách hàng",
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight(500),
                                  color: Colors.white
                              ),),
                          ),
                        ],
                      ),
                    ],
                  )
                ),
                Container(
                    width: double.infinity,
                    alignment: Alignment.topCenter,
                    height: 700,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/image/bg_home_2.png"),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10,top: 10,),
                                padding: EdgeInsets.all(5),
                                width: 200,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset("assets/image/home_1.png",
                                      height: 150,
                                      width: 200,
                                      fit: BoxFit.fitWidth,),
                                    Text(
                                      "Bảo hiểm",
                                      style: TextStyle(
                                        fontSize: 23,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.only(left: 10,top: 10,),
                                width: 200,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset("assets/image/home_2.png",
                                      height: 150,
                                      width: 200,
                                      fit: BoxFit.fitWidth,),
                                    Text(
                                      "Bảo hiểm",
                                      style: TextStyle(
                                        fontSize: 23,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.only(left: 10,top: 10,),
                                width: 200,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset("assets/image/home_3.png",
                                      height: 150,
                                      width: 200,
                                      fit: BoxFit.fitWidth,),
                                    Text(
                                      "Bảo hiểm",
                                      style: TextStyle(
                                        fontSize: 23,

                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 180,
                          margin: EdgeInsets.only(top:20),
                          child: OutlinedButton(
                              onPressed: (){},
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.circular(5),
                                  ),
                                  side: BorderSide(
                                      color: Color(0xFFBB8A0B)
                                  )
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "Xem thêm",
                                    style: TextStyle(fontSize: 20, color: Color(0xFFBB8A0B)),
                                  ),
                                  const SizedBox(width: 15),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 18,
                                    color: Color(0xFFBB8A0B),
                                  ),
                                ],
                              )
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top:30),
                          child: Text("Tiện ích hỗ trợ",
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight(500),
                                color: Color(0xFF196121)
                            ),),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10,top: 10,),
                                padding: EdgeInsets.all(5),
                                width: 200,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset("assets/image/home_1.png",
                                      height: 150,
                                      width: 200,
                                      fit: BoxFit.fitWidth,),
                                    Text(
                                      "Bảo hiểm",
                                      style: TextStyle(
                                        fontSize: 23,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.only(left: 10,top: 10,),
                                width: 200,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset("assets/image/home_2.png",
                                      height: 150,
                                      width: 200,
                                      fit: BoxFit.fitWidth,),
                                    Text(
                                      "Bảo hiểm",
                                      style: TextStyle(
                                        fontSize: 23,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.only(left: 10,top: 10,),
                                width: 200,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset("assets/image/home_3.png",
                                      height: 150,
                                      width: 200,
                                      fit: BoxFit.fitWidth,),
                                    Text(
                                      "Bảo hiểm",
                                      style: TextStyle(
                                        fontSize: 23,

                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 180,
                          margin: EdgeInsets.only(top:20),
                          child: OutlinedButton(
                              onPressed: (){},
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.circular(5),
                                  ),
                                  side: BorderSide(
                                      color: Color(0xFFBB8A0B)
                                  )
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "Xem thêm",
                                    style: TextStyle(fontSize: 20, color: Color(0xFFBB8A0B)),
                                  ),
                                  const SizedBox(width: 15),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 18,
                                    color: Color(0xFFBB8A0B),
                                  ),
                                ],
                              )
                          ),
                        ),
                      ],
                    )
                ),
              ],
            ),
          Column(
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top:1400),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/image/bg_home_3.png"),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top:80),
                      child: Text("Thông tin đối tác",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight(500),
                            color: Colors.white
                        ),),
                    ),
                    CarouselSlider(
                        options: CarouselOptions(
                          height: 180,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          viewportFraction: 0.7,
                          enlargeCenterPage: true,
                        ),
                        items: imgList2.map((item) => Container(
                          padding: EdgeInsets.all(25),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              item,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )).toList(),
                      ),
                  ],
                ),
                ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/image/bg_home_4.png"),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text("Liên hệ tư vấn bảo hiểm",style: TextStyle(fontSize: 20,color: Colors.red),),
                            Text("Vui lòng để lại thông tin và chọn\n thời gian tư vấn,"
                                " tư vấn viên sẽ hồi\n đáp mọi thắc mắc và vấn đề liên\n quan"
                                " đến các sản phẩm bảo hiểm\n và dịch vụ khách hàng",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            )
                          ],
                        ),
                        Image.asset(
                            "assets/image/logo1.png",
                          height: 100,
                          width: 100,

                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                )
                              ]
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Số điện thoại",
                                prefixIcon: Icon(Icons.phone),
                                filled: true,
                                fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none
                                  )

                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  )
                                ]
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Họ và tên",
                                  prefixIcon: Icon(Icons.person),
                                  filled: true,
                                  fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none
                                )

                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            )
                          ]
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Email",
                            prefixIcon: Icon(Icons.email),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none
                            )

                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  )
                                ]
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Ngày hẹn",
                                  prefixIcon: Icon(Icons.event_available),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none
                                  )

                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  )
                                ]
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Giờ bắt hẹn",
                                  prefixIcon: Icon(Icons.event_available),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none
                                  )

                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),

                      ],
                    ),
                    SizedBox(height: 10,),
                    TextButton(onPressed: (){},
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xFFBB8A0B),
                          minimumSize: Size(400, 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(10)
                          )
                        ),
                        child: Text("Đặt lịch ngay",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white
                          ),
                        )

                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                width: double.infinity,
                decoration: BoxDecoration(
                 image: DecorationImage(
                     image: AssetImage("assets/image/bg_home_5.png"),
                      fit: BoxFit.cover
                 )
                ),
                child: Column(
                  children: [
                    Text("TIN TỨC",style: TextStyle(fontSize: 25,color: Colors.green),),
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  "assets/image/new1.png",
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    "Tin thị trường",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text("Thông báo về: \"Điều khoản và điều kiện chung"
                              " về bảo vệ và xử lí dữ liệu cá nhân\"",
                            style: TextStyle(overflow: TextOverflow.ellipsis,fontSize: 16),maxLines: 2,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("11:00 - 20/12/2023",
                                style: TextStyle(overflow: TextOverflow.ellipsis,fontSize: 16, fontWeight: FontWeight(350)),maxLines: 2,),
                              TextButton.icon(
                                onPressed: () {
                                },
                                icon: Text(
                                  "Xem thêm",
                                  style: TextStyle(color: Color(0xFFBB8A0B)),
                                ),
                                label: Icon(Icons.arrow_forward, color: Color(0xFFBB8A0B), size: 16),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: SizedBox(
                                        width: 200,
                                        height: 80,
                                        child: Image.asset(
                                          "assets/image/new2.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                        ),
                                        child: Text(
                                          "Tin thị trường",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text("Hướng dẫn của Bộ Tài Chính về bảo"
                                    " hiểm cháy, nổ bắt buộc",
                                  style: TextStyle(overflow: TextOverflow.ellipsis,fontSize: 16),maxLines: 3,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("11:00 - 20/12/2023",
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight(350)),),
                                  ],
                                ),
                                TextButton.icon(
                                  onPressed: () {
                                  },
                                  icon: Text(
                                    "Xem thêm",
                                    style: TextStyle(color: Color(0xFFBB8A0B)),
                                  ),
                                  label: Icon(Icons.arrow_forward, color: Color(0xFFBB8A0B), size: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: SizedBox(
                                        width: 200,
                                        height: 80,
                                        child: Image.asset(
                                          "assets/image/new3.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                        ),
                                        child: Text(
                                          "Tin thị trường",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text("Hoàn tiền dến 10 triệu đồng khi dùng thẻ HDBank",
                                  style: TextStyle(overflow: TextOverflow.ellipsis,fontSize: 16),maxLines: 3,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("11:00 - 20/12/2023",
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight(350)),),
                                  ],
                                ),
                                TextButton.icon(
                                  onPressed: () {
                                  },
                                  icon: Text(
                                    "Xem thêm",
                                    style: TextStyle(color: Color(0xFFBB8A0B)),
                                  ),
                                  label: Icon(Icons.arrow_forward, color: Color(0xFFBB8A0B), size: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top:30),
                      child: OutlinedButton(
                          onPressed: (){},
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(1),
                              ),
                              side: BorderSide(
                                  color: Color(0xFFBB8A0B)
                              )
                          ),
                          child: Text("Xem thêm",style: TextStyle(fontSize: 20, color: Color(0xFFBB8A0B)),)),
                    ),
                    SizedBox(height: 100,)
                  ],
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 2790),
            height: 800,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/image/bg_home_6.png"),
                  fit: BoxFit.cover
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 180,),
                Row(
                  children: [
                    SizedBox(width: 50,),
                    Image.asset("assets/image/logohd_insurance.png"),
                  ],
                ),
                SizedBox(height: 80,),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Công ty TNHH Bảo hiểm HD",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      SizedBox(height: 15,),
                      Text("Giấy phép thành lập và hoạt động số 82/GP/KDBH\n"
                          "ngày cấp 19/5/2020 cấp bởi Bộ Tài Chính",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          ImageIcon(AssetImage("assets/icons/icon_addres.png"),color: Colors.white,size: 24,),
                          Text("Tòa nhà Abacus, 58 Nguyễn Đình Chiều \n,Quận 1, Tp.Hồ Chí Minh",style: TextStyle(color: Colors.white),)
                        ],
                      ),
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          ImageIcon(AssetImage("assets/icons/icon_email.png"),color: Colors.white,size: 24,),
                          Text("Email: info@hdinsurance.com.vn",style: TextStyle(color: Colors.white),)
                        ],
                      ),
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          ImageIcon(AssetImage("assets/icons/icon_call.png"),color: Colors.white,size: 24,),
                          Text("Hotline: (028) 3528 2888",style: TextStyle(color: Colors.white),)
                        ],
                      ),
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          ImageIcon(AssetImage("assets/icons/icon_global.png"),color: Colors.white,size: 24,),
                          Text("Website: hdinsurance.com.vn",style: TextStyle(color: Colors.white),)
                        ],
                      ),
                      SizedBox(height: 15,),
                      Text("Theo dõi chúng tôi",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          Container(
                           decoration: BoxDecoration(
                             color: Color(0xFF1E7E34),
                             borderRadius: BorderRadius.circular(10)
                           ),
                           child:  IconButton(padding: EdgeInsets.zero,
                               onPressed: (){},
                               icon: Image.asset("assets/icons/icon_fb.png",fit: BoxFit.contain,width: 30,)),
                         ),
                          SizedBox(width: 15,),
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xFF1E7E34),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child:  IconButton(padding: EdgeInsets.zero,
                                onPressed: (){},
                                icon: Image.asset("assets/icons/icon_in.png",fit: BoxFit.contain,width: 30,)),
                          ),
                          SizedBox(width: 15,),
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xFF1E7E34),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child:  IconButton(padding: EdgeInsets.zero,
                                onPressed: (){},
                                icon: Image.asset("assets/icons/icon_ytb.png",fit: BoxFit.contain,width: 30,)),
                          ),
                          SizedBox(width: 15,),
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xFF1E7E34),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child:  IconButton(padding: EdgeInsets.zero,
                                onPressed: (){},
                                icon: Image.asset("assets/icons/icon_ig.png",fit: BoxFit.contain,width: 30,)),
                          ),
                          SizedBox(width: 15,),
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xFF1E7E34),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child:  IconButton(padding: EdgeInsets.zero,
                                onPressed: (){},
                                icon: Image.asset("assets/icons/icon_zalo.png",fit: BoxFit.contain,width: 30,)),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
class CustomBottomNavBar1 extends StatelessWidget{
  const CustomBottomNavBar1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: double.infinity,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              IconButton(
                  onPressed: (){},
                iconSize: 30,
                  icon: Image.asset("assets/icons/icon_bottom1.png"),),
              Text("Trang chủ",style: TextStyle(fontSize: 13,color: Colors.grey),)
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: (){},
                iconSize: 30,
                icon: Image.asset("assets/icons/icon_bottom1.png"),),
              Text("Trang chủ",style: TextStyle(fontSize: 13,color: Colors.grey),)
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: (){},
                iconSize: 30,
                icon: Image.asset("assets/icons/icon_bottom1.png"),),
              Text("Trang chủ",style: TextStyle(fontSize: 13,color: Colors.grey),)
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: (){},
                iconSize: 30,
                icon: Image.asset("assets/icons/icon_bottom1.png"),),
              Text("Trang chủ",style: TextStyle(fontSize: 13,color: Colors.grey),)
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: (){},
                iconSize: 30,
                icon: Image.asset("assets/icons/icon_bottom1.png"),),
              Text("Trang chủ",style: TextStyle(fontSize: 13,color: Colors.grey),)
            ],
          ),
        ],
      ),
    );
  }
}
class CustomBottomNavBar extends StatefulWidget{
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}
class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  Widget _buildBottomItem(int index, String label, String assetPath) {
    bool isSelected = _selectedIndex == index;
    bool isCenter = index == 2;

    Color activeColor = const Color(0xFFBB8A0B);
    Color inactiveColor = Colors.grey;
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 5),
            Image.asset(
              assetPath,
              width: isCenter ? 32 : 24,
              height: isCenter ? 32 : 24,
              color: isSelected ? activeColor : null,
              colorBlendMode: isCenter && !isSelected ? null : BlendMode.srcIn,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: isSelected ? activeColor : inactiveColor,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            _buildBottomItem(0, "Trang chủ", "assets/icons/icon_bottom1.png"),
            _buildBottomItem(1, "Bồi thường", "assets/icons/icon_bottom2.png"),
            _buildBottomItem(2, "Thao tác", "assets/icons/icon_bottom3.png"),
            _buildBottomItem(3, "Hỗ trợ", "assets/icons/icon_bottom4.png"),
            _buildBottomItem(4, "Tiện ích", "assets/icons/icon_bottom5.png"),
          ],
        ),
      ),
    );
  }
}

