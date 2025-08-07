import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi_driver/core/constants/app_images.dart';

class CustomNetworkImage extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadius;
  final BoxShape shape;
  final String imageUrl;
  final Widget? loadingWidget;
  final BoxFit? fit;

  final Widget Function(BuildContext, Object)? errorBuilder;

  const CustomNetworkImage({
    Key? key,
    required this.imageUrl,
    this.height,
    this.width,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
    this.loadingWidget,
    this.fit,
    this.errorBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: Image.network(
        imageUrl,
        height: height,
        width: width,
        fit: fit ?? BoxFit.fill,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return loadingWidget ??
              const Center(child: CircularProgressIndicator());
        },
        errorBuilder: (context, error, stackTrace) {
          return errorBuilder != null
              ? errorBuilder!(context, error)
              : Container(
                  height: height,
                  width: width,
                  child: Image.asset(
                    AppImages.appLogo,
                    fit: BoxFit.fill,
                  ),
                  // color:
                  // Colors.grey.withOpacity(0.5),
                  // child: const Icon(Icons.error),
                );
        },
      ),
    );
  }
}

class CustomImage extends StatelessWidget {
  final String image;
  const CustomImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110.w,
      height: 95.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image.asset(
        image,
        fit: BoxFit.contain,
      ),
    );
  }
}