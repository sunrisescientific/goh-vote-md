import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/county_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home_screen.dart';
import 'check_registration.dart';
import 'contact.dart';

class HelpfulLinksScreen extends StatefulWidget {
  const HelpfulLinksScreen({super.key});

  @override
  State<HelpfulLinksScreen> createState() => _HelpfulLinksScreenState();
}

class _HelpfulLinksScreenState extends State<HelpfulLinksScreen> {
  int _selectedIndex = 0;

  final Map<String, String> helpfulLinks = {
    "Register to Vote": "https://voterservices.elections.maryland.gov/OnlineVoterRegistration/InstructionsStep1",
    "Become a Poll Worker": "https://elections.maryland.gov/get_involved/registration_volunteers.html",
    "Become an Election Judge": "https://elections.maryland.gov/get_involved/election_judges_form.html",
    "Press Releases": "https://elections.maryland.gov/press_room/index.html",
    "Request a Mail-in Ballot": "https://voterservices.elections.maryland.gov/OnlineMailinRequest/InstructionsStep1",
    "Permanent Mail-in": "https://elections.maryland.gov/voting/absentee.html",
  };

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RegistrationScreen()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RegistrationScreen()),
      );
    } else if (index ==3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RegistrationScreen()),
      );
    } else if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ContactScreen()),
      );
    }
  }

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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/title_logo.png',
                  height: screenHeight * 0.12,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: screenHeight * 0.006),
              SizedBox(
                height: screenHeight * 0.05,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB60022),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: 0,
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.pin_drop,
                      color: Colors.white, size: 20),
                  label: Text(
                    selectedCounty.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              const Text(
                "Helpful Links",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              Column(
                children: helpfulLinks.entries.map((entry) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.008),
                    child: SizedBox(
                      width: screenWidth * 0.8,
                      height: screenHeight * 0.08,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 7,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(
                              color: Color(0xFFFFA100),
                              width: 2,
                            ),
                          ),
                        ),
                        onPressed: () => _launchURL(entry.value),
                        child: Text(
                          entry.key,
                          style: const TextStyle(color: Colors.black, fontSize: 23),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: const Color(0xFFB60022),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 40,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Registration'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'FAQs'),
          BottomNavigationBarItem(icon: Icon(Icons.phone), label: 'Contact'),
        ],
      ),
    );
  }
}
