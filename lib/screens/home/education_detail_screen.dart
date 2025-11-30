import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class EducationDetailScreen extends StatefulWidget {
  final String title;
  final String paragraph1;
  final String paragraph2;
  final String? paragraph3;
  final String imageUrl;
  final String articleId;

  const EducationDetailScreen({
    super.key,
    required this.title,
    required this.paragraph1,
    required this.paragraph2,
    this.paragraph3,
    required this.imageUrl,
    required this.articleId,
  });

  @override
  State<EducationDetailScreen> createState() => _EducationDetailScreenState();
}

class _EducationDetailScreenState extends State<EducationDetailScreen> {
  bool imageLoaded = false;

  @override
  void initState() {
    super.initState();
    _precacheImage();
  }

  void _precacheImage() {
    final image = Image.network(widget.imageUrl);
    final ImageStreamListener listener = ImageStreamListener(
      (ImageInfo info, bool synchronousCall) {
        if (mounted) {
          setState(() {
            imageLoaded = true;
          });
        }
      },
      onError: (dynamic error, StackTrace? stackTrace) {
        if (mounted) {
          setState(() {
            imageLoaded = true; // tetap hilangkan skeleton walau error
          });
        }
      },
    );
    image.image.resolve(const ImageConfiguration()).addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBEA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF398A57),
        title: const Text("Article"),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              !imageLoaded
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: double.infinity,
                        height: 28,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
              const SizedBox(height: 20),

              // Paragraph 1
              !imageLoaded
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Column(
                        children: List.generate(3, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Container(
                              width: double.infinity,
                              height: 16,
                              color: Colors.white,
                            ),
                          );
                        }),
                      ),
                    )
                  : Text(
                      widget.paragraph1,
                      style: const TextStyle(fontSize: 16, height: 1.6),
                    ),
              const SizedBox(height: 12),

              // Gambar
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: InteractiveViewer(
                  panEnabled: true,
                  minScale: 0.8,
                  maxScale: 3,
                  child: Image.network(
                    widget.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      return imageLoaded
                          ? child
                          : Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: double.infinity,
                                height: 200,
                                color: Colors.white,
                              ),
                            );
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[300],
                      height: 200,
                      child: const Center(child: Icon(Icons.broken_image)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Paragraph 2
              !imageLoaded
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Column(
                        children: List.generate(2, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Container(
                              width: double.infinity,
                              height: 16,
                              color: Colors.white,
                            ),
                          );
                        }),
                      ),
                    )
                  : Text(
                      widget.paragraph2,
                      style: const TextStyle(fontSize: 16, height: 1.6),
                    ),
              const SizedBox(height: 12),

              // Paragraph 3 (optional)
              if (widget.paragraph3 != null && widget.paragraph3!.isNotEmpty)
                !imageLoaded
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Column(
                          children: List.generate(2, (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Container(
                                width: double.infinity,
                                height: 16,
                                color: Colors.white,
                              ),
                            );
                          }),
                        ),
                      )
                    : Text(
                        widget.paragraph3!,
                        style: const TextStyle(fontSize: 16, height: 1.6),
                      ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
