import 'package:flutter/material.dart';
import 'home_page.dart';



class UserPage extends StatelessWidget{
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white, // Set the icon color explicitly
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const HomePage();
            },
          ),
        ),
        child: const Icon(Icons.home),
      ),
      backgroundColor: Color(0xff484646),
      body: SafeArea(
        child: Column(
          children: [
              Padding(
                padding: const EdgeInsets.all(40),
              ),
              Image (image: AssetImage('lib/images/cart.png'),
                  height: 200),
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  "CENTSIBLE FOUNDER",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 5),
              const Text(
                'Nathalie Equiza',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 5),
              const Text(
                'Ariane Magbanua',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 14),
              const Text(
                'CPE31',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.grey,
                ),
              ),
            ],
        ),
      ),
    );
  }
}