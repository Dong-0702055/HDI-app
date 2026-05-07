class InsurancePackage {
  final String name;
  final String subtitle;
  final String iconPath;
  final String bgPath;
  final String price;
  final Map<String, String> benefits;

  const InsurancePackage({
    required this.name,
    required this.subtitle,
    required this.iconPath,
    required this.bgPath,
    required this.price,
    required this.benefits,
  });
}

class OtherProduct {
  final String name;
  final String iconPath;

  const OtherProduct({required this.name, required this.iconPath});
}

class PackageData {
  // Benefits common to all or customized
  static Map<String, String> _getBenefits({
    required String taiNan,
    required String thuongTat,
    required String noiTru,
    required String ngoaiTru,
    required String nhaKhoa,
  }) {
    return {
      'Bảo hiểm tai nạn:': taiNan,
      'Thương tật bộ phận vĩnh viễn do ốm đau, bệnh tật': thuongTat,
      'Điều trị nội trú do ốm đau,bệnh tật': noiTru,
      'Điều trị ngoại trú do ốm đau, bệnh tật': ngoaiTru,
      'Nha khoa:': nhaKhoa,
    };
  }

  static final List<InsurancePackage> packages = [
    InsurancePackage(
      name: 'Bảo hiểm gói Đồng',
      subtitle: 'Tiết kiệm',
      iconPath: 'assets/icons/icon_bzone.svg',
      bgPath: 'assets/image/bg_bzone.png',
      price: '295.000 VNĐ/năm',
      benefits: _getBenefits(
        taiNan: '100 triệu',
        thuongTat: '50 triệu',
        noiTru: '40 triệu',
        ngoaiTru: 'Không áp dụng',
        nhaKhoa: 'Không áp dụng',
      ),
    ),
    InsurancePackage(
      name: 'Bảo hiểm gói Bạc',
      subtitle: 'Phổ biến',
      iconPath: 'assets/icons/icon_silver.svg',
      bgPath: 'assets/image/bg_silver.png',
      price: '495.000 VNĐ/năm',
      benefits: _getBenefits(
        taiNan: '150 triệu',
        thuongTat: '50 triệu',
        noiTru: '40 triệu',
        ngoaiTru: '1 triệu',
        nhaKhoa: 'Không áp dụng',
      ),
    ),
    InsurancePackage(
      name: 'Bảo hiểm gói Vàng',
      subtitle: 'Nên mua',
      iconPath: 'assets/icons/icon_gold.svg',
      bgPath: 'assets/image/bg_gold.png',
      price: '695.000 VNĐ/năm',
      benefits: _getBenefits(
        taiNan: '150 triệu',
        thuongTat: '50 triệu',
        noiTru: '40 triệu',
        ngoaiTru: '1,5 triệu',
        nhaKhoa: '1 triệu',
      ),
    ),
    InsurancePackage(
      name: 'Bảo hiểm gói Titan',
      subtitle: 'Bảo vệ tối đa',
      iconPath: 'assets/icons/icon_titan.svg',
      bgPath: 'assets/image/bg_titan.png',
      price: '2.695.000 VNĐ/năm',
      benefits: _getBenefits(
        taiNan: '150 triệu',
        thuongTat: '50 triệu',
        noiTru: '40 triệu',
        ngoaiTru: '2 triệu',
        nhaKhoa: '1,5 triệu',
      ),
    ),
    InsurancePackage(
      name: 'Bảo hiểm gói Bạch kim',
      subtitle: 'Cao Cấp',
      iconPath: 'assets/icons/icon_plat.svg',
      bgPath: 'assets/image/bg_plat.png',
      price: '4.695.000 VNĐ/năm',
      benefits: _getBenefits(
        taiNan: '300 triệu',
        thuongTat: '100 triệu',
        noiTru: '80 triệu',
        ngoaiTru: '5 triệu',
        nhaKhoa: '3 triệu',
      ),
    ),
    InsurancePackage(
      name: 'Bảo hiểm gói Kim cương',
      subtitle: 'Siêu cao cấp',
      iconPath: 'assets/icons/icon_dia.svg',
      bgPath: 'assets/image/bg_dia.png',
      price: '8.695.000 VNĐ/năm',
      benefits: _getBenefits(
        taiNan: '500 triệu',
        thuongTat: '200 triệu',
        noiTru: '150 triệu',
        ngoaiTru: '10 triệu',
        nhaKhoa: '5 triệu',
      ),
    ),
  ];

  static const List<OtherProduct> otherProducts = [
    OtherProduct(
      name: 'Bảo hiểm tai\nnạn con người',
      iconPath: 'assets/icons/icon_safe2.svg',
    ),
    OtherProduct(
      name: 'Bảo hiểm du\nlịch Việt Nam',
      iconPath: 'assets/icons/icon_safe2.svg',
    ),
    OtherProduct(
      name: 'Bảo hiểm nhà tư nhân',
      iconPath: 'assets/icons/icon_safe2.svg',
    ),
    OtherProduct(
      name: 'Bảo hiểm tai\nnạn con người',
      iconPath: 'assets/icons/icon_safe2.svg',
    ),
    OtherProduct(
      name: 'Bảo hiểm du\nlịch Việt Nam',
      iconPath: 'assets/icons/icon_safe2.svg',
    ),
    OtherProduct(
      name: 'Bảo hiểm tai\nnạn con người',
      iconPath: 'assets/icons/icon_safe2.svg',
    ),
  ];
}
