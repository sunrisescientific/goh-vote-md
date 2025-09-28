import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/county_provider.dart';
import '../widgets/screen_header.dart';
import '../data/constants.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:intl/intl.dart';
import '../providers/calendar_provider.dart';

class ExpandableSection extends StatefulWidget
{
  final ElectionEvent event;

  const ExpandableSection
  (
    {
      super.key, 
      required this.event,
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
        width: expandableBoxSize,
        decoration: BoxDecoration
        (
          color: Colors.white,
          border: Border.all(color: MARYLAND_RED, width: 3),
          boxShadow:[yellowBoxShadow],
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
                              widget.event.name,
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
                        "Voting day: ${DateFormat('MMMM d, y').format(widget.event.date)}",
                        style: smallDetails,
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
                      {
                        final Event event = Event
                        (
                          title: widget.event.name,
                          description: 'Vote!',
                          location: 'Polling location',
                          startDate: widget.event.date,
                          endDate: widget.event.date.add(const Duration(hours: 13)),
                        );
                        Add2Calendar.addEvent2Cal(event);
                      },
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
                        style: smallDetails2
                      ),
                    ),
                    SizedBox(height: 12),
                    Text
                    (
                      "Early voting: ${DateFormat('MMMM d, y').format(widget.event.earlyStart)} to ${DateFormat('MMMM d, y').format(widget.event.earlyEnd)}",
                      style: smallDetails,
                      softWrap: true,
                    ),
                    SizedBox(height: 6),
                    ElevatedButton
                    (
                      onPressed: ()
                      {
                        final Event event = Event
                        (
                          title: "${widget.event.name} Early Voting",
                          description: 'Vote!',
                          location: 'Polling location',
                          startDate: widget.event.earlyStart,
                          endDate: widget.event.earlyEnd,
                          allDay: true,
                        );
                        Add2Calendar.addEvent2Cal(event);
                      },
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
                        style: smallDetails2
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
                          style: smallDetails
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
  const Events({super.key});

  @override
  Widget build(BuildContext context)
  {
    final calendarProvider = Provider.of<CalendarProvider>(context);
    final List<ElectionEvent> events = calendarProvider.calendarEvents;

    return ListView.builder
    (
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: events.length,
      itemBuilder: (context, index)
      {
        final curEvent = events[index];
        return ExpandableSection
        (
          event: curEvent,
        );
      },
    );
  }
}

class CalendarScreen extends StatelessWidget
{
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    final countyProvider = Provider.of<CountyProvider>(context);
    final selectedCounty = countyProvider.selectedCounty;

    return Scaffold
    (
      body: SafeArea
      (
        child: SingleChildScrollView
        (
          padding: EdgeInsets.symmetric(horizontal: Dimensions.screenWidth * 0.06),
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
                  borderRadius: BorderRadius.circular(roundedCorners),
                ),
                child: Text
                (
                  "Upcoming elections",
                  style: smallDetails2
                ),
              ),
              SizedBox(height: 12),
              Events(),
            ],
          ),
        ),
      )
    );
  }
}