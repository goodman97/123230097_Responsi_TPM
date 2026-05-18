import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/menu_model.dart';
import '../services/api_service.dart';

class DetailPage extends StatefulWidget {
  final MealModel meal;

  const DetailPage({
    super.key,
    required this.meal,
  });

  @override
  State<DetailPage> createState() =>
      _DetailPageState();
}

class _DetailPageState
    extends State<DetailPage> {
  late Future<MealModel> futureMeal;

  @override
  void initState() {
    super.initState();

    futureMeal =
        ApiService.fetchMealDetail(
      widget.meal.idMeal,
    );
  }

  Future<void> openSource(
    String url,
  ) async {
    if (url.isEmpty) return;

    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri)) {
      throw Exception(
        'Tidak bisa membuka source',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F5F5),

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,

        iconTheme: const IconThemeData(
          color: Colors.white,
        ),

        title: const Text(
          'Detail Meal',

          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: FutureBuilder<MealModel>(
        future: futureMeal,

        builder: (context, snapshot) {
          // LOADING
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          // ERROR
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error : ${snapshot.error}',
              ),
            );
          }

          // DATA
          final meal = snapshot.data!;

          return SingleChildScrollView(
            padding:
                const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                // IMAGE
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(
                    16,
                  ),

                  child: Image.network(
                    meal.strMealThumb,
                    width: double.infinity,
                    height: 240,
                    fit: BoxFit.cover,

                    errorBuilder:
                        (
                          context,
                          error,
                          stackTrace,
                        ) {
                      return Container(
                        width: double.infinity,
                        height: 240,
                        color: Colors.grey[300],

                        child: const Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 50,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // TITLE
                Text(
                  meal.strMeal,

                  style:
                      const TextStyle(
                    fontSize: 28,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                // CATEGORY
                Container(
                  width: double.infinity,

                  padding:
                      const EdgeInsets.all(
                    16,
                  ),

                  decoration:
                      BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(
                      16,
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(0.05),

                        blurRadius: 8,
                        offset:
                            const Offset(0, 3),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Category : ${meal.strCategory}',

                              style:
                                  const TextStyle(
                                fontSize:
                                    16,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 14,
                      ),

                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),

                          Expanded(
                            child: Text(
                              'Area : ${meal.strCountry}',

                              style:
                                  const TextStyle(
                                fontSize:
                                    16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),
                const Text(
                  'Instructions',

                  style: TextStyle(
                    fontSize: 22,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 14),

                // INSTRUCTION CONTENT
                Container(
                  width: double.infinity,

                  padding:
                      const EdgeInsets.all(
                    16,
                  ),

                  decoration:
                      BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(
                      16,
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(0.05),

                        blurRadius: 8,
                        offset:
                            const Offset(0, 3),
                      ),
                    ],
                  ),

                  child: Text(
                    meal.strInstructions,

                    textAlign:
                        TextAlign.justify,

                    style:
                        const TextStyle(
                      fontSize: 15,
                      height: 1.7,
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // BUTTON SOURCE
                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child:
                      ElevatedButton.icon(
                    onPressed: () {
                      openSource(
                        meal.strSource,
                      );
                    },

                    icon: const Icon(
                      Icons.open_in_browser,
                    ),

                    label: const Text(
                      'Open Source Website',
                    ),

                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.black,

                      foregroundColor:
                          Colors.white,

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          14,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}