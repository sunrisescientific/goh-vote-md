import 'dart:io' show Platform;
import 'dart:math' show cos, sqrt, asin, pi, sin;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geocoding/geocoding.dart';

import '../providers/county_provider.dart';
import '../providers/location_provider.dart';
import '../widgets/screen_header.dart';
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

  /*
  final List<Map<String, String>> _dropBoxRaw = [
    {"name": "Activity Center at Bohrer Park", "address": "506 South Frederick Avenue, Gaithersburg, MD 20877"},
    {"name": "Allegany County Office Complex", "address": "701 Kelly Road, Cumberland, MD 21502"},
    {"name": "Mountain Ridge High School", "address": "100 Dr. Nancy S. Grasmick Lane, Frostburg, MD 21532"},
    {"name": "Crofton Library", "address": "1681 Riedel Road, Crofton, MD 21114"},
  ];

  final List<Map<String, String>> _earlyVotingRaw = [
    {"name": "Activity Center at Bohrer Park", "address": "506 South Frederick Avenue, Gaithersburg, MD 20877"},
    {"name": "Allegany County Office Complex", "address": "701 Kelly Road, Cumberland, MD 21502"},
    {"name": "Mountain Ridge High School", "address": "100 Dr. Nancy S. Grasmick Lane, Frostburg, MD 21532"},
    {"name": "Crofton Library", "address": "1681 Riedel Road, Crofton, MD 21114"},
  ];

  final List<Map<String, String>> _pollingRaw = [
    {"name": "Sample Polling Place", "address": "123 Main Street, Baltimore, MD 21201"},
  ];
  */

  /*
  List<Map<String, String>> _dropBox = [];
  List<Map<String, String>> _earlyVoting = [];
  List<Map<String, String>> _polling = [];
  */
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //_geocodeAllLocations();
  }

  /*
  Future<void> _geocodeAllLocations() async {
    Future<List<Map<String, String>>> enrich(List<Map<String, String>> raw) async {
      List<Map<String, String>> enriched = [];
      for (final loc in raw) {
        try {
          final results = await locationFromAddress(loc["address"]!);
          if (results.isNotEmpty) {
            enriched.add({
              ...loc,
              "lat": results.first.latitude.toString(),
              "lng": results.first.longitude.toString(),
            });
          } else {
            enriched.add(loc); 
          }
        } catch (e) {
          debugPrint("Geocoding failed for ${loc["address"]}: $e");
          enriched.add(loc);
        }
      }
      return enriched;
    }

    final drop = await enrich(_dropBoxRaw);
    final early = await enrich(_earlyVotingRaw);
    final poll = await enrich(_pollingRaw);

    if (mounted) {
      setState(() {
        _dropBox = drop;
        _earlyVoting = early;
        _polling = poll;
      });
    }
  }
  */

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

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    final dropBox = locationProvider.dropboxLocations;
    final earlyVoting = locationProvider.earlyLocations;
    final polling = locationProvider.pollingLocations;

    final countyProvider = Provider.of<CountyProvider>(context);
    final selectedCounty = countyProvider.selectedCounty;
    final screenWidth = Dimensions.screenWidth;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ScreenHeader(
                logoPath: 'assets/title_logo.png',
                countyName: selectedCounty,
                title: "Locations",
              ),

              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Type address here",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search, color: MARYLAND_YELLOW),
                    onPressed: () {
                      _updateSearch(_searchController.text);
                    },
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: MARYLAND_RED, width: 3),
                    borderRadius: BorderRadius.circular(roundedCorners),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: MARYLAND_RED, width: 3),
                    borderRadius: BorderRadius.circular(roundedCorners),
                  ),
                ),
                onSubmitted: _updateSearch,
              ),
              const SizedBox(height: 16),

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

              const SizedBox(height: 16),

              if (dropBox.isEmpty || earlyVoting.isEmpty || polling.isEmpty)
                const CircularProgressIndicator()
              else
                IndexedStack(
                  index: _selectedTab,
                  children: [
                    DropBoxLocationsList(
                      locations: dropBox.where((loc) => loc['county'] == selectedCounty).toList(),
                      searchLat: _searchLat,
                      searchLng: _searchLng,
                    ),
                    EarlyVotingLocationsList(
                      locations: earlyVoting.where((loc) => loc['county'] == selectedCounty).toList(),
                      searchLat: _searchLat,
                      searchLng: _searchLng,
                    ),
                    PollingPlace(
                      locations: polling,
                      searchLat: _searchLat,
                      searchLng: _searchLng,
                    ),
                  ],
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
          child: Text(
            text,
            style: isSelected ? heading3Selected : heading3,
          ),
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
    final Uri googleUrl = Uri.parse("https://www.google.com/maps/search/?api=1&query=$query");

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
        borderRadius: const BorderRadius.all(Radius.circular(0)),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(8),
        itemCount: locations.length + (showMore ? 1 : 0),
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          if (showMore && index == locations.length) {
            return TextButton(
              onPressed: () {},
              child: const Text(""),
            );
          }

          final loc = locations[index];
          return ListTile(
            title: Text(loc["name"]!, style: heading3),
            subtitle: Text(loc["address"]!),
            trailing: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    _openMaps(loc["address"]!);
                  },
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

  final a = sin(dLat / 2) * sin(dLat / 2) +
      cos(lat1 * (pi / 180)) *
          cos(lat2 * (pi / 180)) *
          sin(dLon / 2) *
          sin(dLon / 2);
  final c = 2 * asin(sqrt(a));

  return earthRadius * c;
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
    final sorted = [...locations];

    if (searchLat != null && searchLng != null) {
      sorted.sort((a, b) {
        final d1 = calculateDistance(
          searchLat!, searchLng!,
          double.parse(a["lat"]!), double.parse(a["lng"]!),
        );
        final d2 = calculateDistance(
          searchLat!, searchLng!,
          double.parse(b["lat"]!), double.parse(b["lng"]!),
        );
        return d1.compareTo(d2);
      });
    }

    return LocationList(locations: sorted, showMore: false);
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
    final sorted = [...locations];

    if (searchLat != null && searchLng != null) {
      sorted.sort((a, b) {
        final d1 = calculateDistance(
          searchLat!, searchLng!,
          double.parse(a["lat"]!), double.parse(a["lng"]!),
        );
        final d2 = calculateDistance(
          searchLat!, searchLng!,
          double.parse(b["lat"]!), double.parse(b["lng"]!),
        );
        return d1.compareTo(d2);
      });
    }

    return LocationList(locations: sorted, showMore: false);
  }
}

class PollingPlace extends StatelessWidget {
  final List<Map<String, String>> locations;
  final double? searchLat;
  final double? searchLng;

  const PollingPlace({
    super.key,
    required this.locations,
    this.searchLat,
    this.searchLng,
  });

  @override
  Widget build(BuildContext context) {
    final sorted = [...locations];

    if (searchLat != null && searchLng != null) {
      sorted.sort((a, b) {
        final d1 = calculateDistance(
          searchLat!, searchLng!,
          double.parse(a["lat"]!), double.parse(a["lng"]!),
        );
        final d2 = calculateDistance(
          searchLat!, searchLng!,
          double.parse(b["lat"]!), double.parse(b["lng"]!),
        );
        return d1.compareTo(d2);
      });
    }

    return LocationList(locations: sorted, showMore: false);
  }
}