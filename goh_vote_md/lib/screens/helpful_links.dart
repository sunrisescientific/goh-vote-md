import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/county_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/screen_header.dart';
import '../data/constants.dart';

class HelpfulLinksScreen extends StatefulWidget {
  const HelpfulLinksScreen({super.key});

  @override
  State<HelpfulLinksScreen> createState() => _HelpfulLinksScreenState();
}

class _HelpfulLinksScreenState extends State<HelpfulLinksScreen> {

  final Map<String, String> helpfulLinks = {
    "Register to Vote": "https://voterservices.elections.maryland.gov/OnlineVoterRegistration/InstructionsStep1",
    "Become a Poll Worker": "https://elections.maryland.gov/get_involved/registration_volunteers.html",
    "Elections News and Updates": "https://elections.maryland.gov/press_room/index.html",
    "Request a Mail-in Ballot": "https://voterservices.elections.maryland.gov/OnlineMailinRequest/InstructionsStep1",
  };

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context) {
    final countyProvider = Provider.of<CountyProvider>(context);
    final selectedCounty = countyProvider.selectedCounty;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.screenWidth * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ScreenHeader(
                logoPath: 'assets/title_logo.png',
                countyName: selectedCounty,
                title: "Helpful Links",
              ),

              Column(
                children: helpfulLinks.entries.map((entry) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.screenHeight * 0.008),
                    child: SizedBox(
                      width: Dimensions.screenWidth * 0.8,
                      height: Dimensions.screenHeight * 0.08,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 7,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                            side: const BorderSide(
                              color: MARYLAND_YELLOW,
                              width: 2,
                            ),
                          ),
                        ),
                        onPressed: ()  =>
                        _launchURL(entry.value),
                        child: Text(
                          entry.key,
                          style: heading2,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
