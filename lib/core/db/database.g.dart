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

class $ProductosTable extends Productos
    with TableInfo<$ProductosTable, Producto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductosTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _unidadMeta = const VerificationMeta('unidad');
  @override
  late final GeneratedColumn<String> unidad = GeneratedColumn<String>(
    'unidad',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('und'),
  );
  static const VerificationMeta _ubicacionMeta = const VerificationMeta(
    'ubicacion',
  );
  @override
  late final GeneratedColumn<String> ubicacion = GeneratedColumn<String>(
    'ubicacion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(Ubicacion.alacena),
  );
  static const VerificationMeta _cantidadMeta = const VerificationMeta(
    'cantidad',
  );
  @override
  late final GeneratedColumn<double> cantidad = GeneratedColumn<double>(
    'cantidad',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _stockMinimoMeta = const VerificationMeta(
    'stockMinimo',
  );
  @override
  late final GeneratedColumn<double> stockMinimo = GeneratedColumn<double>(
    'stock_minimo',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _compraHabitualMeta = const VerificationMeta(
    'compraHabitual',
  );
  @override
  late final GeneratedColumn<double> compraHabitual = GeneratedColumn<double>(
    'compra_habitual',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    unidad,
    ubicacion,
    cantidad,
    stockMinimo,
    compraHabitual,
    vence,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'coc_productos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Producto> instance, {
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
    if (data.containsKey('unidad')) {
      context.handle(
        _unidadMeta,
        unidad.isAcceptableOrUnknown(data['unidad']!, _unidadMeta),
      );
    }
    if (data.containsKey('ubicacion')) {
      context.handle(
        _ubicacionMeta,
        ubicacion.isAcceptableOrUnknown(data['ubicacion']!, _ubicacionMeta),
      );
    }
    if (data.containsKey('cantidad')) {
      context.handle(
        _cantidadMeta,
        cantidad.isAcceptableOrUnknown(data['cantidad']!, _cantidadMeta),
      );
    }
    if (data.containsKey('stock_minimo')) {
      context.handle(
        _stockMinimoMeta,
        stockMinimo.isAcceptableOrUnknown(
          data['stock_minimo']!,
          _stockMinimoMeta,
        ),
      );
    }
    if (data.containsKey('compra_habitual')) {
      context.handle(
        _compraHabitualMeta,
        compraHabitual.isAcceptableOrUnknown(
          data['compra_habitual']!,
          _compraHabitualMeta,
        ),
      );
    }
    if (data.containsKey('vence')) {
      context.handle(
        _venceMeta,
        vence.isAcceptableOrUnknown(data['vence']!, _venceMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Producto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Producto(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      unidad: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unidad'],
      )!,
      ubicacion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ubicacion'],
      )!,
      cantidad: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cantidad'],
      )!,
      stockMinimo: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}stock_minimo'],
      )!,
      compraHabitual: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}compra_habitual'],
      )!,
      vence: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}vence'],
      ),
    );
  }

  @override
  $ProductosTable createAlias(String alias) {
    return $ProductosTable(attachedDatabase, alias);
  }
}

class Producto extends DataClass implements Insertable<Producto> {
  final int id;
  final String nombre;

  /// "kg", "g", "L", "ml", "und".
  final String unidad;
  final String ubicacion;

  /// Cantidad que hay ahora mismo.
  final double cantidad;

  /// Por debajo de esto se sugiere comprar.
  final double stockMinimo;

  /// Lo que se compra normalmente de una vez (se suma al marcarlo comprado).
  final double compraHabitual;
  final DateTime? vence;
  const Producto({
    required this.id,
    required this.nombre,
    required this.unidad,
    required this.ubicacion,
    required this.cantidad,
    required this.stockMinimo,
    required this.compraHabitual,
    this.vence,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['unidad'] = Variable<String>(unidad);
    map['ubicacion'] = Variable<String>(ubicacion);
    map['cantidad'] = Variable<double>(cantidad);
    map['stock_minimo'] = Variable<double>(stockMinimo);
    map['compra_habitual'] = Variable<double>(compraHabitual);
    if (!nullToAbsent || vence != null) {
      map['vence'] = Variable<DateTime>(vence);
    }
    return map;
  }

  ProductosCompanion toCompanion(bool nullToAbsent) {
    return ProductosCompanion(
      id: Value(id),
      nombre: Value(nombre),
      unidad: Value(unidad),
      ubicacion: Value(ubicacion),
      cantidad: Value(cantidad),
      stockMinimo: Value(stockMinimo),
      compraHabitual: Value(compraHabitual),
      vence: vence == null && nullToAbsent
          ? const Value.absent()
          : Value(vence),
    );
  }

  factory Producto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Producto(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      unidad: serializer.fromJson<String>(json['unidad']),
      ubicacion: serializer.fromJson<String>(json['ubicacion']),
      cantidad: serializer.fromJson<double>(json['cantidad']),
      stockMinimo: serializer.fromJson<double>(json['stockMinimo']),
      compraHabitual: serializer.fromJson<double>(json['compraHabitual']),
      vence: serializer.fromJson<DateTime?>(json['vence']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'unidad': serializer.toJson<String>(unidad),
      'ubicacion': serializer.toJson<String>(ubicacion),
      'cantidad': serializer.toJson<double>(cantidad),
      'stockMinimo': serializer.toJson<double>(stockMinimo),
      'compraHabitual': serializer.toJson<double>(compraHabitual),
      'vence': serializer.toJson<DateTime?>(vence),
    };
  }

  Producto copyWith({
    int? id,
    String? nombre,
    String? unidad,
    String? ubicacion,
    double? cantidad,
    double? stockMinimo,
    double? compraHabitual,
    Value<DateTime?> vence = const Value.absent(),
  }) => Producto(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    unidad: unidad ?? this.unidad,
    ubicacion: ubicacion ?? this.ubicacion,
    cantidad: cantidad ?? this.cantidad,
    stockMinimo: stockMinimo ?? this.stockMinimo,
    compraHabitual: compraHabitual ?? this.compraHabitual,
    vence: vence.present ? vence.value : this.vence,
  );
  Producto copyWithCompanion(ProductosCompanion data) {
    return Producto(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      unidad: data.unidad.present ? data.unidad.value : this.unidad,
      ubicacion: data.ubicacion.present ? data.ubicacion.value : this.ubicacion,
      cantidad: data.cantidad.present ? data.cantidad.value : this.cantidad,
      stockMinimo: data.stockMinimo.present
          ? data.stockMinimo.value
          : this.stockMinimo,
      compraHabitual: data.compraHabitual.present
          ? data.compraHabitual.value
          : this.compraHabitual,
      vence: data.vence.present ? data.vence.value : this.vence,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Producto(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('unidad: $unidad, ')
          ..write('ubicacion: $ubicacion, ')
          ..write('cantidad: $cantidad, ')
          ..write('stockMinimo: $stockMinimo, ')
          ..write('compraHabitual: $compraHabitual, ')
          ..write('vence: $vence')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nombre,
    unidad,
    ubicacion,
    cantidad,
    stockMinimo,
    compraHabitual,
    vence,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Producto &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.unidad == this.unidad &&
          other.ubicacion == this.ubicacion &&
          other.cantidad == this.cantidad &&
          other.stockMinimo == this.stockMinimo &&
          other.compraHabitual == this.compraHabitual &&
          other.vence == this.vence);
}

class ProductosCompanion extends UpdateCompanion<Producto> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String> unidad;
  final Value<String> ubicacion;
  final Value<double> cantidad;
  final Value<double> stockMinimo;
  final Value<double> compraHabitual;
  final Value<DateTime?> vence;
  const ProductosCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.unidad = const Value.absent(),
    this.ubicacion = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.stockMinimo = const Value.absent(),
    this.compraHabitual = const Value.absent(),
    this.vence = const Value.absent(),
  });
  ProductosCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    this.unidad = const Value.absent(),
    this.ubicacion = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.stockMinimo = const Value.absent(),
    this.compraHabitual = const Value.absent(),
    this.vence = const Value.absent(),
  }) : nombre = Value(nombre);
  static Insertable<Producto> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? unidad,
    Expression<String>? ubicacion,
    Expression<double>? cantidad,
    Expression<double>? stockMinimo,
    Expression<double>? compraHabitual,
    Expression<DateTime>? vence,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (unidad != null) 'unidad': unidad,
      if (ubicacion != null) 'ubicacion': ubicacion,
      if (cantidad != null) 'cantidad': cantidad,
      if (stockMinimo != null) 'stock_minimo': stockMinimo,
      if (compraHabitual != null) 'compra_habitual': compraHabitual,
      if (vence != null) 'vence': vence,
    });
  }

  ProductosCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<String>? unidad,
    Value<String>? ubicacion,
    Value<double>? cantidad,
    Value<double>? stockMinimo,
    Value<double>? compraHabitual,
    Value<DateTime?>? vence,
  }) {
    return ProductosCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      unidad: unidad ?? this.unidad,
      ubicacion: ubicacion ?? this.ubicacion,
      cantidad: cantidad ?? this.cantidad,
      stockMinimo: stockMinimo ?? this.stockMinimo,
      compraHabitual: compraHabitual ?? this.compraHabitual,
      vence: vence ?? this.vence,
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
    if (unidad.present) {
      map['unidad'] = Variable<String>(unidad.value);
    }
    if (ubicacion.present) {
      map['ubicacion'] = Variable<String>(ubicacion.value);
    }
    if (cantidad.present) {
      map['cantidad'] = Variable<double>(cantidad.value);
    }
    if (stockMinimo.present) {
      map['stock_minimo'] = Variable<double>(stockMinimo.value);
    }
    if (compraHabitual.present) {
      map['compra_habitual'] = Variable<double>(compraHabitual.value);
    }
    if (vence.present) {
      map['vence'] = Variable<DateTime>(vence.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductosCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('unidad: $unidad, ')
          ..write('ubicacion: $ubicacion, ')
          ..write('cantidad: $cantidad, ')
          ..write('stockMinimo: $stockMinimo, ')
          ..write('compraHabitual: $compraHabitual, ')
          ..write('vence: $vence')
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
  static const VerificationMeta _productoIdMeta = const VerificationMeta(
    'productoId',
  );
  @override
  late final GeneratedColumn<int> productoId = GeneratedColumn<int>(
    'producto_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES coc_productos (id) ON DELETE SET NULL',
    ),
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
    productoId,
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
    if (data.containsKey('producto_id')) {
      context.handle(
        _productoIdMeta,
        productoId.isAcceptableOrUnknown(data['producto_id']!, _productoIdMeta),
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
      productoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}producto_id'],
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

  /// Producto de Cocina asociado (al marcarlo comprado se suma al inventario).
  final int? productoId;
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
    this.productoId,
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
    if (!nullToAbsent || productoId != null) {
      map['producto_id'] = Variable<int>(productoId);
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
      productoId: productoId == null && nullToAbsent
          ? const Value.absent()
          : Value(productoId),
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
      productoId: serializer.fromJson<int?>(json['productoId']),
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
      'productoId': serializer.toJson<int?>(productoId),
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
    Value<int?> productoId = const Value.absent(),
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
    productoId: productoId.present ? productoId.value : this.productoId,
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
      productoId: data.productoId.present
          ? data.productoId.value
          : this.productoId,
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
          ..write('productoId: $productoId, ')
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
    productoId,
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
          other.productoId == this.productoId &&
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
  final Value<int?> productoId;
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
    this.productoId = const Value.absent(),
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
    this.productoId = const Value.absent(),
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
    Expression<int>? productoId,
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
      if (productoId != null) 'producto_id': productoId,
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
    Value<int?>? productoId,
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
      productoId: productoId ?? this.productoId,
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
    if (productoId.present) {
      map['producto_id'] = Variable<int>(productoId.value);
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
          ..write('productoId: $productoId, ')
          ..write('completadaEn: $completadaEn, ')
          ..write('creadaEn: $creadaEn')
          ..write(')'))
        .toString();
  }
}

class $CuentasTable extends Cuentas with TableInfo<$CuentasTable, Cuenta> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CuentasTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _bancoMeta = const VerificationMeta('banco');
  @override
  late final GeneratedColumn<String> banco = GeneratedColumn<String>(
    'banco',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
    'tipo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(TipoCuenta.ahorros),
  );
  static const VerificationMeta _saldoInicialMeta = const VerificationMeta(
    'saldoInicial',
  );
  @override
  late final GeneratedColumn<int> saldoInicial = GeneratedColumn<int>(
    'saldo_inicial',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _archivadaMeta = const VerificationMeta(
    'archivada',
  );
  @override
  late final GeneratedColumn<bool> archivada = GeneratedColumn<bool>(
    'archivada',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("archivada" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    banco,
    tipo,
    saldoInicial,
    archivada,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fin_cuentas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Cuenta> instance, {
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
    if (data.containsKey('banco')) {
      context.handle(
        _bancoMeta,
        banco.isAcceptableOrUnknown(data['banco']!, _bancoMeta),
      );
    }
    if (data.containsKey('tipo')) {
      context.handle(
        _tipoMeta,
        tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta),
      );
    }
    if (data.containsKey('saldo_inicial')) {
      context.handle(
        _saldoInicialMeta,
        saldoInicial.isAcceptableOrUnknown(
          data['saldo_inicial']!,
          _saldoInicialMeta,
        ),
      );
    }
    if (data.containsKey('archivada')) {
      context.handle(
        _archivadaMeta,
        archivada.isAcceptableOrUnknown(data['archivada']!, _archivadaMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Cuenta map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Cuenta(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      banco: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}banco'],
      ),
      tipo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo'],
      )!,
      saldoInicial: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}saldo_inicial'],
      )!,
      archivada: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}archivada'],
      )!,
    );
  }

  @override
  $CuentasTable createAlias(String alias) {
    return $CuentasTable(attachedDatabase, alias);
  }
}

class Cuenta extends DataClass implements Insertable<Cuenta> {
  final int id;
  final String nombre;
  final String? banco;
  final String tipo;
  final int saldoInicial;
  final bool archivada;
  const Cuenta({
    required this.id,
    required this.nombre,
    this.banco,
    required this.tipo,
    required this.saldoInicial,
    required this.archivada,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    if (!nullToAbsent || banco != null) {
      map['banco'] = Variable<String>(banco);
    }
    map['tipo'] = Variable<String>(tipo);
    map['saldo_inicial'] = Variable<int>(saldoInicial);
    map['archivada'] = Variable<bool>(archivada);
    return map;
  }

  CuentasCompanion toCompanion(bool nullToAbsent) {
    return CuentasCompanion(
      id: Value(id),
      nombre: Value(nombre),
      banco: banco == null && nullToAbsent
          ? const Value.absent()
          : Value(banco),
      tipo: Value(tipo),
      saldoInicial: Value(saldoInicial),
      archivada: Value(archivada),
    );
  }

  factory Cuenta.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Cuenta(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      banco: serializer.fromJson<String?>(json['banco']),
      tipo: serializer.fromJson<String>(json['tipo']),
      saldoInicial: serializer.fromJson<int>(json['saldoInicial']),
      archivada: serializer.fromJson<bool>(json['archivada']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'banco': serializer.toJson<String?>(banco),
      'tipo': serializer.toJson<String>(tipo),
      'saldoInicial': serializer.toJson<int>(saldoInicial),
      'archivada': serializer.toJson<bool>(archivada),
    };
  }

  Cuenta copyWith({
    int? id,
    String? nombre,
    Value<String?> banco = const Value.absent(),
    String? tipo,
    int? saldoInicial,
    bool? archivada,
  }) => Cuenta(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    banco: banco.present ? banco.value : this.banco,
    tipo: tipo ?? this.tipo,
    saldoInicial: saldoInicial ?? this.saldoInicial,
    archivada: archivada ?? this.archivada,
  );
  Cuenta copyWithCompanion(CuentasCompanion data) {
    return Cuenta(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      banco: data.banco.present ? data.banco.value : this.banco,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      saldoInicial: data.saldoInicial.present
          ? data.saldoInicial.value
          : this.saldoInicial,
      archivada: data.archivada.present ? data.archivada.value : this.archivada,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Cuenta(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('banco: $banco, ')
          ..write('tipo: $tipo, ')
          ..write('saldoInicial: $saldoInicial, ')
          ..write('archivada: $archivada')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nombre, banco, tipo, saldoInicial, archivada);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Cuenta &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.banco == this.banco &&
          other.tipo == this.tipo &&
          other.saldoInicial == this.saldoInicial &&
          other.archivada == this.archivada);
}

class CuentasCompanion extends UpdateCompanion<Cuenta> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String?> banco;
  final Value<String> tipo;
  final Value<int> saldoInicial;
  final Value<bool> archivada;
  const CuentasCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.banco = const Value.absent(),
    this.tipo = const Value.absent(),
    this.saldoInicial = const Value.absent(),
    this.archivada = const Value.absent(),
  });
  CuentasCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    this.banco = const Value.absent(),
    this.tipo = const Value.absent(),
    this.saldoInicial = const Value.absent(),
    this.archivada = const Value.absent(),
  }) : nombre = Value(nombre);
  static Insertable<Cuenta> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? banco,
    Expression<String>? tipo,
    Expression<int>? saldoInicial,
    Expression<bool>? archivada,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (banco != null) 'banco': banco,
      if (tipo != null) 'tipo': tipo,
      if (saldoInicial != null) 'saldo_inicial': saldoInicial,
      if (archivada != null) 'archivada': archivada,
    });
  }

  CuentasCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<String?>? banco,
    Value<String>? tipo,
    Value<int>? saldoInicial,
    Value<bool>? archivada,
  }) {
    return CuentasCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      banco: banco ?? this.banco,
      tipo: tipo ?? this.tipo,
      saldoInicial: saldoInicial ?? this.saldoInicial,
      archivada: archivada ?? this.archivada,
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
    if (banco.present) {
      map['banco'] = Variable<String>(banco.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (saldoInicial.present) {
      map['saldo_inicial'] = Variable<int>(saldoInicial.value);
    }
    if (archivada.present) {
      map['archivada'] = Variable<bool>(archivada.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CuentasCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('banco: $banco, ')
          ..write('tipo: $tipo, ')
          ..write('saldoInicial: $saldoInicial, ')
          ..write('archivada: $archivada')
          ..write(')'))
        .toString();
  }
}

class $CategoriasTable extends Categorias
    with TableInfo<$CategoriasTable, Categoria> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriasTable(this.attachedDatabase, [this._alias]);
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
      maxTextLength: 40,
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconoMeta = const VerificationMeta('icono');
  @override
  late final GeneratedColumn<String> icono = GeneratedColumn<String>(
    'icono',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('otros'),
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0xFF757575),
  );
  static const VerificationMeta _presupuestoMeta = const VerificationMeta(
    'presupuesto',
  );
  @override
  late final GeneratedColumn<int> presupuesto = GeneratedColumn<int>(
    'presupuesto',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    tipo,
    icono,
    color,
    presupuesto,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fin_categorias';
  @override
  VerificationContext validateIntegrity(
    Insertable<Categoria> instance, {
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
    } else if (isInserting) {
      context.missing(_tipoMeta);
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
    if (data.containsKey('presupuesto')) {
      context.handle(
        _presupuestoMeta,
        presupuesto.isAcceptableOrUnknown(
          data['presupuesto']!,
          _presupuestoMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Categoria map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Categoria(
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
      presupuesto: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}presupuesto'],
      )!,
    );
  }

  @override
  $CategoriasTable createAlias(String alias) {
    return $CategoriasTable(attachedDatabase, alias);
  }
}

class Categoria extends DataClass implements Insertable<Categoria> {
  final int id;
  final String nombre;
  final String tipo;
  final String icono;
  final int color;

  /// Presupuesto mensual (0 = sin presupuesto).
  final int presupuesto;
  const Categoria({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.icono,
    required this.color,
    required this.presupuesto,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['tipo'] = Variable<String>(tipo);
    map['icono'] = Variable<String>(icono);
    map['color'] = Variable<int>(color);
    map['presupuesto'] = Variable<int>(presupuesto);
    return map;
  }

  CategoriasCompanion toCompanion(bool nullToAbsent) {
    return CategoriasCompanion(
      id: Value(id),
      nombre: Value(nombre),
      tipo: Value(tipo),
      icono: Value(icono),
      color: Value(color),
      presupuesto: Value(presupuesto),
    );
  }

  factory Categoria.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Categoria(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      tipo: serializer.fromJson<String>(json['tipo']),
      icono: serializer.fromJson<String>(json['icono']),
      color: serializer.fromJson<int>(json['color']),
      presupuesto: serializer.fromJson<int>(json['presupuesto']),
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
      'presupuesto': serializer.toJson<int>(presupuesto),
    };
  }

  Categoria copyWith({
    int? id,
    String? nombre,
    String? tipo,
    String? icono,
    int? color,
    int? presupuesto,
  }) => Categoria(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    tipo: tipo ?? this.tipo,
    icono: icono ?? this.icono,
    color: color ?? this.color,
    presupuesto: presupuesto ?? this.presupuesto,
  );
  Categoria copyWithCompanion(CategoriasCompanion data) {
    return Categoria(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      icono: data.icono.present ? data.icono.value : this.icono,
      color: data.color.present ? data.color.value : this.color,
      presupuesto: data.presupuesto.present
          ? data.presupuesto.value
          : this.presupuesto,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Categoria(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('tipo: $tipo, ')
          ..write('icono: $icono, ')
          ..write('color: $color, ')
          ..write('presupuesto: $presupuesto')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre, tipo, icono, color, presupuesto);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Categoria &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.tipo == this.tipo &&
          other.icono == this.icono &&
          other.color == this.color &&
          other.presupuesto == this.presupuesto);
}

class CategoriasCompanion extends UpdateCompanion<Categoria> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String> tipo;
  final Value<String> icono;
  final Value<int> color;
  final Value<int> presupuesto;
  const CategoriasCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.tipo = const Value.absent(),
    this.icono = const Value.absent(),
    this.color = const Value.absent(),
    this.presupuesto = const Value.absent(),
  });
  CategoriasCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required String tipo,
    this.icono = const Value.absent(),
    this.color = const Value.absent(),
    this.presupuesto = const Value.absent(),
  }) : nombre = Value(nombre),
       tipo = Value(tipo);
  static Insertable<Categoria> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? tipo,
    Expression<String>? icono,
    Expression<int>? color,
    Expression<int>? presupuesto,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (tipo != null) 'tipo': tipo,
      if (icono != null) 'icono': icono,
      if (color != null) 'color': color,
      if (presupuesto != null) 'presupuesto': presupuesto,
    });
  }

  CategoriasCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<String>? tipo,
    Value<String>? icono,
    Value<int>? color,
    Value<int>? presupuesto,
  }) {
    return CategoriasCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      tipo: tipo ?? this.tipo,
      icono: icono ?? this.icono,
      color: color ?? this.color,
      presupuesto: presupuesto ?? this.presupuesto,
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
    if (presupuesto.present) {
      map['presupuesto'] = Variable<int>(presupuesto.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriasCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('tipo: $tipo, ')
          ..write('icono: $icono, ')
          ..write('color: $color, ')
          ..write('presupuesto: $presupuesto')
          ..write(')'))
        .toString();
  }
}

