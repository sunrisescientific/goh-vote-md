import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/county_provider.dart';
import '../widgets/screen_header.dart';
import '../data/constants.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final countyProvider = Provider.of<CountyProvider>(context);
    final selectedCounty = countyProvider.selectedCounty;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.screenWidth * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ScreenHeader(
                logoPath: 'assets/title_logo.png',
                countyName: selectedCounty,
                title: "Locations",
              ),

              TextField(
                decoration: InputDecoration(
                  hintText: "Type address here",
                  suffixIcon: const Icon(Icons.search, color: MARYLAND_YELLOW),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: MARYLAND_RED, width: 3),
                    borderRadius: BorderRadius.circular(roundedCorners),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: MARYLAND_RED, width: 3),
                    borderRadius: BorderRadius.circular(roundedCorners),
                  ),
                ),
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

              IndexedStack(
                index: _selectedTab,
                children: const [
                  DropBoxLocationsList(),
                  EarlyVotingLocationsList(),
                  PollingPlace(),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: MARYLAND_RED, width: 3),
        boxShadow: [yellowBoxShadow],
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
                  },
                  child: CircleAvatar(
                    radius: 19,
                    backgroundColor: MARYLAND_RED,
                    child: const Icon(Icons.map, color: Colors.white, size: 20),
                  ),
                ),
                Text(
                  "Directions",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

//
// Individual tab widgets
//
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
    ];

    return LocationList(locations: locations, showMore: false);
  }
}

class EarlyVotingLocationsList extends StatelessWidget {
  const EarlyVotingLocationsList({super.key});

  @override
  Widget build(BuildContext context) {
    final locations = [
      {"name": "Name", "address": "Address line 1\nCity, State Zip code"},
      {"name": "Name", "address": "Address line 1\nCity, State Zip code"},
      {"name": "Name", "address": "Address line 1\nCity, State Zip code"},
    ];

    return LocationList(locations: locations, showMore: false);
  }
}

class PollingPlace extends StatelessWidget {
  const PollingPlace({super.key});

  @override
  Widget build(BuildContext context) {
    final locations = [
      {
        "name": "Sample Polling Place",
        "address": "123 Main Street\nCity, State Zip code"
      },
    ];

    return LocationList(locations: locations, showMore: false);
  }
}
