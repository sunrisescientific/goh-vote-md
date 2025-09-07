import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/county_provider.dart';
import '../widgets/contact_card.dart';
import '../widgets/contact_row.dart';
import 'home_screen.dart';
import 'check_registration.dart';
import '../widgets/county_dropdown.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  int _selectedIndex = 4;

  final List<Widget> pages = [
    const HomeScreen(),
    const RegistrationScreen(),
    const RegistrationScreen(),
    const RegistrationScreen(),
    const ContactScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => pages[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final countyProvider = Provider.of<CountyProvider>(context);
    final selectedCounty = countyProvider.selectedCounty;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final stateRows = const [
      ContactRow(icon: Icons.phone, text: "410-269-2840"),
      ContactRow(icon: Icons.mail, text: "info.sbe@maryland.gov"),
      ContactRow(icon: Icons.language, text: "elections.maryland.gov"),
      ContactRow(icon: Icons.pin_drop, text: "151 West Street, Suite 200 \nAnnapolis, MD 21401"),
      ContactRow(icon: Icons.numbers, text: "x.com/md_sbe"),
      ContactRow(icon: Icons.numbers, text: "instagram.com/md_sbe"),
    ];

    Widget countyDropdown = CountyDropdown();

    List<ContactRow> countyRows = countyProvider.selectedCountyContact != null
        ? [
            ContactRow(icon: Icons.phone, text: countyProvider.selectedCountyContact!.phone),
            ContactRow(icon: Icons.mail, text: countyProvider.selectedCountyContact!.email),
            ContactRow(icon: Icons.language, text: countyProvider.selectedCountyContact!.website),
            ContactRow(icon: Icons.pin_drop, text: countyProvider.selectedCountyContact!.address),
          ]
        : [];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
              const Text("Contact", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black)),
              SizedBox(height: screenHeight * 0.02),

              ContactCard(title: "State Board of Election Contact", rows: stateRows),
              if (countyProvider.selectedCountyContact != null)
                ContactCard(title: "${selectedCounty} Election Office Contact", rows: countyRows, dropdown: countyDropdown),
              if (countyProvider.selectedCountyContact == null)
                Container(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  child: ContactCard(
                    title: "State Election Office Contacts",
                    rows: [],
                    dropdown: countyDropdown,
                  ),
                )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: const Color(0xFFB60022),
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(120, 255, 255, 255),
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
