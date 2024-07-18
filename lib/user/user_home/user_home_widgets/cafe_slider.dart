// import 'package:flutter/material.dart';

// import '../../../utils/constans/colors.dart';
// import '../../../utils/constans/sizes.dart';

// class CafeSlider extends StatelessWidget {
//   const CafeSlider({
//     super.key,
//     this.width,
//     this.height,
//     required this.imageUrl,
//     this.applyImageRadius = true,
//     this.border,
//     this.backgroundColor,
//     this.fit = BoxFit.contain,
//     this.padding,
//     this.isNetworkImage = false,
//     this.onPressed,
//     this.borderRadius = Sizes.md,
//     this.title = '',
//   });

//   final double? width, height;
//   final String imageUrl;
//   final bool applyImageRadius;
//   final BoxBorder? border;
//   final Color? backgroundColor;
//   final BoxFit? fit;
//   final EdgeInsetsGeometry? padding;
//   final bool isNetworkImage;
//   final VoidCallback? onPressed;
//   final double borderRadius;
//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: Stack(
//         children: [
//           Container(
//             width: width,
//             height: height,
//             padding: padding,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(borderRadius),
//                 border: border,
//                 color: backgroundColor),
//             child: ClipRRect(
//               borderRadius: applyImageRadius
//                   ? BorderRadius.circular(borderRadius)
//                   : BorderRadius.zero,
//               child: Image(
//                   image: isNetworkImage
//                       ? NetworkImage(imageUrl)
//                       : AssetImage(imageUrl) as ImageProvider,
//                   fit: fit),
//             ),
//           ),
//           Positioned(
//             bottom: 40,
//             left: 20,
//             child: Text(
//               title,
//               style: Theme.of(context)
//                   .textTheme
//                   .titleLarge!
//                   .apply(color: MyColors.black), //~------------color
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
