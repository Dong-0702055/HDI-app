/// Model cho một quyền lợi trong bảng so sánh
class ComparisonBenefit {
  final String title; // Tên quyền lợi (hiển thị ở giữa dưới 2 cột)
  final String leftValue; // Giá trị cột trái
  final String rightValue; // Giá trị cột phải

  const ComparisonBenefit({
    required this.title,
    required this.leftValue,
    required this.rightValue,
  });
}

/// Model cho một nhóm/section trong bảng so sánh (VD: "I. Bảo hiểm tai nạn")
class ComparisonSection {
  final String sectionTitle; // Tiêu đề nhóm
  final List<ComparisonBenefit> benefits; // Các quyền lợi trong nhóm

  const ComparisonSection({
    required this.sectionTitle,
    required this.benefits,
  });
}

/// Model cho một gói bảo hiểm dùng trong màn hình so sánh
class ComparisonPackage {
  final String title; // VD: "Gói Đồng"
  final String subtitle; // VD: "Siêu tiết kiệm"
  final String price; // VD: "695.000 VNĐ/năm"

  const ComparisonPackage({
    required this.title,
    required this.subtitle,
    required this.price,
  });
}

/// Dữ liệu mock cho màn hình "Chi tiết quyền lợi các gói"
/// (Bảo hiểm Chăm sóc Sức khỏe và Tai nạn)
class ComparisonData {
  static const List<ComparisonPackage> packages = [
    ComparisonPackage(
      title: 'Gói Đồng',
      subtitle: 'Siêu tiết kiệm',
      price: '695.000 VNĐ/năm',
    ),
    ComparisonPackage(
      title: 'Gói Bạc',
      subtitle: 'Phổ biến',
      price: '1.695.000 VNĐ/năm',
    ),
    ComparisonPackage(
      title: 'Gói Vàng',
      subtitle: 'Nên mua',
      price: '2.695.000 VNĐ/năm',
    ),
    ComparisonPackage(
      title: 'Gói Titan',
      subtitle: 'Bảo vệ tối đa',
      price: '3.695.000 VNĐ/năm',
    ),
    ComparisonPackage(
      title: 'Gói Bạch Kim',
      subtitle: 'Cao cấp',
      price: '4.695.000 VNĐ/năm',
    ),
    ComparisonPackage(
      title: 'Gói Kim Cương',
      subtitle: 'Siêu cao cấp',
      price: '5.695.000 VNĐ/năm',
    ),
  ];

