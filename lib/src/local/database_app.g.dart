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
  @override
  List<GeneratedColumn> get $columns => [id];
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
  const NewProductsEntityData({required this.id});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    return map;
  }

  NewProductsEntityCompanion toCompanion(bool nullToAbsent) {
    return NewProductsEntityCompanion(
      id: Value(id),
    );
  }

  factory NewProductsEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NewProductsEntityData(
      id: serializer.fromJson<String>(json['id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
    };
  }

  NewProductsEntityData copyWith({String? id}) => NewProductsEntityData(
        id: id ?? this.id,
      );
  @override
  String toString() {
    return (StringBuffer('NewProductsEntityData(')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => id.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NewProductsEntityData && other.id == this.id);
}

class NewProductsEntityCompanion
    extends UpdateCompanion<NewProductsEntityData> {
  final Value<String> id;
  final Value<int> rowid;
  const NewProductsEntityCompanion({
    this.id = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NewProductsEntityCompanion.insert({
    required String id,
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<NewProductsEntityData> custom({
    Expression<String>? id,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NewProductsEntityCompanion copyWith({Value<String>? id, Value<int>? rowid}) {
    return NewProductsEntityCompanion(
      id: id ?? this.id,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
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
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MostViewProductsEntityTable extends MostViewProductsEntity
    with TableInfo<$MostViewProductsEntityTable, MostViewProductsEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MostViewProductsEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'most_view_products_entity';
  @override
  VerificationContext validateIntegrity(
      Insertable<MostViewProductsEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MostViewProductsEntityData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MostViewProductsEntityData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
    );
  }

  @override
  $MostViewProductsEntityTable createAlias(String alias) {
    return $MostViewProductsEntityTable(attachedDatabase, alias);
  }
}

class MostViewProductsEntityData extends DataClass
    implements Insertable<MostViewProductsEntityData> {
  final String id;
  const MostViewProductsEntityData({required this.id});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    return map;
  }

  MostViewProductsEntityCompanion toCompanion(bool nullToAbsent) {
    return MostViewProductsEntityCompanion(
      id: Value(id),
    );
  }

  factory MostViewProductsEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MostViewProductsEntityData(
      id: serializer.fromJson<String>(json['id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
    };
  }

  MostViewProductsEntityData copyWith({String? id}) =>
      MostViewProductsEntityData(
        id: id ?? this.id,
      );
  @override
  String toString() {
    return (StringBuffer('MostViewProductsEntityData(')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => id.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MostViewProductsEntityData && other.id == this.id);
}

class MostViewProductsEntityCompanion
    extends UpdateCompanion<MostViewProductsEntityData> {
  final Value<String> id;
  final Value<int> rowid;
  const MostViewProductsEntityCompanion({
    this.id = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MostViewProductsEntityCompanion.insert({
    required String id,
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<MostViewProductsEntityData> custom({
    Expression<String>? id,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MostViewProductsEntityCompanion copyWith(
      {Value<String>? id, Value<int>? rowid}) {
    return MostViewProductsEntityCompanion(
      id: id ?? this.id,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MostViewProductsEntityCompanion(')
          ..write('id: $id, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WishlistProductsEntityTable extends WishlistProductsEntity
    with TableInfo<$WishlistProductsEntityTable, WishlistProductsEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WishlistProductsEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wishlist_products_entity';
  @override
  VerificationContext validateIntegrity(
      Insertable<WishlistProductsEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WishlistProductsEntityData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WishlistProductsEntityData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
    );
  }

  @override
  $WishlistProductsEntityTable createAlias(String alias) {
    return $WishlistProductsEntityTable(attachedDatabase, alias);
  }
}

class WishlistProductsEntityData extends DataClass
    implements Insertable<WishlistProductsEntityData> {
  final String id;
  const WishlistProductsEntityData({required this.id});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    return map;
  }

  WishlistProductsEntityCompanion toCompanion(bool nullToAbsent) {
    return WishlistProductsEntityCompanion(
      id: Value(id),
    );
  }

  factory WishlistProductsEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WishlistProductsEntityData(
      id: serializer.fromJson<String>(json['id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
    };
  }

  WishlistProductsEntityData copyWith({String? id}) =>
      WishlistProductsEntityData(
        id: id ?? this.id,
      );
  @override
  String toString() {
    return (StringBuffer('WishlistProductsEntityData(')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => id.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WishlistProductsEntityData && other.id == this.id);
}

class WishlistProductsEntityCompanion
    extends UpdateCompanion<WishlistProductsEntityData> {
  final Value<String> id;
  final Value<int> rowid;
  const WishlistProductsEntityCompanion({
    this.id = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WishlistProductsEntityCompanion.insert({
    required String id,
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<WishlistProductsEntityData> custom({
    Expression<String>? id,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WishlistProductsEntityCompanion copyWith(
      {Value<String>? id, Value<int>? rowid}) {
    return WishlistProductsEntityCompanion(
      id: id ?? this.id,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WishlistProductsEntityCompanion(')
          ..write('id: $id, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductsEntityTable extends ProductsEntity
    with TableInfo<$ProductsEntityTable, ProductsEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsEntityTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _ownerMeta = const VerificationMeta('owner');
  @override
  late final GeneratedColumn<String> owner = GeneratedColumn<String>(
      'owner', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
      'time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _viewedMeta = const VerificationMeta('viewed');
  @override
  late final GeneratedColumn<int> viewed = GeneratedColumn<int>(
      'viewed', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, province, price, image, owner, time, viewed];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products_entity';
  @override
  VerificationContext validateIntegrity(Insertable<ProductsEntityData> instance,
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
    if (data.containsKey('owner')) {
      context.handle(
          _ownerMeta, owner.isAcceptableOrUnknown(data['owner']!, _ownerMeta));
    } else if (isInserting) {
      context.missing(_ownerMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    }
    if (data.containsKey('viewed')) {
      context.handle(_viewedMeta,
          viewed.isAcceptableOrUnknown(data['viewed']!, _viewedMeta));
    } else if (isInserting) {
      context.missing(_viewedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductsEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductsEntityData(
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
      owner: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}owner'])!,
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time']),
      viewed: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}viewed'])!,
    );
  }

  @override
  $ProductsEntityTable createAlias(String alias) {
    return $ProductsEntityTable(attachedDatabase, alias);
  }
}

class ProductsEntityData extends DataClass
    implements Insertable<ProductsEntityData> {
  final String id;
  final String title;
  final String province;
  final double price;
  final Uint8List? image;
  final String owner;
  final DateTime? time;
  final int viewed;
  const ProductsEntityData(
      {required this.id,
      required this.title,
      required this.province,
      required this.price,
      this.image,
      required this.owner,
      this.time,
      required this.viewed});
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
    map['owner'] = Variable<String>(owner);
    if (!nullToAbsent || time != null) {
      map['time'] = Variable<DateTime>(time);
    }
    map['viewed'] = Variable<int>(viewed);
    return map;
  }

  ProductsEntityCompanion toCompanion(bool nullToAbsent) {
    return ProductsEntityCompanion(
      id: Value(id),
      title: Value(title),
      province: Value(province),
      price: Value(price),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
      owner: Value(owner),
      time: time == null && nullToAbsent ? const Value.absent() : Value(time),
      viewed: Value(viewed),
    );
  }

  factory ProductsEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductsEntityData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      province: serializer.fromJson<String>(json['province']),
      price: serializer.fromJson<double>(json['price']),
      image: serializer.fromJson<Uint8List?>(json['image']),
      owner: serializer.fromJson<String>(json['owner']),
      time: serializer.fromJson<DateTime?>(json['time']),
      viewed: serializer.fromJson<int>(json['viewed']),
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
      'owner': serializer.toJson<String>(owner),
      'time': serializer.toJson<DateTime?>(time),
      'viewed': serializer.toJson<int>(viewed),
    };
  }

  ProductsEntityData copyWith(
          {String? id,
          String? title,
          String? province,
          double? price,
          Value<Uint8List?> image = const Value.absent(),
          String? owner,
          Value<DateTime?> time = const Value.absent(),
          int? viewed}) =>
      ProductsEntityData(
        id: id ?? this.id,
        title: title ?? this.title,
        province: province ?? this.province,
        price: price ?? this.price,
        image: image.present ? image.value : this.image,
        owner: owner ?? this.owner,
        time: time.present ? time.value : this.time,
        viewed: viewed ?? this.viewed,
      );
  @override
  String toString() {
    return (StringBuffer('ProductsEntityData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('province: $province, ')
          ..write('price: $price, ')
          ..write('image: $image, ')
          ..write('owner: $owner, ')
          ..write('time: $time, ')
          ..write('viewed: $viewed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, province, price,
      $driftBlobEquality.hash(image), owner, time, viewed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductsEntityData &&
          other.id == this.id &&
          other.title == this.title &&
          other.province == this.province &&
          other.price == this.price &&
          $driftBlobEquality.equals(other.image, this.image) &&
          other.owner == this.owner &&
          other.time == this.time &&
          other.viewed == this.viewed);
}

class ProductsEntityCompanion extends UpdateCompanion<ProductsEntityData> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> province;
  final Value<double> price;
  final Value<Uint8List?> image;
  final Value<String> owner;
  final Value<DateTime?> time;
  final Value<int> viewed;
  final Value<int> rowid;
  const ProductsEntityCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.province = const Value.absent(),
    this.price = const Value.absent(),
    this.image = const Value.absent(),
    this.owner = const Value.absent(),
    this.time = const Value.absent(),
    this.viewed = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductsEntityCompanion.insert({
    required String id,
    required String title,
    required String province,
    required double price,
    this.image = const Value.absent(),
    required String owner,
    this.time = const Value.absent(),
    required int viewed,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        province = Value(province),
        price = Value(price),
        owner = Value(owner),
        viewed = Value(viewed);
  static Insertable<ProductsEntityData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? province,
    Expression<double>? price,
    Expression<Uint8List>? image,
    Expression<String>? owner,
    Expression<DateTime>? time,
    Expression<int>? viewed,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (province != null) 'province': province,
      if (price != null) 'price': price,
      if (image != null) 'image': image,
      if (owner != null) 'owner': owner,
      if (time != null) 'time': time,
      if (viewed != null) 'viewed': viewed,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductsEntityCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? province,
      Value<double>? price,
      Value<Uint8List?>? image,
      Value<String>? owner,
      Value<DateTime?>? time,
      Value<int>? viewed,
      Value<int>? rowid}) {
    return ProductsEntityCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      province: province ?? this.province,
      price: price ?? this.price,
      image: image ?? this.image,
      owner: owner ?? this.owner,
      time: time ?? this.time,
      viewed: viewed ?? this.viewed,
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
    if (owner.present) {
      map['owner'] = Variable<String>(owner.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    if (viewed.present) {
      map['viewed'] = Variable<int>(viewed.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsEntityCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('province: $province, ')
          ..write('price: $price, ')
          ..write('image: $image, ')
          ..write('owner: $owner, ')
          ..write('time: $time, ')
          ..write('viewed: $viewed, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$DatabaseApp extends GeneratedDatabase {
  _$DatabaseApp(QueryExecutor e) : super(e);
  late final $NewProductsEntityTable newProductsEntity =
      $NewProductsEntityTable(this);
  late final $MostViewProductsEntityTable mostViewProductsEntity =
      $MostViewProductsEntityTable(this);
  late final $WishlistProductsEntityTable wishlistProductsEntity =
      $WishlistProductsEntityTable(this);
  late final $ProductsEntityTable productsEntity = $ProductsEntityTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        newProductsEntity,
        mostViewProductsEntity,
        wishlistProductsEntity,
        productsEntity
      ];
}
