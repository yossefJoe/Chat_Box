// import 'dart:math';

// import 'package:flutter/material.dart';

// class CurvedContainer extends StatefulWidget {
//   @override
//   State<CurvedContainer> createState() => _CurvedContainerState();
// }

// class _CurvedContainerState extends State<CurvedContainer>
//     with TickerProviderStateMixin {
//   List<String> text = ['Transfer', 'Withdraw', 'Invest', 'Top Up'];

//   List<String> recenttitles = ['Youtube', 'Stripe', 'Google', 'Ovo'];

//   List<IconData> icon = [
//     Icons.arrow_upward,
//     Icons.arrow_downward,
//     Icons.monetization_on,
//     Icons.topic_outlined
//   ];

//   List<IconData> recenticon = [
//     FontAwesomeIcons.youtube,
//     FontAwesomeIcons.stripeS,
//     FontAwesomeIcons.googlePlay,
//     FontAwesomeIcons.stackOverflow,
//   ];

//   List<Color> recentcolors = [
//     Colors.red,
//     Colors.blue,
//     Colors.black,
//     Colors.purple,
//   ];

//   late AnimationController _controller;
//   bool isPlaying = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 300),
//     );
//   }

//   void _toggleAnimation() {
//     if (isPlaying) {
//       _controller.reverse(); // Play to Pause
//     } else {
//       _controller.forward(); // Pause to Play
//     }
//     isPlaying = !isPlaying;
//   }

//   double progress = 0.0;

//   Color getProgressColor(double value) {
//     if (value < 0.33) return Colors.blue;
//     if (value < 0.66) return Colors.orange;
//     return Colors.green;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//       children: [
//         Stack(
//           clipBehavior: Clip.none, // Allows content to overflow
//           alignment: Alignment.center,
//           children: [
//             Container(
//               padding: EdgeInsets.all(20),
//               height: 220,
//               color: Color(0xff16124A),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 40.0),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CircleAvatar(
//                       child: Icon(Icons.person),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Text(
//                       'Hello Helliya\nWelcome back',
//                       style: TextStyle(fontSize: 12, color: Colors.white),
//                     ),
//                     Spacer(),
//                     Badge(
//                       child: Icon(
//                         Icons.notifications,
//                         size: 30,
//                         color: Colors.white,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             Positioned(
//                 right: 10,
//                 left: 10,
//                 bottom: -70,
//                 child: Container(
//                   padding: EdgeInsets.all(15),
//                   decoration: BoxDecoration(
//                     boxShadow: <BoxShadow>[
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.5),
//                         spreadRadius: 2,
//                         blurRadius: 7,
//                         offset: Offset(0, 3), // changes position of shadow
//                       ),
//                     ],
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Your Balance ',
//                         style: TextStyle(fontSize: 20, color: Colors.black),
//                       ),
//                       Text(
//                         '\$41,379,00',
//                         style: Theme.of(context).textTheme.headlineSmall,
//                       ),
//                       Center(
//                         child: SizedBox(
//                           height: 70,
//                           child: ListView.separated(
//                             separatorBuilder: (context, index) {
//                               return SizedBox(
//                                 width: 20,
//                               );
//                             },
//                             scrollDirection: Axis.horizontal,
//                             itemCount: text.length,
//                             itemBuilder: (context, index) {
//                               return _buildchoice(text[index], icon[index]);
//                             },
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   height: 170,
//                 ))
//           ],
//         ),
//         SizedBox(
//           height: 80,
//         ),
//         Text('Recent'),
//         Expanded(
//           child: ListView.builder(
//             padding: EdgeInsets.zero,
//             itemCount: 4,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 subtitle: Text('Transfer'),
//                 trailing: Container(
//                   height: 50,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text('\$15,00'),
//                       Text('14 May 2023'),
//                     ],
//                   ),
//                 ),
//                 title: Text(recenttitles[index]),
//                 leading: Icon(
//                   recenticon[index],
//                   color: recentcolors[index],
//                   size: 30,
//                 ),
//               );
//             },
//           ),
//         ),
//         GestureDetector(
//           child: AnimatedIcon(
//             size: 50,
//             icon: AnimatedIcons.pause_play,
//             progress: _controller,
//           ),
//           onTap: _toggleAnimation,
//         ),
//         CustomPaint(
//           painter: MultiColorProgressPainter(progress),
//         )
//       ],
//     ));
//   }

//   Widget _buildchoice(String text, IconData icon) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Container(
//           height: 40,
//           width: 40,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Colors.purpleAccent,
//           ),
//           child: Center(
//             child: Icon(
//               icon,
//               size: 20,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 5,
//         ),
//         Text(
//           text,
//           style: TextStyle(fontSize: 12, color: Colors.black),
//         )
//       ],
//     );
//   }
// }

// class MultiColorProgressPainter extends CustomPainter {
//   final double progress;

//   MultiColorProgressPainter(this.progress);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final strokeWidth = 10.0;
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = (size.width / 2) - strokeWidth / 2;
//     final rect = Rect.fromCircle(center: center, radius: radius);

//     final totalAngle = 2 * pi;
//     double progressAngle = totalAngle * progress;

//     // Paint background circle
//     final bgPaint = Paint()
//       ..color = Colors.red
//       ..strokeWidth = strokeWidth
//       ..style = PaintingStyle.stroke;

//     canvas.drawCircle(center, radius, bgPaint);

//     // Paint colored segments
//     final segmentPaint = Paint()
//       ..strokeWidth = strokeWidth
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.butt;

//     final segments = [
//       {'color': Colors.red, 'fraction': 0.5},
//       {'color': Colors.blue, 'fraction': 0.25},
//       {'color': Colors.black, 'fraction': 0.25},
//     ];

//     double startAngle = -pi / 2;
//     double drawnAngle = 0;

//     for (var segment in segments) {
//       final segAngle =
//           totalAngle * double.parse(segment['fraction'].toString());
//       final drawThis = min(progressAngle - drawnAngle, segAngle);

//       if (drawThis > 0) {
//         segmentPaint.color = segment['color'] as Color;
//         canvas.drawArc(rect, startAngle, drawThis, false, segmentPaint);
//         startAngle += segAngle;
//         drawnAngle += drawThis;
//       } else {
//         break;
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => true;
// }

// class CustomCurveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.lineTo(0, 0);
//     path.quadraticBezierTo(size.width / 2, 50, size.width, 0); // The curve
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }
