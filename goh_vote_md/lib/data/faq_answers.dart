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
  "When can I vote?",
  "Where should I vote?",
  "How will I cast my vote?",
  "I have a disability. Will I be able to vote?",
  "Are election materials available in languages other than English?",
  "What should I do if I moved since the last election?",
  "Is there a deadline to submit my new address information?",
  "Who can vote early?",
  "When can I vote early?",
  "Where can I vote early?",
  "How will I vote during early voting?",
];

final List<RichText> votingAnswersFormatted =
[
  // "Who can vote?"
  RichText
  (
    text: TextSpan
    (
      text: '',
      style: smallDetails,
      children:
      [
        TextSpan(text: 'Any registered voter can vote. If you are not registered to vote, learn about '),
        TextSpan
        (
          text: 'how to register.',
          style: smallLinks,
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://elections.maryland.gov/voter_registration/application.html")
        ),
      ],
    ),
  ),

  // "When can I vote?"
  RichText
  (
    text: TextSpan
    (
      text: '',
      style: smallDetails,
      children:
      [
        TextSpan(text: 'For the 2026 Gubernatorial Primary Election:\n\n'),
        TextSpan(text: '• You can either vote in person during early voting or on election day or by '),
        TextSpan
        (
          text: 'mail-in ballot.\n',
          style: smallLinks,
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://elections.maryland.gov/voting/absentee.html")
        ),
        TextSpan(text: '• For the 2026 Gubernatorial Primary Election, early voting will be available from Thursday, June 11, 2026 through Thursday, June 18, 2026 (including Saturday and Sunday) from 7 am to 8 pm.\n'),
        TextSpan(text: '• On election day, Tuesday, June 23, 2026, you must vote at your '),
        TextSpan
        (
          text: 'assigned polling place.',
          style: smallLinks,
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://voterservices.elections.maryland.gov/VoterSearch")
        ),
        TextSpan(text: ' All election day polling places are open continuously from 7 am until 8 pm on. Anyone in line at 8 pm will be allowed to vote.\n\n'),
        TextSpan(text: 'If you are unable to vote during early voting or on election day, you may vote by mail-in ballot. '),
        TextSpan
        (
          text: 'Find out more information about mail-in voting.\n',
          style: smallLinks,
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://elections.maryland.gov/voting/absentee.html")
        ),
        TextSpan(text: 'Important Note: The law requires the State Board of Elections and each local board of elections to refer to absentee ballots as "mail-in ballots" and absentee voting as "mail-in voting." Please note that this change in terminology does NOT change the process of mail-in voting.'),
      ],
    ),
  ),

  // "Where should I vote?"
  RichText
  (
    text: TextSpan
    (
      text: '',
      style: smallDetails,
      children:
      [
        TextSpan(text: 'For the 2024 Presidential Primary Election:\n\n'),
        TextSpan(text: '• During '),
        TextSpan
        (
          text: 'early voting,',
          style: smallLinks,
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://elections.maryland.gov/voting/early_voting.html")
        ),
        TextSpan(text: ' you can vote at any early voting center in the jurisdiction where you live.\n'),
        TextSpan(text: '• On election day, you must vote at your '),
        TextSpan
        (
          text: 'assigned polling place.',
          style: smallLinks,
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://voterservices.elections.maryland.gov/VoterSearch")
        ),
      ],
    ),
  ),

  // "How will I cast my vote?"
  RichText
  (
    text: TextSpan
    (
      text: '',
      style: smallDetails,
      children:
      [
        TextSpan(text: 'For the 2024 Presidential Primary Election:\n\n'),
        TextSpan(text: '• During early voting or on election day, you will hand mark a paper ballot. Use the pen provided to fill in the oval next to your choices. You can also mark your ballot electronically. Review your ballot choices, place your voted ballot into the privacy sleeve and take it to the scanner. An election worker will direct you to insert your ballot into the scanning unit to cast your vote. Your ballot will be scanned and dropped into a secure ballot box.\n'),
        TextSpan(text: '• There will be instructions available at the early voting centers and election day polling places to familiarize you with the ballot. You may ask an election judge to explain how to vote, but you must cast your vote alone, unless you are unable to do so because you have a disability or are unable to read or write the English language.\n'),
        TextSpan(text: '• For '),
        TextSpan
        (
          text: 'mail-in voting',
          style: smallLinks,
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://elections.maryland.gov/voting/absentee.html")
        ),
        TextSpan(text: ' and '),
        TextSpan
        (
          text: 'provisional voting,',
          style: smallLinks,
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://elections.maryland.gov/voting/provisional_voting.html")
        ),
        TextSpan(text: ' you will issued a paper ballot. Use a black ink pen to fill in the oval next to your choices. Provisional ballots are returned to the local election office in secure bags on election night. Mail-in and provisional ballots will be scanned at the local election office.'),
      ],
    ),
  ),

  // "I have a disability. Will I be able to vote?"
  RichText
  (
    text: TextSpan
    (
      text: '',
      style: smallDetails,
      children:
      [
        TextSpan(text: 'Yes. All early voting centers in Maryland are accessible to voters with disabilities. '),
        TextSpan(text: 'See '),
        TextSpan
        (
          text: 'Access by Voters with Disabilities',
          style: smallLinks,
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://elections.maryland.gov/voting/accessibility.html")
        ),
        TextSpan(text: ' for more information.'),
      ],
    ),
  ),

  // "Are election materials available in languages other than English?"
  RichText
  (
    text: TextSpan
    (
      text: '',
      style: smallDetails,
      children:
      [
        TextSpan(text: 'Federal law requires Montgomery County and Prince George\'s County to provide election materials in Spanish. Non-English materials may be provided in other jurisdictions on a voluntary basis. Contact your '),
        TextSpan
        (
          text: 'local board of elections',
          style: smallLinks,
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://elections.maryland.gov/about/county_boards.html")
        ),
        TextSpan(text: ' to determine what is available in your jurisdiction.'),
      ],
    ),
  ),

  // "What should I do if I moved since the last election?"
  RichText
  (
    text: TextSpan
    (
      text: '',
      style: smallDetails,
      children:
      [
        TextSpan(text: 'Give the local board of elections where you currently live your new address information. You can use the '),
        TextSpan
        (
          text: 'voter registration application',
          style: smallLinks,
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://elections.maryland.gov/voter_registration/application.html")
        ),
        TextSpan(text: ' to make the change, or you can submit in writing your new address. You can also use the voter registration application to make a name or party affiliation change.\n\n'),
        TextSpan(text: 'If you changed your address with MVA, the change should have been sent to your '),
        TextSpan
        (
          text: 'local board of elections',
          style: smallLinks,
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://elections.maryland.gov/about/county_boards.html")
        ),
        TextSpan(text: ' unless you specifically stated that you did not want your address changed for voter registration purposes. You can verify that your address has been updated by using the '),
        TextSpan
        (
          text: 'voter look-up website.',
          style: smallLinks,
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://voterservices.elections.maryland.gov/VoterSearch")
        ),
        TextSpan(text: ' If you cannot find your information by entering the zip code of your new address, try entering the zip code of your former address. If you find your information using your former address information, it means that your change of address has not been processed. Please contact your '),
        TextSpan
        (
          text: 'local board of elections',
          style: smallLinks,
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://elections.maryland.gov/about/county_boards.html")
        ),
        TextSpan(text: ' or submit a '),
        TextSpan
        (
          text: 'voter registration application',
          style: smallLinks,
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://elections.maryland.gov/voter_registration/application.html")
        ),
        TextSpan(text: ' with your new information.\n\n'),
        TextSpan(text: 'If you do not receive a Voter Notification Card with your new address and polling place information within three to four weeks, contact the '),
        TextSpan
        (
          text: 'local board of elections',
          style: smallLinks,
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://elections.maryland.gov/about/county_boards.html")
        ),
        TextSpan(text: ' where you now live to ensure that your records are up-to-date.'),
      ],
    ),
  ),

  // "Is there a deadline to submit my new address information?"
  RichText
  (
    text: TextSpan
    (
      text: '',
      style: smallDetails,
      children:
      [
        TextSpan(text: 'To update your address before the next election, please use '),
        TextSpan
        (
          text: 'Maryland\'s Online Voter Registration System (OLVR)',
          style: smallLinks,
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://voterservices.elections.maryland.gov/OnlineVoterRegistration")
        ),
        TextSpan(text: ' or submit a '),
        TextSpan
        (
          text: 'voter registration application',
          style: smallLinks,
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://elections.maryland.gov/voter_registration/application.html")
        ),
        TextSpan(text: ' or written notice with your new address at least 21 days before the election. If you can\'t register by that date, go to an early voting center in the county where you live and bring a document that proves where you live. This document can be your MVA-issued license, ID card, or change of address card, or your paycheck, bank statement, utility bill, or other government document with your name and new address.'),
      ],
    ),
  ),

  // "Who can vote early?"
  RichText
  (
    text: TextSpan
    (
      text: '',
      style: smallDetails,
      children:
      [
        TextSpan(text: 'Any person that is registered to vote can vote during early voting. Any person that is eligible to '),
        TextSpan
        (
          text: 'register to vote',
          style: smallLinks,
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://elections.maryland.gov/voter_registration/index.html")
        ),
        TextSpan(text: ' can vote during early voting.\n\n'),
        TextSpan(text: 'Registered voters have always been able to vote during early voting, but now individuals who are eligible but not yet registered can register and vote.\n\n'),
        TextSpan(text: 'To register and vote during early voting, go to an early voting center in the county where you live and bring a document that proves where you live. This document can be your MVA-issued driver license, ID card, or change of address card, or your paycheck, bank statement, utility bill, or other government document with your name and new address. You will be able to register to vote and vote.'),
      ],
    ),
  ),

  // "When can I vote early?"
  RichText
  (
    text: TextSpan
    (
      text: '',
      style: smallDetails,
      children:
      [
        TextSpan(text: 'For the 2026 Gubernatorial Primary Election, early voting will be available from Thursday, June 11, 2026 through Thursday, June 18, 2026 (including Saturday and Sunday) from 7 am to 8 pm.'),
      ],
    ),
  ),

  // "Where can I vote early?"
  RichText
  (
    text: TextSpan
    (
      text: '',
      style: smallDetails,
      children:
      [
        TextSpan(text: 'For both the 2026 Gubernatorial Primary and General Elections, you can vote in an early voting center in the county where you live. The list of early voting centers will be posted when available.'),
      ],
    ),
  ),

  // "How will I vote during early voting?"
  RichText
  (
    text: TextSpan
    (
      text: '',
      style: smallDetails,
      children:
      [
        TextSpan(text: 'Voting during early voting is the same as voting on election day. When you get to the early voting center, you will check in to vote and vote your ballot.\n\n'),
        TextSpan(text: 'Instructions will be available at the early voting centers to familiarize you with the ballot. You may ask an election judge to explain how to vote, but you must cast your vote alone, unless you are unable to do so because you have a disability or are unable to read or write the English language.'),
      ],
    ),
  ),
];