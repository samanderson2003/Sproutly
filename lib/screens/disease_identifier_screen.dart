import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class DiseaseIdentifierScreen extends StatefulWidget {
  const DiseaseIdentifierScreen({super.key});

  @override
  State<DiseaseIdentifierScreen> createState() =>
      _DiseaseIdentifierScreenState();
}

class _DiseaseIdentifierScreenState extends State<DiseaseIdentifierScreen> {
  File? _imageFile;
  String? _analysisResult;
  bool _isLoading = false;
  String? _errorMessage; // To store any error messages
  final ImagePicker _picker = ImagePicker();

  // Function to let the user pick an image from the gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 50,
        maxWidth: 800,
      );

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
          _analysisResult = null; // Reset previous results
          _errorMessage = null; // Reset errors
        });
        _analyzeImage(); // Automatically start analysis
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      setState(() {
        _errorMessage = "Error picking image. Please try again.";
      });
    }
  }

  // --- NEW: Function to handle the image analysis via OpenAI API ---
  Future<void> _analyzeImage() async {
    if (_imageFile == null) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null; // Clear previous errors
    });

    // 1. Get the API Key from .env
    final apiKey = dotenv.env['OPENAI_API_KEY'];
    if (apiKey == null) {
      setState(() {
        _errorMessage = 'API Key not found. Please check your .env file.';
        _isLoading = false;
      });
      return;
    }

    try {
      // 2. Encode the image to Base64
      final imageBytes = await _imageFile!.readAsBytes();
      final base64Image = base64Encode(imageBytes);

      // 3. Set up the API request headers
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      };

      // 4. Construct the request body with a specific prompt
      final body = jsonEncode({
        "model": "gpt-4o", // Using the powerful and cost-effective gpt-4o model
        "messages": [
          {
            "role": "user",
            "content": [
              {
                "type": "text",
                // This prompt instructs the AI to return ONLY a JSON object
                "text":
                    "Identify the plant disease in this image. Respond ONLY with a valid JSON object containing four keys: 'disease' (string), 'cause' (string), 'prevention' (string), and 'cure' (string). If you cannot identify a disease, return a JSON with an 'error' key.",
              },
              {
                "type": "image_url",
                "image_url": {"url": "data:image/jpeg;base64,$base64Image"},
              },
            ],
          },
        ],
        "max_tokens": 500, // Limit the response size
      });

      // 5. Make the HTTP POST request
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: headers,
        body: body,
      );

      // 6. Handle the response
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        // The actual content is a string, which we expect to be JSON
        final String content =
            decodedResponse['choices'][0]['message']['content'];

        setState(() {
          _analysisResult = content;
        });
      } else {
        // Handle API errors (e.g., invalid key, server error)
        final errorBody = jsonDecode(response.body);
        setState(() {
          _errorMessage =
              'API Error: ${errorBody['error']['message']} (Status Code: ${response.statusCode})';
        });
        debugPrint('API Error: ${response.body}');
      }
    } catch (e) {
      // Handle network or other exceptions
      setState(() {
        _errorMessage = 'An error occurred during analysis: ${e.toString()}';
      });
      debugPrint('Exception during analysis: $e');
    } finally {
      // Ensure loading indicator is always turned off
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F0),
      appBar: AppBar(
        title: const Text(
          'Plant Disease Identifier',
          style: TextStyle(color: Color(0xFF2D5016)),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF2D5016)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image display area
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF2D5016).withOpacity(0.3),
                ),
              ),
              child: _imageFile == null
                  ? const Center(
                      child: Text(
                        'Image will appear here',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(_imageFile!, fit: BoxFit.cover),
                    ),
            ),
            const SizedBox(height: 20),
            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  icon: Icons.photo_library,
                  label: 'Gallery',
                  onPressed: () => _pickImage(ImageSource.gallery),
                ),
                _buildActionButton(
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  onPressed: () => _pickImage(ImageSource.camera),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Results section
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(color: Color(0xFF2D5016)),
              )
            else if (_errorMessage != null)
              // Display error message if something went wrong
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              )
            else if (_analysisResult != null)
              _buildResultsCard(jsonDecode(_analysisResult!)),
          ],
        ),
      ),
    );
  }

  // Helper widget for action buttons
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      icon: Icon(icon, color: Colors.white),
      label: Text(label, style: const TextStyle(color: Colors.white)),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2D5016),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }

  // Helper widget to display results in a neat format
  Widget _buildResultsCard(Map<String, dynamic> results) {
    // Check if the API returned an error message within the JSON
    if (results.containsKey('error')) {
      return Text(
        'Analysis failed: ${results['error']}',
        style: const TextStyle(color: Colors.orange, fontSize: 16),
        textAlign: TextAlign.center,
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            results['disease'] ?? 'Unknown Disease',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D5016),
            ),
          ),
          const Divider(height: 24),
          _buildResultSection('Cause', results['cause']),
          _buildResultSection('Prevention', results['prevention']),
          _buildResultSection('Cure', results['cure']),
        ],
      ),
    );
  }

  // Helper widget for each section in the results card
  Widget _buildResultSection(String title, String? content) {
    if (content == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
