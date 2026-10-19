import 'package:flutter_test/flutter_test.dart';
import 'package:personal_vault/core/db/database.dart';
import 'package:personal_vault/modules/ideas/data/prompt_chat.dart';
import 'package:personal_vault/modules/ideas/data/sugerencias.dart';

Idea _idea(
  int id,
  String titulo, {
  String formato = FormatoIdea.carrusel,
  String tags = '',
  String estado = EstadoIdea.idea,
  int? guardados,
  int? likes,
  DateTime? creada,
}) => Idea(
  id: id,
  titulo: titulo,
  formato: formato,
  tags: tags,
  estado: estado,
  guardados: guardados,
  likes: likes,
  origen: OrigenIdea.manual,
  creadaEn: creada ?? DateTime(2026, 10, 10),
);

void main() {
  final ahora = DateTime(2026, 10, 19);

  group('sugerirPorReglas', () {
    test('banco vacío: usa temas iniciales y no repite', () {
      final s = sugerirPorReglas([], ahora: ahora);
      expect(s, hasLength(8));
      expect(s.map((x) => normalizar(x.titulo)).toSet(), hasLength(8));
    });

    test('detecta huecos de formato, parte 2 y temas olvidados', () {
      final ideas = [
        _idea(1, 'Flexbox en 5 pasos', tags: 'css'),
        _idea(2, 'Grid vs Flexbox', tags: 'css'),
        _idea(
          3,
          'Closures explicados',
          formato: FormatoIdea.reel,
          tags: 'javascript',
          estado: EstadoIdea.publicado,
          guardados: 120,
          likes: 900,
        ),
        _idea(4, 'Comandos de Git', tags: 'git', creada: DateTime(2026, 8, 1)),
      ];
      final titulos = sugerirPorReglas(
        ideas,
        ahora: ahora,
        maximo: 20,
      ).map((s) => s.titulo).toList();

      expect(titulos, contains('Parte 2: Closures explicados'));
      expect(
        titulos,
        contains('CSS en 30 segundos: el truco que nadie te enseñó'),
      );
      expect(titulos, contains('Lo nuevo de Git en 2026'));
      // No propone algo que ya está en el banco.
      expect(
        titulos.map(normalizar),
        isNot(contains(normalizar('Grid vs Flexbox'))),
      );
    });

    test('descartadas no vuelven a aparecer', () {
      final primera = sugerirPorReglas([], ahora: ahora).first;
      final otra = sugerirPorReglas(
        [],
        ahora: ahora,
        descartadas: {normalizar(primera.titulo)},
      );
      expect(otra.map((s) => s.titulo), isNot(contains(primera.titulo)));
    });
  });

  group('chat de IA', () {
    test('el prompt incluye ideas y mejores publicaciones', () {
      final p = construirPrompt([
        _idea(
          1,
          'Closures explicados',
          tags: 'javascript',
          estado: EstadoIdea.publicado,
          guardados: 50,
        ),
      ]);
      expect(p, contains('- Closures explicados [carrusel; javascript]'));
      expect(p, contains('Closures explicados (50 guardados, 0 likes)'));
      expect(p, contains('Título | formato | tag1, tag2 | gancho'));
    });

    test('parsea la respuesta tolerando numeración y markdown', () {
      const respuesta = '''
Aquí tienes 3 ideas:
1. **Promesas en 60 segundos** | Reel | javascript, async | "¿Tu código no espera?"
- Guía de selectores CSS | carrusel | css
* Título | formato | tag1 | gancho
Una línea sin separador
Mito: Python es lento | historia | python, mitos | ¿Verdad o mentira? | parte 2
''';
      final s = parsearRespuesta(respuesta);
      expect(s.map((x) => x.titulo), [
        'Promesas en 60 segundos',
        'Guía de selectores CSS',
        'Mito: Python es lento',
      ]);
      expect(s[0].formato, FormatoIdea.reel);
      expect(s[0].tags, ['javascript', 'async']);
      expect(s[0].hook, '"¿Tu código no espera?"');
      expect(s[1].hook, isNull);
      expect(s[2].formato, FormatoIdea.historia);
      expect(s[2].hook, '¿Verdad o mentira? | parte 2');
    });
  });
}
