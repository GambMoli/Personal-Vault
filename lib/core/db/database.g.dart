// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ListasTable extends Listas with TableInfo<$ListasTable, Lista> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ListasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 60,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
    'tipo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(TipoLista.general),
  );
  static const VerificationMeta _iconoMeta = const VerificationMeta('icono');
  @override
  late final GeneratedColumn<String> icono = GeneratedColumn<String>(
    'icono',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('lista'),
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0xFF3F51B5),
  );
  static const VerificationMeta _ordenMeta = const VerificationMeta('orden');
  @override
  late final GeneratedColumn<int> orden = GeneratedColumn<int>(
    'orden',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _creadaEnMeta = const VerificationMeta(
    'creadaEn',
  );
  @override
  late final GeneratedColumn<DateTime> creadaEn = GeneratedColumn<DateTime>(
    'creada_en',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    tipo,
    icono,
    color,
    orden,
    creadaEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tar_listas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Lista> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('tipo')) {
      context.handle(
        _tipoMeta,
        tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta),
      );
    }
    if (data.containsKey('icono')) {
      context.handle(
        _iconoMeta,
        icono.isAcceptableOrUnknown(data['icono']!, _iconoMeta),
      );
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('orden')) {
      context.handle(
        _ordenMeta,
        orden.isAcceptableOrUnknown(data['orden']!, _ordenMeta),
      );
    }
    if (data.containsKey('creada_en')) {
      context.handle(
        _creadaEnMeta,
        creadaEn.isAcceptableOrUnknown(data['creada_en']!, _creadaEnMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Lista map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Lista(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      tipo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo'],
      )!,
      icono: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icono'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color'],
      )!,
      orden: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}orden'],
      )!,
      creadaEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creada_en'],
      )!,
    );
  }

  @override
  $ListasTable createAlias(String alias) {
    return $ListasTable(attachedDatabase, alias);
  }
}

