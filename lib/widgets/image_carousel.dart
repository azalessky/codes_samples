import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageCarousel extends StatefulWidget {
  static const dotSize = 8.0;
  static const dotSpacing = 6.0;

  final int initialPage;
  final List<String> images;
  final double imageWidth;
  final double imageHeight;
  final Function(int) onPageChanged;

  const ImageCarousel({
    required this.initialPage,
    required this.images,
    required this.imageWidth,
    required this.imageHeight,
    required this.onPageChanged,
    super.key,
  });

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  late int selectedPage;

  @override
  void initState() {
    selectedPage = widget.initialPage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: widget.imageWidth,
          height: widget.imageHeight,
          child: CarouselSlider(
            items: List<Widget>.generate(
              widget.images.length + 1,
              (index) => Container(
                width: widget.imageWidth,
                height: widget.imageHeight,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: index == 0
                    ? const Icon(
                        Icons.hide_image_outlined,
                        size: 32,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: SvgPicture.asset(
                          widget.images[index - 1],
                          width: widget.imageWidth,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
            options: CarouselOptions(
              initialPage: widget.initialPage,
              height: widget.imageHeight,
              viewportFraction: widget.imageWidth / widget.imageHeight,
              onPageChanged: (index, reason) => _pageChangedHandler(index),
            ),
          ),
        ),
        const SizedBox(height: 12),
        AnimatedSmoothIndicator(
          activeIndex: selectedPage,
          count: widget.images.length + 1,
          effect: SlideEffect(
            dotWidth: ImageCarousel.dotSize,
            dotHeight: ImageCarousel.dotSize,
            spacing: ImageCarousel.dotSpacing,
            activeDotColor: Theme.of(context).colorScheme.primary,
            dotColor: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
      ],
    );
  }

  void _pageChangedHandler(int index) {
    setState(() => selectedPage = index);
    widget.onPageChanged(index);
  }
}
