import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:goh_vote_md/providers/location_provider.dart';
import 'package:provider/provider.dart';
import 'providers/county_provider.dart';
import 'providers/calendar_provider.dart';
import 'screens/check_registration.dart';
import 'screens/contact.dart';
import 'screens/calendar.dart';
import 'screens/faqs.dart';
import 'screens/helpful_links.dart';
import 'screens/locations.dart';
import 'screens/dis-misinformation.dart';
import 'widgets/county_dropdown.dart';
import 'widgets/nav_bar.dart';
import 'data/constants.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiProvider
    (
      providers:
      [
        ChangeNotifierProvider(create: (_) => CountyProvider()),
        ChangeNotifierProvider(create: (_) => CalendarProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
      ],
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
      theme: ThemeData(scaffoldBackgroundColor: BACKGROUND),
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
    Dis_MisinformationScreen(),
    ContactScreen(),
    HelpfulLinksScreen(),
    LocationsScreen(),
    FAQScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(()
    {
      final county = Provider.of<CountyProvider>(context, listen: false);
      final calendar = Provider.of<CalendarProvider>(context, listen: false);
      final locations = Provider.of<LocationProvider>(context, listen: false);

      county.fetchCountyData();
      calendar.fetchCalendarData();
      locations.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: NavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: onItemTapped,
      ),

      floatingActionButton: Opacity(
        opacity: 0.8,
        child: SizedBox(
          width: 55, 
          height: 55,
          child: FloatingActionButton(
            backgroundColor: MARYLAND_YELLOW,
            child: const Icon(Icons.question_mark, size: 22, color: Colors.white),
            onPressed: () {
              setState(()
              {
                _selectedIndex = 7;
              });
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,


    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Dimensions.init(context);
    final homeState = context.findAncestorStateOfType<_HomePageState>();
    final screenHeight = Dimensions.screenHeight;
    final screenWidth =  Dimensions.screenWidth;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/title_logo.png',
                height: topLogoSize,
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
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.08,
                    left: screenWidth * 0.04,
                  ),
                  child: Text(
                    "GOH\nVote\nMaryland",
                    style: appName,
                  ),
                ),
              ],
            ),

            Transform.translate(
              offset: Offset(0, -screenHeight * 0.05),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome!",
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: screenHeight * 0.06,
                          ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      "Select a county and an option below",
                      style: TextStyle(fontSize: screenHeight * 0.018),
                    ),
                    SizedBox(height: screenHeight * 0.015),

                    Row(
                      children: [
                        Text(
                          "Selected county: ",
                          style: TextStyle(fontSize: screenHeight * 0.018),
                        ),
                        Expanded(
                          child: CountyDropdown(),
                        ),
                      ],
                    ),

                    SizedBox(height: screenHeight * 0.03),

                    LayoutBuilder(
                      builder: (context, constraints) {
                        final double buttonWidth =
                            ((constraints.maxWidth - screenWidth * 0.04) / 2)
                                .clamp(0, double.infinity);

                        return Column(
                          children: [
                            Wrap(
                              spacing: screenWidth * 0.04,
                              runSpacing: screenHeight * 0.02,
                              alignment: WrapAlignment.center,
                              children: [
                                ElectionButton(
                                  icon: Icons.person,
                                  label: "Check\nRegistration",
                                  width: buttonWidth,
                                  onPressed: () => homeState?.onItemTapped(1),
                                ),
                                ElectionButton(
                                  icon: Icons.calendar_today,
                                  label: "Election\nCalendar",
                                  width: buttonWidth,
                                  onPressed: () => homeState?.onItemTapped(2),
                                ),
                                ElectionButton(
                                  icon: Icons.campaign,
                                  label: "Dis/Mis-\nInformation",
                                  width: buttonWidth,
                                  onPressed: () => homeState?.onItemTapped(3),
                                ),
                                ElectionButton(
                                  icon: Icons.phone,
                                  label: "Contact",
                                  width: buttonWidth,
                                  onPressed: () => homeState?.onItemTapped(4),
                                ),
                                ElectionButton(
                                  icon: Icons.link,
                                  label: "Helpful Links",
                                  width: buttonWidth,
                                  onPressed: () => homeState?.onItemTapped(5),
                                ),
                                ElectionButton(
                                  icon: Icons.location_on,
                                  label:  "Locations",
                                  width: buttonWidth,
                                  onPressed: () => homeState?.onItemTapped(6),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),

                    SizedBox(height: screenHeight * 0.12),
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
    final screenHeight = Dimensions.screenHeight;
    final screenWidth =  Dimensions.screenWidth;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: MARYLAND_RED,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.015),
        ),
        onPressed: onPressed,
        icon: Icon(icon, size: homePageIconSize, color: Colors.white),
        label: Text(
          label,
          textAlign: TextAlign.center,
          style: homePageButtons,
        ),
      ),
    );
  }
}
