import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/county_provider.dart';
import '../widgets/screen_header.dart'; 
import '../data/constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Dis_MisinformationScreen extends StatefulWidget {
  const Dis_MisinformationScreen({super.key});

  @override
  State<Dis_MisinformationScreen> createState() => _Dis_MisinformationScreenState();
}

class _Dis_MisinformationScreenState extends State<Dis_MisinformationScreen> {
    late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId('https://www.youtube.com/watch?v=55n6W5ZUhQo&embeds_referring_euri=https%3A%2F%2Felections.maryland.gov%2F&source_ve_path=Mjg2NjY') ?? '', // Replace with your video URL
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final countyProvider = Provider.of<CountyProvider>(context);
    final selectedCounty = countyProvider.selectedCounty;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ScreenHeader(
              logoPath: 'assets/title_logo.png',
              countyName: selectedCounty,
              title: "Reporting Dis/Misinformation",
            ),

            Expanded(
              
              child: 
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:
                  [
                    YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.blueAccent,
                      onReady: () {
                      },
                    ),

                    SizedBox(height: 10),



                    Expanded(
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                          width: Dimensions.screenWidth * 0.95,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(44, 45, 45, 1),
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Text("Dis/Misinformation", style: TextStyle(fontSize: 30,color: Colors.white, fontWeight: FontWeight.bold)),
                                Text("Election dis/misinformation means incorrect or misleading information regarding the TIME, PLACE, OR MANNER OF AN ELECTION, ELECTION RESULTS, OR VOTING RIGHTS in Maryland. It is important that if you see any dis/misinformation on the social media platforms to report it to the State Board of Elections. As the trusted source of election information, we will correct the record.", 
                                    style: TextStyle(fontSize: 15,color: Colors.white, fontWeight: FontWeight.bold))
                              ]
                            )
                          ),
                        )
                    )
                  ]
                )
              ),

              
            ),
          ],
        ),
      ),
    );
  }
}
