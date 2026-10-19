import 'dart:math';

import '../../../core/db/database.dart';

/// Una idea propuesta (por reglas o por un chat de IA) que aún no se guarda.
class Sugerencia {
  const Sugerencia({
    required this.titulo,
    required this.formato,
    required this.tags,
    this.razon,
    this.hook,
  });

  final String titulo;
  final String formato;
  final List<String> tags;

  /// Por qué se sugiere ("Tienes 4 ideas de CSS y ninguna en reel").
  final String? razon;
  final String? hook;
}

List<String> tagsDe(Idea idea) => separarTags(idea.tags);

List<String> separarTags(String texto) => [
  for (final t in texto.split(RegExp(r'[,#]')))
    if (t.trim().isNotEmpty) t.trim().toLowerCase(),
];

const _nombresBonitos = {
  'javascript': 'JavaScript',
  'typescript': 'TypeScript',
  'css': 'CSS',
  'html': 'HTML',
  'sql': 'SQL',
  'ia': 'IA',
  'ai': 'IA',
  'api': 'APIs',
  'apis': 'APIs',
  'git': 'Git',
  'github': 'GitHub',
  'react': 'React',
  'python': 'Python',
  'java': 'Java',
  'node': 'Node.js',
  'nodejs': 'Node.js',
  'flutter': 'Flutter',
  'vscode': 'VS Code',
  'linux': 'Linux',
  'docker': 'Docker',
};

String nombreTema(String tag) =>
    _nombresBonitos[tag] ??
    (tag.isEmpty ? tag : tag[0].toUpperCase() + tag.substring(1));

/// Temas por defecto cuando el banco aún está vacío.
const temasIniciales = [
  'javascript',
  'python',
  'css',
  'git',
  'ia',
  'carrera dev',
];

/// Plantillas de series que suelen funcionar. `{T}` = tema, `{T2}` = otro tema.
const _plantillas = [
  ('5 errores comunes en {T} (y cómo evitarlos)', FormatoIdea.carrusel),
  ('{T}: ¿mito o realidad?', FormatoIdea.reel),
  ('Cómo le explicaría {T} a mi mamá', FormatoIdea.reel),
  ('{T} vs {T2}: ¿cuál aprender primero?', FormatoIdea.carrusel),
  ('Roadmap para aprender {T} desde cero', FormatoIdea.carrusel),
  ('3 proyectos para practicar {T}', FormatoIdea.carrusel),
  ('Pregunta de entrevista técnica sobre {T}', FormatoIdea.reel),
  ('Lo que me hubiera gustado saber antes de aprender {T}', FormatoIdea.reel),
  ('Atajos de {T} que te ahorran horas', FormatoIdea.reel),
  ('¿Vale la pena aprender {T} en {A}?', FormatoIdea.reel),
  ('Chuleta (cheatsheet) de {T} para guardar', FormatoIdea.post),
  ('Encuesta: ¿qué es lo más difícil de {T}?', FormatoIdea.historia),
];

const _plantillaPorFormato = {
  FormatoIdea.reel: '{T} en 30 segundos: el truco que nadie te enseñó',
  FormatoIdea.carrusel: 'Guía rápida de {T} en 5 slides',
  FormatoIdea.post: 'Chuleta (cheatsheet) de {T} para guardar',
  FormatoIdea.historia: 'Encuesta: ¿qué te cuesta más de {T}?',
};

const nombresFormato = {
  FormatoIdea.reel: 'reel',
  FormatoIdea.carrusel: 'carrusel',
  FormatoIdea.post: 'post',
  FormatoIdea.historia: 'historia',
};

/// Normaliza un título para detectar repetidos (sin tildes ni signos).
String normalizar(String texto) {
  const tildes = {
    'á': 'a',
    'é': 'e',
    'í': 'i',
    'ó': 'o',
    'ú': 'u',
    'ü': 'u',
    'ñ': 'n',
  };
  final minus = texto.toLowerCase();
  final sb = StringBuffer();
  for (final c in minus.split('')) {
    sb.write(tildes[c] ?? c);
  }
  return sb
      .toString()
      .replaceAll(RegExp(r'[^a-z0-9 ]'), '')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
}

int _puntaje(Idea i) =>
    (i.guardados ?? 0) * 3 + (i.comentarios ?? 0) * 2 + (i.likes ?? 0);

