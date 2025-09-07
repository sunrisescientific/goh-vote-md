import 'package:flutter/material.dart';
import 'check_registration.dart';
import 'helpful_links.dart';
import 'contact.dart';
import 'faqs.dart';
import 'locations.dart';
import '../widgets/county_dropdown.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Center(
                child: Image.asset(
                  'assets/title_logo.png',
                  height: MediaQuery.of(context).size.height * 0.12,
                  fit: BoxFit.contain,
                ),
              ),

              Stack(
                children: [
                  Image.asset(
                    'assets/top_maryland.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                    opacity: const AlwaysStoppedAnimation(0.5),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
                    child: Text(
                      "Tag Line\n / App\n Name",
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: const Color(0xFFB60022),
                        fontWeight: FontWeight.w700,
                        fontSize: 35,
                      ),
                    ),
                  ),
                ],
              ),
              
              Transform.translate(
                offset: const Offset(0, -40), 
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Text(
                        "Welcome!",
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Select a county and an option below",
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 12),

                      Row(
                        children: [
                          const Text(
                            "Selected county: ",
                            style: TextStyle(fontSize: 14),
                          ),
                          Expanded(
                            child: CountyDropdown(),
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),

                      LayoutBuilder(
                        builder: (context, constraints) {
                          final double buttonWidth = ((constraints.maxWidth - 16) / 2).clamp(0, double.infinity);

                          return Column(
                            children: [
                              
                              Wrap(
                                spacing: 16,
                                runSpacing: 16,
                                alignment: WrapAlignment.center,
                                children: [
                                  ElectionButton(
                                    icon: Icons.person,
                                    label: "Check\nRegistration",
                                    width: buttonWidth,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const RegistrationScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                  ElectionButton(
                                    icon: Icons.calendar_today,
                                    label: "Election\nCalendar",
                                    width: buttonWidth,
                                    onPressed: () {},
                                  ),
                                  ElectionButton(
                                    icon: Icons.list,
                                    label: "FAQs",
                                    width: buttonWidth,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const FAQSScreen(),
                                        ),
                                      );},
                                  ),
                                  ElectionButton(
                                    icon: Icons.phone,
                                    label: "Contact",
                                    width: buttonWidth,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ContactScreen(),
                                          ),
                                        );
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: ElectionButton(
                                      icon: Icons.link,
                                      label: "Helpful Links",
                                      width: buttonWidth,
                                      height: 60,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const HelpfulLinksScreen(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: ElectionButton(
                                      icon: Icons.location_on,
                                      label: "Locations",
                                      width: buttonWidth,
                                      height: 60,
                                      onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LocationsScreen(),
                                        ),
                                      );},
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ElectionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final double width;
  final double height;
  final VoidCallback? onPressed;

  const ElectionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.width,
    this.height = 80,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFB60022),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        onPressed: onPressed,
        icon: Icon(icon, size: 24, color: Colors.white),
        label: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }
}
