import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/county_provider.dart';
import 'home_screen.dart';
import 'contact.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  int _selectedIndex = 1;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dobController = TextEditingController();
  final _zipController = TextEditingController();

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

  Widget _buildInputField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 16, color: Colors.black)),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Type here',
            suffixIcon: controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.cancel, color: Colors.black54),
                    onPressed: () => setState(() => controller.clear()),
                  )
                : null,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 16),
      ],
    );
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
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.06,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/title_logo.png',
                  height: MediaQuery.of(context).size.height * 0.12,
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
                "Check Registration",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: screenHeight * 0.02),

              _buildInputField("First name", _firstNameController),
              _buildInputField("Last name", _lastNameController),
              _buildInputField("Date of birth", _dobController),
              _buildInputField("Zip code", _zipController),

              SizedBox(height: screenHeight * 0.03),

              SizedBox(
                width: screenWidth * 0.7,
                height: screenHeight * 0.06,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Check Registration",
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: const Color(0xFFB60022),
        selectedItemColor: const Color(0xFFFFFFFF),
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
