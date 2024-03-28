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

class $OrderEntityTable extends OrderEntity
    with TableInfo<$OrderEntityTable, OrderEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrderEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
      'product_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdOrderTimeMeta =
      const VerificationMeta('createdOrderTime');
  @override
  late final GeneratedColumn<int> createdOrderTime = GeneratedColumn<int>(
      'created_order_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, productId, createdOrderTime, status];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'order_entity';
  @override
  VerificationContext validateIntegrity(Insertable<OrderEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('created_order_time')) {
      context.handle(
          _createdOrderTimeMeta,
          createdOrderTime.isAcceptableOrUnknown(
              data['created_order_time']!, _createdOrderTimeMeta));
    } else if (isInserting) {
      context.missing(_createdOrderTimeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrderEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrderEntityData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_id'])!,
      createdOrderTime: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}created_order_time'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
    );
  }

  @override
  $OrderEntityTable createAlias(String alias) {
    return $OrderEntityTable(attachedDatabase, alias);
  }
}

class OrderEntityData extends DataClass implements Insertable<OrderEntityData> {
  final String id;
  final String productId;
  final int createdOrderTime;
  final String status;
  const OrderEntityData(
      {required this.id,
      required this.productId,
      required this.createdOrderTime,
      required this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['product_id'] = Variable<String>(productId);
    map['created_order_time'] = Variable<int>(createdOrderTime);
    map['status'] = Variable<String>(status);
    return map;
  }

  OrderEntityCompanion toCompanion(bool nullToAbsent) {
    return OrderEntityCompanion(
      id: Value(id),
      productId: Value(productId),
      createdOrderTime: Value(createdOrderTime),
      status: Value(status),
    );
  }

  factory OrderEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrderEntityData(
      id: serializer.fromJson<String>(json['id']),
      productId: serializer.fromJson<String>(json['productId']),
      createdOrderTime: serializer.fromJson<int>(json['createdOrderTime']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'productId': serializer.toJson<String>(productId),
      'createdOrderTime': serializer.toJson<int>(createdOrderTime),
      'status': serializer.toJson<String>(status),
    };
  }

  OrderEntityData copyWith(
          {String? id,
          String? productId,
          int? createdOrderTime,
          String? status}) =>
      OrderEntityData(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        createdOrderTime: createdOrderTime ?? this.createdOrderTime,
        status: status ?? this.status,
      );
  @override
  String toString() {
    return (StringBuffer('OrderEntityData(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('createdOrderTime: $createdOrderTime, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, productId, createdOrderTime, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderEntityData &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.createdOrderTime == this.createdOrderTime &&
          other.status == this.status);
}

class OrderEntityCompanion extends UpdateCompanion<OrderEntityData> {
  final Value<String> id;
  final Value<String> productId;
  final Value<int> createdOrderTime;
  final Value<String> status;
  final Value<int> rowid;
  const OrderEntityCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.createdOrderTime = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrderEntityCompanion.insert({
    required String id,
    required String productId,
    required int createdOrderTime,
    required String status,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        productId = Value(productId),
        createdOrderTime = Value(createdOrderTime),
        status = Value(status);
  static Insertable<OrderEntityData> custom({
    Expression<String>? id,
    Expression<String>? productId,
    Expression<int>? createdOrderTime,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (createdOrderTime != null) 'created_order_time': createdOrderTime,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrderEntityCompanion copyWith(
      {Value<String>? id,
      Value<String>? productId,
      Value<int>? createdOrderTime,
      Value<String>? status,
      Value<int>? rowid}) {
    return OrderEntityCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      createdOrderTime: createdOrderTime ?? this.createdOrderTime,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (createdOrderTime.present) {
      map['created_order_time'] = Variable<int>(createdOrderTime.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrderEntityCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('createdOrderTime: $createdOrderTime, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CartEntityTable extends CartEntity
    with TableInfo<$CartEntityTable, CartEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CartEntityTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'cart_entity';
  @override
  VerificationContext validateIntegrity(Insertable<CartEntityData> instance,
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
  CartEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CartEntityData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
    );
  }

  @override
  $CartEntityTable createAlias(String alias) {
    return $CartEntityTable(attachedDatabase, alias);
  }
}

class CartEntityData extends DataClass implements Insertable<CartEntityData> {
  final String id;
  const CartEntityData({required this.id});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    return map;
  }

  CartEntityCompanion toCompanion(bool nullToAbsent) {
    return CartEntityCompanion(
      id: Value(id),
    );
  }

  factory CartEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CartEntityData(
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

  CartEntityData copyWith({String? id}) => CartEntityData(
        id: id ?? this.id,
      );
  @override
  String toString() {
    return (StringBuffer('CartEntityData(')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => id.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CartEntityData && other.id == this.id);
}

class CartEntityCompanion extends UpdateCompanion<CartEntityData> {
  final Value<String> id;
  final Value<int> rowid;
  const CartEntityCompanion({
    this.id = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CartEntityCompanion.insert({
    required String id,
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<CartEntityData> custom({
    Expression<String>? id,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CartEntityCompanion copyWith({Value<String>? id, Value<int>? rowid}) {
    return CartEntityCompanion(
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
    return (StringBuffer('CartEntityCompanion(')
          ..write('id: $id, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecentlyViewedEntityTable extends RecentlyViewedEntity
    with TableInfo<$RecentlyViewedEntityTable, RecentlyViewedEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecentlyViewedEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<Uint8List> image = GeneratedColumn<Uint8List>(
      'image', aliasedName, false,
      type: DriftSqlType.blob, requiredDuringInsert: true);
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<int> time = GeneratedColumn<int>(
      'time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, image, time];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recently_viewed_entity';
  @override
  VerificationContext validateIntegrity(
      Insertable<RecentlyViewedEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecentlyViewedEntityData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecentlyViewedEntityData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}image'])!,
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}time'])!,
    );
  }

  @override
  $RecentlyViewedEntityTable createAlias(String alias) {
    return $RecentlyViewedEntityTable(attachedDatabase, alias);
  }
}

class RecentlyViewedEntityData extends DataClass
    implements Insertable<RecentlyViewedEntityData> {
  final String id;
  final Uint8List image;
  final int time;
  const RecentlyViewedEntityData(
      {required this.id, required this.image, required this.time});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['image'] = Variable<Uint8List>(image);
    map['time'] = Variable<int>(time);
    return map;
  }

  RecentlyViewedEntityCompanion toCompanion(bool nullToAbsent) {
    return RecentlyViewedEntityCompanion(
      id: Value(id),
      image: Value(image),
      time: Value(time),
    );
  }

  factory RecentlyViewedEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecentlyViewedEntityData(
      id: serializer.fromJson<String>(json['id']),
      image: serializer.fromJson<Uint8List>(json['image']),
      time: serializer.fromJson<int>(json['time']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'image': serializer.toJson<Uint8List>(image),
      'time': serializer.toJson<int>(time),
    };
  }

  RecentlyViewedEntityData copyWith(
          {String? id, Uint8List? image, int? time}) =>
      RecentlyViewedEntityData(
        id: id ?? this.id,
        image: image ?? this.image,
        time: time ?? this.time,
      );
  @override
  String toString() {
    return (StringBuffer('RecentlyViewedEntityData(')
          ..write('id: $id, ')
          ..write('image: $image, ')
          ..write('time: $time')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, $driftBlobEquality.hash(image), time);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecentlyViewedEntityData &&
          other.id == this.id &&
          $driftBlobEquality.equals(other.image, this.image) &&
          other.time == this.time);
}

class RecentlyViewedEntityCompanion
    extends UpdateCompanion<RecentlyViewedEntityData> {
  final Value<String> id;
  final Value<Uint8List> image;
  final Value<int> time;
  final Value<int> rowid;
  const RecentlyViewedEntityCompanion({
    this.id = const Value.absent(),
    this.image = const Value.absent(),
    this.time = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecentlyViewedEntityCompanion.insert({
    required String id,
    required Uint8List image,
    required int time,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        image = Value(image),
        time = Value(time);
  static Insertable<RecentlyViewedEntityData> custom({
    Expression<String>? id,
    Expression<Uint8List>? image,
    Expression<int>? time,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (image != null) 'image': image,
      if (time != null) 'time': time,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecentlyViewedEntityCompanion copyWith(
      {Value<String>? id,
      Value<Uint8List>? image,
      Value<int>? time,
      Value<int>? rowid}) {
    return RecentlyViewedEntityCompanion(
      id: id ?? this.id,
      image: image ?? this.image,
      time: time ?? this.time,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (image.present) {
      map['image'] = Variable<Uint8List>(image.value);
    }
    if (time.present) {
      map['time'] = Variable<int>(time.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecentlyViewedEntityCompanion(')
          ..write('id: $id, ')
          ..write('image: $image, ')
          ..write('time: $time, ')
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
  late final $OrderEntityTable orderEntity = $OrderEntityTable(this);
  late final $CartEntityTable cartEntity = $CartEntityTable(this);
  late final $RecentlyViewedEntityTable recentlyViewedEntity =
      $RecentlyViewedEntityTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        newProductsEntity,
        mostViewProductsEntity,
        wishlistProductsEntity,
        productsEntity,
        orderEntity,
        cartEntity,
        recentlyViewedEntity
      ];
}
