import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'constants.dart';

Future<void> _launchURL(String url) async
{
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
}

final List<String> votingQuestionsFormatted =
[
  "Who can vote?",
];

final List<RichText> votingAnswersFormatted =
[
  RichText
  (
    text: TextSpan
    (
      text: 'Hello ',
      style: TextStyle(color: Colors.black),
      //style: smallDetails,
      children:
      [
        TextSpan(text: 'Any registered voter can vote. If you are not registered to vote, learn about '),
        TextSpan
        (
          text: 'how to register.',
          style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://elections.maryland.gov/voter_registration/application.html")
        ),
      ],
    ),
  )
];