class $TarjetasTable extends Tarjetas with TableInfo<$TarjetasTable, Tarjeta> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TarjetasTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _bancoMeta = const VerificationMeta('banco');
  @override
  late final GeneratedColumn<String> banco = GeneratedColumn<String>(
    'banco',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cupoMeta = const VerificationMeta('cupo');
  @override
  late final GeneratedColumn<int> cupo = GeneratedColumn<int>(
    'cupo',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _deudaInicialMeta = const VerificationMeta(
    'deudaInicial',
  );
  @override
  late final GeneratedColumn<int> deudaInicial = GeneratedColumn<int>(
    'deuda_inicial',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _diaCorteMeta = const VerificationMeta(
    'diaCorte',
  );
  @override
  late final GeneratedColumn<int> diaCorte = GeneratedColumn<int>(
    'dia_corte',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _diaPagoMeta = const VerificationMeta(
    'diaPago',
  );
  @override
  late final GeneratedColumn<int> diaPago = GeneratedColumn<int>(
    'dia_pago',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tasaEaMeta = const VerificationMeta('tasaEa');
  @override
  late final GeneratedColumn<double> tasaEa = GeneratedColumn<double>(
    'tasa_ea',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _archivadaMeta = const VerificationMeta(
    'archivada',
  );
  @override
  late final GeneratedColumn<bool> archivada = GeneratedColumn<bool>(
    'archivada',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("archivada" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    banco,
    cupo,
    deudaInicial,
    diaCorte,
    diaPago,
    tasaEa,
    archivada,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fin_tarjetas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tarjeta> instance, {
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
    if (data.containsKey('banco')) {
      context.handle(
        _bancoMeta,
        banco.isAcceptableOrUnknown(data['banco']!, _bancoMeta),
      );
    }
    if (data.containsKey('cupo')) {
      context.handle(
        _cupoMeta,
        cupo.isAcceptableOrUnknown(data['cupo']!, _cupoMeta),
      );
    }
    if (data.containsKey('deuda_inicial')) {
      context.handle(
        _deudaInicialMeta,
        deudaInicial.isAcceptableOrUnknown(
          data['deuda_inicial']!,
          _deudaInicialMeta,
        ),
      );
    }
    if (data.containsKey('dia_corte')) {
      context.handle(
        _diaCorteMeta,
        diaCorte.isAcceptableOrUnknown(data['dia_corte']!, _diaCorteMeta),
      );
    }
    if (data.containsKey('dia_pago')) {
      context.handle(
        _diaPagoMeta,
        diaPago.isAcceptableOrUnknown(data['dia_pago']!, _diaPagoMeta),
      );
    }
    if (data.containsKey('tasa_ea')) {
      context.handle(
        _tasaEaMeta,
        tasaEa.isAcceptableOrUnknown(data['tasa_ea']!, _tasaEaMeta),
      );
    }
    if (data.containsKey('archivada')) {
      context.handle(
        _archivadaMeta,
        archivada.isAcceptableOrUnknown(data['archivada']!, _archivadaMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tarjeta map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tarjeta(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      banco: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}banco'],
      ),
      cupo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cupo'],
      )!,
      deudaInicial: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deuda_inicial'],
      )!,
      diaCorte: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dia_corte'],
      ),
      diaPago: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dia_pago'],
      ),
      tasaEa: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tasa_ea'],
      ),
      archivada: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}archivada'],
      )!,
    );
  }

  @override
  $TarjetasTable createAlias(String alias) {
    return $TarjetasTable(attachedDatabase, alias);
  }
}

class Tarjeta extends DataClass implements Insertable<Tarjeta> {
  final int id;
  final String nombre;
  final String? banco;
  final int cupo;

  /// Deuda al momento de registrar la tarjeta en la app.
  final int deudaInicial;
  final int? diaCorte;
  final int? diaPago;

  /// Tasa efectiva anual en %, solo informativa.
  final double? tasaEa;
  final bool archivada;
  const Tarjeta({
    required this.id,
    required this.nombre,
    this.banco,
    required this.cupo,
    required this.deudaInicial,
    this.diaCorte,
    this.diaPago,
    this.tasaEa,
    required this.archivada,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    if (!nullToAbsent || banco != null) {
      map['banco'] = Variable<String>(banco);
    }
    map['cupo'] = Variable<int>(cupo);
    map['deuda_inicial'] = Variable<int>(deudaInicial);
    if (!nullToAbsent || diaCorte != null) {
      map['dia_corte'] = Variable<int>(diaCorte);
    }
    if (!nullToAbsent || diaPago != null) {
      map['dia_pago'] = Variable<int>(diaPago);
    }
    if (!nullToAbsent || tasaEa != null) {
      map['tasa_ea'] = Variable<double>(tasaEa);
    }
    map['archivada'] = Variable<bool>(archivada);
    return map;
  }

  TarjetasCompanion toCompanion(bool nullToAbsent) {
    return TarjetasCompanion(
      id: Value(id),
      nombre: Value(nombre),
      banco: banco == null && nullToAbsent
          ? const Value.absent()
          : Value(banco),
      cupo: Value(cupo),
      deudaInicial: Value(deudaInicial),
      diaCorte: diaCorte == null && nullToAbsent
          ? const Value.absent()
          : Value(diaCorte),
      diaPago: diaPago == null && nullToAbsent
          ? const Value.absent()
          : Value(diaPago),
      tasaEa: tasaEa == null && nullToAbsent
          ? const Value.absent()
          : Value(tasaEa),
      archivada: Value(archivada),
    );
  }

  factory Tarjeta.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tarjeta(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      banco: serializer.fromJson<String?>(json['banco']),
      cupo: serializer.fromJson<int>(json['cupo']),
      deudaInicial: serializer.fromJson<int>(json['deudaInicial']),
      diaCorte: serializer.fromJson<int?>(json['diaCorte']),
      diaPago: serializer.fromJson<int?>(json['diaPago']),
      tasaEa: serializer.fromJson<double?>(json['tasaEa']),
      archivada: serializer.fromJson<bool>(json['archivada']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'banco': serializer.toJson<String?>(banco),
      'cupo': serializer.toJson<int>(cupo),
      'deudaInicial': serializer.toJson<int>(deudaInicial),
      'diaCorte': serializer.toJson<int?>(diaCorte),
      'diaPago': serializer.toJson<int?>(diaPago),
      'tasaEa': serializer.toJson<double?>(tasaEa),
      'archivada': serializer.toJson<bool>(archivada),
    };
  }

  Tarjeta copyWith({
    int? id,
    String? nombre,
    Value<String?> banco = const Value.absent(),
    int? cupo,
    int? deudaInicial,
    Value<int?> diaCorte = const Value.absent(),
    Value<int?> diaPago = const Value.absent(),
    Value<double?> tasaEa = const Value.absent(),
    bool? archivada,
  }) => Tarjeta(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    banco: banco.present ? banco.value : this.banco,
    cupo: cupo ?? this.cupo,
    deudaInicial: deudaInicial ?? this.deudaInicial,
    diaCorte: diaCorte.present ? diaCorte.value : this.diaCorte,
    diaPago: diaPago.present ? diaPago.value : this.diaPago,
    tasaEa: tasaEa.present ? tasaEa.value : this.tasaEa,
    archivada: archivada ?? this.archivada,
  );
  Tarjeta copyWithCompanion(TarjetasCompanion data) {
    return Tarjeta(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      banco: data.banco.present ? data.banco.value : this.banco,
      cupo: data.cupo.present ? data.cupo.value : this.cupo,
      deudaInicial: data.deudaInicial.present
          ? data.deudaInicial.value
          : this.deudaInicial,
      diaCorte: data.diaCorte.present ? data.diaCorte.value : this.diaCorte,
      diaPago: data.diaPago.present ? data.diaPago.value : this.diaPago,
      tasaEa: data.tasaEa.present ? data.tasaEa.value : this.tasaEa,
      archivada: data.archivada.present ? data.archivada.value : this.archivada,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tarjeta(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('banco: $banco, ')
          ..write('cupo: $cupo, ')
          ..write('deudaInicial: $deudaInicial, ')
          ..write('diaCorte: $diaCorte, ')
          ..write('diaPago: $diaPago, ')
          ..write('tasaEa: $tasaEa, ')
          ..write('archivada: $archivada')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nombre,
    banco,
    cupo,
    deudaInicial,
    diaCorte,
    diaPago,
    tasaEa,
    archivada,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tarjeta &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.banco == this.banco &&
          other.cupo == this.cupo &&
          other.deudaInicial == this.deudaInicial &&
          other.diaCorte == this.diaCorte &&
          other.diaPago == this.diaPago &&
          other.tasaEa == this.tasaEa &&
          other.archivada == this.archivada);
}

class TarjetasCompanion extends UpdateCompanion<Tarjeta> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String?> banco;
  final Value<int> cupo;
  final Value<int> deudaInicial;
  final Value<int?> diaCorte;
  final Value<int?> diaPago;
  final Value<double?> tasaEa;
  final Value<bool> archivada;
  const TarjetasCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.banco = const Value.absent(),
    this.cupo = const Value.absent(),
    this.deudaInicial = const Value.absent(),
    this.diaCorte = const Value.absent(),
    this.diaPago = const Value.absent(),
    this.tasaEa = const Value.absent(),
    this.archivada = const Value.absent(),
  });
  TarjetasCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    this.banco = const Value.absent(),
    this.cupo = const Value.absent(),
    this.deudaInicial = const Value.absent(),
    this.diaCorte = const Value.absent(),
    this.diaPago = const Value.absent(),
    this.tasaEa = const Value.absent(),
    this.archivada = const Value.absent(),
  }) : nombre = Value(nombre);
  static Insertable<Tarjeta> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? banco,
    Expression<int>? cupo,
    Expression<int>? deudaInicial,
    Expression<int>? diaCorte,
    Expression<int>? diaPago,
    Expression<double>? tasaEa,
    Expression<bool>? archivada,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (banco != null) 'banco': banco,
      if (cupo != null) 'cupo': cupo,
      if (deudaInicial != null) 'deuda_inicial': deudaInicial,
      if (diaCorte != null) 'dia_corte': diaCorte,
      if (diaPago != null) 'dia_pago': diaPago,
      if (tasaEa != null) 'tasa_ea': tasaEa,
      if (archivada != null) 'archivada': archivada,
    });
  }

  TarjetasCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<String?>? banco,
    Value<int>? cupo,
    Value<int>? deudaInicial,
    Value<int?>? diaCorte,
    Value<int?>? diaPago,
    Value<double?>? tasaEa,
    Value<bool>? archivada,
  }) {
    return TarjetasCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      banco: banco ?? this.banco,
      cupo: cupo ?? this.cupo,
      deudaInicial: deudaInicial ?? this.deudaInicial,
      diaCorte: diaCorte ?? this.diaCorte,
      diaPago: diaPago ?? this.diaPago,
      tasaEa: tasaEa ?? this.tasaEa,
      archivada: archivada ?? this.archivada,
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
    if (banco.present) {
      map['banco'] = Variable<String>(banco.value);
    }
    if (cupo.present) {
      map['cupo'] = Variable<int>(cupo.value);
    }
    if (deudaInicial.present) {
      map['deuda_inicial'] = Variable<int>(deudaInicial.value);
    }
    if (diaCorte.present) {
      map['dia_corte'] = Variable<int>(diaCorte.value);
    }
    if (diaPago.present) {
      map['dia_pago'] = Variable<int>(diaPago.value);
    }
    if (tasaEa.present) {
      map['tasa_ea'] = Variable<double>(tasaEa.value);
    }
    if (archivada.present) {
      map['archivada'] = Variable<bool>(archivada.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TarjetasCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('banco: $banco, ')
          ..write('cupo: $cupo, ')
          ..write('deudaInicial: $deudaInicial, ')
          ..write('diaCorte: $diaCorte, ')
          ..write('diaPago: $diaPago, ')
          ..write('tasaEa: $tasaEa, ')
          ..write('archivada: $archivada')
          ..write(')'))
        .toString();
  }
}

class $GastosFijosTable extends GastosFijos
    with TableInfo<$GastosFijosTable, GastoFijo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GastosFijosTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _montoMeta = const VerificationMeta('monto');
  @override
  late final GeneratedColumn<int> monto = GeneratedColumn<int>(
    'monto',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _diaMeta = const VerificationMeta('dia');
  @override
  late final GeneratedColumn<int> dia = GeneratedColumn<int>(
    'dia',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoriaIdMeta = const VerificationMeta(
    'categoriaId',
  );
  @override
  late final GeneratedColumn<int> categoriaId = GeneratedColumn<int>(
    'categoria_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES fin_categorias (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _cuentaIdMeta = const VerificationMeta(
    'cuentaId',
  );
  @override
  late final GeneratedColumn<int> cuentaId = GeneratedColumn<int>(
    'cuenta_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES fin_cuentas (id) ON DELETE SET NULL',
    ),
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
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _activoMeta = const VerificationMeta('activo');
  @override
  late final GeneratedColumn<bool> activo = GeneratedColumn<bool>(
    'activo',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("activo" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    descripcion,
    monto,
    dia,
    categoriaId,
    cuentaId,
    recordar,
    activo,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fin_gastos_fijos';
  @override
  VerificationContext validateIntegrity(
    Insertable<GastoFijo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descripcionMeta);
    }
    if (data.containsKey('monto')) {
      context.handle(
        _montoMeta,
        monto.isAcceptableOrUnknown(data['monto']!, _montoMeta),
      );
    } else if (isInserting) {
      context.missing(_montoMeta);
    }
    if (data.containsKey('dia')) {
      context.handle(
        _diaMeta,
        dia.isAcceptableOrUnknown(data['dia']!, _diaMeta),
      );
    } else if (isInserting) {
      context.missing(_diaMeta);
    }
    if (data.containsKey('categoria_id')) {
      context.handle(
        _categoriaIdMeta,
        categoriaId.isAcceptableOrUnknown(
          data['categoria_id']!,
          _categoriaIdMeta,
        ),
      );
    }
    if (data.containsKey('cuenta_id')) {
      context.handle(
        _cuentaIdMeta,
        cuentaId.isAcceptableOrUnknown(data['cuenta_id']!, _cuentaIdMeta),
      );
    }
    if (data.containsKey('recordar')) {
      context.handle(
        _recordarMeta,
        recordar.isAcceptableOrUnknown(data['recordar']!, _recordarMeta),
      );
    }
    if (data.containsKey('activo')) {
      context.handle(
        _activoMeta,
        activo.isAcceptableOrUnknown(data['activo']!, _activoMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GastoFijo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GastoFijo(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      )!,
      monto: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}monto'],
      )!,
      dia: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dia'],
      )!,
      categoriaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}categoria_id'],
      ),
      cuentaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cuenta_id'],
      ),
      recordar: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}recordar'],
      )!,
      activo: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}activo'],
      )!,
    );
  }

  @override
  $GastosFijosTable createAlias(String alias) {
    return $GastosFijosTable(attachedDatabase, alias);
  }
}

class GastoFijo extends DataClass implements Insertable<GastoFijo> {
  final int id;
  final String descripcion;
  final int monto;
  final int dia;
  final int? categoriaId;
  final int? cuentaId;
  final bool recordar;
  final bool activo;
  const GastoFijo({
    required this.id,
    required this.descripcion,
    required this.monto,
    required this.dia,
    this.categoriaId,
    this.cuentaId,
    required this.recordar,
    required this.activo,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['descripcion'] = Variable<String>(descripcion);
    map['monto'] = Variable<int>(monto);
    map['dia'] = Variable<int>(dia);
    if (!nullToAbsent || categoriaId != null) {
      map['categoria_id'] = Variable<int>(categoriaId);
    }
    if (!nullToAbsent || cuentaId != null) {
      map['cuenta_id'] = Variable<int>(cuentaId);
    }
    map['recordar'] = Variable<bool>(recordar);
    map['activo'] = Variable<bool>(activo);
    return map;
  }

  GastosFijosCompanion toCompanion(bool nullToAbsent) {
    return GastosFijosCompanion(
      id: Value(id),
      descripcion: Value(descripcion),
      monto: Value(monto),
      dia: Value(dia),
      categoriaId: categoriaId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoriaId),
      cuentaId: cuentaId == null && nullToAbsent
          ? const Value.absent()
          : Value(cuentaId),
      recordar: Value(recordar),
      activo: Value(activo),
    );
  }

  factory GastoFijo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GastoFijo(
      id: serializer.fromJson<int>(json['id']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      monto: serializer.fromJson<int>(json['monto']),
      dia: serializer.fromJson<int>(json['dia']),
      categoriaId: serializer.fromJson<int?>(json['categoriaId']),
      cuentaId: serializer.fromJson<int?>(json['cuentaId']),
      recordar: serializer.fromJson<bool>(json['recordar']),
      activo: serializer.fromJson<bool>(json['activo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'descripcion': serializer.toJson<String>(descripcion),
      'monto': serializer.toJson<int>(monto),
      'dia': serializer.toJson<int>(dia),
      'categoriaId': serializer.toJson<int?>(categoriaId),
      'cuentaId': serializer.toJson<int?>(cuentaId),
      'recordar': serializer.toJson<bool>(recordar),
      'activo': serializer.toJson<bool>(activo),
    };
  }

  GastoFijo copyWith({
    int? id,
    String? descripcion,
    int? monto,
    int? dia,
    Value<int?> categoriaId = const Value.absent(),
    Value<int?> cuentaId = const Value.absent(),
    bool? recordar,
    bool? activo,
  }) => GastoFijo(
    id: id ?? this.id,
    descripcion: descripcion ?? this.descripcion,
    monto: monto ?? this.monto,
    dia: dia ?? this.dia,
    categoriaId: categoriaId.present ? categoriaId.value : this.categoriaId,
    cuentaId: cuentaId.present ? cuentaId.value : this.cuentaId,
    recordar: recordar ?? this.recordar,
    activo: activo ?? this.activo,
  );
  GastoFijo copyWithCompanion(GastosFijosCompanion data) {
    return GastoFijo(
      id: data.id.present ? data.id.value : this.id,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      monto: data.monto.present ? data.monto.value : this.monto,
      dia: data.dia.present ? data.dia.value : this.dia,
      categoriaId: data.categoriaId.present
          ? data.categoriaId.value
          : this.categoriaId,
      cuentaId: data.cuentaId.present ? data.cuentaId.value : this.cuentaId,
      recordar: data.recordar.present ? data.recordar.value : this.recordar,
      activo: data.activo.present ? data.activo.value : this.activo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GastoFijo(')
          ..write('id: $id, ')
          ..write('descripcion: $descripcion, ')
          ..write('monto: $monto, ')
          ..write('dia: $dia, ')
          ..write('categoriaId: $categoriaId, ')
          ..write('cuentaId: $cuentaId, ')
          ..write('recordar: $recordar, ')
          ..write('activo: $activo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    descripcion,
    monto,
    dia,
    categoriaId,
    cuentaId,
    recordar,
    activo,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GastoFijo &&
          other.id == this.id &&
          other.descripcion == this.descripcion &&
          other.monto == this.monto &&
          other.dia == this.dia &&
          other.categoriaId == this.categoriaId &&
          other.cuentaId == this.cuentaId &&
          other.recordar == this.recordar &&
          other.activo == this.activo);
}

class GastosFijosCompanion extends UpdateCompanion<GastoFijo> {
  final Value<int> id;
  final Value<String> descripcion;
  final Value<int> monto;
  final Value<int> dia;
  final Value<int?> categoriaId;
  final Value<int?> cuentaId;
  final Value<bool> recordar;
  final Value<bool> activo;
  const GastosFijosCompanion({
    this.id = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.monto = const Value.absent(),
    this.dia = const Value.absent(),
    this.categoriaId = const Value.absent(),
    this.cuentaId = const Value.absent(),
    this.recordar = const Value.absent(),
    this.activo = const Value.absent(),
  });
  GastosFijosCompanion.insert({
    this.id = const Value.absent(),
    required String descripcion,
    required int monto,
    required int dia,
    this.categoriaId = const Value.absent(),
    this.cuentaId = const Value.absent(),
    this.recordar = const Value.absent(),
    this.activo = const Value.absent(),
  }) : descripcion = Value(descripcion),
       monto = Value(monto),
       dia = Value(dia);
  static Insertable<GastoFijo> custom({
    Expression<int>? id,
    Expression<String>? descripcion,
    Expression<int>? monto,
    Expression<int>? dia,
    Expression<int>? categoriaId,
    Expression<int>? cuentaId,
    Expression<bool>? recordar,
    Expression<bool>? activo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (descripcion != null) 'descripcion': descripcion,
      if (monto != null) 'monto': monto,
      if (dia != null) 'dia': dia,
      if (categoriaId != null) 'categoria_id': categoriaId,
      if (cuentaId != null) 'cuenta_id': cuentaId,
      if (recordar != null) 'recordar': recordar,
      if (activo != null) 'activo': activo,
    });
  }

  GastosFijosCompanion copyWith({
    Value<int>? id,
    Value<String>? descripcion,
    Value<int>? monto,
    Value<int>? dia,
    Value<int?>? categoriaId,
    Value<int?>? cuentaId,
    Value<bool>? recordar,
    Value<bool>? activo,
  }) {
    return GastosFijosCompanion(
      id: id ?? this.id,
      descripcion: descripcion ?? this.descripcion,
      monto: monto ?? this.monto,
      dia: dia ?? this.dia,
      categoriaId: categoriaId ?? this.categoriaId,
      cuentaId: cuentaId ?? this.cuentaId,
      recordar: recordar ?? this.recordar,
      activo: activo ?? this.activo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (monto.present) {
      map['monto'] = Variable<int>(monto.value);
    }
    if (dia.present) {
      map['dia'] = Variable<int>(dia.value);
    }
    if (categoriaId.present) {
      map['categoria_id'] = Variable<int>(categoriaId.value);
    }
    if (cuentaId.present) {
      map['cuenta_id'] = Variable<int>(cuentaId.value);
    }
    if (recordar.present) {
      map['recordar'] = Variable<bool>(recordar.value);
    }
    if (activo.present) {
      map['activo'] = Variable<bool>(activo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GastosFijosCompanion(')
          ..write('id: $id, ')
          ..write('descripcion: $descripcion, ')
          ..write('monto: $monto, ')
          ..write('dia: $dia, ')
          ..write('categoriaId: $categoriaId, ')
          ..write('cuentaId: $cuentaId, ')
          ..write('recordar: $recordar, ')
          ..write('activo: $activo')
          ..write(')'))
        .toString();
  }
}

class $MovimientosTable extends Movimientos
    with TableInfo<$MovimientosTable, Movimiento> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MovimientosTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
    'tipo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _montoMeta = const VerificationMeta('monto');
  @override
  late final GeneratedColumn<int> monto = GeneratedColumn<int>(
    'monto',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
    'fecha',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoriaIdMeta = const VerificationMeta(
    'categoriaId',
  );
  @override
  late final GeneratedColumn<int> categoriaId = GeneratedColumn<int>(
    'categoria_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES fin_categorias (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _cuentaIdMeta = const VerificationMeta(
    'cuentaId',
  );
  @override
  late final GeneratedColumn<int> cuentaId = GeneratedColumn<int>(
    'cuenta_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES fin_cuentas (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _cuentaDestinoIdMeta = const VerificationMeta(
    'cuentaDestinoId',
  );
  @override
  late final GeneratedColumn<int> cuentaDestinoId = GeneratedColumn<int>(
    'cuenta_destino_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES fin_cuentas (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _tarjetaIdMeta = const VerificationMeta(
    'tarjetaId',
  );
  @override
  late final GeneratedColumn<int> tarjetaId = GeneratedColumn<int>(
    'tarjeta_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES fin_tarjetas (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _cuotasMeta = const VerificationMeta('cuotas');
  @override
  late final GeneratedColumn<int> cuotas = GeneratedColumn<int>(
    'cuotas',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _fijoIdMeta = const VerificationMeta('fijoId');
  @override
  late final GeneratedColumn<int> fijoId = GeneratedColumn<int>(
    'fijo_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES fin_gastos_fijos (id) ON DELETE SET NULL',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tipo,
    monto,
    fecha,
    descripcion,
    categoriaId,
    cuentaId,
    cuentaDestinoId,
    tarjetaId,
    cuotas,
    fijoId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fin_movimientos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Movimiento> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tipo')) {
      context.handle(
        _tipoMeta,
        tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta),
      );
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('monto')) {
      context.handle(
        _montoMeta,
        monto.isAcceptableOrUnknown(data['monto']!, _montoMeta),
      );
    } else if (isInserting) {
      context.missing(_montoMeta);
    }
    if (data.containsKey('fecha')) {
      context.handle(
        _fechaMeta,
        fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta),
      );
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    }
    if (data.containsKey('categoria_id')) {
      context.handle(
        _categoriaIdMeta,
        categoriaId.isAcceptableOrUnknown(
          data['categoria_id']!,
          _categoriaIdMeta,
        ),
      );
    }
    if (data.containsKey('cuenta_id')) {
      context.handle(
        _cuentaIdMeta,
        cuentaId.isAcceptableOrUnknown(data['cuenta_id']!, _cuentaIdMeta),
      );
    }
    if (data.containsKey('cuenta_destino_id')) {
      context.handle(
        _cuentaDestinoIdMeta,
        cuentaDestinoId.isAcceptableOrUnknown(
          data['cuenta_destino_id']!,
          _cuentaDestinoIdMeta,
        ),
      );
    }
    if (data.containsKey('tarjeta_id')) {
      context.handle(
        _tarjetaIdMeta,
        tarjetaId.isAcceptableOrUnknown(data['tarjeta_id']!, _tarjetaIdMeta),
      );
    }
    if (data.containsKey('cuotas')) {
      context.handle(
        _cuotasMeta,
        cuotas.isAcceptableOrUnknown(data['cuotas']!, _cuotasMeta),
      );
    }
    if (data.containsKey('fijo_id')) {
      context.handle(
        _fijoIdMeta,
        fijoId.isAcceptableOrUnknown(data['fijo_id']!, _fijoIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Movimiento map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Movimiento(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tipo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo'],
      )!,
      monto: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}monto'],
      )!,
      fecha: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      ),
      categoriaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}categoria_id'],
      ),
      cuentaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cuenta_id'],
      ),
      cuentaDestinoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cuenta_destino_id'],
      ),
      tarjetaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tarjeta_id'],
      ),
      cuotas: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cuotas'],
      )!,
      fijoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fijo_id'],
      ),
    );
  }

  @override
  $MovimientosTable createAlias(String alias) {
    return $MovimientosTable(attachedDatabase, alias);
  }
}

class Movimiento extends DataClass implements Insertable<Movimiento> {
  final int id;
  final String tipo;
  final int monto;
  final DateTime fecha;
  final String? descripcion;
  final int? categoriaId;

  /// Cuenta de origen (gasto, transferencia, pago de tarjeta) o destino (ingreso).
  final int? cuentaId;
  final int? cuentaDestinoId;

  /// Tarjeta con la que se pagó un gasto, o tarjeta que recibe un pago.
  final int? tarjetaId;
  final int cuotas;
  final int? fijoId;
  const Movimiento({
    required this.id,
    required this.tipo,
    required this.monto,
    required this.fecha,
    this.descripcion,
    this.categoriaId,
    this.cuentaId,
    this.cuentaDestinoId,
    this.tarjetaId,
    required this.cuotas,
    this.fijoId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tipo'] = Variable<String>(tipo);
    map['monto'] = Variable<int>(monto);
    map['fecha'] = Variable<DateTime>(fecha);
    if (!nullToAbsent || descripcion != null) {
      map['descripcion'] = Variable<String>(descripcion);
    }
    if (!nullToAbsent || categoriaId != null) {
      map['categoria_id'] = Variable<int>(categoriaId);
    }
    if (!nullToAbsent || cuentaId != null) {
      map['cuenta_id'] = Variable<int>(cuentaId);
    }
    if (!nullToAbsent || cuentaDestinoId != null) {
      map['cuenta_destino_id'] = Variable<int>(cuentaDestinoId);
    }
    if (!nullToAbsent || tarjetaId != null) {
      map['tarjeta_id'] = Variable<int>(tarjetaId);
    }
    map['cuotas'] = Variable<int>(cuotas);
    if (!nullToAbsent || fijoId != null) {
      map['fijo_id'] = Variable<int>(fijoId);
    }
    return map;
  }

  MovimientosCompanion toCompanion(bool nullToAbsent) {
    return MovimientosCompanion(
      id: Value(id),
      tipo: Value(tipo),
      monto: Value(monto),
      fecha: Value(fecha),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
      categoriaId: categoriaId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoriaId),
      cuentaId: cuentaId == null && nullToAbsent
          ? const Value.absent()
          : Value(cuentaId),
      cuentaDestinoId: cuentaDestinoId == null && nullToAbsent
          ? const Value.absent()
          : Value(cuentaDestinoId),
      tarjetaId: tarjetaId == null && nullToAbsent
          ? const Value.absent()
          : Value(tarjetaId),
      cuotas: Value(cuotas),
      fijoId: fijoId == null && nullToAbsent
          ? const Value.absent()
          : Value(fijoId),
    );
  }

