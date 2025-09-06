import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/county_provider.dart';
import 'home_screen.dart';
import 'check_registration.dart';
import 'faqs.dart';
import 'contact.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  int _selectedIndex = 0;
  int _selectedTab = 0; 

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
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FAQSScreen()),
      );
    } else if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ContactScreen()),
      );
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
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: 0,
                    ),
                  ),
                  onPressed: () {
                  },
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
                "Locations",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              TextField(
                decoration: InputDecoration(
                  hintText: "Type address here",
                  suffixIcon: const Icon(Icons.search, color: Color(0xFFFFA100)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFFB60022), width: 3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color(0xFFB60022), width: 3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              Row(
                children: [
                  Expanded(
                    child: _TabButton(
                      text: "Drop Box",
                      isSelected: _selectedTab == 0,
                      onTap: () => setState(() => _selectedTab = 0),
                      isFirst: true,
                      isLast: false,
                    ),
                  ),
                  Expanded(
                    child: _TabButton(
                      text: "Early Voting",
                      isSelected: _selectedTab == 1,
                      onTap: () => setState(() => _selectedTab = 1),
                      isFirst: false,
                      isLast: false,
                    ),
                  ),
                  Expanded(
                    child: _TabButton(
                      text: "Polling Place",
                      isSelected: _selectedTab == 2,
                      onTap: () => setState(() => _selectedTab = 2),
                      isFirst: false,
                      isLast: true,
                    ),
                  ),
                ],
              ),

              // const SizedBox(height: 16),

              SizedBox(
                height: screenHeight * 0.43,
                child: IndexedStack(
                  index: _selectedTab,
                  children: const [
                    DropBoxLocationsList(),
                    Center(child: Text("Early Voting locations here")),
                    Center(child: Text("Polling Place locations here")),
                  ],
                ),
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

class _TabButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isFirst;
  final bool isLast;

  const _TabButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFB60022) : Colors.grey[300],
          border: Border.all(color: Colors.grey[400]!),
          borderRadius: BorderRadius.horizontal(
            left: isFirst ? const Radius.circular(8) : Radius.zero,
            right: isLast ? const Radius.circular(8) : Radius.zero,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class DropBoxLocationsList extends StatelessWidget {
  const DropBoxLocationsList({super.key});

  @override
  Widget build(BuildContext context) {
    final locations = [
      {
        "name": "Activity Center at Bohrer Park",
        "address": "506 South Frederick Avenue\nGaithersburg, MD 20877"
      },
      {"name": "Name", "address": "Address line 1\nCity, State Zip code"},
      {"name": "Name", "address": "Address line 1\nCity, State Zip code"},
      {"name": "Name", "address": "Address line 1\nCity, State Zip code"},
      {"name": "Name", "address": "Address line 1\nCity, State Zip code"},
      {"name": "Name", "address": "Address line 1\nCity, State Zip code"},
    ];
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: screenHeight * 0.43,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFB60022), width: 3),
        boxShadow: const [
          BoxShadow(
            color:  Color(0xFFFFA100),
            offset: Offset(4, 4), 
            blurRadius: 0,     
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: locations.length + 1,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          if (index == locations.length) {
            return TextButton(
              onPressed: () {},
              child: const Text("Show more"),
            );
          }
          final loc = locations[index];
          return ListTile(
            title: Text(
              loc["name"]!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(loc["address"]!),
            trailing: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                  },
                  child: CircleAvatar(
                    radius: 19,
                    backgroundColor: const Color(0xFFB60022),
                    child: const Icon(Icons.map, color: Colors.white, size: 20),
                  ),
                ),
                // const SizedBox(height: 4),
                const Text(
                  "Directions",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