class Lista extends DataClass implements Insertable<Lista> {
  final int id;
  final String nombre;
  final String tipo;
  final String icono;
  final int color;
  final int orden;
  final DateTime creadaEn;
  const Lista({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.icono,
    required this.color,
    required this.orden,
    required this.creadaEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['tipo'] = Variable<String>(tipo);
    map['icono'] = Variable<String>(icono);
    map['color'] = Variable<int>(color);
    map['orden'] = Variable<int>(orden);
    map['creada_en'] = Variable<DateTime>(creadaEn);
    return map;
  }

  ListasCompanion toCompanion(bool nullToAbsent) {
    return ListasCompanion(
      id: Value(id),
      nombre: Value(nombre),
      tipo: Value(tipo),
      icono: Value(icono),
      color: Value(color),
      orden: Value(orden),
      creadaEn: Value(creadaEn),
    );
  }

  factory Lista.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Lista(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      tipo: serializer.fromJson<String>(json['tipo']),
      icono: serializer.fromJson<String>(json['icono']),
      color: serializer.fromJson<int>(json['color']),
      orden: serializer.fromJson<int>(json['orden']),
      creadaEn: serializer.fromJson<DateTime>(json['creadaEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'tipo': serializer.toJson<String>(tipo),
      'icono': serializer.toJson<String>(icono),
      'color': serializer.toJson<int>(color),
      'orden': serializer.toJson<int>(orden),
      'creadaEn': serializer.toJson<DateTime>(creadaEn),
    };
  }

  Lista copyWith({
    int? id,
    String? nombre,
    String? tipo,
    String? icono,
    int? color,
    int? orden,
    DateTime? creadaEn,
  }) => Lista(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    tipo: tipo ?? this.tipo,
    icono: icono ?? this.icono,
    color: color ?? this.color,
    orden: orden ?? this.orden,
    creadaEn: creadaEn ?? this.creadaEn,
  );
  Lista copyWithCompanion(ListasCompanion data) {
    return Lista(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      icono: data.icono.present ? data.icono.value : this.icono,
      color: data.color.present ? data.color.value : this.color,
      orden: data.orden.present ? data.orden.value : this.orden,
      creadaEn: data.creadaEn.present ? data.creadaEn.value : this.creadaEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Lista(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('tipo: $tipo, ')
          ..write('icono: $icono, ')
          ..write('color: $color, ')
          ..write('orden: $orden, ')
          ..write('creadaEn: $creadaEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nombre, tipo, icono, color, orden, creadaEn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Lista &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.tipo == this.tipo &&
          other.icono == this.icono &&
          other.color == this.color &&
          other.orden == this.orden &&
          other.creadaEn == this.creadaEn);
}

class ListasCompanion extends UpdateCompanion<Lista> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String> tipo;
  final Value<String> icono;
  final Value<int> color;
  final Value<int> orden;
  final Value<DateTime> creadaEn;
  const ListasCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.tipo = const Value.absent(),
    this.icono = const Value.absent(),
    this.color = const Value.absent(),
    this.orden = const Value.absent(),
    this.creadaEn = const Value.absent(),
  });
  ListasCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    this.tipo = const Value.absent(),
    this.icono = const Value.absent(),
    this.color = const Value.absent(),
    this.orden = const Value.absent(),
    this.creadaEn = const Value.absent(),
  }) : nombre = Value(nombre);
  static Insertable<Lista> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? tipo,
    Expression<String>? icono,
    Expression<int>? color,
    Expression<int>? orden,
    Expression<DateTime>? creadaEn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (tipo != null) 'tipo': tipo,
      if (icono != null) 'icono': icono,
      if (color != null) 'color': color,
      if (orden != null) 'orden': orden,
      if (creadaEn != null) 'creada_en': creadaEn,
    });
  }

  ListasCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<String>? tipo,
    Value<String>? icono,
    Value<int>? color,
    Value<int>? orden,
    Value<DateTime>? creadaEn,
  }) {
    return ListasCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      tipo: tipo ?? this.tipo,
      icono: icono ?? this.icono,
      color: color ?? this.color,
      orden: orden ?? this.orden,
      creadaEn: creadaEn ?? this.creadaEn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (icono.present) {
      map['icono'] = Variable<String>(icono.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (orden.present) {
      map['orden'] = Variable<int>(orden.value);
    }
    if (creadaEn.present) {
      map['creada_en'] = Variable<DateTime>(creadaEn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ListasCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('tipo: $tipo, ')
          ..write('icono: $icono, ')
          ..write('color: $color, ')
          ..write('orden: $orden, ')
          ..write('creadaEn: $creadaEn')
          ..write(')'))
        .toString();
  }
}

class $TareasTable extends Tareas with TableInfo<$TareasTable, Tarea> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TareasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _listaIdMeta = const VerificationMeta(
    'listaId',
  );
  @override
  late final GeneratedColumn<int> listaId = GeneratedColumn<int>(
    'lista_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tar_listas (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _tituloMeta = const VerificationMeta('titulo');
  @override
  late final GeneratedColumn<String> titulo = GeneratedColumn<String>(
    'titulo',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notasMeta = const VerificationMeta('notas');
  @override
  late final GeneratedColumn<String> notas = GeneratedColumn<String>(
    'notas',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _venceMeta = const VerificationMeta('vence');
  @override
  late final GeneratedColumn<DateTime> vence = GeneratedColumn<DateTime>(
    'vence',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _conHoraMeta = const VerificationMeta(
    'conHora',
  );
  @override
  late final GeneratedColumn<bool> conHora = GeneratedColumn<bool>(
    'con_hora',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("con_hora" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _recordarMeta = const VerificationMeta(
    'recordar',
  );
  @override
  late final GeneratedColumn<bool> recordar = GeneratedColumn<bool>(
    'recordar',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("recordar" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _prioridadMeta = const VerificationMeta(
    'prioridad',
  );
  @override
  late final GeneratedColumn<int> prioridad = GeneratedColumn<int>(
    'prioridad',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _repeticionMeta = const VerificationMeta(
    'repeticion',
  );
  @override
  late final GeneratedColumn<String> repeticion = GeneratedColumn<String>(
    'repeticion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(Repeticion.ninguna),
  );
  static const VerificationMeta _cantidadMeta = const VerificationMeta(
    'cantidad',
  );
  @override
  late final GeneratedColumn<String> cantidad = GeneratedColumn<String>(
    'cantidad',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completadaEnMeta = const VerificationMeta(
    'completadaEn',
  );
  @override
  late final GeneratedColumn<DateTime> completadaEn = GeneratedColumn<DateTime>(
    'completada_en',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _creadaEnMeta = const VerificationMeta(
    'creadaEn',
  );
  @override
  late final GeneratedColumn<DateTime> creadaEn = GeneratedColumn<DateTime>(
    'creada_en',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    listaId,
    titulo,
    notas,
    vence,
    conHora,
    recordar,
    prioridad,
    repeticion,
    cantidad,
    completadaEn,
    creadaEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tar_tareas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tarea> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('lista_id')) {
      context.handle(
        _listaIdMeta,
        listaId.isAcceptableOrUnknown(data['lista_id']!, _listaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_listaIdMeta);
    }
    if (data.containsKey('titulo')) {
      context.handle(
        _tituloMeta,
        titulo.isAcceptableOrUnknown(data['titulo']!, _tituloMeta),
      );
    } else if (isInserting) {
      context.missing(_tituloMeta);
    }
    if (data.containsKey('notas')) {
      context.handle(
        _notasMeta,
        notas.isAcceptableOrUnknown(data['notas']!, _notasMeta),
      );
    }
    if (data.containsKey('vence')) {
      context.handle(
        _venceMeta,
        vence.isAcceptableOrUnknown(data['vence']!, _venceMeta),
      );
    }
    if (data.containsKey('con_hora')) {
      context.handle(
        _conHoraMeta,
        conHora.isAcceptableOrUnknown(data['con_hora']!, _conHoraMeta),
      );
    }
    if (data.containsKey('recordar')) {
      context.handle(
        _recordarMeta,
        recordar.isAcceptableOrUnknown(data['recordar']!, _recordarMeta),
      );
    }
    if (data.containsKey('prioridad')) {
      context.handle(
        _prioridadMeta,
        prioridad.isAcceptableOrUnknown(data['prioridad']!, _prioridadMeta),
      );
    }
    if (data.containsKey('repeticion')) {
      context.handle(
        _repeticionMeta,
        repeticion.isAcceptableOrUnknown(data['repeticion']!, _repeticionMeta),
      );
    }
    if (data.containsKey('cantidad')) {
      context.handle(
        _cantidadMeta,
        cantidad.isAcceptableOrUnknown(data['cantidad']!, _cantidadMeta),
      );
    }
    if (data.containsKey('completada_en')) {
      context.handle(
        _completadaEnMeta,
        completadaEn.isAcceptableOrUnknown(
          data['completada_en']!,
          _completadaEnMeta,
        ),
      );
    }
    if (data.containsKey('creada_en')) {
      context.handle(
        _creadaEnMeta,
        creadaEn.isAcceptableOrUnknown(data['creada_en']!, _creadaEnMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tarea map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tarea(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      listaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lista_id'],
      )!,
      titulo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}titulo'],
      )!,
      notas: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notas'],
      ),
      vence: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}vence'],
      ),
      conHora: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}con_hora'],
      )!,
      recordar: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}recordar'],
      )!,
      prioridad: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}prioridad'],
      )!,
      repeticion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}repeticion'],
      )!,
      cantidad: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cantidad'],
      ),
      completadaEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completada_en'],
      ),
      creadaEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creada_en'],
      )!,
    );
  }

  @override
  $TareasTable createAlias(String alias) {
    return $TareasTable(attachedDatabase, alias);
  }
}

