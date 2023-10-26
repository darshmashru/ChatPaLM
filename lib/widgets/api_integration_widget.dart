import 'package:ChatPaLM/env/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_language_api/google_generative_language_api.dart';
import 'package:ChatPaLM/globals.dart';

class ApiIntegrationWidget extends StatelessWidget {
  final TextEditingController _promptInputController = TextEditingController();
  final TextEditingController _promptOutputController = TextEditingController();
  ApiIntegrationWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    maxLines: null,
                    enabled: false,
                    controller: _promptOutputController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.black,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      hintText: "Output text",
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: FloatingActionButton(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    onPressed: () {
                      final text = _promptOutputController.text;
                      Clipboard.setData(ClipboardData(text: text));
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Copied to Clipboard'))
                      );
                    },
                    child: const Icon(Icons.copy_rounded),
                  ),
                ),
              ], // children:
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 290.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 25.0),
                  child: TextField(
                    minLines: 1,
                    maxLines: 50,
                    style: const TextStyle(color: Colors.white),
                    controller: _promptInputController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromRGBO(30, 30, 30, 1),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(30, 30, 30, 1),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(30, 30, 30, 1),
                        ),
                      ),
                      hintText: "Input text",
                      hintStyle: TextStyle(
                        color: Colors.white, // Set the text color to white
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 100.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    generateTextWithPrompt(
                        promptString: _promptInputController.text);
                  },
                  child: const Text('Ask'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<String> generateTextWithPrompt({
    required String promptString,
  }) async {
    // API Key from Envied .env file
    String apiKey = Env.palmApiKey;

    // API Key from globals.dart
    // String apiKey = PALM_API_KEY;

    String textModel = 'models/text-bison-001';

    GenerateTextRequest textRequest = GenerateTextRequest(
        prompt: TextPrompt(text: promptString),
        temperature: 0.7,
        // Control the randomness of text generation
        candidateCount: 1,
        // Number of generated text candidates
        topK: 40,
        // Consider the top K probable tokens
        topP: 0.95,
        // Nucleus sampling parameter
        maxOutputTokens: 1024,
        // Maximum number of output tokens
        stopSequences: [],
        // Sequences at which to stop generation
        safetySettings: const [
          // Define safety settings to filter out harmful content
          SafetySetting(
              category: HarmCategory.derogatory,
              threshold: HarmBlockThreshold.lowAndAbove),
          SafetySetting(
              category: HarmCategory.toxicity,
              threshold: HarmBlockThreshold.lowAndAbove),
          SafetySetting(
              category: HarmCategory.violence,
              threshold: HarmBlockThreshold.mediumAndAbove),
          SafetySetting(
              category: HarmCategory.sexual,
              threshold: HarmBlockThreshold.mediumAndAbove),
          SafetySetting(
              category: HarmCategory.medical,
              threshold: HarmBlockThreshold.mediumAndAbove),
          SafetySetting(
              category: HarmCategory.dangerous,
              threshold: HarmBlockThreshold.mediumAndAbove),
        ]);

    final GeneratedText response = await GenerativeLanguageAPI.generateText(
      modelName: textModel,
      request: textRequest,
      apiKey: apiKey,
    );
    print(response.candidates.map((candidate) => candidate.output).join('\n'));
    _promptOutputController.text =
        response.candidates.map((candidate) => candidate.output).join('\n');

    // Extract and return the generated text
    if (response.candidates.isNotEmpty) {
      TextCompletion candidate = response.candidates.first;
      return candidate.output;
    }

    return '';
  }
}
