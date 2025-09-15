import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/county_provider.dart';
import '../widgets/screen_header.dart';
import '../data/constants.dart';

class ExpandableSection extends StatefulWidget
{
  final String event;
  final String date;
  final String info;

  const ExpandableSection
  (
    {
      required this.event,
      required this.date,
      required this.info,
    }
  );

  @override
  State<ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection>
{
  bool _expanded = false;

  @override
  Widget build(BuildContext context)
  {
    return Padding
    (
      padding: const EdgeInsets.only(bottom: 12),
      child: Container
      (
        decoration: BoxDecoration
        (
          color: Colors.white,
          border: Border.all(color: MARYLAND_RED, width: 3),
          boxShadow:
          [
            BoxShadow
            (
              color: MARYLAND_YELLOW,
              spreadRadius: 0.5,
              blurRadius: 0,
              offset: Offset(2.5, 2.5),
            ),
          ],
        ),
        child: Column
        (
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            // Header Button
            TextButton
            (
              onPressed: ()
              {
                setState(()
                {
                  _expanded = !_expanded;
                });
              },
              style: TextButton.styleFrom
              (
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 6),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Padding
              (
                padding: const EdgeInsets.only(top: 6,),
                child: SizedBox
                (
                  width: double.infinity,
                  child: Column
                  (
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      Row
                      (
                        children:
                        [
                          Expanded
                          (
                            child: Text
                            (
                              widget.event,
                              style: heading3,
                              softWrap: true,
                            ),
                          ),
                          Icon
                          (
                            _expanded ? Icons.expand_less : Icons.expand_more,
                            color: Colors.black,
                            size: 32
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text
                      (
                        widget.date,
                        style: TextStyle
                        (
                          fontSize: 12,
                          fontFamily: "Inter",
                          color: Colors.black
                        ),
                        softWrap: true,
                      ),
                    ],
                  )
                ),
              )
            ),

            // Expandable content
            AnimatedCrossFade
            (
              duration: const Duration(milliseconds: 100),
              crossFadeState: _expanded
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: Padding
              (
                padding: const EdgeInsets.only(left: 10, bottom: 12),
                child: Column
                (
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    ElevatedButton
                    (
                      onPressed: ()
                      {},
                      style: ElevatedButton.styleFrom
                      (
                        backgroundColor: Color(0xFF484848),
                        padding: EdgeInsets.symmetric
                        (
                          horizontal: 14,
                          vertical: 6,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text
                      (
                        "Add to calendar",
                        style: TextStyle
                        (
                          fontSize: 12,
                          fontFamily: "Inter",
                          color: Colors.white
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text
                    (
                      widget.info,
                      style: TextStyle
                        (
                          fontSize: 12,
                          fontFamily: "Inter",
                          color: Colors.black
                        ),
                        softWrap: true,
                    ),
                    SizedBox(height: 6),
                    ElevatedButton
                    (
                      onPressed: ()
                      {},
                      style: ElevatedButton.styleFrom
                      (
                        backgroundColor: Color(0xFF484848),
                        padding: EdgeInsets.symmetric
                        (
                          horizontal: 14,
                          vertical: 6,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text
                      (
                        "Add to calendar",
                        style: TextStyle
                        (
                          fontSize: 12,
                          fontFamily: "Inter",
                          color: Colors.white
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Align
                    (
                      alignment: Alignment.center,
                      child: ElevatedButton
                      (
                        onPressed: ()
                        {},
                        style: ElevatedButton.styleFrom
                        (
                          backgroundColor: MARYLAND_YELLOW,
                          padding: EdgeInsets.symmetric
                          (
                            horizontal: 32,
                            vertical: 6,
                          ),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text
                        (
                          "Sample Ballot",
                          style: TextStyle
                          (
                            fontSize: 12,
                            fontFamily: "Inter",
                            color: Colors.black
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              secondChild: const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}

class Events extends StatelessWidget
{
  final List<String> events;
  final List<String> dates;
  final List<String> infos;

  const Events
  ({
    required this.events,
    required this.dates,
    required this.infos,
  });

  @override
  Widget build(BuildContext context)
  {
    return Column
    (
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(events.length, (index)
      {
        return ExpandableSection
        (
          event: events[index],
          date: dates[index],
          info: infos[index],
        );
      }),
    );
  }
}

class CalendarScreen extends StatelessWidget
{
  final List<String> eventsList =
  [
    "2028 Presidential Election",
    "2026 Gubernatorial General Election",
    "2026 Gubernatorial Primary Election",
  ];

  final List<String> datesList =
  [
    "Election day: November 7, 2028",
    "Election day: November 3, 2026",
    "Election day: June 23, 2026",
  ];

  final List<String> infosList =
  [
    "Early voting: DATE -- DATE",
    "Early voting: October 22, 2026 -- October 29, 2026",
    "Early voting: June 11, 2026 -- June 18, 2026",
  ];

  @override
  Widget build(BuildContext context)
  {
    final countyProvider = Provider.of<CountyProvider>(context);
    final selectedCounty = countyProvider.selectedCounty;
    final screenHeight = Dimensions.screenHeight;
    final screenWidth =  Dimensions.screenWidth;
    return Scaffold
    (
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
        child: Column
        (
          crossAxisAlignment: CrossAxisAlignment.center,
          children:
          [

            ScreenHeader(
              logoPath: 'assets/title_logo.png',
              countyName: selectedCounty,
              title: "Election Calendar",
            ),
            Container
            (
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 100),
              decoration: BoxDecoration
              (
                color: Colors.black,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text
              (
                "Upcoming elections",
                style: TextStyle
                (
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: "Inter",
                ),
              ),
            ),
            SizedBox(height: 12),
            Events
            (
              events: eventsList,
              dates: datesList,
              infos: infosList,
            ),
          ],
        ),
      ),
      )
    );
  }
}
