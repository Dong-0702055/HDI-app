class FaqItem {
  final String question;
  final String answer;

  const FaqItem({
    required this.question,
    required this.answer,
  });
}

class FaqData {
  static const List<FaqItem> items = [
    FaqItem(
      question: 'Tôi có thể mua bảo hiểm với thời hạn bảo hiểm là bao lâu?',
      answer: 'Thời hạn chuẩn của bảo hiểm này là 1 năm và sẽ được tái tục bảo hiểm hàng năm nếu Quý khách có nhu cầu. Trường hợp Quý khách muốn mua bảo hiểm với thời hạn bảo hiểm dưới 1 năm hoặc trên 1 năm, Quý khách vui lòng liên hệ trực tiếp với Bảo hiểm HD để được tư vấn.',
    ),
    FaqItem(
      question: 'Tôi có cần kiểm tra sức khỏe khi tham gia bảo hiểm không?',
      answer: 'Thông thường Quý khách không cần kiểm tra sức khỏe trước khi tham gia, trừ một số trường hợp đặc biệt theo yêu cầu của nhà bảo hiểm.',
    ),
    FaqItem(
      question: 'Tôi có thể mua bảo hiểm ở đâu?',
      answer: 'Quý khách có thể mua trực tiếp trên ứng dụng này hoặc liên hệ qua tổng đài, các chi nhánh của HDI trên toàn quốc.',
    ),
    FaqItem(
      question: 'Thời gian chờ trong bảo hiểm sức khoẻ là gì?',
      answer: 'Là khoảng thời gian kể từ khi hợp đồng bảo hiểm có hiệu lực đến khi người được bảo hiểm được hưởng quyền lợi bảo hiểm đối với một số rủi ro cụ thể (như ốm đau, thai sản...).',
    ),
    FaqItem(
      question: 'Phí bảo hiểm có bị thay đổi trong thời hạn bảo hiểm không?',
      answer: 'Phí bảo hiểm thường được giữ nguyên trong suốt thời hạn 1 năm của hợp đồng, trừ trường hợp có thỏa thuận khác được ghi rõ trong hợp đồng.',
    ),
  ];
}
