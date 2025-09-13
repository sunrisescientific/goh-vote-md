import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/county_provider.dart';
import 'screens/check_registration.dart';
import 'screens/contact.dart';
import 'screens/calendar.dart';
import 'screens/faqs.dart';
import 'screens/helpful_links.dart';
import 'screens/locations.dart';
import 'widgets/county_dropdown.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CountyProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    RegistrationScreen(),
    CalendarScreen(),
    FAQScreen(),
    ContactScreen(),
    HelpfulLinksScreen(),
    LocationsScreen()
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: const Color(0xFFB60022),
          indicatorColor: Colors.transparent,
          iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(
            (states) {
              if (states.contains(WidgetState.selected)) {
                return const IconThemeData(
                    color: Color(0xFFFFFFFF), size: 40); 
              }
              return const IconThemeData(
                  color: Color(0x88E5E5E5), size: 40); 
            },
          ),
        ),
        child: _selectedIndex == 0
            ? const SizedBox(height: 0)
            : NavigationBar(
                selectedIndex: _selectedIndex,
                onDestinationSelected: onItemTapped,
                labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
                labelTextStyle: MaterialStateProperty.all(
                  const TextStyle(
                    fontSize: 11, 
                    color: Colors.white, 
                  ),
                ),
                destinations: const [
                  NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
                  NavigationDestination(
                      icon: Icon(Icons.person), label: 'Look up'),
                  NavigationDestination(
                      icon: Icon(Icons.calendar_month), label: 'Calendar'),
                  NavigationDestination(
                      icon: Icon(Icons.list), label: 'FAQ'),
                  NavigationDestination(
                      icon: Icon(Icons.phone), label: 'Contact'),
                  NavigationDestination(
                      icon: Icon(Icons.link), label: 'Links'),
                  NavigationDestination(
                      icon: Icon(Icons.location_on), label: 'Locations'),
                ],
              ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeState = context.findAncestorStateOfType<_HomePageState>();

    return SafeArea(
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
                const Padding(
                  padding: EdgeInsets.only(top: 100, left: 20, right: 20),
                  child: Text(
                    "Tag Line\n / App\n Name",
                    style: TextStyle(
                      color: Color(0xFFB60022),
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
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(
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
                        final double buttonWidth =
                            ((constraints.maxWidth - 16) / 2)
                                .clamp(0, double.infinity);

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
                                  onPressed: () =>
                                      homeState?.onItemTapped(1),
                                ),
                                ElectionButton(
                                  icon: Icons.calendar_today,
                                  label: "Election\nCalendar",
                                  width: buttonWidth,
                                  onPressed: () =>
                                      homeState?.onItemTapped(2),
                                ),
                                ElectionButton(
                                  icon: Icons.list,
                                  label: "FAQs",
                                  width: buttonWidth,
                                  onPressed: () =>
                                      homeState?.onItemTapped(3),
                                ),
                                ElectionButton(
                                  icon: Icons.phone,
                                  label: "Contact",
                                  width: buttonWidth,
                                  onPressed: () =>
                                      homeState?.onItemTapped(4),
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
                                    onPressed: ()  =>
                                      homeState?.onItemTapped(5),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: ElectionButton(
                                    icon: Icons.location_on,
                                    label: "Locations",
                                    width: buttonWidth,
                                    height: 60,
                                   onPressed: () =>
                                      homeState?.onItemTapped(6),
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
