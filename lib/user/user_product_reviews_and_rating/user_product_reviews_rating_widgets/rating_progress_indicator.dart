// import 'package:flutter/material.dart';

// import '../../../utils/constans/colors.dart';
// import '../../../utils/device/device_utility.dart';

// class RatingProgressIndicator extends StatelessWidget {
//   const RatingProgressIndicator({
//     super.key,
//     required this.text,
//     required this.value,
//   });
//   final String text;
//   final double value;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           flex: 1,
//           child: Text(
//             text,
//             style: Theme.of(context).textTheme.bodyMedium,
//           ),
//         ),
//         Expanded(
//           flex: 11,
//           child: SizedBox(
//             width: DeviceUtils.getScreenWidth(context) * 0.5,
//             child: LinearProgressIndicator(
//               value: value,
//               minHeight: 10,
//               backgroundColor: gray,
//               valueColor: AlwaysStoppedAnimation(MyColors.primary),
//               borderRadius: BorderRadius.circular(7),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
