import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../home.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const SelecaoPerfilScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, _) {
          final a = _ctrl.value * 2 * math.pi;
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: const [
                  Color(0xFF132E87),
                  Color(0xFF1848B0),
                  Color(0xFF2460B9),
                ],
                begin: Alignment(math.cos(a), math.sin(a)),
                end: Alignment(-math.cos(a), -math.sin(a)),
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: Container(
                      width: 220,
                      height: 220,
                      alignment: Alignment.center,
                      color: Colors.black,
                      child: Image.asset(
                        'assets/images/logo_branca.png',
                        width: 220,
                        height: 220,
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Mente Viva',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontFamily: 'LibreBarcode128',
                    ),
                  ),
                  const SizedBox(height: 40),
                  const SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                      strokeWidth: 4,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'CARREGANDO...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SelecaoPerfilScreen extends StatelessWidget {
  const SelecaoPerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: modoEscuro,
      builder: (context, escuro, _) {
        final bg = escuro ? Colors.black : const Color(0xFFF5EFE6);
        final textColor = escuro ? Colors.white : Colors.black87;
        return Scaffold(
          backgroundColor: bg,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        width: 80,
                        height: 80,
                        alignment: Alignment.center,
                        color: escuro ? const Color(0xFF335CAE) : Colors.white,
                        child: Image.asset(
                          escuro
                              ? 'assets/images/logo_branca.png'
                              : 'assets/images/logo.png',
                          width: 80,
                          height: 80,
                          fit: BoxFit.contain,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      'Mente Viva',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Quem está usando o aplicativo?',
                      style: TextStyle(
                        color: textColor.withOpacity(0.6),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                  _CardPerfil(
                    icone: Icons.person_outline,
                    titulo: 'Pessoa Assistida',
                    descricao:
                        'Visualize sua rotina, lembretes\ne álbum de memórias',
                    cor: const Color(0xFF1848B0),
                    escuro: escuro,
                    onTap: () {
                      perfilAtivo.value = 'assistida';
                      _irParaMain(context);
                    },
                  ),
                  const SizedBox(height: 20),
                  _CardPerfil(
                    icone: Icons.medical_services_outlined,
                    titulo: 'Cuidador',
                    descricao:
                        'Gerencie lembretes, álbum,\nprogresso e estatísticas',
                    cor: const Color(0xFF0F6E56),
                    escuro: escuro,
                    onTap: () {
                      perfilAtivo.value = 'cuidador';
                      _irParaMain(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _irParaMain(BuildContext context) {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const MainScreen()));
  }
}

class _CardPerfil extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String descricao;
  final Color cor;
  final bool escuro;
  final VoidCallback onTap;

  const _CardPerfil({
    required this.icone,
    required this.titulo,
    required this.descricao,
    required this.cor,
    required this.escuro,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardBg = escuro ? const Color(0xFF1A1A2E) : Colors.white;
    final textColor = escuro ? Colors.white : Colors.black87;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: cor.withOpacity(0.4), width: 2),
          boxShadow: [
            BoxShadow(
              color: cor.withOpacity(0.1),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: cor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(icone, color: cor, size: 32),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    descricao,
                    style: TextStyle(
                      color: textColor.withOpacity(0.6),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: cor),
          ],
        ),
      ),
    );
  }
}
