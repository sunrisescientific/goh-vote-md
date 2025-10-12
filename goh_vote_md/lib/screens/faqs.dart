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
    "Where do I go to vote?",
    "How is the voting unit accessible to voters with disabilities?",
    "What are the ways I can vote in Maryland?",
    "What forms of ID do I need to show when I vote?"
  ];

  final List<String> votingAnswers =
  [
    "Your polling place location is printed on your Voter Notification Card. If you do not have your Voter Notification Card, please visit the Polling Place Look-up.",
    "Unlike other voting systems, DRE voting systems allow most voters with disabilities to vote a secret ballot. The State's voting system accommodates voters with disabilities by offering:\n\n"
    "• An audio ballot. Using headphones, the voter listens to the ballot and records the vote using a keypad. Both the headphones and keypad are provided. To assure the privacy of the voter, the voting unit's screen is blank while the audio ballot feature is being used.\n"
    "• A magnified ballot for voters who have low vision.\n"
    "• A high contrast ballot for voters with visual impairments.\n"
    "• An adjustable screen to accommodate voters who prefer or need to sit while voting.\n\n"
    "To use an audio ballot just ask an election judge for the particular option. You will not be required to provide an explanation or fill out additional paperwork. Election judges will be available to answer questions and, if needed, provide assistance.\n\n"
    "If you need assistance voting, you may select someone to assist in the voting process. Maryland law prohibits a voter's employer or agent of the employer or an officer or agent of the voter's union from serving as a voter's assistant. An election judge may assist a voter, but only in the presence of another election judge of a different political party.",
    "You can vote in person during Early Voting, in person on Election Day at your assigned polling place, or by mail via a mail-in ballot (formerly called absentee ballot).",
    "For first-time Maryland voters, or if the polling officials require verification, you may need to show either:\n"
    "• A current valid photo ID (Maryland DMV license, MVA-issued ID, student/employee/military ID, U.S. passport, etc.)\n"
    "• A current (within 3 months) utility bill, bank statement, government check, paycheck, or other government document showing your name and address."
  ];

  final List<String> involvedQuestions =
  [
    "How to become a poll worker?",
    "How to become an election judge?",
  ];

  final List<String> involvedAnswers =
  [
    "To become a poll worker (Election Judge) in Maryland:\n"
      "• Apply through your local Board of Elections (forms are usually online).\n"
      "• Be a registered voter in Maryland.\n"
      "• Be able to read, write, and speak English clearly.\n"
      "• Complete required training before the election.\n"
      "• Work all day on Election Day (hours are typically from before polls open until after they close).\n"
      "• Some counties also allow high school students (16 years or older) to serve in limited roles "
    "through student worker or 'Future Vote' programs.\n\n"
    "Poll workers may receive compensation. Contact your county’s Board of Elections for exact "
    "requirements, application forms, and pay details.",
    
    "As an election judge, you will set up and break down the polling place, check in and assist voters, and oversee election procedures, playing a vital role in upholding the integrity of the electoral process and voters' fundamental right to vote."

    "\nTo qualify as an election judge, you must meet the following minimum requirements:"

    "\n\t• Be 1​6 years old or older.*"
    "\n\t• Be a registered voter in the State of Maryland."
    "\n\t• Be able to speak, read, and write English."
    "\n\t• Be physically and mentally able to work at least a 15-hour day."
    "\n\t• Be willing to work outside your home precinct."
    "\n\t• Be able to sit and/or stand for an extended period.",

    "\n If you are interested in contributing to the democratic process and serving your community in this important role, please complete the application here."
  ];

  final List<String> registrationQuestions =
  [
    "Where can I register?",
    "Who is eligible to register to vote in Maryland?",
    "When is the deadline to register or change my registration?" 
  ];

  final List<String> registrationAnswers =
  [
    "You can register:\n"
      "• Online using Maryland’s Online Voter Registration System\n"
      "• By mailing a paper application\n"
      "• In person at local election offices, the State Board of Elections, MVA, "
      "or other designated agencies.",
    "You must:\n"
      "• Be a U.S. citizen\n"
      "• Be a Maryland resident\n"
      "• Be at least 16 years old (you must be 18 by the next general election to vote)\n"
      "• Not be under guardianship for mental disability if a court has ruled you cannot vote\n"
      "• Not have been convicted of buying or selling votes\n"
      "• Not be currently serving a court-ordered prison sentence for a felony.",
      "The deadline is 21 days before an election.\n"
      "You may also register or update your information during Early Voting or on Election Day "
      "if you bring proof of residence.",

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
