import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/menu_card.dart';
import 'list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = '';

  Future<void> getUsername() async {
    final prefs =
        await SharedPreferences.getInstance();

    setState(() {
      username =
          prefs.getString('username') ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  Widget buildMenu({
    required String title,
    required String description,
    required String imageUrl,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 18,
      ),
      child: MenuCard(
        title: title,
        description: description,
        imageUrl: imageUrl,

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ListPage(
                menu: title,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF5F5F5,
      ),

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,

        title: const Text(
          'Meal App',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            const SizedBox(height: 10),

            Text(
              'Hallo, $username',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Pilih kategori makanan favoritmu hari ini.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 30),

            buildMenu(
              title: 'Beef',
              description:
                  'Berbagai olahan daging sapi lezat.',
              imageUrl:
                  'https://www.themealdb.com/images/category/beef.png',
            ),

            buildMenu(
              title: 'Chicken',
              description:
                  'Menu ayam favorit dengan rasa spesial.',
              imageUrl:
                  'https://www.themealdb.com/images/category/chicken.png',
            ),

            buildMenu(
              title: 'Pork',
              description:
                  'Pilihan menu pork dengan cita rasa khas.',
              imageUrl:
                  'https://www.themealdb.com/images/category/pork.png',
            ),
          ],
        ),
      ),
    );
  }
}