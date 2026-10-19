import '../../../core/db/database.dart';
import 'sugerencias.dart';

/// Arma el prompt para pegar en un chat de IA gratuito (Claude, ChatGPT,
/// Gemini) con el contexto del banco de ideas.
String construirPrompt(List<Idea> ideas, {int cantidad = 10}) {
  final recientes = [...ideas]
    ..sort((a, b) => b.creadaEn.compareTo(a.creadaEn));
  final mejores =
      ideas
          .where(
            (i) =>
                i.estado == EstadoIdea.publicado &&
                ((i.guardados ?? 0) + (i.likes ?? 0)) > 0,
          )
          .toList()
        ..sort(
          (a, b) => ((b.guardados ?? 0) * 3 + (b.likes ?? 0)).compareTo(
            (a.guardados ?? 0) * 3 + (a.likes ?? 0),
          ),
        );

  final sb = StringBuffer()
    ..writeln(
      'Eres mi asistente de contenido para "Code con Gabo", mi cuenta de Instagram '
      'sobre programación en español. Mi público son personas que están aprendiendo a programar '
      'o empezando su carrera como devs.',
    )
    ..writeln();
  if (recientes.isNotEmpty) {
    sb.writeln('Estas son mis ideas recientes (no las repitas):');
    for (final i in recientes.take(30)) {
      final tags = tagsDe(i);
      sb.writeln(
        '- ${i.titulo} [${nombresFormato[i.formato] ?? i.formato}${tags.isEmpty ? '' : '; ${tags.join(', ')}'}]',
      );
    }
    sb.writeln();
  }
  if (mejores.isNotEmpty) {
    sb.writeln('Las que mejor me funcionaron:');
    for (final i in mejores.take(5)) {
      sb.writeln(
        '- ${i.titulo} (${i.guardados ?? 0} guardados, ${i.likes ?? 0} likes)',
      );
    }
    sb.writeln();
  }
  sb
    ..writeln(
      'Propón $cantidad ideas NUEVAS en mi estilo, variando los formatos '
      '(reel, carrusel, post, historia) y con temas que conecten con los que ya trabajo.',
    )
    ..writeln(
      'Responde SOLO con una idea por línea, sin numerar ni agregar nada más, con este formato exacto:',
    )
    ..writeln(
      'Título | formato | tag1, tag2 | gancho para los primeros 3 segundos',
    );
  return sb.toString();
}

/// Convierte la respuesta pegada del chat en sugerencias. Tolera numeración,
/// viñetas y negritas de markdown; ignora líneas sin el separador "|".
List<Sugerencia> parsearRespuesta(String texto) {
  final resultado = <Sugerencia>[];
  for (var linea in texto.split('\n')) {
    linea = linea
        .replaceAll('**', '')
        .replaceFirst(RegExp(r'^\s*(?:[-*•]|\d+[.)])\s*'), '')
        .trim();
    if (!linea.contains('|')) continue;
    final partes = linea.split('|').map((p) => p.trim()).toList();
    final titulo = partes[0].replaceAll(RegExp(r'^["“]|["”]$'), '').trim();
    if (titulo.isEmpty || normalizar(titulo) == 'titulo') continue;

    final formatoTexto = partes.length > 1 ? normalizar(partes[1]) : '';
    final formato = FormatoIdea.todos.firstWhere(
      (f) => formatoTexto.contains(f),
      orElse: () => FormatoIdea.reel,
    );
    resultado.add(
      Sugerencia(
        titulo: titulo,
        formato: formato,
        tags: partes.length > 2 ? separarTags(partes[2]) : const [],
        hook: partes.length > 3 && partes[3].isNotEmpty
            ? partes.sublist(3).join(' | ')
            : null,
      ),
    );
  }
  return resultado;
}