  /// Lấy dữ liệu bảng so sánh dựa trên 2 gói đang được chọn
  static List<ComparisonSection> getSections(
    ComparisonPackage left,
    ComparisonPackage right,
  ) {
    // Tra cứu giá trị quyền lợi theo tên gói
    final lv = _getValues(left.title);
    final rv = _getValues(right.title);

    return [
      ComparisonSection(
        sectionTitle: 'I. Bảo hiểm tai nạn',
        benefits: [
          ComparisonBenefit(
            title: '1. Tử vong do tai nạn',
            leftValue: lv['taiNan']!,
            rightValue: rv['taiNan']!,
          ),
          ComparisonBenefit(
            title: '2. Thương tật toàn bộ vĩnh viễn do tai nạn',
            leftValue: 'Tối đa số tiền bảo hiểm',
            rightValue: 'Tối đa số tiền bảo hiểm',
          ),
          ComparisonBenefit(
            title: '3. Thương tật bộ phận vĩnh viễn do tai nạn',
            leftValue: 'Chi trả theo Bảng tỷ lệ\ntrả tiền thương tật',
            rightValue: 'Chi trả theo Bảng tỷ lệ\ntrả tiền thương tật',
          ),
        ],
      ),
      ComparisonSection(
        sectionTitle: 'II. Tử vong/thương tật vĩnh viễn do ốm đau\nbệnh tật, thai sản',
        benefits: [
          ComparisonBenefit(
            title: '1. Tử vong do ốm đau, bệnh tật, thai sản',
            leftValue: lv['omDau']!,
            rightValue: rv['omDau']!,
          ),
          ComparisonBenefit(
            title: '2. Thương tật toàn bộ vĩnh viễn do ốm đau, bệnh tật',
            leftValue: 'Tối đa số tiền bảo hiểm',
            rightValue: 'Tối đa số tiền bảo hiểm',
          ),
        ],
      ),
      ComparisonSection(
        sectionTitle: 'III. Điều trị nội trú',
        benefits: [
          ComparisonBenefit(
            title: '1. Chi phí phòng, giường bệnh',
            leftValue: lv['noiTru']!,
            rightValue: rv['noiTru']!,
          ),
          ComparisonBenefit(
            title: '2. Chi phí phẫu thuật',
            leftValue: 'Theo thực tế',
            rightValue: 'Theo thực tế',
          ),
        ],
      ),
      ComparisonSection(
        sectionTitle: 'IV. Điều trị ngoại trú',
        benefits: [
          ComparisonBenefit(
            title: '1. Chi phí khám, chữa bệnh ngoại trú',
            leftValue: lv['ngoaiTru']!,
            rightValue: rv['ngoaiTru']!,
          ),
        ],
      ),
      ComparisonSection(
        sectionTitle: 'V. Nha khoa',
        benefits: [
          ComparisonBenefit(
            title: '1. Chi phí nha khoa cơ bản',
            leftValue: lv['nhaKhoa']!,
            rightValue: rv['nhaKhoa']!,
          ),
        ],
      ),
    ];
  }

  /// Bảng tra cứu giá trị quyền lợi theo tên gói
  static Map<String, String> _getValues(String packageTitle) {
    const data = {
      'Gói Đồng': {
        'taiNan': '100.000.000 VNĐ',
        'omDau': '50.000.000 VNĐ',
        'noiTru': '40.000.000 VNĐ',
        'ngoaiTru': 'Không áp dụng',
        'nhaKhoa': 'Không áp dụng',
      },
      'Gói Bạc': {
        'taiNan': '150.000.000 VNĐ',
        'omDau': '75.000.000 VNĐ',
        'noiTru': '60.000.000 VNĐ',
        'ngoaiTru': '1.000.000 VNĐ/lần',
        'nhaKhoa': 'Không áp dụng',
      },
      'Gói Vàng': {
        'taiNan': '200.000.000 VNĐ',
        'omDau': '100.000.000 VNĐ',
        'noiTru': '80.000.000 VNĐ',
        'ngoaiTru': '1.500.000 VNĐ/lần',
        'nhaKhoa': '1.000.000 VNĐ/năm',
      },
      'Gói Titan': {
        'taiNan': '300.000.000 VNĐ',
        'omDau': '150.000.000 VNĐ',
        'noiTru': '120.000.000 VNĐ',
        'ngoaiTru': '2.000.000 VNĐ/lần',
        'nhaKhoa': '1.500.000 VNĐ/năm',
      },
      'Gói Bạch Kim': {
        'taiNan': '400.000.000 VNĐ',
        'omDau': '200.000.000 VNĐ',
        'noiTru': '150.000.000 VNĐ',
        'ngoaiTru': '5.000.000 VNĐ/lần',
        'nhaKhoa': '3.000.000 VNĐ/năm',
      },
      'Gói Kim Cương': {
        'taiNan': '500.000.000 VNĐ',
        'omDau': '300.000.000 VNĐ',
        'noiTru': '200.000.000 VNĐ',
        'ngoaiTru': '10.000.000 VNĐ/lần',
        'nhaKhoa': '5.000.000 VNĐ/năm',
      },
    };

    return data[packageTitle] ??
        {
          'taiNan': '-',
          'omDau': '-',
          'noiTru': '-',
          'ngoaiTru': '-',
          'nhaKhoa': '-',
        };
  }
}
