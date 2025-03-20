import 'package:flutter/material.dart';
import 'package:metafit/utils/home_utils/fetching/quote_fetching.dart';
import 'package:metafit/utils/home_utils/json_parsing/quote_json_parsing.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RandomQuote? randomQuote;
  bool isLoading = true;

  void loadQuote() async {
    setState(() {
      isLoading = true;
    });

    try {
      var quote = await fetchRandomQuote();
      setState(() {
        randomQuote = quote;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch quote!")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    loadQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Daily Motivation",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(color: Colors.deepOrange)
              : randomQuote != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade900,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(125, 255, 86, 34),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              const Icon(Icons.format_quote_rounded,
                                  color: Colors.deepOrange, size: 50),
                              const SizedBox(height: 15),
                              Text(
                                randomQuote!.quote,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                "- ${randomQuote!.author}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.deepOrange.shade200,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        ElevatedButton.icon(
                          onPressed: loadQuote,
                          icon: const Icon(Icons.refresh, color: Colors.white),
                          label: const Text("New Quote"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrange,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    )
                  : const Text(
                      "No quote available",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
        ),
      ),
    );
  }
}
