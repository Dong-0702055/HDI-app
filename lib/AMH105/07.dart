import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CameraCmndScreen extends StatefulWidget {
  const CameraCmndScreen({super.key});

  @override
  State<CameraCmndScreen> createState() => _CameraCmndScreenState();
}

class _CameraCmndScreenState extends State<CameraCmndScreen> {
  bool scanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Stack(
        children: [
          /// CAMERA
          MobileScanner(
            fit: BoxFit.cover,

            onDetect: (capture) {
              if (scanned) return;

              final List<Barcode> barcodes = capture.barcodes;

              for (final barcode in barcodes) {
                final String code = barcode.rawValue ?? "";

                if (code.isEmpty) return;

                scanned = true;

                print("QR RESULT: $code");

                /// TÁCH QR CCCD
                final parts = code.split("|");

                String cccd = "";
                String name = "";
                String birth = "";

                /// QR CCCD VN THƯỜNG:
                /// CCCD|CMND|HỌ TÊN|NGÀY SINH|...

                if (parts.isNotEmpty) {
                  cccd = parts[0];
                }

                if (parts.length > 2) {
                  name = parts[2];
                }

                if (parts.length > 3) {
                  birth = parts[3];
                }

                /// FORMAT NGÀY
                if (birth.length == 8) {
                  birth =
                      "${birth.substring(0, 2)}/"
                      "${birth.substring(2, 4)}/"
                      "${birth.substring(4)}";
                }

                /// TRẢ DỮ LIỆU VỀ
                Navigator.pop(context, {
                  "name": name,

                  "birth": birth,

                  "cccd": cccd,

                  "raw": code,
                });

                break;
              }
            },
          ),

          /// OVERLAY
          Container(color: Colors.black.withOpacity(0.35)),

          /// FRAME
          Center(
            child: Container(
              width: 300,
              height: 190,

              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 3),

                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),

          /// TEXT
          Positioned(
            top: 90,
            left: 20,
            right: 20,

            child: Container(
              padding: const EdgeInsets.all(14),

              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),

                borderRadius: BorderRadius.circular(12),
              ),

              child: const Text(
                "Đưa mã QR CCCD vào khung để quét",

                textAlign: TextAlign.center,

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          /// BACK
          Positioned(
            top: 50,
            left: 20,

            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },

              child: Container(
                padding: const EdgeInsets.all(8),

                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),

                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),

          /// SCAN LINE
          Center(child: Container(width: 260, height: 2, color: Colors.red)),
        ],
      ),
    );
  }
}
