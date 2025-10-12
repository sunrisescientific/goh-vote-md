import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:dotted_border/dotted_border.dart';
import '../providers/county_provider.dart';
import '../widgets/screen_header.dart';
import '../data/constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
              'https://www.youtube.com/watch?v=55n6W5ZUhQo') ??
          '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle:
          const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
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
        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailRegex.hasMatch(value)) return 'Please enter a valid email';
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your phone number';
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length != 10) return 'Enter a valid phone number (10 digits)';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final countyProvider = Provider.of<CountyProvider>(context);
    final selectedCounty = countyProvider.selectedCounty;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
                title: "Reporting Dis/Misinformation",
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
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(44, 45, 45, 1),
                ),
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
                      "Election dis/misinformation means incorrect or misleading information regarding the TIME, PLACE, OR MANNER OF AN ELECTION, ELECTION RESULTS, OR VOTING RIGHTS in Maryland. If you see any dis/misinformation on social media, report it to the State Board of Elections. As the trusted source of election information, we will correct the record.",
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: _nameController,
                              decoration: _inputDecoration('Name *'),
                              validator: (value) =>
                                  value!.isEmpty ? 'Please enter your name' : null,
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
                                suffixIcon:
                                    const Icon(Icons.calendar_today_outlined),
                              ),
                              onTap: () async {
                                final pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2030),
                                );
                                if (pickedDate != null) {
                                  _dateController.text =
                                      "${pickedDate.month}/${pickedDate.day}/${pickedDate.year}";
                                }
                              },
                              validator: (value) =>
                                  value!.isEmpty ? 'Please select a date' : null,
                            ),
                            const SizedBox(height: 15),

                            TextFormField(
                              controller: _locationController,
                              decoration: _inputDecoration(
                                  'Location of the dis/misinformation *'),
                              validator: (value) => value!.isEmpty
                                  ? 'Please enter the location'
                                  : null,
                            ),
                            const SizedBox(height: 15),

                            TextFormField(
                              controller: _descriptionController,
                              maxLines: 4,
                              decoration: _inputDecoration('Description *'),
                              validator: (value) => value!.isEmpty
                                  ? 'Please describe the dis/misinformation'
                                  : null,
                            ),
                            const SizedBox(height: 25),

                            const Text(
                              'Screenshot or photo (optional)',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),

                            GestureDetector(
                              onTap: _pickFile,
                              child: DottedBorder(
                                color: Colors.grey,
                                strokeWidth: 1.2,
                                dashPattern: const [6, 4],
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(10),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 35),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.insert_drive_file_outlined,
                                        size: 50,
                                        color: Colors.blueAccent,
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        "Drop your files here",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: _pickFile,
                                        child: const Text(
                                          "Browse",
                                          style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      if (_selectedFile != null)
                                        Text(
                                          _selectedFile!.path.split('/').last,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.black54,
                                          ),
                                        ),
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
                                  onChanged: (value) {
                                    setState(() {
                                      _sendCopy = value ?? false;
                                    });
                                  },
                                  activeColor: Colors.blueAccent,
                                ),
                                const Text(
                                  "Send me a copy of my responses",
                                  style: TextStyle(color: Colors.black87),
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),

                            Center(
                              child: SizedBox(
                                width: Dimensions.screenWidth * 0.3,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color(0xFFBFC8FF), 
                                    foregroundColor: Colors.black87,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Form submitted successfully!'),
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text(
                                    'Submit',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