  factory Movimiento.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Movimiento(
      id: serializer.fromJson<int>(json['id']),
      tipo: serializer.fromJson<String>(json['tipo']),
      monto: serializer.fromJson<int>(json['monto']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      descripcion: serializer.fromJson<String?>(json['descripcion']),
      categoriaId: serializer.fromJson<int?>(json['categoriaId']),
      cuentaId: serializer.fromJson<int?>(json['cuentaId']),
      cuentaDestinoId: serializer.fromJson<int?>(json['cuentaDestinoId']),
      tarjetaId: serializer.fromJson<int?>(json['tarjetaId']),
      cuotas: serializer.fromJson<int>(json['cuotas']),
      fijoId: serializer.fromJson<int?>(json['fijoId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tipo': serializer.toJson<String>(tipo),
      'monto': serializer.toJson<int>(monto),
      'fecha': serializer.toJson<DateTime>(fecha),
      'descripcion': serializer.toJson<String?>(descripcion),
      'categoriaId': serializer.toJson<int?>(categoriaId),
      'cuentaId': serializer.toJson<int?>(cuentaId),
      'cuentaDestinoId': serializer.toJson<int?>(cuentaDestinoId),
      'tarjetaId': serializer.toJson<int?>(tarjetaId),
      'cuotas': serializer.toJson<int>(cuotas),
      'fijoId': serializer.toJson<int?>(fijoId),
    };
  }

  Movimiento copyWith({
    int? id,
    String? tipo,
    int? monto,
    DateTime? fecha,
    Value<String?> descripcion = const Value.absent(),
    Value<int?> categoriaId = const Value.absent(),
    Value<int?> cuentaId = const Value.absent(),
    Value<int?> cuentaDestinoId = const Value.absent(),
    Value<int?> tarjetaId = const Value.absent(),
    int? cuotas,
    Value<int?> fijoId = const Value.absent(),
  }) => Movimiento(
    id: id ?? this.id,
    tipo: tipo ?? this.tipo,
    monto: monto ?? this.monto,
    fecha: fecha ?? this.fecha,
    descripcion: descripcion.present ? descripcion.value : this.descripcion,
    categoriaId: categoriaId.present ? categoriaId.value : this.categoriaId,
    cuentaId: cuentaId.present ? cuentaId.value : this.cuentaId,
    cuentaDestinoId: cuentaDestinoId.present
        ? cuentaDestinoId.value
        : this.cuentaDestinoId,
    tarjetaId: tarjetaId.present ? tarjetaId.value : this.tarjetaId,
    cuotas: cuotas ?? this.cuotas,
    fijoId: fijoId.present ? fijoId.value : this.fijoId,
  );
  Movimiento copyWithCompanion(MovimientosCompanion data) {
    return Movimiento(
      id: data.id.present ? data.id.value : this.id,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      monto: data.monto.present ? data.monto.value : this.monto,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      categoriaId: data.categoriaId.present
          ? data.categoriaId.value
          : this.categoriaId,
      cuentaId: data.cuentaId.present ? data.cuentaId.value : this.cuentaId,
      cuentaDestinoId: data.cuentaDestinoId.present
          ? data.cuentaDestinoId.value
          : this.cuentaDestinoId,
      tarjetaId: data.tarjetaId.present ? data.tarjetaId.value : this.tarjetaId,
      cuotas: data.cuotas.present ? data.cuotas.value : this.cuotas,
      fijoId: data.fijoId.present ? data.fijoId.value : this.fijoId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Movimiento(')
          ..write('id: $id, ')
          ..write('tipo: $tipo, ')
          ..write('monto: $monto, ')
          ..write('fecha: $fecha, ')
          ..write('descripcion: $descripcion, ')
          ..write('categoriaId: $categoriaId, ')
          ..write('cuentaId: $cuentaId, ')
          ..write('cuentaDestinoId: $cuentaDestinoId, ')
          ..write('tarjetaId: $tarjetaId, ')
          ..write('cuotas: $cuotas, ')
          ..write('fijoId: $fijoId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tipo,
    monto,
    fecha,
    descripcion,
    categoriaId,
    cuentaId,
    cuentaDestinoId,
    tarjetaId,
    cuotas,
    fijoId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Movimiento &&
          other.id == this.id &&
          other.tipo == this.tipo &&
          other.monto == this.monto &&
          other.fecha == this.fecha &&
          other.descripcion == this.descripcion &&
          other.categoriaId == this.categoriaId &&
          other.cuentaId == this.cuentaId &&
          other.cuentaDestinoId == this.cuentaDestinoId &&
          other.tarjetaId == this.tarjetaId &&
          other.cuotas == this.cuotas &&
          other.fijoId == this.fijoId);
}

class MovimientosCompanion extends UpdateCompanion<Movimiento> {
  final Value<int> id;
  final Value<String> tipo;
  final Value<int> monto;
  final Value<DateTime> fecha;
  final Value<String?> descripcion;
  final Value<int?> categoriaId;
  final Value<int?> cuentaId;
  final Value<int?> cuentaDestinoId;
  final Value<int?> tarjetaId;
  final Value<int> cuotas;
  final Value<int?> fijoId;
  const MovimientosCompanion({
    this.id = const Value.absent(),
    this.tipo = const Value.absent(),
    this.monto = const Value.absent(),
    this.fecha = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.categoriaId = const Value.absent(),
    this.cuentaId = const Value.absent(),
    this.cuentaDestinoId = const Value.absent(),
    this.tarjetaId = const Value.absent(),
    this.cuotas = const Value.absent(),
    this.fijoId = const Value.absent(),
  });
  MovimientosCompanion.insert({
    this.id = const Value.absent(),
    required String tipo,
    required int monto,
    required DateTime fecha,
    this.descripcion = const Value.absent(),
    this.categoriaId = const Value.absent(),
    this.cuentaId = const Value.absent(),
    this.cuentaDestinoId = const Value.absent(),
    this.tarjetaId = const Value.absent(),
    this.cuotas = const Value.absent(),
    this.fijoId = const Value.absent(),
  }) : tipo = Value(tipo),
       monto = Value(monto),
       fecha = Value(fecha);
  static Insertable<Movimiento> custom({
    Expression<int>? id,
    Expression<String>? tipo,
    Expression<int>? monto,
    Expression<DateTime>? fecha,
    Expression<String>? descripcion,
    Expression<int>? categoriaId,
    Expression<int>? cuentaId,
    Expression<int>? cuentaDestinoId,
    Expression<int>? tarjetaId,
    Expression<int>? cuotas,
    Expression<int>? fijoId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tipo != null) 'tipo': tipo,
      if (monto != null) 'monto': monto,
      if (fecha != null) 'fecha': fecha,
      if (descripcion != null) 'descripcion': descripcion,
      if (categoriaId != null) 'categoria_id': categoriaId,
      if (cuentaId != null) 'cuenta_id': cuentaId,
      if (cuentaDestinoId != null) 'cuenta_destino_id': cuentaDestinoId,
      if (tarjetaId != null) 'tarjeta_id': tarjetaId,
      if (cuotas != null) 'cuotas': cuotas,
      if (fijoId != null) 'fijo_id': fijoId,
    });
  }

  MovimientosCompanion copyWith({
    Value<int>? id,
    Value<String>? tipo,
    Value<int>? monto,
    Value<DateTime>? fecha,
    Value<String?>? descripcion,
    Value<int?>? categoriaId,
    Value<int?>? cuentaId,
    Value<int?>? cuentaDestinoId,
    Value<int?>? tarjetaId,
    Value<int>? cuotas,
    Value<int?>? fijoId,
  }) {
    return MovimientosCompanion(
      id: id ?? this.id,
      tipo: tipo ?? this.tipo,
      monto: monto ?? this.monto,
      fecha: fecha ?? this.fecha,
      descripcion: descripcion ?? this.descripcion,
      categoriaId: categoriaId ?? this.categoriaId,
      cuentaId: cuentaId ?? this.cuentaId,
      cuentaDestinoId: cuentaDestinoId ?? this.cuentaDestinoId,
      tarjetaId: tarjetaId ?? this.tarjetaId,
      cuotas: cuotas ?? this.cuotas,
      fijoId: fijoId ?? this.fijoId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (monto.present) {
      map['monto'] = Variable<int>(monto.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (categoriaId.present) {
      map['categoria_id'] = Variable<int>(categoriaId.value);
    }
    if (cuentaId.present) {
      map['cuenta_id'] = Variable<int>(cuentaId.value);
    }
    if (cuentaDestinoId.present) {
      map['cuenta_destino_id'] = Variable<int>(cuentaDestinoId.value);
    }
    if (tarjetaId.present) {
      map['tarjeta_id'] = Variable<int>(tarjetaId.value);
    }
    if (cuotas.present) {
      map['cuotas'] = Variable<int>(cuotas.value);
    }
    if (fijoId.present) {
      map['fijo_id'] = Variable<int>(fijoId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MovimientosCompanion(')
          ..write('id: $id, ')
          ..write('tipo: $tipo, ')
          ..write('monto: $monto, ')
          ..write('fecha: $fecha, ')
          ..write('descripcion: $descripcion, ')
          ..write('categoriaId: $categoriaId, ')
          ..write('cuentaId: $cuentaId, ')
          ..write('cuentaDestinoId: $cuentaDestinoId, ')
          ..write('tarjetaId: $tarjetaId, ')
          ..write('cuotas: $cuotas, ')
          ..write('fijoId: $fijoId')
          ..write(')'))
        .toString();
  }
}

class $MetasTable extends Metas with TableInfo<$MetasTable, Meta> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MetasTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _objetivoMeta = const VerificationMeta(
    'objetivo',
  );
  @override
  late final GeneratedColumn<int> objetivo = GeneratedColumn<int>(
    'objetivo',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ahorradoMeta = const VerificationMeta(
    'ahorrado',
  );
  @override
  late final GeneratedColumn<int> ahorrado = GeneratedColumn<int>(
    'ahorrado',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _fechaObjetivoMeta = const VerificationMeta(
    'fechaObjetivo',
  );
  @override
  late final GeneratedColumn<DateTime> fechaObjetivo =
      GeneratedColumn<DateTime>(
        'fecha_objetivo',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _dondeEstaMeta = const VerificationMeta(
    'dondeEsta',
  );
  @override
  late final GeneratedColumn<String> dondeEsta = GeneratedColumn<String>(
    'donde_esta',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    objetivo,
    ahorrado,
    fechaObjetivo,
    dondeEsta,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fin_metas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Meta> instance, {
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
    if (data.containsKey('objetivo')) {
      context.handle(
        _objetivoMeta,
        objetivo.isAcceptableOrUnknown(data['objetivo']!, _objetivoMeta),
      );
    } else if (isInserting) {
      context.missing(_objetivoMeta);
    }
    if (data.containsKey('ahorrado')) {
      context.handle(
        _ahorradoMeta,
        ahorrado.isAcceptableOrUnknown(data['ahorrado']!, _ahorradoMeta),
      );
    }
    if (data.containsKey('fecha_objetivo')) {
      context.handle(
        _fechaObjetivoMeta,
        fechaObjetivo.isAcceptableOrUnknown(
          data['fecha_objetivo']!,
          _fechaObjetivoMeta,
        ),
      );
    }
    if (data.containsKey('donde_esta')) {
      context.handle(
        _dondeEstaMeta,
        dondeEsta.isAcceptableOrUnknown(data['donde_esta']!, _dondeEstaMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Meta map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Meta(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      objetivo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}objetivo'],
      )!,
      ahorrado: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ahorrado'],
      )!,
      fechaObjetivo: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_objetivo'],
      ),
      dondeEsta: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}donde_esta'],
      ),
    );
  }

  @override
  $MetasTable createAlias(String alias) {
    return $MetasTable(attachedDatabase, alias);
  }
}

class Meta extends DataClass implements Insertable<Meta> {
  final int id;
  final String nombre;
  final int objetivo;
  final int ahorrado;
  final DateTime? fechaObjetivo;

  /// Dónde está guardado el dinero (texto libre: "Nequi", "CDT Bancolombia").
  final String? dondeEsta;
  const Meta({
    required this.id,
    required this.nombre,
    required this.objetivo,
    required this.ahorrado,
    this.fechaObjetivo,
    this.dondeEsta,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['objetivo'] = Variable<int>(objetivo);
    map['ahorrado'] = Variable<int>(ahorrado);
    if (!nullToAbsent || fechaObjetivo != null) {
      map['fecha_objetivo'] = Variable<DateTime>(fechaObjetivo);
    }
    if (!nullToAbsent || dondeEsta != null) {
      map['donde_esta'] = Variable<String>(dondeEsta);
    }
    return map;
  }

  MetasCompanion toCompanion(bool nullToAbsent) {
    return MetasCompanion(
      id: Value(id),
      nombre: Value(nombre),
      objetivo: Value(objetivo),
      ahorrado: Value(ahorrado),
      fechaObjetivo: fechaObjetivo == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaObjetivo),
      dondeEsta: dondeEsta == null && nullToAbsent
          ? const Value.absent()
          : Value(dondeEsta),
    );
  }

  factory Meta.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Meta(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      objetivo: serializer.fromJson<int>(json['objetivo']),
      ahorrado: serializer.fromJson<int>(json['ahorrado']),
      fechaObjetivo: serializer.fromJson<DateTime?>(json['fechaObjetivo']),
      dondeEsta: serializer.fromJson<String?>(json['dondeEsta']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'objetivo': serializer.toJson<int>(objetivo),
      'ahorrado': serializer.toJson<int>(ahorrado),
      'fechaObjetivo': serializer.toJson<DateTime?>(fechaObjetivo),
      'dondeEsta': serializer.toJson<String?>(dondeEsta),
    };
  }

  Meta copyWith({
    int? id,
    String? nombre,
    int? objetivo,
    int? ahorrado,
    Value<DateTime?> fechaObjetivo = const Value.absent(),
    Value<String?> dondeEsta = const Value.absent(),
  }) => Meta(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    objetivo: objetivo ?? this.objetivo,
    ahorrado: ahorrado ?? this.ahorrado,
    fechaObjetivo: fechaObjetivo.present
        ? fechaObjetivo.value
        : this.fechaObjetivo,
    dondeEsta: dondeEsta.present ? dondeEsta.value : this.dondeEsta,
  );
  Meta copyWithCompanion(MetasCompanion data) {
    return Meta(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      objetivo: data.objetivo.present ? data.objetivo.value : this.objetivo,
      ahorrado: data.ahorrado.present ? data.ahorrado.value : this.ahorrado,
      fechaObjetivo: data.fechaObjetivo.present
          ? data.fechaObjetivo.value
          : this.fechaObjetivo,
      dondeEsta: data.dondeEsta.present ? data.dondeEsta.value : this.dondeEsta,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Meta(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('objetivo: $objetivo, ')
          ..write('ahorrado: $ahorrado, ')
          ..write('fechaObjetivo: $fechaObjetivo, ')
          ..write('dondeEsta: $dondeEsta')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nombre, objetivo, ahorrado, fechaObjetivo, dondeEsta);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Meta &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.objetivo == this.objetivo &&
          other.ahorrado == this.ahorrado &&
          other.fechaObjetivo == this.fechaObjetivo &&
          other.dondeEsta == this.dondeEsta);
}

class MetasCompanion extends UpdateCompanion<Meta> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<int> objetivo;
  final Value<int> ahorrado;
  final Value<DateTime?> fechaObjetivo;
  final Value<String?> dondeEsta;
  const MetasCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.objetivo = const Value.absent(),
    this.ahorrado = const Value.absent(),
    this.fechaObjetivo = const Value.absent(),
    this.dondeEsta = const Value.absent(),
  });
  MetasCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required int objetivo,
    this.ahorrado = const Value.absent(),
    this.fechaObjetivo = const Value.absent(),
    this.dondeEsta = const Value.absent(),
  }) : nombre = Value(nombre),
       objetivo = Value(objetivo);
  static Insertable<Meta> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<int>? objetivo,
    Expression<int>? ahorrado,
    Expression<DateTime>? fechaObjetivo,
    Expression<String>? dondeEsta,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (objetivo != null) 'objetivo': objetivo,
      if (ahorrado != null) 'ahorrado': ahorrado,
      if (fechaObjetivo != null) 'fecha_objetivo': fechaObjetivo,
      if (dondeEsta != null) 'donde_esta': dondeEsta,
    });
  }

  MetasCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<int>? objetivo,
    Value<int>? ahorrado,
    Value<DateTime?>? fechaObjetivo,
    Value<String?>? dondeEsta,
  }) {
    return MetasCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      objetivo: objetivo ?? this.objetivo,
      ahorrado: ahorrado ?? this.ahorrado,
      fechaObjetivo: fechaObjetivo ?? this.fechaObjetivo,
      dondeEsta: dondeEsta ?? this.dondeEsta,
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
    if (objetivo.present) {
      map['objetivo'] = Variable<int>(objetivo.value);
    }
    if (ahorrado.present) {
      map['ahorrado'] = Variable<int>(ahorrado.value);
    }
    if (fechaObjetivo.present) {
      map['fecha_objetivo'] = Variable<DateTime>(fechaObjetivo.value);
    }
    if (dondeEsta.present) {
      map['donde_esta'] = Variable<String>(dondeEsta.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MetasCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('objetivo: $objetivo, ')
          ..write('ahorrado: $ahorrado, ')
          ..write('fechaObjetivo: $fechaObjetivo, ')
          ..write('dondeEsta: $dondeEsta')
          ..write(')'))
        .toString();
  }
}

class $DeudasTable extends Deudas with TableInfo<$DeudasTable, Deuda> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DeudasTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _personaMeta = const VerificationMeta(
    'persona',
  );
  @override
  late final GeneratedColumn<String> persona = GeneratedColumn<String>(
    'persona',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 60,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _direccionMeta = const VerificationMeta(
    'direccion',
  );
  @override
  late final GeneratedColumn<String> direccion = GeneratedColumn<String>(
    'direccion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _montoMeta = const VerificationMeta('monto');
  @override
  late final GeneratedColumn<int> monto = GeneratedColumn<int>(
    'monto',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _abonadoMeta = const VerificationMeta(
    'abonado',
  );
  @override
  late final GeneratedColumn<int> abonado = GeneratedColumn<int>(
    'abonado',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _notaMeta = const VerificationMeta('nota');
  @override
  late final GeneratedColumn<String> nota = GeneratedColumn<String>(
    'nota',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
    'fecha',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    persona,
    direccion,
    monto,
    abonado,
    nota,
    fecha,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fin_deudas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Deuda> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('persona')) {
      context.handle(
        _personaMeta,
        persona.isAcceptableOrUnknown(data['persona']!, _personaMeta),
      );
    } else if (isInserting) {
      context.missing(_personaMeta);
    }
    if (data.containsKey('direccion')) {
      context.handle(
        _direccionMeta,
        direccion.isAcceptableOrUnknown(data['direccion']!, _direccionMeta),
      );
    } else if (isInserting) {
      context.missing(_direccionMeta);
    }
    if (data.containsKey('monto')) {
      context.handle(
        _montoMeta,
        monto.isAcceptableOrUnknown(data['monto']!, _montoMeta),
      );
    } else if (isInserting) {
      context.missing(_montoMeta);
    }
    if (data.containsKey('abonado')) {
      context.handle(
        _abonadoMeta,
        abonado.isAcceptableOrUnknown(data['abonado']!, _abonadoMeta),
      );
    }
    if (data.containsKey('nota')) {
      context.handle(
        _notaMeta,
        nota.isAcceptableOrUnknown(data['nota']!, _notaMeta),
      );
    }
    if (data.containsKey('fecha')) {
      context.handle(
        _fechaMeta,
        fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta),
      );
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Deuda map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Deuda(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      persona: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}persona'],
      )!,
      direccion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}direccion'],
      )!,
      monto: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}monto'],
      )!,
      abonado: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}abonado'],
      )!,
      nota: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nota'],
      ),
      fecha: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha'],
      )!,
    );
  }

  @override
  $DeudasTable createAlias(String alias) {
    return $DeudasTable(attachedDatabase, alias);
  }
}

class Deuda extends DataClass implements Insertable<Deuda> {
  final int id;
  final String persona;
  final String direccion;
  final int monto;
  final int abonado;
  final String? nota;
  final DateTime fecha;
  const Deuda({
    required this.id,
    required this.persona,
    required this.direccion,
    required this.monto,
    required this.abonado,
    this.nota,
    required this.fecha,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['persona'] = Variable<String>(persona);
    map['direccion'] = Variable<String>(direccion);
    map['monto'] = Variable<int>(monto);
    map['abonado'] = Variable<int>(abonado);
    if (!nullToAbsent || nota != null) {
      map['nota'] = Variable<String>(nota);
    }
    map['fecha'] = Variable<DateTime>(fecha);
    return map;
  }

  DeudasCompanion toCompanion(bool nullToAbsent) {
    return DeudasCompanion(
      id: Value(id),
      persona: Value(persona),
      direccion: Value(direccion),
      monto: Value(monto),
      abonado: Value(abonado),
      nota: nota == null && nullToAbsent ? const Value.absent() : Value(nota),
      fecha: Value(fecha),
    );
  }

  factory Deuda.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Deuda(
      id: serializer.fromJson<int>(json['id']),
      persona: serializer.fromJson<String>(json['persona']),
      direccion: serializer.fromJson<String>(json['direccion']),
      monto: serializer.fromJson<int>(json['monto']),
      abonado: serializer.fromJson<int>(json['abonado']),
      nota: serializer.fromJson<String?>(json['nota']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'persona': serializer.toJson<String>(persona),
      'direccion': serializer.toJson<String>(direccion),
      'monto': serializer.toJson<int>(monto),
      'abonado': serializer.toJson<int>(abonado),
      'nota': serializer.toJson<String?>(nota),
      'fecha': serializer.toJson<DateTime>(fecha),
    };
  }

  Deuda copyWith({
    int? id,
    String? persona,
    String? direccion,
    int? monto,
    int? abonado,
    Value<String?> nota = const Value.absent(),
    DateTime? fecha,
  }) => Deuda(
    id: id ?? this.id,
    persona: persona ?? this.persona,
    direccion: direccion ?? this.direccion,
    monto: monto ?? this.monto,
    abonado: abonado ?? this.abonado,
    nota: nota.present ? nota.value : this.nota,
    fecha: fecha ?? this.fecha,
  );
  Deuda copyWithCompanion(DeudasCompanion data) {
    return Deuda(
      id: data.id.present ? data.id.value : this.id,
      persona: data.persona.present ? data.persona.value : this.persona,
      direccion: data.direccion.present ? data.direccion.value : this.direccion,
      monto: data.monto.present ? data.monto.value : this.monto,
      abonado: data.abonado.present ? data.abonado.value : this.abonado,
      nota: data.nota.present ? data.nota.value : this.nota,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Deuda(')
          ..write('id: $id, ')
          ..write('persona: $persona, ')
          ..write('direccion: $direccion, ')
          ..write('monto: $monto, ')
          ..write('abonado: $abonado, ')
          ..write('nota: $nota, ')
          ..write('fecha: $fecha')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, persona, direccion, monto, abonado, nota, fecha);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Deuda &&
          other.id == this.id &&
          other.persona == this.persona &&
          other.direccion == this.direccion &&
          other.monto == this.monto &&
          other.abonado == this.abonado &&
          other.nota == this.nota &&
          other.fecha == this.fecha);
}

class DeudasCompanion extends UpdateCompanion<Deuda> {
  final Value<int> id;
  final Value<String> persona;
  final Value<String> direccion;
  final Value<int> monto;
  final Value<int> abonado;
  final Value<String?> nota;
  final Value<DateTime> fecha;
  const DeudasCompanion({
    this.id = const Value.absent(),
    this.persona = const Value.absent(),
    this.direccion = const Value.absent(),
    this.monto = const Value.absent(),
    this.abonado = const Value.absent(),
    this.nota = const Value.absent(),
    this.fecha = const Value.absent(),
  });
  DeudasCompanion.insert({
    this.id = const Value.absent(),
    required String persona,
    required String direccion,
    required int monto,
    this.abonado = const Value.absent(),
    this.nota = const Value.absent(),
    required DateTime fecha,
  }) : persona = Value(persona),
       direccion = Value(direccion),
       monto = Value(monto),
       fecha = Value(fecha);
  static Insertable<Deuda> custom({
    Expression<int>? id,
    Expression<String>? persona,
    Expression<String>? direccion,
    Expression<int>? monto,
    Expression<int>? abonado,
    Expression<String>? nota,
    Expression<DateTime>? fecha,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (persona != null) 'persona': persona,
      if (direccion != null) 'direccion': direccion,
      if (monto != null) 'monto': monto,
      if (abonado != null) 'abonado': abonado,
      if (nota != null) 'nota': nota,
      if (fecha != null) 'fecha': fecha,
    });
  }

  DeudasCompanion copyWith({
    Value<int>? id,
    Value<String>? persona,
    Value<String>? direccion,
    Value<int>? monto,
    Value<int>? abonado,
    Value<String?>? nota,
    Value<DateTime>? fecha,
  }) {
    return DeudasCompanion(
      id: id ?? this.id,
      persona: persona ?? this.persona,
      direccion: direccion ?? this.direccion,
      monto: monto ?? this.monto,
      abonado: abonado ?? this.abonado,
      nota: nota ?? this.nota,
      fecha: fecha ?? this.fecha,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (persona.present) {
      map['persona'] = Variable<String>(persona.value);
    }
    if (direccion.present) {
      map['direccion'] = Variable<String>(direccion.value);
    }
    if (monto.present) {
      map['monto'] = Variable<int>(monto.value);
    }
    if (abonado.present) {
      map['abonado'] = Variable<int>(abonado.value);
    }
    if (nota.present) {
      map['nota'] = Variable<String>(nota.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeudasCompanion(')
          ..write('id: $id, ')
          ..write('persona: $persona, ')
          ..write('direccion: $direccion, ')
          ..write('monto: $monto, ')
          ..write('abonado: $abonado, ')
          ..write('nota: $nota, ')
          ..write('fecha: $fecha')
          ..write(')'))
        .toString();
  }
}

class $EjerciciosTable extends Ejercicios
    with TableInfo<$EjerciciosTable, Ejercicio> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EjerciciosTable(this.attachedDatabase, [this._alias]);
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
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _grupoMeta = const VerificationMeta('grupo');
  @override
  late final GeneratedColumn<String> grupo = GeneratedColumn<String>(
    'grupo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _equipoMeta = const VerificationMeta('equipo');
  @override
  late final GeneratedColumn<String> equipo = GeneratedColumn<String>(
    'equipo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(Equipo.maquina),
  );
  static const VerificationMeta _maquinaMeta = const VerificationMeta(
    'maquina',
  );
  @override
  late final GeneratedColumn<String> maquina = GeneratedColumn<String>(
    'maquina',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nombre, grupo, equipo, maquina];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ent_ejercicios';
  @override
  VerificationContext validateIntegrity(
    Insertable<Ejercicio> instance, {
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
    if (data.containsKey('grupo')) {
      context.handle(
        _grupoMeta,
        grupo.isAcceptableOrUnknown(data['grupo']!, _grupoMeta),
      );
    } else if (isInserting) {
      context.missing(_grupoMeta);
    }
    if (data.containsKey('equipo')) {
      context.handle(
        _equipoMeta,
        equipo.isAcceptableOrUnknown(data['equipo']!, _equipoMeta),
      );
    }
    if (data.containsKey('maquina')) {
      context.handle(
        _maquinaMeta,
        maquina.isAcceptableOrUnknown(data['maquina']!, _maquinaMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Ejercicio map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Ejercicio(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      grupo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grupo'],
      )!,
      equipo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}equipo'],
      )!,
      maquina: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}maquina'],
      ),
    );
  }

  @override
  $EjerciciosTable createAlias(String alias) {
    return $EjerciciosTable(attachedDatabase, alias);
  }
}

class Ejercicio extends DataClass implements Insertable<Ejercicio> {
  final int id;
  final String nombre;
  final String grupo;
  final String equipo;

  /// Nombre de la máquina concreta del gimnasio, si aplica.
  final String? maquina;
  const Ejercicio({
    required this.id,
    required this.nombre,
    required this.grupo,
    required this.equipo,
    this.maquina,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['grupo'] = Variable<String>(grupo);
    map['equipo'] = Variable<String>(equipo);
    if (!nullToAbsent || maquina != null) {
      map['maquina'] = Variable<String>(maquina);
    }
    return map;
  }

  EjerciciosCompanion toCompanion(bool nullToAbsent) {
    return EjerciciosCompanion(
      id: Value(id),
      nombre: Value(nombre),
      grupo: Value(grupo),
      equipo: Value(equipo),
      maquina: maquina == null && nullToAbsent
          ? const Value.absent()
          : Value(maquina),
    );
  }

  factory Ejercicio.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Ejercicio(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      grupo: serializer.fromJson<String>(json['grupo']),
      equipo: serializer.fromJson<String>(json['equipo']),
      maquina: serializer.fromJson<String?>(json['maquina']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'grupo': serializer.toJson<String>(grupo),
      'equipo': serializer.toJson<String>(equipo),
      'maquina': serializer.toJson<String?>(maquina),
    };
  }

  Ejercicio copyWith({
    int? id,
    String? nombre,
    String? grupo,
    String? equipo,
    Value<String?> maquina = const Value.absent(),
  }) => Ejercicio(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    grupo: grupo ?? this.grupo,
    equipo: equipo ?? this.equipo,
    maquina: maquina.present ? maquina.value : this.maquina,
  );
  Ejercicio copyWithCompanion(EjerciciosCompanion data) {
    return Ejercicio(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      grupo: data.grupo.present ? data.grupo.value : this.grupo,
      equipo: data.equipo.present ? data.equipo.value : this.equipo,
      maquina: data.maquina.present ? data.maquina.value : this.maquina,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Ejercicio(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('grupo: $grupo, ')
          ..write('equipo: $equipo, ')
          ..write('maquina: $maquina')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre, grupo, equipo, maquina);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Ejercicio &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.grupo == this.grupo &&
          other.equipo == this.equipo &&
          other.maquina == this.maquina);
}

class EjerciciosCompanion extends UpdateCompanion<Ejercicio> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String> grupo;
  final Value<String> equipo;
  final Value<String?> maquina;
  const EjerciciosCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.grupo = const Value.absent(),
    this.equipo = const Value.absent(),
    this.maquina = const Value.absent(),
  });
  EjerciciosCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required String grupo,
    this.equipo = const Value.absent(),
    this.maquina = const Value.absent(),
  }) : nombre = Value(nombre),
       grupo = Value(grupo);
  static Insertable<Ejercicio> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? grupo,
    Expression<String>? equipo,
    Expression<String>? maquina,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (grupo != null) 'grupo': grupo,
      if (equipo != null) 'equipo': equipo,
      if (maquina != null) 'maquina': maquina,
    });
  }

  EjerciciosCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<String>? grupo,
    Value<String>? equipo,
    Value<String?>? maquina,
  }) {
    return EjerciciosCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      grupo: grupo ?? this.grupo,
      equipo: equipo ?? this.equipo,
      maquina: maquina ?? this.maquina,
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
    if (grupo.present) {
      map['grupo'] = Variable<String>(grupo.value);
    }
    if (equipo.present) {
      map['equipo'] = Variable<String>(equipo.value);
    }
    if (maquina.present) {
      map['maquina'] = Variable<String>(maquina.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EjerciciosCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('grupo: $grupo, ')
          ..write('equipo: $equipo, ')
          ..write('maquina: $maquina')
          ..write(')'))
        .toString();
  }
}

