// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:taxi_driver/features/driver/FAQ/FAQ_Controller.dart';


// class FAQScreen extends StatelessWidget {
//   const FAQScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final FAQController controller = Get.put(FAQController());

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('FAQ'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Get.back(),
//         ),
//       ),
//       body: Obx(() {
//         return ListView.builder(
//           itemCount: controller.faqItems.length,
//           itemBuilder: (_, index) {
//             final expanded = controller.expandedIndex.value == index;
//             return ExpansionTile(
//               initiallyExpanded: expanded,
//               onExpansionChanged: (val) {
//                 controller.expandedIndex.value = val ? index : -1;
//               },
//               title: Text(controller.faqItems[index]['question']!),
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(controller.faqItems[index]['answer']!),
//                 ),
//               ],
//             );
//           },
//         );
//       }),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/core/widgets/custom_appbar.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  int expandedIndex = -1;

  final faqItems = [
    {
      'question': 'Lorem Ipsum is simply dummy text?',
      'answer':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'
    },
    {'question': 'Typesetting industry?', 'answer': 'Yes, it is related.'},
    {
      'question': 'Industry’s standard dummy text ever?',
      'answer': 'It has been since the 1500s.'
    },
    {
      'question': 'Lorem Ipsum is simply dummy text?',
      'answer': 'Indeed, it is dummy text.'
    },
    {
      'question': 'Text of the printing and type?',
      'answer': 'It is for printing and type testing.'
    },
    {
      'question': 'Ipsum is simply dummy text?',
      'answer': 'Yes, again it is dummy text.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: 'FAQ'),
      body: ListView.builder(
        itemCount: faqItems.length,
        itemBuilder: (_, index) {
          final expanded = expandedIndex == index;
          return ExpansionTile(
            initiallyExpanded: expanded,
            onExpansionChanged: (val) {
              setState(() {
                expandedIndex = val ? index : -1;
              });
            },
            title: Text(faqItems[index]['question']!),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(faqItems[index]['answer']!),
              ),
            ],
          );
        },
      ),
    );
  }
}
