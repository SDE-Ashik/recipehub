<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RecipeHub README</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 20px;
            color: #333;
        }
        h1, h2, h3 {
            color: #444;
        }
        code {
            background-color: #f4f4f4;
            padding: 2px 4px;
            border-radius: 4px;
            font-family: Consolas, Monaco, 'Andale Mono', 'Ubuntu Mono', monospace;
        }
        pre {
            background-color: #f4f4f4;
            padding: 10px;
            border-radius: 4px;
            overflow-x: auto;
        }
        a {
            color: #007bff;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <h1>RecipeHub</h1>
    <p>RecipeHub is a Flutter application designed to help users discover and view recipes. The app allows users to filter recipes by meal type and view detailed information. It also includes a feature to toggle between English and Malayalam languages for better accessibility.</p>

    <h2>Features</h2>
    <ul>
        <li>Browse recipes by meal type: Snack, Breakfast, Lunch, Dinner.</li>
        <li>View detailed recipe information including ingredients, instructions, and ratings.</li>
        <li>Toggle between English and Malayalam languages for content translation.</li>
        <li>User-friendly interface with responsive design.</li>
    </ul>

    <h2>Prerequisites</h2>
    <p>Before you begin, ensure you have met the following requirements:</p>
    <ul>
        <li>Flutter SDK installed on your machine.</li>
        <li>Dart SDK installed on your machine.</li>
        <li>An IDE with Flutter support (e.g., Android Studio, VS Code).</li>
    </ul>

    <h2>Installation</h2>
    <p>Follow these steps to get your development environment set up:</p>
    <ol>
        <li><strong>Clone the repository:</strong></li>
        <pre><code>git clone https://github.com/SDE-Ashik/recipehub.git</code></pre>
        <li><strong>Navigate to the project directory:</strong></li>
        <pre><code>cd recipehub</code></pre>
        <li><strong>Install dependencies:</strong></li>
        <pre><code>flutter pub get</code></pre>
    </ol>

    <h2>Configuration</h2>
    <ol>
        <li><strong>Translator Package:</strong>
            <p>The app uses the <code>translator</code> package to handle language translation. Make sure you have an active internet connection for translation.</p>
        </li>
        <li><strong>API Configuration:</strong>
            <p>If you have a custom backend or API, configure it in the <code>DataService</code> class located in <code>lib/services/data_service.dart</code>.</p>
        </li>
    </ol>

    <h2>Running the App</h2>
    <p>To run the app on an emulator or a physical device, use the following command:</p>
    <pre><code>flutter run</code></pre>

    <h2>Usage</h2>
    <ul>
        <li><strong>Home Page:</strong> 
            <p>Browse recipes by selecting a meal type filter (Snack, Breakfast, Lunch, Dinner) using the buttons at the top of the screen.</p>
        </li>
        <li><strong>Recipe Page:</strong> 
            <p>Tap on any recipe to view detailed information including ingredients and instructions.</p>
        </li>
        <li><strong>Language Toggle:</strong> 
            <p>Use the toggle button in the AppBar to switch between English and Malayalam languages.</p>
        </li>
    </ul>

    <h2>Code Structure</h2>
    <ul>
        <li><code>lib/main.dart</code>: Entry point of the application.</li>
        <li><code>lib/models/recipe.dart</code>: Defines the Recipe model.</li>
        <li><code>lib/pages/recipe_page.dart</code>: Displays detailed information of a selected recipe.</li>
        <li><code>lib/services/data_service.dart</code>: Handles fetching recipes data from the API.</li>
        <li><code>lib/pages/home_page.dart</code>: Displays the list of recipes and meal type filters.</li>
    </ul>

    <h2>Contributing</h2>
    <p>We welcome contributions to RecipeHub! Please follow these steps to contribute:</p>
    <ol>
        <li>Fork the repository.</li>
        <li>Create a new branch (<code>git checkout -b feature-branch</code>).</li>
        <li>Make your changes.</li>
        <li>Commit your changes (<code>git commit -am 'Add new feature'</code>).</li>
        <li>Push to the branch (<code>git push origin feature-branch</code>).</li>
        <li>Create a new Pull Request.</li>
    </ol>
    <p>Please ensure your code adheres to the project's coding standards and passes all tests.</p>

    <h2>License</h2>
    <p>This project is licensed under the MIT License. See the <a href="LICENSE">LICENSE</a> file for details.</p>

    <h2>Acknowledgements</h2>
    <ul>
        <li>The <code>translator</code> package for language translation functionality.</li>
        <li>Flutter and Dart for providing a robust framework for app development.</li>
    </ul>

    <hr>
    <p>For any issues or feature requests, please open an issue in the GitHub repository.</p>
</body>
</html>