/// Motor de reglas: propone ideas a partir del banco, sin internet ni IA.
///
/// [semilla] cambia el orden de las plantillas para "ver otras sugerencias".
List<Sugerencia> sugerirPorReglas(
  List<Idea> ideas, {
  required DateTime ahora,
  int semilla = 0,
  int maximo = 8,
  Set<String> descartadas = const {},
}) {
  final existentes = {
    for (final i in ideas) normalizar(i.titulo),
    ...descartadas,
  };
  final resultado = <Sugerencia>[];

  void agregar(Sugerencia s) {
    final clave = normalizar(s.titulo);
    if (existentes.add(clave)) resultado.add(s);
  }

  // Frecuencia de cada tema, del más usado al menos usado.
  final porTema = <String, List<Idea>>{};
  for (final i in ideas) {
    for (final t in tagsDe(i)) {
      porTema.putIfAbsent(t, () => []).add(i);
    }
  }
  final temas = porTema.keys.toList()
    ..sort((a, b) => porTema[b]!.length.compareTo(porTema[a]!.length));
  final temasBase = temas.isEmpty ? temasIniciales : temas;
  String aplicar(String plantilla, String tema, {String? otro}) => plantilla
      .replaceAll('{T}', nombreTema(tema))
      .replaceAll('{T2}', nombreTema(otro ?? tema))
      .replaceAll('{A}', '${ahora.year}');

  // 1. Lo que mejor funcionó → parte 2 o en otro formato.
  final publicadas =
      ideas
          .where((i) => i.estado == EstadoIdea.publicado && _puntaje(i) > 0)
          .toList()
        ..sort((a, b) => _puntaje(b).compareTo(_puntaje(a)));
  for (final i in publicadas.take(2)) {
    final metricas = [
      if ((i.guardados ?? 0) > 0) '${i.guardados} guardados',
      if ((i.likes ?? 0) > 0) '${i.likes} likes',
    ].join(', ');
    agregar(
      Sugerencia(
        titulo: 'Parte 2: ${i.titulo}',
        formato: i.formato,
        tags: tagsDe(i),
        razon: 'Fue de tus mejores publicaciones ($metricas)',
      ),
    );
    if (i.formato != FormatoIdea.reel) {
      agregar(
        Sugerencia(
          titulo: '${i.titulo} (versión reel)',
          formato: FormatoIdea.reel,
          tags: tagsDe(i),
          razon: 'Funcionó en ${nombresFormato[i.formato]}; pruébalo en video',
        ),
      );
    }
  }

  // 2. Huecos: temas con varias ideas pero sin cierto formato.
  for (final t in temas.take(5)) {
    final ideasTema = porTema[t]!;
    if (ideasTema.length < 2) continue;
    final usados = {for (final i in ideasTema) i.formato};
    for (final f in [FormatoIdea.reel, FormatoIdea.carrusel]) {
      if (usados.contains(f)) continue;
      agregar(
        Sugerencia(
          titulo: aplicar(_plantillaPorFormato[f]!, t),
          formato: f,
          tags: [t],
          razon:
              'Tienes ${ideasTema.length} ideas de ${nombreTema(t)} y ninguna en ${nombresFormato[f]}',
        ),
      );
    }
  }

  // 3. Temas olvidados: sin ideas nuevas hace más de 30 días.
  for (final t in temas) {
    final ultima = porTema[t]!
        .map((i) => i.creadaEn)
        .reduce((a, b) => a.isAfter(b) ? a : b);
    final dias = ahora.difference(ultima).inDays;
    if (dias <= 30) continue;
    agregar(
      Sugerencia(
        titulo: 'Lo nuevo de ${nombreTema(t)} en ${ahora.year}',
        formato: FormatoIdea.carrusel,
        tags: [t],
        razon: 'No tocas ${nombreTema(t)} hace $dias días',
      ),
    );
  }

  // 4. Plantillas que funcionan cruzadas con tus temas.
  final aleatorio = Random(semilla);
  final plantillas = [..._plantillas]..shuffle(aleatorio);
  final temasMezcla = [...temasBase.take(6)]..shuffle(aleatorio);
  var k = 0;
  for (final (plantilla, formato) in plantillas) {
    if (resultado.length >= maximo * 2) break;
    final tema = temasMezcla[k % temasMezcla.length];
    final otro = temasMezcla.length > 1
        ? temasMezcla[(k + 1) % temasMezcla.length]
        : null;
    k++;
    if (plantilla.contains('{T2}') && otro == null) continue;
    agregar(
      Sugerencia(
        titulo: aplicar(plantilla, tema, otro: otro),
        formato: formato,
        tags: [tema, if (plantilla.contains('{T2}')) ?otro],
        razon: temas.isEmpty
            ? 'Formato que suele funcionar'
            : 'Formato probado aplicado a ${nombreTema(tema)}',
      ),
    );
  }

  return resultado.take(maximo).toList();
}
