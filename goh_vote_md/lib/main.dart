import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:provider/provider.dart';
import 'providers/location_provider.dart';
import 'providers/county_provider.dart';
import 'providers/calendar_provider.dart';
import 'screens/check_registration.dart';
import 'screens/contact.dart';
import 'screens/calendar.dart';
import 'screens/faqs.dart';
import 'screens/helpful_links.dart';
import 'screens/locations.dart';
import 'screens/misinformation.dart';
import 'widgets/county_dropdown.dart';
import 'widgets/nav_bar.dart';
import 'data/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    MultiProvider(
      providers: [
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
    Dimensions.init(context);
    return MaterialApp(
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
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
  bool _isOnline = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const RegistrationScreen(),
    const CalendarScreen(),
    const Dis_MisinformationScreen(),
    const ContactScreen(),
    const HelpfulLinksScreen(),
    const LocationsScreen(),
    FAQScreen(),
  ];

  void onItemTapped(int index) {
    if (!_isOnline) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'No internet connection. Please connect to continue.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(255, 255, 100, 100),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> checkConnectivity() async {
    final results = await Connectivity().checkConnectivity();
    final online =
        results.isNotEmpty && results.first != ConnectivityResult.none;
    setState(() => _isOnline = online);

    if (!online && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'No internet connection. Please connect to continue using the app.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 4),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await checkConnectivity();

      final county = Provider.of<CountyProvider>(context, listen: false);
      final calendar = Provider.of<CalendarProvider>(context, listen: false);
      final locations = Provider.of<LocationProvider>(context, listen: false);

      county.fetchCountyData();
      calendar.fetchCalendarData();
      locations.initialize();
    });

    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      final hasConnection =
          results.isNotEmpty &&
          results.any((r) => r != ConnectivityResult.none);

      if (!hasConnection) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'You are offline. Please connect to continue.',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 4),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Internet connection restored!',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }

      setState(() => _isOnline = hasConnection);
    });
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: IgnorePointer(
        ignoring: !_isOnline,
        child: Opacity(
          opacity: _isOnline ? 1 : 0.4,
          child: NavBar(
            selectedIndex: _selectedIndex,
            onItemTapped: onItemTapped,
          ),
        ),
      ),
      floatingActionButton: Opacity(
        opacity: _isOnline ? 0.8 : 0.3,
        child: IgnorePointer(
          ignoring: !_isOnline,
          child: SizedBox(
            width: 55,
            height: 55,
            child: FloatingActionButton(
              backgroundColor: MARYLAND_YELLOW,
              child: const Icon(
                Icons.question_mark,
                size: 22,
                color: Colors.white,
              ),
              onPressed: () => onItemTapped(7),
            ),
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
    final homeState = context.findAncestorStateOfType<_HomePageState>();
    final screenHeight = Dimensions.screenHeight;
    final screenWidth = Dimensions.screenWidth;
    final isOnline = homeState?._isOnline ?? true;

    return SafeArea(
      child: AbsorbPointer(
        absorbing: !isOnline,
        child: Opacity(
          opacity: isOnline ? 1.0 : 0.4,
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
                SizedBox(height: screenHeight * 0.006),

                Center(
                  child: Text(
                    "Jared DeMarinis, State Administrator",
                    style: smallDetails,
                  ),
                ),

                SizedBox(height: screenHeight * 0.006),
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
                      child: Text("GO\nVote\nMaryland", style: appName),
                    ),
                  ],
                ),
                Transform.translate(
                  offset: Offset(0, -screenHeight * 0.05),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome!",
                          style: Theme.of(
                            context,
                          ).textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: screenHeight * 0.06,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          "Select one of the options below to get started.",
                          style: TextStyle(fontSize: screenHeight * 0.018),
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        // Row(
                        //   children: [
                        //     Text(
                        //       "Selected county: ",
                        //       style: TextStyle(fontSize: screenHeight * 0.018),
                        //     ),
                        //     const Expanded(child: CountyDropdown()),
                        //   ],
                        // ),
                        SizedBox(height: screenHeight * 0.03),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final double buttonWidth = ((constraints.maxWidth -
                                        screenWidth * 0.04) /
                                    2)
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
                                      onPressed:
                                          () => homeState?.onItemTapped(1),
                                    ),
                                    ElectionButton(
                                      icon: Icons.calendar_today,
                                      label: "Election\nCalendar",
                                      width: buttonWidth,
                                      onPressed:
                                          () => homeState?.onItemTapped(2),
                                    ),
                                    ElectionButton(
                                      icon: Icons.campaign,
                                      label: "Report\nMisInformation",
                                      width: buttonWidth,
                                      onPressed:
                                          () => homeState?.onItemTapped(3),
                                    ),
                                    ElectionButton(
                                      icon: Icons.phone,
                                      label: "Contact",
                                      width: buttonWidth,
                                      onPressed:
                                          () => homeState?.onItemTapped(4),
                                    ),
                                    ElectionButton(
                                      icon: Icons.link,
                                      label: "Helpful Links",
                                      width: buttonWidth,
                                      onPressed:
                                          () => homeState?.onItemTapped(5),
                                    ),
                                    ElectionButton(
                                      icon: Icons.location_on,
                                      label: "Voting\nLocations",
                                      width: buttonWidth,
                                      onPressed:
                                          () => homeState?.onItemTapped(6),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "This app is for voter education purposes and developed in collaboration with the Maryland State Board of Elections",
                                style: TextStyle(fontSize: screenHeight * 0.01),
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.12),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
    final screenHeight = Dimensions.screenHeight;
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: MARYLAND_RED,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.015),
        ),
        onPressed: onPressed,
        icon: Icon(icon, size: homePageIconSize, color: Colors.white),
        label: Text(label, textAlign: TextAlign.center, style: homePageButtons),
      ),
    );
  }
}
