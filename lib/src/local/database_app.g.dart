// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_app.dart';

// ignore_for_file: type=lint
class $NewProductsEntityTable extends NewProductsEntity
    with TableInfo<$NewProductsEntityTable, NewProductsEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NewProductsEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _provinceMeta =
      const VerificationMeta('province');
  @override
  late final GeneratedColumn<String> province = GeneratedColumn<String>(
      'province', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
      'price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<Uint8List> image = GeneratedColumn<Uint8List>(
      'image', aliasedName, true,
      type: DriftSqlType.blob, requiredDuringInsert: false);
  static const VerificationMeta _isNewMeta = const VerificationMeta('isNew');
  @override
  late final GeneratedColumn<bool> isNew = GeneratedColumn<bool>(
      'is_new', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_new" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, province, price, image, isNew];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'new_products_entity';
  @override
  VerificationContext validateIntegrity(
      Insertable<NewProductsEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('province')) {
      context.handle(_provinceMeta,
          province.isAcceptableOrUnknown(data['province']!, _provinceMeta));
    } else if (isInserting) {
      context.missing(_provinceMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    }
    if (data.containsKey('is_new')) {
      context.handle(
          _isNewMeta, isNew.isAcceptableOrUnknown(data['is_new']!, _isNewMeta));
    } else if (isInserting) {
      context.missing(_isNewMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NewProductsEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NewProductsEntityData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      province: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}province'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price'])!,
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}image']),
      isNew: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_new'])!,
    );
  }

  @override
  $NewProductsEntityTable createAlias(String alias) {
    return $NewProductsEntityTable(attachedDatabase, alias);
  }
}

class NewProductsEntityData extends DataClass
    implements Insertable<NewProductsEntityData> {
  final String id;
  final String title;
  final String province;
  final double price;
  final Uint8List? image;
  final bool isNew;
  const NewProductsEntityData(
      {required this.id,
      required this.title,
      required this.province,
      required this.price,
      this.image,
      required this.isNew});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['province'] = Variable<String>(province);
    map['price'] = Variable<double>(price);
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<Uint8List>(image);
    }
    map['is_new'] = Variable<bool>(isNew);
    return map;
  }

  NewProductsEntityCompanion toCompanion(bool nullToAbsent) {
    return NewProductsEntityCompanion(
      id: Value(id),
      title: Value(title),
      province: Value(province),
      price: Value(price),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
      isNew: Value(isNew),
    );
  }

  factory NewProductsEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NewProductsEntityData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      province: serializer.fromJson<String>(json['province']),
      price: serializer.fromJson<double>(json['price']),
      image: serializer.fromJson<Uint8List?>(json['image']),
      isNew: serializer.fromJson<bool>(json['isNew']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'province': serializer.toJson<String>(province),
      'price': serializer.toJson<double>(price),
      'image': serializer.toJson<Uint8List?>(image),
      'isNew': serializer.toJson<bool>(isNew),
    };
  }

  NewProductsEntityData copyWith(
          {String? id,
          String? title,
          String? province,
          double? price,
          Value<Uint8List?> image = const Value.absent(),
          bool? isNew}) =>
      NewProductsEntityData(
        id: id ?? this.id,
        title: title ?? this.title,
        province: province ?? this.province,
        price: price ?? this.price,
        image: image.present ? image.value : this.image,
        isNew: isNew ?? this.isNew,
      );
  @override
  String toString() {
    return (StringBuffer('NewProductsEntityData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('province: $province, ')
          ..write('price: $price, ')
          ..write('image: $image, ')
          ..write('isNew: $isNew')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, title, province, price, $driftBlobEquality.hash(image), isNew);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NewProductsEntityData &&
          other.id == this.id &&
          other.title == this.title &&
          other.province == this.province &&
          other.price == this.price &&
          $driftBlobEquality.equals(other.image, this.image) &&
          other.isNew == this.isNew);
}

class NewProductsEntityCompanion
    extends UpdateCompanion<NewProductsEntityData> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> province;
  final Value<double> price;
  final Value<Uint8List?> image;
  final Value<bool> isNew;
  final Value<int> rowid;
  const NewProductsEntityCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.province = const Value.absent(),
    this.price = const Value.absent(),
    this.image = const Value.absent(),
    this.isNew = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NewProductsEntityCompanion.insert({
    required String id,
    required String title,
    required String province,
    required double price,
    this.image = const Value.absent(),
    required bool isNew,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        province = Value(province),
        price = Value(price),
        isNew = Value(isNew);
  static Insertable<NewProductsEntityData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? province,
    Expression<double>? price,
    Expression<Uint8List>? image,
    Expression<bool>? isNew,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (province != null) 'province': province,
      if (price != null) 'price': price,
      if (image != null) 'image': image,
      if (isNew != null) 'is_new': isNew,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NewProductsEntityCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? province,
      Value<double>? price,
      Value<Uint8List?>? image,
      Value<bool>? isNew,
      Value<int>? rowid}) {
    return NewProductsEntityCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      province: province ?? this.province,
      price: price ?? this.price,
      image: image ?? this.image,
      isNew: isNew ?? this.isNew,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (province.present) {
      map['province'] = Variable<String>(province.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (image.present) {
      map['image'] = Variable<Uint8List>(image.value);
    }
    if (isNew.present) {
      map['is_new'] = Variable<bool>(isNew.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NewProductsEntityCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('province: $province, ')
          ..write('price: $price, ')
          ..write('image: $image, ')
          ..write('isNew: $isNew, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$DatabaseApp extends GeneratedDatabase {
  _$DatabaseApp(QueryExecutor e) : super(e);
  late final $NewProductsEntityTable newProductsEntity =
      $NewProductsEntityTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [newProductsEntity];
}
