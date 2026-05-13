class ExclusionCondition {
  final int index;
  final String content;

  const ExclusionCondition({required this.index, required this.content});
}

class TermsClause {
  final String prefix; // "a)" / "b)" / "c)"
  final String content;
  final List<TermsLink> links; // các từ cần highlight màu vàng

  const TermsClause({
    required this.prefix,
    required this.content,
    this.links = const [],
  });
}

class TermsLink {
  final String text;
  final String? url;

  const TermsLink({required this.text, this.url});
}

/// Static Mock Data
class ConfirmInfoData {
  /// Câu hỏi loại trừ
  static const String questionText =
      'Người tham gia bảo hiểm có thuộc một trong các đối tượng sau đây?';

  /// Danh sách điều kiện loại trừ
  static const List<ExclusionCondition> exclusions = [
    ExclusionCondition(
      index: 1,
      content: 'Người đang mắc bệnh tâm thần, bệnh ung thư, bệnh phong',
    ),
    ExclusionCondition(
      index: 2,
      content: 'Người bị thương tật vĩnh viễn từ 70% trở lên',
    ),
    ExclusionCondition(
      index: 3,
      content: 'Người đang trong thời gian điều trị bệnh tật, thương tật',
    ),
  ];

  /// Cảnh báo khi chọn "Có"
  static const String warningText =
      'Rất tiếc, Quý khách không nằm trong phạm vi đối tượng được bảo hiểm '
      'theo quy định chương trình. Vui lòng xem Quy tắc bảo hiểm để tìm hiểu '
      'chi tiết về đối tượng bảo hiểm. Nếu có bất kỳ câu hỏi hoặc cần sự hỗ '
      'trợ, xin vui lòng liên hệ với Bảo hiểm HD qua số hotline ';

  static const String hotline = '1900 068898';

  /// Điều khoản cam kết (a, b, c)
  static const List<TermsClause> termsClauses = [
    TermsClause(
      prefix: 'a)',
      content:
          'Các thông tin được khai báo, cung cấp là đúng sự thật và hoàn toàn '
          'chịu trách nhiệm trước pháp luật. Đồng thời, Bên mua bảo hiểm đã '
          'đọc, hiểu và đồng ý với điều kiện, điều khoản và quy tắc của Bảo hiểm HD.',
      links: [TermsLink(text: 'điều khoản và quy tắc của Bảo hiểm HD')],
    ),
    TermsClause(
      prefix: 'b)',
      content:
          'Người được bảo hiểm hoặc người đại diện hợp pháp của người được bảo '
          'hiểm đồng ý về nội dung yêu cầu bảo hiểm, số tiền bảo hiểm, người '
          'thụ hưởng theo quy định của pháp luật.',
    ),
    TermsClause(
      prefix: 'c)',
      content:
          'Tôi/chúng tôi cùng những người/các bên có quyền lợi và nghĩa vụ '
          'liên quan đồng ý với các nội dung Điều khoản và điều kiện chung về '
          'bảo vệ và xử lý dữ liệu cá nhân của Bảo hiểm HD.',
      links: [
        TermsLink(
          text:
              'Điều khoản và điều kiện chung về bảo vệ và xử lý dữ liệu cá nhân',
        ),
      ],
    ),
  ];

  /// Tên sản phẩm hiển thị ở bottom bar
  static const String productName = 'Bảo hiểm chăm sóc sức khỏe và tai nạn';
}
