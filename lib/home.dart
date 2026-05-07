import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_hdi/insurance_detail/insurance_detail_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // AutoSliderBanner(),
            // ServiceContainer()
            Container1(),
          ],
        ),
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Padding(
        padding: EdgeInsets.only(left: 16),
        child: Image.asset('assets/image/logo.png'),
      ),
      actions: [
        TextButton.icon(
          onPressed: () {},
          icon: Icon(Icons.person_2_outlined, color: Colors.green),
          label: Text(
            "Đăng nhập",
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
        IconButton(
          icon: Icon(Icons.search, color: Colors.black87),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.notifications_none, color: Colors.black87),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.format_list_bulleted, color: Colors.black87),
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

class Container1 extends StatelessWidget {
  Container1({super.key});
  final List<String> imgList1 = [
    'assets/image/title1.png',
    'assets/image/title.png',
  ];
  final List<String> imgList2 = [
    'assets/image/slide1.png',
    'assets/image/slide2.png',
  ];
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
            items: imgList1
                .map(
                  (item) => Image.asset(
                    item,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                )
                .toList(),
          ),
          Column(
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 285),
                padding: EdgeInsets.only(top: 45),
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
                    Column(
                      children: [
                        Text(
                          "Bảo hiểm trực tuyến",
                          style: TextStyle(fontSize: 28, color: Colors.white),
                        ),
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
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      "assets/image/home_1.png",
                                      height: 150,
                                      width: 200,
                                      fit: BoxFit.fitWidth,
                                    ),
                                    Text(
                                      "Bảo hiểm",
                                      style: TextStyle(fontSize: 23),
                                    ),
                                    Text(
                                      "Chăm sóc sức khỏe và tai nạn",
                                      style: TextStyle(
                                        fontSize: 15,
                                        overflow: TextOverflow.ellipsis,
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
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                const InsuranceDetailScreen(),
                                          ),
                                        );
                                      },
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Color(0xFFBB8A0B),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadiusGeometry.circular(1),
                                        ),
                                        side: BorderSide(
                                          color: Color(0xFFBB8A0B),
                                        ),
                                      ),
                                      child: Text("Mua ngay"),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.only(left: 10),
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      "assets/image/home_2.png",
                                      height: 150,
                                      width: 200,
                                      fit: BoxFit.fitWidth,
                                    ),
                                    Text(
                                      "Bảo hiểm",
                                      style: TextStyle(fontSize: 23),
                                    ),
                                    Text(
                                      "Tai nạn và con người",
                                      style: TextStyle(
                                        fontSize: 15,
                                        overflow: TextOverflow.ellipsis,
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
                                      onPressed: () {},
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Color(0xFFBB8A0B),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadiusGeometry.circular(1),
                                        ),
                                        side: BorderSide(
                                          color: Color(0xFFBB8A0B),
                                        ),
                                      ),
                                      child: Text("Mua ngay"),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.only(left: 10),
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      "assets/image/home_3.png",
                                      height: 150,
                                      width: 200,
                                      fit: BoxFit.fitWidth,
                                    ),
                                    Text(
                                      "Bảo hiểm",
                                      style: TextStyle(fontSize: 23),
                                    ),
                                    Text(
                                      "Du lịch Việt Nam",
                                      style: TextStyle(
                                        fontSize: 15,
                                        overflow: TextOverflow.ellipsis,
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
                                      onPressed: () {},
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Color(0xFFBB8A0B),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadiusGeometry.circular(1),
                                        ),
                                        side: BorderSide(
                                          color: Color(0xFFBB8A0B),
                                        ),
                                      ),
                                      child: Text("Mua ngay"),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 30),
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(1),
                              ),
                              side: BorderSide(color: Color(0xFFBB8A0B)),
                            ),
                            child: Text(
                              "Xem thêm",
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFFBB8A0B),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 30),
                          child: Text(
                            "Dịch vụ khách hàng",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight(500),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
                            margin: EdgeInsets.only(left: 10, top: 10),
                            padding: EdgeInsets.all(5),
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  "assets/image/home_1.png",
                                  height: 150,
                                  width: 200,
                                  fit: BoxFit.fitWidth,
                                ),
                                Text(
                                  "Bảo hiểm",
                                  style: TextStyle(fontSize: 23),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(left: 10, top: 10),
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  "assets/image/home_2.png",
                                  height: 150,
                                  width: 200,
                                  fit: BoxFit.fitWidth,
                                ),
                                Text(
                                  "Bảo hiểm",
                                  style: TextStyle(fontSize: 23),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(left: 10, top: 10),
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  "assets/image/home_3.png",
                                  height: 150,
                                  width: 200,
                                  fit: BoxFit.fitWidth,
                                ),
                                Text(
                                  "Bảo hiểm",
                                  style: TextStyle(fontSize: 23),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 20),
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(1),
                          ),
                          side: BorderSide(color: Color(0xFFBB8A0B)),
                        ),
                        child: Text(
                          "Xem thêm",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFFBB8A0B),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 30),
                      child: Text(
                        "Tiện ích hỗ trợ",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight(500),
                          color: Colors.green,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 10),
                            padding: EdgeInsets.all(5),
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  "assets/image/home_1.png",
                                  height: 150,
                                  width: 200,
                                  fit: BoxFit.fitWidth,
                                ),
                                Text(
                                  "Bảo hiểm",
                                  style: TextStyle(fontSize: 23),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(left: 10, top: 10),
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  "assets/image/home_2.png",
                                  height: 150,
                                  width: 200,
                                  fit: BoxFit.fitWidth,
                                ),
                                Text(
                                  "Bảo hiểm",
                                  style: TextStyle(fontSize: 23),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(left: 10, top: 10),
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  "assets/image/home_3.png",
                                  height: 150,
                                  width: 200,
                                  fit: BoxFit.fitWidth,
                                ),
                                Text(
                                  "Bảo hiểm",
                                  style: TextStyle(fontSize: 23),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 20),
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(1),
                          ),
                          side: BorderSide(color: Color(0xFFBB8A0B)),
                        ),
                        child: Text(
                          "Xem thêm",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFFBB8A0B),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 1400),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/image/bg_home_3.png"),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 80),
                  child: Text(
                    "Thông tin đối tác",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight(500),
                      color: Colors.white,
                    ),
                  ),
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    viewportFraction: 0.7,
                    enlargeCenterPage: true,
                  ),
                  items: imgList2
                      .map(
                        (item) => ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(10),
                          child: Image.asset(item, fit: BoxFit.fitWidth),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
