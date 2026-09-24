// pubspec.yaml:
//   dependencies:
//     liquid_glass_easy: ^4.3.1
//
// Note: needs Impeller (default on modern iOS/Android) for the standalone
// LiquidGlassTabBar.withImpeller. On Skia it falls back to a frosted bar.

import 'package:flutter/material.dart';
import 'package:liquid_glass_easy/liquid_glass_easy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Compile shaders up front so the first frame is already glass.
  await LiquidGlassShaders.ensureLoaded();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeShell(),
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  final _items = const [
    LiquidGlassTabBarItem(label: 'Home', icon: Icons.home_rounded),
    LiquidGlassTabBarItem(label: 'Search', icon: Icons.search_rounded),
    LiquidGlassTabBarItem(label: 'Profile', icon: Icons.person_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Let the page draw under the bar so the glass has something to refract.
      extendBody: true,
      body: Stack(
        children: [
          // Your pages
          IndexedStack(
            index: _index,
            children: const [
              _DemoPage(title: 'Home', color1: Color(0xFF7F00FF), color2: Color(0xFFE100FF)),
              _DemoPage(title: 'Search', color1: Color(0xFF0072FF), color2: Color(0xFF00C6FF)),
              _DemoPage(title: 'Profile', color1: Color(0xFFFF512F), color2: Color(0xFFF09819)),
            ],
          ),

          // The floating glass tab bar, as the LAST child of the Stack
          LiquidGlassTabBar.withImpeller(
            items: _items,
            selectedIndex: _index,
            onChanged: (i) => setState(() => _index = i),
          ),
        ],
      ),
    );
  }
}

class _DemoPage extends StatelessWidget {
  const _DemoPage({
    required this.title,
    required this.color1,
    required this.color2,
  });

  final String title;
  final Color color1;
  final Color color2;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color1, color2],
        ),
      ),
      child: SafeArea(
        child: ListView.builder(
          // Extra bottom padding so the last items can scroll above the bar.
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 140),
          itemCount: 20,
          itemBuilder: (context, i) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            height: 80,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$title item ${i + 1}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
