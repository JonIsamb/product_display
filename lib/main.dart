import 'package:flutter/material.dart';
import 'package:project_display/class/padel_raquet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Catalogue de raquettes de padel'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool fullDisplay = true;
  bool displayFavoritesOnly = false;

  void toggleDisplay() {
    setState(() {
      fullDisplay = !fullDisplay;
    });
  }

  void displayFavoritesToggle() {
    setState(() {
      displayFavoritesOnly = !displayFavoritesOnly;
    });
  }

  final items = List<PadelRaquet>.from([
    PadelRaquet('Bullpadel Vertex 04 Comfort 24', 'Forme diamant, confort/polyvalente', 109.95, '', false),
    PadelRaquet('Nox AT10 Genius 18K 2025', 'Forme diamant, puissance, signature Agustín Tapia', 179.90, '', false),
    PadelRaquet('Bullpadel Vertex 05 GEO 26', 'Forme diamant, puissance/contrôle', 169.85, '', false),
    PadelRaquet('Babolat Technical Viper 3.0', 'Forme goutte, polyvalence haut de gamme', 249.99, '', false),
    PadelRaquet('Bullpadel XPLO 26 Martín Di Nenno', 'Forme diamant, très haut de gamme', 284.99, '', false),
  ]);

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final displayedItems = displayFavoritesOnly
        ? items.where((item) => item.isFavorite).toList()
        : items;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 80,
              child: Column(
                children: [
                  Text('Les produits'),
                  Text('${displayedItems.length} produits à découvrir')
                ],
              ),
            ),
            Row(
              children: [
                TextButton(onPressed: toggleDisplay, child: Text(fullDisplay ? 'Affichage compact' : 'Affichage détaillé')),
                TextButton(onPressed: displayFavoritesToggle, child: Text(displayFavoritesOnly ? 'Favoris uniquement' : 'Tous les produits'))
              ],

            ),
            Expanded(
              child: ListView.builder(
                itemCount: displayedItems.length,
                itemBuilder: (context, index) {
                  final item = displayedItems[index];

                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          item.buildName(context),
                          item.buildPrice(context)
                        ],
                      ),
                      if (fullDisplay) item.buildDescription(context),
                      item.buildFavorite(context, () {
                        setState(() {
                          item.setIsFavorite(!item.isFavorite);
                        });
                      }),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}