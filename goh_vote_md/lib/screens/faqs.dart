import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/county_provider.dart';
import '../widgets/screen_header.dart';
import '../data/constants.dart';

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
      padding: EdgeInsets.only(bottom: 14),
      child: Container
      (
        width: expandableBoxSize,
        decoration: BoxDecoration
        (
          color: Colors.white,
          border: Border.all(color: MARYLAND_YELLOW, width: 1.5),
          boxShadow: [greyBoxShadow]
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
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
                        style: heading3,
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
                child: Text(widget.content, style: smallDetails),
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
          style: heading2
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

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
        // padding: const EdgeInsets.only(left: 24, right: 24),
        padding: EdgeInsets.symmetric(horizontal: Dimensions.screenWidth * 0.06),
        child: Column
        (
          crossAxisAlignment: CrossAxisAlignment.center,
          children:
          [
            ScreenHeader(
              logoPath: 'assets/title_logo.png',
              countyName: selectedCounty,
              title: "FAQs",
            ),
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