class $SesionesTable extends Sesiones with TableInfo<$SesionesTable, Sesion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SesionesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
    'fecha',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tituloMeta = const VerificationMeta('titulo');
  @override
  late final GeneratedColumn<String> titulo = GeneratedColumn<String>(
    'titulo',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 60,
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
  @override
  List<GeneratedColumn> get $columns => [id, fecha, titulo, notas];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ent_sesiones';
  @override
  VerificationContext validateIntegrity(
    Insertable<Sesion> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('fecha')) {
      context.handle(
        _fechaMeta,
        fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta),
      );
    } else if (isInserting) {
      context.missing(_fechaMeta);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Sesion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Sesion(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fecha: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha'],
      )!,
      titulo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}titulo'],
      )!,
      notas: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notas'],
      ),
    );
  }

  @override
  $SesionesTable createAlias(String alias) {
    return $SesionesTable(attachedDatabase, alias);
  }
}

class Sesion extends DataClass implements Insertable<Sesion> {
  final int id;
  final DateTime fecha;

  /// Lo que se entrenó: "Espalda", "Pecho y tríceps"...
  final String titulo;
  final String? notas;
  const Sesion({
    required this.id,
    required this.fecha,
    required this.titulo,
    this.notas,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['fecha'] = Variable<DateTime>(fecha);
    map['titulo'] = Variable<String>(titulo);
    if (!nullToAbsent || notas != null) {
      map['notas'] = Variable<String>(notas);
    }
    return map;
  }

  SesionesCompanion toCompanion(bool nullToAbsent) {
    return SesionesCompanion(
      id: Value(id),
      fecha: Value(fecha),
      titulo: Value(titulo),
      notas: notas == null && nullToAbsent
          ? const Value.absent()
          : Value(notas),
    );
  }

  factory Sesion.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Sesion(
      id: serializer.fromJson<int>(json['id']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      titulo: serializer.fromJson<String>(json['titulo']),
      notas: serializer.fromJson<String?>(json['notas']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fecha': serializer.toJson<DateTime>(fecha),
      'titulo': serializer.toJson<String>(titulo),
      'notas': serializer.toJson<String?>(notas),
    };
  }

  Sesion copyWith({
    int? id,
    DateTime? fecha,
    String? titulo,
    Value<String?> notas = const Value.absent(),
  }) => Sesion(
    id: id ?? this.id,
    fecha: fecha ?? this.fecha,
    titulo: titulo ?? this.titulo,
    notas: notas.present ? notas.value : this.notas,
  );
  Sesion copyWithCompanion(SesionesCompanion data) {
    return Sesion(
      id: data.id.present ? data.id.value : this.id,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      titulo: data.titulo.present ? data.titulo.value : this.titulo,
      notas: data.notas.present ? data.notas.value : this.notas,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Sesion(')
          ..write('id: $id, ')
          ..write('fecha: $fecha, ')
          ..write('titulo: $titulo, ')
          ..write('notas: $notas')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, fecha, titulo, notas);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Sesion &&
          other.id == this.id &&
          other.fecha == this.fecha &&
          other.titulo == this.titulo &&
          other.notas == this.notas);
}

class SesionesCompanion extends UpdateCompanion<Sesion> {
  final Value<int> id;
  final Value<DateTime> fecha;
  final Value<String> titulo;
  final Value<String?> notas;
  const SesionesCompanion({
    this.id = const Value.absent(),
    this.fecha = const Value.absent(),
    this.titulo = const Value.absent(),
    this.notas = const Value.absent(),
  });
  SesionesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime fecha,
    required String titulo,
    this.notas = const Value.absent(),
  }) : fecha = Value(fecha),
       titulo = Value(titulo);
  static Insertable<Sesion> custom({
    Expression<int>? id,
    Expression<DateTime>? fecha,
    Expression<String>? titulo,
    Expression<String>? notas,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fecha != null) 'fecha': fecha,
      if (titulo != null) 'titulo': titulo,
      if (notas != null) 'notas': notas,
    });
  }

  SesionesCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? fecha,
    Value<String>? titulo,
    Value<String?>? notas,
  }) {
    return SesionesCompanion(
      id: id ?? this.id,
      fecha: fecha ?? this.fecha,
      titulo: titulo ?? this.titulo,
      notas: notas ?? this.notas,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (titulo.present) {
      map['titulo'] = Variable<String>(titulo.value);
    }
    if (notas.present) {
      map['notas'] = Variable<String>(notas.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SesionesCompanion(')
          ..write('id: $id, ')
          ..write('fecha: $fecha, ')
          ..write('titulo: $titulo, ')
          ..write('notas: $notas')
          ..write(')'))
        .toString();
  }
}

class $SeriesTable extends Series with TableInfo<$SeriesTable, Serie> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SeriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _sesionIdMeta = const VerificationMeta(
    'sesionId',
  );
  @override
  late final GeneratedColumn<int> sesionId = GeneratedColumn<int>(
    'sesion_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ent_sesiones (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _ejercicioIdMeta = const VerificationMeta(
    'ejercicioId',
  );
  @override
  late final GeneratedColumn<int> ejercicioId = GeneratedColumn<int>(
    'ejercicio_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ent_ejercicios (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _ordenMeta = const VerificationMeta('orden');
  @override
  late final GeneratedColumn<int> orden = GeneratedColumn<int>(
    'orden',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
    'reps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pesoKgMeta = const VerificationMeta('pesoKg');
  @override
  late final GeneratedColumn<double> pesoKg = GeneratedColumn<double>(
    'peso_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sesionId,
    ejercicioId,
    orden,
    reps,
    pesoKg,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ent_series';
  @override
  VerificationContext validateIntegrity(
    Insertable<Serie> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sesion_id')) {
      context.handle(
        _sesionIdMeta,
        sesionId.isAcceptableOrUnknown(data['sesion_id']!, _sesionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sesionIdMeta);
    }
    if (data.containsKey('ejercicio_id')) {
      context.handle(
        _ejercicioIdMeta,
        ejercicioId.isAcceptableOrUnknown(
          data['ejercicio_id']!,
          _ejercicioIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ejercicioIdMeta);
    }
    if (data.containsKey('orden')) {
      context.handle(
        _ordenMeta,
        orden.isAcceptableOrUnknown(data['orden']!, _ordenMeta),
      );
    } else if (isInserting) {
      context.missing(_ordenMeta);
    }
    if (data.containsKey('reps')) {
      context.handle(
        _repsMeta,
        reps.isAcceptableOrUnknown(data['reps']!, _repsMeta),
      );
    } else if (isInserting) {
      context.missing(_repsMeta);
    }
    if (data.containsKey('peso_kg')) {
      context.handle(
        _pesoKgMeta,
        pesoKg.isAcceptableOrUnknown(data['peso_kg']!, _pesoKgMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Serie map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Serie(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sesionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sesion_id'],
      )!,
      ejercicioId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ejercicio_id'],
      )!,
      orden: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}orden'],
      )!,
      reps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reps'],
      )!,
      pesoKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}peso_kg'],
      )!,
    );
  }

  @override
  $SeriesTable createAlias(String alias) {
    return $SeriesTable(attachedDatabase, alias);
  }
}

class Serie extends DataClass implements Insertable<Serie> {
  final int id;
  final int sesionId;
  final int ejercicioId;
  final int orden;
  final int reps;
  final double pesoKg;
  const Serie({
    required this.id,
    required this.sesionId,
    required this.ejercicioId,
    required this.orden,
    required this.reps,
    required this.pesoKg,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sesion_id'] = Variable<int>(sesionId);
    map['ejercicio_id'] = Variable<int>(ejercicioId);
    map['orden'] = Variable<int>(orden);
    map['reps'] = Variable<int>(reps);
    map['peso_kg'] = Variable<double>(pesoKg);
    return map;
  }

  SeriesCompanion toCompanion(bool nullToAbsent) {
    return SeriesCompanion(
      id: Value(id),
      sesionId: Value(sesionId),
      ejercicioId: Value(ejercicioId),
      orden: Value(orden),
      reps: Value(reps),
      pesoKg: Value(pesoKg),
    );
  }

  factory Serie.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Serie(
      id: serializer.fromJson<int>(json['id']),
      sesionId: serializer.fromJson<int>(json['sesionId']),
      ejercicioId: serializer.fromJson<int>(json['ejercicioId']),
      orden: serializer.fromJson<int>(json['orden']),
      reps: serializer.fromJson<int>(json['reps']),
      pesoKg: serializer.fromJson<double>(json['pesoKg']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sesionId': serializer.toJson<int>(sesionId),
      'ejercicioId': serializer.toJson<int>(ejercicioId),
      'orden': serializer.toJson<int>(orden),
      'reps': serializer.toJson<int>(reps),
      'pesoKg': serializer.toJson<double>(pesoKg),
    };
  }

  Serie copyWith({
    int? id,
    int? sesionId,
    int? ejercicioId,
    int? orden,
    int? reps,
    double? pesoKg,
  }) => Serie(
    id: id ?? this.id,
    sesionId: sesionId ?? this.sesionId,
    ejercicioId: ejercicioId ?? this.ejercicioId,
    orden: orden ?? this.orden,
    reps: reps ?? this.reps,
    pesoKg: pesoKg ?? this.pesoKg,
  );
  Serie copyWithCompanion(SeriesCompanion data) {
    return Serie(
      id: data.id.present ? data.id.value : this.id,
      sesionId: data.sesionId.present ? data.sesionId.value : this.sesionId,
      ejercicioId: data.ejercicioId.present
          ? data.ejercicioId.value
          : this.ejercicioId,
      orden: data.orden.present ? data.orden.value : this.orden,
      reps: data.reps.present ? data.reps.value : this.reps,
      pesoKg: data.pesoKg.present ? data.pesoKg.value : this.pesoKg,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Serie(')
          ..write('id: $id, ')
          ..write('sesionId: $sesionId, ')
          ..write('ejercicioId: $ejercicioId, ')
          ..write('orden: $orden, ')
          ..write('reps: $reps, ')
          ..write('pesoKg: $pesoKg')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, sesionId, ejercicioId, orden, reps, pesoKg);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Serie &&
          other.id == this.id &&
          other.sesionId == this.sesionId &&
          other.ejercicioId == this.ejercicioId &&
          other.orden == this.orden &&
          other.reps == this.reps &&
          other.pesoKg == this.pesoKg);
}

class SeriesCompanion extends UpdateCompanion<Serie> {
  final Value<int> id;
  final Value<int> sesionId;
  final Value<int> ejercicioId;
  final Value<int> orden;
  final Value<int> reps;
  final Value<double> pesoKg;
  const SeriesCompanion({
    this.id = const Value.absent(),
    this.sesionId = const Value.absent(),
    this.ejercicioId = const Value.absent(),
    this.orden = const Value.absent(),
    this.reps = const Value.absent(),
    this.pesoKg = const Value.absent(),
  });
  SeriesCompanion.insert({
    this.id = const Value.absent(),
    required int sesionId,
    required int ejercicioId,
    required int orden,
    required int reps,
    this.pesoKg = const Value.absent(),
  }) : sesionId = Value(sesionId),
       ejercicioId = Value(ejercicioId),
       orden = Value(orden),
       reps = Value(reps);
  static Insertable<Serie> custom({
    Expression<int>? id,
    Expression<int>? sesionId,
    Expression<int>? ejercicioId,
    Expression<int>? orden,
    Expression<int>? reps,
    Expression<double>? pesoKg,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sesionId != null) 'sesion_id': sesionId,
      if (ejercicioId != null) 'ejercicio_id': ejercicioId,
      if (orden != null) 'orden': orden,
      if (reps != null) 'reps': reps,
      if (pesoKg != null) 'peso_kg': pesoKg,
    });
  }

  SeriesCompanion copyWith({
    Value<int>? id,
    Value<int>? sesionId,
    Value<int>? ejercicioId,
    Value<int>? orden,
    Value<int>? reps,
    Value<double>? pesoKg,
  }) {
    return SeriesCompanion(
      id: id ?? this.id,
      sesionId: sesionId ?? this.sesionId,
      ejercicioId: ejercicioId ?? this.ejercicioId,
      orden: orden ?? this.orden,
      reps: reps ?? this.reps,
      pesoKg: pesoKg ?? this.pesoKg,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sesionId.present) {
      map['sesion_id'] = Variable<int>(sesionId.value);
    }
    if (ejercicioId.present) {
      map['ejercicio_id'] = Variable<int>(ejercicioId.value);
    }
    if (orden.present) {
      map['orden'] = Variable<int>(orden.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (pesoKg.present) {
      map['peso_kg'] = Variable<double>(pesoKg.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SeriesCompanion(')
          ..write('id: $id, ')
          ..write('sesionId: $sesionId, ')
          ..write('ejercicioId: $ejercicioId, ')
          ..write('orden: $orden, ')
          ..write('reps: $reps, ')
          ..write('pesoKg: $pesoKg')
          ..write(')'))
        .toString();
  }
}

class $MovimientosCocinaTable extends MovimientosCocina
    with TableInfo<$MovimientosCocinaTable, MovCocina> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MovimientosCocinaTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _productoIdMeta = const VerificationMeta(
    'productoId',
  );
  @override
  late final GeneratedColumn<int> productoId = GeneratedColumn<int>(
    'producto_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES coc_productos (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
    'tipo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cantidadMeta = const VerificationMeta(
    'cantidad',
  );
  @override
  late final GeneratedColumn<double> cantidad = GeneratedColumn<double>(
    'cantidad',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
    'fecha',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, productoId, tipo, cantidad, fecha];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'coc_movimientos';
  @override
  VerificationContext validateIntegrity(
    Insertable<MovCocina> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('producto_id')) {
      context.handle(
        _productoIdMeta,
        productoId.isAcceptableOrUnknown(data['producto_id']!, _productoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productoIdMeta);
    }
    if (data.containsKey('tipo')) {
      context.handle(
        _tipoMeta,
        tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta),
      );
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('cantidad')) {
      context.handle(
        _cantidadMeta,
        cantidad.isAcceptableOrUnknown(data['cantidad']!, _cantidadMeta),
      );
    } else if (isInserting) {
      context.missing(_cantidadMeta);
    }
    if (data.containsKey('fecha')) {
      context.handle(
        _fechaMeta,
        fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta),
      );
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MovCocina map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MovCocina(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}producto_id'],
      )!,
      tipo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo'],
      )!,
      cantidad: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cantidad'],
      )!,
      fecha: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha'],
      )!,
    );
  }

  @override
  $MovimientosCocinaTable createAlias(String alias) {
    return $MovimientosCocinaTable(attachedDatabase, alias);
  }
}

class MovCocina extends DataClass implements Insertable<MovCocina> {
  final int id;
  final int productoId;
  final String tipo;
  final double cantidad;
  final DateTime fecha;
  const MovCocina({
    required this.id,
    required this.productoId,
    required this.tipo,
    required this.cantidad,
    required this.fecha,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['producto_id'] = Variable<int>(productoId);
    map['tipo'] = Variable<String>(tipo);
    map['cantidad'] = Variable<double>(cantidad);
    map['fecha'] = Variable<DateTime>(fecha);
    return map;
  }

  MovimientosCocinaCompanion toCompanion(bool nullToAbsent) {
    return MovimientosCocinaCompanion(
      id: Value(id),
      productoId: Value(productoId),
      tipo: Value(tipo),
      cantidad: Value(cantidad),
      fecha: Value(fecha),
    );
  }

  factory MovCocina.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MovCocina(
      id: serializer.fromJson<int>(json['id']),
      productoId: serializer.fromJson<int>(json['productoId']),
      tipo: serializer.fromJson<String>(json['tipo']),
      cantidad: serializer.fromJson<double>(json['cantidad']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productoId': serializer.toJson<int>(productoId),
      'tipo': serializer.toJson<String>(tipo),
      'cantidad': serializer.toJson<double>(cantidad),
      'fecha': serializer.toJson<DateTime>(fecha),
    };
  }

  MovCocina copyWith({
    int? id,
    int? productoId,
    String? tipo,
    double? cantidad,
    DateTime? fecha,
  }) => MovCocina(
    id: id ?? this.id,
    productoId: productoId ?? this.productoId,
    tipo: tipo ?? this.tipo,
    cantidad: cantidad ?? this.cantidad,
    fecha: fecha ?? this.fecha,
  );
  MovCocina copyWithCompanion(MovimientosCocinaCompanion data) {
    return MovCocina(
      id: data.id.present ? data.id.value : this.id,
      productoId: data.productoId.present
          ? data.productoId.value
          : this.productoId,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      cantidad: data.cantidad.present ? data.cantidad.value : this.cantidad,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MovCocina(')
          ..write('id: $id, ')
          ..write('productoId: $productoId, ')
          ..write('tipo: $tipo, ')
          ..write('cantidad: $cantidad, ')
          ..write('fecha: $fecha')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, productoId, tipo, cantidad, fecha);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MovCocina &&
          other.id == this.id &&
          other.productoId == this.productoId &&
          other.tipo == this.tipo &&
          other.cantidad == this.cantidad &&
          other.fecha == this.fecha);
}

class MovimientosCocinaCompanion extends UpdateCompanion<MovCocina> {
  final Value<int> id;
  final Value<int> productoId;
  final Value<String> tipo;
  final Value<double> cantidad;
  final Value<DateTime> fecha;
  const MovimientosCocinaCompanion({
    this.id = const Value.absent(),
    this.productoId = const Value.absent(),
    this.tipo = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.fecha = const Value.absent(),
  });
  MovimientosCocinaCompanion.insert({
    this.id = const Value.absent(),
    required int productoId,
    required String tipo,
    required double cantidad,
    required DateTime fecha,
  }) : productoId = Value(productoId),
       tipo = Value(tipo),
       cantidad = Value(cantidad),
       fecha = Value(fecha);
  static Insertable<MovCocina> custom({
    Expression<int>? id,
    Expression<int>? productoId,
    Expression<String>? tipo,
    Expression<double>? cantidad,
    Expression<DateTime>? fecha,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productoId != null) 'producto_id': productoId,
      if (tipo != null) 'tipo': tipo,
      if (cantidad != null) 'cantidad': cantidad,
      if (fecha != null) 'fecha': fecha,
    });
  }

