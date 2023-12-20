import 'package:ChatPaLM/env/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_generative_language_api/google_generative_language_api.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ApiIntegrationWidget extends StatefulWidget {
  const ApiIntegrationWidget({Key? key}) : super(key: key);

  @override
  _ApiIntegrationWidgetState createState() => _ApiIntegrationWidgetState();
}

class _ApiIntegrationWidgetState extends State<ApiIntegrationWidget>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _promptInputController = TextEditingController();
  final TextEditingController _promptOutputController = TextEditingController();
  String mdText = "";

  void updateText(String newText) {
    setState(() {
      mdText = newText;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: MarkdownBody(
                    data: mdText,
                    styleSheet: MarkdownStyleSheet(
                      h1: const TextStyle(color: Colors.red, fontSize: 24),
                      h2: const TextStyle(color: Colors.orange, fontSize: 20),
                      p: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                      codeblockDecoration: BoxDecoration(
                        color: Colors.black, // background color for code block
                        borderRadius: BorderRadius.circular(5), // border radius
                        border: Border.all(color: Colors.black),
                        // border color
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: FloatingActionButton(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      final text = _promptOutputController.text;
                      Clipboard.setData(ClipboardData(text: text));
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Copied to Clipboard')));
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
              Container(
                width: 290.0,
                padding: const EdgeInsets.only(right: 10.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: TextField(
                    minLines: 1,
                    maxLines: 50,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    controller: _promptInputController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.background,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        borderRadius: BorderRadius.circular(
                            10.0), // Set the border radius
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        borderRadius: BorderRadius.circular(
                            10.0), // Set the border radius
                      ),
                      hintText: "Input text",
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 75.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.background,
                    backgroundColor: Theme.of(context).colorScheme.primary,
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
    // print(response.candidates.map((candidate) => candidate.output).join('\n'));
    _promptOutputController.text =
        response.candidates.map((candidate) => candidate.output).join('\n');
    // mdText = _promptOutputController.text;
    updateText(_promptOutputController.text);
    print("Markdown text: ");
    print(mdText);

    // Extract and return the generated text
    if (response.candidates.isNotEmpty) {
      TextCompletion candidate = response.candidates.first;
      return candidate.output;
    }

    return '';
  }

  @override
  bool get wantKeepAlive => true;
}
