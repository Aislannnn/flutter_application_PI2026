import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../auth/presentation.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  void _selectTab(int index) {
    setState(() => _currentIndex = index);
  }

  List<Widget> get _pages => perfilAtivo.value == 'cuidador'
      ? const [
          _HomePageCuidador(),
          _JogosPage(),
          _LembretesPage(),
          _AlbumPage(),
        ]
      : const [_HomePage(), _JogosPage(), _LembretesPage(), _AlbumPage()];

  void _abrirConfiguracoes() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => const _ConfigSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: modoEscuro,
      builder: (context, escuro, _) {
        final navBg = escuro ? const Color(0xFF1A1A1A) : Colors.white;
        final iconColor = escuro ? Colors.white70 : Colors.black54;
        const selectedColor = Color(0xFF1848B0);
        final bgColor = escuro ? Colors.black : const Color(0xFFF5EFE6);

        return Scaffold(
          backgroundColor: bgColor,
          extendBody: true,
          body: SafeArea(child: _pages[_currentIndex]),
          floatingActionButton: _buildFab(),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: navBg,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _NavItem(
                      icon: Icons.home_outlined,
                      activeIcon: Icons.home,
                      label: 'Início',
                      index: 0,
                      currentIndex: _currentIndex,
                      selectedColor: selectedColor,
                      iconColor: iconColor,
                      onTap: (i) => setState(() => _currentIndex = i),
                    ),
                    _NavItem(
                      icon: Icons.sports_esports_outlined,
                      activeIcon: Icons.sports_esports,
                      label: 'Jogos',
                      index: 1,
                      currentIndex: _currentIndex,
                      selectedColor: selectedColor,
                      iconColor: iconColor,
                      onTap: (i) => setState(() => _currentIndex = i),
                    ),
                    _NavItem(
                      icon: Icons.notifications_outlined,
                      activeIcon: Icons.notifications,
                      label: 'Lembretes',
                      index: 2,
                      currentIndex: _currentIndex,
                      selectedColor: selectedColor,
                      iconColor: iconColor,
                      onTap: (i) => setState(() => _currentIndex = i),
                    ),
                    _NavItem(
                      icon: Icons.photo_album_outlined,
                      activeIcon: Icons.photo_album,
                      label: 'Álbum',
                      index: 3,
                      currentIndex: _currentIndex,
                      selectedColor: selectedColor,
                      iconColor: iconColor,
                      onTap: (i) => setState(() => _currentIndex = i),
                    ),
                    _NavItem(
                      icon: Icons.settings_outlined,
                      activeIcon: Icons.settings,
                      label: 'Config.',
                      index: 4,
                      currentIndex: _currentIndex,
                      selectedColor: selectedColor,
                      iconColor: iconColor,
                      onTap: (_) => _abrirConfiguracoes(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget? _buildFab() {
    final eCuidador = perfilAtivo.value == 'cuidador';
    if (_currentIndex == 2 && eCuidador) {
      return FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => const _CriarLembreteSheet(),
        ),
        backgroundColor: const Color(0xFF1848B0),
        child: const Icon(Icons.add, color: Colors.white),
      );
    }
    if (_currentIndex == 3 && eCuidador) {
      return FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => const _AdicionarPessoaSheet(),
        ),
        backgroundColor: const Color(0xFF1848B0),
        child: const Icon(Icons.person_add_outlined, color: Colors.white),
      );
    }
    if (_currentIndex == 0 && perfilAtivo.value == 'assistida') {
      return FloatingActionButton.small(
        onPressed: () => _registrarVisita(context),
        backgroundColor: const Color(0xFF0F6E56),
        tooltip: 'Registrar visita',
        child: const Icon(Icons.people_outline, color: Colors.white, size: 20),
      );
    }
    return null;
  }

  void _registrarVisita(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _RegistrarVisitaSheet(),
    );
  }
}

class _HomePageCuidador extends StatelessWidget {
  const _HomePageCuidador();

