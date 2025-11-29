import 'dart:io';
import 'dart:ui' as ui;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'complete_quest_screen.dart';
import '../../main.dart';

class CameraScreen extends StatefulWidget {
  final String questTitle;
  final int xp;

  const CameraScreen({super.key, required this.questTitle, required this.xp});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  bool isReady = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      controller = CameraController(
        cameras[0],
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await controller!.initialize();

      if (!mounted) return;
      setState(() => isReady = true);
    } catch (e) {
      debugPrint("Camera init error: $e");
    }
  }

  String _getDateTime() {
    final now = DateTime.now();

    String d(int v) => v.toString().padLeft(2, "0");

    return "${d(now.day)}-${d(now.month)}-${now.year}   •   ${d(now.hour)}:${d(now.minute)}";
  }

  Future<File> _mergeOverlay(File photo) async {
    final bytes = await photo.readAsBytes();
    final cameraImg = await decodeImageFromList(bytes);

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    final paint = Paint();
    canvas.drawImage(cameraImg, Offset.zero, paint);

    final double h = cameraImg.height.toDouble();

    double scale(double v) => v * (h / 1280);

    final double baseX = scale(26) + scale(20);
    final double baseY = h - scale(160);

    TextPainter tp(String text, double size, FontWeight fw, Color color) {
      final txt = TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(fontSize: scale(size), fontWeight: fw, color: color),
        ),
        textDirection: TextDirection.ltr,
      );
      txt.layout();
      return txt;
    }

    tp(
      widget.questTitle,
      26,
      FontWeight.w800,
      Colors.white,
    ).paint(canvas, Offset(baseX, baseY));

    final xpText = "+${widget.xp} XP";

    final xpTp = tp(xpText, 18, FontWeight.w700, Colors.black);

    final xpWidth = xpTp.width + scale(34);
    final xpHeight = xpTp.height + scale(14);

    final xpRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(baseX, baseY + scale(38), xpWidth, xpHeight),
      Radius.circular(scale(26)),
    );

    final xpPaint = Paint()..color = Colors.greenAccent.withOpacity(0.85);
    canvas.drawRRect(xpRect, xpPaint);

    xpTp.paint(canvas, Offset(baseX + scale(17), baseY + scale(38) + scale(7)));

    tp(
      _getDateTime(),
      18,
      FontWeight.w400,
      Colors.white.withOpacity(0.88),
    ).paint(canvas, Offset(baseX, baseY + scale(94)));

    final picture = recorder.endRecording();
    final merged = await picture.toImage(cameraImg.width, cameraImg.height);

    final png = await merged.toByteData(format: ui.ImageByteFormat.png);
    final output = File(
      "${photo.parent.path}/final_${DateTime.now().millisecondsSinceEpoch}.png",
    );

    await output.writeAsBytes(png!.buffer.asUint8List());
    return output;
  }

  Future<void> _capture() async {
    if (!controller!.value.isInitialized) return;

    final raw = await controller!.takePicture();
    final merged = await _mergeOverlay(File(raw.path));

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CompleteQuestScreen(
          questTitle: widget.questTitle,
          xp: widget.xp,
          image: merged,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBEA),
      body: Column(
        children: [
          // HEADER
          Container(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 25),
            width: double.infinity,
            decoration: const BoxDecoration(color: Color(0xFF398A57)),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                ),
                const SizedBox(width: 10),
                const Text(
                  "Complete the mission",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // PREVIEW
          // PREVIEW
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: isReady
                    ? LayoutBuilder(
                        builder: (context, constraints) {
                          return FittedBox(
                            fit: BoxFit.scaleDown,
                            child: SizedBox(
                              width: constraints.maxWidth,
                              height: constraints.maxHeight,

                              child: AspectRatio(
                                aspectRatio: controller!.value.aspectRatio,

                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    CameraPreview(controller!),

                                    // ==== overlay ====
                                    Positioned(
                                      bottom: 18,
                                      left: 18,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.questTitle,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              height: 1.05,
                                            ),
                                          ),

                                          SizedBox(height: 4),

                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.greenAccent
                                                  .withOpacity(0.85),
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                            ),
                                            child: Text(
                                              "+${widget.xp} XP",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ),

                                          SizedBox(height: 8),

                                          Text(
                                            _getDateTime(),
                                            style: TextStyle(
                                              color: Colors.white.withOpacity(
                                                0.88,
                                              ),
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(child: CircularProgressIndicator()),
              ),
            ),
          ),

          // CAPTURE BUTTON
          GestureDetector(
            onTap: _capture,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.green, width: 8),
              ),
            ),
          ),

          const SizedBox(height: 35),
        ],
      ),
    );
  }
}
