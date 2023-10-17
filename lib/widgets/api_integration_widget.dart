import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_language_api/google_generative_language_api.dart';

class ApiIntegrationWidget extends StatelessWidget {
  final TextEditingController _promptInputController = TextEditingController();
  final TextEditingController _promptOutputController = TextEditingController();
  ApiIntegrationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: TextField(
              controller: _promptInputController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a prompt',
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.teal,
            ),
            onPressed: () {
              generateTextWithPrompt(
                  promptString: _promptInputController.text);
            },
            child: const Text('Generate Text'),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 350.0,
              ),
              child: SingleChildScrollView(
                child: TextField(
                  maxLines: null,
                  enabled: false,
                  controller: _promptOutputController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Output text',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> generateTextWithPrompt({
    required String promptString,
  }) async {

    String apiKey = dotenv.env['PALM_API_KEY']!;

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
