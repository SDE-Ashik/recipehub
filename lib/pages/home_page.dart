// import 'package:flutter/material.dart';
// import 'package:recepies_app/models/recipe.dart';
// import 'package:recepies_app/pages/recipe_page.dart';
// import 'package:recepies_app/services/data_service.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   String _mealTypeFilter = "";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text("RecipeHub"),
//       ),
//       body: SafeArea(child: _buildUi()),
//     );
//   }

//   Widget _buildUi() {
//     return Container(
//       padding: EdgeInsets.all(10),
//       child: Column(
//         children: [
//           _recipeTypeButtons(),
//           _recipesList(),
//         ],
//       ),
//     );
//   }

//   Widget _recipeTypeButtons() {
//     return SizedBox(
//       height: MediaQuery.sizeOf(context).height * 0.05,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 5),
//             child: FilledButton(
//               onPressed: () {
//                 setState(() {
//                   _mealTypeFilter = "snack";
//                 });
//               },
//               child: const Text("🥕 Snack"),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 5),
//             child: FilledButton(
//               onPressed: () {
//                 setState(() {
//                   _mealTypeFilter = "breakfast";
//                 });
//               },
//               child: const Text("☕ Breakfast"),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 5),
//             child: FilledButton(
//               onPressed: () {
//                 setState(() {
//                   _mealTypeFilter = "lunch";
//                 });
//               },
//               child: const Text("🍗 Lunch"),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 5),
//             child: FilledButton(
//               onPressed: () {
//                 setState(() {
//                   _mealTypeFilter = "dinner";
//                 });
//               },
//               child: const Text("🍽️ Dinner"),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _recipesList() {
//     return Expanded(
//       child: FutureBuilder(
//           future: DataService().getRecipes(_mealTypeFilter),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             }

//             if (snapshot.hasError) {
//               return const Center(
//                 child: Text("Unable to load data."),
//               );
//             }

//             return ListView.builder(
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (context, index) {
//                   Recipe recipe = snapshot.data![index];
//                   return ListTile(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) {
//                           return RecipePage(recipe: recipe,);
//                         }),
//                       );
//                     },
//                     contentPadding: const EdgeInsets.only(top: 20),
//                     isThreeLine: true,
//                     title: Text(
//                       recipe.name,
//                     ),
//                     subtitle: Text(
//                       "${recipe.cuisine} \nDifficulty:${recipe.difficulty}",
//                     ),
//                     leading: Image.network(recipe.image),
//                     trailing: Text(
//                       "${recipe.rating.toString()} ⭐",
//                       style: TextStyle(fontSize: 15),
//                     ),
//                   );
//                 });
//           }),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:recepies_app/models/recipe.dart';
import 'package:recepies_app/pages/recipe_page.dart';
import 'package:recepies_app/services/data_service.dart';
import 'package:translator/translator.dart'; // Import the translator package

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _mealTypeFilter = "";
  bool _isMalayalam = false; // Toggle for language
  final translator = GoogleTranslator(); // Initialize the translator

  // Function to translate the text
  Future<String> translateText(String text, String languageCode) async {
    try {
      var translation = await translator.translate(text, to: languageCode);
      return translation.text;
    } catch (e) {
      return text; // Return original text on error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FutureBuilder<String>(
          future: translateText("RecipeHub",
              _isMalayalam ? 'ml' : 'en'), // Translate AppBar title
          builder: (context, snapshot) {
            return Text(snapshot.data ?? "RecipeHub");
          },
        ),
        actions: [
          Switch(
            value: _isMalayalam,
            onChanged: (value) {
              setState(() {
                _isMalayalam = value; // Toggle language on switch
              });
            },
          ),
        ],
      ),
      body: SafeArea(child: _buildUi()),
    );
  }

  Widget _buildUi() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          _recipeTypeButtons(),
          _recipesList(),
        ],
      ),
    );
  }

  Widget _recipeTypeButtons() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.05,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: FilledButton(
              onPressed: () {
                setState(() {
                  _mealTypeFilter = "snack";
                });
              },
              child: FutureBuilder<String>(
                future: translateText("🥕 Snack",
                    _isMalayalam ? 'ml' : 'en'), // Translate button label
                builder: (context, snapshot) {
                  return Text(snapshot.data ?? "🥕 Snack");
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: FilledButton(
              onPressed: () {
                setState(() {
                  _mealTypeFilter = "breakfast";
                });
              },
              child: FutureBuilder<String>(
                future:
                    translateText("☕ Breakfast", _isMalayalam ? 'ml' : 'en'),
                builder: (context, snapshot) {
                  return Text(snapshot.data ?? "☕ Breakfast");
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: FilledButton(
              onPressed: () {
                setState(() {
                  _mealTypeFilter = "lunch";
                });
              },
              child: FutureBuilder<String>(
                future: translateText("🍗 Lunch", _isMalayalam ? 'ml' : 'en'),
                builder: (context, snapshot) {
                  return Text(snapshot.data ?? "🍗 Lunch");
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: FilledButton(
              onPressed: () {
                setState(() {
                  _mealTypeFilter = "dinner";
                });
              },
              child: FutureBuilder<String>(
                future: translateText("🍽️ Dinner", _isMalayalam ? 'ml' : 'en'),
                builder: (context, snapshot) {
                  return Text(snapshot.data ?? "🍽️ Dinner");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _recipesList() {
    return Expanded(
      child: FutureBuilder(
        future: DataService().getRecipes(_mealTypeFilter),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text("Unable to load data."),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Recipe recipe = snapshot.data![index];
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return RecipePage(recipe: recipe);
                    }),
                  );
                },
                contentPadding: const EdgeInsets.only(top: 20),
                isThreeLine: true,
                title: FutureBuilder<String>(
                  future: translateText(recipe.name,
                      _isMalayalam ? 'ml' : 'en'), // Translate recipe name
                  builder: (context, snapshot) {
                    return Text(snapshot.data ?? recipe.name);
                  },
                ),
                subtitle: FutureBuilder<String>(
                  future: translateText(
                      "${recipe.cuisine} \nDifficulty: ${recipe.difficulty}",
                      _isMalayalam
                          ? 'ml'
                          : 'en'), // Translate cuisine and difficulty
                  builder: (context, snapshot) {
                    return Text(snapshot.data ??
                        "${recipe.cuisine} \nDifficulty: ${recipe.difficulty}");
                  },
                ),
                leading: Image.network(recipe.image),
                trailing: Text(
                  "${recipe.rating.toString()} ⭐",
                  style: TextStyle(fontSize: 15),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