  MovimientosCocinaCompanion copyWith({
    Value<int>? id,
    Value<int>? productoId,
    Value<String>? tipo,
    Value<double>? cantidad,
    Value<DateTime>? fecha,
  }) {
    return MovimientosCocinaCompanion(
      id: id ?? this.id,
      productoId: productoId ?? this.productoId,
      tipo: tipo ?? this.tipo,
      cantidad: cantidad ?? this.cantidad,
      fecha: fecha ?? this.fecha,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productoId.present) {
      map['producto_id'] = Variable<int>(productoId.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (cantidad.present) {
      map['cantidad'] = Variable<double>(cantidad.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MovimientosCocinaCompanion(')
          ..write('id: $id, ')
          ..write('productoId: $productoId, ')
          ..write('tipo: $tipo, ')
          ..write('cantidad: $cantidad, ')
          ..write('fecha: $fecha')
          ..write(')'))
        .toString();
  }
}

class $IdeasTable extends Ideas with TableInfo<$IdeasTable, Idea> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IdeasTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _formatoMeta = const VerificationMeta(
    'formato',
  );
  @override
  late final GeneratedColumn<String> formato = GeneratedColumn<String>(
    'formato',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(FormatoIdea.reel),
  );
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
    'estado',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(EstadoIdea.idea),
  );
  static const VerificationMeta _hookMeta = const VerificationMeta('hook');
  @override
  late final GeneratedColumn<String> hook = GeneratedColumn<String>(
    'hook',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _guionMeta = const VerificationMeta('guion');
  @override
  late final GeneratedColumn<String> guion = GeneratedColumn<String>(
    'guion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<String> codigo = GeneratedColumn<String>(
    'codigo',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _captionMeta = const VerificationMeta(
    'caption',
  );
  @override
  late final GeneratedColumn<String> caption = GeneratedColumn<String>(
    'caption',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _publicadaEnMeta = const VerificationMeta(
    'publicadaEn',
  );
  @override
  late final GeneratedColumn<DateTime> publicadaEn = GeneratedColumn<DateTime>(
    'publicada_en',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _likesMeta = const VerificationMeta('likes');
  @override
  late final GeneratedColumn<int> likes = GeneratedColumn<int>(
    'likes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _guardadosMeta = const VerificationMeta(
    'guardados',
  );
  @override
  late final GeneratedColumn<int> guardados = GeneratedColumn<int>(
    'guardados',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _comentariosMeta = const VerificationMeta(
    'comentarios',
  );
  @override
  late final GeneratedColumn<int> comentarios = GeneratedColumn<int>(
    'comentarios',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _alcanceMeta = const VerificationMeta(
    'alcance',
  );
  @override
  late final GeneratedColumn<int> alcance = GeneratedColumn<int>(
    'alcance',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _origenMeta = const VerificationMeta('origen');
  @override
  late final GeneratedColumn<String> origen = GeneratedColumn<String>(
    'origen',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(OrigenIdea.manual),
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
    titulo,
    descripcion,
    formato,
    tags,
    estado,
    hook,
    guion,
    codigo,
    caption,
    publicadaEn,
    likes,
    guardados,
    comentarios,
    alcance,
    origen,
    creadaEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ide_ideas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Idea> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('titulo')) {
      context.handle(
        _tituloMeta,
        titulo.isAcceptableOrUnknown(data['titulo']!, _tituloMeta),
      );
    } else if (isInserting) {
      context.missing(_tituloMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    }
    if (data.containsKey('formato')) {
      context.handle(
        _formatoMeta,
        formato.isAcceptableOrUnknown(data['formato']!, _formatoMeta),
      );
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    }
    if (data.containsKey('hook')) {
      context.handle(
        _hookMeta,
        hook.isAcceptableOrUnknown(data['hook']!, _hookMeta),
      );
    }
    if (data.containsKey('guion')) {
      context.handle(
        _guionMeta,
        guion.isAcceptableOrUnknown(data['guion']!, _guionMeta),
      );
    }
    if (data.containsKey('codigo')) {
      context.handle(
        _codigoMeta,
        codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta),
      );
    }
    if (data.containsKey('caption')) {
      context.handle(
        _captionMeta,
        caption.isAcceptableOrUnknown(data['caption']!, _captionMeta),
      );
    }
    if (data.containsKey('publicada_en')) {
      context.handle(
        _publicadaEnMeta,
        publicadaEn.isAcceptableOrUnknown(
          data['publicada_en']!,
          _publicadaEnMeta,
        ),
      );
    }
    if (data.containsKey('likes')) {
      context.handle(
        _likesMeta,
        likes.isAcceptableOrUnknown(data['likes']!, _likesMeta),
      );
    }
    if (data.containsKey('guardados')) {
      context.handle(
        _guardadosMeta,
        guardados.isAcceptableOrUnknown(data['guardados']!, _guardadosMeta),
      );
    }
    if (data.containsKey('comentarios')) {
      context.handle(
        _comentariosMeta,
        comentarios.isAcceptableOrUnknown(
          data['comentarios']!,
          _comentariosMeta,
        ),
      );
    }
    if (data.containsKey('alcance')) {
      context.handle(
        _alcanceMeta,
        alcance.isAcceptableOrUnknown(data['alcance']!, _alcanceMeta),
      );
    }
    if (data.containsKey('origen')) {
      context.handle(
        _origenMeta,
        origen.isAcceptableOrUnknown(data['origen']!, _origenMeta),
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
  Idea map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Idea(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      titulo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}titulo'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      ),
      formato: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}formato'],
      )!,
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      )!,
      estado: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}estado'],
      )!,
      hook: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hook'],
      ),
      guion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}guion'],
      ),
      codigo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}codigo'],
      ),
      caption: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}caption'],
      ),
      publicadaEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}publicada_en'],
      ),
      likes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}likes'],
      ),
      guardados: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}guardados'],
      ),
      comentarios: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}comentarios'],
      ),
      alcance: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}alcance'],
      ),
      origen: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}origen'],
      )!,
      creadaEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creada_en'],
      )!,
    );
  }

  @override
  $IdeasTable createAlias(String alias) {
    return $IdeasTable(attachedDatabase, alias);
  }
}

class Idea extends DataClass implements Insertable<Idea> {
  final int id;
  final String titulo;
  final String? descripcion;
  final String formato;

