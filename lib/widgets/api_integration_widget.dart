import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_language_api/google_generative_language_api.dart';


class ApiIntegrationWidget extends StatelessWidget {
  const ApiIntegrationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Integration Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Call the function to generate the story here
                generateTextWithPrompt(
                    promptString: 'Write a story about a Magic Backpack');
              },
              child: const Text('Generate Story'),
            ),
          ],
        ),
      ),
    );
  }

  static Future<String> generateTextWithPrompt({
    required String promptString,
  }) async {
    /// DO NOT PUBLICLY SHARE YOUR API KEY.
    // Load the API key from the local .env file.
    String apiKey = dotenv.env['PALM_API_KEY']!;

    // PaLM 2.0 model name
    String textModel = 'models/text-bison-001';

    // Construct the prompt string with input examples
    // String promptString = 'Teach me how to print hello world in python';

    // Configure the text generation request
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

    // Call the PaLM API to generate text
    final GeneratedText response = await GenerativeLanguageAPI.generateText(
      modelName: textModel,
      request: textRequest,
      apiKey: apiKey,
    );
    print(response.candidates.map((candidate) => candidate.output).join('\n'));

    // Extract and return the generated text
    if (response.candidates.isNotEmpty) {
      TextCompletion candidate = response.candidates.first;
      return candidate.output;
    }

    return '';
  }
}