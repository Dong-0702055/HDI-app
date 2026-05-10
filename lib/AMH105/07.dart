import 'package:flutter/material.dart';

class CameraCmndScreen extends StatelessWidget {
  const CameraCmndScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Stack(
        children: [
          /// BACKGROUND
          Positioned.fill(
            child: Image.asset(
              "assets/image/105/background.png",
              fit: BoxFit.cover,
            ),
          ),

          /// OVERLAY
          Container(color: Colors.black.withOpacity(0.45)),

          SafeArea(
            child: Column(
              children: [
                /// HEADER
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),

                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },

                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// TEXT GUIDE
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),

                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),

                  child: const Text(
                    "Hãy đặt chứng từ trên mặt phẳng và đảm bảo hình chụp không bị mờ, tối hoặc chói sáng",

                    textAlign: TextAlign.center,

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                /// FRAME SCAN
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: 220,

                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 3),
                  ),

                  child: Stack(
                    children: [
                      buildCorner(Alignment.topLeft),
                      buildCorner(Alignment.topRight),
                      buildCorner(Alignment.bottomLeft),
                      buildCorner(Alignment.bottomRight),
                    ],
                  ),
                ),

                const Spacer(),

                /// TEXT
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: const Text(
                    "Bấm để chụp",

                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),

                const SizedBox(height: 16),

                /// BUTTON CAMERA
                GestureDetector(
                  onTap: () {
                    /// xử lý chụp ảnh
                  },

                  child: Image.asset(
                    "assets/image/105/camera2.png",
                    width: 80,
                    height: 80,
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCorner(Alignment alignment) {
    return Align(
      alignment: alignment,

      child: Container(
        width: 30,
        height: 30,

        decoration: BoxDecoration(
          border: Border(
            top:
                alignment == Alignment.topLeft ||
                    alignment == Alignment.topRight
                ? const BorderSide(color: Colors.white, width: 4)
                : BorderSide.none,

            bottom:
                alignment == Alignment.bottomLeft ||
                    alignment == Alignment.bottomRight
                ? const BorderSide(color: Colors.white, width: 4)
                : BorderSide.none,

            left:
                alignment == Alignment.topLeft ||
                    alignment == Alignment.bottomLeft
                ? const BorderSide(color: Colors.white, width: 4)
                : BorderSide.none,

            right:
                alignment == Alignment.topRight ||
                    alignment == Alignment.bottomRight
                ? const BorderSide(color: Colors.white, width: 4)
                : BorderSide.none,
          ),
        ),
      ),
    );
  }
}
