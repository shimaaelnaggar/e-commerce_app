import 'package:ecommerce_app/core/widgets/brand_name.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountryView extends StatefulWidget {
  const CountryView({super.key});

  @override
  State<CountryView> createState() => _CountryViewState();
}

class _CountryViewState extends State<CountryView> {
  String? selectedCountry;

  final List<String> countries = [
    "Egypt",
    "Saudi Arabia",
    "United States",
    "United Kingdom",
  ];

  Future<void> saveCountry() async {
    if (selectedCountry == null) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("country", selectedCountry!);

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const Placeholder()),
    );
  }

  void _showCountrySheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          children: countries.map((country) {
            return ListTile(
              title: Text(country, style: const TextStyle(color: Colors.white)),
              onTap: () {
                setState(() {
                  selectedCountry = country;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          buildBackground(),

          buildOverlay(),

          Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BrandName(fontSize: 32),

                  const SizedBox(height: 40),
                  buildSelector(),
                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: saveCountry,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Continue"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector buildSelector() {
    return GestureDetector(
      onTap: _showCountrySheet,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedCountry ?? "Select Country",
              style: const TextStyle(color: Colors.white),
            ),
            const Icon(Icons.arrow_drop_down, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Container buildOverlay() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black.withValues(alpha: 0.8),
            Colors.black.withValues(alpha: 0.5),
            Colors.black.withValues(alpha: 0.8),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
    );
  }

  SizedBox buildBackground() {
    return SizedBox.expand(
      child: Image.network(
        "https://th.bing.com/th/id/OIG2.FmWwko.EfA4VFdpjxZsU?w=270&h=270&c=6&r=0&o=5&pid=ImgGn",
        fit: BoxFit.cover,
      ),
    );
  }
}
