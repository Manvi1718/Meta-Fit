// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
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
  String? userEmail;

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
        const SnackBar(content: Text("Failed to fetch quote!")),
      );
    }
  }

  void getUserDetails() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userEmail = user.email;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
    loadQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF121212), Color(0xFF1E1E1E)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 🟠 Welcome Message
              if (userEmail != null) ...[
                Text(
                  "Welcome Back,",
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  userEmail!,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 30),
              ],

              // 🎯 Motivation Title
              Text(
                "Daily Motivation",
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // 💡 Quote Display
              Expanded(
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.orange,
                        ),
                      )
                    : randomQuote != null
                        ? AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(187, 0, 0, 0),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(79, 255, 153, 0),
                                  blurRadius: 12,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: SingleChildScrollView(
                              // ✅ This prevents overflow
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.format_quote_rounded,
                                      color: Colors.orange, size: 50),
                                  const SizedBox(height: 15),
                                  Text(
                                    randomQuote!.quote,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    "- ${randomQuote!.author}",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.orange.shade200,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const Center(
                            child: Text(
                              "No quote available",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
              ),
              const SizedBox(height: 30),

              // 🔄 New Quote Button
              ElevatedButton.icon(
                onPressed: loadQuote,
                icon: const Icon(Icons.refresh, color: Colors.white),
                label: const Text(
                  "New Quote",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
