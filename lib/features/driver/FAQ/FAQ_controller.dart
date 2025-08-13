// faq_controllerimport 'package:get/get.dart';


import 'package:get/get.dart';

class FAQController extends GetxController {
  var expandedIndex = (-1).obs;

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
    }
  ];
}
