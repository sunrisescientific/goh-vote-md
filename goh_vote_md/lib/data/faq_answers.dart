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
  "I'm registered to vote, but I need to make a change. Can I make that change during early voting?",
  "Who may vote by mail-in ballot?",
  "How do I request a mail-in ballot?",
  "How do I know if my request for a ballot was received and processed?",
  "Can I have someone pick up my ballot?",
  "How will I receive my mail-in voting ballot?",
  "How do I return my main-in voting ballot?",
  "Is accessible voting available?",
  "Is there a way I mark my mail-in ballot without help?",
  "Can someone help me vote?",
  "Who can I contact if I have an accessibility question or concern?",
];

final List<RichText> votingAnswersFormatted =
[
  RichText
  (
    text: TextSpan
    (
      text: '',
      style: smallDetails,
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
  ), 

  RichText
  (
    text: TextSpan
    (
      text: '',
      style: smallDetails,
      children:
      [
        TextSpan(text: 'It depends.\n\n'
          'If you moved, you can update your address. You will be able to change your address and vote.\n\n'
          'If you want to change your party affiliation, you can\'t do that at an early voting center. You must wait until after the election to change your party affiliation.\n\n'
          'If you changed your name, you must vote under your former name, but you can fill out a form with your new name. Your name will be updated after the election.'
        ),
      ],
    ),
  ),

  RichText
  (
    text: TextSpan
    (
      text: '',
      style: smallDetails,
      children:
      [
        TextSpan(text: 'Any registered voter may vote by mail-in ballot. You don\'t need a reason to vote by mail-in ballot. It\'s another way to vote if you don\'t want to or can\'t go to an early voting center or your polling place.\n\n'
          'If you do not know if you are registered to vote, use our '
        ),
        TextSpan
        (
          text: 'Voter Look-up',
          style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://voterservices.elections.maryland.gov/VoterSearch")
        ),
        TextSpan(text: 'to find out. If you are not registered to vote, find out '),
        TextSpan
        (
          text: 'how to register to vote.',
          style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://elections.maryland.gov/voter_registration/application.html")
        ),
        TextSpan(text: '\n\nIMPORTANT: If you want to vote in-person, please do not sign up for mail-in voting. Once we issue your mail-in ballot, if you later change your mind and show up to vote in-person you will have to vote a provisional ballot')
      ],
    ),
  ),



  RichText
  (
    text: TextSpan
    (
      text: '',
      style: smallDetails,
      children:
      [
        TextSpan(text: 'There are three ways you can request a mail-in ballot:\n\n'
        '•	'),
        TextSpan
        (
          text: '•	Go Online if you have a Maryland’s driver’s license or MVA-issued ID card.',
          style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://voterservices.elections.maryland.gov/onlinemailinrequest/InstructionsStep1")
        ),
        TextSpan(text: '\n'),

        TextSpan(text: '•	  Complete and return one of the forms below. Read the instructions, enter the required information, print the form, sign it, and return it to your local board of elections. You can return it by mail, fax, in-person, or email with an attached image of your signed request to your local board. Your signature is required on any returned request.\n'
        '\t\t\t\t•	'),
        TextSpan
        (
          text: 'Mail-in Ballot Application (PDF)',
          style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://elections.maryland.gov/voting/documents/Mail-in%20Ballot%20Application_English.pdf")
        ),
        TextSpan(text: '\n'),

        TextSpan(text: '\t\t\t\t•	  '),
        TextSpan
        (
          text: 'Solicitud de Papeleta de Votante Ausente (PDF)',
          style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://elections.maryland.gov/voting/documents/Mail-in%20Ballot%20Application_Spanish.pdf")
        ),
        TextSpan(text: '\n'),

        TextSpan(text: '•	  Go to your '),
        TextSpan
        (
          text: 'local board of elections',
          style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://elections.maryland.gov/about/county_boards.html")
        ),
        TextSpan(text: ' and receive a mail-in ballot in person.\n\n'),

        TextSpan(text: 'If you want to get a mail-in ballot for all future elections, you can sign up for the permanent mail-in ballot list when you request a mail-in ballot. Once you are on this list, we will send you your mail-in ballot for each future election you are eligible to vote in. You won\'t have to submit a request for each election.\n\n'
          'Please note: Requests for mail-in ballots may take approximately a week to process.\n\n'
          'IMPORTANT: If you want to vote in-person, please do not sign up for mail-in voting. Once we issue your mail-in ballot, if you later change your mind and show up to vote in-person you will have to vote a provisional ballot.'
        )
      ],
    ),
  ),

  RichText
  (
    text: TextSpan
    (
      text: '',
      style: smallDetails,
      children:
      [
        TextSpan(text: 'Visit the '),
        TextSpan
        (
          text: 'voter look-up website',
          style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://voterservices.elections.maryland.gov/VoterSearch")
        ),
        TextSpan(text: ' to verify if your '),
        TextSpan
        (
          text: 'local board of elections ',
          style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://elections.maryland.gov/about/county_boards.html")
        ),
        TextSpan(text: ' received your request for a ballot and the status of your mail-in ballot. If you have more questions, please contact your '),
        TextSpan
        (
          text: 'local board of elections.',
          style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://elections.maryland.gov/about/county_boards.html")
        ),
      ],
    ),
  ),

  RichText
  (
    text: TextSpan
    (
      text: '',
      style: smallDetails,
      children:
      [
        TextSpan(text: 'Yes. You can designate someone to be your agent. This person will take your completed mail-in ballot application to your '),
        TextSpan
        (
          text: 'local board of elections',
          style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("elections.maryland.gov/about/county_boards.html")
        ),
        TextSpan(text: ', pick up your ballot, and deliver it to you. To get your ballot this way, you and your agent must complete the '),
        TextSpan
        (
          text: 'mail-in ballot: Designation of Agent Form',
          style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://elections.maryland.gov/voting/documents/Designation_of_Agent_Form_Mail-In_Ballot_English.pdf")
        ),
        TextSpan(text: ' '),
        TextSpan
        (
          text: '(Papeleta de Votante Ausente: Formulario para Designar un Representante)',
          style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://elections.maryland.gov/voting/documents/2010_Designation_of_Agent_Form_Spanish.pdf")
        ),
        TextSpan(text: '. This form can also be obtained from your '),
        TextSpan
        (
          text: ' local board of elections.',
          style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://elections.maryland.gov/about/county_boards.html")
        ),
      ],
    ),
  ),

  RichText
  (
    text: TextSpan
    (
      text: '',
      style: smallDetails,
      children:
      [
        TextSpan(text: 'You decide how you want to receive your ballot. You can receive it:\n\n'
          '•	By mail. We can send it to your home or where you’ll be when ballots are sent out about 30-45 days before an election\n'
          '•	By a link in an email. We will send you an email about 30-45 days before the election with a link to your ballot. Please note:\n'
          '\t\t\t\t•	You will need to create an online username and password to access and download your ballot materials.\n'
          '\t\t\t\t•	You will need to print out your ballot and oath, and provide your own return envelope.\n'
          '\t\t\t\t•	You will need to return your voted ballot and signed oath by mail (requires postage), ballot dropbox, or in person - You cannot return your voted ballot online, by email, or fax.\n'
          '\t\t\t\t•	Election workers will duplicate your voting choices onto ballot materials that are scannable.\n\n'
          'Please note: Requests for mail-in ballots may take approximately a week to process.'

        ),
      ],
    ),
  ),

  RichText
  (
    text: TextSpan
    (
      text: '',
      style: smallDetails,
      children:
      [
        TextSpan(text: 'You must return your ballot, in a properly addressed envelope, by mail, ballot dropbox, or hand delivery\n\n'
          'IMPORTANT: You can not return your voted ballot online, by email, or fax\n\n'
          'We recommend that you return your ballot as soon as you have voted it, if you:\n\n'
          '•	Mail your ballot, your ballot must be postmarked on or before election day\n'
          '•	Use a ballot dropbox, your ballot must be in a ballot dropbox by 8pm on Election Day. The ballot dropbox locations are included when we send you your ballot\n'
          '•	Hand deliver your ballot, you must deliver your ballot by 8 pm on election day\n\n'
          'All mail-in ballots must be returned in an envelope (please use the return envelope we mailed you, or use the envelope template we include with ballots sent by emailed link)'

        ),
      ],
    ),
  ),

  RichText
  (
    text: TextSpan
    (
      text: '',
      style: smallDetails,
      children:
      [
        TextSpan(text: 'Yes, a ballot marking device that is accessible to most voters is available at all voting locations in early voting centers and polling places. Using a headset and keypad, blind voters and voters with low vision are able to vote by listening to the ballot selections and by using the keypad. You may also choose to use the high contrast and large print functions of the voting unit. Other assistive devices (for example, sip and puff) can be plugged into the device.\n\n'
        'If you want to use the audio ballot, ask an election judge. Election judges will answer questions and help you, if needed.'
        ),
      ],
    ),
  ),

  RichText
  (
    text: TextSpan
    (
      text: '',
      style: smallDetails,
      children:
      [
        TextSpan(text: 'Yes. '),
        TextSpan
        (
          text: 'Request a mail-in ballot online',
          style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://voterservices.elections.maryland.gov/onlinemailinrequest/InstructionsStep1")
        ),
        TextSpan(text: 
        '. When completing the application to request a ballot, select the option to receive a ballot in the mail or access to your ballot through email. If you select email, we will send you an email when your ballot is ready. The email will include a link with instructions to access our online ballot delivery system.\n\n'
        'If you select an emailed ballot, you have the options to mark your ballot online using an accessible online ballot marking tool. If you use this tool, you make your choices on your computer and print your ballot. Your printed ballot will have your choices marked. With this tool, most voters with disabilities can make selections without help. If you do not choose to use the marking tool, you can download and print your ballot and mark your selections by hand.\n\n'
        'Your voted ballot must be printed and returned to your local election office by mail, by ballot drop box, or in person. If you return your voted ballot by email or fax, it will not count. There is no electronic ballot return in Maryland.\n'
        ),
      ],
    ),
  ),

  RichText
  (
    text: TextSpan
    (
      text: '',
      style: smallDetails,
      children:
      [
        TextSpan(text: 'Yes. You can bring someone to help you vote as long as that person is not:\n\n'
          '•	Your employer or an agent of your employer\n'
          '•	An officer or agent of your union\n'
          '•	A challenger or watcher\n\n'
          'Or, you may choose to have two election judges help you.\n'
        ),
      ],
    ),
  ),

  RichText
  (
    text: TextSpan
    (
      text: '',
      style: smallDetails,
      children:
      [
        TextSpan(text: 'You can find your local board of elections contact information '),
        TextSpan
        (
          text: 'here',
          style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://elections.maryland.gov/about/county_boards.html")
        ),
        TextSpan(text: '. You can also email us with attention to Election Reform at the State Board of Elections.'),
      ],
    ),
  ),
];