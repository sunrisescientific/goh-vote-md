import 'dart:io' show Platform;
import 'dart:math' show cos, sqrt, asin, pi, sin;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../providers/county_provider.dart';
import '../providers/location_provider.dart';
import '../widgets/screen_header.dart';
import '../widgets/county_dropdown.dart';
import '../data/constants.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  int _selectedTab = 0;
  String _searchAddress = "";
  double? _searchLat;
  double? _searchLng;
  final TextEditingController _searchController = TextEditingController();

  Future<void> _updateSearch(String query) async {
    setState(() => _searchAddress = query);
    if (query.isNotEmpty) {
      try {
        final results = await locationFromAddress(query);
        if (results.isNotEmpty) {
          setState(() {
            _searchLat = results.first.latitude;
            _searchLng = results.first.longitude;
          });
        }
      } catch (e) {
        debugPrint("Geocoding failed: $e");
      }
    }
  }

  Future<void> _useCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location services are disabled.")),
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Location permission denied.")),
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Location permissions are permanently denied."),
          ),
        );
        return;
      }

      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _searchLat = pos.latitude;
        _searchLng = pos.longitude;
        _searchAddress = "My Current Location";
        _searchController.text = "";
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Sorted by current location.")),
      );
    } catch (e) {
      debugPrint("Error getting current location: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to get current location.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    final dropBox = locationProvider.dropboxLocations;
    final earlyVoting = locationProvider.earlyLocations;
    final countyProvider = Provider.of<CountyProvider>(context);
    final selectedCounty = countyProvider.selectedCounty;
    final screenWidth = Dimensions.screenWidth;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ScreenHeader(
                logoPath: 'assets/title_logo.png',
                countyName: selectedCounty,
                title: "Voting Locations",
              ),

              Row(
                children: [
                  Expanded(
                    child: _TabButton(
                      text: "Polling Place",
                      isSelected: _selectedTab == 0,
                      onTap: () => setState(() => _selectedTab = 0),
                      isFirst: true,
                    ),
                  ),
                  Expanded(
                    child: _TabButton(
                      text: "Drop Box",
                      isSelected: _selectedTab == 1,
                      onTap: () => setState(() => _selectedTab = 1),
                    ),
                  ),
                  Expanded(
                    child: _TabButton(
                      text: "Early Voting",
                      isSelected: _selectedTab == 2,
                      onTap: () => setState(() => _selectedTab = 2),
                      isLast: true,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              if (_selectedTab == 1 || _selectedTab == 2)
                Column(
                  children: [
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "Type address here",
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.search,
                            color: MARYLAND_YELLOW,
                          ),
                          onPressed:
                              () => _updateSearch(_searchController.text),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: MARYLAND_RED,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(roundedCorners),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: MARYLAND_RED,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(roundedCorners),
                        ),
                      ),
                      onSubmitted: _updateSearch,
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.485,
                          child: ElevatedButton.icon(
                            onPressed: _useCurrentLocation,
                            icon: const Icon(
                              Icons.my_location,
                              color: Colors.white,
                            ),
                            label: const Text(
                              "Use My Current Location",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MARYLAND_RED,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  roundedCorners,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 5),

                        CountyDropdown(),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),

              Expanded(
                child:
                    locationProvider.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : _selectedTab == 0
                        ? const PollingPlace()
                        : _selectedTab == 1
                        ? DropBoxLocationsList(
                          locations:
                              selectedCounty == "County"
                                  ? dropBox
                                  : dropBox
                                      .where(
                                        (loc) =>
                                            loc['county'] == selectedCounty,
                                      )
                                      .toList(),
                          searchLat: _searchLat,
                          searchLng: _searchLng,
                        )
                        : EarlyVotingLocationsList(
                          locations:
                          selectedCounty == "County"
                          ? earlyVoting :
                              earlyVoting
                                  .where(
                                    (loc) => loc['county'] == selectedCounty,
                                  )
                                  .toList(),
                          searchLat: _searchLat,
                          searchLng: _searchLng,
                        ),
              ),
            ],
          ),
        ),
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
          color: isSelected ? MARYLAND_RED : Colors.grey[300],
          border: Border.all(color: Colors.grey[400]!),
          borderRadius: BorderRadius.horizontal(
            left: isFirst ? const Radius.circular(roundedCorners) : Radius.zero,
            right: isLast ? const Radius.circular(roundedCorners) : Radius.zero,
          ),
        ),
        child: Center(
          child: Text(text, style: isSelected ? heading3Selected : heading3),
        ),
      ),
    );
  }
}