  /// Tags en minúscula separados por coma: "javascript,css".
  final String tags;
  final String estado;
  final String? hook;
  final String? guion;
  final String? codigo;
  final String? caption;
  final DateTime? publicadaEn;
  final int? likes;
  final int? guardados;
  final int? comentarios;
  final int? alcance;
  final String origen;
  final DateTime creadaEn;
  const Idea({
    required this.id,
    required this.titulo,
    this.descripcion,
    required this.formato,
    required this.tags,
    required this.estado,
    this.hook,
    this.guion,
    this.codigo,
    this.caption,
    this.publicadaEn,
    this.likes,
    this.guardados,
    this.comentarios,
    this.alcance,
    required this.origen,
    required this.creadaEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['titulo'] = Variable<String>(titulo);
    if (!nullToAbsent || descripcion != null) {
      map['descripcion'] = Variable<String>(descripcion);
    }
    map['formato'] = Variable<String>(formato);
    map['tags'] = Variable<String>(tags);
    map['estado'] = Variable<String>(estado);
    if (!nullToAbsent || hook != null) {
      map['hook'] = Variable<String>(hook);
    }
    if (!nullToAbsent || guion != null) {
      map['guion'] = Variable<String>(guion);
    }
    if (!nullToAbsent || codigo != null) {
      map['codigo'] = Variable<String>(codigo);
    }
    if (!nullToAbsent || caption != null) {
      map['caption'] = Variable<String>(caption);
    }
    if (!nullToAbsent || publicadaEn != null) {
      map['publicada_en'] = Variable<DateTime>(publicadaEn);
    }
    if (!nullToAbsent || likes != null) {
      map['likes'] = Variable<int>(likes);
    }
    if (!nullToAbsent || guardados != null) {
      map['guardados'] = Variable<int>(guardados);
    }
    if (!nullToAbsent || comentarios != null) {
      map['comentarios'] = Variable<int>(comentarios);
    }
    if (!nullToAbsent || alcance != null) {
      map['alcance'] = Variable<int>(alcance);
    }
    map['origen'] = Variable<String>(origen);
    map['creada_en'] = Variable<DateTime>(creadaEn);
    return map;
  }

  IdeasCompanion toCompanion(bool nullToAbsent) {
    return IdeasCompanion(
      id: Value(id),
      titulo: Value(titulo),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
      formato: Value(formato),
      tags: Value(tags),
      estado: Value(estado),
      hook: hook == null && nullToAbsent ? const Value.absent() : Value(hook),
      guion: guion == null && nullToAbsent
          ? const Value.absent()
          : Value(guion),
      codigo: codigo == null && nullToAbsent
          ? const Value.absent()
          : Value(codigo),
      caption: caption == null && nullToAbsent
          ? const Value.absent()
          : Value(caption),
      publicadaEn: publicadaEn == null && nullToAbsent
          ? const Value.absent()
          : Value(publicadaEn),
      likes: likes == null && nullToAbsent
          ? const Value.absent()
          : Value(likes),
      guardados: guardados == null && nullToAbsent
          ? const Value.absent()
          : Value(guardados),
      comentarios: comentarios == null && nullToAbsent
          ? const Value.absent()
          : Value(comentarios),
      alcance: alcance == null && nullToAbsent
          ? const Value.absent()
          : Value(alcance),
      origen: Value(origen),
      creadaEn: Value(creadaEn),
    );
  }

  factory Idea.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Idea(
      id: serializer.fromJson<int>(json['id']),
      titulo: serializer.fromJson<String>(json['titulo']),
      descripcion: serializer.fromJson<String?>(json['descripcion']),
      formato: serializer.fromJson<String>(json['formato']),
      tags: serializer.fromJson<String>(json['tags']),
      estado: serializer.fromJson<String>(json['estado']),
      hook: serializer.fromJson<String?>(json['hook']),
      guion: serializer.fromJson<String?>(json['guion']),
      codigo: serializer.fromJson<String?>(json['codigo']),
      caption: serializer.fromJson<String?>(json['caption']),
      publicadaEn: serializer.fromJson<DateTime?>(json['publicadaEn']),
      likes: serializer.fromJson<int?>(json['likes']),
      guardados: serializer.fromJson<int?>(json['guardados']),
      comentarios: serializer.fromJson<int?>(json['comentarios']),
      alcance: serializer.fromJson<int?>(json['alcance']),
      origen: serializer.fromJson<String>(json['origen']),
      creadaEn: serializer.fromJson<DateTime>(json['creadaEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'titulo': serializer.toJson<String>(titulo),
      'descripcion': serializer.toJson<String?>(descripcion),
      'formato': serializer.toJson<String>(formato),
      'tags': serializer.toJson<String>(tags),
      'estado': serializer.toJson<String>(estado),
      'hook': serializer.toJson<String?>(hook),
      'guion': serializer.toJson<String?>(guion),
      'codigo': serializer.toJson<String?>(codigo),
      'caption': serializer.toJson<String?>(caption),
      'publicadaEn': serializer.toJson<DateTime?>(publicadaEn),
      'likes': serializer.toJson<int?>(likes),
      'guardados': serializer.toJson<int?>(guardados),
      'comentarios': serializer.toJson<int?>(comentarios),
      'alcance': serializer.toJson<int?>(alcance),
      'origen': serializer.toJson<String>(origen),
      'creadaEn': serializer.toJson<DateTime>(creadaEn),
    };
  }

  Idea copyWith({
    int? id,
    String? titulo,
    Value<String?> descripcion = const Value.absent(),
    String? formato,
    String? tags,
    String? estado,
    Value<String?> hook = const Value.absent(),
    Value<String?> guion = const Value.absent(),
    Value<String?> codigo = const Value.absent(),
    Value<String?> caption = const Value.absent(),
    Value<DateTime?> publicadaEn = const Value.absent(),
    Value<int?> likes = const Value.absent(),
    Value<int?> guardados = const Value.absent(),
    Value<int?> comentarios = const Value.absent(),
    Value<int?> alcance = const Value.absent(),
    String? origen,
    DateTime? creadaEn,
  }) => Idea(
    id: id ?? this.id,
    titulo: titulo ?? this.titulo,
    descripcion: descripcion.present ? descripcion.value : this.descripcion,
    formato: formato ?? this.formato,
    tags: tags ?? this.tags,
    estado: estado ?? this.estado,
    hook: hook.present ? hook.value : this.hook,
    guion: guion.present ? guion.value : this.guion,
    codigo: codigo.present ? codigo.value : this.codigo,
    caption: caption.present ? caption.value : this.caption,
    publicadaEn: publicadaEn.present ? publicadaEn.value : this.publicadaEn,
    likes: likes.present ? likes.value : this.likes,
    guardados: guardados.present ? guardados.value : this.guardados,
    comentarios: comentarios.present ? comentarios.value : this.comentarios,
    alcance: alcance.present ? alcance.value : this.alcance,
    origen: origen ?? this.origen,
    creadaEn: creadaEn ?? this.creadaEn,
  );
  Idea copyWithCompanion(IdeasCompanion data) {
    return Idea(
      id: data.id.present ? data.id.value : this.id,
      titulo: data.titulo.present ? data.titulo.value : this.titulo,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      formato: data.formato.present ? data.formato.value : this.formato,
      tags: data.tags.present ? data.tags.value : this.tags,
      estado: data.estado.present ? data.estado.value : this.estado,
      hook: data.hook.present ? data.hook.value : this.hook,
      guion: data.guion.present ? data.guion.value : this.guion,
      codigo: data.codigo.present ? data.codigo.value : this.codigo,
      caption: data.caption.present ? data.caption.value : this.caption,
      publicadaEn: data.publicadaEn.present
          ? data.publicadaEn.value
          : this.publicadaEn,
      likes: data.likes.present ? data.likes.value : this.likes,
      guardados: data.guardados.present ? data.guardados.value : this.guardados,
      comentarios: data.comentarios.present
          ? data.comentarios.value
          : this.comentarios,
      alcance: data.alcance.present ? data.alcance.value : this.alcance,
      origen: data.origen.present ? data.origen.value : this.origen,
      creadaEn: data.creadaEn.present ? data.creadaEn.value : this.creadaEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Idea(')
          ..write('id: $id, ')
          ..write('titulo: $titulo, ')
          ..write('descripcion: $descripcion, ')
          ..write('formato: $formato, ')
          ..write('tags: $tags, ')
          ..write('estado: $estado, ')
          ..write('hook: $hook, ')
          ..write('guion: $guion, ')
          ..write('codigo: $codigo, ')
          ..write('caption: $caption, ')
          ..write('publicadaEn: $publicadaEn, ')
          ..write('likes: $likes, ')
          ..write('guardados: $guardados, ')
          ..write('comentarios: $comentarios, ')
          ..write('alcance: $alcance, ')
          ..write('origen: $origen, ')
          ..write('creadaEn: $creadaEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    titulo,
    descripcion,
    formato,
    tags,
    estado,
    hook,
    guion,
    codigo,
    caption,
    publicadaEn,
    likes,
    guardados,
    comentarios,
    alcance,
    origen,
    creadaEn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Idea &&
          other.id == this.id &&
          other.titulo == this.titulo &&
          other.descripcion == this.descripcion &&
          other.formato == this.formato &&
          other.tags == this.tags &&
          other.estado == this.estado &&
          other.hook == this.hook &&
          other.guion == this.guion &&
          other.codigo == this.codigo &&
          other.caption == this.caption &&
          other.publicadaEn == this.publicadaEn &&
          other.likes == this.likes &&
          other.guardados == this.guardados &&
          other.comentarios == this.comentarios &&
          other.alcance == this.alcance &&
          other.origen == this.origen &&
          other.creadaEn == this.creadaEn);
}

class IdeasCompanion extends UpdateCompanion<Idea> {
  final Value<int> id;
  final Value<String> titulo;
  final Value<String?> descripcion;
  final Value<String> formato;
  final Value<String> tags;
  final Value<String> estado;
  final Value<String?> hook;
  final Value<String?> guion;
  final Value<String?> codigo;
  final Value<String?> caption;
  final Value<DateTime?> publicadaEn;
  final Value<int?> likes;
  final Value<int?> guardados;
  final Value<int?> comentarios;
  final Value<int?> alcance;
  final Value<String> origen;
  final Value<DateTime> creadaEn;
  const IdeasCompanion({
    this.id = const Value.absent(),
    this.titulo = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.formato = const Value.absent(),
    this.tags = const Value.absent(),
    this.estado = const Value.absent(),
    this.hook = const Value.absent(),
    this.guion = const Value.absent(),
    this.codigo = const Value.absent(),
    this.caption = const Value.absent(),
    this.publicadaEn = const Value.absent(),
    this.likes = const Value.absent(),
    this.guardados = const Value.absent(),
    this.comentarios = const Value.absent(),
    this.alcance = const Value.absent(),
    this.origen = const Value.absent(),
    this.creadaEn = const Value.absent(),
  });
  IdeasCompanion.insert({
    this.id = const Value.absent(),
    required String titulo,
    this.descripcion = const Value.absent(),
    this.formato = const Value.absent(),
    this.tags = const Value.absent(),
    this.estado = const Value.absent(),
    this.hook = const Value.absent(),
    this.guion = const Value.absent(),
    this.codigo = const Value.absent(),
    this.caption = const Value.absent(),
    this.publicadaEn = const Value.absent(),
    this.likes = const Value.absent(),
    this.guardados = const Value.absent(),
    this.comentarios = const Value.absent(),
    this.alcance = const Value.absent(),
    this.origen = const Value.absent(),
    this.creadaEn = const Value.absent(),
  }) : titulo = Value(titulo);
  static Insertable<Idea> custom({
    Expression<int>? id,
    Expression<String>? titulo,
    Expression<String>? descripcion,
    Expression<String>? formato,
    Expression<String>? tags,
    Expression<String>? estado,
    Expression<String>? hook,
    Expression<String>? guion,
    Expression<String>? codigo,
    Expression<String>? caption,
    Expression<DateTime>? publicadaEn,
    Expression<int>? likes,
    Expression<int>? guardados,
    Expression<int>? comentarios,
    Expression<int>? alcance,
    Expression<String>? origen,
    Expression<DateTime>? creadaEn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (titulo != null) 'titulo': titulo,
      if (descripcion != null) 'descripcion': descripcion,
      if (formato != null) 'formato': formato,
      if (tags != null) 'tags': tags,
      if (estado != null) 'estado': estado,
      if (hook != null) 'hook': hook,
      if (guion != null) 'guion': guion,
      if (codigo != null) 'codigo': codigo,
      if (caption != null) 'caption': caption,
      if (publicadaEn != null) 'publicada_en': publicadaEn,
      if (likes != null) 'likes': likes,
      if (guardados != null) 'guardados': guardados,
      if (comentarios != null) 'comentarios': comentarios,
      if (alcance != null) 'alcance': alcance,
      if (origen != null) 'origen': origen,
      if (creadaEn != null) 'creada_en': creadaEn,
    });
  }

  IdeasCompanion copyWith({
    Value<int>? id,
    Value<String>? titulo,
    Value<String?>? descripcion,
    Value<String>? formato,
    Value<String>? tags,
    Value<String>? estado,
    Value<String?>? hook,
    Value<String?>? guion,
    Value<String?>? codigo,
    Value<String?>? caption,
    Value<DateTime?>? publicadaEn,
    Value<int?>? likes,
    Value<int?>? guardados,
    Value<int?>? comentarios,
    Value<int?>? alcance,
    Value<String>? origen,
    Value<DateTime>? creadaEn,
  }) {
    return IdeasCompanion(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descripcion: descripcion ?? this.descripcion,
      formato: formato ?? this.formato,
      tags: tags ?? this.tags,
      estado: estado ?? this.estado,
      hook: hook ?? this.hook,
      guion: guion ?? this.guion,
      codigo: codigo ?? this.codigo,
      caption: caption ?? this.caption,
      publicadaEn: publicadaEn ?? this.publicadaEn,
      likes: likes ?? this.likes,
      guardados: guardados ?? this.guardados,
      comentarios: comentarios ?? this.comentarios,
      alcance: alcance ?? this.alcance,
      origen: origen ?? this.origen,
      creadaEn: creadaEn ?? this.creadaEn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (titulo.present) {
      map['titulo'] = Variable<String>(titulo.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (formato.present) {
      map['formato'] = Variable<String>(formato.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (hook.present) {
      map['hook'] = Variable<String>(hook.value);
    }
    if (guion.present) {
      map['guion'] = Variable<String>(guion.value);
    }
    if (codigo.present) {
      map['codigo'] = Variable<String>(codigo.value);
    }
    if (caption.present) {
      map['caption'] = Variable<String>(caption.value);
    }
    if (publicadaEn.present) {
      map['publicada_en'] = Variable<DateTime>(publicadaEn.value);
    }
    if (likes.present) {
      map['likes'] = Variable<int>(likes.value);
    }
    if (guardados.present) {
      map['guardados'] = Variable<int>(guardados.value);
    }
    if (comentarios.present) {
      map['comentarios'] = Variable<int>(comentarios.value);
    }
    if (alcance.present) {
      map['alcance'] = Variable<int>(alcance.value);
    }
    if (origen.present) {
      map['origen'] = Variable<String>(origen.value);
    }
    if (creadaEn.present) {
      map['creada_en'] = Variable<DateTime>(creadaEn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IdeasCompanion(')
          ..write('id: $id, ')
          ..write('titulo: $titulo, ')
          ..write('descripcion: $descripcion, ')
          ..write('formato: $formato, ')
          ..write('tags: $tags, ')
          ..write('estado: $estado, ')
          ..write('hook: $hook, ')
          ..write('guion: $guion, ')
          ..write('codigo: $codigo, ')
          ..write('caption: $caption, ')
          ..write('publicadaEn: $publicadaEn, ')
          ..write('likes: $likes, ')
          ..write('guardados: $guardados, ')
          ..write('comentarios: $comentarios, ')
          ..write('alcance: $alcance, ')
          ..write('origen: $origen, ')
          ..write('creadaEn: $creadaEn')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ListasTable listas = $ListasTable(this);
  late final $ProductosTable productos = $ProductosTable(this);
  late final $TareasTable tareas = $TareasTable(this);
  late final $CuentasTable cuentas = $CuentasTable(this);
  late final $CategoriasTable categorias = $CategoriasTable(this);
  late final $TarjetasTable tarjetas = $TarjetasTable(this);
  late final $GastosFijosTable gastosFijos = $GastosFijosTable(this);
  late final $MovimientosTable movimientos = $MovimientosTable(this);
  late final $MetasTable metas = $MetasTable(this);
  late final $DeudasTable deudas = $DeudasTable(this);
  late final $EjerciciosTable ejercicios = $EjerciciosTable(this);
  late final $SesionesTable sesiones = $SesionesTable(this);
  late final $SeriesTable series = $SeriesTable(this);
  late final $MovimientosCocinaTable movimientosCocina =
      $MovimientosCocinaTable(this);
  late final $IdeasTable ideas = $IdeasTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    listas,
    productos,
    tareas,
    cuentas,
    categorias,
    tarjetas,
    gastosFijos,
    movimientos,
    metas,
    deudas,
    ejercicios,
    sesiones,
    series,
    movimientosCocina,
    ideas,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tar_listas',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tar_tareas', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'coc_productos',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tar_tareas', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'fin_categorias',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('fin_gastos_fijos', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'fin_cuentas',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('fin_gastos_fijos', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'fin_categorias',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('fin_movimientos', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'fin_cuentas',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('fin_movimientos', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'fin_cuentas',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('fin_movimientos', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'fin_tarjetas',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('fin_movimientos', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'fin_gastos_fijos',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('fin_movimientos', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'ent_sesiones',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('ent_series', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'ent_ejercicios',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('ent_series', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'coc_productos',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('coc_movimientos', kind: UpdateKind.delete)],
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
typedef $$ProductosTableCreateCompanionBuilder = ProductosCompanion Function({
  Value<int> id,
  required String nombre,
  Value<String> unidad,
  Value<String> ubicacion,
  Value<double> cantidad,
  Value<double> stockMinimo,
  Value<double> compraHabitual,
  Value<DateTime?> vence,
});
typedef $$ProductosTableUpdateCompanionBuilder = ProductosCompanion Function({
  Value<int> id,
  Value<String> nombre,
  Value<String> unidad,
  Value<String> ubicacion,
  Value<double> cantidad,
  Value<double> stockMinimo,
  Value<double> compraHabitual,
  Value<DateTime?> vence,
});

final class $$ProductosTableReferences
    extends BaseReferences<_$AppDatabase, $ProductosTable, Producto> {
  $$ProductosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TareasTable, List<Tarea>> _tareasRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.tareas,
    aliasName: 'coc_productos__id__tar_tareas__producto_id',
  );

  $$TareasTableProcessedTableManager get tareasRefs {
    final manager = $$TareasTableTableManager(
      $_db,
      $_db.tareas,
    ).filter((f) => f.productoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_tareasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MovimientosCocinaTable, List<MovCocina>>
  _movimientosCocinaRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.movimientosCocina,
        aliasName: 'coc_productos__id__coc_movimientos__producto_id',
      );

  $$MovimientosCocinaTableProcessedTableManager get movimientosCocinaRefs {
    final manager = $$MovimientosCocinaTableTableManager(
      $_db,
      $_db.movimientosCocina,
    ).filter((f) => f.productoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _movimientosCocinaRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductosTableFilterComposer
    extends Composer<_$AppDatabase, $ProductosTable> {
  $$ProductosTableFilterComposer({
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

  ColumnFilters<String> get unidad => $composableBuilder(
    column: $table.unidad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ubicacion => $composableBuilder(
    column: $table.ubicacion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get stockMinimo => $composableBuilder(
    column: $table.stockMinimo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get compraHabitual => $composableBuilder(
    column: $table.compraHabitual,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get vence => $composableBuilder(
    column: $table.vence,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> tareasRefs(
    Expression<bool> Function($$TareasTableFilterComposer f) f,
  ) {
    final $$TareasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tareas,
      getReferencedColumn: (t) => t.productoId,
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

  Expression<bool> movimientosCocinaRefs(
    Expression<bool> Function($$MovimientosCocinaTableFilterComposer f) f,
  ) {
    final $$MovimientosCocinaTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movimientosCocina,
      getReferencedColumn: (t) => t.productoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovimientosCocinaTableFilterComposer(
            $db: $db,
            $table: $db.movimientosCocina,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductosTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductosTable> {
  $$ProductosTableOrderingComposer({
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

  ColumnOrderings<String> get unidad => $composableBuilder(
    column: $table.unidad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ubicacion => $composableBuilder(
    column: $table.ubicacion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get stockMinimo => $composableBuilder(
    column: $table.stockMinimo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get compraHabitual => $composableBuilder(
    column: $table.compraHabitual,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get vence => $composableBuilder(
    column: $table.vence,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductosTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductosTable> {
  $$ProductosTableAnnotationComposer({
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

  GeneratedColumn<String> get unidad =>
      $composableBuilder(column: $table.unidad, builder: (column) => column);

  GeneratedColumn<String> get ubicacion =>
      $composableBuilder(column: $table.ubicacion, builder: (column) => column);

  GeneratedColumn<double> get cantidad =>
      $composableBuilder(column: $table.cantidad, builder: (column) => column);

  GeneratedColumn<double> get stockMinimo => $composableBuilder(
    column: $table.stockMinimo,
    builder: (column) => column,
  );

  GeneratedColumn<double> get compraHabitual => $composableBuilder(
    column: $table.compraHabitual,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get vence =>
      $composableBuilder(column: $table.vence, builder: (column) => column);

  Expression<T> tareasRefs<T extends Object>(
    Expression<T> Function($$TareasTableAnnotationComposer a) f,
  ) {
    final $$TareasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tareas,
      getReferencedColumn: (t) => t.productoId,
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

  Expression<T> movimientosCocinaRefs<T extends Object>(
    Expression<T> Function($$MovimientosCocinaTableAnnotationComposer a) f,
  ) {
    final $$MovimientosCocinaTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.movimientosCocina,
          getReferencedColumn: (t) => t.productoId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MovimientosCocinaTableAnnotationComposer(
                $db: $db,
                $table: $db.movimientosCocina,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ProductosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductosTable,
          Producto,
          $$ProductosTableFilterComposer,
          $$ProductosTableOrderingComposer,
          $$ProductosTableAnnotationComposer,
          $$ProductosTableCreateCompanionBuilder,
          $$ProductosTableUpdateCompanionBuilder,
          (Producto, $$ProductosTableReferences),
          Producto,
          PrefetchHooks Function({bool tareasRefs, bool movimientosCocinaRefs})
        > {
  $$ProductosTableTableManager(_$AppDatabase db, $ProductosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> unidad = const Value.absent(),
                Value<String> ubicacion = const Value.absent(),
                Value<double> cantidad = const Value.absent(),
                Value<double> stockMinimo = const Value.absent(),
                Value<double> compraHabitual = const Value.absent(),
                Value<DateTime?> vence = const Value.absent(),
              }) => ProductosCompanion(
                id: id,
                nombre: nombre,
                unidad: unidad,
                ubicacion: ubicacion,
                cantidad: cantidad,
                stockMinimo: stockMinimo,
                compraHabitual: compraHabitual,
                vence: vence,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                Value<String> unidad = const Value.absent(),
                Value<String> ubicacion = const Value.absent(),
                Value<double> cantidad = const Value.absent(),
                Value<double> stockMinimo = const Value.absent(),
                Value<double> compraHabitual = const Value.absent(),
                Value<DateTime?> vence = const Value.absent(),
              }) => ProductosCompanion.insert(
                id: id,
                nombre: nombre,
                unidad: unidad,
                ubicacion: ubicacion,
                cantidad: cantidad,
                stockMinimo: stockMinimo,
                compraHabitual: compraHabitual,
                vence: vence,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProductosTable, Producto>(table),
                  $$ProductosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({tareasRefs = false, movimientosCocinaRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (tareasRefs) db.tareas,
                    if (movimientosCocinaRefs) db.movimientosCocina,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (tareasRefs)
                        await $_getPrefetchedData<
                          Producto,
                          $ProductosTable,
                          Tarea
                        >(
                          currentTable: table,
                          referencedTable: $$ProductosTableReferences
                              ._tareasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductosTableReferences(
                                db,
                                table,
                                p0,
                              ).tareasRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productoId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (movimientosCocinaRefs)
                        await $_getPrefetchedData<
                          Producto,
                          $ProductosTable,
                          MovCocina
                        >(
                          currentTable: table,
                          referencedTable: $$ProductosTableReferences
                              ._movimientosCocinaRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductosTableReferences(
                                db,
                                table,
                                p0,
                              ).movimientosCocinaRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productoId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProductosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductosTable,
      Producto,
      $$ProductosTableFilterComposer,
      $$ProductosTableOrderingComposer,
      $$ProductosTableAnnotationComposer,
      $$ProductosTableCreateCompanionBuilder,
      $$ProductosTableUpdateCompanionBuilder,
      (Producto, $$ProductosTableReferences),
      Producto,
      PrefetchHooks Function({bool tareasRefs, bool movimientosCocinaRefs})
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
  Value<int?> productoId,
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
  Value<int?> productoId,
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

  static $ProductosTable _productoIdTable(_$AppDatabase db) =>
      db.productos.createAlias('tar_tareas__producto_id__coc_productos__id');

  $$ProductosTableProcessedTableManager? get productoId {
    final $_column = $_itemColumn<int>('producto_id');
    if ($_column == null) return null;
    final manager = $$ProductosTableTableManager(
      $_db,
      $_db.productos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productoIdTable($_db));
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

  $$ProductosTableFilterComposer get productoId {
    final $$ProductosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productoId,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableFilterComposer(
            $db: $db,
            $table: $db.productos,
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

  $$ProductosTableOrderingComposer get productoId {
    final $$ProductosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productoId,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableOrderingComposer(
            $db: $db,
            $table: $db.productos,
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

  $$ProductosTableAnnotationComposer get productoId {
    final $$ProductosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productoId,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableAnnotationComposer(
            $db: $db,
            $table: $db.productos,
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
          PrefetchHooks Function({bool listaId, bool productoId})
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
                Value<int?> productoId = const Value.absent(),
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
                productoId: productoId,
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
                Value<int?> productoId = const Value.absent(),
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
                productoId: productoId,
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
          prefetchHooksCallback: ({listaId = false, productoId = false}) {
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
                    if (productoId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.productoId,
                        referencedTable: $$TareasTableReferences
                            ._productoIdTable(db),
                        referencedColumn: $$TareasTableReferences
                            ._productoIdTable(db)
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
      PrefetchHooks Function({bool listaId, bool productoId})
    >;
typedef $$CuentasTableCreateCompanionBuilder = CuentasCompanion Function({
  Value<int> id,
  required String nombre,
  Value<String?> banco,
  Value<String> tipo,
  Value<int> saldoInicial,
  Value<bool> archivada,
});
typedef $$CuentasTableUpdateCompanionBuilder = CuentasCompanion Function({
  Value<int> id,
  Value<String> nombre,
  Value<String?> banco,
  Value<String> tipo,
  Value<int> saldoInicial,
  Value<bool> archivada,
});

final class $$CuentasTableReferences
    extends BaseReferences<_$AppDatabase, $CuentasTable, Cuenta> {
  $$CuentasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$GastosFijosTable, List<GastoFijo>>
  _gastosFijosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.gastosFijos,
    aliasName: 'fin_cuentas__id__fin_gastos_fijos__cuenta_id',
  );

  $$GastosFijosTableProcessedTableManager get gastosFijosRefs {
    final manager = $$GastosFijosTableTableManager(
      $_db,
      $_db.gastosFijos,
    ).filter((f) => f.cuentaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_gastosFijosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CuentasTableFilterComposer
    extends Composer<_$AppDatabase, $CuentasTable> {
  $$CuentasTableFilterComposer({
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

  ColumnFilters<String> get banco => $composableBuilder(
    column: $table.banco,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get saldoInicial => $composableBuilder(
    column: $table.saldoInicial,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get archivada => $composableBuilder(
    column: $table.archivada,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> gastosFijosRefs(
    Expression<bool> Function($$GastosFijosTableFilterComposer f) f,
  ) {
    final $$GastosFijosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gastosFijos,
      getReferencedColumn: (t) => t.cuentaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GastosFijosTableFilterComposer(
            $db: $db,
            $table: $db.gastosFijos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CuentasTableOrderingComposer
    extends Composer<_$AppDatabase, $CuentasTable> {
  $$CuentasTableOrderingComposer({
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

  ColumnOrderings<String> get banco => $composableBuilder(
    column: $table.banco,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get saldoInicial => $composableBuilder(
    column: $table.saldoInicial,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get archivada => $composableBuilder(
    column: $table.archivada,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CuentasTableAnnotationComposer
    extends Composer<_$AppDatabase, $CuentasTable> {
  $$CuentasTableAnnotationComposer({
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

  GeneratedColumn<String> get banco =>
      $composableBuilder(column: $table.banco, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<int> get saldoInicial => $composableBuilder(
    column: $table.saldoInicial,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get archivada =>
      $composableBuilder(column: $table.archivada, builder: (column) => column);

  Expression<T> gastosFijosRefs<T extends Object>(
    Expression<T> Function($$GastosFijosTableAnnotationComposer a) f,
  ) {
    final $$GastosFijosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gastosFijos,
      getReferencedColumn: (t) => t.cuentaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GastosFijosTableAnnotationComposer(
            $db: $db,
            $table: $db.gastosFijos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CuentasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CuentasTable,
          Cuenta,
          $$CuentasTableFilterComposer,
          $$CuentasTableOrderingComposer,
          $$CuentasTableAnnotationComposer,
          $$CuentasTableCreateCompanionBuilder,
          $$CuentasTableUpdateCompanionBuilder,
          (Cuenta, $$CuentasTableReferences),
          Cuenta,
          PrefetchHooks Function({bool gastosFijosRefs})
        > {
  $$CuentasTableTableManager(_$AppDatabase db, $CuentasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CuentasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CuentasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CuentasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String?> banco = const Value.absent(),
                Value<String> tipo = const Value.absent(),
                Value<int> saldoInicial = const Value.absent(),
                Value<bool> archivada = const Value.absent(),
              }) => CuentasCompanion(
                id: id,
                nombre: nombre,
                banco: banco,
                tipo: tipo,
                saldoInicial: saldoInicial,
                archivada: archivada,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                Value<String?> banco = const Value.absent(),
                Value<String> tipo = const Value.absent(),
                Value<int> saldoInicial = const Value.absent(),
                Value<bool> archivada = const Value.absent(),
              }) => CuentasCompanion.insert(
                id: id,
                nombre: nombre,
                banco: banco,
                tipo: tipo,
                saldoInicial: saldoInicial,
                archivada: archivada,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CuentasTable, Cuenta>(table),
                  $$CuentasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({gastosFijosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (gastosFijosRefs) db.gastosFijos],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (gastosFijosRefs)
                    await $_getPrefetchedData<Cuenta, $CuentasTable, GastoFijo>(
                      currentTable: table,
                      referencedTable: $$CuentasTableReferences
                          ._gastosFijosRefsTable(db),
                      managerFromTypedResult: (p0) => $$CuentasTableReferences(
                        db,
                        table,
                        p0,
                      ).gastosFijosRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.cuentaId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CuentasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CuentasTable,
      Cuenta,
      $$CuentasTableFilterComposer,
      $$CuentasTableOrderingComposer,
      $$CuentasTableAnnotationComposer,
      $$CuentasTableCreateCompanionBuilder,
      $$CuentasTableUpdateCompanionBuilder,
      (Cuenta, $$CuentasTableReferences),
      Cuenta,
      PrefetchHooks Function({bool gastosFijosRefs})
    >;
typedef $$CategoriasTableCreateCompanionBuilder = CategoriasCompanion Function({
  Value<int> id,
  required String nombre,
  required String tipo,
  Value<String> icono,
  Value<int> color,
  Value<int> presupuesto,
});
typedef $$CategoriasTableUpdateCompanionBuilder = CategoriasCompanion Function({
  Value<int> id,
  Value<String> nombre,
  Value<String> tipo,
  Value<String> icono,
  Value<int> color,
  Value<int> presupuesto,
});

final class $$CategoriasTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriasTable, Categoria> {
  $$CategoriasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$GastosFijosTable, List<GastoFijo>>
  _gastosFijosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.gastosFijos,
    aliasName: 'fin_categorias__id__fin_gastos_fijos__categoria_id',
  );

  $$GastosFijosTableProcessedTableManager get gastosFijosRefs {
    final manager = $$GastosFijosTableTableManager(
      $_db,
      $_db.gastosFijos,
    ).filter((f) => f.categoriaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_gastosFijosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MovimientosTable, List<Movimiento>>
  _movimientosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.movimientos,
    aliasName: 'fin_categorias__id__fin_movimientos__categoria_id',
  );

  $$MovimientosTableProcessedTableManager get movimientosRefs {
    final manager = $$MovimientosTableTableManager(
      $_db,
      $_db.movimientos,
    ).filter((f) => f.categoriaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_movimientosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriasTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriasTable> {
  $$CategoriasTableFilterComposer({
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

  ColumnFilters<int> get presupuesto => $composableBuilder(
    column: $table.presupuesto,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> gastosFijosRefs(
    Expression<bool> Function($$GastosFijosTableFilterComposer f) f,
  ) {
    final $$GastosFijosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gastosFijos,
      getReferencedColumn: (t) => t.categoriaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GastosFijosTableFilterComposer(
            $db: $db,
            $table: $db.gastosFijos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> movimientosRefs(
    Expression<bool> Function($$MovimientosTableFilterComposer f) f,
  ) {
    final $$MovimientosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movimientos,
      getReferencedColumn: (t) => t.categoriaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovimientosTableFilterComposer(
            $db: $db,
            $table: $db.movimientos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriasTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriasTable> {
  $$CategoriasTableOrderingComposer({
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

  ColumnOrderings<int> get presupuesto => $composableBuilder(
    column: $table.presupuesto,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriasTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriasTable> {
  $$CategoriasTableAnnotationComposer({
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

  GeneratedColumn<int> get presupuesto => $composableBuilder(
    column: $table.presupuesto,
    builder: (column) => column,
  );

  Expression<T> gastosFijosRefs<T extends Object>(
    Expression<T> Function($$GastosFijosTableAnnotationComposer a) f,
  ) {
    final $$GastosFijosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gastosFijos,
      getReferencedColumn: (t) => t.categoriaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GastosFijosTableAnnotationComposer(
            $db: $db,
            $table: $db.gastosFijos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> movimientosRefs<T extends Object>(
    Expression<T> Function($$MovimientosTableAnnotationComposer a) f,
  ) {
    final $$MovimientosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movimientos,
      getReferencedColumn: (t) => t.categoriaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovimientosTableAnnotationComposer(
            $db: $db,
            $table: $db.movimientos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriasTable,
          Categoria,
          $$CategoriasTableFilterComposer,
          $$CategoriasTableOrderingComposer,
          $$CategoriasTableAnnotationComposer,
          $$CategoriasTableCreateCompanionBuilder,
          $$CategoriasTableUpdateCompanionBuilder,
          (Categoria, $$CategoriasTableReferences),
          Categoria,
          PrefetchHooks Function({bool gastosFijosRefs, bool movimientosRefs})
        > {
  $$CategoriasTableTableManager(_$AppDatabase db, $CategoriasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> tipo = const Value.absent(),
                Value<String> icono = const Value.absent(),
                Value<int> color = const Value.absent(),
                Value<int> presupuesto = const Value.absent(),
              }) => CategoriasCompanion(
                id: id,
                nombre: nombre,
                tipo: tipo,
                icono: icono,
                color: color,
                presupuesto: presupuesto,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                required String tipo,
                Value<String> icono = const Value.absent(),
                Value<int> color = const Value.absent(),
                Value<int> presupuesto = const Value.absent(),
              }) => CategoriasCompanion.insert(
                id: id,
                nombre: nombre,
                tipo: tipo,
                icono: icono,
                color: color,
                presupuesto: presupuesto,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CategoriasTable, Categoria>(table),
                  $$CategoriasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({gastosFijosRefs = false, movimientosRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (gastosFijosRefs) db.gastosFijos,
                    if (movimientosRefs) db.movimientos,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (gastosFijosRefs)
                        await $_getPrefetchedData<
                          Categoria,
                          $CategoriasTable,
                          GastoFijo
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriasTableReferences
                              ._gastosFijosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriasTableReferences(
                                db,
                                table,
                                p0,
                              ).gastosFijosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoriaId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (movimientosRefs)
                        await $_getPrefetchedData<
                          Categoria,
                          $CategoriasTable,
                          Movimiento
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriasTableReferences
                              ._movimientosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriasTableReferences(
                                db,
                                table,
                                p0,
                              ).movimientosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoriaId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CategoriasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriasTable,
      Categoria,
      $$CategoriasTableFilterComposer,
      $$CategoriasTableOrderingComposer,
      $$CategoriasTableAnnotationComposer,
      $$CategoriasTableCreateCompanionBuilder,
      $$CategoriasTableUpdateCompanionBuilder,
      (Categoria, $$CategoriasTableReferences),
      Categoria,
      PrefetchHooks Function({bool gastosFijosRefs, bool movimientosRefs})
    >;
typedef $$TarjetasTableCreateCompanionBuilder = TarjetasCompanion Function({
  Value<int> id,
  required String nombre,
  Value<String?> banco,
  Value<int> cupo,
  Value<int> deudaInicial,
  Value<int?> diaCorte,
  Value<int?> diaPago,
  Value<double?> tasaEa,
  Value<bool> archivada,
});
typedef $$TarjetasTableUpdateCompanionBuilder = TarjetasCompanion Function({
  Value<int> id,
  Value<String> nombre,
  Value<String?> banco,
  Value<int> cupo,
  Value<int> deudaInicial,
  Value<int?> diaCorte,
  Value<int?> diaPago,
  Value<double?> tasaEa,
  Value<bool> archivada,
});

final class $$TarjetasTableReferences
    extends BaseReferences<_$AppDatabase, $TarjetasTable, Tarjeta> {
  $$TarjetasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MovimientosTable, List<Movimiento>>
  _movimientosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.movimientos,
    aliasName: 'fin_tarjetas__id__fin_movimientos__tarjeta_id',
  );

  $$MovimientosTableProcessedTableManager get movimientosRefs {
    final manager = $$MovimientosTableTableManager(
      $_db,
      $_db.movimientos,
    ).filter((f) => f.tarjetaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_movimientosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TarjetasTableFilterComposer
    extends Composer<_$AppDatabase, $TarjetasTable> {
  $$TarjetasTableFilterComposer({
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

  ColumnFilters<String> get banco => $composableBuilder(
    column: $table.banco,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cupo => $composableBuilder(
    column: $table.cupo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deudaInicial => $composableBuilder(
    column: $table.deudaInicial,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get diaCorte => $composableBuilder(
    column: $table.diaCorte,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get diaPago => $composableBuilder(
    column: $table.diaPago,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tasaEa => $composableBuilder(
    column: $table.tasaEa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get archivada => $composableBuilder(
    column: $table.archivada,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> movimientosRefs(
    Expression<bool> Function($$MovimientosTableFilterComposer f) f,
  ) {
    final $$MovimientosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movimientos,
      getReferencedColumn: (t) => t.tarjetaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovimientosTableFilterComposer(
            $db: $db,
            $table: $db.movimientos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TarjetasTableOrderingComposer
    extends Composer<_$AppDatabase, $TarjetasTable> {
  $$TarjetasTableOrderingComposer({
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

  ColumnOrderings<String> get banco => $composableBuilder(
    column: $table.banco,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cupo => $composableBuilder(
    column: $table.cupo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deudaInicial => $composableBuilder(
    column: $table.deudaInicial,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get diaCorte => $composableBuilder(
    column: $table.diaCorte,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get diaPago => $composableBuilder(
    column: $table.diaPago,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tasaEa => $composableBuilder(
    column: $table.tasaEa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get archivada => $composableBuilder(
    column: $table.archivada,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TarjetasTableAnnotationComposer
    extends Composer<_$AppDatabase, $TarjetasTable> {
  $$TarjetasTableAnnotationComposer({
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

  GeneratedColumn<String> get banco =>
      $composableBuilder(column: $table.banco, builder: (column) => column);

  GeneratedColumn<int> get cupo =>
      $composableBuilder(column: $table.cupo, builder: (column) => column);

  GeneratedColumn<int> get deudaInicial => $composableBuilder(
    column: $table.deudaInicial,
    builder: (column) => column,
  );

  GeneratedColumn<int> get diaCorte =>
      $composableBuilder(column: $table.diaCorte, builder: (column) => column);

  GeneratedColumn<int> get diaPago =>
      $composableBuilder(column: $table.diaPago, builder: (column) => column);

  GeneratedColumn<double> get tasaEa =>
      $composableBuilder(column: $table.tasaEa, builder: (column) => column);

  GeneratedColumn<bool> get archivada =>
      $composableBuilder(column: $table.archivada, builder: (column) => column);

  Expression<T> movimientosRefs<T extends Object>(
    Expression<T> Function($$MovimientosTableAnnotationComposer a) f,
  ) {
    final $$MovimientosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movimientos,
      getReferencedColumn: (t) => t.tarjetaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovimientosTableAnnotationComposer(
            $db: $db,
            $table: $db.movimientos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TarjetasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TarjetasTable,
          Tarjeta,
          $$TarjetasTableFilterComposer,
          $$TarjetasTableOrderingComposer,
          $$TarjetasTableAnnotationComposer,
          $$TarjetasTableCreateCompanionBuilder,
          $$TarjetasTableUpdateCompanionBuilder,
          (Tarjeta, $$TarjetasTableReferences),
          Tarjeta,
          PrefetchHooks Function({bool movimientosRefs})
        > {
  $$TarjetasTableTableManager(_$AppDatabase db, $TarjetasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TarjetasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TarjetasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TarjetasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String?> banco = const Value.absent(),
                Value<int> cupo = const Value.absent(),
                Value<int> deudaInicial = const Value.absent(),
                Value<int?> diaCorte = const Value.absent(),
                Value<int?> diaPago = const Value.absent(),
                Value<double?> tasaEa = const Value.absent(),
                Value<bool> archivada = const Value.absent(),
              }) => TarjetasCompanion(
                id: id,
                nombre: nombre,
                banco: banco,
                cupo: cupo,
                deudaInicial: deudaInicial,
                diaCorte: diaCorte,
                diaPago: diaPago,
                tasaEa: tasaEa,
                archivada: archivada,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                Value<String?> banco = const Value.absent(),
                Value<int> cupo = const Value.absent(),
                Value<int> deudaInicial = const Value.absent(),
                Value<int?> diaCorte = const Value.absent(),
                Value<int?> diaPago = const Value.absent(),
                Value<double?> tasaEa = const Value.absent(),
                Value<bool> archivada = const Value.absent(),
              }) => TarjetasCompanion.insert(
                id: id,
                nombre: nombre,
                banco: banco,
                cupo: cupo,
                deudaInicial: deudaInicial,
                diaCorte: diaCorte,
                diaPago: diaPago,
                tasaEa: tasaEa,
                archivada: archivada,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TarjetasTable, Tarjeta>(table),
                  $$TarjetasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({movimientosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (movimientosRefs) db.movimientos],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (movimientosRefs)
                    await $_getPrefetchedData<
                      Tarjeta,
                      $TarjetasTable,
                      Movimiento
                    >(
                      currentTable: table,
                      referencedTable: $$TarjetasTableReferences
                          ._movimientosRefsTable(db),
                      managerFromTypedResult: (p0) => $$TarjetasTableReferences(
                        db,
                        table,
                        p0,
                      ).movimientosRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.tarjetaId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TarjetasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TarjetasTable,
      Tarjeta,
      $$TarjetasTableFilterComposer,
      $$TarjetasTableOrderingComposer,
      $$TarjetasTableAnnotationComposer,
      $$TarjetasTableCreateCompanionBuilder,
      $$TarjetasTableUpdateCompanionBuilder,
      (Tarjeta, $$TarjetasTableReferences),
      Tarjeta,
      PrefetchHooks Function({bool movimientosRefs})
    >;
typedef $$GastosFijosTableCreateCompanionBuilder =
    GastosFijosCompanion Function({
      Value<int> id,
      required String descripcion,
      required int monto,
      required int dia,
      Value<int?> categoriaId,
      Value<int?> cuentaId,
      Value<bool> recordar,
      Value<bool> activo,
    });
typedef $$GastosFijosTableUpdateCompanionBuilder =
    GastosFijosCompanion Function({
      Value<int> id,
      Value<String> descripcion,
      Value<int> monto,
      Value<int> dia,
      Value<int?> categoriaId,
      Value<int?> cuentaId,
      Value<bool> recordar,
      Value<bool> activo,
    });

final class $$GastosFijosTableReferences
    extends BaseReferences<_$AppDatabase, $GastosFijosTable, GastoFijo> {
  $$GastosFijosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriasTable _categoriaIdTable(_$AppDatabase db) => db.categorias
      .createAlias('fin_gastos_fijos__categoria_id__fin_categorias__id');

  $$CategoriasTableProcessedTableManager? get categoriaId {
    final $_column = $_itemColumn<int>('categoria_id');
    if ($_column == null) return null;
    final manager = $$CategoriasTableTableManager(
      $_db,
      $_db.categorias,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoriaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CuentasTable _cuentaIdTable(_$AppDatabase db) =>
      db.cuentas.createAlias('fin_gastos_fijos__cuenta_id__fin_cuentas__id');

  $$CuentasTableProcessedTableManager? get cuentaId {
    final $_column = $_itemColumn<int>('cuenta_id');
    if ($_column == null) return null;
    final manager = $$CuentasTableTableManager(
      $_db,
      $_db.cuentas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cuentaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$MovimientosTable, List<Movimiento>>
  _movimientosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.movimientos,
    aliasName: 'fin_gastos_fijos__id__fin_movimientos__fijo_id',
  );

  $$MovimientosTableProcessedTableManager get movimientosRefs {
    final manager = $$MovimientosTableTableManager(
      $_db,
      $_db.movimientos,
    ).filter((f) => f.fijoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_movimientosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GastosFijosTableFilterComposer
    extends Composer<_$AppDatabase, $GastosFijosTable> {
  $$GastosFijosTableFilterComposer({
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

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get monto => $composableBuilder(
    column: $table.monto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dia => $composableBuilder(
    column: $table.dia,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get recordar => $composableBuilder(
    column: $table.recordar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoriasTableFilterComposer get categoriaId {
    final $$CategoriasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoriaId,
      referencedTable: $db.categorias,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriasTableFilterComposer(
            $db: $db,
            $table: $db.categorias,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CuentasTableFilterComposer get cuentaId {
    final $$CuentasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cuentaId,
      referencedTable: $db.cuentas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CuentasTableFilterComposer(
            $db: $db,
            $table: $db.cuentas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> movimientosRefs(
    Expression<bool> Function($$MovimientosTableFilterComposer f) f,
  ) {
    final $$MovimientosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movimientos,
      getReferencedColumn: (t) => t.fijoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovimientosTableFilterComposer(
            $db: $db,
            $table: $db.movimientos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GastosFijosTableOrderingComposer
    extends Composer<_$AppDatabase, $GastosFijosTable> {
  $$GastosFijosTableOrderingComposer({
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

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get monto => $composableBuilder(
    column: $table.monto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dia => $composableBuilder(
    column: $table.dia,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get recordar => $composableBuilder(
    column: $table.recordar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriasTableOrderingComposer get categoriaId {
    final $$CategoriasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoriaId,
      referencedTable: $db.categorias,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriasTableOrderingComposer(
            $db: $db,
            $table: $db.categorias,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CuentasTableOrderingComposer get cuentaId {
    final $$CuentasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cuentaId,
      referencedTable: $db.cuentas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CuentasTableOrderingComposer(
            $db: $db,
            $table: $db.cuentas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GastosFijosTableAnnotationComposer
    extends Composer<_$AppDatabase, $GastosFijosTable> {
  $$GastosFijosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get monto =>
      $composableBuilder(column: $table.monto, builder: (column) => column);

  GeneratedColumn<int> get dia =>
      $composableBuilder(column: $table.dia, builder: (column) => column);

  GeneratedColumn<bool> get recordar =>
      $composableBuilder(column: $table.recordar, builder: (column) => column);

  GeneratedColumn<bool> get activo =>
      $composableBuilder(column: $table.activo, builder: (column) => column);

  $$CategoriasTableAnnotationComposer get categoriaId {
    final $$CategoriasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoriaId,
      referencedTable: $db.categorias,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriasTableAnnotationComposer(
            $db: $db,
            $table: $db.categorias,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CuentasTableAnnotationComposer get cuentaId {
    final $$CuentasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cuentaId,
      referencedTable: $db.cuentas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CuentasTableAnnotationComposer(
            $db: $db,
            $table: $db.cuentas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> movimientosRefs<T extends Object>(
    Expression<T> Function($$MovimientosTableAnnotationComposer a) f,
  ) {
    final $$MovimientosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movimientos,
      getReferencedColumn: (t) => t.fijoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovimientosTableAnnotationComposer(
            $db: $db,
            $table: $db.movimientos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GastosFijosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GastosFijosTable,
          GastoFijo,
          $$GastosFijosTableFilterComposer,
          $$GastosFijosTableOrderingComposer,
          $$GastosFijosTableAnnotationComposer,
          $$GastosFijosTableCreateCompanionBuilder,
          $$GastosFijosTableUpdateCompanionBuilder,
          (GastoFijo, $$GastosFijosTableReferences),
          GastoFijo,
          PrefetchHooks Function({
            bool categoriaId,
            bool cuentaId,
            bool movimientosRefs,
          })
        > {
  $$GastosFijosTableTableManager(_$AppDatabase db, $GastosFijosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GastosFijosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GastosFijosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GastosFijosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> descripcion = const Value.absent(),
                Value<int> monto = const Value.absent(),
                Value<int> dia = const Value.absent(),
                Value<int?> categoriaId = const Value.absent(),
                Value<int?> cuentaId = const Value.absent(),
                Value<bool> recordar = const Value.absent(),
                Value<bool> activo = const Value.absent(),
              }) => GastosFijosCompanion(
                id: id,
                descripcion: descripcion,
                monto: monto,
                dia: dia,
                categoriaId: categoriaId,
                cuentaId: cuentaId,
                recordar: recordar,
                activo: activo,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String descripcion,
                required int monto,
                required int dia,
                Value<int?> categoriaId = const Value.absent(),
                Value<int?> cuentaId = const Value.absent(),
                Value<bool> recordar = const Value.absent(),
                Value<bool> activo = const Value.absent(),
              }) => GastosFijosCompanion.insert(
                id: id,
                descripcion: descripcion,
                monto: monto,
                dia: dia,
                categoriaId: categoriaId,
                cuentaId: cuentaId,
                recordar: recordar,
                activo: activo,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GastosFijosTable, GastoFijo>(table),
                  $$GastosFijosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                categoriaId = false,
                cuentaId = false,
                movimientosRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (movimientosRefs) db.movimientos,
                  ],
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
                        if (categoriaId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.categoriaId,
                            referencedTable: $$GastosFijosTableReferences
                                ._categoriaIdTable(db),
                            referencedColumn: $$GastosFijosTableReferences
                                ._categoriaIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (cuentaId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.cuentaId,
                            referencedTable: $$GastosFijosTableReferences
                                ._cuentaIdTable(db),
                            referencedColumn: $$GastosFijosTableReferences
                                ._cuentaIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (movimientosRefs)
                        await $_getPrefetchedData<
                          GastoFijo,
                          $GastosFijosTable,
                          Movimiento
                        >(
                          currentTable: table,
                          referencedTable: $$GastosFijosTableReferences
                              ._movimientosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GastosFijosTableReferences(
                                db,
                                table,
                                p0,
                              ).movimientosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fijoId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$GastosFijosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GastosFijosTable,
      GastoFijo,
      $$GastosFijosTableFilterComposer,
      $$GastosFijosTableOrderingComposer,
      $$GastosFijosTableAnnotationComposer,
      $$GastosFijosTableCreateCompanionBuilder,
      $$GastosFijosTableUpdateCompanionBuilder,
      (GastoFijo, $$GastosFijosTableReferences),
      GastoFijo,
      PrefetchHooks Function({
        bool categoriaId,
        bool cuentaId,
        bool movimientosRefs,
      })
    >;
typedef $$MovimientosTableCreateCompanionBuilder =
    MovimientosCompanion Function({
      Value<int> id,
      required String tipo,
      required int monto,
      required DateTime fecha,
      Value<String?> descripcion,
      Value<int?> categoriaId,
      Value<int?> cuentaId,
      Value<int?> cuentaDestinoId,
      Value<int?> tarjetaId,
      Value<int> cuotas,
      Value<int?> fijoId,
    });
typedef $$MovimientosTableUpdateCompanionBuilder =
    MovimientosCompanion Function({
      Value<int> id,
      Value<String> tipo,
      Value<int> monto,
      Value<DateTime> fecha,
      Value<String?> descripcion,
      Value<int?> categoriaId,
      Value<int?> cuentaId,
      Value<int?> cuentaDestinoId,
      Value<int?> tarjetaId,
      Value<int> cuotas,
      Value<int?> fijoId,
    });

final class $$MovimientosTableReferences
    extends BaseReferences<_$AppDatabase, $MovimientosTable, Movimiento> {
  $$MovimientosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriasTable _categoriaIdTable(_$AppDatabase db) => db.categorias
      .createAlias('fin_movimientos__categoria_id__fin_categorias__id');

  $$CategoriasTableProcessedTableManager? get categoriaId {
    final $_column = $_itemColumn<int>('categoria_id');
    if ($_column == null) return null;
    final manager = $$CategoriasTableTableManager(
      $_db,
      $_db.categorias,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoriaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CuentasTable _cuentaIdTable(_$AppDatabase db) =>
      db.cuentas.createAlias('fin_movimientos__cuenta_id__fin_cuentas__id');

  $$CuentasTableProcessedTableManager? get cuentaId {
    final $_column = $_itemColumn<int>('cuenta_id');
    if ($_column == null) return null;
    final manager = $$CuentasTableTableManager(
      $_db,
      $_db.cuentas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cuentaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CuentasTable _cuentaDestinoIdTable(_$AppDatabase db) => db.cuentas
      .createAlias('fin_movimientos__cuenta_destino_id__fin_cuentas__id');

  $$CuentasTableProcessedTableManager? get cuentaDestinoId {
    final $_column = $_itemColumn<int>('cuenta_destino_id');
    if ($_column == null) return null;
    final manager = $$CuentasTableTableManager(
      $_db,
      $_db.cuentas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cuentaDestinoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TarjetasTable _tarjetaIdTable(_$AppDatabase db) =>
      db.tarjetas.createAlias('fin_movimientos__tarjeta_id__fin_tarjetas__id');

  $$TarjetasTableProcessedTableManager? get tarjetaId {
    final $_column = $_itemColumn<int>('tarjeta_id');
    if ($_column == null) return null;
    final manager = $$TarjetasTableTableManager(
      $_db,
      $_db.tarjetas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tarjetaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $GastosFijosTable _fijoIdTable(_$AppDatabase db) => db.gastosFijos
      .createAlias('fin_movimientos__fijo_id__fin_gastos_fijos__id');

  $$GastosFijosTableProcessedTableManager? get fijoId {
    final $_column = $_itemColumn<int>('fijo_id');
    if ($_column == null) return null;
    final manager = $$GastosFijosTableTableManager(
      $_db,
      $_db.gastosFijos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fijoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MovimientosTableFilterComposer
    extends Composer<_$AppDatabase, $MovimientosTable> {
  $$MovimientosTableFilterComposer({
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

  ColumnFilters<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get monto => $composableBuilder(
    column: $table.monto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cuotas => $composableBuilder(
    column: $table.cuotas,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoriasTableFilterComposer get categoriaId {
    final $$CategoriasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoriaId,
      referencedTable: $db.categorias,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriasTableFilterComposer(
            $db: $db,
            $table: $db.categorias,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CuentasTableFilterComposer get cuentaId {
    final $$CuentasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cuentaId,
      referencedTable: $db.cuentas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CuentasTableFilterComposer(
            $db: $db,
            $table: $db.cuentas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CuentasTableFilterComposer get cuentaDestinoId {
    final $$CuentasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cuentaDestinoId,
      referencedTable: $db.cuentas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CuentasTableFilterComposer(
            $db: $db,
            $table: $db.cuentas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TarjetasTableFilterComposer get tarjetaId {
    final $$TarjetasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tarjetaId,
      referencedTable: $db.tarjetas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TarjetasTableFilterComposer(
            $db: $db,
            $table: $db.tarjetas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GastosFijosTableFilterComposer get fijoId {
    final $$GastosFijosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fijoId,
      referencedTable: $db.gastosFijos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GastosFijosTableFilterComposer(
            $db: $db,
            $table: $db.gastosFijos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovimientosTableOrderingComposer
    extends Composer<_$AppDatabase, $MovimientosTable> {
  $$MovimientosTableOrderingComposer({
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

  ColumnOrderings<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get monto => $composableBuilder(
    column: $table.monto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cuotas => $composableBuilder(
    column: $table.cuotas,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriasTableOrderingComposer get categoriaId {
    final $$CategoriasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoriaId,
      referencedTable: $db.categorias,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriasTableOrderingComposer(
            $db: $db,
            $table: $db.categorias,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CuentasTableOrderingComposer get cuentaId {
    final $$CuentasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cuentaId,
      referencedTable: $db.cuentas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CuentasTableOrderingComposer(
            $db: $db,
            $table: $db.cuentas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CuentasTableOrderingComposer get cuentaDestinoId {
    final $$CuentasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cuentaDestinoId,
      referencedTable: $db.cuentas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CuentasTableOrderingComposer(
            $db: $db,
            $table: $db.cuentas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TarjetasTableOrderingComposer get tarjetaId {
    final $$TarjetasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tarjetaId,
      referencedTable: $db.tarjetas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TarjetasTableOrderingComposer(
            $db: $db,
            $table: $db.tarjetas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GastosFijosTableOrderingComposer get fijoId {
    final $$GastosFijosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fijoId,
      referencedTable: $db.gastosFijos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GastosFijosTableOrderingComposer(
            $db: $db,
            $table: $db.gastosFijos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovimientosTableAnnotationComposer
    extends Composer<_$AppDatabase, $MovimientosTable> {
  $$MovimientosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<int> get monto =>
      $composableBuilder(column: $table.monto, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get cuotas =>
      $composableBuilder(column: $table.cuotas, builder: (column) => column);

  $$CategoriasTableAnnotationComposer get categoriaId {
    final $$CategoriasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoriaId,
      referencedTable: $db.categorias,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriasTableAnnotationComposer(
            $db: $db,
            $table: $db.categorias,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CuentasTableAnnotationComposer get cuentaId {
    final $$CuentasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cuentaId,
      referencedTable: $db.cuentas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CuentasTableAnnotationComposer(
            $db: $db,
            $table: $db.cuentas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CuentasTableAnnotationComposer get cuentaDestinoId {
    final $$CuentasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cuentaDestinoId,
      referencedTable: $db.cuentas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CuentasTableAnnotationComposer(
            $db: $db,
            $table: $db.cuentas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TarjetasTableAnnotationComposer get tarjetaId {
    final $$TarjetasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tarjetaId,
      referencedTable: $db.tarjetas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TarjetasTableAnnotationComposer(
            $db: $db,
            $table: $db.tarjetas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GastosFijosTableAnnotationComposer get fijoId {
    final $$GastosFijosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fijoId,
      referencedTable: $db.gastosFijos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GastosFijosTableAnnotationComposer(
            $db: $db,
            $table: $db.gastosFijos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovimientosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MovimientosTable,
          Movimiento,
          $$MovimientosTableFilterComposer,
          $$MovimientosTableOrderingComposer,
          $$MovimientosTableAnnotationComposer,
          $$MovimientosTableCreateCompanionBuilder,
          $$MovimientosTableUpdateCompanionBuilder,
          (Movimiento, $$MovimientosTableReferences),
          Movimiento,
          PrefetchHooks Function({
            bool categoriaId,
            bool cuentaId,
            bool cuentaDestinoId,
            bool tarjetaId,
            bool fijoId,
          })
        > {
  $$MovimientosTableTableManager(_$AppDatabase db, $MovimientosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MovimientosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MovimientosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MovimientosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> tipo = const Value.absent(),
                Value<int> monto = const Value.absent(),
                Value<DateTime> fecha = const Value.absent(),
                Value<String?> descripcion = const Value.absent(),
                Value<int?> categoriaId = const Value.absent(),
                Value<int?> cuentaId = const Value.absent(),
                Value<int?> cuentaDestinoId = const Value.absent(),
                Value<int?> tarjetaId = const Value.absent(),
                Value<int> cuotas = const Value.absent(),
                Value<int?> fijoId = const Value.absent(),
              }) => MovimientosCompanion(
                id: id,
                tipo: tipo,
                monto: monto,
                fecha: fecha,
                descripcion: descripcion,
                categoriaId: categoriaId,
                cuentaId: cuentaId,
                cuentaDestinoId: cuentaDestinoId,
                tarjetaId: tarjetaId,
                cuotas: cuotas,
                fijoId: fijoId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String tipo,
                required int monto,
                required DateTime fecha,
                Value<String?> descripcion = const Value.absent(),
                Value<int?> categoriaId = const Value.absent(),
                Value<int?> cuentaId = const Value.absent(),
                Value<int?> cuentaDestinoId = const Value.absent(),
                Value<int?> tarjetaId = const Value.absent(),
                Value<int> cuotas = const Value.absent(),
                Value<int?> fijoId = const Value.absent(),
              }) => MovimientosCompanion.insert(
                id: id,
                tipo: tipo,
                monto: monto,
                fecha: fecha,
                descripcion: descripcion,
                categoriaId: categoriaId,
                cuentaId: cuentaId,
                cuentaDestinoId: cuentaDestinoId,
                tarjetaId: tarjetaId,
                cuotas: cuotas,
                fijoId: fijoId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MovimientosTable, Movimiento>(table),
                  $$MovimientosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                categoriaId = false,
                cuentaId = false,
                cuentaDestinoId = false,
                tarjetaId = false,
                fijoId = false,
              }) {
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
                        if (categoriaId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.categoriaId,
                            referencedTable: $$MovimientosTableReferences
                                ._categoriaIdTable(db),
                            referencedColumn: $$MovimientosTableReferences
                                ._categoriaIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (cuentaId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.cuentaId,
                            referencedTable: $$MovimientosTableReferences
                                ._cuentaIdTable(db),
                            referencedColumn: $$MovimientosTableReferences
                                ._cuentaIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (cuentaDestinoId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.cuentaDestinoId,
                            referencedTable: $$MovimientosTableReferences
                                ._cuentaDestinoIdTable(db),
                            referencedColumn: $$MovimientosTableReferences
                                ._cuentaDestinoIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (tarjetaId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.tarjetaId,
                            referencedTable: $$MovimientosTableReferences
                                ._tarjetaIdTable(db),
                            referencedColumn: $$MovimientosTableReferences
                                ._tarjetaIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (fijoId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.fijoId,
                            referencedTable: $$MovimientosTableReferences
                                ._fijoIdTable(db),
                            referencedColumn: $$MovimientosTableReferences
                                ._fijoIdTable(db)
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

typedef $$MovimientosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MovimientosTable,
      Movimiento,
      $$MovimientosTableFilterComposer,
      $$MovimientosTableOrderingComposer,
      $$MovimientosTableAnnotationComposer,
      $$MovimientosTableCreateCompanionBuilder,
      $$MovimientosTableUpdateCompanionBuilder,
      (Movimiento, $$MovimientosTableReferences),
      Movimiento,
      PrefetchHooks Function({
        bool categoriaId,
        bool cuentaId,
        bool cuentaDestinoId,
        bool tarjetaId,
        bool fijoId,
      })
    >;
typedef $$MetasTableCreateCompanionBuilder = MetasCompanion Function({
  Value<int> id,
  required String nombre,
  required int objetivo,
  Value<int> ahorrado,
  Value<DateTime?> fechaObjetivo,
  Value<String?> dondeEsta,
});
typedef $$MetasTableUpdateCompanionBuilder = MetasCompanion Function({
  Value<int> id,
  Value<String> nombre,
  Value<int> objetivo,
  Value<int> ahorrado,
  Value<DateTime?> fechaObjetivo,
  Value<String?> dondeEsta,
});

class $$MetasTableFilterComposer extends Composer<_$AppDatabase, $MetasTable> {
  $$MetasTableFilterComposer({
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

  ColumnFilters<int> get objetivo => $composableBuilder(
    column: $table.objetivo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ahorrado => $composableBuilder(
    column: $table.ahorrado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaObjetivo => $composableBuilder(
    column: $table.fechaObjetivo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dondeEsta => $composableBuilder(
    column: $table.dondeEsta,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MetasTableOrderingComposer
    extends Composer<_$AppDatabase, $MetasTable> {
  $$MetasTableOrderingComposer({
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

  ColumnOrderings<int> get objetivo => $composableBuilder(
    column: $table.objetivo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ahorrado => $composableBuilder(
    column: $table.ahorrado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaObjetivo => $composableBuilder(
    column: $table.fechaObjetivo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dondeEsta => $composableBuilder(
    column: $table.dondeEsta,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MetasTableAnnotationComposer
    extends Composer<_$AppDatabase, $MetasTable> {
  $$MetasTableAnnotationComposer({
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

  GeneratedColumn<int> get objetivo =>
      $composableBuilder(column: $table.objetivo, builder: (column) => column);

  GeneratedColumn<int> get ahorrado =>
      $composableBuilder(column: $table.ahorrado, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaObjetivo => $composableBuilder(
    column: $table.fechaObjetivo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dondeEsta =>
      $composableBuilder(column: $table.dondeEsta, builder: (column) => column);
}

class $$MetasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MetasTable,
          Meta,
          $$MetasTableFilterComposer,
          $$MetasTableOrderingComposer,
          $$MetasTableAnnotationComposer,
          $$MetasTableCreateCompanionBuilder,
          $$MetasTableUpdateCompanionBuilder,
          (Meta, BaseReferences<_$AppDatabase, $MetasTable, Meta>),
          Meta,
          PrefetchHooks Function()
        > {
  $$MetasTableTableManager(_$AppDatabase db, $MetasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MetasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MetasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MetasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<int> objetivo = const Value.absent(),
                Value<int> ahorrado = const Value.absent(),
                Value<DateTime?> fechaObjetivo = const Value.absent(),
                Value<String?> dondeEsta = const Value.absent(),
              }) => MetasCompanion(
                id: id,
                nombre: nombre,
                objetivo: objetivo,
                ahorrado: ahorrado,
                fechaObjetivo: fechaObjetivo,
                dondeEsta: dondeEsta,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                required int objetivo,
                Value<int> ahorrado = const Value.absent(),
                Value<DateTime?> fechaObjetivo = const Value.absent(),
                Value<String?> dondeEsta = const Value.absent(),
              }) => MetasCompanion.insert(
                id: id,
                nombre: nombre,
                objetivo: objetivo,
                ahorrado: ahorrado,
                fechaObjetivo: fechaObjetivo,
                dondeEsta: dondeEsta,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MetasTable, Meta>(table),
                  BaseReferences<_$AppDatabase, $MetasTable, Meta>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MetasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MetasTable,
      Meta,
      $$MetasTableFilterComposer,
      $$MetasTableOrderingComposer,
      $$MetasTableAnnotationComposer,
      $$MetasTableCreateCompanionBuilder,
      $$MetasTableUpdateCompanionBuilder,
      (Meta, BaseReferences<_$AppDatabase, $MetasTable, Meta>),
      Meta,
      PrefetchHooks Function()
    >;
typedef $$DeudasTableCreateCompanionBuilder = DeudasCompanion Function({
  Value<int> id,
  required String persona,
  required String direccion,
  required int monto,
  Value<int> abonado,
  Value<String?> nota,
  required DateTime fecha,
});
typedef $$DeudasTableUpdateCompanionBuilder = DeudasCompanion Function({
  Value<int> id,
  Value<String> persona,
  Value<String> direccion,
  Value<int> monto,
  Value<int> abonado,
  Value<String?> nota,
  Value<DateTime> fecha,
});

class $$DeudasTableFilterComposer
    extends Composer<_$AppDatabase, $DeudasTable> {
  $$DeudasTableFilterComposer({
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

  ColumnFilters<String> get persona => $composableBuilder(
    column: $table.persona,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get direccion => $composableBuilder(
    column: $table.direccion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get monto => $composableBuilder(
    column: $table.monto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get abonado => $composableBuilder(
    column: $table.abonado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nota => $composableBuilder(
    column: $table.nota,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DeudasTableOrderingComposer
    extends Composer<_$AppDatabase, $DeudasTable> {
  $$DeudasTableOrderingComposer({
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

  ColumnOrderings<String> get persona => $composableBuilder(
    column: $table.persona,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get direccion => $composableBuilder(
    column: $table.direccion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get monto => $composableBuilder(
    column: $table.monto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get abonado => $composableBuilder(
    column: $table.abonado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nota => $composableBuilder(
    column: $table.nota,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DeudasTableAnnotationComposer
    extends Composer<_$AppDatabase, $DeudasTable> {
  $$DeudasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get persona =>
      $composableBuilder(column: $table.persona, builder: (column) => column);

  GeneratedColumn<String> get direccion =>
      $composableBuilder(column: $table.direccion, builder: (column) => column);

  GeneratedColumn<int> get monto =>
      $composableBuilder(column: $table.monto, builder: (column) => column);

  GeneratedColumn<int> get abonado =>
      $composableBuilder(column: $table.abonado, builder: (column) => column);

  GeneratedColumn<String> get nota =>
      $composableBuilder(column: $table.nota, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);
}

class $$DeudasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DeudasTable,
          Deuda,
          $$DeudasTableFilterComposer,
          $$DeudasTableOrderingComposer,
          $$DeudasTableAnnotationComposer,
          $$DeudasTableCreateCompanionBuilder,
          $$DeudasTableUpdateCompanionBuilder,
          (Deuda, BaseReferences<_$AppDatabase, $DeudasTable, Deuda>),
          Deuda,
          PrefetchHooks Function()
        > {
  $$DeudasTableTableManager(_$AppDatabase db, $DeudasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DeudasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DeudasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DeudasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> persona = const Value.absent(),
                Value<String> direccion = const Value.absent(),
                Value<int> monto = const Value.absent(),
                Value<int> abonado = const Value.absent(),
                Value<String?> nota = const Value.absent(),
                Value<DateTime> fecha = const Value.absent(),
              }) => DeudasCompanion(
                id: id,
                persona: persona,
                direccion: direccion,
                monto: monto,
                abonado: abonado,
                nota: nota,
                fecha: fecha,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String persona,
                required String direccion,
                required int monto,
                Value<int> abonado = const Value.absent(),
                Value<String?> nota = const Value.absent(),
                required DateTime fecha,
              }) => DeudasCompanion.insert(
                id: id,
                persona: persona,
                direccion: direccion,
                monto: monto,
                abonado: abonado,
                nota: nota,
                fecha: fecha,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DeudasTable, Deuda>(table),
                  BaseReferences<_$AppDatabase, $DeudasTable, Deuda>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DeudasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DeudasTable,
      Deuda,
      $$DeudasTableFilterComposer,
      $$DeudasTableOrderingComposer,
      $$DeudasTableAnnotationComposer,
      $$DeudasTableCreateCompanionBuilder,
      $$DeudasTableUpdateCompanionBuilder,
      (Deuda, BaseReferences<_$AppDatabase, $DeudasTable, Deuda>),
      Deuda,
      PrefetchHooks Function()
    >;
typedef $$EjerciciosTableCreateCompanionBuilder = EjerciciosCompanion Function({
  Value<int> id,
  required String nombre,
  required String grupo,
  Value<String> equipo,
  Value<String?> maquina,
});
typedef $$EjerciciosTableUpdateCompanionBuilder = EjerciciosCompanion Function({
  Value<int> id,
  Value<String> nombre,
  Value<String> grupo,
  Value<String> equipo,
  Value<String?> maquina,
});

final class $$EjerciciosTableReferences
    extends BaseReferences<_$AppDatabase, $EjerciciosTable, Ejercicio> {
  $$EjerciciosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SeriesTable, List<Serie>> _seriesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.series,
    aliasName: 'ent_ejercicios__id__ent_series__ejercicio_id',
  );

  $$SeriesTableProcessedTableManager get seriesRefs {
    final manager = $$SeriesTableTableManager(
      $_db,
      $_db.series,
    ).filter((f) => f.ejercicioId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_seriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EjerciciosTableFilterComposer
    extends Composer<_$AppDatabase, $EjerciciosTable> {
  $$EjerciciosTableFilterComposer({
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

  ColumnFilters<String> get grupo => $composableBuilder(
    column: $table.grupo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get equipo => $composableBuilder(
    column: $table.equipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get maquina => $composableBuilder(
    column: $table.maquina,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> seriesRefs(
    Expression<bool> Function($$SeriesTableFilterComposer f) f,
  ) {
    final $$SeriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.series,
      getReferencedColumn: (t) => t.ejercicioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SeriesTableFilterComposer(
            $db: $db,
            $table: $db.series,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EjerciciosTableOrderingComposer
    extends Composer<_$AppDatabase, $EjerciciosTable> {
  $$EjerciciosTableOrderingComposer({
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

  ColumnOrderings<String> get grupo => $composableBuilder(
    column: $table.grupo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get equipo => $composableBuilder(
    column: $table.equipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get maquina => $composableBuilder(
    column: $table.maquina,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EjerciciosTableAnnotationComposer
    extends Composer<_$AppDatabase, $EjerciciosTable> {
  $$EjerciciosTableAnnotationComposer({
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

  GeneratedColumn<String> get grupo =>
      $composableBuilder(column: $table.grupo, builder: (column) => column);

  GeneratedColumn<String> get equipo =>
      $composableBuilder(column: $table.equipo, builder: (column) => column);

  GeneratedColumn<String> get maquina =>
      $composableBuilder(column: $table.maquina, builder: (column) => column);

  Expression<T> seriesRefs<T extends Object>(
    Expression<T> Function($$SeriesTableAnnotationComposer a) f,
  ) {
    final $$SeriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.series,
      getReferencedColumn: (t) => t.ejercicioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SeriesTableAnnotationComposer(
            $db: $db,
            $table: $db.series,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EjerciciosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EjerciciosTable,
          Ejercicio,
          $$EjerciciosTableFilterComposer,
          $$EjerciciosTableOrderingComposer,
          $$EjerciciosTableAnnotationComposer,
          $$EjerciciosTableCreateCompanionBuilder,
          $$EjerciciosTableUpdateCompanionBuilder,
          (Ejercicio, $$EjerciciosTableReferences),
          Ejercicio,
          PrefetchHooks Function({bool seriesRefs})
        > {
  $$EjerciciosTableTableManager(_$AppDatabase db, $EjerciciosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EjerciciosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EjerciciosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EjerciciosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> grupo = const Value.absent(),
                Value<String> equipo = const Value.absent(),
                Value<String?> maquina = const Value.absent(),
              }) => EjerciciosCompanion(
                id: id,
                nombre: nombre,
                grupo: grupo,
                equipo: equipo,
                maquina: maquina,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                required String grupo,
                Value<String> equipo = const Value.absent(),
                Value<String?> maquina = const Value.absent(),
              }) => EjerciciosCompanion.insert(
                id: id,
                nombre: nombre,
                grupo: grupo,
                equipo: equipo,
                maquina: maquina,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EjerciciosTable, Ejercicio>(table),
                  $$EjerciciosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({seriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (seriesRefs) db.series],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (seriesRefs)
                    await $_getPrefetchedData<
                      Ejercicio,
                      $EjerciciosTable,
                      Serie
                    >(
                      currentTable: table,
                      referencedTable: $$EjerciciosTableReferences
                          ._seriesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$EjerciciosTableReferences(db, table, p0).seriesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.ejercicioId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$EjerciciosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EjerciciosTable,
      Ejercicio,
      $$EjerciciosTableFilterComposer,
      $$EjerciciosTableOrderingComposer,
      $$EjerciciosTableAnnotationComposer,
      $$EjerciciosTableCreateCompanionBuilder,
      $$EjerciciosTableUpdateCompanionBuilder,
      (Ejercicio, $$EjerciciosTableReferences),
      Ejercicio,
      PrefetchHooks Function({bool seriesRefs})
    >;
typedef $$SesionesTableCreateCompanionBuilder = SesionesCompanion Function({
  Value<int> id,
  required DateTime fecha,
  required String titulo,
  Value<String?> notas,
});
typedef $$SesionesTableUpdateCompanionBuilder = SesionesCompanion Function({
  Value<int> id,
  Value<DateTime> fecha,
  Value<String> titulo,
  Value<String?> notas,
});

final class $$SesionesTableReferences
    extends BaseReferences<_$AppDatabase, $SesionesTable, Sesion> {
  $$SesionesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SeriesTable, List<Serie>> _seriesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.series,
    aliasName: 'ent_sesiones__id__ent_series__sesion_id',
  );

  $$SeriesTableProcessedTableManager get seriesRefs {
    final manager = $$SeriesTableTableManager(
      $_db,
      $_db.series,
    ).filter((f) => f.sesionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_seriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SesionesTableFilterComposer
    extends Composer<_$AppDatabase, $SesionesTable> {
  $$SesionesTableFilterComposer({
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

  ColumnFilters<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
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

  Expression<bool> seriesRefs(
    Expression<bool> Function($$SeriesTableFilterComposer f) f,
  ) {
    final $$SeriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.series,
      getReferencedColumn: (t) => t.sesionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SeriesTableFilterComposer(
            $db: $db,
            $table: $db.series,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SesionesTableOrderingComposer
    extends Composer<_$AppDatabase, $SesionesTable> {
  $$SesionesTableOrderingComposer({
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

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
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
}

class $$SesionesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SesionesTable> {
  $$SesionesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  GeneratedColumn<String> get titulo =>
      $composableBuilder(column: $table.titulo, builder: (column) => column);

  GeneratedColumn<String> get notas =>
      $composableBuilder(column: $table.notas, builder: (column) => column);

  Expression<T> seriesRefs<T extends Object>(
    Expression<T> Function($$SeriesTableAnnotationComposer a) f,
  ) {
    final $$SeriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.series,
      getReferencedColumn: (t) => t.sesionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SeriesTableAnnotationComposer(
            $db: $db,
            $table: $db.series,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SesionesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SesionesTable,
          Sesion,
          $$SesionesTableFilterComposer,
          $$SesionesTableOrderingComposer,
          $$SesionesTableAnnotationComposer,
          $$SesionesTableCreateCompanionBuilder,
          $$SesionesTableUpdateCompanionBuilder,
          (Sesion, $$SesionesTableReferences),
          Sesion,
          PrefetchHooks Function({bool seriesRefs})
        > {
  $$SesionesTableTableManager(_$AppDatabase db, $SesionesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SesionesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SesionesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SesionesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> fecha = const Value.absent(),
                Value<String> titulo = const Value.absent(),
                Value<String?> notas = const Value.absent(),
              }) => SesionesCompanion(
                id: id,
                fecha: fecha,
                titulo: titulo,
                notas: notas,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime fecha,
                required String titulo,
                Value<String?> notas = const Value.absent(),
              }) => SesionesCompanion.insert(
                id: id,
                fecha: fecha,
                titulo: titulo,
                notas: notas,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SesionesTable, Sesion>(table),
                  $$SesionesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({seriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (seriesRefs) db.series],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (seriesRefs)
                    await $_getPrefetchedData<Sesion, $SesionesTable, Serie>(
                      currentTable: table,
                      referencedTable: $$SesionesTableReferences
                          ._seriesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SesionesTableReferences(db, table, p0).seriesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.sesionId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SesionesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SesionesTable,
      Sesion,
      $$SesionesTableFilterComposer,
      $$SesionesTableOrderingComposer,
      $$SesionesTableAnnotationComposer,
      $$SesionesTableCreateCompanionBuilder,
      $$SesionesTableUpdateCompanionBuilder,
      (Sesion, $$SesionesTableReferences),
      Sesion,
      PrefetchHooks Function({bool seriesRefs})
    >;
typedef $$SeriesTableCreateCompanionBuilder = SeriesCompanion Function({
  Value<int> id,
  required int sesionId,
  required int ejercicioId,
  required int orden,
  required int reps,
  Value<double> pesoKg,
});
typedef $$SeriesTableUpdateCompanionBuilder = SeriesCompanion Function({
  Value<int> id,
  Value<int> sesionId,
  Value<int> ejercicioId,
  Value<int> orden,
  Value<int> reps,
  Value<double> pesoKg,
});

final class $$SeriesTableReferences
    extends BaseReferences<_$AppDatabase, $SeriesTable, Serie> {
  $$SeriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SesionesTable _sesionIdTable(_$AppDatabase db) =>
      db.sesiones.createAlias('ent_series__sesion_id__ent_sesiones__id');

  $$SesionesTableProcessedTableManager get sesionId {
    final $_column = $_itemColumn<int>('sesion_id')!;

    final manager = $$SesionesTableTableManager(
      $_db,
      $_db.sesiones,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sesionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $EjerciciosTable _ejercicioIdTable(_$AppDatabase db) =>
      db.ejercicios.createAlias('ent_series__ejercicio_id__ent_ejercicios__id');

  $$EjerciciosTableProcessedTableManager get ejercicioId {
    final $_column = $_itemColumn<int>('ejercicio_id')!;

    final manager = $$EjerciciosTableTableManager(
      $_db,
      $_db.ejercicios,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ejercicioIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SeriesTableFilterComposer
    extends Composer<_$AppDatabase, $SeriesTable> {
  $$SeriesTableFilterComposer({
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

  ColumnFilters<int> get orden => $composableBuilder(
    column: $table.orden,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pesoKg => $composableBuilder(
    column: $table.pesoKg,
    builder: (column) => ColumnFilters(column),
  );

  $$SesionesTableFilterComposer get sesionId {
    final $$SesionesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sesionId,
      referencedTable: $db.sesiones,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SesionesTableFilterComposer(
            $db: $db,
            $table: $db.sesiones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EjerciciosTableFilterComposer get ejercicioId {
    final $$EjerciciosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ejercicioId,
      referencedTable: $db.ejercicios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EjerciciosTableFilterComposer(
            $db: $db,
            $table: $db.ejercicios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SeriesTableOrderingComposer
    extends Composer<_$AppDatabase, $SeriesTable> {
  $$SeriesTableOrderingComposer({
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

  ColumnOrderings<int> get orden => $composableBuilder(
    column: $table.orden,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pesoKg => $composableBuilder(
    column: $table.pesoKg,
    builder: (column) => ColumnOrderings(column),
  );

  $$SesionesTableOrderingComposer get sesionId {
    final $$SesionesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sesionId,
      referencedTable: $db.sesiones,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SesionesTableOrderingComposer(
            $db: $db,
            $table: $db.sesiones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EjerciciosTableOrderingComposer get ejercicioId {
    final $$EjerciciosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ejercicioId,
      referencedTable: $db.ejercicios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EjerciciosTableOrderingComposer(
            $db: $db,
            $table: $db.ejercicios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SeriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SeriesTable> {
  $$SeriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get orden =>
      $composableBuilder(column: $table.orden, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<double> get pesoKg =>
      $composableBuilder(column: $table.pesoKg, builder: (column) => column);

  $$SesionesTableAnnotationComposer get sesionId {
    final $$SesionesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sesionId,
      referencedTable: $db.sesiones,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SesionesTableAnnotationComposer(
            $db: $db,
            $table: $db.sesiones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EjerciciosTableAnnotationComposer get ejercicioId {
    final $$EjerciciosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ejercicioId,
      referencedTable: $db.ejercicios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EjerciciosTableAnnotationComposer(
            $db: $db,
            $table: $db.ejercicios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SeriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SeriesTable,
          Serie,
          $$SeriesTableFilterComposer,
          $$SeriesTableOrderingComposer,
          $$SeriesTableAnnotationComposer,
          $$SeriesTableCreateCompanionBuilder,
          $$SeriesTableUpdateCompanionBuilder,
          (Serie, $$SeriesTableReferences),
          Serie,
          PrefetchHooks Function({bool sesionId, bool ejercicioId})
        > {
  $$SeriesTableTableManager(_$AppDatabase db, $SeriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SeriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SeriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SeriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> sesionId = const Value.absent(),
                Value<int> ejercicioId = const Value.absent(),
                Value<int> orden = const Value.absent(),
                Value<int> reps = const Value.absent(),
                Value<double> pesoKg = const Value.absent(),
              }) => SeriesCompanion(
                id: id,
                sesionId: sesionId,
                ejercicioId: ejercicioId,
                orden: orden,
                reps: reps,
                pesoKg: pesoKg,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int sesionId,
                required int ejercicioId,
                required int orden,
                required int reps,
                Value<double> pesoKg = const Value.absent(),
              }) => SeriesCompanion.insert(
                id: id,
                sesionId: sesionId,
                ejercicioId: ejercicioId,
                orden: orden,
                reps: reps,
                pesoKg: pesoKg,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SeriesTable, Serie>(table),
                  $$SeriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sesionId = false, ejercicioId = false}) {
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
                    if (sesionId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.sesionId,
                        referencedTable: $$SeriesTableReferences._sesionIdTable(
                          db,
                        ),
                        referencedColumn: $$SeriesTableReferences
                            ._sesionIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (ejercicioId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.ejercicioId,
                        referencedTable: $$SeriesTableReferences
                            ._ejercicioIdTable(db),
                        referencedColumn: $$SeriesTableReferences
                            ._ejercicioIdTable(db)
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

typedef $$SeriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SeriesTable,
      Serie,
      $$SeriesTableFilterComposer,
      $$SeriesTableOrderingComposer,
      $$SeriesTableAnnotationComposer,
      $$SeriesTableCreateCompanionBuilder,
      $$SeriesTableUpdateCompanionBuilder,
      (Serie, $$SeriesTableReferences),
      Serie,
      PrefetchHooks Function({bool sesionId, bool ejercicioId})
    >;
typedef $$MovimientosCocinaTableCreateCompanionBuilder =
    MovimientosCocinaCompanion Function({
      Value<int> id,
      required int productoId,
      required String tipo,
      required double cantidad,
      required DateTime fecha,
    });
typedef $$MovimientosCocinaTableUpdateCompanionBuilder =
    MovimientosCocinaCompanion Function({
      Value<int> id,
      Value<int> productoId,
      Value<String> tipo,
      Value<double> cantidad,
      Value<DateTime> fecha,
    });

final class $$MovimientosCocinaTableReferences
    extends BaseReferences<_$AppDatabase, $MovimientosCocinaTable, MovCocina> {
  $$MovimientosCocinaTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProductosTable _productoIdTable(_$AppDatabase db) => db.productos
      .createAlias('coc_movimientos__producto_id__coc_productos__id');

  $$ProductosTableProcessedTableManager get productoId {
    final $_column = $_itemColumn<int>('producto_id')!;

    final manager = $$ProductosTableTableManager(
      $_db,
      $_db.productos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MovimientosCocinaTableFilterComposer
    extends Composer<_$AppDatabase, $MovimientosCocinaTable> {
  $$MovimientosCocinaTableFilterComposer({
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

  ColumnFilters<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductosTableFilterComposer get productoId {
    final $$ProductosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productoId,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableFilterComposer(
            $db: $db,
            $table: $db.productos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovimientosCocinaTableOrderingComposer
    extends Composer<_$AppDatabase, $MovimientosCocinaTable> {
  $$MovimientosCocinaTableOrderingComposer({
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

  ColumnOrderings<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductosTableOrderingComposer get productoId {
    final $$ProductosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productoId,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableOrderingComposer(
            $db: $db,
            $table: $db.productos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovimientosCocinaTableAnnotationComposer
    extends Composer<_$AppDatabase, $MovimientosCocinaTable> {
  $$MovimientosCocinaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<double> get cantidad =>
      $composableBuilder(column: $table.cantidad, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  $$ProductosTableAnnotationComposer get productoId {
    final $$ProductosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productoId,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableAnnotationComposer(
            $db: $db,
            $table: $db.productos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovimientosCocinaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MovimientosCocinaTable,
          MovCocina,
          $$MovimientosCocinaTableFilterComposer,
          $$MovimientosCocinaTableOrderingComposer,
          $$MovimientosCocinaTableAnnotationComposer,
          $$MovimientosCocinaTableCreateCompanionBuilder,
          $$MovimientosCocinaTableUpdateCompanionBuilder,
          (MovCocina, $$MovimientosCocinaTableReferences),
          MovCocina,
          PrefetchHooks Function({bool productoId})
        > {
  $$MovimientosCocinaTableTableManager(
    _$AppDatabase db,
    $MovimientosCocinaTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MovimientosCocinaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MovimientosCocinaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MovimientosCocinaTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> productoId = const Value.absent(),
                Value<String> tipo = const Value.absent(),
                Value<double> cantidad = const Value.absent(),
                Value<DateTime> fecha = const Value.absent(),
              }) => MovimientosCocinaCompanion(
                id: id,
                productoId: productoId,
                tipo: tipo,
                cantidad: cantidad,
                fecha: fecha,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int productoId,
                required String tipo,
                required double cantidad,
                required DateTime fecha,
              }) => MovimientosCocinaCompanion.insert(
                id: id,
                productoId: productoId,
                tipo: tipo,
                cantidad: cantidad,
                fecha: fecha,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MovimientosCocinaTable, MovCocina>(table),
                  $$MovimientosCocinaTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productoId = false}) {
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
                    if (productoId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.productoId,
                        referencedTable: $$MovimientosCocinaTableReferences
                            ._productoIdTable(db),
                        referencedColumn: $$MovimientosCocinaTableReferences
                            ._productoIdTable(db)
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

typedef $$MovimientosCocinaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MovimientosCocinaTable,
      MovCocina,
      $$MovimientosCocinaTableFilterComposer,
      $$MovimientosCocinaTableOrderingComposer,
      $$MovimientosCocinaTableAnnotationComposer,
      $$MovimientosCocinaTableCreateCompanionBuilder,
      $$MovimientosCocinaTableUpdateCompanionBuilder,
      (MovCocina, $$MovimientosCocinaTableReferences),
      MovCocina,
      PrefetchHooks Function({bool productoId})
    >;
typedef $$IdeasTableCreateCompanionBuilder = IdeasCompanion Function({
  Value<int> id,
  required String titulo,
  Value<String?> descripcion,
  Value<String> formato,
  Value<String> tags,
  Value<String> estado,
  Value<String?> hook,
  Value<String?> guion,
  Value<String?> codigo,
  Value<String?> caption,
  Value<DateTime?> publicadaEn,
  Value<int?> likes,
  Value<int?> guardados,
  Value<int?> comentarios,
  Value<int?> alcance,
  Value<String> origen,
  Value<DateTime> creadaEn,
});
typedef $$IdeasTableUpdateCompanionBuilder = IdeasCompanion Function({
  Value<int> id,
  Value<String> titulo,
  Value<String?> descripcion,
  Value<String> formato,
  Value<String> tags,
  Value<String> estado,
  Value<String?> hook,
  Value<String?> guion,
  Value<String?> codigo,
  Value<String?> caption,
  Value<DateTime?> publicadaEn,
  Value<int?> likes,
  Value<int?> guardados,
  Value<int?> comentarios,
  Value<int?> alcance,
  Value<String> origen,
  Value<DateTime> creadaEn,
});

class $$IdeasTableFilterComposer extends Composer<_$AppDatabase, $IdeasTable> {
  $$IdeasTableFilterComposer({
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

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get formato => $composableBuilder(
    column: $table.formato,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hook => $composableBuilder(
    column: $table.hook,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get guion => $composableBuilder(
    column: $table.guion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get codigo => $composableBuilder(
    column: $table.codigo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get caption => $composableBuilder(
    column: $table.caption,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get publicadaEn => $composableBuilder(
    column: $table.publicadaEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get likes => $composableBuilder(
    column: $table.likes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get guardados => $composableBuilder(
    column: $table.guardados,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get comentarios => $composableBuilder(
    column: $table.comentarios,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get alcance => $composableBuilder(
    column: $table.alcance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get origen => $composableBuilder(
    column: $table.origen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creadaEn => $composableBuilder(
    column: $table.creadaEn,
    builder: (column) => ColumnFilters(column),
  );
}

class $$IdeasTableOrderingComposer
    extends Composer<_$AppDatabase, $IdeasTable> {
  $$IdeasTableOrderingComposer({
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

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get formato => $composableBuilder(
    column: $table.formato,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hook => $composableBuilder(
    column: $table.hook,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get guion => $composableBuilder(
    column: $table.guion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get codigo => $composableBuilder(
    column: $table.codigo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get caption => $composableBuilder(
    column: $table.caption,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get publicadaEn => $composableBuilder(
    column: $table.publicadaEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get likes => $composableBuilder(
    column: $table.likes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get guardados => $composableBuilder(
    column: $table.guardados,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get comentarios => $composableBuilder(
    column: $table.comentarios,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get alcance => $composableBuilder(
    column: $table.alcance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get origen => $composableBuilder(
    column: $table.origen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creadaEn => $composableBuilder(
    column: $table.creadaEn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$IdeasTableAnnotationComposer
    extends Composer<_$AppDatabase, $IdeasTable> {
  $$IdeasTableAnnotationComposer({
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

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get formato =>
      $composableBuilder(column: $table.formato, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<String> get hook =>
      $composableBuilder(column: $table.hook, builder: (column) => column);

  GeneratedColumn<String> get guion =>
      $composableBuilder(column: $table.guion, builder: (column) => column);

  GeneratedColumn<String> get codigo =>
      $composableBuilder(column: $table.codigo, builder: (column) => column);

  GeneratedColumn<String> get caption =>
      $composableBuilder(column: $table.caption, builder: (column) => column);

  GeneratedColumn<DateTime> get publicadaEn => $composableBuilder(
    column: $table.publicadaEn,
    builder: (column) => column,
  );

  GeneratedColumn<int> get likes =>
      $composableBuilder(column: $table.likes, builder: (column) => column);

  GeneratedColumn<int> get guardados =>
      $composableBuilder(column: $table.guardados, builder: (column) => column);

  GeneratedColumn<int> get comentarios => $composableBuilder(
    column: $table.comentarios,
    builder: (column) => column,
  );

  GeneratedColumn<int> get alcance =>
      $composableBuilder(column: $table.alcance, builder: (column) => column);

  GeneratedColumn<String> get origen =>
      $composableBuilder(column: $table.origen, builder: (column) => column);

  GeneratedColumn<DateTime> get creadaEn =>
      $composableBuilder(column: $table.creadaEn, builder: (column) => column);
}

class $$IdeasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $IdeasTable,
          Idea,
          $$IdeasTableFilterComposer,
          $$IdeasTableOrderingComposer,
          $$IdeasTableAnnotationComposer,
          $$IdeasTableCreateCompanionBuilder,
          $$IdeasTableUpdateCompanionBuilder,
          (Idea, BaseReferences<_$AppDatabase, $IdeasTable, Idea>),
          Idea,
          PrefetchHooks Function()
        > {
  $$IdeasTableTableManager(_$AppDatabase db, $IdeasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IdeasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IdeasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IdeasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> titulo = const Value.absent(),
                Value<String?> descripcion = const Value.absent(),
                Value<String> formato = const Value.absent(),
                Value<String> tags = const Value.absent(),
                Value<String> estado = const Value.absent(),
                Value<String?> hook = const Value.absent(),
                Value<String?> guion = const Value.absent(),
                Value<String?> codigo = const Value.absent(),
                Value<String?> caption = const Value.absent(),
                Value<DateTime?> publicadaEn = const Value.absent(),
                Value<int?> likes = const Value.absent(),
                Value<int?> guardados = const Value.absent(),
                Value<int?> comentarios = const Value.absent(),
                Value<int?> alcance = const Value.absent(),
                Value<String> origen = const Value.absent(),
                Value<DateTime> creadaEn = const Value.absent(),
              }) => IdeasCompanion(
                id: id,
                titulo: titulo,
                descripcion: descripcion,
                formato: formato,
                tags: tags,
                estado: estado,
                hook: hook,
                guion: guion,
                codigo: codigo,
                caption: caption,
                publicadaEn: publicadaEn,
                likes: likes,
                guardados: guardados,
                comentarios: comentarios,
                alcance: alcance,
                origen: origen,
                creadaEn: creadaEn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String titulo,
                Value<String?> descripcion = const Value.absent(),
                Value<String> formato = const Value.absent(),
                Value<String> tags = const Value.absent(),
                Value<String> estado = const Value.absent(),
                Value<String?> hook = const Value.absent(),
                Value<String?> guion = const Value.absent(),
                Value<String?> codigo = const Value.absent(),
                Value<String?> caption = const Value.absent(),
                Value<DateTime?> publicadaEn = const Value.absent(),
                Value<int?> likes = const Value.absent(),
                Value<int?> guardados = const Value.absent(),
                Value<int?> comentarios = const Value.absent(),
                Value<int?> alcance = const Value.absent(),
                Value<String> origen = const Value.absent(),
                Value<DateTime> creadaEn = const Value.absent(),
              }) => IdeasCompanion.insert(
                id: id,
                titulo: titulo,
                descripcion: descripcion,
                formato: formato,
                tags: tags,
                estado: estado,
                hook: hook,
                guion: guion,
                codigo: codigo,
                caption: caption,
                publicadaEn: publicadaEn,
                likes: likes,
                guardados: guardados,
                comentarios: comentarios,
                alcance: alcance,
                origen: origen,
                creadaEn: creadaEn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$IdeasTable, Idea>(table),
                  BaseReferences<_$AppDatabase, $IdeasTable, Idea>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$IdeasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $IdeasTable,
      Idea,
      $$IdeasTableFilterComposer,
      $$IdeasTableOrderingComposer,
      $$IdeasTableAnnotationComposer,
      $$IdeasTableCreateCompanionBuilder,
      $$IdeasTableUpdateCompanionBuilder,
      (Idea, BaseReferences<_$AppDatabase, $IdeasTable, Idea>),
      Idea,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ListasTableTableManager get listas =>
      $$ListasTableTableManager(_db, _db.listas);
  $$ProductosTableTableManager get productos =>
      $$ProductosTableTableManager(_db, _db.productos);
  $$TareasTableTableManager get tareas =>
      $$TareasTableTableManager(_db, _db.tareas);
  $$CuentasTableTableManager get cuentas =>
      $$CuentasTableTableManager(_db, _db.cuentas);
  $$CategoriasTableTableManager get categorias =>
      $$CategoriasTableTableManager(_db, _db.categorias);
  $$TarjetasTableTableManager get tarjetas =>
      $$TarjetasTableTableManager(_db, _db.tarjetas);
  $$GastosFijosTableTableManager get gastosFijos =>
      $$GastosFijosTableTableManager(_db, _db.gastosFijos);
  $$MovimientosTableTableManager get movimientos =>
      $$MovimientosTableTableManager(_db, _db.movimientos);
  $$MetasTableTableManager get metas =>
      $$MetasTableTableManager(_db, _db.metas);
  $$DeudasTableTableManager get deudas =>
      $$DeudasTableTableManager(_db, _db.deudas);
  $$EjerciciosTableTableManager get ejercicios =>
      $$EjerciciosTableTableManager(_db, _db.ejercicios);
  $$SesionesTableTableManager get sesiones =>
      $$SesionesTableTableManager(_db, _db.sesiones);
  $$SeriesTableTableManager get series =>
      $$SeriesTableTableManager(_db, _db.series);
  $$MovimientosCocinaTableTableManager get movimientosCocina =>
      $$MovimientosCocinaTableTableManager(_db, _db.movimientosCocina);
  $$IdeasTableTableManager get ideas =>
      $$IdeasTableTableManager(_db, _db.ideas);
}
