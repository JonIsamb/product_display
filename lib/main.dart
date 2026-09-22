import 'package:flutter/material.dart';
import 'package:project_display/class/padel_raquet.dart';

// Palette empruntée au terrain de padel : vitres sombres, balle jaune-vert.
const _court = Color(0xFF0F3338);
const _courtLight = Color(0xFF16474E);
const _ball = Color(0xFFC8F04B);
const _paper = Color(0xFFF4F6F1);
const _line = Color(0xFFDDE3DA);
const _inkSoft = Color(0xFF5E6B64);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catalogue de raquettes de padel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _court, primary: _court),
        scaffoldBackgroundColor: _paper,
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
    final displayedItems = displayFavoritesOnly
        ? items.where((item) => item.isFavorite).toList()
        : items;
    final favoritesCount = items.where((item) => item.isFavorite).length;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(displayedItems.length),
            _filterBar(favoritesCount),
            Expanded(
              child: displayedItems.isEmpty
                  ? _emptyFavorites()
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                      itemCount: displayedItems.length,
                      itemBuilder: (context, index) {
                        return _card(displayedItems[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  /// Titre de la page et compteur.
  Widget _header(int count) {
    final label = displayFavoritesOnly
        ? '$count ${count > 1 ? 'raquettes gardées' : 'raquette gardée'}'
        : '$count ${count > 1 ? 'modèles' : 'modèle'} en rayon';

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            displayFavoritesOnly ? 'Favoris' : 'Raquettes',
            style: const TextStyle(
              fontSize: 34,
              height: 1.05,
              fontWeight: FontWeight.w700,
              letterSpacing: -1.1,
              color: _court,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                height: 8,
                width: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: _ball,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(fontSize: 13, color: _inkSoft),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Sélecteur Tous / Favoris, et bascule compact / détaillé.
  Widget _filterBar(int favoritesCount) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Row(
        children: [
          _segment(
            label: 'Tous',
            selected: !displayFavoritesOnly,
            onTap: displayFavoritesOnly ? displayFavoritesToggle : null,
          ),
          const SizedBox(width: 8),
          _segment(
            label: favoritesCount > 0 ? 'Favoris · $favoritesCount' : 'Favoris',
            selected: displayFavoritesOnly,
            onTap: displayFavoritesOnly ? null : displayFavoritesToggle,
          ),
          const Spacer(),
          TextButton(
            onPressed: toggleDisplay,
            style: TextButton.styleFrom(foregroundColor: _inkSoft),
            child: Text(fullDisplay ? 'Compact' : 'Détaillé'),
          ),
        ],
      ),
    );
  }

  Widget _segment({
    required String label,
    required bool selected,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? _court : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: selected ? _court : _line),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : _inkSoft,
          ),
        ),
      ),
    );
  }

  /// Une raquette : vignette, nom, description, prix et cœur.
  Widget _card(PadelRaquet item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.fromLTRB(12, 12, 4, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _line),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _thumbnail(item),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.25,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.2,
                    color: _court,
                  ),
                  child: item.buildName(context),
                ),
                if (fullDisplay) ...[
                  const SizedBox(height: 4),
                  DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 13.5,
                      height: 1.45,
                      color: _inkSoft,
                    ),
                    child: item.buildDescription(context),
                  ),
                ],
                const SizedBox(height: 6),
                Row(
                  children: [
                    DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.6,
                        color: _court,
                      ),
                      child: item.buildPrice(context),
                    ),
                    const Spacer(),
                    item.buildFavorite(context, () {
                      setState(() {
                        item.setIsFavorite(!item.isFavorite);
                      });
                    }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Vignette « terrain » avec les initiales, en attendant les vraies photos.
  Widget _thumbnail(PadelRaquet item) {
    final words = item.name.split(' ').where((w) => w.isNotEmpty).toList();
    final monogram = words.length > 1
        ? (words[0][0] + words[1][0]).toUpperCase()
        : (words.isEmpty ? '?' : words[0][0].toUpperCase());

    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: SizedBox(
        height: 84,
        width: 84,
        child: Stack(
          fit: StackFit.expand,
          children: [
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [_courtLight, _court],
                ),
              ),
            ),
            Positioned(
              right: -16,
              top: -16,
              child: Container(
                height: 46,
                width: 46,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: _ball,
                ),
              ),
            ),
            Center(
              child: Text(
                monogram,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Page favoris vide.
  Widget _emptyFavorites() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 64,
              width: 64,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: _court,
              ),
              child: const Icon(Icons.favorite, color: _ball, size: 28),
            ),
            const SizedBox(height: 18),
            const Text(
              'Gardez vos raquettes ici',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: _court,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Touchez le cœur sur une raquette pour la retrouver dans cette page.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13.5, height: 1.45, color: _inkSoft),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: displayFavoritesToggle,
              style: FilledButton.styleFrom(
                backgroundColor: _court,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text('Voir le catalogue'),
            ),
          ],
        ),
      ),
    );
  }
}