class LocationList extends StatelessWidget {
  final List<Map<String, String>> locations;
  final bool showMore;

  const LocationList({
    super.key,
    required this.locations,
    this.showMore = false,
  });

  Future<void> _openMaps(String address) async {
    final query = Uri.encodeComponent(address);
    final Uri appleUrl = Uri.parse("http://maps.apple.com/?q=$query");
    final Uri googleUrl = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$query",
    );

    try {
      if (Platform.isIOS) {
        await launchUrl(appleUrl, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(googleUrl, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint("Error opening maps: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: MARYLAND_RED, width: 3),
        boxShadow: const [
          BoxShadow(
            color: MARYLAND_YELLOW,
            offset: Offset(4, 4),
            blurRadius: 0,
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: locations.length + (showMore ? 1 : 0),
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          if (showMore && index == locations.length) {
            return const SizedBox.shrink();
          }

          final loc = locations[index];
          return ListTile(
            title: Text(loc["name"]!, style: heading3),
            subtitle: Text(loc["address"]!),
            trailing: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => _openMaps(loc["address"]!),
                  child: CircleAvatar(
                    radius: 19,
                    backgroundColor: MARYLAND_RED,
                    child: const Icon(Icons.map, color: Colors.white, size: 20),
                  ),
                ),
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

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const earthRadius = 6371;
  final dLat = (lat2 - lat1) * (pi / 180);
  final dLon = (lon2 - lon1) * (pi / 180);
  final a =
      sin(dLat / 2) * sin(dLat / 2) +
      cos(lat1 * (pi / 180)) *
          cos(lat2 * (pi / 180)) *
          sin(dLon / 2) *
          sin(dLon / 2);
  final c = 2 * asin(sqrt(a));
  return earthRadius * c;
}

List<Map<String, String>> sortLocations(
  List<Map<String, String>> locations,
  double? searchLat,
  double? searchLng,
) {
  final sorted = [...locations];
  if (searchLat != null && searchLng != null) {
    sorted.sort((a, b) {
      final d1 = calculateDistance(
        searchLat,
        searchLng,
        double.parse(a["lat"]!),
        double.parse(a["lng"]!),
      );
      final d2 = calculateDistance(
        searchLat,
        searchLng,
        double.parse(b["lat"]!),
        double.parse(b["lng"]!),
      );
      return d1.compareTo(d2);
    });
  }
  return sorted;
}

class DropBoxLocationsList extends StatelessWidget {
  final List<Map<String, String>> locations;
  final double? searchLat;
  final double? searchLng;

  const DropBoxLocationsList({
    super.key,
    required this.locations,
    this.searchLat,
    this.searchLng,
  });

  @override
  Widget build(BuildContext context) {
    final sorted = sortLocations(locations, searchLat, searchLng);
    return LocationList(locations: sorted);
  }
}

class EarlyVotingLocationsList extends StatelessWidget {
  final List<Map<String, String>> locations;
  final double? searchLat;
  final double? searchLng;

  const EarlyVotingLocationsList({
    super.key,
    required this.locations,
    this.searchLat,
    this.searchLng,
  });

  @override
  Widget build(BuildContext context) {
    final sorted = sortLocations(locations, searchLat, searchLng);
    return LocationList(locations: sorted);
  }
}

class PollingPlace extends StatefulWidget {
  const PollingPlace({super.key});

  @override
  State<PollingPlace> createState() => _PollingPlaceState();
}

class _PollingPlaceState extends State<PollingPlace> {
  late final WebViewController controller;
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();

    controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted:
                  (_) => setState(() {
                    isLoading = true;
                    hasError = false;
                  }),
              onPageFinished: (_) => setState(() => isLoading = false),
              onWebResourceError:
                  (_) => setState(() {
                    isLoading = false;
                    hasError = true;
                  }),
            ),
          )
          ..loadRequest(
            Uri.parse(
              'https://voterservices.elections.maryland.gov/PollingPlaceSearch',
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child:
              hasError
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.error_outline,
                          color: MARYLAND_RED,
                          size: 48,
                        ),
                        SizedBox(height: 12),
                        Text(
                          "Unable to load the voter search site.\nPlease check your internet connection.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  )
                  : WebViewWidget(controller: controller),
        ),
        if (isLoading)
          const Center(child: CircularProgressIndicator(color: MARYLAND_RED)),
      ],
    );
  }
}
