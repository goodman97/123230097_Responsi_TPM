import 'package:flutter/material.dart';
import '../models/menu_model.dart';
import '../services/api_service.dart';
import 'detail_page.dart';

class ListPage extends StatefulWidget {
  final String menu;

  const ListPage({
    super.key,
    required this.menu,
  });

  @override
  State<ListPage> createState() =>
      _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late Future<List<MealModel>> futureData;

  @override
  void initState() {
    super.initState();

    futureData =
        ApiService.fetchMeals(widget.menu);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F5F5),

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,

        iconTheme: const IconThemeData(
          color: Colors.white,
        ),

        title: Text(
          '${widget.menu} Menu',

          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),

      body: FutureBuilder<List<MealModel>>(
        future: futureData,

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
              child: Padding(
                padding:
                    const EdgeInsets.all(20),

                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 70,
                      color: Colors.red,
                    ),

                    const SizedBox(height: 16),

                    Text(
                      'Terjadi Error\n${snapshot.error}',

                      textAlign:
                          TextAlign.center,

                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // DATA KOSONG
          if (!snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Data tidak ditemukan',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            );
          }

          final data = snapshot.data!;

          return ListView.builder(
            padding:
                const EdgeInsets.all(16),

            itemCount: data.length,

            itemBuilder: (context, index) {
              final item = data[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          DetailPage(
                        meal: item,
                      ),
                    ),
                  );
                },

                child: Container(
                  margin:
                      const EdgeInsets.only(
                    bottom: 18,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(
                      20,
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(0.08),

                        blurRadius: 10,
                        offset:
                            const Offset(0, 4),
                      ),
                    ],
                  ),

                  child: Row(
                    children: [
                      // IMAGE
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.only(
                          topLeft:
                              Radius.circular(
                            20,
                          ),
                          bottomLeft:
                              Radius.circular(
                            20,
                          ),
                        ),

                        child: Image.network(
                          item.strMealThumb,

                          width: 130,
                          height: 130,
                          fit: BoxFit.cover,

                          errorBuilder:
                              (
                                context,
                                error,
                                stackTrace,
                              ) {
                            return Container(
                              width: 130,
                              height: 130,
                              color:
                                  Colors.grey[300],

                              child: const Icon(
                                Icons
                                    .broken_image,
                                size: 40,
                              ),
                            );
                          },
                        ),
                      ),

                      // CONTENT
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.all(
                            16,
                          ),

                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [
                              // NAMA MAKANAN
                              Text(
                                item.strMeal,

                                maxLines: 2,

                                overflow:
                                    TextOverflow
                                        .ellipsis,

                                style:
                                    const TextStyle(
                                  fontSize: 20,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),

                              const SizedBox(
                                height: 12,
                              ),

                              // COUNTRY
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 18,
                                    color:
                                        Colors.red,
                                  ),

                                  const SizedBox(
                                    width: 6,
                                  ),

                                  Expanded(
                                    child: Text(
                                      item.strCountry,

                                      overflow:
                                          TextOverflow
                                              .ellipsis,

                                      style:
                                          TextStyle(
                                        color: Colors
                                            .grey[700],

                                        fontSize:
                                            14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              /*const SizedBox(
                                height: 10,
                              ),

                              // ID
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(
                                  horizontal:
                                      12,
                                  vertical: 6,
                                ),

                                decoration:
                                    BoxDecoration(
                                  color: Colors
                                      .black,

                                  borderRadius:
                                      BorderRadius.circular(
                                    30,
                                  ),
                                ),

                              ),*/

                              const SizedBox(
                                height: 14,
                              ),

                              // DETAIL TEXT
                              Row(
                                children: const [
                                  SizedBox(
                                    width: 6,
                                  ),

                                  Text(
                                    'Tap for details',

                                    style:
                                        TextStyle(
                                      color: Colors
                                          .black54,

                                      fontSize:
                                          14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      const Padding(
                        padding:
                            EdgeInsets.only(
                          right: 14,
                        ),

                        child: Icon(
                          Icons
                              .arrow_forward_ios,
                          size: 18,
                          color:
                              Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}