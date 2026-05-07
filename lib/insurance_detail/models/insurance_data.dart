class BenefitItem {
  final String? title;
  final String content;

  const BenefitItem({this.title, required this.content});
}

class StepData {
  final String title;
  final List<BenefitItem> benefits;
  final String tooltipLabel;

  const StepData({
    required this.title,
    required this.benefits,
    required this.tooltipLabel,
  });
}

class InsuranceData {
  static const String coverImage = 'assets/image/detail_home1.png';

  static const List<StepData> steps = [
    StepData(
      title: 'Bảo Hiểm Chăm Sóc Sức Khỏe \nVà Tai Nạn',
      tooltipLabel: 'Độ tuổi áp dụng',
      benefits: [
        BenefitItem(
          content:
              'Chủ động bảo vệ bản thân và những người bạn thương yêu bằng gói bảo hiểm chăm sóc sức khoẻ và tai nạn.',
        ),
        BenefitItem(
          content:
              'Gói bảo hiểm chăm sóc sức khoẻ và tai nạn là lựa chọn tuyệt vời với ưu đãi vượt trội, kèm theo các quyền lợi bảo hiểm ưu việt.',
        ),
        BenefitItem(
          content:
              'Giải quyết chi trả quyền lợi bảo hiểm kịp thời. Hãy để HDI là chỗ dựa tài chính vững chắc.',
        ),
      ],
    ),
    StepData(
      title: 'Độ tuổi áp dụng & Quy tắc bảo \nhiểm',
      tooltipLabel: 'Step content',
      benefits: [
        BenefitItem(
          title: 'Đối tượng tham gia bảo hiểm:\n',
          content:
              'Mọi công dân Việt Nam hoặc Người nước ngoài sinh sống hợp pháp tại Việt Nam từ 18 đến 65 tuổi',
        ),
        BenefitItem(title: 'Thời hạn bảo hiểm:\n', content: '1 năm'),
        BenefitItem(
          title: 'Hình thức hợp đồng\n',
          content: 'Giấy chứng nhận bảo hiểm điện tử',
        ),
      ],
    ),
    StepData(
      title: 'Phạm vi bảo hiểm',
      benefits: [
        BenefitItem(
          title: 'Bảo hiểm tai nạn cá nhân:',
          content:
              'Chi trả quyền lợi trong trường hợp tử vong hoặc thương tật toàn bộ/bộ phận vĩnh viễn do tai nạn xảy ra trong lãnh thổ Việt Nam.',
        ),
        BenefitItem(
          title: 'Hỗ trợ chi phí y tế:',
          content:
              'Thanh toán các chi phí khám chữa bệnh, phẫu thuật, thuốc men và thiết bị y tế cần thiết theo chỉ định của bác sĩ khi điều trị tai nạn.',
        ),
      ],
      tooltipLabel: '',
    ),
  ];
}
