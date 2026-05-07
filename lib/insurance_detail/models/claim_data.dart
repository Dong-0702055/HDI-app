class ClaimStep {
  final String title;
  final String content;
  final String iconPath;

  const ClaimStep({
    required this.title,
    required this.content,
    required this.iconPath,
  });
}

class ClaimSection {
  final String title;
  final List<ClaimStep> steps;

  const ClaimSection({required this.title, required this.steps});
}

class ClaimData {
  static const List<ClaimSection> sections = [
    ClaimSection(
      title: 'Quy trình xử lý bồi thường',
      steps: [
        ClaimStep(
          title: '1. Thanh toán và thu thập',
          content:
              'Thanh toán chi phí khám chữa bệnh, sau đó thu thập và khai báo hồ sơ yêu cầu bồi thường.',
          iconPath: 'assets/image/claim_step1.png',
        ),
        ClaimStep(
          title: '2. Nộp hồ sơ',
          content:
              'Nộp hồ sơ yêu cầu bồi thường trong vòng 30 ngày kể từ ngày khám chữa bệnh đầu tiên.',
          iconPath: 'assets/image/claim_step2.png',
        ),
        ClaimStep(
          title: '3. Giải quyết yêu cầu',
          content:
              'HDI giải quyết hồ sơ và hoàn trả chi phí khám chữa bệnh trong vòng 15 ngày làm việc.',
          iconPath: 'assets/image/claim_step3.png',
        ),
      ],
    ),
    ClaimSection(
      title: 'Quy trình bảo lãnh',
      steps: [
        ClaimStep(
          title: '1. Lựa chọn cơ sở y tế',
          content:
              'Lựa chọn Cơ sở y tế, bệnh viện trong danh sách liên kết của HDI.',
          iconPath: 'assets/image/claim_step4.png',
        ),
        ClaimStep(
          title: '2. Xuất trình giấy tờ và làm thủ tục',
          content:
              'Xuất trình giấy tờ và ký giấy yêu cầu bảo lãnh (do cơ sở y tế cung cấp).',
          iconPath: 'assets/image/claim_step2.png',
        ),
        ClaimStep(
          title: '3. Thanh toán chi phí phát sinh',
          content:
              'Khách hàng thanh toán chi phí không được bảo lãnh (nếu có).',
          iconPath: 'assets/image/claim_step1.png',
        ),
      ],
    ),
  ];
}
