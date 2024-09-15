// import 'package:flutter/material.dart';
// import 'package:recepies_app/common/widget/app_style.dart';
// import 'package:recepies_app/models/recipe.dart';

// class RecipePage extends StatelessWidget {
//   final Recipe recipe;
//   RecipePage({required this.recipe});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.white60,
//         title: const Text(
//           "RecipeHub",
//         ),
//       ),
//       body: _build_Ui(context),
//     );
//   }

//   Widget _build_Ui(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           _recipeImage(context),
//           _recipeDetails(context),
//           _recipeIngridents(context),
//           _recipeInstructions(context),
//         ],
//       ),
//     );
//   }

//   Widget _recipeImage(BuildContext context) {
//     return Container(
//       height: MediaQuery.sizeOf(context).height * 0.40,
//       width: MediaQuery.sizeOf(context).width,
//       decoration: BoxDecoration(
//         image: DecorationImage(
//             image: NetworkImage(recipe.image), fit: BoxFit.cover),
//       ),
//     );
//   }

//   Widget _recipeDetails(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       width: MediaQuery.sizeOf(context).width,
//       padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//       child: Column(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "${recipe.cuisine},${recipe.difficulty}",
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
//           ),
//           Text(
//             recipe.name,
//             style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//           ),
//           Text(
//             "Prep Time: ${recipe.prepTimeMinutes} Minutes| Cook Time ${recipe.cookTimeMinutes} Minutes",
//             style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
//           ),
//           Text(
//             "${recipe.rating.toString()} ⭐|  ${recipe.reviewCount} Reviews",
//             style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _recipeIngridents(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       width: MediaQuery.sizeOf(context).width,
//       padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//       child: Column(
//         children: recipe.ingredients.map((i) {
//           return Row(
//             children: [
//               const Icon(Icons.check_box),
//               Text(" $i"),
//             ],
//           );
//         }).toList(),
//       ),
//     );
//   }

//   Widget _recipeInstructions(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       width: MediaQuery.sizeOf(context).width,
//       padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//       child: Column(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: recipe.instructions.map((i) {
//           return Text(i, maxLines: 3,
//           textAlign: TextAlign.start,
//           style:const TextStyle(fontSize: 15),);
//         }).toList(),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:recepies_app/common/widget/app_style.dart';
import 'package:recepies_app/models/recipe.dart';
import 'package:translator/translator.dart'; // Import the Google Translator package

class RecipePage extends StatefulWidget {
  final Recipe recipe;
  RecipePage({required this.recipe});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  bool _isMalayalam = false; // Toggle for language
  final translator = GoogleTranslator(); // Initialize the translator

  // Function to translate the text
  Future<String> translateText(String text) async {
    if (_isMalayalam) {
      var translation = await translator.translate(text, to: 'ml');
      return translation.text;
    }
    return text; // Return the original text if in English
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white60,
        title: const Text(
          "RecipeHub",
        ),
        actions: [
          // Toggle button on the trailing side of the app bar
          Switch(
            value: _isMalayalam,
            onChanged: (value) {
              setState(() {
                _isMalayalam = value;
              });
            },
            activeColor: Colors.green,
          ),
        ],
      ),
      body: _buildUi(context),
    );
  }

  Widget _buildUi(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _recipeImage(context),
          FutureBuilder<String>(
            future: translateText(
                "${widget.recipe.cuisine}, ${widget.recipe.difficulty}"),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? CircularProgressIndicator()
                  : _recipeDetails(context, snapshot.data ?? "");
            },
          ),
          _recipeIngridents(context),
          _recipeInstructions(context),
        ],
      ),
    );
  }

  Widget _recipeImage(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.40,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(widget.recipe.image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _recipeDetails(BuildContext context, String translatedText) {
    return Container(
      color: Colors.white,
      width: MediaQuery.sizeOf(context).width,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            translatedText,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
          FutureBuilder<String>(
            future: translateText(widget.recipe.name),
            builder: (context, snapshot) {
              return Text(
                snapshot.data ?? widget.recipe.name,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              );
            },
          ),
          Text(
            "Prep Time: ${widget.recipe.prepTimeMinutes} Minutes | Cook Time: ${widget.recipe.cookTimeMinutes} Minutes",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
          ),
          Text(
            "${widget.recipe.rating.toString()} ⭐ | ${widget.recipe.reviewCount} Reviews",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _recipeIngridents(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Column(
        children: widget.recipe.ingredients.map((i) {
          return FutureBuilder<String>(
            future: translateText(i),
            builder: (context, snapshot) {
              return Row(
                children: [
                  const Icon(Icons.check_box),
                  Text(" ${snapshot.data ?? i}"),
                ],
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _recipeInstructions(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.recipe.instructions.map((i) {
          return FutureBuilder<String>(
            future: translateText(i),
            builder: (context, snapshot) {
              return Text(
                snapshot.data ?? i,
                maxLines: 3,
                textAlign: TextAlign.start,
                style: const TextStyle(fontSize: 15),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
