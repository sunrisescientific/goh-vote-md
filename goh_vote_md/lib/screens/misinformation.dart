import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../providers/county_provider.dart';
import '../widgets/screen_header.dart'; 
import '../data/constants.dart';

class Dis_MisinformationScreen extends StatefulWidget {
  const Dis_MisinformationScreen({super.key});

  @override
  State<Dis_MisinformationScreen> createState() => _Dis_MisinformationScreenState();
}

class _Dis_MisinformationScreenState extends State<Dis_MisinformationScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent(
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) '
        'AppleWebKit/537.36 (KHTML, like Gecko) '
        'Chrome/121.0.0.0 Safari/537.36',
      )
      ..setBackgroundColor(const Color(0xFFFFFFFF))
      ..loadRequest(
        Uri.parse('https://elections.maryland.gov/press_room/Dis-Misinformation.html'),
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
              title: "Reporting Misinformation",
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.all(Dimensions.screenWidth * 0.02),
                child: WebViewWidget(controller: controller),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/*
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
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
          YoutubePlayer.convertUrlToId('https://www.youtube.com/watch?v=55n6W5ZUhQo') ?? '',
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (!emailRegex.hasMatch(value)) return 'Please enter a valid email';
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your phone number';
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length != 10) return 'Enter a valid phone number (10 digits)';
    return null;
  }

  Future<void> _sendEmailReport() async {
    setState(() {
      _isSending = true;
      _message = null;
    });

    const String username = 'thistest314@gmail.com';
    const String password = 'password_here';
    String adminEmail = 'topemail314@gmail.com';

    final smtpServer = gmail(username, password);

    final bodyHtml = '''
      <h2>Dis/Misinformation Report</h2>
      <p><b>Name:</b> ${_nameController.text}</p>
      <p><b>Email:</b> ${_emailController.text}</p>
      <p><b>Phone:</b> ${_phoneController.text}</p>
      <p><b>Date:</b> ${_dateController.text}</p>
      <p><b>Location:</b> ${_locationController.text}</p>
      <p><b>Description:</b><br>${_descriptionController.text}</p>
    ''';

    final message = Message()
      ..from = Address(username, 'Dis/Misinformation Report Form')
      ..recipients.add('formdoer314@gmail.com')
      ..subject = 'Dis/Misinformation Report from ${_nameController.text}'
      ..html = bodyHtml;

    if (_selectedFile != null) {
      message.attachments = [FileAttachment(_selectedFile!)];
    }

    try {

      if (_sendCopy) {
        final copyMsg = Message()
          ..from = Address(username, 'Dis/Misinformation Report Form')
          ..recipients.add(_emailController.text.trim())
          ..subject = 'Copy of your Dis/Misinformation Report'
          ..html = "<p>Hello ${_nameController.text},</p>$bodyHtml";

        if (_selectedFile != null) {
          copyMsg.attachments = [FileAttachment(_selectedFile!)];
        }

        await send(copyMsg, smtpServer);
      }

      final adminMessage = Message()
        ..from = Address(username, 'Dis/Misinformation Form')
        ..recipients.add(adminEmail)
        ..subject = 'New form submission'
        ..text = 'A new user submitted the form.\nEmail: ${message.recipients.first}'
        ..html = bodyHtml;
      if (_selectedFile != null) {
          adminMessage.attachments = [FileAttachment(_selectedFile!)];
        }

      final adminReport = await send(adminMessage, smtpServer);
      print('Admin message sent: $adminReport');

      setState(() {
        _message = 'Report sent successfully!';
          _nameController.clear();
          _emailController.clear();
          _phoneController.clear();
          _dateController.clear();
          _locationController.clear();
          _descriptionController.clear();
          _selectedFile = null;
          _sendCopy = false;
      });
    } on MailerException catch (e) {
      setState(() {
        _message = 'Failed to send: ${e.problems.map((p) => p.msg).join(', ')}';
      });
    } finally {
      setState(() {
        _isSending = false;
      });
    }
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
                      style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
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
                              validator: (v) =>
                                  v!.isEmpty ? 'Please enter your name' : null,
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
                                suffixIcon: const Icon(Icons.calendar_today_outlined),
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
                              validator: (v) =>
                                  v!.isEmpty ? 'Please select a date' : null,
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              controller: _locationController,
                              decoration: _inputDecoration('Location *'),
                              validator: (v) =>
                                  v!.isEmpty ? 'Please enter a location' : null,
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              controller: _descriptionController,
                              maxLines: 4,
                              decoration: _inputDecoration('Description *'),
                              validator: (v) =>
                                  v!.isEmpty ? 'Please describe the issue' : null,
                            ),
                            const SizedBox(height: 25),

                            const Text('Screenshot or photo (optional)',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: _pickFile,
                              child: DottedBorder(
                                color: Colors.grey,
                                dashPattern: const [6, 4],
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(10),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 35),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.insert_drive_file_outlined,
                                          size: 50, color: Colors.blueAccent),
                                      const SizedBox(height: 10),
                                      const Text("Drop your files here"),
                                      TextButton(
                                        onPressed: _pickFile,
                                        child: const Text("Browse"),
                                      ),
                                      if (_selectedFile != null)
                                        Text(_selectedFile!.path.split('/').last),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            Row(
                              children: [
                                Checkbox(
                                  value: _sendCopy,
                                  onChanged: (v) =>
                                      setState(() => _sendCopy = v ?? false),
                                ),
                                const Text("Send me a copy of my responses"),
                              ],
                            ),
                            const SizedBox(height: 25),

                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFBFC8FF),
                                  foregroundColor: Colors.black87,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 30),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: _isSending
                                    ? null
                                    : () {
                                        if (_formKey.currentState!.validate()) {
                                          _sendEmailReport();
                                        }
                                      },
                                child: _isSending
                                    ? const CircularProgressIndicator(color: Colors.black)
                                    : const Text(
                                        'Submit',
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
                                  color: _message!.contains('successfully')
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
*/