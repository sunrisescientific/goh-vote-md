import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/county_provider.dart';

class ExpandableSection extends StatefulWidget
{
  final String title;
  final String content;

  const ExpandableSection
  (
    {
      required this.title,
      required this.content,
    }
  );

  @override
  State<ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection>
{
  bool _expanded = false;

  @override
  Widget build(BuildContext context)
  {
    return Padding
    (
      padding: EdgeInsets.only(bottom: 12),
      child: Container
      (
        decoration: BoxDecoration
        (
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 1),
          boxShadow:
          [
            BoxShadow
            (
              color: Color.fromARGB(255, 196, 196, 196),
              spreadRadius: 0.5,
              blurRadius: 2,
              offset: Offset(2.5, 2.5),
            ),
          ],
        ),
        child: Column
        (
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            TextButton
            (
              onPressed: () {
                setState(()
                {
                  _expanded = !_expanded;
                });
              },
              style: TextButton.styleFrom
              (
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: SizedBox
              (
                width: double.infinity,
                child: Stack
                (
                  children:
                  [
                    Padding
                    (
                      padding: EdgeInsets.only(right: 32),
                      child: Text
                      (
                        widget.title,
                        style: TextStyle
                        (
                          fontSize: 16,
                          color: Colors.black,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400
                        ),
                        softWrap: true,
                      ),
                    ),
                    Positioned
                    (
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Center
                      (
                        child: Icon
                        (
                          _expanded ? Icons.remove : Icons.add,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            AnimatedCrossFade
            (
              duration: const Duration(milliseconds: 100),
              crossFadeState: _expanded
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: Padding
              (
                padding: const EdgeInsets.only(left: 16.0, bottom: 8),
                child: Text(widget.content),
              ),
              secondChild: const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}

class FAQCategory extends StatelessWidget
{
  final String title;
  final List<String> questions;
  final List<String> answers;

  const FAQCategory
  ({
    required this.title,
    required this.questions,
    required this.answers,
  });

  @override
  Widget build(BuildContext context)
  {
    return Column
    (
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Text
        (
          title,
          style: const TextStyle
          (
            color: Color(0xFFB60022),
            fontFamily: 'Inter',
            fontSize: 24,
            fontWeight: FontWeight.w600,
            shadows:
            [
              Shadow
              (
                offset: Offset(2, 2),
                blurRadius: 8,
                color: Color.fromARGB(255, 205, 204, 204),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Column
        (
          children: List.generate(questions.length, (index)
          {
            return ExpandableSection
            (
              title: questions[index],
              content: answers[index],
            );
          }),
        ),
        SizedBox(height: 14),
      ],
    );
  }
}

class FAQScreen extends StatelessWidget
{
  final List<String> votingQuestions =
  [
    "Question 1",
    "Question 2",
    "Question 3",
  ];

  final List<String> votingAnswers =
  [
    "Answer 1",
    "Answer 2",
    "Answer 3",
  ];

  final List<String> involvedQuestions =
  [
    "How to become a poll worker?",
    "How to become an election judge?",
    "Question 3",
  ];

  final List<String> involvedAnswers =
  [
    "Answer 1",
    "Answer 2",
    "Answer 3",
  ];

  final List<String> registrationQuestions =
  [
    "Where can I register?",
    "Question 2",
  ];

  final List<String> registrationAnswers =
  [
    "Answer 1",
    "Answer 2",
  ];

  @override
  Widget build(BuildContext context)
  {
    final countyProvider = Provider.of<CountyProvider>(context);
    final selectedCounty = countyProvider.selectedCounty;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
        // padding: const EdgeInsets.only(left: 24, right: 24),
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
        child: Column
        (
          crossAxisAlignment: CrossAxisAlignment.center,
          children:
          [
            Center(
                child: Image.asset('assets/title_logo.png', height: screenHeight * 0.12, fit: BoxFit.contain),
              ),
              SizedBox(height: screenHeight * 0.006),
              SizedBox(
                height: screenHeight * 0.05,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB60022),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 0),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.pin_drop, color: Colors.white, size: 20),
                  label: Text(selectedCounty.toUpperCase(),
                      style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              const Text("FAQs", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black)),
              SizedBox(height: screenHeight * 0.02), 
            FAQCategory
            (
              title: "Voting",
              questions: votingQuestions,
              answers: votingAnswers,
            ),
            FAQCategory
            (
              title: "Getting Involved",
              questions: involvedQuestions,
              answers: involvedAnswers,
            ),
            FAQCategory
            (
              title: "Registration",
              questions: registrationQuestions,
              answers: registrationAnswers,
            ),
          ],
        ),
      ),
    ));
  }
}