  @override
  Widget build(BuildContext context) {
    return const _HomePage();
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  String _saudacao() {
    final h = DateTime.now().hour;
    if (h < 12) return 'Bom dia';
    if (h < 18) return 'Boa tarde';
    return 'Boa noite';
  }

  String _dataFormatada() {
    const meses = [
      'janeiro',
      'fevereiro',
      'março',
      'abril',
      'maio',
      'junho',
      'julho',
      'agosto',
      'setembro',
      'outubro',
      'novembro',
      'dezembro',
    ];
    const dias = [
      'Domingo',
      'Segunda-feira',
      'Terça-feira',
      'Quarta-feira',
      'Quinta-feira',
      'Sexta-feira',
      'Sábado',
    ];
    final n = DateTime.now();
    return '${dias[n.weekday % 7]}, ${n.day} de ${meses[n.month - 1]}';
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: modoEscuro,
      builder: (context, escuro, _) {
        final textColor = escuro ? Colors.white : Colors.black87;
        final subColor = escuro ? Colors.white60 : Colors.black45;
        final cardColor = escuro ? const Color(0xFF1A1A2E) : Colors.white;

        return ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ).copyWith(bottom: 100),
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    width: 44,
                    height: 44,
                    alignment: Alignment.center,
                    color: escuro ? const Color(0xFF335CAE) : Colors.white,
                    child: Image.asset(
                      escuro
                          ? 'assets/images/logo_branca.png'
                          : 'assets/images/logo.png',
                      width: 44,
                      height: 44,
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _saudacao(),
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _dataFormatada(),
                      style: TextStyle(color: subColor, fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            ValueListenableBuilder<List<Lembrete>>(
              valueListenable: lembretes,
              builder: (context, lista, _) {
                final concluidos = lista.where((l) => l.concluido).length;
                final total = lista.length;
                return Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1848B0),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Progresso de hoje',
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '$concluidos de $total lembretes',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: total > 0 ? concluidos / total : 0,
                          backgroundColor: Colors.white24,
                          valueColor: const AlwaysStoppedAnimation(
                            Colors.white,
                          ),
                          minHeight: 6,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            Text(
              'Acesso rápido',
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _QuickCard(
                  icon: Icons.photo_album_outlined,
                  label: 'Álbum',
                  color: const Color(0xFF7B5EA7),
                  escuro: escuro,
                  onTap: () {
                    context
                        .findAncestorStateOfType<_MainScreenState>()
                        ?._selectTab(3);
                  },
                ),
                const SizedBox(width: 12),
                _QuickCard(
                  icon: Icons.sports_esports_outlined,
                  label: 'Jogos',
                  color: const Color(0xFF0F6E56),
                  escuro: escuro,
                  onTap: () {
                    context
                        .findAncestorStateOfType<_MainScreenState>()
                        ?._selectTab(1);
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            _QuickCardWide(
              icon: Icons.notifications_outlined,
              label: 'Lembretes',
              color: const Color(0xFFBA7517),
              escuro: escuro,
              onTap: () {
                context.findAncestorStateOfType<_MainScreenState>()?._selectTab(
                  2,
                );
              },
            ),
            const SizedBox(height: 12),
            _QuickCardWide(
              icon: Icons.bedtime_outlined,
              label: 'Registrar horas de sono',
              color: const Color(0xFF993556),
              escuro: escuro,
              onTap: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => const _RegistrarSonoSheet(),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Rotina de hoje',
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ValueListenableBuilder<List<Compromisso>>(
              valueListenable: compromissos,
              builder: (context, lista, _) {
                final hoje = lista
                    .where((c) => _mesmodia(c.data, DateTime.now()))
                    .toList();
                if (hoje.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Nenhum compromisso hoje.',
                        style: TextStyle(color: subColor),
                      ),
                    ),
                  );
                }
                return Column(
                  children: hoje
                      .map(
                        (c) => _CompromissoCard(
                          c: c,
                          cardColor: cardColor,
                          textColor: textColor,
                          subColor: subColor,
                          escuro: escuro,
                        ),
                      )
                      .toList(),
                );
              },
            ),
            const SizedBox(height: 24),
            Text(
              'Lembretes de hoje',
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ValueListenableBuilder<List<Lembrete>>(
              valueListenable: lembretes,
              builder: (context, lista, _) {
                final pendentes = lista
                    .where((l) => !l.concluido)
                    .take(3)
                    .toList();
                if (pendentes.isEmpty) {
                  return Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1848B0).withOpacity(0.08),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Text(
                        '✓ Todos os lembretes concluídos!',
                        style: TextStyle(color: subColor),
                      ),
                    ),
                  );
                }
                return Column(
                  children: pendentes.map((l) {
                    final idx = lista.indexOf(l);
                    return GestureDetector(
                      onTap: () {
                        final nova = List<Lembrete>.from(lembretes.value);
                        nova[idx].concluido = true;
                        nova[idx].concluidoEm = DateTime.now();
                        lembretes.value = nova;
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFF1848B0,
                                ).withOpacity(0.08),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                l.icone,
                                color: const Color(0xFF1848B0),
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l.titulo,
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    l.descricao,
                                    style: TextStyle(
                                      color: subColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFF1848B0,
                                ).withOpacity(0.08),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                l.horario,
                                style: const TextStyle(
                                  color: Color(0xFF1848B0),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: 24),
            Text(
              'Pessoas visitadas recentemente',
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ValueListenableBuilder<List<VisitaRegistro>>(
              valueListenable: visitas,
              builder: (context, lista, _) {
                if (lista.isEmpty) {
                  return Text(
                    'Nenhuma visita registrada.',
                    style: TextStyle(color: subColor, fontSize: 13),
                  );
                }
                return Column(
                  children: lista.take(3).map((v) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0F6E56).withOpacity(0.12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.people_outline,
                              color: Color(0xFF0F6E56),
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  v.nomePessoa,
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  _formatarData(v.data),
                                  style: TextStyle(
                                    color: subColor,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        );
      },
    );
  }

  bool _mesmodia(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  String _formatarData(DateTime d) {
    final diff = DateTime.now().difference(d).inDays;
    if (diff == 0) return 'Hoje';
    if (diff == 1) return 'Ontem';
    return 'Há $diff dias';
  }
}

class _CompromissoCard extends StatelessWidget {
  final Compromisso c;
  final Color cardColor, textColor, subColor;
  final bool escuro;

  const _CompromissoCard({
    required this.c,
    required this.cardColor,
    required this.textColor,
    required this.subColor,
    required this.escuro,
  });

  @override
  Widget build(BuildContext context) {
    final idx = compromissos.value.indexOf(c);
    return GestureDetector(
      onTap: () {
        if (idx < 0) return;
        final nova = List<Compromisso>.from(compromissos.value);
        nova[idx].realizado = !nova[idx].realizado;
        compromissos.value = nova;
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: c.realizado
              ? const Color(0xFF1848B0).withOpacity(0.06)
              : cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: c.realizado
                ? const Color(0xFF1848B0).withOpacity(0.3)
                : Colors.transparent,
          ),
          boxShadow: c.realizado
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF1848B0).withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                c.realizado ? Icons.check_circle_outline : Icons.event_outlined,
                color: const Color(0xFF1848B0),
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    c.titulo,
                    style: TextStyle(
                      color: c.realizado ? subColor : textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      decoration: c.realizado
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  Text(
                    c.descricao,
                    style: TextStyle(color: subColor, fontSize: 12),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF1848B0).withOpacity(0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                c.horario,
                style: const TextStyle(
                  color: Color(0xFF1848B0),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _JogoModel {
  final String titulo, descricao, duracao;
  final IconData icone;
  final Color cor;
  final int duracaoMin;
  const _JogoModel({
    required this.titulo,
    required this.descricao,
    required this.duracao,
    required this.icone,
    required this.cor,
    required this.duracaoMin,
  });
}

const _jogosData = [
  _JogoModel(
    titulo: 'Sequência de cores',
    descricao: 'Memorize e repita a sequência.',
    duracao: '5 min',
    icone: Icons.color_lens_outlined,
    cor: Color(0xFF7B5EA7),
    duracaoMin: 5,
  ),
  _JogoModel(
    titulo: 'Complete a palavra',
    descricao: 'Forme palavras com letras embaralhadas.',
    duracao: '10 min',
    icone: Icons.text_fields_outlined,
    cor: Color(0xFF1848B0),
    duracaoMin: 10,
  ),
  _JogoModel(
    titulo: 'Encontre o par',
    descricao: 'Jogo da memória com figuras do cotidiano.',
    duracao: '8 min',
    icone: Icons.grid_view_outlined,
    cor: Color(0xFF0F6E56),
    duracaoMin: 8,
  ),
  _JogoModel(
    titulo: 'Calendário da memória',
    descricao: 'Treine sua memória episódica.',
    duracao: '5 min',
    icone: Icons.calendar_today_outlined,
    cor: Color(0xFFBA7517),
    duracaoMin: 5,
  ),
  _JogoModel(
    titulo: 'Respiração guiada',
    descricao: 'Exercício de relaxamento.',
    duracao: '5 min',
    icone: Icons.air_outlined,
    cor: Color(0xFF993556),
    duracaoMin: 5,
  ),
  _JogoModel(
    titulo: 'Leitura em voz alta',
    descricao: 'Leia e responda perguntas simples.',
    duracao: '15 min',
    icone: Icons.menu_book_outlined,
    cor: Color(0xFF854F0B),
    duracaoMin: 15,
  ),
];

class _JogosPage extends StatelessWidget {
  const _JogosPage();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: modoEscuro,
      builder: (context, escuro, _) {
        final textColor = escuro ? Colors.white : Colors.black87;
        final subColor = escuro ? Colors.white60 : Colors.black45;

        return ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ).copyWith(top: 20, bottom: 80),
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F6E56).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.sports_esports_outlined,
                    color: Color(0xFF0F6E56),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jogos interativos',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Exercite a memória com diversão',
                      style: TextStyle(color: subColor, fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1848B0).withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: const Color(0xFF1848B0).withOpacity(0.2),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.lightbulb_outline,
                    color: Color(0xFF1848B0),
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Dica do dia',
                          style: TextStyle(
                            color: Color(0xFF1848B0),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Exercícios cognitivos diários ajudam a retardar a progressão do Alzheimer.',
                          style: TextStyle(color: subColor, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Atividades disponíveis',
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.92,
              children: _jogosData.map((j) {
                return GestureDetector(
                  onTap: () => _mostrarDetalhes(context, j, escuro),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: escuro ? const Color(0xFF1A1A2E) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: j.cor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(j.icone, color: j.cor, size: 26),
                        ),
                        const Spacer(),
                        Text(
                          j.titulo,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          j.descricao,
                          style: TextStyle(color: subColor, fontSize: 11),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.timer_outlined, color: j.cor, size: 13),
                            const SizedBox(width: 4),
                            Text(
                              j.duracao,
                              style: TextStyle(
                                color: j.cor,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  void _mostrarDetalhes(BuildContext context, _JogoModel jogo, bool escuro) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _DetalhesJogoSheet(jogo: jogo, escuro: escuro),
    );
  }
}

class _DetalhesJogoSheet extends StatelessWidget {
  final _JogoModel jogo;
  final bool escuro;
  const _DetalhesJogoSheet({required this.jogo, required this.escuro});

  @override
  Widget build(BuildContext context) {
    final bg = escuro ? const Color(0xFF1A1A1A) : Colors.white;
    final textColor = escuro ? Colors.white : Colors.black87;
    final subColor = escuro ? Colors.white60 : Colors.black45;

    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: jogo.cor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(jogo.icone, color: jogo.cor, size: 36),
          ),
          const SizedBox(height: 16),
          Text(
            jogo.titulo,
            style: TextStyle(
              color: textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            jogo.descricao,
            style: TextStyle(color: subColor, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.timer_outlined, color: jogo.cor, size: 18),
              const SizedBox(width: 6),
              Text(
                'Duração: ${jogo.duracao}',
                style: TextStyle(color: jogo.cor, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                final stats = List<JogoStat>.from(jogoStats.value);
                final idx = stats.indexWhere((s) => s.titulo == jogo.titulo);
                if (idx >= 0) {
                  stats[idx].vezes++;
                  stats[idx].minutosTotais += jogo.duracaoMin;
                  stats[idx].ultimaVez = DateTime.now();
                  jogoStats.value = stats;
                }
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${jogo.titulo} — em breve!'),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.play_arrow_rounded),
              label: const Text(
                'Iniciar atividade',
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: jogo.cor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _LembretesPage extends StatelessWidget {
  const _LembretesPage();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: modoEscuro,
      builder: (context, escuro, _) {
        final textColor = escuro ? Colors.white : Colors.black87;
        final subColor = escuro ? Colors.white60 : Colors.black45;
        final cardColor = escuro ? const Color(0xFF1A1A2E) : Colors.white;
        final eCuidador = perfilAtivo.value == 'cuidador';

        return ValueListenableBuilder<List<Lembrete>>(
          valueListenable: lembretes,
          builder: (context, lista, _) {
            final pendentes = lista.where((l) => !l.concluido).toList();
            final concluidos = lista.where((l) => l.concluido).toList();

            return ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ).copyWith(top: 20, bottom: 100),
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFBA7517).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.notifications_outlined,
                        color: Color(0xFFBA7517),
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lembretes',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${pendentes.length} pendente(s) · ${concluidos.length} concluído(s)',
                          style: TextStyle(color: subColor, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (pendentes.isNotEmpty) ...[
                  Text(
                    'Pendentes',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...pendentes.map(
                    (l) => _LembreteCard(
                      lembrete: l,
                      indice: lista.indexOf(l),
                      cardColor: cardColor,
                      textColor: textColor,
                      subColor: subColor,
                      eCuidador: eCuidador,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                if (concluidos.isNotEmpty) ...[
                  Text(
                    'Concluídos hoje',
                    style: TextStyle(
                      color: subColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...concluidos.map(
                    (l) => _LembreteCard(
                      lembrete: l,
                      indice: lista.indexOf(l),
                      cardColor: cardColor,
                      textColor: textColor,
                      subColor: subColor,
                      eCuidador: eCuidador,
                    ),
                  ),
                ],
                if (lista.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 48),
                      child: Column(
                        children: [
                          Icon(
                            Icons.notifications_off_outlined,
                            color: subColor,
                            size: 48,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Nenhum lembrete ainda.\nToque no + para adicionar.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: subColor, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}

class _LembreteCard extends StatelessWidget {
  final Lembrete lembrete;
  final int indice;
  final Color cardColor, textColor, subColor;
  final bool eCuidador;

  const _LembreteCard({
    required this.lembrete,
    required this.indice,
    required this.cardColor,
    required this.textColor,
    required this.subColor,
    required this.eCuidador,
  });

  String _fmtHora(DateTime d) =>
      '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final l = lembrete;
    return Dismissible(
      key: UniqueKey(),
      direction: eCuidador
          ? DismissDirection.endToStart
          : DismissDirection.none,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
      ),
      onDismissed: (_) {
        final nova = List<Lembrete>.from(lembretes.value);
        nova.removeAt(indice);
        lembretes.value = nova;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lembrete "${l.titulo}" removido'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            action: SnackBarAction(
              label: 'Desfazer',
              onPressed: () {
                lembretes.value = [...lembretes.value, l];
              },
            ),
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          final nova = List<Lembrete>.from(lembretes.value);
          nova[indice].concluido = !nova[indice].concluido;
          if (nova[indice].concluido) {
            nova[indice].concluidoEm = DateTime.now();
          } else {
            nova[indice].concluidoEm = null;
          }
          lembretes.value = nova;
        },
        onLongPress: eCuidador
            ? () => _editarLembrete(context, l, indice)
            : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: l.concluido
                ? const Color(0xFF1848B0).withOpacity(0.08)
                : cardColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: l.concluido
                  ? const Color(0xFF1848B0).withOpacity(0.3)
                  : Colors.transparent,
            ),
            boxShadow: l.concluido
                ? []
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(
                        0xFF1848B0,
                      ).withOpacity(l.concluido ? 0.15 : 0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      l.concluido ? Icons.check_circle_outline : l.icone,
                      color: const Color(0xFF1848B0),
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l.titulo,
                          style: TextStyle(
                            color: l.concluido ? subColor : textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            decoration: l.concluido
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        Text(
                          l.descricao,
                          style: TextStyle(color: subColor, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1848B0).withOpacity(0.08),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          l.horario,
                          style: const TextStyle(
                            color: Color(0xFF1848B0),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (l.concluido && l.concluidoEm != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          'Concluído às ${_fmtHora(l.concluidoEm!)}',
                          style: TextStyle(color: subColor, fontSize: 10),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
              if (eCuidador)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    'Segure para editar · Deslize para excluir',
                    style: TextStyle(color: subColor, fontSize: 10),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _editarLembrete(BuildContext context, Lembrete l, int idx) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _EditarLembreteSheet(lembrete: l, indice: idx),
    );
  }
}

class _AlbumPage extends StatelessWidget {
  const _AlbumPage();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: modoEscuro,
      builder: (context, escuro, _) {
        final textColor = escuro ? Colors.white : Colors.black87;
        final subColor = escuro ? Colors.white60 : Colors.black45;
        final eCuidador = perfilAtivo.value == 'cuidador';

        return ValueListenableBuilder<List<Pessoa>>(
          valueListenable: pessoas,
          builder: (context, lista, _) {
            return ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ).copyWith(top: 20, bottom: 100),
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF7B5EA7).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.photo_album_outlined,
                        color: Color(0xFF7B5EA7),
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Álbum de memórias',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${lista.length} pessoa(s) cadastrada(s)',
                          style: TextStyle(color: subColor, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (lista.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 48),
                      child: Column(
                        children: [
                          Icon(
                            Icons.person_add_outlined,
                            color: subColor,
                            size: 48,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            eCuidador
                                ? 'Nenhuma pessoa.\nToque no + para adicionar.'
                                : 'Nenhuma pessoa cadastrada.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: subColor, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.85,
                    children: lista.asMap().entries.map((entry) {
                      final idx = entry.key;
                      final p = entry.value;
                      return GestureDetector(
                        onTap: () =>
                            _verDetalhes(context, p, idx, escuro, eCuidador),
                        child: Container(
                          decoration: BoxDecoration(
                            color: escuro
                                ? const Color(0xFF1A1A2E)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 72,
                                height: 72,
                                decoration: BoxDecoration(
                                  color: p.cor.withOpacity(0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(p.icone, color: p.cor, size: 36),
                              ),
                              const SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Text(
                                  p.nome,
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: p.cor.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  p.relacao,
                                  style: TextStyle(
                                    color: p.cor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  void _verDetalhes(
    BuildContext context,
    Pessoa p,
    int idx,
    bool escuro,
    bool eCuidador,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _DetalhesPessoaSheet(
        pessoa: p,
        indice: idx,
        escuro: escuro,
        eCuidador: eCuidador,
      ),
    );
  }
}

class _DetalhesPessoaSheet extends StatelessWidget {
  final Pessoa pessoa;
  final int indice;
  final bool escuro, eCuidador;

  const _DetalhesPessoaSheet({
    required this.pessoa,
    required this.indice,
    required this.escuro,
    required this.eCuidador,
  });

  @override
  Widget build(BuildContext context) {
    final bg = escuro ? const Color(0xFF1A1A1A) : Colors.white;
    final textColor = escuro ? Colors.white : Colors.black87;
    final subColor = escuro ? Colors.white60 : Colors.black45;
    final p = pessoa;

    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: p.cor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(p.icone, color: p.cor, size: 46),
          ),
          const SizedBox(height: 16),
          Text(
            p.nome,
            style: TextStyle(
              color: textColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: p.cor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              p.relacao,
              style: TextStyle(
                color: p.cor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: escuro ? const Color(0xFF2A2A3E) : const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              p.descricao,
              style: TextStyle(color: subColor, fontSize: 14, height: 1.5),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              if (eCuidador) ...[
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => _EditarPessoaSheet(
                          pessoa: p,
                          indice: indice,
                          escuro: escuro,
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.edit_outlined,
                      color: Color(0xFF1848B0),
                    ),
                    label: const Text(
                      'Editar',
                      style: TextStyle(color: Color(0xFF1848B0)),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF1848B0)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _confirmarExclusao(context, p);
                    },
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    label: const Text(
                      'Remover',
                      style: TextStyle(color: Colors.red),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  label: const Text('Fechar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1848B0),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  void _confirmarExclusao(BuildContext context, Pessoa p) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Remover pessoa'),
        content: Text('Deseja remover ${p.nome} do álbum?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              final nova = List<Pessoa>.from(pessoas.value);
              nova.removeAt(indice);
              pessoas.value = nova;
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${p.nome} removido do álbum'),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            child: const Text('Remover', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _QuickCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool escuro;
  final VoidCallback onTap;

  const _QuickCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.escuro,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardBg = escuro ? const Color(0xFF1A1A2E) : Colors.white;
    final textColor = escuro ? Colors.white : Colors.black87;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 120,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(height: 10),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickCardWide extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool escuro;
  final VoidCallback onTap;

  const _QuickCardWide({
    required this.icon,
    required this.label,
    required this.color,
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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right,
              color: escuro ? Colors.white38 : Colors.black26,
            ),
          ],
        ),
      ),
    );
  }
}

class _EditarLembreteSheet extends StatefulWidget {
  final Lembrete lembrete;
  final int indice;
  const _EditarLembreteSheet({required this.lembrete, required this.indice});
  @override
  State<_EditarLembreteSheet> createState() => _EditarLembreteSheetState();
}

class _EditarLembreteSheetState extends State<_EditarLembreteSheet> {
  late TextEditingController _titulo, _desc;
  late TimeOfDay _horario;
  late IconData _icone;

  final _icones = [
    Icons.medication_outlined,
    Icons.local_drink_outlined,
    Icons.psychology_outlined,
    Icons.directions_walk_outlined,
    Icons.restaurant_outlined,
    Icons.people_outline,
    Icons.notifications_outlined,
    Icons.bedtime_outlined,
  ];

  @override
  void initState() {
    super.initState();
    _titulo = TextEditingController(text: widget.lembrete.titulo);
    _desc = TextEditingController(text: widget.lembrete.descricao);
    final parts = widget.lembrete.horario.split(':');
    _horario = TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
    _icone = widget.lembrete.icone;
  }

  @override
  void dispose() {
    _titulo.dispose();
    _desc.dispose();
    super.dispose();
  }

  void _salvar() {
    if (_titulo.text.trim().isEmpty) return;
    final nova = List<Lembrete>.from(lembretes.value);
    nova[widget.indice].titulo = _titulo.text.trim();
    nova[widget.indice].descricao = _desc.text.trim().isEmpty
        ? 'Sem descrição'
        : _desc.text.trim();
    nova[widget.indice].horario =
        '${_horario.hour.toString().padLeft(2, '0')}:${_horario.minute.toString().padLeft(2, '0')}';
    nova[widget.indice].icone = _icone;
    lembretes.value = nova;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: modoEscuro,
      builder: (context, escuro, _) {
        final bg = escuro ? const Color(0xFF1A1A1A) : Colors.white;
        final textColor = escuro ? Colors.white : Colors.black87;
        final subColor = escuro ? Colors.white60 : Colors.black45;
        return Container(
          decoration: BoxDecoration(
            color: bg,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Editar lembrete',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _titulo,
                  style: TextStyle(color: textColor),
                  decoration: InputDecoration(
                    labelText: 'Título',
                    labelStyle: TextStyle(color: Colors.grey[500]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _desc,
                  style: TextStyle(color: textColor),
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: 'Descrição',
                    labelStyle: TextStyle(color: Colors.grey[500]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () async {
                    final p = await showTimePicker(
                      context: context,
                      initialTime: _horario,
                    );
                    if (p != null) setState(() => _horario = p);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: Color(0xFF1848B0),
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${_horario.hour.toString().padLeft(2, '0')}:${_horario.minute.toString().padLeft(2, '0')}',
                          style: TextStyle(color: textColor, fontSize: 16),
                        ),
                        const Spacer(),
                        Text(
                          'Alterar horário',
                          style: TextStyle(color: subColor, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text('Ícone', style: TextStyle(color: subColor, fontSize: 13)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: _icones.map((ic) {
                    final sel = ic == _icone;
                    return GestureDetector(
                      onTap: () => setState(() => _icone = ic),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: sel
                              ? const Color(0xFF1848B0)
                              : const Color(0xFF1848B0).withOpacity(0.08),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          ic,
                          color: sel ? Colors.white : const Color(0xFF1848B0),
                          size: 22,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _salvar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1848B0),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Salvar alterações',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CriarLembreteSheet extends StatefulWidget {
  const _CriarLembreteSheet();
  @override
  State<_CriarLembreteSheet> createState() => _CriarLembreteSheetState();
}

class _CriarLembreteSheetState extends State<_CriarLembreteSheet> {
  final _titulo = TextEditingController();
  final _desc = TextEditingController();
  TimeOfDay _horario = TimeOfDay.now();
  IconData _icone = Icons.notifications_outlined;

  final _icones = [
    Icons.medication_outlined,
    Icons.local_drink_outlined,
    Icons.psychology_outlined,
    Icons.directions_walk_outlined,
    Icons.restaurant_outlined,
    Icons.people_outline,
    Icons.notifications_outlined,
    Icons.bedtime_outlined,
  ];

  @override
  void dispose() {
    _titulo.dispose();
    _desc.dispose();
    super.dispose();
  }

  void _salvar() {
    if (_titulo.text.trim().isEmpty) return;
    final h = _horario.hour.toString().padLeft(2, '0');
    final m = _horario.minute.toString().padLeft(2, '0');
    lembretes.value = [
      ...lembretes.value,
      Lembrete(
        titulo: _titulo.text.trim(),
        descricao: _desc.text.trim().isEmpty
            ? 'Sem descrição'
            : _desc.text.trim(),
        horario: '$h:$m',
        icone: _icone,
      ),
    ];
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: modoEscuro,
      builder: (context, escuro, _) {
        final bg = escuro ? const Color(0xFF1A1A1A) : Colors.white;
        final textColor = escuro ? Colors.white : Colors.black87;
        final subColor = escuro ? Colors.white60 : Colors.black45;
        return Container(
          decoration: BoxDecoration(
            color: bg,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Novo lembrete',
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _titulo,
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  labelText: 'Título *',
                  labelStyle: TextStyle(color: Colors.grey[500]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _desc,
                style: TextStyle(color: textColor),
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  labelStyle: TextStyle(color: Colors.grey[500]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () async {
                  final p = await showTimePicker(
                    context: context,
                    initialTime: _horario,
                  );
                  if (p != null) setState(() => _horario = p);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: Color(0xFF1848B0),
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${_horario.hour.toString().padLeft(2, '0')}:${_horario.minute.toString().padLeft(2, '0')}',
                        style: TextStyle(color: textColor, fontSize: 16),
                      ),
                      const Spacer(),
                      Text(
                        'Alterar horário',
                        style: TextStyle(color: subColor, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text('Ícone', style: TextStyle(color: subColor, fontSize: 13)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: _icones.map((ic) {
                  final sel = ic == _icone;
                  return GestureDetector(
                    onTap: () => setState(() => _icone = ic),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: sel
                            ? const Color(0xFF1848B0)
                            : const Color(0xFF1848B0).withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        ic,
                        color: sel ? Colors.white : const Color(0xFF1848B0),
                        size: 22,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _salvar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1848B0),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Salvar lembrete',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AdicionarPessoaSheet extends StatefulWidget {
  const _AdicionarPessoaSheet();
  @override
  State<_AdicionarPessoaSheet> createState() => _AdicionarPessoaSheetState();
}

class _AdicionarPessoaSheetState extends State<_AdicionarPessoaSheet> {
  final _nome = TextEditingController();
  final _relacao = TextEditingController();
  final _desc = TextEditingController();

  final _cores = [
    const Color(0xFF1848B0),
    const Color(0xFF7B5EA7),
    const Color(0xFF0F6E56),
    const Color(0xFFBA7517),
    const Color(0xFF993556),
    const Color(0xFF854F0B),
  ];
  Color _cor = const Color(0xFF1848B0);

  @override
  void dispose() {
    _nome.dispose();
    _relacao.dispose();
    _desc.dispose();
    super.dispose();
  }

  void _salvar() {
    if (_nome.text.trim().isEmpty) return;
    pessoas.value = [
      ...pessoas.value,
      Pessoa(
        nome: _nome.text.trim(),
        relacao: _relacao.text.trim().isEmpty
            ? 'Familiar'
            : _relacao.text.trim(),
        descricao: _desc.text.trim().isEmpty
            ? 'Sem descrição'
            : _desc.text.trim(),
        icone: Icons.person,
        cor: _cor,
      ),
    ];
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: modoEscuro,
      builder: (context, escuro, _) {
        final bg = escuro ? const Color(0xFF1A1A1A) : Colors.white;
        final textColor = escuro ? Colors.white : Colors.black87;
        final subColor = escuro ? Colors.white60 : Colors.black45;
        return Container(
          decoration: BoxDecoration(
            color: bg,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Adicionar pessoa ao álbum',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _nome,
                  style: TextStyle(color: textColor),
                  decoration: InputDecoration(
                    labelText: 'Nome *',
                    labelStyle: TextStyle(color: Colors.grey[500]),
                    prefixIcon: const Icon(
                      Icons.person_outline,
                      color: Color(0xFF1848B0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _relacao,
                  style: TextStyle(color: textColor),
                  decoration: InputDecoration(
                    labelText: 'Relação (ex: Filha, Médico)',
                    labelStyle: TextStyle(color: Colors.grey[500]),
                    prefixIcon: const Icon(
                      Icons.people_outline,
                      color: Color(0xFF1848B0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _desc,
                  style: TextStyle(color: textColor),
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: 'Descrição / como reconhecer',
                    labelStyle: TextStyle(color: Colors.grey[500]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Cor do cartão',
                  style: TextStyle(color: subColor, fontSize: 13),
                ),
                const SizedBox(height: 8),
                Row(
                  children: _cores.map((c) {
                    final sel = c == _cor;
                    return GestureDetector(
                      onTap: () => setState(() => _cor = c),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(right: 10),
                        width: sel ? 40 : 34,
                        height: sel ? 40 : 34,
                        decoration: BoxDecoration(
                          color: c,
                          shape: BoxShape.circle,
                          border: sel
                              ? Border.all(color: Colors.white, width: 3)
                              : null,
                          boxShadow: sel
                              ? [
                                  BoxShadow(
                                    color: c.withOpacity(0.5),
                                    blurRadius: 8,
                                  ),
                                ]
                              : null,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _salvar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1848B0),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Adicionar ao álbum',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _EditarPessoaSheet extends StatefulWidget {
  final Pessoa pessoa;
  final int indice;
  final bool escuro;
  const _EditarPessoaSheet({
    required this.pessoa,
    required this.indice,
    required this.escuro,
  });
  @override
  State<_EditarPessoaSheet> createState() => _EditarPessoaSheetState();
}

class _EditarPessoaSheetState extends State<_EditarPessoaSheet> {
  late TextEditingController _nome, _relacao, _desc;
  final _cores = [
    const Color(0xFF1848B0),
    const Color(0xFF7B5EA7),
    const Color(0xFF0F6E56),
    const Color(0xFFBA7517),
    const Color(0xFF993556),
    const Color(0xFF854F0B),
  ];
  late Color _cor;

  @override
  void initState() {
    super.initState();
    _nome = TextEditingController(text: widget.pessoa.nome);
    _relacao = TextEditingController(text: widget.pessoa.relacao);
    _desc = TextEditingController(text: widget.pessoa.descricao);
    _cor = widget.pessoa.cor;
  }

  @override
  void dispose() {
    _nome.dispose();
    _relacao.dispose();
    _desc.dispose();
    super.dispose();
  }

  void _salvar() {
    if (_nome.text.trim().isEmpty) return;
    final nova = List<Pessoa>.from(pessoas.value);
    nova[widget.indice] = Pessoa(
      nome: _nome.text.trim(),
      relacao: _relacao.text.trim().isEmpty ? 'Familiar' : _relacao.text.trim(),
      descricao: _desc.text.trim().isEmpty
          ? 'Sem descrição'
          : _desc.text.trim(),
      icone: Icons.person,
      cor: _cor,
    );
    pessoas.value = nova;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final escuro = widget.escuro;
    final bg = escuro ? const Color(0xFF1A1A1A) : Colors.white;
    final textColor = escuro ? Colors.white : Colors.black87;
    final subColor = escuro ? Colors.white60 : Colors.black45;
    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Editar pessoa',
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nome,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                labelText: 'Nome *',
                labelStyle: TextStyle(color: Colors.grey[500]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _relacao,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                labelText: 'Relação',
                labelStyle: TextStyle(color: Colors.grey[500]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _desc,
              style: TextStyle(color: textColor),
              maxLines: 2,
              decoration: InputDecoration(
                labelText: 'Descrição / como reconhecer',
                labelStyle: TextStyle(color: Colors.grey[500]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Cor do cartão',
              style: TextStyle(color: subColor, fontSize: 13),
            ),
            const SizedBox(height: 8),
            Row(
              children: _cores.map((c) {
                final sel = c == _cor;
                return GestureDetector(
                  onTap: () => setState(() => _cor = c),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 10),
                    width: sel ? 40 : 34,
                    height: sel ? 40 : 34,
                    decoration: BoxDecoration(
                      color: c,
                      shape: BoxShape.circle,
                      border: sel
                          ? Border.all(color: Colors.white, width: 3)
                          : null,
                      boxShadow: sel
                          ? [
                              BoxShadow(
                                color: c.withOpacity(0.5),
                                blurRadius: 8,
                              ),
                            ]
                          : null,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _salvar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1848B0),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Salvar alterações',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RegistrarSonoSheet extends StatefulWidget {
  const _RegistrarSonoSheet();
  @override
  State<_RegistrarSonoSheet> createState() => _RegistrarSonoSheetState();
}

class _RegistrarSonoSheetState extends State<_RegistrarSonoSheet> {
  double _horas = 7;

  void _salvar() {
    registrosSono.value = [
      RegistroSono(data: DateTime.now(), horas: _horas),
      ...registrosSono.value,
    ];
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sono registrado: ${_horas}h'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: modoEscuro,
      builder: (context, escuro, _) {
        final bg = escuro ? const Color(0xFF1A1A1A) : Colors.white;
        final textColor = escuro ? Colors.white : Colors.black87;
        return Container(
          decoration: BoxDecoration(
            color: bg,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Icon(
                Icons.bedtime_outlined,
                color: Color(0xFF993556),
                size: 40,
              ),
              const SizedBox(height: 12),
              Text(
                'Quantas horas você dormiu?',
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '${_horas.toStringAsFixed(1)}h',
                style: const TextStyle(
                  color: Color(0xFF993556),
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Slider(
                value: _horas,
                min: 1,
                max: 12,
                divisions: 22,
                activeColor: const Color(0xFF993556),
                onChanged: (v) => setState(() => _horas = (v * 2).round() / 2),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _salvar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF993556),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Registrar',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RegistrarEsquecimentoSheet extends StatefulWidget {
  const _RegistrarEsquecimentoSheet();
  @override
  State<_RegistrarEsquecimentoSheet> createState() =>
      _RegistrarEsquecimentoSheetState();
}

class _RegistrarEsquecimentoSheetState
    extends State<_RegistrarEsquecimentoSheet> {
  final _desc = TextEditingController();

  @override
  void dispose() {
    _desc.dispose();
    super.dispose();
  }

  void _salvar() {
    if (_desc.text.trim().isEmpty) return;
    esquecimentos.value = [
      EsquecimentoRegistro(data: DateTime.now(), descricao: _desc.text.trim()),
      ...esquecimentos.value,
    ];
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: modoEscuro,
      builder: (context, escuro, _) {
        final bg = escuro ? const Color(0xFF1A1A1A) : Colors.white;
        final textColor = escuro ? Colors.white : Colors.black87;
        return Container(
          decoration: BoxDecoration(
            color: bg,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Registrar episódio de esquecimento',
                style: TextStyle(
                  color: textColor,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _desc,
                style: TextStyle(color: textColor),
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Descreva o que aconteceu',
                  labelStyle: TextStyle(color: Colors.grey[500]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _salvar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Registrar',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RegistrarVisitaSheet extends StatefulWidget {
  const _RegistrarVisitaSheet();
  @override
  State<_RegistrarVisitaSheet> createState() => _RegistrarVisitaSheetState();
}

class _RegistrarVisitaSheetState extends State<_RegistrarVisitaSheet> {
  final _nome = TextEditingController();

  @override
  void dispose() {
    _nome.dispose();
    super.dispose();
  }

  void _salvar() {
    if (_nome.text.trim().isEmpty) return;
    visitas.value = [
      VisitaRegistro(data: DateTime.now(), nomePessoa: _nome.text.trim()),
      ...visitas.value,
    ];
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: modoEscuro,
      builder: (context, escuro, _) {
        final bg = escuro ? const Color(0xFF1A1A1A) : Colors.white;
        final textColor = escuro ? Colors.white : Colors.black87;
        final pessoasCad = pessoas.value;
        return Container(
          decoration: BoxDecoration(
            color: bg,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Registrar visita',
                style: TextStyle(
                  color: textColor,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _nome,
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  labelText: 'Nome da pessoa visitada',
                  labelStyle: TextStyle(color: Colors.grey[500]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              if (pessoasCad.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  'Ou selecione do álbum:',
                  style: TextStyle(
                    color: textColor.withOpacity(0.6),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: pessoasCad.map((p) {
                    return GestureDetector(
                      onTap: () {
                        setState(() => _nome.text = p.nome);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: p.cor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          p.nome,
                          style: TextStyle(
                            color: p.cor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _salvar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F6E56),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Registrar visita',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ConfigSheet extends StatelessWidget {
  const _ConfigSheet();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: modoEscuro,
      builder: (context, escuro, _) {
        final bg = escuro ? const Color(0xFF1A1A1A) : Colors.white;
        final textColor = escuro ? Colors.white : Colors.black87;

        return Container(
          decoration: BoxDecoration(
            color: bg,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).padding.bottom + 24,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Configurações',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _ConfigItem(
                  escuro: escuro,
                  icon: Icons.swap_horiz_outlined,
                  label: 'Trocar perfil',
                  trailing: Text(
                    perfilAtivo.value == 'cuidador'
                        ? 'Cuidador'
                        : 'Pessoa Assistida',
                    style: const TextStyle(
                      color: Color(0xFF1848B0),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => const SelecaoPerfilScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                _ConfigItem(
                  escuro: escuro,
                  icon: Icons.dark_mode_outlined,
                  label: 'Modo escuro',
                  trailing: Switch(
                    value: escuro,
                    activeThumbColor: const Color(0xFF1848B0),
                    onChanged: (v) => modoEscuro.value = v,
                  ),
                ),
                const SizedBox(height: 10),
                ValueListenableBuilder<double>(
                  valueListenable: escalaFonte,
                  builder: (context, escala, _) {
                    return _ConfigItem(
                      escuro: escuro,
                      icon: Icons.text_fields_outlined,
                      label: 'Tamanho da fonte',
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (escalaFonte.value > 0.8) {
                                escalaFonte.value -= 0.1;
                              }
                            },
                            icon: const Icon(Icons.remove, size: 18),
                            color: const Color(0xFF1848B0),
                          ),
                          Text(
                            '${(escala * 100).round()}%',
                            style: const TextStyle(
                              color: Color(0xFF1848B0),
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (escalaFonte.value < 1.5) {
                                escalaFonte.value += 0.1;
                              }
                            },
                            icon: const Icon(Icons.add, size: 18),
                            color: const Color(0xFF1848B0),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                ValueListenableBuilder<String>(
                  valueListenable: tipoFonte,
                  builder: (context, fonte, _) {
                    return _ConfigItem(
                      escuro: escuro,
                      icon: Icons.font_download_outlined,
                      label: 'Tipo de fonte',
                      trailing: DropdownButton<String>(
                        value: fonte,
                        dropdownColor: bg,
                        underline: const SizedBox(),
                        style: const TextStyle(
                          color: Color(0xFF1848B0),
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                        items: ['Padrão', 'Serif', 'Mono']
                            .map(
                              (f) => DropdownMenuItem(value: f, child: Text(f)),
                            )
                            .toList(),
                        onChanged: (v) {
                          if (v != null) tipoFonte.value = v;
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                ValueListenableBuilder<double>(
                  valueListenable: escalaFonte,
                  builder: (context, escala, _) {
                    return _ConfigItem(
                      escuro: escuro,
                      icon: Icons.aspect_ratio_outlined,
                      label: 'Tamanho dos elementos',
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (escalaFonte.value > 0.8) {
                                escalaFonte.value -= 0.1;
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1848B0).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Icon(
                                Icons.remove,
                                size: 16,
                                color: Color(0xFF1848B0),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            escala <= 0.9
                                ? 'Pequeno'
                                : escala <= 1.1
                                ? 'Normal'
                                : 'Grande',
                            style: const TextStyle(
                              color: Color(0xFF1848B0),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              if (escalaFonte.value < 1.5) {
                                escalaFonte.value += 0.1;
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1848B0).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Icon(
                                Icons.add,
                                size: 16,
                                color: Color(0xFF1848B0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                _ConfigItem(
                  escuro: escuro,
                  icon: Icons.cleaning_services_outlined,
                  label: 'Limpar lembretes concluídos',
                  trailing: Icon(
                    Icons.chevron_right,
                    color: escuro ? Colors.white38 : Colors.black26,
                  ),
                  onTap: () {
                    lembretes.value = lembretes.value
                        .where((l) => !l.concluido)
                        .toList();
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Lembretes concluídos removidos'),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: escuro
                        ? const Color(0xFF2A2A3E)
                        : const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline, color: Color(0xFF1848B0)),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mente Viva',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Text(
                            'Versão 1.0.0 · IFPR 2025',
                            style: TextStyle(
                              color: Color(0xFF1848B0),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ConfigItem extends StatelessWidget {
  final bool escuro;
  final IconData icon;
  final String label;
  final Widget trailing;
  final VoidCallback? onTap;

  const _ConfigItem({
    required this.escuro,
    required this.icon,
    required this.label,
    required this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = escuro ? Colors.white : Colors.black87;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: escuro ? const Color(0xFF2A2A3E) : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF1848B0)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(color: textColor, fontSize: 15),
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final int index;
  final int currentIndex;
  final Color selectedColor;
  final Color iconColor;
  final ValueChanged<int> onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.selectedColor,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = index == currentIndex;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSelected ? activeIcon : icon,
            color: isSelected ? selectedColor : iconColor,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? selectedColor : iconColor,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
