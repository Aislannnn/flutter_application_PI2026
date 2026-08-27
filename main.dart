import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loading App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, primarySwatch: Colors.blue),
      home: const LoadingScreen(),
    );
  }
}

// ─── LOADING SCREEN ───────────────────────────────────────────────────────────

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    // Navega automaticamente para o MainScreen após 3 segundos
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MainScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Gradiente animado
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final angle = _controller.value * 2 * math.pi;
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: const [
                      Color.fromRGBO(19, 57, 135, 1),
                      Color.fromRGBO(24, 72, 155, 1),
                      Color.fromRGBO(36, 96, 185, 1),
                    ],
                    begin: Alignment(math.cos(angle), math.sin(angle)),
                    end: Alignment(-math.cos(angle), -math.sin(angle)),
                  ),
                ),
              );
            },
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: Image.asset(
                    'assets/images/ideia-logo.png.png',
                    width: 250,
                    height: 250,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Mente Viva',
                  style: GoogleFonts.libreBarcode128Text(
                    color: Colors.white,
                    fontSize: 48,
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white.withOpacity(0.9),
                    ),
                    strokeWidth: 4,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "CARREGANDO...",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── MAIN SCREEN COM BOTTOM NAVIGATION BAR ────────────────────────────────────

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    _HomePage(),
    _ExplorarPage(),
    _PerfilPage(),
    _ConfiguracoesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'Explorar',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
      ),
    );
  }
}

// ─── WIDGET DE FUNDO REUTILIZÁVEL ─────────────────────────────────────────────

class _BackgroundPage extends StatelessWidget {
  final String title;
  const _BackgroundPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset('assets/Images/Julia.jpg', fit: BoxFit.cover),
        Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [Shadow(blurRadius: 8, color: Colors.black)],
            ),
          ),
        ),
      ],
    );
  }
}

// ─── PÁGINAS PLACEHOLDER ──────────────────────────────────────────────────────

class _HomePage extends StatelessWidget {
  const _HomePage();
  @override
  Widget build(BuildContext context) {
    return const _BackgroundPage(title: 'Home');
  }
}

class _ExplorarPage extends StatelessWidget {
  const _ExplorarPage();
  @override
  Widget build(BuildContext context) {
    return const _BackgroundPage(title: 'Explorar');
  }
}

class _PerfilPage extends StatelessWidget {
  const _PerfilPage();
  @override
  Widget build(BuildContext context) {
    return const _BackgroundPage(title: 'Perfil');
  }
}

class _ConfiguracoesPage extends StatelessWidget {
  const _ConfiguracoesPage();
  @override
  Widget build(BuildContext context) {
    return const _BackgroundPage(title: 'Configurações');
  }
}
