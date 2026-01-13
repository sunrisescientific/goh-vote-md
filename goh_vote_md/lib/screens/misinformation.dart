import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../providers/county_provider.dart';
import '../widgets/screen_header.dart';
import '../data/constants.dart';

class Dis_MisinformationScreen extends StatefulWidget {
  const Dis_MisinformationScreen({super.key});

  @override
  State<Dis_MisinformationScreen> createState() =>
      _Dis_MisinformationScreenState();
}

class _Dis_MisinformationScreenState extends State<Dis_MisinformationScreen> {
  late YoutubePlayerController _controller;
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dateController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();

  File? _selectedFile;
  bool _sendCopy = false;
  bool _isSending = false;
  String? _message;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(
            'https://www.youtube.com/watch?v=55n6W5ZUhQo',
          ) ??
          '',
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
    );
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your email';
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    if (!emailRegex.hasMatch(value)) return 'Please enter a valid email';
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your phone number';
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length != 10)
      return 'Enter a valid phone number (10 digits)';
    return null;
  }

  Future<void> _composeAndSendReport() async {
    setState(() {
      _isSending = true;
      _message = null;
    });

    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map(
            (MapEntry<String, String> e) =>
                '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
          )
          .join('&');
    }

    String report = """
     Dis/Misinformation Report
    ────────────────────────────

    Name: ${_nameController.text}
    Email: ${_emailController.text}
    Phone: ${_phoneController.text}
    Date: ${_dateController.text}
    Location: ${_locationController.text}

    Description:
    ${_descriptionController.text}
    """;
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'AAEMPLOYEE@gmail.com', //change to AA drop-in email
      query: encodeQueryParameters(<String, String>{
        'subject': "Misinformation form submission by ${_nameController.text}",
        'body': "${report}",
      }),
    );

    await launchUrl(emailLaunchUri);

    setState(() {
      _isSending = false;
      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
      _dateController.clear();
      _locationController.clear();
      _descriptionController.clear();
      FocusScope.of(context).unfocus(); //removing the focus from textbox, which disables the keyboard
    });
  }

  @override
  Widget build(BuildContext context) {
    final countyProvider = Provider.of<CountyProvider>(context);
    final selectedCounty = countyProvider.selectedCounty;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.screenWidth * 0.06,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ScreenHeader(
                logoPath: 'assets/title_logo.png',
                countyName: selectedCounty,
                title: "Reporting Misinformation",
              ),
              const SizedBox(height: 15),
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.blueAccent,
              ),
              const SizedBox(height: 15),

              Container(
                width: Dimensions.screenWidth * 0.95,
                color: const Color.fromRGBO(44, 45, 45, 1),
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    const Text(
                      "Dis/Misinformation",
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Election dis/misinformation means incorrect or misleading information regarding the TIME, PLACE, OR MANNER OF AN ELECTION, ELECTION RESULTS, OR VOTING RIGHTS in Maryland. If you see any dis/misinformation on social media, report it to the State Board of Elections.",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _nameController,
                              decoration: _inputDecoration('Name *'),
                              validator:
                                  (v) =>
                                      v!.isEmpty
                                          ? 'Please enter your name'
                                          : null,
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              controller: _emailController,
                              decoration: _inputDecoration('Email *').copyWith(
                                prefixIcon: const Icon(Icons.email_outlined),
                              ),
                              validator: _validateEmail,
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: _inputDecoration('Phone *').copyWith(
                                prefixIcon: const Icon(Icons.phone_outlined),
                              ),
                              validator: _validatePhone,
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              controller: _dateController,
                              readOnly: true,
                              decoration: _inputDecoration('Date *').copyWith(
                                suffixIcon: const Icon(
                                  Icons.calendar_today_outlined,
                                ),
                              ),
                              onTap: () async {
                                final picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2030),
                                );
                                if (picked != null) {
                                  _dateController.text =
                                      "${picked.month}/${picked.day}/${picked.year}";
                                }
                              },
                              validator:
                                  (v) =>
                                      v!.isEmpty
                                          ? 'Please select a date'
                                          : null,
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              controller: _locationController,
                              decoration: _inputDecoration('Location *'),
                              validator:
                                  (v) =>
                                      v!.isEmpty
                                          ? 'Please enter a location'
                                          : null,
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              controller: _descriptionController,
                              maxLines: 4,
                              decoration: _inputDecoration('Description *'),
                              validator:
                                  (v) =>
                                      v!.isEmpty
                                          ? 'Please describe the issue'
                                          : null,
                            ),
                            const SizedBox(height: 25),

                            const Text(
                              '*You can add photos or videos in next step',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            const SizedBox(height: 25),
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFBFC8FF),
                                  foregroundColor: Colors.black87,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                    horizontal: 30,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed:
                                    _isSending
                                        ? null
                                        : () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _composeAndSendReport();
                                          }
                                        },
                                child:
                                    _isSending
                                        ? const CircularProgressIndicator(
                                          color: Colors.black,
                                        )
                                        : const Text(
                                          'Continue',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                              ),
                            ),
                            if (_message != null) ...[
                              const SizedBox(height: 16),
                              Text(
                                _message!,
                                style: TextStyle(
                                  color:
                                      _message!.contains('successfully')
                                          ? Colors.green
                                          : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import '../providers/county_provider.dart';
// import '../widgets/screen_header.dart';
// import '../data/constants.dart';

// class Dis_MisinformationScreen extends StatefulWidget {
//   const Dis_MisinformationScreen({super.key});

//   @override
//   State<Dis_MisinformationScreen> createState() => _Dis_MisinformationScreenState();
// }

// class _Dis_MisinformationScreenState extends State<Dis_MisinformationScreen> {
//   late final WebViewController controller;

//   @override
//   void initState() {
//     super.initState();

//     controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setUserAgent(
//         'Mozilla/5.0 (Windows NT 10.0; Win64; x64) '
//         'AppleWebKit/537.36 (KHTML, like Gecko) '
//         'Chrome/121.0.0.0 Safari/537.36',
//       )
//       ..setBackgroundColor(const Color(0xFFFFFFFF))
//       ..loadRequest(
//         Uri.parse('https://elections.maryland.gov/press_room/Dis-Misinformation.html'),
//       );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final countyProvider = Provider.of<CountyProvider>(context);
//     final selectedCounty = countyProvider.selectedCounty;

//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             ScreenHeader(
//               logoPath: 'assets/title_logo.png',
//               countyName: selectedCounty,
//               title: "Reporting Misinformation",
//             ),

//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.all(Dimensions.screenWidth * 0.02),
//                 child: WebViewWidget(controller: controller),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