class Tarea extends DataClass implements Insertable<Tarea> {
  final int id;
  final int listaId;
  final String titulo;
  final String? notas;

  /// Fecha límite. Si [conHora] es falso solo importa el día.
  final DateTime? vence;
  final bool conHora;

  /// Notificar en [vence] (requiere [conHora]).
  final bool recordar;

  /// 0 = normal, 1 = alta, 2 = urgente.
  final int prioridad;
  final String repeticion;

  /// Cantidad libre para listas de mercado ("2 kg", "1 docena").
  final String? cantidad;
  final DateTime? completadaEn;
  final DateTime creadaEn;
  const Tarea({
    required this.id,
    required this.listaId,
    required this.titulo,
    this.notas,
    this.vence,
    required this.conHora,
    required this.recordar,
    required this.prioridad,
    required this.repeticion,
    this.cantidad,
    this.completadaEn,
    required this.creadaEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['lista_id'] = Variable<int>(listaId);
    map['titulo'] = Variable<String>(titulo);
    if (!nullToAbsent || notas != null) {
      map['notas'] = Variable<String>(notas);
    }
    if (!nullToAbsent || vence != null) {
      map['vence'] = Variable<DateTime>(vence);
    }
    map['con_hora'] = Variable<bool>(conHora);
    map['recordar'] = Variable<bool>(recordar);
    map['prioridad'] = Variable<int>(prioridad);
    map['repeticion'] = Variable<String>(repeticion);
    if (!nullToAbsent || cantidad != null) {
      map['cantidad'] = Variable<String>(cantidad);
    }
    if (!nullToAbsent || completadaEn != null) {
      map['completada_en'] = Variable<DateTime>(completadaEn);
    }
    map['creada_en'] = Variable<DateTime>(creadaEn);
    return map;
  }

  TareasCompanion toCompanion(bool nullToAbsent) {
    return TareasCompanion(
      id: Value(id),
      listaId: Value(listaId),
      titulo: Value(titulo),
      notas: notas == null && nullToAbsent
          ? const Value.absent()
          : Value(notas),
      vence: vence == null && nullToAbsent
          ? const Value.absent()
          : Value(vence),
      conHora: Value(conHora),
      recordar: Value(recordar),
      prioridad: Value(prioridad),
      repeticion: Value(repeticion),
      cantidad: cantidad == null && nullToAbsent
          ? const Value.absent()
          : Value(cantidad),
      completadaEn: completadaEn == null && nullToAbsent
          ? const Value.absent()
          : Value(completadaEn),
      creadaEn: Value(creadaEn),
    );
  }

  factory Tarea.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tarea(
      id: serializer.fromJson<int>(json['id']),
      listaId: serializer.fromJson<int>(json['listaId']),
      titulo: serializer.fromJson<String>(json['titulo']),
      notas: serializer.fromJson<String?>(json['notas']),
      vence: serializer.fromJson<DateTime?>(json['vence']),
      conHora: serializer.fromJson<bool>(json['conHora']),
      recordar: serializer.fromJson<bool>(json['recordar']),
      prioridad: serializer.fromJson<int>(json['prioridad']),
      repeticion: serializer.fromJson<String>(json['repeticion']),
      cantidad: serializer.fromJson<String?>(json['cantidad']),
      completadaEn: serializer.fromJson<DateTime?>(json['completadaEn']),
      creadaEn: serializer.fromJson<DateTime>(json['creadaEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'listaId': serializer.toJson<int>(listaId),
      'titulo': serializer.toJson<String>(titulo),
      'notas': serializer.toJson<String?>(notas),
      'vence': serializer.toJson<DateTime?>(vence),
      'conHora': serializer.toJson<bool>(conHora),
      'recordar': serializer.toJson<bool>(recordar),
      'prioridad': serializer.toJson<int>(prioridad),
      'repeticion': serializer.toJson<String>(repeticion),
      'cantidad': serializer.toJson<String?>(cantidad),
      'completadaEn': serializer.toJson<DateTime?>(completadaEn),
      'creadaEn': serializer.toJson<DateTime>(creadaEn),
    };
  }

  Tarea copyWith({
    int? id,
    int? listaId,
    String? titulo,
    Value<String?> notas = const Value.absent(),
    Value<DateTime?> vence = const Value.absent(),
    bool? conHora,
    bool? recordar,
    int? prioridad,
    String? repeticion,
    Value<String?> cantidad = const Value.absent(),
    Value<DateTime?> completadaEn = const Value.absent(),
    DateTime? creadaEn,
  }) => Tarea(
    id: id ?? this.id,
    listaId: listaId ?? this.listaId,
    titulo: titulo ?? this.titulo,
    notas: notas.present ? notas.value : this.notas,
    vence: vence.present ? vence.value : this.vence,
    conHora: conHora ?? this.conHora,
    recordar: recordar ?? this.recordar,
    prioridad: prioridad ?? this.prioridad,
    repeticion: repeticion ?? this.repeticion,
    cantidad: cantidad.present ? cantidad.value : this.cantidad,
    completadaEn: completadaEn.present ? completadaEn.value : this.completadaEn,
    creadaEn: creadaEn ?? this.creadaEn,
  );
  Tarea copyWithCompanion(TareasCompanion data) {
    return Tarea(
      id: data.id.present ? data.id.value : this.id,
      listaId: data.listaId.present ? data.listaId.value : this.listaId,
      titulo: data.titulo.present ? data.titulo.value : this.titulo,
      notas: data.notas.present ? data.notas.value : this.notas,
      vence: data.vence.present ? data.vence.value : this.vence,
      conHora: data.conHora.present ? data.conHora.value : this.conHora,
      recordar: data.recordar.present ? data.recordar.value : this.recordar,
      prioridad: data.prioridad.present ? data.prioridad.value : this.prioridad,
      repeticion: data.repeticion.present
          ? data.repeticion.value
          : this.repeticion,
      cantidad: data.cantidad.present ? data.cantidad.value : this.cantidad,
      completadaEn: data.completadaEn.present
          ? data.completadaEn.value
          : this.completadaEn,
      creadaEn: data.creadaEn.present ? data.creadaEn.value : this.creadaEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tarea(')
          ..write('id: $id, ')
          ..write('listaId: $listaId, ')
          ..write('titulo: $titulo, ')
          ..write('notas: $notas, ')
          ..write('vence: $vence, ')
          ..write('conHora: $conHora, ')
          ..write('recordar: $recordar, ')
          ..write('prioridad: $prioridad, ')
          ..write('repeticion: $repeticion, ')
          ..write('cantidad: $cantidad, ')
          ..write('completadaEn: $completadaEn, ')
          ..write('creadaEn: $creadaEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    listaId,
    titulo,
    notas,
    vence,
    conHora,
    recordar,
    prioridad,
    repeticion,
    cantidad,
    completadaEn,
    creadaEn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tarea &&
          other.id == this.id &&
          other.listaId == this.listaId &&
          other.titulo == this.titulo &&
          other.notas == this.notas &&
          other.vence == this.vence &&
          other.conHora == this.conHora &&
          other.recordar == this.recordar &&
          other.prioridad == this.prioridad &&
          other.repeticion == this.repeticion &&
          other.cantidad == this.cantidad &&
          other.completadaEn == this.completadaEn &&
          other.creadaEn == this.creadaEn);
}

class TareasCompanion extends UpdateCompanion<Tarea> {
  final Value<int> id;
  final Value<int> listaId;
  final Value<String> titulo;
  final Value<String?> notas;
  final Value<DateTime?> vence;
  final Value<bool> conHora;
  final Value<bool> recordar;
  final Value<int> prioridad;
  final Value<String> repeticion;
  final Value<String?> cantidad;
  final Value<DateTime?> completadaEn;
  final Value<DateTime> creadaEn;
  const TareasCompanion({
    this.id = const Value.absent(),
    this.listaId = const Value.absent(),
    this.titulo = const Value.absent(),
    this.notas = const Value.absent(),
    this.vence = const Value.absent(),
    this.conHora = const Value.absent(),
    this.recordar = const Value.absent(),
    this.prioridad = const Value.absent(),
    this.repeticion = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.completadaEn = const Value.absent(),
    this.creadaEn = const Value.absent(),
  });
  TareasCompanion.insert({
    this.id = const Value.absent(),
    required int listaId,
    required String titulo,
    this.notas = const Value.absent(),
    this.vence = const Value.absent(),
    this.conHora = const Value.absent(),
    this.recordar = const Value.absent(),
    this.prioridad = const Value.absent(),
    this.repeticion = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.completadaEn = const Value.absent(),
    this.creadaEn = const Value.absent(),
  }) : listaId = Value(listaId),
       titulo = Value(titulo);
  static Insertable<Tarea> custom({
    Expression<int>? id,
    Expression<int>? listaId,
    Expression<String>? titulo,
    Expression<String>? notas,
    Expression<DateTime>? vence,
    Expression<bool>? conHora,
    Expression<bool>? recordar,
    Expression<int>? prioridad,
    Expression<String>? repeticion,
    Expression<String>? cantidad,
    Expression<DateTime>? completadaEn,
    Expression<DateTime>? creadaEn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (listaId != null) 'lista_id': listaId,
      if (titulo != null) 'titulo': titulo,
      if (notas != null) 'notas': notas,
      if (vence != null) 'vence': vence,
      if (conHora != null) 'con_hora': conHora,
      if (recordar != null) 'recordar': recordar,
      if (prioridad != null) 'prioridad': prioridad,
      if (repeticion != null) 'repeticion': repeticion,
      if (cantidad != null) 'cantidad': cantidad,
      if (completadaEn != null) 'completada_en': completadaEn,
      if (creadaEn != null) 'creada_en': creadaEn,
    });
  }

  TareasCompanion copyWith({
    Value<int>? id,
    Value<int>? listaId,
    Value<String>? titulo,
    Value<String?>? notas,
    Value<DateTime?>? vence,
    Value<bool>? conHora,
    Value<bool>? recordar,
    Value<int>? prioridad,
    Value<String>? repeticion,
    Value<String?>? cantidad,
    Value<DateTime?>? completadaEn,
    Value<DateTime>? creadaEn,
  }) {
    return TareasCompanion(
      id: id ?? this.id,
      listaId: listaId ?? this.listaId,
      titulo: titulo ?? this.titulo,
      notas: notas ?? this.notas,
      vence: vence ?? this.vence,
      conHora: conHora ?? this.conHora,
      recordar: recordar ?? this.recordar,
      prioridad: prioridad ?? this.prioridad,
      repeticion: repeticion ?? this.repeticion,
      cantidad: cantidad ?? this.cantidad,
      completadaEn: completadaEn ?? this.completadaEn,
      creadaEn: creadaEn ?? this.creadaEn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (listaId.present) {
      map['lista_id'] = Variable<int>(listaId.value);
    }
    if (titulo.present) {
      map['titulo'] = Variable<String>(titulo.value);
    }
    if (notas.present) {
      map['notas'] = Variable<String>(notas.value);
    }
    if (vence.present) {
      map['vence'] = Variable<DateTime>(vence.value);
    }
    if (conHora.present) {
      map['con_hora'] = Variable<bool>(conHora.value);
    }
    if (recordar.present) {
      map['recordar'] = Variable<bool>(recordar.value);
    }
    if (prioridad.present) {
      map['prioridad'] = Variable<int>(prioridad.value);
    }
    if (repeticion.present) {
      map['repeticion'] = Variable<String>(repeticion.value);
    }
    if (cantidad.present) {
      map['cantidad'] = Variable<String>(cantidad.value);
    }
    if (completadaEn.present) {
      map['completada_en'] = Variable<DateTime>(completadaEn.value);
    }
    if (creadaEn.present) {
      map['creada_en'] = Variable<DateTime>(creadaEn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TareasCompanion(')
          ..write('id: $id, ')
          ..write('listaId: $listaId, ')
          ..write('titulo: $titulo, ')
          ..write('notas: $notas, ')
          ..write('vence: $vence, ')
          ..write('conHora: $conHora, ')
          ..write('recordar: $recordar, ')
          ..write('prioridad: $prioridad, ')
          ..write('repeticion: $repeticion, ')
          ..write('cantidad: $cantidad, ')
          ..write('completadaEn: $completadaEn, ')
          ..write('creadaEn: $creadaEn')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ListasTable listas = $ListasTable(this);
  late final $TareasTable tareas = $TareasTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [listas, tareas];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tar_listas',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tar_tareas', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$ListasTableCreateCompanionBuilder = ListasCompanion Function({
  Value<int> id,
  required String nombre,
  Value<String> tipo,
  Value<String> icono,
  Value<int> color,
  Value<int> orden,
  Value<DateTime> creadaEn,
});
typedef $$ListasTableUpdateCompanionBuilder = ListasCompanion Function({
  Value<int> id,
  Value<String> nombre,
  Value<String> tipo,
  Value<String> icono,
  Value<int> color,
  Value<int> orden,
  Value<DateTime> creadaEn,
});

final class $$ListasTableReferences
    extends BaseReferences<_$AppDatabase, $ListasTable, Lista> {
  $$ListasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TareasTable, List<Tarea>> _tareasRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.tareas,
    aliasName: 'tar_listas__id__tar_tareas__lista_id',
  );

  $$TareasTableProcessedTableManager get tareasRefs {
    final manager = $$TareasTableTableManager(
      $_db,
      $_db.tareas,
    ).filter((f) => f.listaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_tareasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ListasTableFilterComposer
    extends Composer<_$AppDatabase, $ListasTable> {
  $$ListasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icono => $composableBuilder(
    column: $table.icono,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orden => $composableBuilder(
    column: $table.orden,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creadaEn => $composableBuilder(
    column: $table.creadaEn,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> tareasRefs(
    Expression<bool> Function($$TareasTableFilterComposer f) f,
  ) {
    final $$TareasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tareas,
      getReferencedColumn: (t) => t.listaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TareasTableFilterComposer(
            $db: $db,
            $table: $db.tareas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ListasTableOrderingComposer
    extends Composer<_$AppDatabase, $ListasTable> {
  $$ListasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icono => $composableBuilder(
    column: $table.icono,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orden => $composableBuilder(
    column: $table.orden,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creadaEn => $composableBuilder(
    column: $table.creadaEn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ListasTableAnnotationComposer
    extends Composer<_$AppDatabase, $ListasTable> {
  $$ListasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<String> get icono =>
      $composableBuilder(column: $table.icono, builder: (column) => column);

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<int> get orden =>
      $composableBuilder(column: $table.orden, builder: (column) => column);

  GeneratedColumn<DateTime> get creadaEn =>
      $composableBuilder(column: $table.creadaEn, builder: (column) => column);

  Expression<T> tareasRefs<T extends Object>(
    Expression<T> Function($$TareasTableAnnotationComposer a) f,
  ) {
    final $$TareasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tareas,
      getReferencedColumn: (t) => t.listaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TareasTableAnnotationComposer(
            $db: $db,
            $table: $db.tareas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ListasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ListasTable,
          Lista,
          $$ListasTableFilterComposer,
          $$ListasTableOrderingComposer,
          $$ListasTableAnnotationComposer,
          $$ListasTableCreateCompanionBuilder,
          $$ListasTableUpdateCompanionBuilder,
          (Lista, $$ListasTableReferences),
          Lista,
          PrefetchHooks Function({bool tareasRefs})
        > {
  $$ListasTableTableManager(_$AppDatabase db, $ListasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ListasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ListasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ListasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> tipo = const Value.absent(),
                Value<String> icono = const Value.absent(),
                Value<int> color = const Value.absent(),
                Value<int> orden = const Value.absent(),
                Value<DateTime> creadaEn = const Value.absent(),
              }) => ListasCompanion(
                id: id,
                nombre: nombre,
                tipo: tipo,
                icono: icono,
                color: color,
                orden: orden,
                creadaEn: creadaEn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                Value<String> tipo = const Value.absent(),
                Value<String> icono = const Value.absent(),
                Value<int> color = const Value.absent(),
                Value<int> orden = const Value.absent(),
                Value<DateTime> creadaEn = const Value.absent(),
              }) => ListasCompanion.insert(
                id: id,
                nombre: nombre,
                tipo: tipo,
                icono: icono,
                color: color,
                orden: orden,
                creadaEn: creadaEn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ListasTable, Lista>(table),
                  $$ListasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({tareasRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (tareasRefs) db.tareas],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (tareasRefs)
                    await $_getPrefetchedData<Lista, $ListasTable, Tarea>(
                      currentTable: table,
                      referencedTable: $$ListasTableReferences._tareasRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$ListasTableReferences(db, table, p0).tareasRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.listaId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ListasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ListasTable,
      Lista,
      $$ListasTableFilterComposer,
      $$ListasTableOrderingComposer,
      $$ListasTableAnnotationComposer,
      $$ListasTableCreateCompanionBuilder,
      $$ListasTableUpdateCompanionBuilder,
      (Lista, $$ListasTableReferences),
      Lista,
      PrefetchHooks Function({bool tareasRefs})
    >;
typedef $$TareasTableCreateCompanionBuilder = TareasCompanion Function({
  Value<int> id,
  required int listaId,
  required String titulo,
  Value<String?> notas,
  Value<DateTime?> vence,
  Value<bool> conHora,
  Value<bool> recordar,
  Value<int> prioridad,
  Value<String> repeticion,
  Value<String?> cantidad,
  Value<DateTime?> completadaEn,
  Value<DateTime> creadaEn,
});
typedef $$TareasTableUpdateCompanionBuilder = TareasCompanion Function({
  Value<int> id,
  Value<int> listaId,
  Value<String> titulo,
  Value<String?> notas,
  Value<DateTime?> vence,
  Value<bool> conHora,
  Value<bool> recordar,
  Value<int> prioridad,
  Value<String> repeticion,
  Value<String?> cantidad,
  Value<DateTime?> completadaEn,
  Value<DateTime> creadaEn,
});

final class $$TareasTableReferences
    extends BaseReferences<_$AppDatabase, $TareasTable, Tarea> {
  $$TareasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ListasTable _listaIdTable(_$AppDatabase db) =>
      db.listas.createAlias('tar_tareas__lista_id__tar_listas__id');

  $$ListasTableProcessedTableManager get listaId {
    final $_column = $_itemColumn<int>('lista_id')!;

    final manager = $$ListasTableTableManager(
      $_db,
      $_db.listas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_listaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TareasTableFilterComposer
    extends Composer<_$AppDatabase, $TareasTable> {
  $$TareasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titulo => $composableBuilder(
    column: $table.titulo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notas => $composableBuilder(
    column: $table.notas,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get vence => $composableBuilder(
    column: $table.vence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get conHora => $composableBuilder(
    column: $table.conHora,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get recordar => $composableBuilder(
    column: $table.recordar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get prioridad => $composableBuilder(
    column: $table.prioridad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get repeticion => $composableBuilder(
    column: $table.repeticion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completadaEn => $composableBuilder(
    column: $table.completadaEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creadaEn => $composableBuilder(
    column: $table.creadaEn,
    builder: (column) => ColumnFilters(column),
  );

  $$ListasTableFilterComposer get listaId {
    final $$ListasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.listaId,
      referencedTable: $db.listas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ListasTableFilterComposer(
            $db: $db,
            $table: $db.listas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TareasTableOrderingComposer
    extends Composer<_$AppDatabase, $TareasTable> {
  $$TareasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titulo => $composableBuilder(
    column: $table.titulo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notas => $composableBuilder(
    column: $table.notas,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get vence => $composableBuilder(
    column: $table.vence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get conHora => $composableBuilder(
    column: $table.conHora,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get recordar => $composableBuilder(
    column: $table.recordar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get prioridad => $composableBuilder(
    column: $table.prioridad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get repeticion => $composableBuilder(
    column: $table.repeticion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completadaEn => $composableBuilder(
    column: $table.completadaEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creadaEn => $composableBuilder(
    column: $table.creadaEn,
    builder: (column) => ColumnOrderings(column),
  );

  $$ListasTableOrderingComposer get listaId {
    final $$ListasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.listaId,
      referencedTable: $db.listas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ListasTableOrderingComposer(
            $db: $db,
            $table: $db.listas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TareasTableAnnotationComposer
    extends Composer<_$AppDatabase, $TareasTable> {
  $$TareasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get titulo =>
      $composableBuilder(column: $table.titulo, builder: (column) => column);

  GeneratedColumn<String> get notas =>
      $composableBuilder(column: $table.notas, builder: (column) => column);

  GeneratedColumn<DateTime> get vence =>
      $composableBuilder(column: $table.vence, builder: (column) => column);

  GeneratedColumn<bool> get conHora =>
      $composableBuilder(column: $table.conHora, builder: (column) => column);

  GeneratedColumn<bool> get recordar =>
      $composableBuilder(column: $table.recordar, builder: (column) => column);

  GeneratedColumn<int> get prioridad =>
      $composableBuilder(column: $table.prioridad, builder: (column) => column);

  GeneratedColumn<String> get repeticion => $composableBuilder(
    column: $table.repeticion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cantidad =>
      $composableBuilder(column: $table.cantidad, builder: (column) => column);

  GeneratedColumn<DateTime> get completadaEn => $composableBuilder(
    column: $table.completadaEn,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get creadaEn =>
      $composableBuilder(column: $table.creadaEn, builder: (column) => column);

  $$ListasTableAnnotationComposer get listaId {
    final $$ListasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.listaId,
      referencedTable: $db.listas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ListasTableAnnotationComposer(
            $db: $db,
            $table: $db.listas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TareasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TareasTable,
          Tarea,
          $$TareasTableFilterComposer,
          $$TareasTableOrderingComposer,
          $$TareasTableAnnotationComposer,
          $$TareasTableCreateCompanionBuilder,
          $$TareasTableUpdateCompanionBuilder,
          (Tarea, $$TareasTableReferences),
          Tarea,
          PrefetchHooks Function({bool listaId})
        > {
  $$TareasTableTableManager(_$AppDatabase db, $TareasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TareasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TareasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TareasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> listaId = const Value.absent(),
                Value<String> titulo = const Value.absent(),
                Value<String?> notas = const Value.absent(),
                Value<DateTime?> vence = const Value.absent(),
                Value<bool> conHora = const Value.absent(),
                Value<bool> recordar = const Value.absent(),
                Value<int> prioridad = const Value.absent(),
                Value<String> repeticion = const Value.absent(),
                Value<String?> cantidad = const Value.absent(),
                Value<DateTime?> completadaEn = const Value.absent(),
                Value<DateTime> creadaEn = const Value.absent(),
              }) => TareasCompanion(
                id: id,
                listaId: listaId,
                titulo: titulo,
                notas: notas,
                vence: vence,
                conHora: conHora,
                recordar: recordar,
                prioridad: prioridad,
                repeticion: repeticion,
                cantidad: cantidad,
                completadaEn: completadaEn,
                creadaEn: creadaEn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int listaId,
                required String titulo,
                Value<String?> notas = const Value.absent(),
                Value<DateTime?> vence = const Value.absent(),
                Value<bool> conHora = const Value.absent(),
                Value<bool> recordar = const Value.absent(),
                Value<int> prioridad = const Value.absent(),
                Value<String> repeticion = const Value.absent(),
                Value<String?> cantidad = const Value.absent(),
                Value<DateTime?> completadaEn = const Value.absent(),
                Value<DateTime> creadaEn = const Value.absent(),
              }) => TareasCompanion.insert(
                id: id,
                listaId: listaId,
                titulo: titulo,
                notas: notas,
                vence: vence,
                conHora: conHora,
                recordar: recordar,
                prioridad: prioridad,
                repeticion: repeticion,
                cantidad: cantidad,
                completadaEn: completadaEn,
                creadaEn: creadaEn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TareasTable, Tarea>(table),
                  $$TareasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({listaId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (listaId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.listaId,
                        referencedTable: $$TareasTableReferences._listaIdTable(
                          db,
                        ),
                        referencedColumn: $$TareasTableReferences
                            ._listaIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TareasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TareasTable,
      Tarea,
      $$TareasTableFilterComposer,
      $$TareasTableOrderingComposer,
      $$TareasTableAnnotationComposer,
      $$TareasTableCreateCompanionBuilder,
      $$TareasTableUpdateCompanionBuilder,
      (Tarea, $$TareasTableReferences),
      Tarea,
      PrefetchHooks Function({bool listaId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ListasTableTableManager get listas =>
      $$ListasTableTableManager(_db, _db.listas);
  $$TareasTableTableManager get tareas =>
      $$TareasTableTableManager(_db, _db.tareas);
}
