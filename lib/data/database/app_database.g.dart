// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _passwordMeta = const VerificationMeta(
    'password',
  );
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
    'password',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    email,
    password,
    role,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('password')) {
      context.handle(
        _passwordMeta,
        password.isAcceptableOrUnknown(data['password']!, _passwordMeta),
      );
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      password: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String name;
  final String email;
  final String password;
  final String role;
  final DateTime createdAt;
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    map['password'] = Variable<String>(password);
    map['role'] = Variable<String>(role);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      name: Value(name),
      email: Value(email),
      password: Value(password),
      role: Value(role),
      createdAt: Value(createdAt),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      password: serializer.fromJson<String>(json['password']),
      role: serializer.fromJson<String>(json['role']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'password': serializer.toJson<String>(password),
      'role': serializer.toJson<String>(role),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? password,
    String? role,
    DateTime? createdAt,
  }) => User(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
    password: password ?? this.password,
    role: role ?? this.role,
    createdAt: createdAt ?? this.createdAt,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      password: data.password.present ? data.password.value : this.password,
      role: data.role.present ? data.role.value : this.role,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('password: $password, ')
          ..write('role: $role, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, email, password, role, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.password == this.password &&
          other.role == this.role &&
          other.createdAt == this.createdAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> email;
  final Value<String> password;
  final Value<String> role;
  final Value<DateTime> createdAt;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.password = const Value.absent(),
    this.role = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String email,
    required String password,
    required String role,
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       email = Value(email),
       password = Value(password),
       role = Value(role);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? password,
    Expression<String>? role,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (role != null) 'role': role,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? email,
    Value<String>? password,
    Value<String>? role,
    Value<DateTime>? createdAt,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('password: $password, ')
          ..write('role: $role, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _pricingTypeMeta = const VerificationMeta(
    'pricingType',
  );
  @override
  late final GeneratedColumn<String> pricingType = GeneratedColumn<String>(
    'pricing_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    pricingType,
    unit,
    isActive,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Category> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('pricing_type')) {
      context.handle(
        _pricingTypeMeta,
        pricingType.isAcceptableOrUnknown(
          data['pricing_type']!,
          _pricingTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pricingTypeMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      pricingType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pricing_type'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final int id;
  final String name;
  final String pricingType;
  final String unit;
  final bool isActive;
  final DateTime createdAt;
  const Category({
    required this.id,
    required this.name,
    required this.pricingType,
    required this.unit,
    required this.isActive,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['pricing_type'] = Variable<String>(pricingType);
    map['unit'] = Variable<String>(unit);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      pricingType: Value(pricingType),
      unit: Value(unit),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      pricingType: serializer.fromJson<String>(json['pricingType']),
      unit: serializer.fromJson<String>(json['unit']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'pricingType': serializer.toJson<String>(pricingType),
      'unit': serializer.toJson<String>(unit),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Category copyWith({
    int? id,
    String? name,
    String? pricingType,
    String? unit,
    bool? isActive,
    DateTime? createdAt,
  }) => Category(
    id: id ?? this.id,
    name: name ?? this.name,
    pricingType: pricingType ?? this.pricingType,
    unit: unit ?? this.unit,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
  );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      pricingType: data.pricingType.present
          ? data.pricingType.value
          : this.pricingType,
      unit: data.unit.present ? data.unit.value : this.unit,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('pricingType: $pricingType, ')
          ..write('unit: $unit, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, pricingType, unit, isActive, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.name == this.name &&
          other.pricingType == this.pricingType &&
          other.unit == this.unit &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> pricingType;
  final Value<String> unit;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.pricingType = const Value.absent(),
    this.unit = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String pricingType,
    required String unit,
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       pricingType = Value(pricingType),
       unit = Value(unit);
  static Insertable<Category> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? pricingType,
    Expression<String>? unit,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (pricingType != null) 'pricing_type': pricingType,
      if (unit != null) 'unit': unit,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CategoriesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? pricingType,
    Value<String>? unit,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      pricingType: pricingType ?? this.pricingType,
      unit: unit ?? this.unit,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (pricingType.present) {
      map['pricing_type'] = Variable<String>(pricingType.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('pricingType: $pricingType, ')
          ..write('unit: $unit, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
    'sku',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _barcodeMeta = const VerificationMeta(
    'barcode',
  );
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _purchasePriceMeta = const VerificationMeta(
    'purchasePrice',
  );
  @override
  late final GeneratedColumn<double> purchasePrice = GeneratedColumn<double>(
    'purchase_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sellingPriceMeta = const VerificationMeta(
    'sellingPrice',
  );
  @override
  late final GeneratedColumn<double> sellingPrice = GeneratedColumn<double>(
    'selling_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stockQtyMeta = const VerificationMeta(
    'stockQty',
  );
  @override
  late final GeneratedColumn<int> stockQty = GeneratedColumn<int>(
    'stock_qty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _minStockMeta = const VerificationMeta(
    'minStock',
  );
  @override
  late final GeneratedColumn<int> minStock = GeneratedColumn<int>(
    'min_stock',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    categoryId,
    name,
    sku,
    barcode,
    purchasePrice,
    sellingPrice,
    stockQty,
    minStock,
    imagePath,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<Product> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sku')) {
      context.handle(
        _skuMeta,
        sku.isAcceptableOrUnknown(data['sku']!, _skuMeta),
      );
    }
    if (data.containsKey('barcode')) {
      context.handle(
        _barcodeMeta,
        barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta),
      );
    }
    if (data.containsKey('purchase_price')) {
      context.handle(
        _purchasePriceMeta,
        purchasePrice.isAcceptableOrUnknown(
          data['purchase_price']!,
          _purchasePriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchasePriceMeta);
    }
    if (data.containsKey('selling_price')) {
      context.handle(
        _sellingPriceMeta,
        sellingPrice.isAcceptableOrUnknown(
          data['selling_price']!,
          _sellingPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sellingPriceMeta);
    }
    if (data.containsKey('stock_qty')) {
      context.handle(
        _stockQtyMeta,
        stockQty.isAcceptableOrUnknown(data['stock_qty']!, _stockQtyMeta),
      );
    } else if (isInserting) {
      context.missing(_stockQtyMeta);
    }
    if (data.containsKey('min_stock')) {
      context.handle(
        _minStockMeta,
        minStock.isAcceptableOrUnknown(data['min_stock']!, _minStockMeta),
      );
    } else if (isInserting) {
      context.missing(_minStockMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      sku: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sku'],
      ),
      barcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode'],
      ),
      purchasePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}purchase_price'],
      )!,
      sellingPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}selling_price'],
      )!,
      stockQty: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stock_qty'],
      )!,
      minStock: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_stock'],
      )!,
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final int id;
  final int categoryId;
  final String name;
  final String? sku;
  final String? barcode;
  final double purchasePrice;
  final double sellingPrice;
  final int stockQty;
  final int minStock;
  final String? imagePath;
  final DateTime createdAt;
  const Product({
    required this.id,
    required this.categoryId,
    required this.name,
    this.sku,
    this.barcode,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.stockQty,
    required this.minStock,
    this.imagePath,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category_id'] = Variable<int>(categoryId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || sku != null) {
      map['sku'] = Variable<String>(sku);
    }
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    map['purchase_price'] = Variable<double>(purchasePrice);
    map['selling_price'] = Variable<double>(sellingPrice);
    map['stock_qty'] = Variable<int>(stockQty);
    map['min_stock'] = Variable<int>(minStock);
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      categoryId: Value(categoryId),
      name: Value(name),
      sku: sku == null && nullToAbsent ? const Value.absent() : Value(sku),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      purchasePrice: Value(purchasePrice),
      sellingPrice: Value(sellingPrice),
      stockQty: Value(stockQty),
      minStock: Value(minStock),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      createdAt: Value(createdAt),
    );
  }

  factory Product.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<int>(json['id']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      name: serializer.fromJson<String>(json['name']),
      sku: serializer.fromJson<String?>(json['sku']),
      barcode: serializer.fromJson<String?>(json['barcode']),
      purchasePrice: serializer.fromJson<double>(json['purchasePrice']),
      sellingPrice: serializer.fromJson<double>(json['sellingPrice']),
      stockQty: serializer.fromJson<int>(json['stockQty']),
      minStock: serializer.fromJson<int>(json['minStock']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'categoryId': serializer.toJson<int>(categoryId),
      'name': serializer.toJson<String>(name),
      'sku': serializer.toJson<String?>(sku),
      'barcode': serializer.toJson<String?>(barcode),
      'purchasePrice': serializer.toJson<double>(purchasePrice),
      'sellingPrice': serializer.toJson<double>(sellingPrice),
      'stockQty': serializer.toJson<int>(stockQty),
      'minStock': serializer.toJson<int>(minStock),
      'imagePath': serializer.toJson<String?>(imagePath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Product copyWith({
    int? id,
    int? categoryId,
    String? name,
    Value<String?> sku = const Value.absent(),
    Value<String?> barcode = const Value.absent(),
    double? purchasePrice,
    double? sellingPrice,
    int? stockQty,
    int? minStock,
    Value<String?> imagePath = const Value.absent(),
    DateTime? createdAt,
  }) => Product(
    id: id ?? this.id,
    categoryId: categoryId ?? this.categoryId,
    name: name ?? this.name,
    sku: sku.present ? sku.value : this.sku,
    barcode: barcode.present ? barcode.value : this.barcode,
    purchasePrice: purchasePrice ?? this.purchasePrice,
    sellingPrice: sellingPrice ?? this.sellingPrice,
    stockQty: stockQty ?? this.stockQty,
    minStock: minStock ?? this.minStock,
    imagePath: imagePath.present ? imagePath.value : this.imagePath,
    createdAt: createdAt ?? this.createdAt,
  );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      id: data.id.present ? data.id.value : this.id,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      name: data.name.present ? data.name.value : this.name,
      sku: data.sku.present ? data.sku.value : this.sku,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      purchasePrice: data.purchasePrice.present
          ? data.purchasePrice.value
          : this.purchasePrice,
      sellingPrice: data.sellingPrice.present
          ? data.sellingPrice.value
          : this.sellingPrice,
      stockQty: data.stockQty.present ? data.stockQty.value : this.stockQty,
      minStock: data.minStock.present ? data.minStock.value : this.minStock,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('name: $name, ')
          ..write('sku: $sku, ')
          ..write('barcode: $barcode, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('sellingPrice: $sellingPrice, ')
          ..write('stockQty: $stockQty, ')
          ..write('minStock: $minStock, ')
          ..write('imagePath: $imagePath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    categoryId,
    name,
    sku,
    barcode,
    purchasePrice,
    sellingPrice,
    stockQty,
    minStock,
    imagePath,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.name == this.name &&
          other.sku == this.sku &&
          other.barcode == this.barcode &&
          other.purchasePrice == this.purchasePrice &&
          other.sellingPrice == this.sellingPrice &&
          other.stockQty == this.stockQty &&
          other.minStock == this.minStock &&
          other.imagePath == this.imagePath &&
          other.createdAt == this.createdAt);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<int> id;
  final Value<int> categoryId;
  final Value<String> name;
  final Value<String?> sku;
  final Value<String?> barcode;
  final Value<double> purchasePrice;
  final Value<double> sellingPrice;
  final Value<int> stockQty;
  final Value<int> minStock;
  final Value<String?> imagePath;
  final Value<DateTime> createdAt;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.name = const Value.absent(),
    this.sku = const Value.absent(),
    this.barcode = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.sellingPrice = const Value.absent(),
    this.stockQty = const Value.absent(),
    this.minStock = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    required int categoryId,
    required String name,
    this.sku = const Value.absent(),
    this.barcode = const Value.absent(),
    required double purchasePrice,
    required double sellingPrice,
    required int stockQty,
    required int minStock,
    this.imagePath = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : categoryId = Value(categoryId),
       name = Value(name),
       purchasePrice = Value(purchasePrice),
       sellingPrice = Value(sellingPrice),
       stockQty = Value(stockQty),
       minStock = Value(minStock);
  static Insertable<Product> custom({
    Expression<int>? id,
    Expression<int>? categoryId,
    Expression<String>? name,
    Expression<String>? sku,
    Expression<String>? barcode,
    Expression<double>? purchasePrice,
    Expression<double>? sellingPrice,
    Expression<int>? stockQty,
    Expression<int>? minStock,
    Expression<String>? imagePath,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (name != null) 'name': name,
      if (sku != null) 'sku': sku,
      if (barcode != null) 'barcode': barcode,
      if (purchasePrice != null) 'purchase_price': purchasePrice,
      if (sellingPrice != null) 'selling_price': sellingPrice,
      if (stockQty != null) 'stock_qty': stockQty,
      if (minStock != null) 'min_stock': minStock,
      if (imagePath != null) 'image_path': imagePath,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ProductsCompanion copyWith({
    Value<int>? id,
    Value<int>? categoryId,
    Value<String>? name,
    Value<String?>? sku,
    Value<String?>? barcode,
    Value<double>? purchasePrice,
    Value<double>? sellingPrice,
    Value<int>? stockQty,
    Value<int>? minStock,
    Value<String?>? imagePath,
    Value<DateTime>? createdAt,
  }) {
    return ProductsCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      sku: sku ?? this.sku,
      barcode: barcode ?? this.barcode,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      stockQty: stockQty ?? this.stockQty,
      minStock: minStock ?? this.minStock,
      imagePath: imagePath ?? this.imagePath,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (purchasePrice.present) {
      map['purchase_price'] = Variable<double>(purchasePrice.value);
    }
    if (sellingPrice.present) {
      map['selling_price'] = Variable<double>(sellingPrice.value);
    }
    if (stockQty.present) {
      map['stock_qty'] = Variable<int>(stockQty.value);
    }
    if (minStock.present) {
      map['min_stock'] = Variable<int>(minStock.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('name: $name, ')
          ..write('sku: $sku, ')
          ..write('barcode: $barcode, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('sellingPrice: $sellingPrice, ')
          ..write('stockQty: $stockQty, ')
          ..write('minStock: $minStock, ')
          ..write('imagePath: $imagePath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, Customer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _creditBalanceMeta = const VerificationMeta(
    'creditBalance',
  );
  @override
  late final GeneratedColumn<double> creditBalance = GeneratedColumn<double>(
    'credit_balance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    phone,
    email,
    address,
    creditBalance,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Customer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('credit_balance')) {
      context.handle(
        _creditBalanceMeta,
        creditBalance.isAcceptableOrUnknown(
          data['credit_balance']!,
          _creditBalanceMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Customer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Customer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      creditBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}credit_balance'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class Customer extends DataClass implements Insertable<Customer> {
  final int id;
  final String name;
  final String phone;
  final String? email;
  final String? address;
  final double creditBalance;
  final DateTime createdAt;
  const Customer({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    this.address,
    required this.creditBalance,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['phone'] = Variable<String>(phone);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    map['credit_balance'] = Variable<double>(creditBalance);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      name: Value(name),
      phone: Value(phone),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      creditBalance: Value(creditBalance),
      createdAt: Value(createdAt),
    );
  }

  factory Customer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Customer(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      address: serializer.fromJson<String?>(json['address']),
      creditBalance: serializer.fromJson<double>(json['creditBalance']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String>(phone),
      'email': serializer.toJson<String?>(email),
      'address': serializer.toJson<String?>(address),
      'creditBalance': serializer.toJson<double>(creditBalance),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Customer copyWith({
    int? id,
    String? name,
    String? phone,
    Value<String?> email = const Value.absent(),
    Value<String?> address = const Value.absent(),
    double? creditBalance,
    DateTime? createdAt,
  }) => Customer(
    id: id ?? this.id,
    name: name ?? this.name,
    phone: phone ?? this.phone,
    email: email.present ? email.value : this.email,
    address: address.present ? address.value : this.address,
    creditBalance: creditBalance ?? this.creditBalance,
    createdAt: createdAt ?? this.createdAt,
  );
  Customer copyWithCompanion(CustomersCompanion data) {
    return Customer(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      address: data.address.present ? data.address.value : this.address,
      creditBalance: data.creditBalance.present
          ? data.creditBalance.value
          : this.creditBalance,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('creditBalance: $creditBalance, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, phone, email, address, creditBalance, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.address == this.address &&
          other.creditBalance == this.creditBalance &&
          other.createdAt == this.createdAt);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> phone;
  final Value<String?> email;
  final Value<String?> address;
  final Value<double> creditBalance;
  final Value<DateTime> createdAt;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.creditBalance = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CustomersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String phone,
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.creditBalance = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       phone = Value(phone);
  static Insertable<Customer> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? address,
    Expression<double>? creditBalance,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
      if (creditBalance != null) 'credit_balance': creditBalance,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CustomersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? phone,
    Value<String?>? email,
    Value<String?>? address,
    Value<double>? creditBalance,
    Value<DateTime>? createdAt,
  }) {
    return CustomersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      creditBalance: creditBalance ?? this.creditBalance,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (creditBalance.present) {
      map['credit_balance'] = Variable<double>(creditBalance.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('creditBalance: $creditBalance, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SuppliersTable extends Suppliers
    with TableInfo<$SuppliersTable, Supplier> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SuppliersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _creditBalanceMeta = const VerificationMeta(
    'creditBalance',
  );
  @override
  late final GeneratedColumn<double> creditBalance = GeneratedColumn<double>(
    'credit_balance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _gstNumberMeta = const VerificationMeta(
    'gstNumber',
  );
  @override
  late final GeneratedColumn<String> gstNumber = GeneratedColumn<String>(
    'gst_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    phone,
    email,
    address,
    creditBalance,
    createdAt,
    gstNumber,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'suppliers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Supplier> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('credit_balance')) {
      context.handle(
        _creditBalanceMeta,
        creditBalance.isAcceptableOrUnknown(
          data['credit_balance']!,
          _creditBalanceMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('gst_number')) {
      context.handle(
        _gstNumberMeta,
        gstNumber.isAcceptableOrUnknown(data['gst_number']!, _gstNumberMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Supplier map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Supplier(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      creditBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}credit_balance'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      gstNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gst_number'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $SuppliersTable createAlias(String alias) {
    return $SuppliersTable(attachedDatabase, alias);
  }
}

class Supplier extends DataClass implements Insertable<Supplier> {
  final int id;
  final String name;
  final String phone;
  final String? email;
  final String? address;
  final double creditBalance;
  final DateTime createdAt;
  final String? gstNumber;
  final bool isActive;
  const Supplier({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    this.address,
    required this.creditBalance,
    required this.createdAt,
    this.gstNumber,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['phone'] = Variable<String>(phone);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    map['credit_balance'] = Variable<double>(creditBalance);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || gstNumber != null) {
      map['gst_number'] = Variable<String>(gstNumber);
    }
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  SuppliersCompanion toCompanion(bool nullToAbsent) {
    return SuppliersCompanion(
      id: Value(id),
      name: Value(name),
      phone: Value(phone),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      creditBalance: Value(creditBalance),
      createdAt: Value(createdAt),
      gstNumber: gstNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(gstNumber),
      isActive: Value(isActive),
    );
  }

  factory Supplier.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Supplier(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      address: serializer.fromJson<String?>(json['address']),
      creditBalance: serializer.fromJson<double>(json['creditBalance']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      gstNumber: serializer.fromJson<String?>(json['gstNumber']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String>(phone),
      'email': serializer.toJson<String?>(email),
      'address': serializer.toJson<String?>(address),
      'creditBalance': serializer.toJson<double>(creditBalance),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'gstNumber': serializer.toJson<String?>(gstNumber),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  Supplier copyWith({
    int? id,
    String? name,
    String? phone,
    Value<String?> email = const Value.absent(),
    Value<String?> address = const Value.absent(),
    double? creditBalance,
    DateTime? createdAt,
    Value<String?> gstNumber = const Value.absent(),
    bool? isActive,
  }) => Supplier(
    id: id ?? this.id,
    name: name ?? this.name,
    phone: phone ?? this.phone,
    email: email.present ? email.value : this.email,
    address: address.present ? address.value : this.address,
    creditBalance: creditBalance ?? this.creditBalance,
    createdAt: createdAt ?? this.createdAt,
    gstNumber: gstNumber.present ? gstNumber.value : this.gstNumber,
    isActive: isActive ?? this.isActive,
  );
  Supplier copyWithCompanion(SuppliersCompanion data) {
    return Supplier(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      address: data.address.present ? data.address.value : this.address,
      creditBalance: data.creditBalance.present
          ? data.creditBalance.value
          : this.creditBalance,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      gstNumber: data.gstNumber.present ? data.gstNumber.value : this.gstNumber,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Supplier(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('creditBalance: $creditBalance, ')
          ..write('createdAt: $createdAt, ')
          ..write('gstNumber: $gstNumber, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    phone,
    email,
    address,
    creditBalance,
    createdAt,
    gstNumber,
    isActive,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Supplier &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.address == this.address &&
          other.creditBalance == this.creditBalance &&
          other.createdAt == this.createdAt &&
          other.gstNumber == this.gstNumber &&
          other.isActive == this.isActive);
}

class SuppliersCompanion extends UpdateCompanion<Supplier> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> phone;
  final Value<String?> email;
  final Value<String?> address;
  final Value<double> creditBalance;
  final Value<DateTime> createdAt;
  final Value<String?> gstNumber;
  final Value<bool> isActive;
  const SuppliersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.creditBalance = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.gstNumber = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  SuppliersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String phone,
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.creditBalance = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.gstNumber = const Value.absent(),
    this.isActive = const Value.absent(),
  }) : name = Value(name),
       phone = Value(phone);
  static Insertable<Supplier> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? address,
    Expression<double>? creditBalance,
    Expression<DateTime>? createdAt,
    Expression<String>? gstNumber,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
      if (creditBalance != null) 'credit_balance': creditBalance,
      if (createdAt != null) 'created_at': createdAt,
      if (gstNumber != null) 'gst_number': gstNumber,
      if (isActive != null) 'is_active': isActive,
    });
  }

  SuppliersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? phone,
    Value<String?>? email,
    Value<String?>? address,
    Value<double>? creditBalance,
    Value<DateTime>? createdAt,
    Value<String?>? gstNumber,
    Value<bool>? isActive,
  }) {
    return SuppliersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      creditBalance: creditBalance ?? this.creditBalance,
      createdAt: createdAt ?? this.createdAt,
      gstNumber: gstNumber ?? this.gstNumber,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (creditBalance.present) {
      map['credit_balance'] = Variable<double>(creditBalance.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (gstNumber.present) {
      map['gst_number'] = Variable<String>(gstNumber.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SuppliersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('creditBalance: $creditBalance, ')
          ..write('createdAt: $createdAt, ')
          ..write('gstNumber: $gstNumber, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class $SalesTable extends Sales with TableInfo<$SalesTable, Sale> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _invoiceNoMeta = const VerificationMeta(
    'invoiceNo',
  );
  @override
  late final GeneratedColumn<String> invoiceNo = GeneratedColumn<String>(
    'invoice_no',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountMeta = const VerificationMeta(
    'discount',
  );
  @override
  late final GeneratedColumn<double> discount = GeneratedColumn<double>(
    'discount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxMeta = const VerificationMeta('tax');
  @override
  late final GeneratedColumn<double> tax = GeneratedColumn<double>(
    'tax',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _grandTotalMeta = const VerificationMeta(
    'grandTotal',
  );
  @override
  late final GeneratedColumn<double> grandTotal = GeneratedColumn<double>(
    'grand_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentStatusMeta = const VerificationMeta(
    'paymentStatus',
  );
  @override
  late final GeneratedColumn<String> paymentStatus = GeneratedColumn<String>(
    'payment_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    customerId,
    invoiceNo,
    total,
    discount,
    tax,
    grandTotal,
    paymentStatus,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sales';
  @override
  VerificationContext validateIntegrity(
    Insertable<Sale> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('invoice_no')) {
      context.handle(
        _invoiceNoMeta,
        invoiceNo.isAcceptableOrUnknown(data['invoice_no']!, _invoiceNoMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceNoMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('discount')) {
      context.handle(
        _discountMeta,
        discount.isAcceptableOrUnknown(data['discount']!, _discountMeta),
      );
    } else if (isInserting) {
      context.missing(_discountMeta);
    }
    if (data.containsKey('tax')) {
      context.handle(
        _taxMeta,
        tax.isAcceptableOrUnknown(data['tax']!, _taxMeta),
      );
    } else if (isInserting) {
      context.missing(_taxMeta);
    }
    if (data.containsKey('grand_total')) {
      context.handle(
        _grandTotalMeta,
        grandTotal.isAcceptableOrUnknown(data['grand_total']!, _grandTotalMeta),
      );
    } else if (isInserting) {
      context.missing(_grandTotalMeta);
    }
    if (data.containsKey('payment_status')) {
      context.handle(
        _paymentStatusMeta,
        paymentStatus.isAcceptableOrUnknown(
          data['payment_status']!,
          _paymentStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentStatusMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Sale map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Sale(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}customer_id'],
      )!,
      invoiceNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_no'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total'],
      )!,
      discount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount'],
      )!,
      tax: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax'],
      )!,
      grandTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}grand_total'],
      )!,
      paymentStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SalesTable createAlias(String alias) {
    return $SalesTable(attachedDatabase, alias);
  }
}

class Sale extends DataClass implements Insertable<Sale> {
  final int id;
  final int customerId;
  final String invoiceNo;
  final double total;
  final double discount;
  final double tax;
  final double grandTotal;
  final String paymentStatus;
  final DateTime createdAt;
  const Sale({
    required this.id,
    required this.customerId,
    required this.invoiceNo,
    required this.total,
    required this.discount,
    required this.tax,
    required this.grandTotal,
    required this.paymentStatus,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['customer_id'] = Variable<int>(customerId);
    map['invoice_no'] = Variable<String>(invoiceNo);
    map['total'] = Variable<double>(total);
    map['discount'] = Variable<double>(discount);
    map['tax'] = Variable<double>(tax);
    map['grand_total'] = Variable<double>(grandTotal);
    map['payment_status'] = Variable<String>(paymentStatus);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SalesCompanion toCompanion(bool nullToAbsent) {
    return SalesCompanion(
      id: Value(id),
      customerId: Value(customerId),
      invoiceNo: Value(invoiceNo),
      total: Value(total),
      discount: Value(discount),
      tax: Value(tax),
      grandTotal: Value(grandTotal),
      paymentStatus: Value(paymentStatus),
      createdAt: Value(createdAt),
    );
  }

  factory Sale.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Sale(
      id: serializer.fromJson<int>(json['id']),
      customerId: serializer.fromJson<int>(json['customerId']),
      invoiceNo: serializer.fromJson<String>(json['invoiceNo']),
      total: serializer.fromJson<double>(json['total']),
      discount: serializer.fromJson<double>(json['discount']),
      tax: serializer.fromJson<double>(json['tax']),
      grandTotal: serializer.fromJson<double>(json['grandTotal']),
      paymentStatus: serializer.fromJson<String>(json['paymentStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'customerId': serializer.toJson<int>(customerId),
      'invoiceNo': serializer.toJson<String>(invoiceNo),
      'total': serializer.toJson<double>(total),
      'discount': serializer.toJson<double>(discount),
      'tax': serializer.toJson<double>(tax),
      'grandTotal': serializer.toJson<double>(grandTotal),
      'paymentStatus': serializer.toJson<String>(paymentStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Sale copyWith({
    int? id,
    int? customerId,
    String? invoiceNo,
    double? total,
    double? discount,
    double? tax,
    double? grandTotal,
    String? paymentStatus,
    DateTime? createdAt,
  }) => Sale(
    id: id ?? this.id,
    customerId: customerId ?? this.customerId,
    invoiceNo: invoiceNo ?? this.invoiceNo,
    total: total ?? this.total,
    discount: discount ?? this.discount,
    tax: tax ?? this.tax,
    grandTotal: grandTotal ?? this.grandTotal,
    paymentStatus: paymentStatus ?? this.paymentStatus,
    createdAt: createdAt ?? this.createdAt,
  );
  Sale copyWithCompanion(SalesCompanion data) {
    return Sale(
      id: data.id.present ? data.id.value : this.id,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      invoiceNo: data.invoiceNo.present ? data.invoiceNo.value : this.invoiceNo,
      total: data.total.present ? data.total.value : this.total,
      discount: data.discount.present ? data.discount.value : this.discount,
      tax: data.tax.present ? data.tax.value : this.tax,
      grandTotal: data.grandTotal.present
          ? data.grandTotal.value
          : this.grandTotal,
      paymentStatus: data.paymentStatus.present
          ? data.paymentStatus.value
          : this.paymentStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Sale(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('invoiceNo: $invoiceNo, ')
          ..write('total: $total, ')
          ..write('discount: $discount, ')
          ..write('tax: $tax, ')
          ..write('grandTotal: $grandTotal, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    customerId,
    invoiceNo,
    total,
    discount,
    tax,
    grandTotal,
    paymentStatus,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Sale &&
          other.id == this.id &&
          other.customerId == this.customerId &&
          other.invoiceNo == this.invoiceNo &&
          other.total == this.total &&
          other.discount == this.discount &&
          other.tax == this.tax &&
          other.grandTotal == this.grandTotal &&
          other.paymentStatus == this.paymentStatus &&
          other.createdAt == this.createdAt);
}

class SalesCompanion extends UpdateCompanion<Sale> {
  final Value<int> id;
  final Value<int> customerId;
  final Value<String> invoiceNo;
  final Value<double> total;
  final Value<double> discount;
  final Value<double> tax;
  final Value<double> grandTotal;
  final Value<String> paymentStatus;
  final Value<DateTime> createdAt;
  const SalesCompanion({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    this.invoiceNo = const Value.absent(),
    this.total = const Value.absent(),
    this.discount = const Value.absent(),
    this.tax = const Value.absent(),
    this.grandTotal = const Value.absent(),
    this.paymentStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SalesCompanion.insert({
    this.id = const Value.absent(),
    required int customerId,
    required String invoiceNo,
    required double total,
    required double discount,
    required double tax,
    required double grandTotal,
    required String paymentStatus,
    this.createdAt = const Value.absent(),
  }) : customerId = Value(customerId),
       invoiceNo = Value(invoiceNo),
       total = Value(total),
       discount = Value(discount),
       tax = Value(tax),
       grandTotal = Value(grandTotal),
       paymentStatus = Value(paymentStatus);
  static Insertable<Sale> custom({
    Expression<int>? id,
    Expression<int>? customerId,
    Expression<String>? invoiceNo,
    Expression<double>? total,
    Expression<double>? discount,
    Expression<double>? tax,
    Expression<double>? grandTotal,
    Expression<String>? paymentStatus,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerId != null) 'customer_id': customerId,
      if (invoiceNo != null) 'invoice_no': invoiceNo,
      if (total != null) 'total': total,
      if (discount != null) 'discount': discount,
      if (tax != null) 'tax': tax,
      if (grandTotal != null) 'grand_total': grandTotal,
      if (paymentStatus != null) 'payment_status': paymentStatus,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SalesCompanion copyWith({
    Value<int>? id,
    Value<int>? customerId,
    Value<String>? invoiceNo,
    Value<double>? total,
    Value<double>? discount,
    Value<double>? tax,
    Value<double>? grandTotal,
    Value<String>? paymentStatus,
    Value<DateTime>? createdAt,
  }) {
    return SalesCompanion(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      invoiceNo: invoiceNo ?? this.invoiceNo,
      total: total ?? this.total,
      discount: discount ?? this.discount,
      tax: tax ?? this.tax,
      grandTotal: grandTotal ?? this.grandTotal,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (invoiceNo.present) {
      map['invoice_no'] = Variable<String>(invoiceNo.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (discount.present) {
      map['discount'] = Variable<double>(discount.value);
    }
    if (tax.present) {
      map['tax'] = Variable<double>(tax.value);
    }
    if (grandTotal.present) {
      map['grand_total'] = Variable<double>(grandTotal.value);
    }
    if (paymentStatus.present) {
      map['payment_status'] = Variable<String>(paymentStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesCompanion(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('invoiceNo: $invoiceNo, ')
          ..write('total: $total, ')
          ..write('discount: $discount, ')
          ..write('tax: $tax, ')
          ..write('grandTotal: $grandTotal, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SaleItemsTable extends SaleItems
    with TableInfo<$SaleItemsTable, SaleItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SaleItemsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _saleIdMeta = const VerificationMeta('saleId');
  @override
  late final GeneratedColumn<int> saleId = GeneratedColumn<int>(
    'sale_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qtyMeta = const VerificationMeta('qty');
  @override
  late final GeneratedColumn<int> qty = GeneratedColumn<int>(
    'qty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subtotalMeta = const VerificationMeta(
    'subtotal',
  );
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
    'subtotal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    saleId,
    productId,
    qty,
    price,
    subtotal,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sale_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<SaleItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sale_id')) {
      context.handle(
        _saleIdMeta,
        saleId.isAcceptableOrUnknown(data['sale_id']!, _saleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_saleIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('qty')) {
      context.handle(
        _qtyMeta,
        qty.isAcceptableOrUnknown(data['qty']!, _qtyMeta),
      );
    } else if (isInserting) {
      context.missing(_qtyMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('subtotal')) {
      context.handle(
        _subtotalMeta,
        subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta),
      );
    } else if (isInserting) {
      context.missing(_subtotalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SaleItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SaleItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      saleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sale_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      qty: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}qty'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      subtotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}subtotal'],
      )!,
    );
  }

  @override
  $SaleItemsTable createAlias(String alias) {
    return $SaleItemsTable(attachedDatabase, alias);
  }
}

class SaleItem extends DataClass implements Insertable<SaleItem> {
  final int id;
  final int saleId;
  final int productId;
  final int qty;
  final double price;
  final double subtotal;
  const SaleItem({
    required this.id,
    required this.saleId,
    required this.productId,
    required this.qty,
    required this.price,
    required this.subtotal,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sale_id'] = Variable<int>(saleId);
    map['product_id'] = Variable<int>(productId);
    map['qty'] = Variable<int>(qty);
    map['price'] = Variable<double>(price);
    map['subtotal'] = Variable<double>(subtotal);
    return map;
  }

  SaleItemsCompanion toCompanion(bool nullToAbsent) {
    return SaleItemsCompanion(
      id: Value(id),
      saleId: Value(saleId),
      productId: Value(productId),
      qty: Value(qty),
      price: Value(price),
      subtotal: Value(subtotal),
    );
  }

  factory SaleItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SaleItem(
      id: serializer.fromJson<int>(json['id']),
      saleId: serializer.fromJson<int>(json['saleId']),
      productId: serializer.fromJson<int>(json['productId']),
      qty: serializer.fromJson<int>(json['qty']),
      price: serializer.fromJson<double>(json['price']),
      subtotal: serializer.fromJson<double>(json['subtotal']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'saleId': serializer.toJson<int>(saleId),
      'productId': serializer.toJson<int>(productId),
      'qty': serializer.toJson<int>(qty),
      'price': serializer.toJson<double>(price),
      'subtotal': serializer.toJson<double>(subtotal),
    };
  }

  SaleItem copyWith({
    int? id,
    int? saleId,
    int? productId,
    int? qty,
    double? price,
    double? subtotal,
  }) => SaleItem(
    id: id ?? this.id,
    saleId: saleId ?? this.saleId,
    productId: productId ?? this.productId,
    qty: qty ?? this.qty,
    price: price ?? this.price,
    subtotal: subtotal ?? this.subtotal,
  );
  SaleItem copyWithCompanion(SaleItemsCompanion data) {
    return SaleItem(
      id: data.id.present ? data.id.value : this.id,
      saleId: data.saleId.present ? data.saleId.value : this.saleId,
      productId: data.productId.present ? data.productId.value : this.productId,
      qty: data.qty.present ? data.qty.value : this.qty,
      price: data.price.present ? data.price.value : this.price,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SaleItem(')
          ..write('id: $id, ')
          ..write('saleId: $saleId, ')
          ..write('productId: $productId, ')
          ..write('qty: $qty, ')
          ..write('price: $price, ')
          ..write('subtotal: $subtotal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, saleId, productId, qty, price, subtotal);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SaleItem &&
          other.id == this.id &&
          other.saleId == this.saleId &&
          other.productId == this.productId &&
          other.qty == this.qty &&
          other.price == this.price &&
          other.subtotal == this.subtotal);
}

class SaleItemsCompanion extends UpdateCompanion<SaleItem> {
  final Value<int> id;
  final Value<int> saleId;
  final Value<int> productId;
  final Value<int> qty;
  final Value<double> price;
  final Value<double> subtotal;
  const SaleItemsCompanion({
    this.id = const Value.absent(),
    this.saleId = const Value.absent(),
    this.productId = const Value.absent(),
    this.qty = const Value.absent(),
    this.price = const Value.absent(),
    this.subtotal = const Value.absent(),
  });
  SaleItemsCompanion.insert({
    this.id = const Value.absent(),
    required int saleId,
    required int productId,
    required int qty,
    required double price,
    required double subtotal,
  }) : saleId = Value(saleId),
       productId = Value(productId),
       qty = Value(qty),
       price = Value(price),
       subtotal = Value(subtotal);
  static Insertable<SaleItem> custom({
    Expression<int>? id,
    Expression<int>? saleId,
    Expression<int>? productId,
    Expression<int>? qty,
    Expression<double>? price,
    Expression<double>? subtotal,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (saleId != null) 'sale_id': saleId,
      if (productId != null) 'product_id': productId,
      if (qty != null) 'qty': qty,
      if (price != null) 'price': price,
      if (subtotal != null) 'subtotal': subtotal,
    });
  }

  SaleItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? saleId,
    Value<int>? productId,
    Value<int>? qty,
    Value<double>? price,
    Value<double>? subtotal,
  }) {
    return SaleItemsCompanion(
      id: id ?? this.id,
      saleId: saleId ?? this.saleId,
      productId: productId ?? this.productId,
      qty: qty ?? this.qty,
      price: price ?? this.price,
      subtotal: subtotal ?? this.subtotal,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (saleId.present) {
      map['sale_id'] = Variable<int>(saleId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (qty.present) {
      map['qty'] = Variable<int>(qty.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<double>(subtotal.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SaleItemsCompanion(')
          ..write('id: $id, ')
          ..write('saleId: $saleId, ')
          ..write('productId: $productId, ')
          ..write('qty: $qty, ')
          ..write('price: $price, ')
          ..write('subtotal: $subtotal')
          ..write(')'))
        .toString();
  }
}

class $PurchasesTable extends Purchases
    with TableInfo<$PurchasesTable, Purchase> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchasesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _purchaseNoMeta = const VerificationMeta(
    'purchaseNo',
  );
  @override
  late final GeneratedColumn<String> purchaseNo = GeneratedColumn<String>(
    'purchase_no',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _supplierNameMeta = const VerificationMeta(
    'supplierName',
  );
  @override
  late final GeneratedColumn<String> supplierName = GeneratedColumn<String>(
    'supplier_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _supplierPhoneMeta = const VerificationMeta(
    'supplierPhone',
  );
  @override
  late final GeneratedColumn<String> supplierPhone = GeneratedColumn<String>(
    'supplier_phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pdfPathMeta = const VerificationMeta(
    'pdfPath',
  );
  @override
  late final GeneratedColumn<String> pdfPath = GeneratedColumn<String>(
    'pdf_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    purchaseNo,
    supplierName,
    supplierPhone,
    total,
    pdfPath,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchases';
  @override
  VerificationContext validateIntegrity(
    Insertable<Purchase> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('purchase_no')) {
      context.handle(
        _purchaseNoMeta,
        purchaseNo.isAcceptableOrUnknown(data['purchase_no']!, _purchaseNoMeta),
      );
    } else if (isInserting) {
      context.missing(_purchaseNoMeta);
    }
    if (data.containsKey('supplier_name')) {
      context.handle(
        _supplierNameMeta,
        supplierName.isAcceptableOrUnknown(
          data['supplier_name']!,
          _supplierNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_supplierNameMeta);
    }
    if (data.containsKey('supplier_phone')) {
      context.handle(
        _supplierPhoneMeta,
        supplierPhone.isAcceptableOrUnknown(
          data['supplier_phone']!,
          _supplierPhoneMeta,
        ),
      );
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('pdf_path')) {
      context.handle(
        _pdfPathMeta,
        pdfPath.isAcceptableOrUnknown(data['pdf_path']!, _pdfPathMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Purchase map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Purchase(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      purchaseNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purchase_no'],
      )!,
      supplierName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_name'],
      )!,
      supplierPhone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_phone'],
      ),
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total'],
      )!,
      pdfPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pdf_path'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PurchasesTable createAlias(String alias) {
    return $PurchasesTable(attachedDatabase, alias);
  }
}

class Purchase extends DataClass implements Insertable<Purchase> {
  final int id;

  /// PURCHASE NO
  final String purchaseNo;

  /// SUPPLIER NAME
  final String supplierName;

  /// PHONE
  final String? supplierPhone;

  /// TOTAL
  final double total;

  /// PDF PATH
  final String? pdfPath;

  /// CREATED DATE
  final DateTime createdAt;
  const Purchase({
    required this.id,
    required this.purchaseNo,
    required this.supplierName,
    this.supplierPhone,
    required this.total,
    this.pdfPath,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['purchase_no'] = Variable<String>(purchaseNo);
    map['supplier_name'] = Variable<String>(supplierName);
    if (!nullToAbsent || supplierPhone != null) {
      map['supplier_phone'] = Variable<String>(supplierPhone);
    }
    map['total'] = Variable<double>(total);
    if (!nullToAbsent || pdfPath != null) {
      map['pdf_path'] = Variable<String>(pdfPath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PurchasesCompanion toCompanion(bool nullToAbsent) {
    return PurchasesCompanion(
      id: Value(id),
      purchaseNo: Value(purchaseNo),
      supplierName: Value(supplierName),
      supplierPhone: supplierPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(supplierPhone),
      total: Value(total),
      pdfPath: pdfPath == null && nullToAbsent
          ? const Value.absent()
          : Value(pdfPath),
      createdAt: Value(createdAt),
    );
  }

  factory Purchase.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Purchase(
      id: serializer.fromJson<int>(json['id']),
      purchaseNo: serializer.fromJson<String>(json['purchaseNo']),
      supplierName: serializer.fromJson<String>(json['supplierName']),
      supplierPhone: serializer.fromJson<String?>(json['supplierPhone']),
      total: serializer.fromJson<double>(json['total']),
      pdfPath: serializer.fromJson<String?>(json['pdfPath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'purchaseNo': serializer.toJson<String>(purchaseNo),
      'supplierName': serializer.toJson<String>(supplierName),
      'supplierPhone': serializer.toJson<String?>(supplierPhone),
      'total': serializer.toJson<double>(total),
      'pdfPath': serializer.toJson<String?>(pdfPath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Purchase copyWith({
    int? id,
    String? purchaseNo,
    String? supplierName,
    Value<String?> supplierPhone = const Value.absent(),
    double? total,
    Value<String?> pdfPath = const Value.absent(),
    DateTime? createdAt,
  }) => Purchase(
    id: id ?? this.id,
    purchaseNo: purchaseNo ?? this.purchaseNo,
    supplierName: supplierName ?? this.supplierName,
    supplierPhone: supplierPhone.present
        ? supplierPhone.value
        : this.supplierPhone,
    total: total ?? this.total,
    pdfPath: pdfPath.present ? pdfPath.value : this.pdfPath,
    createdAt: createdAt ?? this.createdAt,
  );
  Purchase copyWithCompanion(PurchasesCompanion data) {
    return Purchase(
      id: data.id.present ? data.id.value : this.id,
      purchaseNo: data.purchaseNo.present
          ? data.purchaseNo.value
          : this.purchaseNo,
      supplierName: data.supplierName.present
          ? data.supplierName.value
          : this.supplierName,
      supplierPhone: data.supplierPhone.present
          ? data.supplierPhone.value
          : this.supplierPhone,
      total: data.total.present ? data.total.value : this.total,
      pdfPath: data.pdfPath.present ? data.pdfPath.value : this.pdfPath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Purchase(')
          ..write('id: $id, ')
          ..write('purchaseNo: $purchaseNo, ')
          ..write('supplierName: $supplierName, ')
          ..write('supplierPhone: $supplierPhone, ')
          ..write('total: $total, ')
          ..write('pdfPath: $pdfPath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    purchaseNo,
    supplierName,
    supplierPhone,
    total,
    pdfPath,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Purchase &&
          other.id == this.id &&
          other.purchaseNo == this.purchaseNo &&
          other.supplierName == this.supplierName &&
          other.supplierPhone == this.supplierPhone &&
          other.total == this.total &&
          other.pdfPath == this.pdfPath &&
          other.createdAt == this.createdAt);
}

class PurchasesCompanion extends UpdateCompanion<Purchase> {
  final Value<int> id;
  final Value<String> purchaseNo;
  final Value<String> supplierName;
  final Value<String?> supplierPhone;
  final Value<double> total;
  final Value<String?> pdfPath;
  final Value<DateTime> createdAt;
  const PurchasesCompanion({
    this.id = const Value.absent(),
    this.purchaseNo = const Value.absent(),
    this.supplierName = const Value.absent(),
    this.supplierPhone = const Value.absent(),
    this.total = const Value.absent(),
    this.pdfPath = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PurchasesCompanion.insert({
    this.id = const Value.absent(),
    required String purchaseNo,
    required String supplierName,
    this.supplierPhone = const Value.absent(),
    required double total,
    this.pdfPath = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : purchaseNo = Value(purchaseNo),
       supplierName = Value(supplierName),
       total = Value(total);
  static Insertable<Purchase> custom({
    Expression<int>? id,
    Expression<String>? purchaseNo,
    Expression<String>? supplierName,
    Expression<String>? supplierPhone,
    Expression<double>? total,
    Expression<String>? pdfPath,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (purchaseNo != null) 'purchase_no': purchaseNo,
      if (supplierName != null) 'supplier_name': supplierName,
      if (supplierPhone != null) 'supplier_phone': supplierPhone,
      if (total != null) 'total': total,
      if (pdfPath != null) 'pdf_path': pdfPath,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PurchasesCompanion copyWith({
    Value<int>? id,
    Value<String>? purchaseNo,
    Value<String>? supplierName,
    Value<String?>? supplierPhone,
    Value<double>? total,
    Value<String?>? pdfPath,
    Value<DateTime>? createdAt,
  }) {
    return PurchasesCompanion(
      id: id ?? this.id,
      purchaseNo: purchaseNo ?? this.purchaseNo,
      supplierName: supplierName ?? this.supplierName,
      supplierPhone: supplierPhone ?? this.supplierPhone,
      total: total ?? this.total,
      pdfPath: pdfPath ?? this.pdfPath,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (purchaseNo.present) {
      map['purchase_no'] = Variable<String>(purchaseNo.value);
    }
    if (supplierName.present) {
      map['supplier_name'] = Variable<String>(supplierName.value);
    }
    if (supplierPhone.present) {
      map['supplier_phone'] = Variable<String>(supplierPhone.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (pdfPath.present) {
      map['pdf_path'] = Variable<String>(pdfPath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchasesCompanion(')
          ..write('id: $id, ')
          ..write('purchaseNo: $purchaseNo, ')
          ..write('supplierName: $supplierName, ')
          ..write('supplierPhone: $supplierPhone, ')
          ..write('total: $total, ')
          ..write('pdfPath: $pdfPath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PurchaseItemsTable extends PurchaseItems
    with TableInfo<$PurchaseItemsTable, PurchaseItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchaseItemsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _purchaseIdMeta = const VerificationMeta(
    'purchaseId',
  );
  @override
  late final GeneratedColumn<int> purchaseId = GeneratedColumn<int>(
    'purchase_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productNameMeta = const VerificationMeta(
    'productName',
  );
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
    'product_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _purchasePriceMeta = const VerificationMeta(
    'purchasePrice',
  );
  @override
  late final GeneratedColumn<double> purchasePrice = GeneratedColumn<double>(
    'purchase_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _variantIdMeta = const VerificationMeta(
    'variantId',
  );
  @override
  late final GeneratedColumn<int> variantId = GeneratedColumn<int>(
    'variant_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _variantNameMeta = const VerificationMeta(
    'variantName',
  );
  @override
  late final GeneratedColumn<String> variantName = GeneratedColumn<String>(
    'variant_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    purchaseId,
    productId,
    productName,
    quantity,
    purchasePrice,
    total,
    createdAt,
    variantId,
    variantName,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchase_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<PurchaseItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('purchase_id')) {
      context.handle(
        _purchaseIdMeta,
        purchaseId.isAcceptableOrUnknown(data['purchase_id']!, _purchaseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_purchaseIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('product_name')) {
      context.handle(
        _productNameMeta,
        productName.isAcceptableOrUnknown(
          data['product_name']!,
          _productNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('purchase_price')) {
      context.handle(
        _purchasePriceMeta,
        purchasePrice.isAcceptableOrUnknown(
          data['purchase_price']!,
          _purchasePriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchasePriceMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('variant_id')) {
      context.handle(
        _variantIdMeta,
        variantId.isAcceptableOrUnknown(data['variant_id']!, _variantIdMeta),
      );
    }
    if (data.containsKey('variant_name')) {
      context.handle(
        _variantNameMeta,
        variantName.isAcceptableOrUnknown(
          data['variant_name']!,
          _variantNameMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PurchaseItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchaseItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      purchaseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}purchase_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      productName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_name'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      purchasePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}purchase_price'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      variantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}variant_id'],
      ),
      variantName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variant_name'],
      ),
    );
  }

  @override
  $PurchaseItemsTable createAlias(String alias) {
    return $PurchaseItemsTable(attachedDatabase, alias);
  }
}

class PurchaseItem extends DataClass implements Insertable<PurchaseItem> {
  final int id;

  /// PURCHASE ID
  final int purchaseId;

  /// PRODUCT ID
  final int productId;

  /// PRODUCT NAME SNAPSHOT
  final String productName;

  /// QUANTITY
  final int quantity;

  /// PURCHASE PRICE
  final double purchasePrice;

  /// TOTAL
  final double total;

  /// CREATED DATE
  final DateTime createdAt;
  final int? variantId;
  final String? variantName;
  const PurchaseItem({
    required this.id,
    required this.purchaseId,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.purchasePrice,
    required this.total,
    required this.createdAt,
    this.variantId,
    this.variantName,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['purchase_id'] = Variable<int>(purchaseId);
    map['product_id'] = Variable<int>(productId);
    map['product_name'] = Variable<String>(productName);
    map['quantity'] = Variable<int>(quantity);
    map['purchase_price'] = Variable<double>(purchasePrice);
    map['total'] = Variable<double>(total);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || variantId != null) {
      map['variant_id'] = Variable<int>(variantId);
    }
    if (!nullToAbsent || variantName != null) {
      map['variant_name'] = Variable<String>(variantName);
    }
    return map;
  }

  PurchaseItemsCompanion toCompanion(bool nullToAbsent) {
    return PurchaseItemsCompanion(
      id: Value(id),
      purchaseId: Value(purchaseId),
      productId: Value(productId),
      productName: Value(productName),
      quantity: Value(quantity),
      purchasePrice: Value(purchasePrice),
      total: Value(total),
      createdAt: Value(createdAt),
      variantId: variantId == null && nullToAbsent
          ? const Value.absent()
          : Value(variantId),
      variantName: variantName == null && nullToAbsent
          ? const Value.absent()
          : Value(variantName),
    );
  }

  factory PurchaseItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchaseItem(
      id: serializer.fromJson<int>(json['id']),
      purchaseId: serializer.fromJson<int>(json['purchaseId']),
      productId: serializer.fromJson<int>(json['productId']),
      productName: serializer.fromJson<String>(json['productName']),
      quantity: serializer.fromJson<int>(json['quantity']),
      purchasePrice: serializer.fromJson<double>(json['purchasePrice']),
      total: serializer.fromJson<double>(json['total']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      variantId: serializer.fromJson<int?>(json['variantId']),
      variantName: serializer.fromJson<String?>(json['variantName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'purchaseId': serializer.toJson<int>(purchaseId),
      'productId': serializer.toJson<int>(productId),
      'productName': serializer.toJson<String>(productName),
      'quantity': serializer.toJson<int>(quantity),
      'purchasePrice': serializer.toJson<double>(purchasePrice),
      'total': serializer.toJson<double>(total),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'variantId': serializer.toJson<int?>(variantId),
      'variantName': serializer.toJson<String?>(variantName),
    };
  }

  PurchaseItem copyWith({
    int? id,
    int? purchaseId,
    int? productId,
    String? productName,
    int? quantity,
    double? purchasePrice,
    double? total,
    DateTime? createdAt,
    Value<int?> variantId = const Value.absent(),
    Value<String?> variantName = const Value.absent(),
  }) => PurchaseItem(
    id: id ?? this.id,
    purchaseId: purchaseId ?? this.purchaseId,
    productId: productId ?? this.productId,
    productName: productName ?? this.productName,
    quantity: quantity ?? this.quantity,
    purchasePrice: purchasePrice ?? this.purchasePrice,
    total: total ?? this.total,
    createdAt: createdAt ?? this.createdAt,
    variantId: variantId.present ? variantId.value : this.variantId,
    variantName: variantName.present ? variantName.value : this.variantName,
  );
  PurchaseItem copyWithCompanion(PurchaseItemsCompanion data) {
    return PurchaseItem(
      id: data.id.present ? data.id.value : this.id,
      purchaseId: data.purchaseId.present
          ? data.purchaseId.value
          : this.purchaseId,
      productId: data.productId.present ? data.productId.value : this.productId,
      productName: data.productName.present
          ? data.productName.value
          : this.productName,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      purchasePrice: data.purchasePrice.present
          ? data.purchasePrice.value
          : this.purchasePrice,
      total: data.total.present ? data.total.value : this.total,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      variantId: data.variantId.present ? data.variantId.value : this.variantId,
      variantName: data.variantName.present
          ? data.variantName.value
          : this.variantName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseItem(')
          ..write('id: $id, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('quantity: $quantity, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('total: $total, ')
          ..write('createdAt: $createdAt, ')
          ..write('variantId: $variantId, ')
          ..write('variantName: $variantName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    purchaseId,
    productId,
    productName,
    quantity,
    purchasePrice,
    total,
    createdAt,
    variantId,
    variantName,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseItem &&
          other.id == this.id &&
          other.purchaseId == this.purchaseId &&
          other.productId == this.productId &&
          other.productName == this.productName &&
          other.quantity == this.quantity &&
          other.purchasePrice == this.purchasePrice &&
          other.total == this.total &&
          other.createdAt == this.createdAt &&
          other.variantId == this.variantId &&
          other.variantName == this.variantName);
}

class PurchaseItemsCompanion extends UpdateCompanion<PurchaseItem> {
  final Value<int> id;
  final Value<int> purchaseId;
  final Value<int> productId;
  final Value<String> productName;
  final Value<int> quantity;
  final Value<double> purchasePrice;
  final Value<double> total;
  final Value<DateTime> createdAt;
  final Value<int?> variantId;
  final Value<String?> variantName;
  const PurchaseItemsCompanion({
    this.id = const Value.absent(),
    this.purchaseId = const Value.absent(),
    this.productId = const Value.absent(),
    this.productName = const Value.absent(),
    this.quantity = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.total = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.variantId = const Value.absent(),
    this.variantName = const Value.absent(),
  });
  PurchaseItemsCompanion.insert({
    this.id = const Value.absent(),
    required int purchaseId,
    required int productId,
    required String productName,
    required int quantity,
    required double purchasePrice,
    required double total,
    this.createdAt = const Value.absent(),
    this.variantId = const Value.absent(),
    this.variantName = const Value.absent(),
  }) : purchaseId = Value(purchaseId),
       productId = Value(productId),
       productName = Value(productName),
       quantity = Value(quantity),
       purchasePrice = Value(purchasePrice),
       total = Value(total);
  static Insertable<PurchaseItem> custom({
    Expression<int>? id,
    Expression<int>? purchaseId,
    Expression<int>? productId,
    Expression<String>? productName,
    Expression<int>? quantity,
    Expression<double>? purchasePrice,
    Expression<double>? total,
    Expression<DateTime>? createdAt,
    Expression<int>? variantId,
    Expression<String>? variantName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (purchaseId != null) 'purchase_id': purchaseId,
      if (productId != null) 'product_id': productId,
      if (productName != null) 'product_name': productName,
      if (quantity != null) 'quantity': quantity,
      if (purchasePrice != null) 'purchase_price': purchasePrice,
      if (total != null) 'total': total,
      if (createdAt != null) 'created_at': createdAt,
      if (variantId != null) 'variant_id': variantId,
      if (variantName != null) 'variant_name': variantName,
    });
  }

  PurchaseItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? purchaseId,
    Value<int>? productId,
    Value<String>? productName,
    Value<int>? quantity,
    Value<double>? purchasePrice,
    Value<double>? total,
    Value<DateTime>? createdAt,
    Value<int?>? variantId,
    Value<String?>? variantName,
  }) {
    return PurchaseItemsCompanion(
      id: id ?? this.id,
      purchaseId: purchaseId ?? this.purchaseId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      total: total ?? this.total,
      createdAt: createdAt ?? this.createdAt,
      variantId: variantId ?? this.variantId,
      variantName: variantName ?? this.variantName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (purchaseId.present) {
      map['purchase_id'] = Variable<int>(purchaseId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (purchasePrice.present) {
      map['purchase_price'] = Variable<double>(purchasePrice.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (variantId.present) {
      map['variant_id'] = Variable<int>(variantId.value);
    }
    if (variantName.present) {
      map['variant_name'] = Variable<String>(variantName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseItemsCompanion(')
          ..write('id: $id, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('quantity: $quantity, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('total: $total, ')
          ..write('createdAt: $createdAt, ')
          ..write('variantId: $variantId, ')
          ..write('variantName: $variantName')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses with TableInfo<$ExpensesTable, Expense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    amount,
    category,
    note,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(
    Insertable<Expense> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }
}

class Expense extends DataClass implements Insertable<Expense> {
  final int id;
  final String title;
  final double amount;
  final String category;
  final String? note;
  final DateTime createdAt;
  const Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    this.note,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['amount'] = Variable<double>(amount);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      title: Value(title),
      amount: Value(amount),
      category: Value(category),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
    );
  }

  factory Expense.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Expense(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      amount: serializer.fromJson<double>(json['amount']),
      category: serializer.fromJson<String>(json['category']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'amount': serializer.toJson<double>(amount),
      'category': serializer.toJson<String>(category),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Expense copyWith({
    int? id,
    String? title,
    double? amount,
    String? category,
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
  }) => Expense(
    id: id ?? this.id,
    title: title ?? this.title,
    amount: amount ?? this.amount,
    category: category ?? this.category,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
  );
  Expense copyWithCompanion(ExpensesCompanion data) {
    return Expense(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      amount: data.amount.present ? data.amount.value : this.amount,
      category: data.category.present ? data.category.value : this.category,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Expense(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('amount: $amount, ')
          ..write('category: $category, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, amount, category, note, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Expense &&
          other.id == this.id &&
          other.title == this.title &&
          other.amount == this.amount &&
          other.category == this.category &&
          other.note == this.note &&
          other.createdAt == this.createdAt);
}

class ExpensesCompanion extends UpdateCompanion<Expense> {
  final Value<int> id;
  final Value<String> title;
  final Value<double> amount;
  final Value<String> category;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.amount = const Value.absent(),
    this.category = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ExpensesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required double amount,
    required String category,
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : title = Value(title),
       amount = Value(amount),
       category = Value(category);
  static Insertable<Expense> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<double>? amount,
    Expression<String>? category,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (amount != null) 'amount': amount,
      if (category != null) 'category': category,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ExpensesCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<double>? amount,
    Value<String>? category,
    Value<String?>? note,
    Value<DateTime>? createdAt,
  }) {
    return ExpensesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('amount: $amount, ')
          ..write('category: $category, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $InvoicesTable extends Invoices with TableInfo<$InvoicesTable, Invoice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoicesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _invoiceNoMeta = const VerificationMeta(
    'invoiceNo',
  );
  @override
  late final GeneratedColumn<String> invoiceNo = GeneratedColumn<String>(
    'invoice_no',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customerNameMeta = const VerificationMeta(
    'customerName',
  );
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
    'customer_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customerPhoneMeta = const VerificationMeta(
    'customerPhone',
  );
  @override
  late final GeneratedColumn<String> customerPhone = GeneratedColumn<String>(
    'customer_phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subtotalMeta = const VerificationMeta(
    'subtotal',
  );
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
    'subtotal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxMeta = const VerificationMeta('tax');
  @override
  late final GeneratedColumn<double> tax = GeneratedColumn<double>(
    'tax',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountMeta = const VerificationMeta(
    'discount',
  );
  @override
  late final GeneratedColumn<double> discount = GeneratedColumn<double>(
    'discount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _grandTotalMeta = const VerificationMeta(
    'grandTotal',
  );
  @override
  late final GeneratedColumn<double> grandTotal = GeneratedColumn<double>(
    'grand_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('CASH'),
  );
  static const VerificationMeta _paymentStatusMeta = const VerificationMeta(
    'paymentStatus',
  );
  @override
  late final GeneratedColumn<String> paymentStatus = GeneratedColumn<String>(
    'payment_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('PAID'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _pdfPathMeta = const VerificationMeta(
    'pdfPath',
  );
  @override
  late final GeneratedColumn<String> pdfPath = GeneratedColumn<String>(
    'pdf_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _amountPaidMeta = const VerificationMeta(
    'amountPaid',
  );
  @override
  late final GeneratedColumn<double> amountPaid = GeneratedColumn<double>(
    'amount_paid',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _dueAmountMeta = const VerificationMeta(
    'dueAmount',
  );
  @override
  late final GeneratedColumn<double> dueAmount = GeneratedColumn<double>(
    'due_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reminderSentMeta = const VerificationMeta(
    'reminderSent',
  );
  @override
  late final GeneratedColumn<bool> reminderSent = GeneratedColumn<bool>(
    'reminder_sent',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("reminder_sent" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _loadingChargeMeta = const VerificationMeta(
    'loadingCharge',
  );
  @override
  late final GeneratedColumn<double> loadingCharge = GeneratedColumn<double>(
    'loading_charge',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _unloadingChargeMeta = const VerificationMeta(
    'unloadingCharge',
  );
  @override
  late final GeneratedColumn<double> unloadingCharge = GeneratedColumn<double>(
    'unloading_charge',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _transportChargeMeta = const VerificationMeta(
    'transportCharge',
  );
  @override
  late final GeneratedColumn<double> transportCharge = GeneratedColumn<double>(
    'transport_charge',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    invoiceNo,
    customerName,
    customerPhone,
    subtotal,
    tax,
    discount,
    grandTotal,
    paymentMethod,
    paymentStatus,
    createdAt,
    pdfPath,
    amountPaid,
    dueAmount,
    dueDate,
    reminderSent,
    loadingCharge,
    unloadingCharge,
    transportCharge,
    customerId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoices';
  @override
  VerificationContext validateIntegrity(
    Insertable<Invoice> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('invoice_no')) {
      context.handle(
        _invoiceNoMeta,
        invoiceNo.isAcceptableOrUnknown(data['invoice_no']!, _invoiceNoMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceNoMeta);
    }
    if (data.containsKey('customer_name')) {
      context.handle(
        _customerNameMeta,
        customerName.isAcceptableOrUnknown(
          data['customer_name']!,
          _customerNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_customerNameMeta);
    }
    if (data.containsKey('customer_phone')) {
      context.handle(
        _customerPhoneMeta,
        customerPhone.isAcceptableOrUnknown(
          data['customer_phone']!,
          _customerPhoneMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_customerPhoneMeta);
    }
    if (data.containsKey('subtotal')) {
      context.handle(
        _subtotalMeta,
        subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta),
      );
    } else if (isInserting) {
      context.missing(_subtotalMeta);
    }
    if (data.containsKey('tax')) {
      context.handle(
        _taxMeta,
        tax.isAcceptableOrUnknown(data['tax']!, _taxMeta),
      );
    } else if (isInserting) {
      context.missing(_taxMeta);
    }
    if (data.containsKey('discount')) {
      context.handle(
        _discountMeta,
        discount.isAcceptableOrUnknown(data['discount']!, _discountMeta),
      );
    }
    if (data.containsKey('grand_total')) {
      context.handle(
        _grandTotalMeta,
        grandTotal.isAcceptableOrUnknown(data['grand_total']!, _grandTotalMeta),
      );
    } else if (isInserting) {
      context.missing(_grandTotalMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    }
    if (data.containsKey('payment_status')) {
      context.handle(
        _paymentStatusMeta,
        paymentStatus.isAcceptableOrUnknown(
          data['payment_status']!,
          _paymentStatusMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('pdf_path')) {
      context.handle(
        _pdfPathMeta,
        pdfPath.isAcceptableOrUnknown(data['pdf_path']!, _pdfPathMeta),
      );
    }
    if (data.containsKey('amount_paid')) {
      context.handle(
        _amountPaidMeta,
        amountPaid.isAcceptableOrUnknown(data['amount_paid']!, _amountPaidMeta),
      );
    }
    if (data.containsKey('due_amount')) {
      context.handle(
        _dueAmountMeta,
        dueAmount.isAcceptableOrUnknown(data['due_amount']!, _dueAmountMeta),
      );
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    }
    if (data.containsKey('reminder_sent')) {
      context.handle(
        _reminderSentMeta,
        reminderSent.isAcceptableOrUnknown(
          data['reminder_sent']!,
          _reminderSentMeta,
        ),
      );
    }
    if (data.containsKey('loading_charge')) {
      context.handle(
        _loadingChargeMeta,
        loadingCharge.isAcceptableOrUnknown(
          data['loading_charge']!,
          _loadingChargeMeta,
        ),
      );
    }
    if (data.containsKey('unloading_charge')) {
      context.handle(
        _unloadingChargeMeta,
        unloadingCharge.isAcceptableOrUnknown(
          data['unloading_charge']!,
          _unloadingChargeMeta,
        ),
      );
    }
    if (data.containsKey('transport_charge')) {
      context.handle(
        _transportChargeMeta,
        transportCharge.isAcceptableOrUnknown(
          data['transport_charge']!,
          _transportChargeMeta,
        ),
      );
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Invoice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Invoice(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      invoiceNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_no'],
      )!,
      customerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_name'],
      )!,
      customerPhone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_phone'],
      )!,
      subtotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}subtotal'],
      )!,
      tax: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax'],
      )!,
      discount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount'],
      )!,
      grandTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}grand_total'],
      )!,
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      )!,
      paymentStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      pdfPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pdf_path'],
      ),
      amountPaid: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount_paid'],
      )!,
      dueAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}due_amount'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      ),
      reminderSent: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reminder_sent'],
      )!,
      loadingCharge: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}loading_charge'],
      )!,
      unloadingCharge: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unloading_charge'],
      )!,
      transportCharge: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}transport_charge'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}customer_id'],
      ),
    );
  }

  @override
  $InvoicesTable createAlias(String alias) {
    return $InvoicesTable(attachedDatabase, alias);
  }
}

class Invoice extends DataClass implements Insertable<Invoice> {
  final int id;
  final String invoiceNo;
  final String customerName;
  final String customerPhone;
  final double subtotal;
  final double tax;
  final double discount;
  final double grandTotal;
  final String paymentMethod;
  final String paymentStatus;
  final DateTime createdAt;
  final String? pdfPath;
  final double amountPaid;
  final double dueAmount;
  final DateTime? dueDate;
  final bool reminderSent;
  final double loadingCharge;
  final double unloadingCharge;
  final double transportCharge;
  final int? customerId;
  const Invoice({
    required this.id,
    required this.invoiceNo,
    required this.customerName,
    required this.customerPhone,
    required this.subtotal,
    required this.tax,
    required this.discount,
    required this.grandTotal,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.createdAt,
    this.pdfPath,
    required this.amountPaid,
    required this.dueAmount,
    this.dueDate,
    required this.reminderSent,
    required this.loadingCharge,
    required this.unloadingCharge,
    required this.transportCharge,
    this.customerId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['invoice_no'] = Variable<String>(invoiceNo);
    map['customer_name'] = Variable<String>(customerName);
    map['customer_phone'] = Variable<String>(customerPhone);
    map['subtotal'] = Variable<double>(subtotal);
    map['tax'] = Variable<double>(tax);
    map['discount'] = Variable<double>(discount);
    map['grand_total'] = Variable<double>(grandTotal);
    map['payment_method'] = Variable<String>(paymentMethod);
    map['payment_status'] = Variable<String>(paymentStatus);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || pdfPath != null) {
      map['pdf_path'] = Variable<String>(pdfPath);
    }
    map['amount_paid'] = Variable<double>(amountPaid);
    map['due_amount'] = Variable<double>(dueAmount);
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    map['reminder_sent'] = Variable<bool>(reminderSent);
    map['loading_charge'] = Variable<double>(loadingCharge);
    map['unloading_charge'] = Variable<double>(unloadingCharge);
    map['transport_charge'] = Variable<double>(transportCharge);
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<int>(customerId);
    }
    return map;
  }

  InvoicesCompanion toCompanion(bool nullToAbsent) {
    return InvoicesCompanion(
      id: Value(id),
      invoiceNo: Value(invoiceNo),
      customerName: Value(customerName),
      customerPhone: Value(customerPhone),
      subtotal: Value(subtotal),
      tax: Value(tax),
      discount: Value(discount),
      grandTotal: Value(grandTotal),
      paymentMethod: Value(paymentMethod),
      paymentStatus: Value(paymentStatus),
      createdAt: Value(createdAt),
      pdfPath: pdfPath == null && nullToAbsent
          ? const Value.absent()
          : Value(pdfPath),
      amountPaid: Value(amountPaid),
      dueAmount: Value(dueAmount),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      reminderSent: Value(reminderSent),
      loadingCharge: Value(loadingCharge),
      unloadingCharge: Value(unloadingCharge),
      transportCharge: Value(transportCharge),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
    );
  }

  factory Invoice.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Invoice(
      id: serializer.fromJson<int>(json['id']),
      invoiceNo: serializer.fromJson<String>(json['invoiceNo']),
      customerName: serializer.fromJson<String>(json['customerName']),
      customerPhone: serializer.fromJson<String>(json['customerPhone']),
      subtotal: serializer.fromJson<double>(json['subtotal']),
      tax: serializer.fromJson<double>(json['tax']),
      discount: serializer.fromJson<double>(json['discount']),
      grandTotal: serializer.fromJson<double>(json['grandTotal']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      paymentStatus: serializer.fromJson<String>(json['paymentStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      pdfPath: serializer.fromJson<String?>(json['pdfPath']),
      amountPaid: serializer.fromJson<double>(json['amountPaid']),
      dueAmount: serializer.fromJson<double>(json['dueAmount']),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
      reminderSent: serializer.fromJson<bool>(json['reminderSent']),
      loadingCharge: serializer.fromJson<double>(json['loadingCharge']),
      unloadingCharge: serializer.fromJson<double>(json['unloadingCharge']),
      transportCharge: serializer.fromJson<double>(json['transportCharge']),
      customerId: serializer.fromJson<int?>(json['customerId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'invoiceNo': serializer.toJson<String>(invoiceNo),
      'customerName': serializer.toJson<String>(customerName),
      'customerPhone': serializer.toJson<String>(customerPhone),
      'subtotal': serializer.toJson<double>(subtotal),
      'tax': serializer.toJson<double>(tax),
      'discount': serializer.toJson<double>(discount),
      'grandTotal': serializer.toJson<double>(grandTotal),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'paymentStatus': serializer.toJson<String>(paymentStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'pdfPath': serializer.toJson<String?>(pdfPath),
      'amountPaid': serializer.toJson<double>(amountPaid),
      'dueAmount': serializer.toJson<double>(dueAmount),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
      'reminderSent': serializer.toJson<bool>(reminderSent),
      'loadingCharge': serializer.toJson<double>(loadingCharge),
      'unloadingCharge': serializer.toJson<double>(unloadingCharge),
      'transportCharge': serializer.toJson<double>(transportCharge),
      'customerId': serializer.toJson<int?>(customerId),
    };
  }

  Invoice copyWith({
    int? id,
    String? invoiceNo,
    String? customerName,
    String? customerPhone,
    double? subtotal,
    double? tax,
    double? discount,
    double? grandTotal,
    String? paymentMethod,
    String? paymentStatus,
    DateTime? createdAt,
    Value<String?> pdfPath = const Value.absent(),
    double? amountPaid,
    double? dueAmount,
    Value<DateTime?> dueDate = const Value.absent(),
    bool? reminderSent,
    double? loadingCharge,
    double? unloadingCharge,
    double? transportCharge,
    Value<int?> customerId = const Value.absent(),
  }) => Invoice(
    id: id ?? this.id,
    invoiceNo: invoiceNo ?? this.invoiceNo,
    customerName: customerName ?? this.customerName,
    customerPhone: customerPhone ?? this.customerPhone,
    subtotal: subtotal ?? this.subtotal,
    tax: tax ?? this.tax,
    discount: discount ?? this.discount,
    grandTotal: grandTotal ?? this.grandTotal,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    paymentStatus: paymentStatus ?? this.paymentStatus,
    createdAt: createdAt ?? this.createdAt,
    pdfPath: pdfPath.present ? pdfPath.value : this.pdfPath,
    amountPaid: amountPaid ?? this.amountPaid,
    dueAmount: dueAmount ?? this.dueAmount,
    dueDate: dueDate.present ? dueDate.value : this.dueDate,
    reminderSent: reminderSent ?? this.reminderSent,
    loadingCharge: loadingCharge ?? this.loadingCharge,
    unloadingCharge: unloadingCharge ?? this.unloadingCharge,
    transportCharge: transportCharge ?? this.transportCharge,
    customerId: customerId.present ? customerId.value : this.customerId,
  );
  Invoice copyWithCompanion(InvoicesCompanion data) {
    return Invoice(
      id: data.id.present ? data.id.value : this.id,
      invoiceNo: data.invoiceNo.present ? data.invoiceNo.value : this.invoiceNo,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
      customerPhone: data.customerPhone.present
          ? data.customerPhone.value
          : this.customerPhone,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      tax: data.tax.present ? data.tax.value : this.tax,
      discount: data.discount.present ? data.discount.value : this.discount,
      grandTotal: data.grandTotal.present
          ? data.grandTotal.value
          : this.grandTotal,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      paymentStatus: data.paymentStatus.present
          ? data.paymentStatus.value
          : this.paymentStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      pdfPath: data.pdfPath.present ? data.pdfPath.value : this.pdfPath,
      amountPaid: data.amountPaid.present
          ? data.amountPaid.value
          : this.amountPaid,
      dueAmount: data.dueAmount.present ? data.dueAmount.value : this.dueAmount,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      reminderSent: data.reminderSent.present
          ? data.reminderSent.value
          : this.reminderSent,
      loadingCharge: data.loadingCharge.present
          ? data.loadingCharge.value
          : this.loadingCharge,
      unloadingCharge: data.unloadingCharge.present
          ? data.unloadingCharge.value
          : this.unloadingCharge,
      transportCharge: data.transportCharge.present
          ? data.transportCharge.value
          : this.transportCharge,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Invoice(')
          ..write('id: $id, ')
          ..write('invoiceNo: $invoiceNo, ')
          ..write('customerName: $customerName, ')
          ..write('customerPhone: $customerPhone, ')
          ..write('subtotal: $subtotal, ')
          ..write('tax: $tax, ')
          ..write('discount: $discount, ')
          ..write('grandTotal: $grandTotal, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('pdfPath: $pdfPath, ')
          ..write('amountPaid: $amountPaid, ')
          ..write('dueAmount: $dueAmount, ')
          ..write('dueDate: $dueDate, ')
          ..write('reminderSent: $reminderSent, ')
          ..write('loadingCharge: $loadingCharge, ')
          ..write('unloadingCharge: $unloadingCharge, ')
          ..write('transportCharge: $transportCharge, ')
          ..write('customerId: $customerId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    invoiceNo,
    customerName,
    customerPhone,
    subtotal,
    tax,
    discount,
    grandTotal,
    paymentMethod,
    paymentStatus,
    createdAt,
    pdfPath,
    amountPaid,
    dueAmount,
    dueDate,
    reminderSent,
    loadingCharge,
    unloadingCharge,
    transportCharge,
    customerId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Invoice &&
          other.id == this.id &&
          other.invoiceNo == this.invoiceNo &&
          other.customerName == this.customerName &&
          other.customerPhone == this.customerPhone &&
          other.subtotal == this.subtotal &&
          other.tax == this.tax &&
          other.discount == this.discount &&
          other.grandTotal == this.grandTotal &&
          other.paymentMethod == this.paymentMethod &&
          other.paymentStatus == this.paymentStatus &&
          other.createdAt == this.createdAt &&
          other.pdfPath == this.pdfPath &&
          other.amountPaid == this.amountPaid &&
          other.dueAmount == this.dueAmount &&
          other.dueDate == this.dueDate &&
          other.reminderSent == this.reminderSent &&
          other.loadingCharge == this.loadingCharge &&
          other.unloadingCharge == this.unloadingCharge &&
          other.transportCharge == this.transportCharge &&
          other.customerId == this.customerId);
}

class InvoicesCompanion extends UpdateCompanion<Invoice> {
  final Value<int> id;
  final Value<String> invoiceNo;
  final Value<String> customerName;
  final Value<String> customerPhone;
  final Value<double> subtotal;
  final Value<double> tax;
  final Value<double> discount;
  final Value<double> grandTotal;
  final Value<String> paymentMethod;
  final Value<String> paymentStatus;
  final Value<DateTime> createdAt;
  final Value<String?> pdfPath;
  final Value<double> amountPaid;
  final Value<double> dueAmount;
  final Value<DateTime?> dueDate;
  final Value<bool> reminderSent;
  final Value<double> loadingCharge;
  final Value<double> unloadingCharge;
  final Value<double> transportCharge;
  final Value<int?> customerId;
  const InvoicesCompanion({
    this.id = const Value.absent(),
    this.invoiceNo = const Value.absent(),
    this.customerName = const Value.absent(),
    this.customerPhone = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.tax = const Value.absent(),
    this.discount = const Value.absent(),
    this.grandTotal = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.paymentStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.pdfPath = const Value.absent(),
    this.amountPaid = const Value.absent(),
    this.dueAmount = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.reminderSent = const Value.absent(),
    this.loadingCharge = const Value.absent(),
    this.unloadingCharge = const Value.absent(),
    this.transportCharge = const Value.absent(),
    this.customerId = const Value.absent(),
  });
  InvoicesCompanion.insert({
    this.id = const Value.absent(),
    required String invoiceNo,
    required String customerName,
    required String customerPhone,
    required double subtotal,
    required double tax,
    this.discount = const Value.absent(),
    required double grandTotal,
    this.paymentMethod = const Value.absent(),
    this.paymentStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.pdfPath = const Value.absent(),
    this.amountPaid = const Value.absent(),
    this.dueAmount = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.reminderSent = const Value.absent(),
    this.loadingCharge = const Value.absent(),
    this.unloadingCharge = const Value.absent(),
    this.transportCharge = const Value.absent(),
    this.customerId = const Value.absent(),
  }) : invoiceNo = Value(invoiceNo),
       customerName = Value(customerName),
       customerPhone = Value(customerPhone),
       subtotal = Value(subtotal),
       tax = Value(tax),
       grandTotal = Value(grandTotal);
  static Insertable<Invoice> custom({
    Expression<int>? id,
    Expression<String>? invoiceNo,
    Expression<String>? customerName,
    Expression<String>? customerPhone,
    Expression<double>? subtotal,
    Expression<double>? tax,
    Expression<double>? discount,
    Expression<double>? grandTotal,
    Expression<String>? paymentMethod,
    Expression<String>? paymentStatus,
    Expression<DateTime>? createdAt,
    Expression<String>? pdfPath,
    Expression<double>? amountPaid,
    Expression<double>? dueAmount,
    Expression<DateTime>? dueDate,
    Expression<bool>? reminderSent,
    Expression<double>? loadingCharge,
    Expression<double>? unloadingCharge,
    Expression<double>? transportCharge,
    Expression<int>? customerId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceNo != null) 'invoice_no': invoiceNo,
      if (customerName != null) 'customer_name': customerName,
      if (customerPhone != null) 'customer_phone': customerPhone,
      if (subtotal != null) 'subtotal': subtotal,
      if (tax != null) 'tax': tax,
      if (discount != null) 'discount': discount,
      if (grandTotal != null) 'grand_total': grandTotal,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (paymentStatus != null) 'payment_status': paymentStatus,
      if (createdAt != null) 'created_at': createdAt,
      if (pdfPath != null) 'pdf_path': pdfPath,
      if (amountPaid != null) 'amount_paid': amountPaid,
      if (dueAmount != null) 'due_amount': dueAmount,
      if (dueDate != null) 'due_date': dueDate,
      if (reminderSent != null) 'reminder_sent': reminderSent,
      if (loadingCharge != null) 'loading_charge': loadingCharge,
      if (unloadingCharge != null) 'unloading_charge': unloadingCharge,
      if (transportCharge != null) 'transport_charge': transportCharge,
      if (customerId != null) 'customer_id': customerId,
    });
  }

  InvoicesCompanion copyWith({
    Value<int>? id,
    Value<String>? invoiceNo,
    Value<String>? customerName,
    Value<String>? customerPhone,
    Value<double>? subtotal,
    Value<double>? tax,
    Value<double>? discount,
    Value<double>? grandTotal,
    Value<String>? paymentMethod,
    Value<String>? paymentStatus,
    Value<DateTime>? createdAt,
    Value<String?>? pdfPath,
    Value<double>? amountPaid,
    Value<double>? dueAmount,
    Value<DateTime?>? dueDate,
    Value<bool>? reminderSent,
    Value<double>? loadingCharge,
    Value<double>? unloadingCharge,
    Value<double>? transportCharge,
    Value<int?>? customerId,
  }) {
    return InvoicesCompanion(
      id: id ?? this.id,
      invoiceNo: invoiceNo ?? this.invoiceNo,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      subtotal: subtotal ?? this.subtotal,
      tax: tax ?? this.tax,
      discount: discount ?? this.discount,
      grandTotal: grandTotal ?? this.grandTotal,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      createdAt: createdAt ?? this.createdAt,
      pdfPath: pdfPath ?? this.pdfPath,
      amountPaid: amountPaid ?? this.amountPaid,
      dueAmount: dueAmount ?? this.dueAmount,
      dueDate: dueDate ?? this.dueDate,
      reminderSent: reminderSent ?? this.reminderSent,
      loadingCharge: loadingCharge ?? this.loadingCharge,
      unloadingCharge: unloadingCharge ?? this.unloadingCharge,
      transportCharge: transportCharge ?? this.transportCharge,
      customerId: customerId ?? this.customerId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (invoiceNo.present) {
      map['invoice_no'] = Variable<String>(invoiceNo.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (customerPhone.present) {
      map['customer_phone'] = Variable<String>(customerPhone.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<double>(subtotal.value);
    }
    if (tax.present) {
      map['tax'] = Variable<double>(tax.value);
    }
    if (discount.present) {
      map['discount'] = Variable<double>(discount.value);
    }
    if (grandTotal.present) {
      map['grand_total'] = Variable<double>(grandTotal.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (paymentStatus.present) {
      map['payment_status'] = Variable<String>(paymentStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (pdfPath.present) {
      map['pdf_path'] = Variable<String>(pdfPath.value);
    }
    if (amountPaid.present) {
      map['amount_paid'] = Variable<double>(amountPaid.value);
    }
    if (dueAmount.present) {
      map['due_amount'] = Variable<double>(dueAmount.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (reminderSent.present) {
      map['reminder_sent'] = Variable<bool>(reminderSent.value);
    }
    if (loadingCharge.present) {
      map['loading_charge'] = Variable<double>(loadingCharge.value);
    }
    if (unloadingCharge.present) {
      map['unloading_charge'] = Variable<double>(unloadingCharge.value);
    }
    if (transportCharge.present) {
      map['transport_charge'] = Variable<double>(transportCharge.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoicesCompanion(')
          ..write('id: $id, ')
          ..write('invoiceNo: $invoiceNo, ')
          ..write('customerName: $customerName, ')
          ..write('customerPhone: $customerPhone, ')
          ..write('subtotal: $subtotal, ')
          ..write('tax: $tax, ')
          ..write('discount: $discount, ')
          ..write('grandTotal: $grandTotal, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('pdfPath: $pdfPath, ')
          ..write('amountPaid: $amountPaid, ')
          ..write('dueAmount: $dueAmount, ')
          ..write('dueDate: $dueDate, ')
          ..write('reminderSent: $reminderSent, ')
          ..write('loadingCharge: $loadingCharge, ')
          ..write('unloadingCharge: $unloadingCharge, ')
          ..write('transportCharge: $transportCharge, ')
          ..write('customerId: $customerId')
          ..write(')'))
        .toString();
  }
}

class $InvoiceItemsTable extends InvoiceItems
    with TableInfo<$InvoiceItemsTable, InvoiceItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoiceItemsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<int> invoiceId = GeneratedColumn<int>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _variantIdMeta = const VerificationMeta(
    'variantId',
  );
  @override
  late final GeneratedColumn<int> variantId = GeneratedColumn<int>(
    'variant_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _productNameMeta = const VerificationMeta(
    'productName',
  );
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
    'product_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _variantNameMeta = const VerificationMeta(
    'variantName',
  );
  @override
  late final GeneratedColumn<String> variantName = GeneratedColumn<String>(
    'variant_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double> height = GeneratedColumn<double>(
    'height',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _widthMeta = const VerificationMeta('width');
  @override
  late final GeneratedColumn<double> width = GeneratedColumn<double>(
    'width',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _areaMeta = const VerificationMeta('area');
  @override
  late final GeneratedColumn<double> area = GeneratedColumn<double>(
    'area',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    invoiceId,
    productId,
    variantId,
    productName,
    variantName,
    quantity,
    price,
    height,
    width,
    area,
    total,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoice_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<InvoiceItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('variant_id')) {
      context.handle(
        _variantIdMeta,
        variantId.isAcceptableOrUnknown(data['variant_id']!, _variantIdMeta),
      );
    }
    if (data.containsKey('product_name')) {
      context.handle(
        _productNameMeta,
        productName.isAcceptableOrUnknown(
          data['product_name']!,
          _productNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('variant_name')) {
      context.handle(
        _variantNameMeta,
        variantName.isAcceptableOrUnknown(
          data['variant_name']!,
          _variantNameMeta,
        ),
      );
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    }
    if (data.containsKey('width')) {
      context.handle(
        _widthMeta,
        width.isAcceptableOrUnknown(data['width']!, _widthMeta),
      );
    }
    if (data.containsKey('area')) {
      context.handle(
        _areaMeta,
        area.isAcceptableOrUnknown(data['area']!, _areaMeta),
      );
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InvoiceItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvoiceItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}invoice_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      variantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}variant_id'],
      ),
      productName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_name'],
      )!,
      variantName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variant_name'],
      ),
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height'],
      ),
      width: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}width'],
      ),
      area: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}area'],
      ),
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $InvoiceItemsTable createAlias(String alias) {
    return $InvoiceItemsTable(attachedDatabase, alias);
  }
}

class InvoiceItem extends DataClass implements Insertable<InvoiceItem> {
  final int id;

  /// INVOICE ID
  final int invoiceId;

  /// PRODUCT ID
  final int productId;

  /// VARIANT ID
  final int? variantId;

  /// PRODUCT NAME SNAPSHOT
  final String productName;

  /// VARIANT NAME SNAPSHOT
  final String? variantName;

  /// QUANTITY
  final int quantity;

  /// PRICE AT SALE TIME
  final double price;

  /// AREA PRODUCTS
  final double? height;
  final double? width;
  final double? area;

  /// TOTAL
  final double total;

  /// CREATED DATE
  final DateTime createdAt;
  const InvoiceItem({
    required this.id,
    required this.invoiceId,
    required this.productId,
    this.variantId,
    required this.productName,
    this.variantName,
    required this.quantity,
    required this.price,
    this.height,
    this.width,
    this.area,
    required this.total,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['invoice_id'] = Variable<int>(invoiceId);
    map['product_id'] = Variable<int>(productId);
    if (!nullToAbsent || variantId != null) {
      map['variant_id'] = Variable<int>(variantId);
    }
    map['product_name'] = Variable<String>(productName);
    if (!nullToAbsent || variantName != null) {
      map['variant_name'] = Variable<String>(variantName);
    }
    map['quantity'] = Variable<int>(quantity);
    map['price'] = Variable<double>(price);
    if (!nullToAbsent || height != null) {
      map['height'] = Variable<double>(height);
    }
    if (!nullToAbsent || width != null) {
      map['width'] = Variable<double>(width);
    }
    if (!nullToAbsent || area != null) {
      map['area'] = Variable<double>(area);
    }
    map['total'] = Variable<double>(total);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  InvoiceItemsCompanion toCompanion(bool nullToAbsent) {
    return InvoiceItemsCompanion(
      id: Value(id),
      invoiceId: Value(invoiceId),
      productId: Value(productId),
      variantId: variantId == null && nullToAbsent
          ? const Value.absent()
          : Value(variantId),
      productName: Value(productName),
      variantName: variantName == null && nullToAbsent
          ? const Value.absent()
          : Value(variantName),
      quantity: Value(quantity),
      price: Value(price),
      height: height == null && nullToAbsent
          ? const Value.absent()
          : Value(height),
      width: width == null && nullToAbsent
          ? const Value.absent()
          : Value(width),
      area: area == null && nullToAbsent ? const Value.absent() : Value(area),
      total: Value(total),
      createdAt: Value(createdAt),
    );
  }

  factory InvoiceItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvoiceItem(
      id: serializer.fromJson<int>(json['id']),
      invoiceId: serializer.fromJson<int>(json['invoiceId']),
      productId: serializer.fromJson<int>(json['productId']),
      variantId: serializer.fromJson<int?>(json['variantId']),
      productName: serializer.fromJson<String>(json['productName']),
      variantName: serializer.fromJson<String?>(json['variantName']),
      quantity: serializer.fromJson<int>(json['quantity']),
      price: serializer.fromJson<double>(json['price']),
      height: serializer.fromJson<double?>(json['height']),
      width: serializer.fromJson<double?>(json['width']),
      area: serializer.fromJson<double?>(json['area']),
      total: serializer.fromJson<double>(json['total']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'invoiceId': serializer.toJson<int>(invoiceId),
      'productId': serializer.toJson<int>(productId),
      'variantId': serializer.toJson<int?>(variantId),
      'productName': serializer.toJson<String>(productName),
      'variantName': serializer.toJson<String?>(variantName),
      'quantity': serializer.toJson<int>(quantity),
      'price': serializer.toJson<double>(price),
      'height': serializer.toJson<double?>(height),
      'width': serializer.toJson<double?>(width),
      'area': serializer.toJson<double?>(area),
      'total': serializer.toJson<double>(total),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  InvoiceItem copyWith({
    int? id,
    int? invoiceId,
    int? productId,
    Value<int?> variantId = const Value.absent(),
    String? productName,
    Value<String?> variantName = const Value.absent(),
    int? quantity,
    double? price,
    Value<double?> height = const Value.absent(),
    Value<double?> width = const Value.absent(),
    Value<double?> area = const Value.absent(),
    double? total,
    DateTime? createdAt,
  }) => InvoiceItem(
    id: id ?? this.id,
    invoiceId: invoiceId ?? this.invoiceId,
    productId: productId ?? this.productId,
    variantId: variantId.present ? variantId.value : this.variantId,
    productName: productName ?? this.productName,
    variantName: variantName.present ? variantName.value : this.variantName,
    quantity: quantity ?? this.quantity,
    price: price ?? this.price,
    height: height.present ? height.value : this.height,
    width: width.present ? width.value : this.width,
    area: area.present ? area.value : this.area,
    total: total ?? this.total,
    createdAt: createdAt ?? this.createdAt,
  );
  InvoiceItem copyWithCompanion(InvoiceItemsCompanion data) {
    return InvoiceItem(
      id: data.id.present ? data.id.value : this.id,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      productId: data.productId.present ? data.productId.value : this.productId,
      variantId: data.variantId.present ? data.variantId.value : this.variantId,
      productName: data.productName.present
          ? data.productName.value
          : this.productName,
      variantName: data.variantName.present
          ? data.variantName.value
          : this.variantName,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      price: data.price.present ? data.price.value : this.price,
      height: data.height.present ? data.height.value : this.height,
      width: data.width.present ? data.width.value : this.width,
      area: data.area.present ? data.area.value : this.area,
      total: data.total.present ? data.total.value : this.total,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceItem(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('productId: $productId, ')
          ..write('variantId: $variantId, ')
          ..write('productName: $productName, ')
          ..write('variantName: $variantName, ')
          ..write('quantity: $quantity, ')
          ..write('price: $price, ')
          ..write('height: $height, ')
          ..write('width: $width, ')
          ..write('area: $area, ')
          ..write('total: $total, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    invoiceId,
    productId,
    variantId,
    productName,
    variantName,
    quantity,
    price,
    height,
    width,
    area,
    total,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvoiceItem &&
          other.id == this.id &&
          other.invoiceId == this.invoiceId &&
          other.productId == this.productId &&
          other.variantId == this.variantId &&
          other.productName == this.productName &&
          other.variantName == this.variantName &&
          other.quantity == this.quantity &&
          other.price == this.price &&
          other.height == this.height &&
          other.width == this.width &&
          other.area == this.area &&
          other.total == this.total &&
          other.createdAt == this.createdAt);
}

class InvoiceItemsCompanion extends UpdateCompanion<InvoiceItem> {
  final Value<int> id;
  final Value<int> invoiceId;
  final Value<int> productId;
  final Value<int?> variantId;
  final Value<String> productName;
  final Value<String?> variantName;
  final Value<int> quantity;
  final Value<double> price;
  final Value<double?> height;
  final Value<double?> width;
  final Value<double?> area;
  final Value<double> total;
  final Value<DateTime> createdAt;
  const InvoiceItemsCompanion({
    this.id = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.productId = const Value.absent(),
    this.variantId = const Value.absent(),
    this.productName = const Value.absent(),
    this.variantName = const Value.absent(),
    this.quantity = const Value.absent(),
    this.price = const Value.absent(),
    this.height = const Value.absent(),
    this.width = const Value.absent(),
    this.area = const Value.absent(),
    this.total = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  InvoiceItemsCompanion.insert({
    this.id = const Value.absent(),
    required int invoiceId,
    required int productId,
    this.variantId = const Value.absent(),
    required String productName,
    this.variantName = const Value.absent(),
    required int quantity,
    required double price,
    this.height = const Value.absent(),
    this.width = const Value.absent(),
    this.area = const Value.absent(),
    required double total,
    this.createdAt = const Value.absent(),
  }) : invoiceId = Value(invoiceId),
       productId = Value(productId),
       productName = Value(productName),
       quantity = Value(quantity),
       price = Value(price),
       total = Value(total);
  static Insertable<InvoiceItem> custom({
    Expression<int>? id,
    Expression<int>? invoiceId,
    Expression<int>? productId,
    Expression<int>? variantId,
    Expression<String>? productName,
    Expression<String>? variantName,
    Expression<int>? quantity,
    Expression<double>? price,
    Expression<double>? height,
    Expression<double>? width,
    Expression<double>? area,
    Expression<double>? total,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (productId != null) 'product_id': productId,
      if (variantId != null) 'variant_id': variantId,
      if (productName != null) 'product_name': productName,
      if (variantName != null) 'variant_name': variantName,
      if (quantity != null) 'quantity': quantity,
      if (price != null) 'price': price,
      if (height != null) 'height': height,
      if (width != null) 'width': width,
      if (area != null) 'area': area,
      if (total != null) 'total': total,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  InvoiceItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? invoiceId,
    Value<int>? productId,
    Value<int?>? variantId,
    Value<String>? productName,
    Value<String?>? variantName,
    Value<int>? quantity,
    Value<double>? price,
    Value<double?>? height,
    Value<double?>? width,
    Value<double?>? area,
    Value<double>? total,
    Value<DateTime>? createdAt,
  }) {
    return InvoiceItemsCompanion(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      productId: productId ?? this.productId,
      variantId: variantId ?? this.variantId,
      productName: productName ?? this.productName,
      variantName: variantName ?? this.variantName,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      height: height ?? this.height,
      width: width ?? this.width,
      area: area ?? this.area,
      total: total ?? this.total,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<int>(invoiceId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (variantId.present) {
      map['variant_id'] = Variable<int>(variantId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (variantName.present) {
      map['variant_name'] = Variable<String>(variantName.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (width.present) {
      map['width'] = Variable<double>(width.value);
    }
    if (area.present) {
      map['area'] = Variable<double>(area.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceItemsCompanion(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('productId: $productId, ')
          ..write('variantId: $variantId, ')
          ..write('productName: $productName, ')
          ..write('variantName: $variantName, ')
          ..write('quantity: $quantity, ')
          ..write('price: $price, ')
          ..write('height: $height, ')
          ..write('width: $width, ')
          ..write('area: $area, ')
          ..write('total: $total, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PaymentHistoriesTable extends PaymentHistories
    with TableInfo<$PaymentHistoriesTable, PaymentHistory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentHistoriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<int> invoiceId = GeneratedColumn<int>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Cash'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paidAtMeta = const VerificationMeta('paidAt');
  @override
  late final GeneratedColumn<DateTime> paidAt = GeneratedColumn<DateTime>(
    'paid_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    invoiceId,
    customerId,
    amount,
    paymentMethod,
    notes,
    paidAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payment_histories';
  @override
  VerificationContext validateIntegrity(
    Insertable<PaymentHistory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('paid_at')) {
      context.handle(
        _paidAtMeta,
        paidAt.isAcceptableOrUnknown(data['paid_at']!, _paidAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PaymentHistory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentHistory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}invoice_id'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}customer_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      paidAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}paid_at'],
      )!,
    );
  }

  @override
  $PaymentHistoriesTable createAlias(String alias) {
    return $PaymentHistoriesTable(attachedDatabase, alias);
  }
}

class PaymentHistory extends DataClass implements Insertable<PaymentHistory> {
  final int id;
  final int invoiceId;
  final int customerId;
  final double amount;
  final String paymentMethod;
  final String? notes;
  final DateTime paidAt;
  const PaymentHistory({
    required this.id,
    required this.invoiceId,
    required this.customerId,
    required this.amount,
    required this.paymentMethod,
    this.notes,
    required this.paidAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['invoice_id'] = Variable<int>(invoiceId);
    map['customer_id'] = Variable<int>(customerId);
    map['amount'] = Variable<double>(amount);
    map['payment_method'] = Variable<String>(paymentMethod);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['paid_at'] = Variable<DateTime>(paidAt);
    return map;
  }

  PaymentHistoriesCompanion toCompanion(bool nullToAbsent) {
    return PaymentHistoriesCompanion(
      id: Value(id),
      invoiceId: Value(invoiceId),
      customerId: Value(customerId),
      amount: Value(amount),
      paymentMethod: Value(paymentMethod),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      paidAt: Value(paidAt),
    );
  }

  factory PaymentHistory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentHistory(
      id: serializer.fromJson<int>(json['id']),
      invoiceId: serializer.fromJson<int>(json['invoiceId']),
      customerId: serializer.fromJson<int>(json['customerId']),
      amount: serializer.fromJson<double>(json['amount']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      notes: serializer.fromJson<String?>(json['notes']),
      paidAt: serializer.fromJson<DateTime>(json['paidAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'invoiceId': serializer.toJson<int>(invoiceId),
      'customerId': serializer.toJson<int>(customerId),
      'amount': serializer.toJson<double>(amount),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'notes': serializer.toJson<String?>(notes),
      'paidAt': serializer.toJson<DateTime>(paidAt),
    };
  }

  PaymentHistory copyWith({
    int? id,
    int? invoiceId,
    int? customerId,
    double? amount,
    String? paymentMethod,
    Value<String?> notes = const Value.absent(),
    DateTime? paidAt,
  }) => PaymentHistory(
    id: id ?? this.id,
    invoiceId: invoiceId ?? this.invoiceId,
    customerId: customerId ?? this.customerId,
    amount: amount ?? this.amount,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    notes: notes.present ? notes.value : this.notes,
    paidAt: paidAt ?? this.paidAt,
  );
  PaymentHistory copyWithCompanion(PaymentHistoriesCompanion data) {
    return PaymentHistory(
      id: data.id.present ? data.id.value : this.id,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      amount: data.amount.present ? data.amount.value : this.amount,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      notes: data.notes.present ? data.notes.value : this.notes,
      paidAt: data.paidAt.present ? data.paidAt.value : this.paidAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentHistory(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('customerId: $customerId, ')
          ..write('amount: $amount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('notes: $notes, ')
          ..write('paidAt: $paidAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    invoiceId,
    customerId,
    amount,
    paymentMethod,
    notes,
    paidAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentHistory &&
          other.id == this.id &&
          other.invoiceId == this.invoiceId &&
          other.customerId == this.customerId &&
          other.amount == this.amount &&
          other.paymentMethod == this.paymentMethod &&
          other.notes == this.notes &&
          other.paidAt == this.paidAt);
}

class PaymentHistoriesCompanion extends UpdateCompanion<PaymentHistory> {
  final Value<int> id;
  final Value<int> invoiceId;
  final Value<int> customerId;
  final Value<double> amount;
  final Value<String> paymentMethod;
  final Value<String?> notes;
  final Value<DateTime> paidAt;
  const PaymentHistoriesCompanion({
    this.id = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.customerId = const Value.absent(),
    this.amount = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.notes = const Value.absent(),
    this.paidAt = const Value.absent(),
  });
  PaymentHistoriesCompanion.insert({
    this.id = const Value.absent(),
    required int invoiceId,
    required int customerId,
    required double amount,
    this.paymentMethod = const Value.absent(),
    this.notes = const Value.absent(),
    this.paidAt = const Value.absent(),
  }) : invoiceId = Value(invoiceId),
       customerId = Value(customerId),
       amount = Value(amount);
  static Insertable<PaymentHistory> custom({
    Expression<int>? id,
    Expression<int>? invoiceId,
    Expression<int>? customerId,
    Expression<double>? amount,
    Expression<String>? paymentMethod,
    Expression<String>? notes,
    Expression<DateTime>? paidAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (customerId != null) 'customer_id': customerId,
      if (amount != null) 'amount': amount,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (notes != null) 'notes': notes,
      if (paidAt != null) 'paid_at': paidAt,
    });
  }

  PaymentHistoriesCompanion copyWith({
    Value<int>? id,
    Value<int>? invoiceId,
    Value<int>? customerId,
    Value<double>? amount,
    Value<String>? paymentMethod,
    Value<String?>? notes,
    Value<DateTime>? paidAt,
  }) {
    return PaymentHistoriesCompanion(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      customerId: customerId ?? this.customerId,
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      notes: notes ?? this.notes,
      paidAt: paidAt ?? this.paidAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<int>(invoiceId.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (paidAt.present) {
      map['paid_at'] = Variable<DateTime>(paidAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentHistoriesCompanion(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('customerId: $customerId, ')
          ..write('amount: $amount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('notes: $notes, ')
          ..write('paidAt: $paidAt')
          ..write(')'))
        .toString();
  }
}

class $ProductVariantsTable extends ProductVariants
    with TableInfo<$ProductVariantsTable, ProductVariant> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductVariantsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id)',
    ),
  );
  static const VerificationMeta _variantNameMeta = const VerificationMeta(
    'variantName',
  );
  @override
  late final GeneratedColumn<String> variantName = GeneratedColumn<String>(
    'variant_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _thicknessMeta = const VerificationMeta(
    'thickness',
  );
  @override
  late final GeneratedColumn<String> thickness = GeneratedColumn<String>(
    'thickness',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<String> size = GeneratedColumn<String>(
    'size',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _purchasePriceMeta = const VerificationMeta(
    'purchasePrice',
  );
  @override
  late final GeneratedColumn<double> purchasePrice = GeneratedColumn<double>(
    'purchase_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sellingPriceMeta = const VerificationMeta(
    'sellingPrice',
  );
  @override
  late final GeneratedColumn<double> sellingPrice = GeneratedColumn<double>(
    'selling_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stockQtyMeta = const VerificationMeta(
    'stockQty',
  );
  @override
  late final GeneratedColumn<double> stockQty = GeneratedColumn<double>(
    'stock_qty',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    variantName,
    thickness,
    color,
    size,
    purchasePrice,
    sellingPrice,
    stockQty,
    isActive,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_variants';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductVariant> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('variant_name')) {
      context.handle(
        _variantNameMeta,
        variantName.isAcceptableOrUnknown(
          data['variant_name']!,
          _variantNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_variantNameMeta);
    }
    if (data.containsKey('thickness')) {
      context.handle(
        _thicknessMeta,
        thickness.isAcceptableOrUnknown(data['thickness']!, _thicknessMeta),
      );
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('size')) {
      context.handle(
        _sizeMeta,
        size.isAcceptableOrUnknown(data['size']!, _sizeMeta),
      );
    }
    if (data.containsKey('purchase_price')) {
      context.handle(
        _purchasePriceMeta,
        purchasePrice.isAcceptableOrUnknown(
          data['purchase_price']!,
          _purchasePriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchasePriceMeta);
    }
    if (data.containsKey('selling_price')) {
      context.handle(
        _sellingPriceMeta,
        sellingPrice.isAcceptableOrUnknown(
          data['selling_price']!,
          _sellingPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sellingPriceMeta);
    }
    if (data.containsKey('stock_qty')) {
      context.handle(
        _stockQtyMeta,
        stockQty.isAcceptableOrUnknown(data['stock_qty']!, _stockQtyMeta),
      );
    } else if (isInserting) {
      context.missing(_stockQtyMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductVariant map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductVariant(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      variantName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variant_name'],
      )!,
      thickness: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thickness'],
      ),
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      ),
      size: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}size'],
      ),
      purchasePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}purchase_price'],
      )!,
      sellingPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}selling_price'],
      )!,
      stockQty: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}stock_qty'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ProductVariantsTable createAlias(String alias) {
    return $ProductVariantsTable(attachedDatabase, alias);
  }
}

class ProductVariant extends DataClass implements Insertable<ProductVariant> {
  final int id;
  final int productId;
  final String variantName;
  final String? thickness;
  final String? color;
  final String? size;
  final double purchasePrice;
  final double sellingPrice;
  final double stockQty;
  final bool isActive;
  final DateTime createdAt;
  const ProductVariant({
    required this.id,
    required this.productId,
    required this.variantName,
    this.thickness,
    this.color,
    this.size,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.stockQty,
    required this.isActive,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    map['variant_name'] = Variable<String>(variantName);
    if (!nullToAbsent || thickness != null) {
      map['thickness'] = Variable<String>(thickness);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    if (!nullToAbsent || size != null) {
      map['size'] = Variable<String>(size);
    }
    map['purchase_price'] = Variable<double>(purchasePrice);
    map['selling_price'] = Variable<double>(sellingPrice);
    map['stock_qty'] = Variable<double>(stockQty);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ProductVariantsCompanion toCompanion(bool nullToAbsent) {
    return ProductVariantsCompanion(
      id: Value(id),
      productId: Value(productId),
      variantName: Value(variantName),
      thickness: thickness == null && nullToAbsent
          ? const Value.absent()
          : Value(thickness),
      color: color == null && nullToAbsent
          ? const Value.absent()
          : Value(color),
      size: size == null && nullToAbsent ? const Value.absent() : Value(size),
      purchasePrice: Value(purchasePrice),
      sellingPrice: Value(sellingPrice),
      stockQty: Value(stockQty),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory ProductVariant.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductVariant(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      variantName: serializer.fromJson<String>(json['variantName']),
      thickness: serializer.fromJson<String?>(json['thickness']),
      color: serializer.fromJson<String?>(json['color']),
      size: serializer.fromJson<String?>(json['size']),
      purchasePrice: serializer.fromJson<double>(json['purchasePrice']),
      sellingPrice: serializer.fromJson<double>(json['sellingPrice']),
      stockQty: serializer.fromJson<double>(json['stockQty']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'variantName': serializer.toJson<String>(variantName),
      'thickness': serializer.toJson<String?>(thickness),
      'color': serializer.toJson<String?>(color),
      'size': serializer.toJson<String?>(size),
      'purchasePrice': serializer.toJson<double>(purchasePrice),
      'sellingPrice': serializer.toJson<double>(sellingPrice),
      'stockQty': serializer.toJson<double>(stockQty),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ProductVariant copyWith({
    int? id,
    int? productId,
    String? variantName,
    Value<String?> thickness = const Value.absent(),
    Value<String?> color = const Value.absent(),
    Value<String?> size = const Value.absent(),
    double? purchasePrice,
    double? sellingPrice,
    double? stockQty,
    bool? isActive,
    DateTime? createdAt,
  }) => ProductVariant(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    variantName: variantName ?? this.variantName,
    thickness: thickness.present ? thickness.value : this.thickness,
    color: color.present ? color.value : this.color,
    size: size.present ? size.value : this.size,
    purchasePrice: purchasePrice ?? this.purchasePrice,
    sellingPrice: sellingPrice ?? this.sellingPrice,
    stockQty: stockQty ?? this.stockQty,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
  );
  ProductVariant copyWithCompanion(ProductVariantsCompanion data) {
    return ProductVariant(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      variantName: data.variantName.present
          ? data.variantName.value
          : this.variantName,
      thickness: data.thickness.present ? data.thickness.value : this.thickness,
      color: data.color.present ? data.color.value : this.color,
      size: data.size.present ? data.size.value : this.size,
      purchasePrice: data.purchasePrice.present
          ? data.purchasePrice.value
          : this.purchasePrice,
      sellingPrice: data.sellingPrice.present
          ? data.sellingPrice.value
          : this.sellingPrice,
      stockQty: data.stockQty.present ? data.stockQty.value : this.stockQty,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductVariant(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('variantName: $variantName, ')
          ..write('thickness: $thickness, ')
          ..write('color: $color, ')
          ..write('size: $size, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('sellingPrice: $sellingPrice, ')
          ..write('stockQty: $stockQty, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productId,
    variantName,
    thickness,
    color,
    size,
    purchasePrice,
    sellingPrice,
    stockQty,
    isActive,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductVariant &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.variantName == this.variantName &&
          other.thickness == this.thickness &&
          other.color == this.color &&
          other.size == this.size &&
          other.purchasePrice == this.purchasePrice &&
          other.sellingPrice == this.sellingPrice &&
          other.stockQty == this.stockQty &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class ProductVariantsCompanion extends UpdateCompanion<ProductVariant> {
  final Value<int> id;
  final Value<int> productId;
  final Value<String> variantName;
  final Value<String?> thickness;
  final Value<String?> color;
  final Value<String?> size;
  final Value<double> purchasePrice;
  final Value<double> sellingPrice;
  final Value<double> stockQty;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  const ProductVariantsCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.variantName = const Value.absent(),
    this.thickness = const Value.absent(),
    this.color = const Value.absent(),
    this.size = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.sellingPrice = const Value.absent(),
    this.stockQty = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ProductVariantsCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    required String variantName,
    this.thickness = const Value.absent(),
    this.color = const Value.absent(),
    this.size = const Value.absent(),
    required double purchasePrice,
    required double sellingPrice,
    required double stockQty,
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : productId = Value(productId),
       variantName = Value(variantName),
       purchasePrice = Value(purchasePrice),
       sellingPrice = Value(sellingPrice),
       stockQty = Value(stockQty);
  static Insertable<ProductVariant> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<String>? variantName,
    Expression<String>? thickness,
    Expression<String>? color,
    Expression<String>? size,
    Expression<double>? purchasePrice,
    Expression<double>? sellingPrice,
    Expression<double>? stockQty,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (variantName != null) 'variant_name': variantName,
      if (thickness != null) 'thickness': thickness,
      if (color != null) 'color': color,
      if (size != null) 'size': size,
      if (purchasePrice != null) 'purchase_price': purchasePrice,
      if (sellingPrice != null) 'selling_price': sellingPrice,
      if (stockQty != null) 'stock_qty': stockQty,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ProductVariantsCompanion copyWith({
    Value<int>? id,
    Value<int>? productId,
    Value<String>? variantName,
    Value<String?>? thickness,
    Value<String?>? color,
    Value<String?>? size,
    Value<double>? purchasePrice,
    Value<double>? sellingPrice,
    Value<double>? stockQty,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
  }) {
    return ProductVariantsCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      variantName: variantName ?? this.variantName,
      thickness: thickness ?? this.thickness,
      color: color ?? this.color,
      size: size ?? this.size,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      stockQty: stockQty ?? this.stockQty,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (variantName.present) {
      map['variant_name'] = Variable<String>(variantName.value);
    }
    if (thickness.present) {
      map['thickness'] = Variable<String>(thickness.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (size.present) {
      map['size'] = Variable<String>(size.value);
    }
    if (purchasePrice.present) {
      map['purchase_price'] = Variable<double>(purchasePrice.value);
    }
    if (sellingPrice.present) {
      map['selling_price'] = Variable<double>(sellingPrice.value);
    }
    if (stockQty.present) {
      map['stock_qty'] = Variable<double>(stockQty.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductVariantsCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('variantName: $variantName, ')
          ..write('thickness: $thickness, ')
          ..write('color: $color, ')
          ..write('size: $size, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('sellingPrice: $sellingPrice, ')
          ..write('stockQty: $stockQty, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SupplierPaymentHistoriesTable extends SupplierPaymentHistories
    with TableInfo<$SupplierPaymentHistoriesTable, SupplierPaymentHistory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SupplierPaymentHistoriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _supplierIdMeta = const VerificationMeta(
    'supplierId',
  );
  @override
  late final GeneratedColumn<int> supplierId = GeneratedColumn<int>(
    'supplier_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _purchaseIdMeta = const VerificationMeta(
    'purchaseId',
  );
  @override
  late final GeneratedColumn<int> purchaseId = GeneratedColumn<int>(
    'purchase_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Cash'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    supplierId,
    purchaseId,
    amount,
    paymentMethod,
    notes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'supplier_payment_histories';
  @override
  VerificationContext validateIntegrity(
    Insertable<SupplierPaymentHistory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
        _supplierIdMeta,
        supplierId.isAcceptableOrUnknown(data['supplier_id']!, _supplierIdMeta),
      );
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    if (data.containsKey('purchase_id')) {
      context.handle(
        _purchaseIdMeta,
        purchaseId.isAcceptableOrUnknown(data['purchase_id']!, _purchaseIdMeta),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SupplierPaymentHistory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SupplierPaymentHistory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      supplierId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}supplier_id'],
      )!,
      purchaseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}purchase_id'],
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SupplierPaymentHistoriesTable createAlias(String alias) {
    return $SupplierPaymentHistoriesTable(attachedDatabase, alias);
  }
}

class SupplierPaymentHistory extends DataClass
    implements Insertable<SupplierPaymentHistory> {
  final int id;
  final int supplierId;
  final int? purchaseId;
  final double amount;
  final String paymentMethod;
  final String? notes;
  final DateTime createdAt;
  const SupplierPaymentHistory({
    required this.id,
    required this.supplierId,
    this.purchaseId,
    required this.amount,
    required this.paymentMethod,
    this.notes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['supplier_id'] = Variable<int>(supplierId);
    if (!nullToAbsent || purchaseId != null) {
      map['purchase_id'] = Variable<int>(purchaseId);
    }
    map['amount'] = Variable<double>(amount);
    map['payment_method'] = Variable<String>(paymentMethod);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SupplierPaymentHistoriesCompanion toCompanion(bool nullToAbsent) {
    return SupplierPaymentHistoriesCompanion(
      id: Value(id),
      supplierId: Value(supplierId),
      purchaseId: purchaseId == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseId),
      amount: Value(amount),
      paymentMethod: Value(paymentMethod),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory SupplierPaymentHistory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SupplierPaymentHistory(
      id: serializer.fromJson<int>(json['id']),
      supplierId: serializer.fromJson<int>(json['supplierId']),
      purchaseId: serializer.fromJson<int?>(json['purchaseId']),
      amount: serializer.fromJson<double>(json['amount']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'supplierId': serializer.toJson<int>(supplierId),
      'purchaseId': serializer.toJson<int?>(purchaseId),
      'amount': serializer.toJson<double>(amount),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SupplierPaymentHistory copyWith({
    int? id,
    int? supplierId,
    Value<int?> purchaseId = const Value.absent(),
    double? amount,
    String? paymentMethod,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
  }) => SupplierPaymentHistory(
    id: id ?? this.id,
    supplierId: supplierId ?? this.supplierId,
    purchaseId: purchaseId.present ? purchaseId.value : this.purchaseId,
    amount: amount ?? this.amount,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  SupplierPaymentHistory copyWithCompanion(
    SupplierPaymentHistoriesCompanion data,
  ) {
    return SupplierPaymentHistory(
      id: data.id.present ? data.id.value : this.id,
      supplierId: data.supplierId.present
          ? data.supplierId.value
          : this.supplierId,
      purchaseId: data.purchaseId.present
          ? data.purchaseId.value
          : this.purchaseId,
      amount: data.amount.present ? data.amount.value : this.amount,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SupplierPaymentHistory(')
          ..write('id: $id, ')
          ..write('supplierId: $supplierId, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('amount: $amount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    supplierId,
    purchaseId,
    amount,
    paymentMethod,
    notes,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SupplierPaymentHistory &&
          other.id == this.id &&
          other.supplierId == this.supplierId &&
          other.purchaseId == this.purchaseId &&
          other.amount == this.amount &&
          other.paymentMethod == this.paymentMethod &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class SupplierPaymentHistoriesCompanion
    extends UpdateCompanion<SupplierPaymentHistory> {
  final Value<int> id;
  final Value<int> supplierId;
  final Value<int?> purchaseId;
  final Value<double> amount;
  final Value<String> paymentMethod;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  const SupplierPaymentHistoriesCompanion({
    this.id = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.purchaseId = const Value.absent(),
    this.amount = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SupplierPaymentHistoriesCompanion.insert({
    this.id = const Value.absent(),
    required int supplierId,
    this.purchaseId = const Value.absent(),
    required double amount,
    this.paymentMethod = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : supplierId = Value(supplierId),
       amount = Value(amount);
  static Insertable<SupplierPaymentHistory> custom({
    Expression<int>? id,
    Expression<int>? supplierId,
    Expression<int>? purchaseId,
    Expression<double>? amount,
    Expression<String>? paymentMethod,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (supplierId != null) 'supplier_id': supplierId,
      if (purchaseId != null) 'purchase_id': purchaseId,
      if (amount != null) 'amount': amount,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SupplierPaymentHistoriesCompanion copyWith({
    Value<int>? id,
    Value<int>? supplierId,
    Value<int?>? purchaseId,
    Value<double>? amount,
    Value<String>? paymentMethod,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
  }) {
    return SupplierPaymentHistoriesCompanion(
      id: id ?? this.id,
      supplierId: supplierId ?? this.supplierId,
      purchaseId: purchaseId ?? this.purchaseId,
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<int>(supplierId.value);
    }
    if (purchaseId.present) {
      map['purchase_id'] = Variable<int>(purchaseId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SupplierPaymentHistoriesCompanion(')
          ..write('id: $id, ')
          ..write('supplierId: $supplierId, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('amount: $amount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PurchaseReturnsTable extends PurchaseReturns
    with TableInfo<$PurchaseReturnsTable, PurchaseReturn> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchaseReturnsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _purchaseIdMeta = const VerificationMeta(
    'purchaseId',
  );
  @override
  late final GeneratedColumn<int> purchaseId = GeneratedColumn<int>(
    'purchase_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _supplierIdMeta = const VerificationMeta(
    'supplierId',
  );
  @override
  late final GeneratedColumn<int> supplierId = GeneratedColumn<int>(
    'supplier_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _variantIdMeta = const VerificationMeta(
    'variantId',
  );
  @override
  late final GeneratedColumn<int> variantId = GeneratedColumn<int>(
    'variant_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _refundStatusMeta = const VerificationMeta(
    'refundStatus',
  );
  @override
  late final GeneratedColumn<String> refundStatus = GeneratedColumn<String>(
    'refund_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('PENDING'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    purchaseId,
    supplierId,
    productId,
    variantId,
    reason,
    quantity,
    amount,
    refundStatus,
    notes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchase_returns';
  @override
  VerificationContext validateIntegrity(
    Insertable<PurchaseReturn> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('purchase_id')) {
      context.handle(
        _purchaseIdMeta,
        purchaseId.isAcceptableOrUnknown(data['purchase_id']!, _purchaseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_purchaseIdMeta);
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
        _supplierIdMeta,
        supplierId.isAcceptableOrUnknown(data['supplier_id']!, _supplierIdMeta),
      );
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('variant_id')) {
      context.handle(
        _variantIdMeta,
        variantId.isAcceptableOrUnknown(data['variant_id']!, _variantIdMeta),
      );
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('refund_status')) {
      context.handle(
        _refundStatusMeta,
        refundStatus.isAcceptableOrUnknown(
          data['refund_status']!,
          _refundStatusMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PurchaseReturn map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchaseReturn(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      purchaseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}purchase_id'],
      )!,
      supplierId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}supplier_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      variantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}variant_id'],
      ),
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      refundStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}refund_status'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PurchaseReturnsTable createAlias(String alias) {
    return $PurchaseReturnsTable(attachedDatabase, alias);
  }
}

class PurchaseReturn extends DataClass implements Insertable<PurchaseReturn> {
  final int id;
  final int purchaseId;
  final int supplierId;
  final int productId;
  final int? variantId;
  final String reason;
  final int quantity;
  final double amount;
  final String refundStatus;
  final String? notes;
  final DateTime createdAt;
  const PurchaseReturn({
    required this.id,
    required this.purchaseId,
    required this.supplierId,
    required this.productId,
    this.variantId,
    required this.reason,
    required this.quantity,
    required this.amount,
    required this.refundStatus,
    this.notes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['purchase_id'] = Variable<int>(purchaseId);
    map['supplier_id'] = Variable<int>(supplierId);
    map['product_id'] = Variable<int>(productId);
    if (!nullToAbsent || variantId != null) {
      map['variant_id'] = Variable<int>(variantId);
    }
    map['reason'] = Variable<String>(reason);
    map['quantity'] = Variable<int>(quantity);
    map['amount'] = Variable<double>(amount);
    map['refund_status'] = Variable<String>(refundStatus);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PurchaseReturnsCompanion toCompanion(bool nullToAbsent) {
    return PurchaseReturnsCompanion(
      id: Value(id),
      purchaseId: Value(purchaseId),
      supplierId: Value(supplierId),
      productId: Value(productId),
      variantId: variantId == null && nullToAbsent
          ? const Value.absent()
          : Value(variantId),
      reason: Value(reason),
      quantity: Value(quantity),
      amount: Value(amount),
      refundStatus: Value(refundStatus),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory PurchaseReturn.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchaseReturn(
      id: serializer.fromJson<int>(json['id']),
      purchaseId: serializer.fromJson<int>(json['purchaseId']),
      supplierId: serializer.fromJson<int>(json['supplierId']),
      productId: serializer.fromJson<int>(json['productId']),
      variantId: serializer.fromJson<int?>(json['variantId']),
      reason: serializer.fromJson<String>(json['reason']),
      quantity: serializer.fromJson<int>(json['quantity']),
      amount: serializer.fromJson<double>(json['amount']),
      refundStatus: serializer.fromJson<String>(json['refundStatus']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'purchaseId': serializer.toJson<int>(purchaseId),
      'supplierId': serializer.toJson<int>(supplierId),
      'productId': serializer.toJson<int>(productId),
      'variantId': serializer.toJson<int?>(variantId),
      'reason': serializer.toJson<String>(reason),
      'quantity': serializer.toJson<int>(quantity),
      'amount': serializer.toJson<double>(amount),
      'refundStatus': serializer.toJson<String>(refundStatus),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PurchaseReturn copyWith({
    int? id,
    int? purchaseId,
    int? supplierId,
    int? productId,
    Value<int?> variantId = const Value.absent(),
    String? reason,
    int? quantity,
    double? amount,
    String? refundStatus,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
  }) => PurchaseReturn(
    id: id ?? this.id,
    purchaseId: purchaseId ?? this.purchaseId,
    supplierId: supplierId ?? this.supplierId,
    productId: productId ?? this.productId,
    variantId: variantId.present ? variantId.value : this.variantId,
    reason: reason ?? this.reason,
    quantity: quantity ?? this.quantity,
    amount: amount ?? this.amount,
    refundStatus: refundStatus ?? this.refundStatus,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  PurchaseReturn copyWithCompanion(PurchaseReturnsCompanion data) {
    return PurchaseReturn(
      id: data.id.present ? data.id.value : this.id,
      purchaseId: data.purchaseId.present
          ? data.purchaseId.value
          : this.purchaseId,
      supplierId: data.supplierId.present
          ? data.supplierId.value
          : this.supplierId,
      productId: data.productId.present ? data.productId.value : this.productId,
      variantId: data.variantId.present ? data.variantId.value : this.variantId,
      reason: data.reason.present ? data.reason.value : this.reason,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      amount: data.amount.present ? data.amount.value : this.amount,
      refundStatus: data.refundStatus.present
          ? data.refundStatus.value
          : this.refundStatus,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseReturn(')
          ..write('id: $id, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('supplierId: $supplierId, ')
          ..write('productId: $productId, ')
          ..write('variantId: $variantId, ')
          ..write('reason: $reason, ')
          ..write('quantity: $quantity, ')
          ..write('amount: $amount, ')
          ..write('refundStatus: $refundStatus, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    purchaseId,
    supplierId,
    productId,
    variantId,
    reason,
    quantity,
    amount,
    refundStatus,
    notes,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseReturn &&
          other.id == this.id &&
          other.purchaseId == this.purchaseId &&
          other.supplierId == this.supplierId &&
          other.productId == this.productId &&
          other.variantId == this.variantId &&
          other.reason == this.reason &&
          other.quantity == this.quantity &&
          other.amount == this.amount &&
          other.refundStatus == this.refundStatus &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class PurchaseReturnsCompanion extends UpdateCompanion<PurchaseReturn> {
  final Value<int> id;
  final Value<int> purchaseId;
  final Value<int> supplierId;
  final Value<int> productId;
  final Value<int?> variantId;
  final Value<String> reason;
  final Value<int> quantity;
  final Value<double> amount;
  final Value<String> refundStatus;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  const PurchaseReturnsCompanion({
    this.id = const Value.absent(),
    this.purchaseId = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.productId = const Value.absent(),
    this.variantId = const Value.absent(),
    this.reason = const Value.absent(),
    this.quantity = const Value.absent(),
    this.amount = const Value.absent(),
    this.refundStatus = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PurchaseReturnsCompanion.insert({
    this.id = const Value.absent(),
    required int purchaseId,
    required int supplierId,
    required int productId,
    this.variantId = const Value.absent(),
    required String reason,
    required int quantity,
    required double amount,
    this.refundStatus = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : purchaseId = Value(purchaseId),
       supplierId = Value(supplierId),
       productId = Value(productId),
       reason = Value(reason),
       quantity = Value(quantity),
       amount = Value(amount);
  static Insertable<PurchaseReturn> custom({
    Expression<int>? id,
    Expression<int>? purchaseId,
    Expression<int>? supplierId,
    Expression<int>? productId,
    Expression<int>? variantId,
    Expression<String>? reason,
    Expression<int>? quantity,
    Expression<double>? amount,
    Expression<String>? refundStatus,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (purchaseId != null) 'purchase_id': purchaseId,
      if (supplierId != null) 'supplier_id': supplierId,
      if (productId != null) 'product_id': productId,
      if (variantId != null) 'variant_id': variantId,
      if (reason != null) 'reason': reason,
      if (quantity != null) 'quantity': quantity,
      if (amount != null) 'amount': amount,
      if (refundStatus != null) 'refund_status': refundStatus,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PurchaseReturnsCompanion copyWith({
    Value<int>? id,
    Value<int>? purchaseId,
    Value<int>? supplierId,
    Value<int>? productId,
    Value<int?>? variantId,
    Value<String>? reason,
    Value<int>? quantity,
    Value<double>? amount,
    Value<String>? refundStatus,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
  }) {
    return PurchaseReturnsCompanion(
      id: id ?? this.id,
      purchaseId: purchaseId ?? this.purchaseId,
      supplierId: supplierId ?? this.supplierId,
      productId: productId ?? this.productId,
      variantId: variantId ?? this.variantId,
      reason: reason ?? this.reason,
      quantity: quantity ?? this.quantity,
      amount: amount ?? this.amount,
      refundStatus: refundStatus ?? this.refundStatus,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (purchaseId.present) {
      map['purchase_id'] = Variable<int>(purchaseId.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<int>(supplierId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (variantId.present) {
      map['variant_id'] = Variable<int>(variantId.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (refundStatus.present) {
      map['refund_status'] = Variable<String>(refundStatus.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseReturnsCompanion(')
          ..write('id: $id, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('supplierId: $supplierId, ')
          ..write('productId: $productId, ')
          ..write('variantId: $variantId, ')
          ..write('reason: $reason, ')
          ..write('quantity: $quantity, ')
          ..write('amount: $amount, ')
          ..write('refundStatus: $refundStatus, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SalesReturnsTable extends SalesReturns
    with TableInfo<$SalesReturnsTable, SalesReturn> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalesReturnsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<int> invoiceId = GeneratedColumn<int>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _variantIdMeta = const VerificationMeta(
    'variantId',
  );
  @override
  late final GeneratedColumn<int> variantId = GeneratedColumn<int>(
    'variant_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _refundStatusMeta = const VerificationMeta(
    'refundStatus',
  );
  @override
  late final GeneratedColumn<String> refundStatus = GeneratedColumn<String>(
    'refund_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('PENDING'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    invoiceId,
    customerId,
    productId,
    variantId,
    quantity,
    amount,
    reason,
    refundStatus,
    notes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sales_returns';
  @override
  VerificationContext validateIntegrity(
    Insertable<SalesReturn> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('variant_id')) {
      context.handle(
        _variantIdMeta,
        variantId.isAcceptableOrUnknown(data['variant_id']!, _variantIdMeta),
      );
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    if (data.containsKey('refund_status')) {
      context.handle(
        _refundStatusMeta,
        refundStatus.isAcceptableOrUnknown(
          data['refund_status']!,
          _refundStatusMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SalesReturn map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SalesReturn(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}invoice_id'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}customer_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      variantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}variant_id'],
      ),
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      )!,
      refundStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}refund_status'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SalesReturnsTable createAlias(String alias) {
    return $SalesReturnsTable(attachedDatabase, alias);
  }
}

class SalesReturn extends DataClass implements Insertable<SalesReturn> {
  final int id;
  final int invoiceId;
  final int customerId;
  final int productId;
  final int? variantId;
  final int quantity;
  final double amount;
  final String reason;
  final String refundStatus;
  final String? notes;
  final DateTime createdAt;
  const SalesReturn({
    required this.id,
    required this.invoiceId,
    required this.customerId,
    required this.productId,
    this.variantId,
    required this.quantity,
    required this.amount,
    required this.reason,
    required this.refundStatus,
    this.notes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['invoice_id'] = Variable<int>(invoiceId);
    map['customer_id'] = Variable<int>(customerId);
    map['product_id'] = Variable<int>(productId);
    if (!nullToAbsent || variantId != null) {
      map['variant_id'] = Variable<int>(variantId);
    }
    map['quantity'] = Variable<int>(quantity);
    map['amount'] = Variable<double>(amount);
    map['reason'] = Variable<String>(reason);
    map['refund_status'] = Variable<String>(refundStatus);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SalesReturnsCompanion toCompanion(bool nullToAbsent) {
    return SalesReturnsCompanion(
      id: Value(id),
      invoiceId: Value(invoiceId),
      customerId: Value(customerId),
      productId: Value(productId),
      variantId: variantId == null && nullToAbsent
          ? const Value.absent()
          : Value(variantId),
      quantity: Value(quantity),
      amount: Value(amount),
      reason: Value(reason),
      refundStatus: Value(refundStatus),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory SalesReturn.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SalesReturn(
      id: serializer.fromJson<int>(json['id']),
      invoiceId: serializer.fromJson<int>(json['invoiceId']),
      customerId: serializer.fromJson<int>(json['customerId']),
      productId: serializer.fromJson<int>(json['productId']),
      variantId: serializer.fromJson<int?>(json['variantId']),
      quantity: serializer.fromJson<int>(json['quantity']),
      amount: serializer.fromJson<double>(json['amount']),
      reason: serializer.fromJson<String>(json['reason']),
      refundStatus: serializer.fromJson<String>(json['refundStatus']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'invoiceId': serializer.toJson<int>(invoiceId),
      'customerId': serializer.toJson<int>(customerId),
      'productId': serializer.toJson<int>(productId),
      'variantId': serializer.toJson<int?>(variantId),
      'quantity': serializer.toJson<int>(quantity),
      'amount': serializer.toJson<double>(amount),
      'reason': serializer.toJson<String>(reason),
      'refundStatus': serializer.toJson<String>(refundStatus),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SalesReturn copyWith({
    int? id,
    int? invoiceId,
    int? customerId,
    int? productId,
    Value<int?> variantId = const Value.absent(),
    int? quantity,
    double? amount,
    String? reason,
    String? refundStatus,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
  }) => SalesReturn(
    id: id ?? this.id,
    invoiceId: invoiceId ?? this.invoiceId,
    customerId: customerId ?? this.customerId,
    productId: productId ?? this.productId,
    variantId: variantId.present ? variantId.value : this.variantId,
    quantity: quantity ?? this.quantity,
    amount: amount ?? this.amount,
    reason: reason ?? this.reason,
    refundStatus: refundStatus ?? this.refundStatus,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  SalesReturn copyWithCompanion(SalesReturnsCompanion data) {
    return SalesReturn(
      id: data.id.present ? data.id.value : this.id,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      productId: data.productId.present ? data.productId.value : this.productId,
      variantId: data.variantId.present ? data.variantId.value : this.variantId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      amount: data.amount.present ? data.amount.value : this.amount,
      reason: data.reason.present ? data.reason.value : this.reason,
      refundStatus: data.refundStatus.present
          ? data.refundStatus.value
          : this.refundStatus,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SalesReturn(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('customerId: $customerId, ')
          ..write('productId: $productId, ')
          ..write('variantId: $variantId, ')
          ..write('quantity: $quantity, ')
          ..write('amount: $amount, ')
          ..write('reason: $reason, ')
          ..write('refundStatus: $refundStatus, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    invoiceId,
    customerId,
    productId,
    variantId,
    quantity,
    amount,
    reason,
    refundStatus,
    notes,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SalesReturn &&
          other.id == this.id &&
          other.invoiceId == this.invoiceId &&
          other.customerId == this.customerId &&
          other.productId == this.productId &&
          other.variantId == this.variantId &&
          other.quantity == this.quantity &&
          other.amount == this.amount &&
          other.reason == this.reason &&
          other.refundStatus == this.refundStatus &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class SalesReturnsCompanion extends UpdateCompanion<SalesReturn> {
  final Value<int> id;
  final Value<int> invoiceId;
  final Value<int> customerId;
  final Value<int> productId;
  final Value<int?> variantId;
  final Value<int> quantity;
  final Value<double> amount;
  final Value<String> reason;
  final Value<String> refundStatus;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  const SalesReturnsCompanion({
    this.id = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.customerId = const Value.absent(),
    this.productId = const Value.absent(),
    this.variantId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.amount = const Value.absent(),
    this.reason = const Value.absent(),
    this.refundStatus = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SalesReturnsCompanion.insert({
    this.id = const Value.absent(),
    required int invoiceId,
    required int customerId,
    required int productId,
    this.variantId = const Value.absent(),
    required int quantity,
    required double amount,
    required String reason,
    this.refundStatus = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : invoiceId = Value(invoiceId),
       customerId = Value(customerId),
       productId = Value(productId),
       quantity = Value(quantity),
       amount = Value(amount),
       reason = Value(reason);
  static Insertable<SalesReturn> custom({
    Expression<int>? id,
    Expression<int>? invoiceId,
    Expression<int>? customerId,
    Expression<int>? productId,
    Expression<int>? variantId,
    Expression<int>? quantity,
    Expression<double>? amount,
    Expression<String>? reason,
    Expression<String>? refundStatus,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (customerId != null) 'customer_id': customerId,
      if (productId != null) 'product_id': productId,
      if (variantId != null) 'variant_id': variantId,
      if (quantity != null) 'quantity': quantity,
      if (amount != null) 'amount': amount,
      if (reason != null) 'reason': reason,
      if (refundStatus != null) 'refund_status': refundStatus,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SalesReturnsCompanion copyWith({
    Value<int>? id,
    Value<int>? invoiceId,
    Value<int>? customerId,
    Value<int>? productId,
    Value<int?>? variantId,
    Value<int>? quantity,
    Value<double>? amount,
    Value<String>? reason,
    Value<String>? refundStatus,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
  }) {
    return SalesReturnsCompanion(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      customerId: customerId ?? this.customerId,
      productId: productId ?? this.productId,
      variantId: variantId ?? this.variantId,
      quantity: quantity ?? this.quantity,
      amount: amount ?? this.amount,
      reason: reason ?? this.reason,
      refundStatus: refundStatus ?? this.refundStatus,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<int>(invoiceId.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (variantId.present) {
      map['variant_id'] = Variable<int>(variantId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (refundStatus.present) {
      map['refund_status'] = Variable<String>(refundStatus.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesReturnsCompanion(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('customerId: $customerId, ')
          ..write('productId: $productId, ')
          ..write('variantId: $variantId, ')
          ..write('quantity: $quantity, ')
          ..write('amount: $amount, ')
          ..write('reason: $reason, ')
          ..write('refundStatus: $refundStatus, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $BusinessSettingsTable extends BusinessSettings
    with TableInfo<$BusinessSettingsTable, BusinessSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BusinessSettingsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _companyNameMeta = const VerificationMeta(
    'companyName',
  );
  @override
  late final GeneratedColumn<String> companyName = GeneratedColumn<String>(
    'company_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ownerNameMeta = const VerificationMeta(
    'ownerName',
  );
  @override
  late final GeneratedColumn<String> ownerName = GeneratedColumn<String>(
    'owner_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gstNoMeta = const VerificationMeta('gstNo');
  @override
  late final GeneratedColumn<String> gstNo = GeneratedColumn<String>(
    'gst_no',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _logoPathMeta = const VerificationMeta(
    'logoPath',
  );
  @override
  late final GeneratedColumn<String> logoPath = GeneratedColumn<String>(
    'logo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bankNameMeta = const VerificationMeta(
    'bankName',
  );
  @override
  late final GeneratedColumn<String> bankName = GeneratedColumn<String>(
    'bank_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accountNumberMeta = const VerificationMeta(
    'accountNumber',
  );
  @override
  late final GeneratedColumn<String> accountNumber = GeneratedColumn<String>(
    'account_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ifscCodeMeta = const VerificationMeta(
    'ifscCode',
  );
  @override
  late final GeneratedColumn<String> ifscCode = GeneratedColumn<String>(
    'ifsc_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _upiIdMeta = const VerificationMeta('upiId');
  @override
  late final GeneratedColumn<String> upiId = GeneratedColumn<String>(
    'upi_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _footerMessageMeta = const VerificationMeta(
    'footerMessage',
  );
  @override
  late final GeneratedColumn<String> footerMessage = GeneratedColumn<String>(
    'footer_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    companyName,
    ownerName,
    phone,
    email,
    address,
    gstNo,
    logoPath,
    bankName,
    accountNumber,
    ifscCode,
    upiId,
    footerMessage,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'business_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<BusinessSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('company_name')) {
      context.handle(
        _companyNameMeta,
        companyName.isAcceptableOrUnknown(
          data['company_name']!,
          _companyNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_companyNameMeta);
    }
    if (data.containsKey('owner_name')) {
      context.handle(
        _ownerNameMeta,
        ownerName.isAcceptableOrUnknown(data['owner_name']!, _ownerNameMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('gst_no')) {
      context.handle(
        _gstNoMeta,
        gstNo.isAcceptableOrUnknown(data['gst_no']!, _gstNoMeta),
      );
    }
    if (data.containsKey('logo_path')) {
      context.handle(
        _logoPathMeta,
        logoPath.isAcceptableOrUnknown(data['logo_path']!, _logoPathMeta),
      );
    }
    if (data.containsKey('bank_name')) {
      context.handle(
        _bankNameMeta,
        bankName.isAcceptableOrUnknown(data['bank_name']!, _bankNameMeta),
      );
    }
    if (data.containsKey('account_number')) {
      context.handle(
        _accountNumberMeta,
        accountNumber.isAcceptableOrUnknown(
          data['account_number']!,
          _accountNumberMeta,
        ),
      );
    }
    if (data.containsKey('ifsc_code')) {
      context.handle(
        _ifscCodeMeta,
        ifscCode.isAcceptableOrUnknown(data['ifsc_code']!, _ifscCodeMeta),
      );
    }
    if (data.containsKey('upi_id')) {
      context.handle(
        _upiIdMeta,
        upiId.isAcceptableOrUnknown(data['upi_id']!, _upiIdMeta),
      );
    }
    if (data.containsKey('footer_message')) {
      context.handle(
        _footerMessageMeta,
        footerMessage.isAcceptableOrUnknown(
          data['footer_message']!,
          _footerMessageMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BusinessSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BusinessSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      companyName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_name'],
      )!,
      ownerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_name'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      gstNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gst_no'],
      ),
      logoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logo_path'],
      ),
      bankName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_name'],
      ),
      accountNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_number'],
      ),
      ifscCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ifsc_code'],
      ),
      upiId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}upi_id'],
      ),
      footerMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}footer_message'],
      ),
    );
  }

  @override
  $BusinessSettingsTable createAlias(String alias) {
    return $BusinessSettingsTable(attachedDatabase, alias);
  }
}

class BusinessSetting extends DataClass implements Insertable<BusinessSetting> {
  final int id;
  final String companyName;
  final String? ownerName;
  final String? phone;
  final String? email;
  final String? address;
  final String? gstNo;
  final String? logoPath;
  final String? bankName;
  final String? accountNumber;
  final String? ifscCode;
  final String? upiId;
  final String? footerMessage;
  const BusinessSetting({
    required this.id,
    required this.companyName,
    this.ownerName,
    this.phone,
    this.email,
    this.address,
    this.gstNo,
    this.logoPath,
    this.bankName,
    this.accountNumber,
    this.ifscCode,
    this.upiId,
    this.footerMessage,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['company_name'] = Variable<String>(companyName);
    if (!nullToAbsent || ownerName != null) {
      map['owner_name'] = Variable<String>(ownerName);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || gstNo != null) {
      map['gst_no'] = Variable<String>(gstNo);
    }
    if (!nullToAbsent || logoPath != null) {
      map['logo_path'] = Variable<String>(logoPath);
    }
    if (!nullToAbsent || bankName != null) {
      map['bank_name'] = Variable<String>(bankName);
    }
    if (!nullToAbsent || accountNumber != null) {
      map['account_number'] = Variable<String>(accountNumber);
    }
    if (!nullToAbsent || ifscCode != null) {
      map['ifsc_code'] = Variable<String>(ifscCode);
    }
    if (!nullToAbsent || upiId != null) {
      map['upi_id'] = Variable<String>(upiId);
    }
    if (!nullToAbsent || footerMessage != null) {
      map['footer_message'] = Variable<String>(footerMessage);
    }
    return map;
  }

  BusinessSettingsCompanion toCompanion(bool nullToAbsent) {
    return BusinessSettingsCompanion(
      id: Value(id),
      companyName: Value(companyName),
      ownerName: ownerName == null && nullToAbsent
          ? const Value.absent()
          : Value(ownerName),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      gstNo: gstNo == null && nullToAbsent
          ? const Value.absent()
          : Value(gstNo),
      logoPath: logoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(logoPath),
      bankName: bankName == null && nullToAbsent
          ? const Value.absent()
          : Value(bankName),
      accountNumber: accountNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(accountNumber),
      ifscCode: ifscCode == null && nullToAbsent
          ? const Value.absent()
          : Value(ifscCode),
      upiId: upiId == null && nullToAbsent
          ? const Value.absent()
          : Value(upiId),
      footerMessage: footerMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(footerMessage),
    );
  }

  factory BusinessSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BusinessSetting(
      id: serializer.fromJson<int>(json['id']),
      companyName: serializer.fromJson<String>(json['companyName']),
      ownerName: serializer.fromJson<String?>(json['ownerName']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      address: serializer.fromJson<String?>(json['address']),
      gstNo: serializer.fromJson<String?>(json['gstNo']),
      logoPath: serializer.fromJson<String?>(json['logoPath']),
      bankName: serializer.fromJson<String?>(json['bankName']),
      accountNumber: serializer.fromJson<String?>(json['accountNumber']),
      ifscCode: serializer.fromJson<String?>(json['ifscCode']),
      upiId: serializer.fromJson<String?>(json['upiId']),
      footerMessage: serializer.fromJson<String?>(json['footerMessage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'companyName': serializer.toJson<String>(companyName),
      'ownerName': serializer.toJson<String?>(ownerName),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'address': serializer.toJson<String?>(address),
      'gstNo': serializer.toJson<String?>(gstNo),
      'logoPath': serializer.toJson<String?>(logoPath),
      'bankName': serializer.toJson<String?>(bankName),
      'accountNumber': serializer.toJson<String?>(accountNumber),
      'ifscCode': serializer.toJson<String?>(ifscCode),
      'upiId': serializer.toJson<String?>(upiId),
      'footerMessage': serializer.toJson<String?>(footerMessage),
    };
  }

  BusinessSetting copyWith({
    int? id,
    String? companyName,
    Value<String?> ownerName = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> address = const Value.absent(),
    Value<String?> gstNo = const Value.absent(),
    Value<String?> logoPath = const Value.absent(),
    Value<String?> bankName = const Value.absent(),
    Value<String?> accountNumber = const Value.absent(),
    Value<String?> ifscCode = const Value.absent(),
    Value<String?> upiId = const Value.absent(),
    Value<String?> footerMessage = const Value.absent(),
  }) => BusinessSetting(
    id: id ?? this.id,
    companyName: companyName ?? this.companyName,
    ownerName: ownerName.present ? ownerName.value : this.ownerName,
    phone: phone.present ? phone.value : this.phone,
    email: email.present ? email.value : this.email,
    address: address.present ? address.value : this.address,
    gstNo: gstNo.present ? gstNo.value : this.gstNo,
    logoPath: logoPath.present ? logoPath.value : this.logoPath,
    bankName: bankName.present ? bankName.value : this.bankName,
    accountNumber: accountNumber.present
        ? accountNumber.value
        : this.accountNumber,
    ifscCode: ifscCode.present ? ifscCode.value : this.ifscCode,
    upiId: upiId.present ? upiId.value : this.upiId,
    footerMessage: footerMessage.present
        ? footerMessage.value
        : this.footerMessage,
  );
  BusinessSetting copyWithCompanion(BusinessSettingsCompanion data) {
    return BusinessSetting(
      id: data.id.present ? data.id.value : this.id,
      companyName: data.companyName.present
          ? data.companyName.value
          : this.companyName,
      ownerName: data.ownerName.present ? data.ownerName.value : this.ownerName,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      address: data.address.present ? data.address.value : this.address,
      gstNo: data.gstNo.present ? data.gstNo.value : this.gstNo,
      logoPath: data.logoPath.present ? data.logoPath.value : this.logoPath,
      bankName: data.bankName.present ? data.bankName.value : this.bankName,
      accountNumber: data.accountNumber.present
          ? data.accountNumber.value
          : this.accountNumber,
      ifscCode: data.ifscCode.present ? data.ifscCode.value : this.ifscCode,
      upiId: data.upiId.present ? data.upiId.value : this.upiId,
      footerMessage: data.footerMessage.present
          ? data.footerMessage.value
          : this.footerMessage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BusinessSetting(')
          ..write('id: $id, ')
          ..write('companyName: $companyName, ')
          ..write('ownerName: $ownerName, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('gstNo: $gstNo, ')
          ..write('logoPath: $logoPath, ')
          ..write('bankName: $bankName, ')
          ..write('accountNumber: $accountNumber, ')
          ..write('ifscCode: $ifscCode, ')
          ..write('upiId: $upiId, ')
          ..write('footerMessage: $footerMessage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    companyName,
    ownerName,
    phone,
    email,
    address,
    gstNo,
    logoPath,
    bankName,
    accountNumber,
    ifscCode,
    upiId,
    footerMessage,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BusinessSetting &&
          other.id == this.id &&
          other.companyName == this.companyName &&
          other.ownerName == this.ownerName &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.address == this.address &&
          other.gstNo == this.gstNo &&
          other.logoPath == this.logoPath &&
          other.bankName == this.bankName &&
          other.accountNumber == this.accountNumber &&
          other.ifscCode == this.ifscCode &&
          other.upiId == this.upiId &&
          other.footerMessage == this.footerMessage);
}

class BusinessSettingsCompanion extends UpdateCompanion<BusinessSetting> {
  final Value<int> id;
  final Value<String> companyName;
  final Value<String?> ownerName;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<String?> address;
  final Value<String?> gstNo;
  final Value<String?> logoPath;
  final Value<String?> bankName;
  final Value<String?> accountNumber;
  final Value<String?> ifscCode;
  final Value<String?> upiId;
  final Value<String?> footerMessage;
  const BusinessSettingsCompanion({
    this.id = const Value.absent(),
    this.companyName = const Value.absent(),
    this.ownerName = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.gstNo = const Value.absent(),
    this.logoPath = const Value.absent(),
    this.bankName = const Value.absent(),
    this.accountNumber = const Value.absent(),
    this.ifscCode = const Value.absent(),
    this.upiId = const Value.absent(),
    this.footerMessage = const Value.absent(),
  });
  BusinessSettingsCompanion.insert({
    this.id = const Value.absent(),
    required String companyName,
    this.ownerName = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.gstNo = const Value.absent(),
    this.logoPath = const Value.absent(),
    this.bankName = const Value.absent(),
    this.accountNumber = const Value.absent(),
    this.ifscCode = const Value.absent(),
    this.upiId = const Value.absent(),
    this.footerMessage = const Value.absent(),
  }) : companyName = Value(companyName);
  static Insertable<BusinessSetting> custom({
    Expression<int>? id,
    Expression<String>? companyName,
    Expression<String>? ownerName,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? address,
    Expression<String>? gstNo,
    Expression<String>? logoPath,
    Expression<String>? bankName,
    Expression<String>? accountNumber,
    Expression<String>? ifscCode,
    Expression<String>? upiId,
    Expression<String>? footerMessage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (companyName != null) 'company_name': companyName,
      if (ownerName != null) 'owner_name': ownerName,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
      if (gstNo != null) 'gst_no': gstNo,
      if (logoPath != null) 'logo_path': logoPath,
      if (bankName != null) 'bank_name': bankName,
      if (accountNumber != null) 'account_number': accountNumber,
      if (ifscCode != null) 'ifsc_code': ifscCode,
      if (upiId != null) 'upi_id': upiId,
      if (footerMessage != null) 'footer_message': footerMessage,
    });
  }

  BusinessSettingsCompanion copyWith({
    Value<int>? id,
    Value<String>? companyName,
    Value<String?>? ownerName,
    Value<String?>? phone,
    Value<String?>? email,
    Value<String?>? address,
    Value<String?>? gstNo,
    Value<String?>? logoPath,
    Value<String?>? bankName,
    Value<String?>? accountNumber,
    Value<String?>? ifscCode,
    Value<String?>? upiId,
    Value<String?>? footerMessage,
  }) {
    return BusinessSettingsCompanion(
      id: id ?? this.id,
      companyName: companyName ?? this.companyName,
      ownerName: ownerName ?? this.ownerName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      gstNo: gstNo ?? this.gstNo,
      logoPath: logoPath ?? this.logoPath,
      bankName: bankName ?? this.bankName,
      accountNumber: accountNumber ?? this.accountNumber,
      ifscCode: ifscCode ?? this.ifscCode,
      upiId: upiId ?? this.upiId,
      footerMessage: footerMessage ?? this.footerMessage,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (companyName.present) {
      map['company_name'] = Variable<String>(companyName.value);
    }
    if (ownerName.present) {
      map['owner_name'] = Variable<String>(ownerName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (gstNo.present) {
      map['gst_no'] = Variable<String>(gstNo.value);
    }
    if (logoPath.present) {
      map['logo_path'] = Variable<String>(logoPath.value);
    }
    if (bankName.present) {
      map['bank_name'] = Variable<String>(bankName.value);
    }
    if (accountNumber.present) {
      map['account_number'] = Variable<String>(accountNumber.value);
    }
    if (ifscCode.present) {
      map['ifsc_code'] = Variable<String>(ifscCode.value);
    }
    if (upiId.present) {
      map['upi_id'] = Variable<String>(upiId.value);
    }
    if (footerMessage.present) {
      map['footer_message'] = Variable<String>(footerMessage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BusinessSettingsCompanion(')
          ..write('id: $id, ')
          ..write('companyName: $companyName, ')
          ..write('ownerName: $ownerName, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('gstNo: $gstNo, ')
          ..write('logoPath: $logoPath, ')
          ..write('bankName: $bankName, ')
          ..write('accountNumber: $accountNumber, ')
          ..write('ifscCode: $ifscCode, ')
          ..write('upiId: $upiId, ')
          ..write('footerMessage: $footerMessage')
          ..write(')'))
        .toString();
  }
}

class $ProductPriceHistoriesTable extends ProductPriceHistories
    with TableInfo<$ProductPriceHistoriesTable, ProductPriceHistory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductPriceHistoriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _supplierIdMeta = const VerificationMeta(
    'supplierId',
  );
  @override
  late final GeneratedColumn<int> supplierId = GeneratedColumn<int>(
    'supplier_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _oldPurchasePriceMeta = const VerificationMeta(
    'oldPurchasePrice',
  );
  @override
  late final GeneratedColumn<double> oldPurchasePrice = GeneratedColumn<double>(
    'old_purchase_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _newPurchasePriceMeta = const VerificationMeta(
    'newPurchasePrice',
  );
  @override
  late final GeneratedColumn<double> newPurchasePrice = GeneratedColumn<double>(
    'new_purchase_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _oldSellingPriceMeta = const VerificationMeta(
    'oldSellingPrice',
  );
  @override
  late final GeneratedColumn<double> oldSellingPrice = GeneratedColumn<double>(
    'old_selling_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _newSellingPriceMeta = const VerificationMeta(
    'newSellingPrice',
  );
  @override
  late final GeneratedColumn<double> newSellingPrice = GeneratedColumn<double>(
    'new_selling_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _inflationPercentageMeta =
      const VerificationMeta('inflationPercentage');
  @override
  late final GeneratedColumn<double> inflationPercentage =
      GeneratedColumn<double>(
        'inflation_percentage',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  static const VerificationMeta _changedAtMeta = const VerificationMeta(
    'changedAt',
  );
  @override
  late final GeneratedColumn<DateTime> changedAt = GeneratedColumn<DateTime>(
    'changed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _remarksMeta = const VerificationMeta(
    'remarks',
  );
  @override
  late final GeneratedColumn<String> remarks = GeneratedColumn<String>(
    'remarks',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    supplierId,
    oldPurchasePrice,
    newPurchasePrice,
    oldSellingPrice,
    newSellingPrice,
    inflationPercentage,
    changedAt,
    remarks,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_price_histories';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductPriceHistory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
        _supplierIdMeta,
        supplierId.isAcceptableOrUnknown(data['supplier_id']!, _supplierIdMeta),
      );
    }
    if (data.containsKey('old_purchase_price')) {
      context.handle(
        _oldPurchasePriceMeta,
        oldPurchasePrice.isAcceptableOrUnknown(
          data['old_purchase_price']!,
          _oldPurchasePriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_oldPurchasePriceMeta);
    }
    if (data.containsKey('new_purchase_price')) {
      context.handle(
        _newPurchasePriceMeta,
        newPurchasePrice.isAcceptableOrUnknown(
          data['new_purchase_price']!,
          _newPurchasePriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_newPurchasePriceMeta);
    }
    if (data.containsKey('old_selling_price')) {
      context.handle(
        _oldSellingPriceMeta,
        oldSellingPrice.isAcceptableOrUnknown(
          data['old_selling_price']!,
          _oldSellingPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_oldSellingPriceMeta);
    }
    if (data.containsKey('new_selling_price')) {
      context.handle(
        _newSellingPriceMeta,
        newSellingPrice.isAcceptableOrUnknown(
          data['new_selling_price']!,
          _newSellingPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_newSellingPriceMeta);
    }
    if (data.containsKey('inflation_percentage')) {
      context.handle(
        _inflationPercentageMeta,
        inflationPercentage.isAcceptableOrUnknown(
          data['inflation_percentage']!,
          _inflationPercentageMeta,
        ),
      );
    }
    if (data.containsKey('changed_at')) {
      context.handle(
        _changedAtMeta,
        changedAt.isAcceptableOrUnknown(data['changed_at']!, _changedAtMeta),
      );
    }
    if (data.containsKey('remarks')) {
      context.handle(
        _remarksMeta,
        remarks.isAcceptableOrUnknown(data['remarks']!, _remarksMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductPriceHistory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductPriceHistory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      supplierId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}supplier_id'],
      ),
      oldPurchasePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}old_purchase_price'],
      )!,
      newPurchasePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}new_purchase_price'],
      )!,
      oldSellingPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}old_selling_price'],
      )!,
      newSellingPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}new_selling_price'],
      )!,
      inflationPercentage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}inflation_percentage'],
      )!,
      changedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}changed_at'],
      )!,
      remarks: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remarks'],
      ),
    );
  }

  @override
  $ProductPriceHistoriesTable createAlias(String alias) {
    return $ProductPriceHistoriesTable(attachedDatabase, alias);
  }
}

class ProductPriceHistory extends DataClass
    implements Insertable<ProductPriceHistory> {
  final int id;
  final int productId;
  final int? supplierId;
  final double oldPurchasePrice;
  final double newPurchasePrice;
  final double oldSellingPrice;
  final double newSellingPrice;
  final double inflationPercentage;
  final DateTime changedAt;
  final String? remarks;
  const ProductPriceHistory({
    required this.id,
    required this.productId,
    this.supplierId,
    required this.oldPurchasePrice,
    required this.newPurchasePrice,
    required this.oldSellingPrice,
    required this.newSellingPrice,
    required this.inflationPercentage,
    required this.changedAt,
    this.remarks,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    if (!nullToAbsent || supplierId != null) {
      map['supplier_id'] = Variable<int>(supplierId);
    }
    map['old_purchase_price'] = Variable<double>(oldPurchasePrice);
    map['new_purchase_price'] = Variable<double>(newPurchasePrice);
    map['old_selling_price'] = Variable<double>(oldSellingPrice);
    map['new_selling_price'] = Variable<double>(newSellingPrice);
    map['inflation_percentage'] = Variable<double>(inflationPercentage);
    map['changed_at'] = Variable<DateTime>(changedAt);
    if (!nullToAbsent || remarks != null) {
      map['remarks'] = Variable<String>(remarks);
    }
    return map;
  }

  ProductPriceHistoriesCompanion toCompanion(bool nullToAbsent) {
    return ProductPriceHistoriesCompanion(
      id: Value(id),
      productId: Value(productId),
      supplierId: supplierId == null && nullToAbsent
          ? const Value.absent()
          : Value(supplierId),
      oldPurchasePrice: Value(oldPurchasePrice),
      newPurchasePrice: Value(newPurchasePrice),
      oldSellingPrice: Value(oldSellingPrice),
      newSellingPrice: Value(newSellingPrice),
      inflationPercentage: Value(inflationPercentage),
      changedAt: Value(changedAt),
      remarks: remarks == null && nullToAbsent
          ? const Value.absent()
          : Value(remarks),
    );
  }

  factory ProductPriceHistory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductPriceHistory(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      supplierId: serializer.fromJson<int?>(json['supplierId']),
      oldPurchasePrice: serializer.fromJson<double>(json['oldPurchasePrice']),
      newPurchasePrice: serializer.fromJson<double>(json['newPurchasePrice']),
      oldSellingPrice: serializer.fromJson<double>(json['oldSellingPrice']),
      newSellingPrice: serializer.fromJson<double>(json['newSellingPrice']),
      inflationPercentage: serializer.fromJson<double>(
        json['inflationPercentage'],
      ),
      changedAt: serializer.fromJson<DateTime>(json['changedAt']),
      remarks: serializer.fromJson<String?>(json['remarks']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'supplierId': serializer.toJson<int?>(supplierId),
      'oldPurchasePrice': serializer.toJson<double>(oldPurchasePrice),
      'newPurchasePrice': serializer.toJson<double>(newPurchasePrice),
      'oldSellingPrice': serializer.toJson<double>(oldSellingPrice),
      'newSellingPrice': serializer.toJson<double>(newSellingPrice),
      'inflationPercentage': serializer.toJson<double>(inflationPercentage),
      'changedAt': serializer.toJson<DateTime>(changedAt),
      'remarks': serializer.toJson<String?>(remarks),
    };
  }

  ProductPriceHistory copyWith({
    int? id,
    int? productId,
    Value<int?> supplierId = const Value.absent(),
    double? oldPurchasePrice,
    double? newPurchasePrice,
    double? oldSellingPrice,
    double? newSellingPrice,
    double? inflationPercentage,
    DateTime? changedAt,
    Value<String?> remarks = const Value.absent(),
  }) => ProductPriceHistory(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    supplierId: supplierId.present ? supplierId.value : this.supplierId,
    oldPurchasePrice: oldPurchasePrice ?? this.oldPurchasePrice,
    newPurchasePrice: newPurchasePrice ?? this.newPurchasePrice,
    oldSellingPrice: oldSellingPrice ?? this.oldSellingPrice,
    newSellingPrice: newSellingPrice ?? this.newSellingPrice,
    inflationPercentage: inflationPercentage ?? this.inflationPercentage,
    changedAt: changedAt ?? this.changedAt,
    remarks: remarks.present ? remarks.value : this.remarks,
  );
  ProductPriceHistory copyWithCompanion(ProductPriceHistoriesCompanion data) {
    return ProductPriceHistory(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      supplierId: data.supplierId.present
          ? data.supplierId.value
          : this.supplierId,
      oldPurchasePrice: data.oldPurchasePrice.present
          ? data.oldPurchasePrice.value
          : this.oldPurchasePrice,
      newPurchasePrice: data.newPurchasePrice.present
          ? data.newPurchasePrice.value
          : this.newPurchasePrice,
      oldSellingPrice: data.oldSellingPrice.present
          ? data.oldSellingPrice.value
          : this.oldSellingPrice,
      newSellingPrice: data.newSellingPrice.present
          ? data.newSellingPrice.value
          : this.newSellingPrice,
      inflationPercentage: data.inflationPercentage.present
          ? data.inflationPercentage.value
          : this.inflationPercentage,
      changedAt: data.changedAt.present ? data.changedAt.value : this.changedAt,
      remarks: data.remarks.present ? data.remarks.value : this.remarks,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductPriceHistory(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('supplierId: $supplierId, ')
          ..write('oldPurchasePrice: $oldPurchasePrice, ')
          ..write('newPurchasePrice: $newPurchasePrice, ')
          ..write('oldSellingPrice: $oldSellingPrice, ')
          ..write('newSellingPrice: $newSellingPrice, ')
          ..write('inflationPercentage: $inflationPercentage, ')
          ..write('changedAt: $changedAt, ')
          ..write('remarks: $remarks')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productId,
    supplierId,
    oldPurchasePrice,
    newPurchasePrice,
    oldSellingPrice,
    newSellingPrice,
    inflationPercentage,
    changedAt,
    remarks,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductPriceHistory &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.supplierId == this.supplierId &&
          other.oldPurchasePrice == this.oldPurchasePrice &&
          other.newPurchasePrice == this.newPurchasePrice &&
          other.oldSellingPrice == this.oldSellingPrice &&
          other.newSellingPrice == this.newSellingPrice &&
          other.inflationPercentage == this.inflationPercentage &&
          other.changedAt == this.changedAt &&
          other.remarks == this.remarks);
}

class ProductPriceHistoriesCompanion
    extends UpdateCompanion<ProductPriceHistory> {
  final Value<int> id;
  final Value<int> productId;
  final Value<int?> supplierId;
  final Value<double> oldPurchasePrice;
  final Value<double> newPurchasePrice;
  final Value<double> oldSellingPrice;
  final Value<double> newSellingPrice;
  final Value<double> inflationPercentage;
  final Value<DateTime> changedAt;
  final Value<String?> remarks;
  const ProductPriceHistoriesCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.oldPurchasePrice = const Value.absent(),
    this.newPurchasePrice = const Value.absent(),
    this.oldSellingPrice = const Value.absent(),
    this.newSellingPrice = const Value.absent(),
    this.inflationPercentage = const Value.absent(),
    this.changedAt = const Value.absent(),
    this.remarks = const Value.absent(),
  });
  ProductPriceHistoriesCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    this.supplierId = const Value.absent(),
    required double oldPurchasePrice,
    required double newPurchasePrice,
    required double oldSellingPrice,
    required double newSellingPrice,
    this.inflationPercentage = const Value.absent(),
    this.changedAt = const Value.absent(),
    this.remarks = const Value.absent(),
  }) : productId = Value(productId),
       oldPurchasePrice = Value(oldPurchasePrice),
       newPurchasePrice = Value(newPurchasePrice),
       oldSellingPrice = Value(oldSellingPrice),
       newSellingPrice = Value(newSellingPrice);
  static Insertable<ProductPriceHistory> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<int>? supplierId,
    Expression<double>? oldPurchasePrice,
    Expression<double>? newPurchasePrice,
    Expression<double>? oldSellingPrice,
    Expression<double>? newSellingPrice,
    Expression<double>? inflationPercentage,
    Expression<DateTime>? changedAt,
    Expression<String>? remarks,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (supplierId != null) 'supplier_id': supplierId,
      if (oldPurchasePrice != null) 'old_purchase_price': oldPurchasePrice,
      if (newPurchasePrice != null) 'new_purchase_price': newPurchasePrice,
      if (oldSellingPrice != null) 'old_selling_price': oldSellingPrice,
      if (newSellingPrice != null) 'new_selling_price': newSellingPrice,
      if (inflationPercentage != null)
        'inflation_percentage': inflationPercentage,
      if (changedAt != null) 'changed_at': changedAt,
      if (remarks != null) 'remarks': remarks,
    });
  }

  ProductPriceHistoriesCompanion copyWith({
    Value<int>? id,
    Value<int>? productId,
    Value<int?>? supplierId,
    Value<double>? oldPurchasePrice,
    Value<double>? newPurchasePrice,
    Value<double>? oldSellingPrice,
    Value<double>? newSellingPrice,
    Value<double>? inflationPercentage,
    Value<DateTime>? changedAt,
    Value<String?>? remarks,
  }) {
    return ProductPriceHistoriesCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      supplierId: supplierId ?? this.supplierId,
      oldPurchasePrice: oldPurchasePrice ?? this.oldPurchasePrice,
      newPurchasePrice: newPurchasePrice ?? this.newPurchasePrice,
      oldSellingPrice: oldSellingPrice ?? this.oldSellingPrice,
      newSellingPrice: newSellingPrice ?? this.newSellingPrice,
      inflationPercentage: inflationPercentage ?? this.inflationPercentage,
      changedAt: changedAt ?? this.changedAt,
      remarks: remarks ?? this.remarks,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<int>(supplierId.value);
    }
    if (oldPurchasePrice.present) {
      map['old_purchase_price'] = Variable<double>(oldPurchasePrice.value);
    }
    if (newPurchasePrice.present) {
      map['new_purchase_price'] = Variable<double>(newPurchasePrice.value);
    }
    if (oldSellingPrice.present) {
      map['old_selling_price'] = Variable<double>(oldSellingPrice.value);
    }
    if (newSellingPrice.present) {
      map['new_selling_price'] = Variable<double>(newSellingPrice.value);
    }
    if (inflationPercentage.present) {
      map['inflation_percentage'] = Variable<double>(inflationPercentage.value);
    }
    if (changedAt.present) {
      map['changed_at'] = Variable<DateTime>(changedAt.value);
    }
    if (remarks.present) {
      map['remarks'] = Variable<String>(remarks.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductPriceHistoriesCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('supplierId: $supplierId, ')
          ..write('oldPurchasePrice: $oldPurchasePrice, ')
          ..write('newPurchasePrice: $newPurchasePrice, ')
          ..write('oldSellingPrice: $oldSellingPrice, ')
          ..write('newSellingPrice: $newSellingPrice, ')
          ..write('inflationPercentage: $inflationPercentage, ')
          ..write('changedAt: $changedAt, ')
          ..write('remarks: $remarks')
          ..write(')'))
        .toString();
  }
}

class $CustomerNotesTable extends CustomerNotes
    with TableInfo<$CustomerNotesTable, CustomerNote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomerNotesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, customerId, note, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customer_notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomerNote> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    } else if (isInserting) {
      context.missing(_noteMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomerNote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomerNote(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}customer_id'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CustomerNotesTable createAlias(String alias) {
    return $CustomerNotesTable(attachedDatabase, alias);
  }
}

class CustomerNote extends DataClass implements Insertable<CustomerNote> {
  final int id;
  final int customerId;
  final String note;
  final DateTime createdAt;
  const CustomerNote({
    required this.id,
    required this.customerId,
    required this.note,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['customer_id'] = Variable<int>(customerId);
    map['note'] = Variable<String>(note);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CustomerNotesCompanion toCompanion(bool nullToAbsent) {
    return CustomerNotesCompanion(
      id: Value(id),
      customerId: Value(customerId),
      note: Value(note),
      createdAt: Value(createdAt),
    );
  }

  factory CustomerNote.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomerNote(
      id: serializer.fromJson<int>(json['id']),
      customerId: serializer.fromJson<int>(json['customerId']),
      note: serializer.fromJson<String>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'customerId': serializer.toJson<int>(customerId),
      'note': serializer.toJson<String>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CustomerNote copyWith({
    int? id,
    int? customerId,
    String? note,
    DateTime? createdAt,
  }) => CustomerNote(
    id: id ?? this.id,
    customerId: customerId ?? this.customerId,
    note: note ?? this.note,
    createdAt: createdAt ?? this.createdAt,
  );
  CustomerNote copyWithCompanion(CustomerNotesCompanion data) {
    return CustomerNote(
      id: data.id.present ? data.id.value : this.id,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomerNote(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, customerId, note, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomerNote &&
          other.id == this.id &&
          other.customerId == this.customerId &&
          other.note == this.note &&
          other.createdAt == this.createdAt);
}

class CustomerNotesCompanion extends UpdateCompanion<CustomerNote> {
  final Value<int> id;
  final Value<int> customerId;
  final Value<String> note;
  final Value<DateTime> createdAt;
  const CustomerNotesCompanion({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CustomerNotesCompanion.insert({
    this.id = const Value.absent(),
    required int customerId,
    required String note,
    this.createdAt = const Value.absent(),
  }) : customerId = Value(customerId),
       note = Value(note);
  static Insertable<CustomerNote> custom({
    Expression<int>? id,
    Expression<int>? customerId,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerId != null) 'customer_id': customerId,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CustomerNotesCompanion copyWith({
    Value<int>? id,
    Value<int>? customerId,
    Value<String>? note,
    Value<DateTime>? createdAt,
  }) {
    return CustomerNotesCompanion(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomerNotesCompanion(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CustomerDocumentsTable extends CustomerDocuments
    with TableInfo<$CustomerDocumentsTable, CustomerDocument> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomerDocumentsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    customerId,
    name,
    filePath,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customer_documents';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomerDocument> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomerDocument map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomerDocument(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}customer_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CustomerDocumentsTable createAlias(String alias) {
    return $CustomerDocumentsTable(attachedDatabase, alias);
  }
}

class CustomerDocument extends DataClass
    implements Insertable<CustomerDocument> {
  final int id;
  final int customerId;
  final String name;
  final String filePath;
  final DateTime createdAt;
  const CustomerDocument({
    required this.id,
    required this.customerId,
    required this.name,
    required this.filePath,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['customer_id'] = Variable<int>(customerId);
    map['name'] = Variable<String>(name);
    map['file_path'] = Variable<String>(filePath);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CustomerDocumentsCompanion toCompanion(bool nullToAbsent) {
    return CustomerDocumentsCompanion(
      id: Value(id),
      customerId: Value(customerId),
      name: Value(name),
      filePath: Value(filePath),
      createdAt: Value(createdAt),
    );
  }

  factory CustomerDocument.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomerDocument(
      id: serializer.fromJson<int>(json['id']),
      customerId: serializer.fromJson<int>(json['customerId']),
      name: serializer.fromJson<String>(json['name']),
      filePath: serializer.fromJson<String>(json['filePath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'customerId': serializer.toJson<int>(customerId),
      'name': serializer.toJson<String>(name),
      'filePath': serializer.toJson<String>(filePath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CustomerDocument copyWith({
    int? id,
    int? customerId,
    String? name,
    String? filePath,
    DateTime? createdAt,
  }) => CustomerDocument(
    id: id ?? this.id,
    customerId: customerId ?? this.customerId,
    name: name ?? this.name,
    filePath: filePath ?? this.filePath,
    createdAt: createdAt ?? this.createdAt,
  );
  CustomerDocument copyWithCompanion(CustomerDocumentsCompanion data) {
    return CustomerDocument(
      id: data.id.present ? data.id.value : this.id,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      name: data.name.present ? data.name.value : this.name,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomerDocument(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('name: $name, ')
          ..write('filePath: $filePath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, customerId, name, filePath, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomerDocument &&
          other.id == this.id &&
          other.customerId == this.customerId &&
          other.name == this.name &&
          other.filePath == this.filePath &&
          other.createdAt == this.createdAt);
}

class CustomerDocumentsCompanion extends UpdateCompanion<CustomerDocument> {
  final Value<int> id;
  final Value<int> customerId;
  final Value<String> name;
  final Value<String> filePath;
  final Value<DateTime> createdAt;
  const CustomerDocumentsCompanion({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    this.name = const Value.absent(),
    this.filePath = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CustomerDocumentsCompanion.insert({
    this.id = const Value.absent(),
    required int customerId,
    required String name,
    required String filePath,
    this.createdAt = const Value.absent(),
  }) : customerId = Value(customerId),
       name = Value(name),
       filePath = Value(filePath);
  static Insertable<CustomerDocument> custom({
    Expression<int>? id,
    Expression<int>? customerId,
    Expression<String>? name,
    Expression<String>? filePath,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerId != null) 'customer_id': customerId,
      if (name != null) 'name': name,
      if (filePath != null) 'file_path': filePath,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CustomerDocumentsCompanion copyWith({
    Value<int>? id,
    Value<int>? customerId,
    Value<String>? name,
    Value<String>? filePath,
    Value<DateTime>? createdAt,
  }) {
    return CustomerDocumentsCompanion(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      name: name ?? this.name,
      filePath: filePath ?? this.filePath,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomerDocumentsCompanion(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('name: $name, ')
          ..write('filePath: $filePath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CustomerFollowUpsTable extends CustomerFollowUps
    with TableInfo<$CustomerFollowUpsTable, CustomerFollowUp> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomerFollowUpsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _followUpDateMeta = const VerificationMeta(
    'followUpDate',
  );
  @override
  late final GeneratedColumn<DateTime> followUpDate = GeneratedColumn<DateTime>(
    'follow_up_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedMeta = const VerificationMeta(
    'completed',
  );
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
    'completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    customerId,
    title,
    description,
    followUpDate,
    completed,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customer_follow_ups';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomerFollowUp> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('follow_up_date')) {
      context.handle(
        _followUpDateMeta,
        followUpDate.isAcceptableOrUnknown(
          data['follow_up_date']!,
          _followUpDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_followUpDateMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomerFollowUp map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomerFollowUp(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}customer_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      followUpDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}follow_up_date'],
      )!,
      completed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}completed'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CustomerFollowUpsTable createAlias(String alias) {
    return $CustomerFollowUpsTable(attachedDatabase, alias);
  }
}

class CustomerFollowUp extends DataClass
    implements Insertable<CustomerFollowUp> {
  final int id;
  final int customerId;
  final String title;
  final String? description;
  final DateTime followUpDate;
  final bool completed;
  final DateTime createdAt;
  const CustomerFollowUp({
    required this.id,
    required this.customerId,
    required this.title,
    this.description,
    required this.followUpDate,
    required this.completed,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['customer_id'] = Variable<int>(customerId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['follow_up_date'] = Variable<DateTime>(followUpDate);
    map['completed'] = Variable<bool>(completed);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CustomerFollowUpsCompanion toCompanion(bool nullToAbsent) {
    return CustomerFollowUpsCompanion(
      id: Value(id),
      customerId: Value(customerId),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      followUpDate: Value(followUpDate),
      completed: Value(completed),
      createdAt: Value(createdAt),
    );
  }

  factory CustomerFollowUp.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomerFollowUp(
      id: serializer.fromJson<int>(json['id']),
      customerId: serializer.fromJson<int>(json['customerId']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      followUpDate: serializer.fromJson<DateTime>(json['followUpDate']),
      completed: serializer.fromJson<bool>(json['completed']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'customerId': serializer.toJson<int>(customerId),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'followUpDate': serializer.toJson<DateTime>(followUpDate),
      'completed': serializer.toJson<bool>(completed),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CustomerFollowUp copyWith({
    int? id,
    int? customerId,
    String? title,
    Value<String?> description = const Value.absent(),
    DateTime? followUpDate,
    bool? completed,
    DateTime? createdAt,
  }) => CustomerFollowUp(
    id: id ?? this.id,
    customerId: customerId ?? this.customerId,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    followUpDate: followUpDate ?? this.followUpDate,
    completed: completed ?? this.completed,
    createdAt: createdAt ?? this.createdAt,
  );
  CustomerFollowUp copyWithCompanion(CustomerFollowUpsCompanion data) {
    return CustomerFollowUp(
      id: data.id.present ? data.id.value : this.id,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      followUpDate: data.followUpDate.present
          ? data.followUpDate.value
          : this.followUpDate,
      completed: data.completed.present ? data.completed.value : this.completed,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomerFollowUp(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('followUpDate: $followUpDate, ')
          ..write('completed: $completed, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    customerId,
    title,
    description,
    followUpDate,
    completed,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomerFollowUp &&
          other.id == this.id &&
          other.customerId == this.customerId &&
          other.title == this.title &&
          other.description == this.description &&
          other.followUpDate == this.followUpDate &&
          other.completed == this.completed &&
          other.createdAt == this.createdAt);
}

class CustomerFollowUpsCompanion extends UpdateCompanion<CustomerFollowUp> {
  final Value<int> id;
  final Value<int> customerId;
  final Value<String> title;
  final Value<String?> description;
  final Value<DateTime> followUpDate;
  final Value<bool> completed;
  final Value<DateTime> createdAt;
  const CustomerFollowUpsCompanion({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.followUpDate = const Value.absent(),
    this.completed = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CustomerFollowUpsCompanion.insert({
    this.id = const Value.absent(),
    required int customerId,
    required String title,
    this.description = const Value.absent(),
    required DateTime followUpDate,
    this.completed = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : customerId = Value(customerId),
       title = Value(title),
       followUpDate = Value(followUpDate);
  static Insertable<CustomerFollowUp> custom({
    Expression<int>? id,
    Expression<int>? customerId,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? followUpDate,
    Expression<bool>? completed,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerId != null) 'customer_id': customerId,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (followUpDate != null) 'follow_up_date': followUpDate,
      if (completed != null) 'completed': completed,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CustomerFollowUpsCompanion copyWith({
    Value<int>? id,
    Value<int>? customerId,
    Value<String>? title,
    Value<String?>? description,
    Value<DateTime>? followUpDate,
    Value<bool>? completed,
    Value<DateTime>? createdAt,
  }) {
    return CustomerFollowUpsCompanion(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      title: title ?? this.title,
      description: description ?? this.description,
      followUpDate: followUpDate ?? this.followUpDate,
      completed: completed ?? this.completed,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (followUpDate.present) {
      map['follow_up_date'] = Variable<DateTime>(followUpDate.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomerFollowUpsCompanion(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('followUpDate: $followUpDate, ')
          ..write('completed: $completed, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CustomerLoyaltiesTable extends CustomerLoyalties
    with TableInfo<$CustomerLoyaltiesTable, CustomerLoyalty> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomerLoyaltiesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pointsMeta = const VerificationMeta('points');
  @override
  late final GeneratedColumn<int> points = GeneratedColumn<int>(
    'points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _tierMeta = const VerificationMeta('tier');
  @override
  late final GeneratedColumn<String> tier = GeneratedColumn<String>(
    'tier',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Bronze'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    customerId,
    points,
    tier,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customer_loyalties';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomerLoyalty> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('points')) {
      context.handle(
        _pointsMeta,
        points.isAcceptableOrUnknown(data['points']!, _pointsMeta),
      );
    }
    if (data.containsKey('tier')) {
      context.handle(
        _tierMeta,
        tier.isAcceptableOrUnknown(data['tier']!, _tierMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomerLoyalty map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomerLoyalty(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}customer_id'],
      )!,
      points: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}points'],
      )!,
      tier: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tier'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CustomerLoyaltiesTable createAlias(String alias) {
    return $CustomerLoyaltiesTable(attachedDatabase, alias);
  }
}

class CustomerLoyalty extends DataClass implements Insertable<CustomerLoyalty> {
  final int id;
  final int customerId;
  final int points;
  final String tier;
  final DateTime updatedAt;
  const CustomerLoyalty({
    required this.id,
    required this.customerId,
    required this.points,
    required this.tier,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['customer_id'] = Variable<int>(customerId);
    map['points'] = Variable<int>(points);
    map['tier'] = Variable<String>(tier);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CustomerLoyaltiesCompanion toCompanion(bool nullToAbsent) {
    return CustomerLoyaltiesCompanion(
      id: Value(id),
      customerId: Value(customerId),
      points: Value(points),
      tier: Value(tier),
      updatedAt: Value(updatedAt),
    );
  }

  factory CustomerLoyalty.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomerLoyalty(
      id: serializer.fromJson<int>(json['id']),
      customerId: serializer.fromJson<int>(json['customerId']),
      points: serializer.fromJson<int>(json['points']),
      tier: serializer.fromJson<String>(json['tier']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'customerId': serializer.toJson<int>(customerId),
      'points': serializer.toJson<int>(points),
      'tier': serializer.toJson<String>(tier),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CustomerLoyalty copyWith({
    int? id,
    int? customerId,
    int? points,
    String? tier,
    DateTime? updatedAt,
  }) => CustomerLoyalty(
    id: id ?? this.id,
    customerId: customerId ?? this.customerId,
    points: points ?? this.points,
    tier: tier ?? this.tier,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CustomerLoyalty copyWithCompanion(CustomerLoyaltiesCompanion data) {
    return CustomerLoyalty(
      id: data.id.present ? data.id.value : this.id,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      points: data.points.present ? data.points.value : this.points,
      tier: data.tier.present ? data.tier.value : this.tier,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomerLoyalty(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('points: $points, ')
          ..write('tier: $tier, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, customerId, points, tier, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomerLoyalty &&
          other.id == this.id &&
          other.customerId == this.customerId &&
          other.points == this.points &&
          other.tier == this.tier &&
          other.updatedAt == this.updatedAt);
}

class CustomerLoyaltiesCompanion extends UpdateCompanion<CustomerLoyalty> {
  final Value<int> id;
  final Value<int> customerId;
  final Value<int> points;
  final Value<String> tier;
  final Value<DateTime> updatedAt;
  const CustomerLoyaltiesCompanion({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    this.points = const Value.absent(),
    this.tier = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CustomerLoyaltiesCompanion.insert({
    this.id = const Value.absent(),
    required int customerId,
    this.points = const Value.absent(),
    this.tier = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : customerId = Value(customerId);
  static Insertable<CustomerLoyalty> custom({
    Expression<int>? id,
    Expression<int>? customerId,
    Expression<int>? points,
    Expression<String>? tier,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerId != null) 'customer_id': customerId,
      if (points != null) 'points': points,
      if (tier != null) 'tier': tier,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CustomerLoyaltiesCompanion copyWith({
    Value<int>? id,
    Value<int>? customerId,
    Value<int>? points,
    Value<String>? tier,
    Value<DateTime>? updatedAt,
  }) {
    return CustomerLoyaltiesCompanion(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      points: points ?? this.points,
      tier: tier ?? this.tier,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (points.present) {
      map['points'] = Variable<int>(points.value);
    }
    if (tier.present) {
      map['tier'] = Variable<String>(tier.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomerLoyaltiesCompanion(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('points: $points, ')
          ..write('tier: $tier, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final $SuppliersTable suppliers = $SuppliersTable(this);
  late final $SalesTable sales = $SalesTable(this);
  late final $SaleItemsTable saleItems = $SaleItemsTable(this);
  late final $PurchasesTable purchases = $PurchasesTable(this);
  late final $PurchaseItemsTable purchaseItems = $PurchaseItemsTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $InvoicesTable invoices = $InvoicesTable(this);
  late final $InvoiceItemsTable invoiceItems = $InvoiceItemsTable(this);
  late final $PaymentHistoriesTable paymentHistories = $PaymentHistoriesTable(
    this,
  );
  late final $ProductVariantsTable productVariants = $ProductVariantsTable(
    this,
  );
  late final $SupplierPaymentHistoriesTable supplierPaymentHistories =
      $SupplierPaymentHistoriesTable(this);
  late final $PurchaseReturnsTable purchaseReturns = $PurchaseReturnsTable(
    this,
  );
  late final $SalesReturnsTable salesReturns = $SalesReturnsTable(this);
  late final $BusinessSettingsTable businessSettings = $BusinessSettingsTable(
    this,
  );
  late final $ProductPriceHistoriesTable productPriceHistories =
      $ProductPriceHistoriesTable(this);
  late final $CustomerNotesTable customerNotes = $CustomerNotesTable(this);
  late final $CustomerDocumentsTable customerDocuments =
      $CustomerDocumentsTable(this);
  late final $CustomerFollowUpsTable customerFollowUps =
      $CustomerFollowUpsTable(this);
  late final $CustomerLoyaltiesTable customerLoyalties =
      $CustomerLoyaltiesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    categories,
    products,
    customers,
    suppliers,
    sales,
    saleItems,
    purchases,
    purchaseItems,
    expenses,
    invoices,
    invoiceItems,
    paymentHistories,
    productVariants,
    supplierPaymentHistories,
    purchaseReturns,
    salesReturns,
    businessSettings,
    productPriceHistories,
    customerNotes,
    customerDocuments,
    customerFollowUps,
    customerLoyalties,
  ];
}

typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      required String name,
      required String email,
      required String password,
      required String role,
      Value<DateTime> createdAt,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> email,
      Value<String> password,
      Value<String> role,
      Value<DateTime> createdAt,
    });

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
          User,
          PrefetchHooks Function()
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> password = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                name: name,
                email: email,
                password: password,
                role: role,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String email,
                required String password,
                required String role,
                Value<DateTime> createdAt = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                name: name,
                email: email,
                password: password,
                role: role,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
      User,
      PrefetchHooks Function()
    >;
typedef $$CategoriesTableCreateCompanionBuilder =
    CategoriesCompanion Function({
      Value<int> id,
      required String name,
      required String pricingType,
      required String unit,
      Value<bool> isActive,
      Value<DateTime> createdAt,
    });
typedef $$CategoriesTableUpdateCompanionBuilder =
    CategoriesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> pricingType,
      Value<String> unit,
      Value<bool> isActive,
      Value<DateTime> createdAt,
    });

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pricingType => $composableBuilder(
    column: $table.pricingType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pricingType => $composableBuilder(
    column: $table.pricingType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get pricingType => $composableBuilder(
    column: $table.pricingType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          Category,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (Category, BaseReferences<_$AppDatabase, $CategoriesTable, Category>),
          Category,
          PrefetchHooks Function()
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> pricingType = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                name: name,
                pricingType: pricingType,
                unit: unit,
                isActive: isActive,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String pricingType,
                required String unit,
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CategoriesCompanion.insert(
                id: id,
                name: name,
                pricingType: pricingType,
                unit: unit,
                isActive: isActive,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      Category,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (Category, BaseReferences<_$AppDatabase, $CategoriesTable, Category>),
      Category,
      PrefetchHooks Function()
    >;
typedef $$ProductsTableCreateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      required int categoryId,
      required String name,
      Value<String?> sku,
      Value<String?> barcode,
      required double purchasePrice,
      required double sellingPrice,
      required int stockQty,
      required int minStock,
      Value<String?> imagePath,
      Value<DateTime> createdAt,
    });
typedef $$ProductsTableUpdateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      Value<int> categoryId,
      Value<String> name,
      Value<String?> sku,
      Value<String?> barcode,
      Value<double> purchasePrice,
      Value<double> sellingPrice,
      Value<int> stockQty,
      Value<int> minStock,
      Value<String?> imagePath,
      Value<DateTime> createdAt,
    });

final class $$ProductsTableReferences
    extends BaseReferences<_$AppDatabase, $ProductsTable, Product> {
  $$ProductsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProductVariantsTable, List<ProductVariant>>
  _productVariantsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.productVariants,
    aliasName: $_aliasNameGenerator(
      db.products.id,
      db.productVariants.productId,
    ),
  );

  $$ProductVariantsTableProcessedTableManager get productVariantsRefs {
    final manager = $$ProductVariantsTableTableManager(
      $_db,
      $_db.productVariants,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _productVariantsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
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

  ColumnFilters<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sellingPrice => $composableBuilder(
    column: $table.sellingPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stockQty => $composableBuilder(
    column: $table.stockQty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minStock => $composableBuilder(
    column: $table.minStock,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> productVariantsRefs(
    Expression<bool> Function($$ProductVariantsTableFilterComposer f) f,
  ) {
    final $$ProductVariantsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productVariants,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductVariantsTableFilterComposer(
            $db: $db,
            $table: $db.productVariants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
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

  ColumnOrderings<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sellingPrice => $composableBuilder(
    column: $table.sellingPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stockQty => $composableBuilder(
    column: $table.stockQty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minStock => $composableBuilder(
    column: $table.minStock,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get sku =>
      $composableBuilder(column: $table.sku, builder: (column) => column);

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get sellingPrice => $composableBuilder(
    column: $table.sellingPrice,
    builder: (column) => column,
  );

  GeneratedColumn<int> get stockQty =>
      $composableBuilder(column: $table.stockQty, builder: (column) => column);

  GeneratedColumn<int> get minStock =>
      $composableBuilder(column: $table.minStock, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> productVariantsRefs<T extends Object>(
    Expression<T> Function($$ProductVariantsTableAnnotationComposer a) f,
  ) {
    final $$ProductVariantsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productVariants,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductVariantsTableAnnotationComposer(
            $db: $db,
            $table: $db.productVariants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          Product,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (Product, $$ProductsTableReferences),
          Product,
          PrefetchHooks Function({bool productVariantsRefs})
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> categoryId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> sku = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<double> purchasePrice = const Value.absent(),
                Value<double> sellingPrice = const Value.absent(),
                Value<int> stockQty = const Value.absent(),
                Value<int> minStock = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ProductsCompanion(
                id: id,
                categoryId: categoryId,
                name: name,
                sku: sku,
                barcode: barcode,
                purchasePrice: purchasePrice,
                sellingPrice: sellingPrice,
                stockQty: stockQty,
                minStock: minStock,
                imagePath: imagePath,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int categoryId,
                required String name,
                Value<String?> sku = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                required double purchasePrice,
                required double sellingPrice,
                required int stockQty,
                required int minStock,
                Value<String?> imagePath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ProductsCompanion.insert(
                id: id,
                categoryId: categoryId,
                name: name,
                sku: sku,
                barcode: barcode,
                purchasePrice: purchasePrice,
                sellingPrice: sellingPrice,
                stockQty: stockQty,
                minStock: minStock,
                imagePath: imagePath,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProductsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productVariantsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (productVariantsRefs) db.productVariants,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (productVariantsRefs)
                    await $_getPrefetchedData<
                      Product,
                      $ProductsTable,
                      ProductVariant
                    >(
                      currentTable: table,
                      referencedTable: $$ProductsTableReferences
                          ._productVariantsRefsTable(db),
                      managerFromTypedResult: (p0) => $$ProductsTableReferences(
                        db,
                        table,
                        p0,
                      ).productVariantsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.productId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      Product,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (Product, $$ProductsTableReferences),
      Product,
      PrefetchHooks Function({bool productVariantsRefs})
    >;
typedef $$CustomersTableCreateCompanionBuilder =
    CustomersCompanion Function({
      Value<int> id,
      required String name,
      required String phone,
      Value<String?> email,
      Value<String?> address,
      Value<double> creditBalance,
      Value<DateTime> createdAt,
    });
typedef $$CustomersTableUpdateCompanionBuilder =
    CustomersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> phone,
      Value<String?> email,
      Value<String?> address,
      Value<double> creditBalance,
      Value<DateTime> createdAt,
    });

class $$CustomersTableFilterComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get creditBalance => $composableBuilder(
    column: $table.creditBalance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CustomersTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get creditBalance => $composableBuilder(
    column: $table.creditBalance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<double> get creditBalance => $composableBuilder(
    column: $table.creditBalance,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CustomersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomersTable,
          Customer,
          $$CustomersTableFilterComposer,
          $$CustomersTableOrderingComposer,
          $$CustomersTableAnnotationComposer,
          $$CustomersTableCreateCompanionBuilder,
          $$CustomersTableUpdateCompanionBuilder,
          (Customer, BaseReferences<_$AppDatabase, $CustomersTable, Customer>),
          Customer,
          PrefetchHooks Function()
        > {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<double> creditBalance = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CustomersCompanion(
                id: id,
                name: name,
                phone: phone,
                email: email,
                address: address,
                creditBalance: creditBalance,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String phone,
                Value<String?> email = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<double> creditBalance = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CustomersCompanion.insert(
                id: id,
                name: name,
                phone: phone,
                email: email,
                address: address,
                creditBalance: creditBalance,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CustomersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomersTable,
      Customer,
      $$CustomersTableFilterComposer,
      $$CustomersTableOrderingComposer,
      $$CustomersTableAnnotationComposer,
      $$CustomersTableCreateCompanionBuilder,
      $$CustomersTableUpdateCompanionBuilder,
      (Customer, BaseReferences<_$AppDatabase, $CustomersTable, Customer>),
      Customer,
      PrefetchHooks Function()
    >;
typedef $$SuppliersTableCreateCompanionBuilder =
    SuppliersCompanion Function({
      Value<int> id,
      required String name,
      required String phone,
      Value<String?> email,
      Value<String?> address,
      Value<double> creditBalance,
      Value<DateTime> createdAt,
      Value<String?> gstNumber,
      Value<bool> isActive,
    });
typedef $$SuppliersTableUpdateCompanionBuilder =
    SuppliersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> phone,
      Value<String?> email,
      Value<String?> address,
      Value<double> creditBalance,
      Value<DateTime> createdAt,
      Value<String?> gstNumber,
      Value<bool> isActive,
    });

class $$SuppliersTableFilterComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get creditBalance => $composableBuilder(
    column: $table.creditBalance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gstNumber => $composableBuilder(
    column: $table.gstNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SuppliersTableOrderingComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get creditBalance => $composableBuilder(
    column: $table.creditBalance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gstNumber => $composableBuilder(
    column: $table.gstNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SuppliersTableAnnotationComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<double> get creditBalance => $composableBuilder(
    column: $table.creditBalance,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get gstNumber =>
      $composableBuilder(column: $table.gstNumber, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);
}

class $$SuppliersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SuppliersTable,
          Supplier,
          $$SuppliersTableFilterComposer,
          $$SuppliersTableOrderingComposer,
          $$SuppliersTableAnnotationComposer,
          $$SuppliersTableCreateCompanionBuilder,
          $$SuppliersTableUpdateCompanionBuilder,
          (Supplier, BaseReferences<_$AppDatabase, $SuppliersTable, Supplier>),
          Supplier,
          PrefetchHooks Function()
        > {
  $$SuppliersTableTableManager(_$AppDatabase db, $SuppliersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SuppliersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SuppliersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SuppliersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<double> creditBalance = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> gstNumber = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
              }) => SuppliersCompanion(
                id: id,
                name: name,
                phone: phone,
                email: email,
                address: address,
                creditBalance: creditBalance,
                createdAt: createdAt,
                gstNumber: gstNumber,
                isActive: isActive,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String phone,
                Value<String?> email = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<double> creditBalance = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> gstNumber = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
              }) => SuppliersCompanion.insert(
                id: id,
                name: name,
                phone: phone,
                email: email,
                address: address,
                creditBalance: creditBalance,
                createdAt: createdAt,
                gstNumber: gstNumber,
                isActive: isActive,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SuppliersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SuppliersTable,
      Supplier,
      $$SuppliersTableFilterComposer,
      $$SuppliersTableOrderingComposer,
      $$SuppliersTableAnnotationComposer,
      $$SuppliersTableCreateCompanionBuilder,
      $$SuppliersTableUpdateCompanionBuilder,
      (Supplier, BaseReferences<_$AppDatabase, $SuppliersTable, Supplier>),
      Supplier,
      PrefetchHooks Function()
    >;
typedef $$SalesTableCreateCompanionBuilder =
    SalesCompanion Function({
      Value<int> id,
      required int customerId,
      required String invoiceNo,
      required double total,
      required double discount,
      required double tax,
      required double grandTotal,
      required String paymentStatus,
      Value<DateTime> createdAt,
    });
typedef $$SalesTableUpdateCompanionBuilder =
    SalesCompanion Function({
      Value<int> id,
      Value<int> customerId,
      Value<String> invoiceNo,
      Value<double> total,
      Value<double> discount,
      Value<double> tax,
      Value<double> grandTotal,
      Value<String> paymentStatus,
      Value<DateTime> createdAt,
    });

class $$SalesTableFilterComposer extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableFilterComposer({
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

  ColumnFilters<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoiceNo => $composableBuilder(
    column: $table.invoiceNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tax => $composableBuilder(
    column: $table.tax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get grandTotal => $composableBuilder(
    column: $table.grandTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentStatus => $composableBuilder(
    column: $table.paymentStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SalesTableOrderingComposer
    extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableOrderingComposer({
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

  ColumnOrderings<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoiceNo => $composableBuilder(
    column: $table.invoiceNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tax => $composableBuilder(
    column: $table.tax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get grandTotal => $composableBuilder(
    column: $table.grandTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentStatus => $composableBuilder(
    column: $table.paymentStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SalesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get invoiceNo =>
      $composableBuilder(column: $table.invoiceNo, builder: (column) => column);

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<double> get discount =>
      $composableBuilder(column: $table.discount, builder: (column) => column);

  GeneratedColumn<double> get tax =>
      $composableBuilder(column: $table.tax, builder: (column) => column);

  GeneratedColumn<double> get grandTotal => $composableBuilder(
    column: $table.grandTotal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentStatus => $composableBuilder(
    column: $table.paymentStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SalesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SalesTable,
          Sale,
          $$SalesTableFilterComposer,
          $$SalesTableOrderingComposer,
          $$SalesTableAnnotationComposer,
          $$SalesTableCreateCompanionBuilder,
          $$SalesTableUpdateCompanionBuilder,
          (Sale, BaseReferences<_$AppDatabase, $SalesTable, Sale>),
          Sale,
          PrefetchHooks Function()
        > {
  $$SalesTableTableManager(_$AppDatabase db, $SalesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SalesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SalesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SalesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> customerId = const Value.absent(),
                Value<String> invoiceNo = const Value.absent(),
                Value<double> total = const Value.absent(),
                Value<double> discount = const Value.absent(),
                Value<double> tax = const Value.absent(),
                Value<double> grandTotal = const Value.absent(),
                Value<String> paymentStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SalesCompanion(
                id: id,
                customerId: customerId,
                invoiceNo: invoiceNo,
                total: total,
                discount: discount,
                tax: tax,
                grandTotal: grandTotal,
                paymentStatus: paymentStatus,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int customerId,
                required String invoiceNo,
                required double total,
                required double discount,
                required double tax,
                required double grandTotal,
                required String paymentStatus,
                Value<DateTime> createdAt = const Value.absent(),
              }) => SalesCompanion.insert(
                id: id,
                customerId: customerId,
                invoiceNo: invoiceNo,
                total: total,
                discount: discount,
                tax: tax,
                grandTotal: grandTotal,
                paymentStatus: paymentStatus,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SalesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SalesTable,
      Sale,
      $$SalesTableFilterComposer,
      $$SalesTableOrderingComposer,
      $$SalesTableAnnotationComposer,
      $$SalesTableCreateCompanionBuilder,
      $$SalesTableUpdateCompanionBuilder,
      (Sale, BaseReferences<_$AppDatabase, $SalesTable, Sale>),
      Sale,
      PrefetchHooks Function()
    >;
typedef $$SaleItemsTableCreateCompanionBuilder =
    SaleItemsCompanion Function({
      Value<int> id,
      required int saleId,
      required int productId,
      required int qty,
      required double price,
      required double subtotal,
    });
typedef $$SaleItemsTableUpdateCompanionBuilder =
    SaleItemsCompanion Function({
      Value<int> id,
      Value<int> saleId,
      Value<int> productId,
      Value<int> qty,
      Value<double> price,
      Value<double> subtotal,
    });

class $$SaleItemsTableFilterComposer
    extends Composer<_$AppDatabase, $SaleItemsTable> {
  $$SaleItemsTableFilterComposer({
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

  ColumnFilters<int> get saleId => $composableBuilder(
    column: $table.saleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SaleItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $SaleItemsTable> {
  $$SaleItemsTableOrderingComposer({
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

  ColumnOrderings<int> get saleId => $composableBuilder(
    column: $table.saleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SaleItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SaleItemsTable> {
  $$SaleItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get saleId =>
      $composableBuilder(column: $table.saleId, builder: (column) => column);

  GeneratedColumn<int> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<int> get qty =>
      $composableBuilder(column: $table.qty, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<double> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);
}

class $$SaleItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SaleItemsTable,
          SaleItem,
          $$SaleItemsTableFilterComposer,
          $$SaleItemsTableOrderingComposer,
          $$SaleItemsTableAnnotationComposer,
          $$SaleItemsTableCreateCompanionBuilder,
          $$SaleItemsTableUpdateCompanionBuilder,
          (SaleItem, BaseReferences<_$AppDatabase, $SaleItemsTable, SaleItem>),
          SaleItem,
          PrefetchHooks Function()
        > {
  $$SaleItemsTableTableManager(_$AppDatabase db, $SaleItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SaleItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SaleItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SaleItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> saleId = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int> qty = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<double> subtotal = const Value.absent(),
              }) => SaleItemsCompanion(
                id: id,
                saleId: saleId,
                productId: productId,
                qty: qty,
                price: price,
                subtotal: subtotal,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int saleId,
                required int productId,
                required int qty,
                required double price,
                required double subtotal,
              }) => SaleItemsCompanion.insert(
                id: id,
                saleId: saleId,
                productId: productId,
                qty: qty,
                price: price,
                subtotal: subtotal,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SaleItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SaleItemsTable,
      SaleItem,
      $$SaleItemsTableFilterComposer,
      $$SaleItemsTableOrderingComposer,
      $$SaleItemsTableAnnotationComposer,
      $$SaleItemsTableCreateCompanionBuilder,
      $$SaleItemsTableUpdateCompanionBuilder,
      (SaleItem, BaseReferences<_$AppDatabase, $SaleItemsTable, SaleItem>),
      SaleItem,
      PrefetchHooks Function()
    >;
typedef $$PurchasesTableCreateCompanionBuilder =
    PurchasesCompanion Function({
      Value<int> id,
      required String purchaseNo,
      required String supplierName,
      Value<String?> supplierPhone,
      required double total,
      Value<String?> pdfPath,
      Value<DateTime> createdAt,
    });
typedef $$PurchasesTableUpdateCompanionBuilder =
    PurchasesCompanion Function({
      Value<int> id,
      Value<String> purchaseNo,
      Value<String> supplierName,
      Value<String?> supplierPhone,
      Value<double> total,
      Value<String?> pdfPath,
      Value<DateTime> createdAt,
    });

class $$PurchasesTableFilterComposer
    extends Composer<_$AppDatabase, $PurchasesTable> {
  $$PurchasesTableFilterComposer({
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

  ColumnFilters<String> get purchaseNo => $composableBuilder(
    column: $table.purchaseNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplierName => $composableBuilder(
    column: $table.supplierName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplierPhone => $composableBuilder(
    column: $table.supplierPhone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pdfPath => $composableBuilder(
    column: $table.pdfPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PurchasesTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchasesTable> {
  $$PurchasesTableOrderingComposer({
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

  ColumnOrderings<String> get purchaseNo => $composableBuilder(
    column: $table.purchaseNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplierName => $composableBuilder(
    column: $table.supplierName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplierPhone => $composableBuilder(
    column: $table.supplierPhone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pdfPath => $composableBuilder(
    column: $table.pdfPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PurchasesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchasesTable> {
  $$PurchasesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get purchaseNo => $composableBuilder(
    column: $table.purchaseNo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get supplierName => $composableBuilder(
    column: $table.supplierName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get supplierPhone => $composableBuilder(
    column: $table.supplierPhone,
    builder: (column) => column,
  );

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<String> get pdfPath =>
      $composableBuilder(column: $table.pdfPath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PurchasesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchasesTable,
          Purchase,
          $$PurchasesTableFilterComposer,
          $$PurchasesTableOrderingComposer,
          $$PurchasesTableAnnotationComposer,
          $$PurchasesTableCreateCompanionBuilder,
          $$PurchasesTableUpdateCompanionBuilder,
          (Purchase, BaseReferences<_$AppDatabase, $PurchasesTable, Purchase>),
          Purchase,
          PrefetchHooks Function()
        > {
  $$PurchasesTableTableManager(_$AppDatabase db, $PurchasesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchasesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchasesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchasesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> purchaseNo = const Value.absent(),
                Value<String> supplierName = const Value.absent(),
                Value<String?> supplierPhone = const Value.absent(),
                Value<double> total = const Value.absent(),
                Value<String?> pdfPath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PurchasesCompanion(
                id: id,
                purchaseNo: purchaseNo,
                supplierName: supplierName,
                supplierPhone: supplierPhone,
                total: total,
                pdfPath: pdfPath,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String purchaseNo,
                required String supplierName,
                Value<String?> supplierPhone = const Value.absent(),
                required double total,
                Value<String?> pdfPath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PurchasesCompanion.insert(
                id: id,
                purchaseNo: purchaseNo,
                supplierName: supplierName,
                supplierPhone: supplierPhone,
                total: total,
                pdfPath: pdfPath,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PurchasesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchasesTable,
      Purchase,
      $$PurchasesTableFilterComposer,
      $$PurchasesTableOrderingComposer,
      $$PurchasesTableAnnotationComposer,
      $$PurchasesTableCreateCompanionBuilder,
      $$PurchasesTableUpdateCompanionBuilder,
      (Purchase, BaseReferences<_$AppDatabase, $PurchasesTable, Purchase>),
      Purchase,
      PrefetchHooks Function()
    >;
typedef $$PurchaseItemsTableCreateCompanionBuilder =
    PurchaseItemsCompanion Function({
      Value<int> id,
      required int purchaseId,
      required int productId,
      required String productName,
      required int quantity,
      required double purchasePrice,
      required double total,
      Value<DateTime> createdAt,
      Value<int?> variantId,
      Value<String?> variantName,
    });
typedef $$PurchaseItemsTableUpdateCompanionBuilder =
    PurchaseItemsCompanion Function({
      Value<int> id,
      Value<int> purchaseId,
      Value<int> productId,
      Value<String> productName,
      Value<int> quantity,
      Value<double> purchasePrice,
      Value<double> total,
      Value<DateTime> createdAt,
      Value<int?> variantId,
      Value<String?> variantName,
    });

class $$PurchaseItemsTableFilterComposer
    extends Composer<_$AppDatabase, $PurchaseItemsTable> {
  $$PurchaseItemsTableFilterComposer({
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

  ColumnFilters<int> get purchaseId => $composableBuilder(
    column: $table.purchaseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get variantId => $composableBuilder(
    column: $table.variantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get variantName => $composableBuilder(
    column: $table.variantName,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PurchaseItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchaseItemsTable> {
  $$PurchaseItemsTableOrderingComposer({
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

  ColumnOrderings<int> get purchaseId => $composableBuilder(
    column: $table.purchaseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get variantId => $composableBuilder(
    column: $table.variantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get variantName => $composableBuilder(
    column: $table.variantName,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PurchaseItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchaseItemsTable> {
  $$PurchaseItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get purchaseId => $composableBuilder(
    column: $table.purchaseId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get variantId =>
      $composableBuilder(column: $table.variantId, builder: (column) => column);

  GeneratedColumn<String> get variantName => $composableBuilder(
    column: $table.variantName,
    builder: (column) => column,
  );
}

class $$PurchaseItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchaseItemsTable,
          PurchaseItem,
          $$PurchaseItemsTableFilterComposer,
          $$PurchaseItemsTableOrderingComposer,
          $$PurchaseItemsTableAnnotationComposer,
          $$PurchaseItemsTableCreateCompanionBuilder,
          $$PurchaseItemsTableUpdateCompanionBuilder,
          (
            PurchaseItem,
            BaseReferences<_$AppDatabase, $PurchaseItemsTable, PurchaseItem>,
          ),
          PurchaseItem,
          PrefetchHooks Function()
        > {
  $$PurchaseItemsTableTableManager(_$AppDatabase db, $PurchaseItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchaseItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchaseItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchaseItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> purchaseId = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<String> productName = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<double> purchasePrice = const Value.absent(),
                Value<double> total = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int?> variantId = const Value.absent(),
                Value<String?> variantName = const Value.absent(),
              }) => PurchaseItemsCompanion(
                id: id,
                purchaseId: purchaseId,
                productId: productId,
                productName: productName,
                quantity: quantity,
                purchasePrice: purchasePrice,
                total: total,
                createdAt: createdAt,
                variantId: variantId,
                variantName: variantName,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int purchaseId,
                required int productId,
                required String productName,
                required int quantity,
                required double purchasePrice,
                required double total,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int?> variantId = const Value.absent(),
                Value<String?> variantName = const Value.absent(),
              }) => PurchaseItemsCompanion.insert(
                id: id,
                purchaseId: purchaseId,
                productId: productId,
                productName: productName,
                quantity: quantity,
                purchasePrice: purchasePrice,
                total: total,
                createdAt: createdAt,
                variantId: variantId,
                variantName: variantName,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PurchaseItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchaseItemsTable,
      PurchaseItem,
      $$PurchaseItemsTableFilterComposer,
      $$PurchaseItemsTableOrderingComposer,
      $$PurchaseItemsTableAnnotationComposer,
      $$PurchaseItemsTableCreateCompanionBuilder,
      $$PurchaseItemsTableUpdateCompanionBuilder,
      (
        PurchaseItem,
        BaseReferences<_$AppDatabase, $PurchaseItemsTable, PurchaseItem>,
      ),
      PurchaseItem,
      PrefetchHooks Function()
    >;
typedef $$ExpensesTableCreateCompanionBuilder =
    ExpensesCompanion Function({
      Value<int> id,
      required String title,
      required double amount,
      required String category,
      Value<String?> note,
      Value<DateTime> createdAt,
    });
typedef $$ExpensesTableUpdateCompanionBuilder =
    ExpensesCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<double> amount,
      Value<String> category,
      Value<String?> note,
      Value<DateTime> createdAt,
    });

class $$ExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ExpensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpensesTable,
          Expense,
          $$ExpensesTableFilterComposer,
          $$ExpensesTableOrderingComposer,
          $$ExpensesTableAnnotationComposer,
          $$ExpensesTableCreateCompanionBuilder,
          $$ExpensesTableUpdateCompanionBuilder,
          (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
          Expense,
          PrefetchHooks Function()
        > {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ExpensesCompanion(
                id: id,
                title: title,
                amount: amount,
                category: category,
                note: note,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required double amount,
                required String category,
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ExpensesCompanion.insert(
                id: id,
                title: title,
                amount: amount,
                category: category,
                note: note,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExpensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpensesTable,
      Expense,
      $$ExpensesTableFilterComposer,
      $$ExpensesTableOrderingComposer,
      $$ExpensesTableAnnotationComposer,
      $$ExpensesTableCreateCompanionBuilder,
      $$ExpensesTableUpdateCompanionBuilder,
      (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
      Expense,
      PrefetchHooks Function()
    >;
typedef $$InvoicesTableCreateCompanionBuilder =
    InvoicesCompanion Function({
      Value<int> id,
      required String invoiceNo,
      required String customerName,
      required String customerPhone,
      required double subtotal,
      required double tax,
      Value<double> discount,
      required double grandTotal,
      Value<String> paymentMethod,
      Value<String> paymentStatus,
      Value<DateTime> createdAt,
      Value<String?> pdfPath,
      Value<double> amountPaid,
      Value<double> dueAmount,
      Value<DateTime?> dueDate,
      Value<bool> reminderSent,
      Value<double> loadingCharge,
      Value<double> unloadingCharge,
      Value<double> transportCharge,
      Value<int?> customerId,
    });
typedef $$InvoicesTableUpdateCompanionBuilder =
    InvoicesCompanion Function({
      Value<int> id,
      Value<String> invoiceNo,
      Value<String> customerName,
      Value<String> customerPhone,
      Value<double> subtotal,
      Value<double> tax,
      Value<double> discount,
      Value<double> grandTotal,
      Value<String> paymentMethod,
      Value<String> paymentStatus,
      Value<DateTime> createdAt,
      Value<String?> pdfPath,
      Value<double> amountPaid,
      Value<double> dueAmount,
      Value<DateTime?> dueDate,
      Value<bool> reminderSent,
      Value<double> loadingCharge,
      Value<double> unloadingCharge,
      Value<double> transportCharge,
      Value<int?> customerId,
    });

class $$InvoicesTableFilterComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableFilterComposer({
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

  ColumnFilters<String> get invoiceNo => $composableBuilder(
    column: $table.invoiceNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerPhone => $composableBuilder(
    column: $table.customerPhone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tax => $composableBuilder(
    column: $table.tax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get grandTotal => $composableBuilder(
    column: $table.grandTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentStatus => $composableBuilder(
    column: $table.paymentStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pdfPath => $composableBuilder(
    column: $table.pdfPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amountPaid => $composableBuilder(
    column: $table.amountPaid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get dueAmount => $composableBuilder(
    column: $table.dueAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get reminderSent => $composableBuilder(
    column: $table.reminderSent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get loadingCharge => $composableBuilder(
    column: $table.loadingCharge,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unloadingCharge => $composableBuilder(
    column: $table.unloadingCharge,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get transportCharge => $composableBuilder(
    column: $table.transportCharge,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InvoicesTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableOrderingComposer({
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

  ColumnOrderings<String> get invoiceNo => $composableBuilder(
    column: $table.invoiceNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerPhone => $composableBuilder(
    column: $table.customerPhone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tax => $composableBuilder(
    column: $table.tax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get grandTotal => $composableBuilder(
    column: $table.grandTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentStatus => $composableBuilder(
    column: $table.paymentStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pdfPath => $composableBuilder(
    column: $table.pdfPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amountPaid => $composableBuilder(
    column: $table.amountPaid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get dueAmount => $composableBuilder(
    column: $table.dueAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get reminderSent => $composableBuilder(
    column: $table.reminderSent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get loadingCharge => $composableBuilder(
    column: $table.loadingCharge,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unloadingCharge => $composableBuilder(
    column: $table.unloadingCharge,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get transportCharge => $composableBuilder(
    column: $table.transportCharge,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InvoicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get invoiceNo =>
      $composableBuilder(column: $table.invoiceNo, builder: (column) => column);

  GeneratedColumn<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customerPhone => $composableBuilder(
    column: $table.customerPhone,
    builder: (column) => column,
  );

  GeneratedColumn<double> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<double> get tax =>
      $composableBuilder(column: $table.tax, builder: (column) => column);

  GeneratedColumn<double> get discount =>
      $composableBuilder(column: $table.discount, builder: (column) => column);

  GeneratedColumn<double> get grandTotal => $composableBuilder(
    column: $table.grandTotal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentStatus => $composableBuilder(
    column: $table.paymentStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get pdfPath =>
      $composableBuilder(column: $table.pdfPath, builder: (column) => column);

  GeneratedColumn<double> get amountPaid => $composableBuilder(
    column: $table.amountPaid,
    builder: (column) => column,
  );

  GeneratedColumn<double> get dueAmount =>
      $composableBuilder(column: $table.dueAmount, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<bool> get reminderSent => $composableBuilder(
    column: $table.reminderSent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get loadingCharge => $composableBuilder(
    column: $table.loadingCharge,
    builder: (column) => column,
  );

  GeneratedColumn<double> get unloadingCharge => $composableBuilder(
    column: $table.unloadingCharge,
    builder: (column) => column,
  );

  GeneratedColumn<double> get transportCharge => $composableBuilder(
    column: $table.transportCharge,
    builder: (column) => column,
  );

  GeneratedColumn<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => column,
  );
}

class $$InvoicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvoicesTable,
          Invoice,
          $$InvoicesTableFilterComposer,
          $$InvoicesTableOrderingComposer,
          $$InvoicesTableAnnotationComposer,
          $$InvoicesTableCreateCompanionBuilder,
          $$InvoicesTableUpdateCompanionBuilder,
          (Invoice, BaseReferences<_$AppDatabase, $InvoicesTable, Invoice>),
          Invoice,
          PrefetchHooks Function()
        > {
  $$InvoicesTableTableManager(_$AppDatabase db, $InvoicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> invoiceNo = const Value.absent(),
                Value<String> customerName = const Value.absent(),
                Value<String> customerPhone = const Value.absent(),
                Value<double> subtotal = const Value.absent(),
                Value<double> tax = const Value.absent(),
                Value<double> discount = const Value.absent(),
                Value<double> grandTotal = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<String> paymentStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> pdfPath = const Value.absent(),
                Value<double> amountPaid = const Value.absent(),
                Value<double> dueAmount = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                Value<bool> reminderSent = const Value.absent(),
                Value<double> loadingCharge = const Value.absent(),
                Value<double> unloadingCharge = const Value.absent(),
                Value<double> transportCharge = const Value.absent(),
                Value<int?> customerId = const Value.absent(),
              }) => InvoicesCompanion(
                id: id,
                invoiceNo: invoiceNo,
                customerName: customerName,
                customerPhone: customerPhone,
                subtotal: subtotal,
                tax: tax,
                discount: discount,
                grandTotal: grandTotal,
                paymentMethod: paymentMethod,
                paymentStatus: paymentStatus,
                createdAt: createdAt,
                pdfPath: pdfPath,
                amountPaid: amountPaid,
                dueAmount: dueAmount,
                dueDate: dueDate,
                reminderSent: reminderSent,
                loadingCharge: loadingCharge,
                unloadingCharge: unloadingCharge,
                transportCharge: transportCharge,
                customerId: customerId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String invoiceNo,
                required String customerName,
                required String customerPhone,
                required double subtotal,
                required double tax,
                Value<double> discount = const Value.absent(),
                required double grandTotal,
                Value<String> paymentMethod = const Value.absent(),
                Value<String> paymentStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> pdfPath = const Value.absent(),
                Value<double> amountPaid = const Value.absent(),
                Value<double> dueAmount = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                Value<bool> reminderSent = const Value.absent(),
                Value<double> loadingCharge = const Value.absent(),
                Value<double> unloadingCharge = const Value.absent(),
                Value<double> transportCharge = const Value.absent(),
                Value<int?> customerId = const Value.absent(),
              }) => InvoicesCompanion.insert(
                id: id,
                invoiceNo: invoiceNo,
                customerName: customerName,
                customerPhone: customerPhone,
                subtotal: subtotal,
                tax: tax,
                discount: discount,
                grandTotal: grandTotal,
                paymentMethod: paymentMethod,
                paymentStatus: paymentStatus,
                createdAt: createdAt,
                pdfPath: pdfPath,
                amountPaid: amountPaid,
                dueAmount: dueAmount,
                dueDate: dueDate,
                reminderSent: reminderSent,
                loadingCharge: loadingCharge,
                unloadingCharge: unloadingCharge,
                transportCharge: transportCharge,
                customerId: customerId,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InvoicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvoicesTable,
      Invoice,
      $$InvoicesTableFilterComposer,
      $$InvoicesTableOrderingComposer,
      $$InvoicesTableAnnotationComposer,
      $$InvoicesTableCreateCompanionBuilder,
      $$InvoicesTableUpdateCompanionBuilder,
      (Invoice, BaseReferences<_$AppDatabase, $InvoicesTable, Invoice>),
      Invoice,
      PrefetchHooks Function()
    >;
typedef $$InvoiceItemsTableCreateCompanionBuilder =
    InvoiceItemsCompanion Function({
      Value<int> id,
      required int invoiceId,
      required int productId,
      Value<int?> variantId,
      required String productName,
      Value<String?> variantName,
      required int quantity,
      required double price,
      Value<double?> height,
      Value<double?> width,
      Value<double?> area,
      required double total,
      Value<DateTime> createdAt,
    });
typedef $$InvoiceItemsTableUpdateCompanionBuilder =
    InvoiceItemsCompanion Function({
      Value<int> id,
      Value<int> invoiceId,
      Value<int> productId,
      Value<int?> variantId,
      Value<String> productName,
      Value<String?> variantName,
      Value<int> quantity,
      Value<double> price,
      Value<double?> height,
      Value<double?> width,
      Value<double?> area,
      Value<double> total,
      Value<DateTime> createdAt,
    });

class $$InvoiceItemsTableFilterComposer
    extends Composer<_$AppDatabase, $InvoiceItemsTable> {
  $$InvoiceItemsTableFilterComposer({
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

  ColumnFilters<int> get invoiceId => $composableBuilder(
    column: $table.invoiceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get variantId => $composableBuilder(
    column: $table.variantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get variantName => $composableBuilder(
    column: $table.variantName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get width => $composableBuilder(
    column: $table.width,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get area => $composableBuilder(
    column: $table.area,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InvoiceItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoiceItemsTable> {
  $$InvoiceItemsTableOrderingComposer({
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

  ColumnOrderings<int> get invoiceId => $composableBuilder(
    column: $table.invoiceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get variantId => $composableBuilder(
    column: $table.variantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get variantName => $composableBuilder(
    column: $table.variantName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get width => $composableBuilder(
    column: $table.width,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get area => $composableBuilder(
    column: $table.area,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InvoiceItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoiceItemsTable> {
  $$InvoiceItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get invoiceId =>
      $composableBuilder(column: $table.invoiceId, builder: (column) => column);

  GeneratedColumn<int> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<int> get variantId =>
      $composableBuilder(column: $table.variantId, builder: (column) => column);

  GeneratedColumn<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get variantName => $composableBuilder(
    column: $table.variantName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<double> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<double> get width =>
      $composableBuilder(column: $table.width, builder: (column) => column);

  GeneratedColumn<double> get area =>
      $composableBuilder(column: $table.area, builder: (column) => column);

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$InvoiceItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvoiceItemsTable,
          InvoiceItem,
          $$InvoiceItemsTableFilterComposer,
          $$InvoiceItemsTableOrderingComposer,
          $$InvoiceItemsTableAnnotationComposer,
          $$InvoiceItemsTableCreateCompanionBuilder,
          $$InvoiceItemsTableUpdateCompanionBuilder,
          (
            InvoiceItem,
            BaseReferences<_$AppDatabase, $InvoiceItemsTable, InvoiceItem>,
          ),
          InvoiceItem,
          PrefetchHooks Function()
        > {
  $$InvoiceItemsTableTableManager(_$AppDatabase db, $InvoiceItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoiceItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoiceItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoiceItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> invoiceId = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int?> variantId = const Value.absent(),
                Value<String> productName = const Value.absent(),
                Value<String?> variantName = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<double?> height = const Value.absent(),
                Value<double?> width = const Value.absent(),
                Value<double?> area = const Value.absent(),
                Value<double> total = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => InvoiceItemsCompanion(
                id: id,
                invoiceId: invoiceId,
                productId: productId,
                variantId: variantId,
                productName: productName,
                variantName: variantName,
                quantity: quantity,
                price: price,
                height: height,
                width: width,
                area: area,
                total: total,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int invoiceId,
                required int productId,
                Value<int?> variantId = const Value.absent(),
                required String productName,
                Value<String?> variantName = const Value.absent(),
                required int quantity,
                required double price,
                Value<double?> height = const Value.absent(),
                Value<double?> width = const Value.absent(),
                Value<double?> area = const Value.absent(),
                required double total,
                Value<DateTime> createdAt = const Value.absent(),
              }) => InvoiceItemsCompanion.insert(
                id: id,
                invoiceId: invoiceId,
                productId: productId,
                variantId: variantId,
                productName: productName,
                variantName: variantName,
                quantity: quantity,
                price: price,
                height: height,
                width: width,
                area: area,
                total: total,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InvoiceItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvoiceItemsTable,
      InvoiceItem,
      $$InvoiceItemsTableFilterComposer,
      $$InvoiceItemsTableOrderingComposer,
      $$InvoiceItemsTableAnnotationComposer,
      $$InvoiceItemsTableCreateCompanionBuilder,
      $$InvoiceItemsTableUpdateCompanionBuilder,
      (
        InvoiceItem,
        BaseReferences<_$AppDatabase, $InvoiceItemsTable, InvoiceItem>,
      ),
      InvoiceItem,
      PrefetchHooks Function()
    >;
typedef $$PaymentHistoriesTableCreateCompanionBuilder =
    PaymentHistoriesCompanion Function({
      Value<int> id,
      required int invoiceId,
      required int customerId,
      required double amount,
      Value<String> paymentMethod,
      Value<String?> notes,
      Value<DateTime> paidAt,
    });
typedef $$PaymentHistoriesTableUpdateCompanionBuilder =
    PaymentHistoriesCompanion Function({
      Value<int> id,
      Value<int> invoiceId,
      Value<int> customerId,
      Value<double> amount,
      Value<String> paymentMethod,
      Value<String?> notes,
      Value<DateTime> paidAt,
    });

class $$PaymentHistoriesTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentHistoriesTable> {
  $$PaymentHistoriesTableFilterComposer({
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

  ColumnFilters<int> get invoiceId => $composableBuilder(
    column: $table.invoiceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get paidAt => $composableBuilder(
    column: $table.paidAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PaymentHistoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentHistoriesTable> {
  $$PaymentHistoriesTableOrderingComposer({
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

  ColumnOrderings<int> get invoiceId => $composableBuilder(
    column: $table.invoiceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get paidAt => $composableBuilder(
    column: $table.paidAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PaymentHistoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentHistoriesTable> {
  $$PaymentHistoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get invoiceId =>
      $composableBuilder(column: $table.invoiceId, builder: (column) => column);

  GeneratedColumn<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get paidAt =>
      $composableBuilder(column: $table.paidAt, builder: (column) => column);
}

class $$PaymentHistoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaymentHistoriesTable,
          PaymentHistory,
          $$PaymentHistoriesTableFilterComposer,
          $$PaymentHistoriesTableOrderingComposer,
          $$PaymentHistoriesTableAnnotationComposer,
          $$PaymentHistoriesTableCreateCompanionBuilder,
          $$PaymentHistoriesTableUpdateCompanionBuilder,
          (
            PaymentHistory,
            BaseReferences<
              _$AppDatabase,
              $PaymentHistoriesTable,
              PaymentHistory
            >,
          ),
          PaymentHistory,
          PrefetchHooks Function()
        > {
  $$PaymentHistoriesTableTableManager(
    _$AppDatabase db,
    $PaymentHistoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentHistoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentHistoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentHistoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> invoiceId = const Value.absent(),
                Value<int> customerId = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> paidAt = const Value.absent(),
              }) => PaymentHistoriesCompanion(
                id: id,
                invoiceId: invoiceId,
                customerId: customerId,
                amount: amount,
                paymentMethod: paymentMethod,
                notes: notes,
                paidAt: paidAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int invoiceId,
                required int customerId,
                required double amount,
                Value<String> paymentMethod = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> paidAt = const Value.absent(),
              }) => PaymentHistoriesCompanion.insert(
                id: id,
                invoiceId: invoiceId,
                customerId: customerId,
                amount: amount,
                paymentMethod: paymentMethod,
                notes: notes,
                paidAt: paidAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PaymentHistoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaymentHistoriesTable,
      PaymentHistory,
      $$PaymentHistoriesTableFilterComposer,
      $$PaymentHistoriesTableOrderingComposer,
      $$PaymentHistoriesTableAnnotationComposer,
      $$PaymentHistoriesTableCreateCompanionBuilder,
      $$PaymentHistoriesTableUpdateCompanionBuilder,
      (
        PaymentHistory,
        BaseReferences<_$AppDatabase, $PaymentHistoriesTable, PaymentHistory>,
      ),
      PaymentHistory,
      PrefetchHooks Function()
    >;
typedef $$ProductVariantsTableCreateCompanionBuilder =
    ProductVariantsCompanion Function({
      Value<int> id,
      required int productId,
      required String variantName,
      Value<String?> thickness,
      Value<String?> color,
      Value<String?> size,
      required double purchasePrice,
      required double sellingPrice,
      required double stockQty,
      Value<bool> isActive,
      Value<DateTime> createdAt,
    });
typedef $$ProductVariantsTableUpdateCompanionBuilder =
    ProductVariantsCompanion Function({
      Value<int> id,
      Value<int> productId,
      Value<String> variantName,
      Value<String?> thickness,
      Value<String?> color,
      Value<String?> size,
      Value<double> purchasePrice,
      Value<double> sellingPrice,
      Value<double> stockQty,
      Value<bool> isActive,
      Value<DateTime> createdAt,
    });

final class $$ProductVariantsTableReferences
    extends
        BaseReferences<_$AppDatabase, $ProductVariantsTable, ProductVariant> {
  $$ProductVariantsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias(
        $_aliasNameGenerator(db.productVariants.productId, db.products.id),
      );

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProductVariantsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductVariantsTable> {
  $$ProductVariantsTableFilterComposer({
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

  ColumnFilters<String> get variantName => $composableBuilder(
    column: $table.variantName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get thickness => $composableBuilder(
    column: $table.thickness,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sellingPrice => $composableBuilder(
    column: $table.sellingPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get stockQty => $composableBuilder(
    column: $table.stockQty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductVariantsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductVariantsTable> {
  $$ProductVariantsTableOrderingComposer({
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

  ColumnOrderings<String> get variantName => $composableBuilder(
    column: $table.variantName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get thickness => $composableBuilder(
    column: $table.thickness,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sellingPrice => $composableBuilder(
    column: $table.sellingPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get stockQty => $composableBuilder(
    column: $table.stockQty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductVariantsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductVariantsTable> {
  $$ProductVariantsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get variantName => $composableBuilder(
    column: $table.variantName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get thickness =>
      $composableBuilder(column: $table.thickness, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get size =>
      $composableBuilder(column: $table.size, builder: (column) => column);

  GeneratedColumn<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get sellingPrice => $composableBuilder(
    column: $table.sellingPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get stockQty =>
      $composableBuilder(column: $table.stockQty, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductVariantsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductVariantsTable,
          ProductVariant,
          $$ProductVariantsTableFilterComposer,
          $$ProductVariantsTableOrderingComposer,
          $$ProductVariantsTableAnnotationComposer,
          $$ProductVariantsTableCreateCompanionBuilder,
          $$ProductVariantsTableUpdateCompanionBuilder,
          (ProductVariant, $$ProductVariantsTableReferences),
          ProductVariant,
          PrefetchHooks Function({bool productId})
        > {
  $$ProductVariantsTableTableManager(
    _$AppDatabase db,
    $ProductVariantsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductVariantsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductVariantsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductVariantsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<String> variantName = const Value.absent(),
                Value<String?> thickness = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<String?> size = const Value.absent(),
                Value<double> purchasePrice = const Value.absent(),
                Value<double> sellingPrice = const Value.absent(),
                Value<double> stockQty = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ProductVariantsCompanion(
                id: id,
                productId: productId,
                variantName: variantName,
                thickness: thickness,
                color: color,
                size: size,
                purchasePrice: purchasePrice,
                sellingPrice: sellingPrice,
                stockQty: stockQty,
                isActive: isActive,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int productId,
                required String variantName,
                Value<String?> thickness = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<String?> size = const Value.absent(),
                required double purchasePrice,
                required double sellingPrice,
                required double stockQty,
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ProductVariantsCompanion.insert(
                id: id,
                productId: productId,
                variantName: variantName,
                thickness: thickness,
                color: color,
                size: size,
                purchasePrice: purchasePrice,
                sellingPrice: sellingPrice,
                stockQty: stockQty,
                isActive: isActive,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProductVariantsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productId = false}) {
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
                    if (productId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productId,
                                referencedTable:
                                    $$ProductVariantsTableReferences
                                        ._productIdTable(db),
                                referencedColumn:
                                    $$ProductVariantsTableReferences
                                        ._productIdTable(db)
                                        .id,
                              )
                              as T;
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

typedef $$ProductVariantsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductVariantsTable,
      ProductVariant,
      $$ProductVariantsTableFilterComposer,
      $$ProductVariantsTableOrderingComposer,
      $$ProductVariantsTableAnnotationComposer,
      $$ProductVariantsTableCreateCompanionBuilder,
      $$ProductVariantsTableUpdateCompanionBuilder,
      (ProductVariant, $$ProductVariantsTableReferences),
      ProductVariant,
      PrefetchHooks Function({bool productId})
    >;
typedef $$SupplierPaymentHistoriesTableCreateCompanionBuilder =
    SupplierPaymentHistoriesCompanion Function({
      Value<int> id,
      required int supplierId,
      Value<int?> purchaseId,
      required double amount,
      Value<String> paymentMethod,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });
typedef $$SupplierPaymentHistoriesTableUpdateCompanionBuilder =
    SupplierPaymentHistoriesCompanion Function({
      Value<int> id,
      Value<int> supplierId,
      Value<int?> purchaseId,
      Value<double> amount,
      Value<String> paymentMethod,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });

class $$SupplierPaymentHistoriesTableFilterComposer
    extends Composer<_$AppDatabase, $SupplierPaymentHistoriesTable> {
  $$SupplierPaymentHistoriesTableFilterComposer({
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

  ColumnFilters<int> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get purchaseId => $composableBuilder(
    column: $table.purchaseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SupplierPaymentHistoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $SupplierPaymentHistoriesTable> {
  $$SupplierPaymentHistoriesTableOrderingComposer({
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

  ColumnOrderings<int> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get purchaseId => $composableBuilder(
    column: $table.purchaseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SupplierPaymentHistoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SupplierPaymentHistoriesTable> {
  $$SupplierPaymentHistoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get purchaseId => $composableBuilder(
    column: $table.purchaseId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SupplierPaymentHistoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SupplierPaymentHistoriesTable,
          SupplierPaymentHistory,
          $$SupplierPaymentHistoriesTableFilterComposer,
          $$SupplierPaymentHistoriesTableOrderingComposer,
          $$SupplierPaymentHistoriesTableAnnotationComposer,
          $$SupplierPaymentHistoriesTableCreateCompanionBuilder,
          $$SupplierPaymentHistoriesTableUpdateCompanionBuilder,
          (
            SupplierPaymentHistory,
            BaseReferences<
              _$AppDatabase,
              $SupplierPaymentHistoriesTable,
              SupplierPaymentHistory
            >,
          ),
          SupplierPaymentHistory,
          PrefetchHooks Function()
        > {
  $$SupplierPaymentHistoriesTableTableManager(
    _$AppDatabase db,
    $SupplierPaymentHistoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SupplierPaymentHistoriesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$SupplierPaymentHistoriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SupplierPaymentHistoriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> supplierId = const Value.absent(),
                Value<int?> purchaseId = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SupplierPaymentHistoriesCompanion(
                id: id,
                supplierId: supplierId,
                purchaseId: purchaseId,
                amount: amount,
                paymentMethod: paymentMethod,
                notes: notes,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int supplierId,
                Value<int?> purchaseId = const Value.absent(),
                required double amount,
                Value<String> paymentMethod = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SupplierPaymentHistoriesCompanion.insert(
                id: id,
                supplierId: supplierId,
                purchaseId: purchaseId,
                amount: amount,
                paymentMethod: paymentMethod,
                notes: notes,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SupplierPaymentHistoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SupplierPaymentHistoriesTable,
      SupplierPaymentHistory,
      $$SupplierPaymentHistoriesTableFilterComposer,
      $$SupplierPaymentHistoriesTableOrderingComposer,
      $$SupplierPaymentHistoriesTableAnnotationComposer,
      $$SupplierPaymentHistoriesTableCreateCompanionBuilder,
      $$SupplierPaymentHistoriesTableUpdateCompanionBuilder,
      (
        SupplierPaymentHistory,
        BaseReferences<
          _$AppDatabase,
          $SupplierPaymentHistoriesTable,
          SupplierPaymentHistory
        >,
      ),
      SupplierPaymentHistory,
      PrefetchHooks Function()
    >;
typedef $$PurchaseReturnsTableCreateCompanionBuilder =
    PurchaseReturnsCompanion Function({
      Value<int> id,
      required int purchaseId,
      required int supplierId,
      required int productId,
      Value<int?> variantId,
      required String reason,
      required int quantity,
      required double amount,
      Value<String> refundStatus,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });
typedef $$PurchaseReturnsTableUpdateCompanionBuilder =
    PurchaseReturnsCompanion Function({
      Value<int> id,
      Value<int> purchaseId,
      Value<int> supplierId,
      Value<int> productId,
      Value<int?> variantId,
      Value<String> reason,
      Value<int> quantity,
      Value<double> amount,
      Value<String> refundStatus,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });

class $$PurchaseReturnsTableFilterComposer
    extends Composer<_$AppDatabase, $PurchaseReturnsTable> {
  $$PurchaseReturnsTableFilterComposer({
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

  ColumnFilters<int> get purchaseId => $composableBuilder(
    column: $table.purchaseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get variantId => $composableBuilder(
    column: $table.variantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get refundStatus => $composableBuilder(
    column: $table.refundStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PurchaseReturnsTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchaseReturnsTable> {
  $$PurchaseReturnsTableOrderingComposer({
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

  ColumnOrderings<int> get purchaseId => $composableBuilder(
    column: $table.purchaseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get variantId => $composableBuilder(
    column: $table.variantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get refundStatus => $composableBuilder(
    column: $table.refundStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PurchaseReturnsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchaseReturnsTable> {
  $$PurchaseReturnsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get purchaseId => $composableBuilder(
    column: $table.purchaseId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<int> get variantId =>
      $composableBuilder(column: $table.variantId, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get refundStatus => $composableBuilder(
    column: $table.refundStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PurchaseReturnsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchaseReturnsTable,
          PurchaseReturn,
          $$PurchaseReturnsTableFilterComposer,
          $$PurchaseReturnsTableOrderingComposer,
          $$PurchaseReturnsTableAnnotationComposer,
          $$PurchaseReturnsTableCreateCompanionBuilder,
          $$PurchaseReturnsTableUpdateCompanionBuilder,
          (
            PurchaseReturn,
            BaseReferences<
              _$AppDatabase,
              $PurchaseReturnsTable,
              PurchaseReturn
            >,
          ),
          PurchaseReturn,
          PrefetchHooks Function()
        > {
  $$PurchaseReturnsTableTableManager(
    _$AppDatabase db,
    $PurchaseReturnsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchaseReturnsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchaseReturnsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchaseReturnsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> purchaseId = const Value.absent(),
                Value<int> supplierId = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int?> variantId = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> refundStatus = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PurchaseReturnsCompanion(
                id: id,
                purchaseId: purchaseId,
                supplierId: supplierId,
                productId: productId,
                variantId: variantId,
                reason: reason,
                quantity: quantity,
                amount: amount,
                refundStatus: refundStatus,
                notes: notes,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int purchaseId,
                required int supplierId,
                required int productId,
                Value<int?> variantId = const Value.absent(),
                required String reason,
                required int quantity,
                required double amount,
                Value<String> refundStatus = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PurchaseReturnsCompanion.insert(
                id: id,
                purchaseId: purchaseId,
                supplierId: supplierId,
                productId: productId,
                variantId: variantId,
                reason: reason,
                quantity: quantity,
                amount: amount,
                refundStatus: refundStatus,
                notes: notes,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PurchaseReturnsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchaseReturnsTable,
      PurchaseReturn,
      $$PurchaseReturnsTableFilterComposer,
      $$PurchaseReturnsTableOrderingComposer,
      $$PurchaseReturnsTableAnnotationComposer,
      $$PurchaseReturnsTableCreateCompanionBuilder,
      $$PurchaseReturnsTableUpdateCompanionBuilder,
      (
        PurchaseReturn,
        BaseReferences<_$AppDatabase, $PurchaseReturnsTable, PurchaseReturn>,
      ),
      PurchaseReturn,
      PrefetchHooks Function()
    >;
typedef $$SalesReturnsTableCreateCompanionBuilder =
    SalesReturnsCompanion Function({
      Value<int> id,
      required int invoiceId,
      required int customerId,
      required int productId,
      Value<int?> variantId,
      required int quantity,
      required double amount,
      required String reason,
      Value<String> refundStatus,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });
typedef $$SalesReturnsTableUpdateCompanionBuilder =
    SalesReturnsCompanion Function({
      Value<int> id,
      Value<int> invoiceId,
      Value<int> customerId,
      Value<int> productId,
      Value<int?> variantId,
      Value<int> quantity,
      Value<double> amount,
      Value<String> reason,
      Value<String> refundStatus,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });

class $$SalesReturnsTableFilterComposer
    extends Composer<_$AppDatabase, $SalesReturnsTable> {
  $$SalesReturnsTableFilterComposer({
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

  ColumnFilters<int> get invoiceId => $composableBuilder(
    column: $table.invoiceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get variantId => $composableBuilder(
    column: $table.variantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get refundStatus => $composableBuilder(
    column: $table.refundStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SalesReturnsTableOrderingComposer
    extends Composer<_$AppDatabase, $SalesReturnsTable> {
  $$SalesReturnsTableOrderingComposer({
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

  ColumnOrderings<int> get invoiceId => $composableBuilder(
    column: $table.invoiceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get variantId => $composableBuilder(
    column: $table.variantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get refundStatus => $composableBuilder(
    column: $table.refundStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SalesReturnsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SalesReturnsTable> {
  $$SalesReturnsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get invoiceId =>
      $composableBuilder(column: $table.invoiceId, builder: (column) => column);

  GeneratedColumn<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<int> get variantId =>
      $composableBuilder(column: $table.variantId, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get refundStatus => $composableBuilder(
    column: $table.refundStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SalesReturnsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SalesReturnsTable,
          SalesReturn,
          $$SalesReturnsTableFilterComposer,
          $$SalesReturnsTableOrderingComposer,
          $$SalesReturnsTableAnnotationComposer,
          $$SalesReturnsTableCreateCompanionBuilder,
          $$SalesReturnsTableUpdateCompanionBuilder,
          (
            SalesReturn,
            BaseReferences<_$AppDatabase, $SalesReturnsTable, SalesReturn>,
          ),
          SalesReturn,
          PrefetchHooks Function()
        > {
  $$SalesReturnsTableTableManager(_$AppDatabase db, $SalesReturnsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SalesReturnsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SalesReturnsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SalesReturnsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> invoiceId = const Value.absent(),
                Value<int> customerId = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int?> variantId = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<String> refundStatus = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SalesReturnsCompanion(
                id: id,
                invoiceId: invoiceId,
                customerId: customerId,
                productId: productId,
                variantId: variantId,
                quantity: quantity,
                amount: amount,
                reason: reason,
                refundStatus: refundStatus,
                notes: notes,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int invoiceId,
                required int customerId,
                required int productId,
                Value<int?> variantId = const Value.absent(),
                required int quantity,
                required double amount,
                required String reason,
                Value<String> refundStatus = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SalesReturnsCompanion.insert(
                id: id,
                invoiceId: invoiceId,
                customerId: customerId,
                productId: productId,
                variantId: variantId,
                quantity: quantity,
                amount: amount,
                reason: reason,
                refundStatus: refundStatus,
                notes: notes,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SalesReturnsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SalesReturnsTable,
      SalesReturn,
      $$SalesReturnsTableFilterComposer,
      $$SalesReturnsTableOrderingComposer,
      $$SalesReturnsTableAnnotationComposer,
      $$SalesReturnsTableCreateCompanionBuilder,
      $$SalesReturnsTableUpdateCompanionBuilder,
      (
        SalesReturn,
        BaseReferences<_$AppDatabase, $SalesReturnsTable, SalesReturn>,
      ),
      SalesReturn,
      PrefetchHooks Function()
    >;
typedef $$BusinessSettingsTableCreateCompanionBuilder =
    BusinessSettingsCompanion Function({
      Value<int> id,
      required String companyName,
      Value<String?> ownerName,
      Value<String?> phone,
      Value<String?> email,
      Value<String?> address,
      Value<String?> gstNo,
      Value<String?> logoPath,
      Value<String?> bankName,
      Value<String?> accountNumber,
      Value<String?> ifscCode,
      Value<String?> upiId,
      Value<String?> footerMessage,
    });
typedef $$BusinessSettingsTableUpdateCompanionBuilder =
    BusinessSettingsCompanion Function({
      Value<int> id,
      Value<String> companyName,
      Value<String?> ownerName,
      Value<String?> phone,
      Value<String?> email,
      Value<String?> address,
      Value<String?> gstNo,
      Value<String?> logoPath,
      Value<String?> bankName,
      Value<String?> accountNumber,
      Value<String?> ifscCode,
      Value<String?> upiId,
      Value<String?> footerMessage,
    });

class $$BusinessSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $BusinessSettingsTable> {
  $$BusinessSettingsTableFilterComposer({
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

  ColumnFilters<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerName => $composableBuilder(
    column: $table.ownerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gstNo => $composableBuilder(
    column: $table.gstNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get logoPath => $composableBuilder(
    column: $table.logoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bankName => $composableBuilder(
    column: $table.bankName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountNumber => $composableBuilder(
    column: $table.accountNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ifscCode => $composableBuilder(
    column: $table.ifscCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get upiId => $composableBuilder(
    column: $table.upiId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get footerMessage => $composableBuilder(
    column: $table.footerMessage,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BusinessSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $BusinessSettingsTable> {
  $$BusinessSettingsTableOrderingComposer({
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

  ColumnOrderings<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerName => $composableBuilder(
    column: $table.ownerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gstNo => $composableBuilder(
    column: $table.gstNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logoPath => $composableBuilder(
    column: $table.logoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bankName => $composableBuilder(
    column: $table.bankName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountNumber => $composableBuilder(
    column: $table.accountNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ifscCode => $composableBuilder(
    column: $table.ifscCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get upiId => $composableBuilder(
    column: $table.upiId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get footerMessage => $composableBuilder(
    column: $table.footerMessage,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BusinessSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BusinessSettingsTable> {
  $$BusinessSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ownerName =>
      $composableBuilder(column: $table.ownerName, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get gstNo =>
      $composableBuilder(column: $table.gstNo, builder: (column) => column);

  GeneratedColumn<String> get logoPath =>
      $composableBuilder(column: $table.logoPath, builder: (column) => column);

  GeneratedColumn<String> get bankName =>
      $composableBuilder(column: $table.bankName, builder: (column) => column);

  GeneratedColumn<String> get accountNumber => $composableBuilder(
    column: $table.accountNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ifscCode =>
      $composableBuilder(column: $table.ifscCode, builder: (column) => column);

  GeneratedColumn<String> get upiId =>
      $composableBuilder(column: $table.upiId, builder: (column) => column);

  GeneratedColumn<String> get footerMessage => $composableBuilder(
    column: $table.footerMessage,
    builder: (column) => column,
  );
}

class $$BusinessSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BusinessSettingsTable,
          BusinessSetting,
          $$BusinessSettingsTableFilterComposer,
          $$BusinessSettingsTableOrderingComposer,
          $$BusinessSettingsTableAnnotationComposer,
          $$BusinessSettingsTableCreateCompanionBuilder,
          $$BusinessSettingsTableUpdateCompanionBuilder,
          (
            BusinessSetting,
            BaseReferences<
              _$AppDatabase,
              $BusinessSettingsTable,
              BusinessSetting
            >,
          ),
          BusinessSetting,
          PrefetchHooks Function()
        > {
  $$BusinessSettingsTableTableManager(
    _$AppDatabase db,
    $BusinessSettingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BusinessSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BusinessSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BusinessSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> companyName = const Value.absent(),
                Value<String?> ownerName = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> gstNo = const Value.absent(),
                Value<String?> logoPath = const Value.absent(),
                Value<String?> bankName = const Value.absent(),
                Value<String?> accountNumber = const Value.absent(),
                Value<String?> ifscCode = const Value.absent(),
                Value<String?> upiId = const Value.absent(),
                Value<String?> footerMessage = const Value.absent(),
              }) => BusinessSettingsCompanion(
                id: id,
                companyName: companyName,
                ownerName: ownerName,
                phone: phone,
                email: email,
                address: address,
                gstNo: gstNo,
                logoPath: logoPath,
                bankName: bankName,
                accountNumber: accountNumber,
                ifscCode: ifscCode,
                upiId: upiId,
                footerMessage: footerMessage,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String companyName,
                Value<String?> ownerName = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> gstNo = const Value.absent(),
                Value<String?> logoPath = const Value.absent(),
                Value<String?> bankName = const Value.absent(),
                Value<String?> accountNumber = const Value.absent(),
                Value<String?> ifscCode = const Value.absent(),
                Value<String?> upiId = const Value.absent(),
                Value<String?> footerMessage = const Value.absent(),
              }) => BusinessSettingsCompanion.insert(
                id: id,
                companyName: companyName,
                ownerName: ownerName,
                phone: phone,
                email: email,
                address: address,
                gstNo: gstNo,
                logoPath: logoPath,
                bankName: bankName,
                accountNumber: accountNumber,
                ifscCode: ifscCode,
                upiId: upiId,
                footerMessage: footerMessage,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BusinessSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BusinessSettingsTable,
      BusinessSetting,
      $$BusinessSettingsTableFilterComposer,
      $$BusinessSettingsTableOrderingComposer,
      $$BusinessSettingsTableAnnotationComposer,
      $$BusinessSettingsTableCreateCompanionBuilder,
      $$BusinessSettingsTableUpdateCompanionBuilder,
      (
        BusinessSetting,
        BaseReferences<_$AppDatabase, $BusinessSettingsTable, BusinessSetting>,
      ),
      BusinessSetting,
      PrefetchHooks Function()
    >;
typedef $$ProductPriceHistoriesTableCreateCompanionBuilder =
    ProductPriceHistoriesCompanion Function({
      Value<int> id,
      required int productId,
      Value<int?> supplierId,
      required double oldPurchasePrice,
      required double newPurchasePrice,
      required double oldSellingPrice,
      required double newSellingPrice,
      Value<double> inflationPercentage,
      Value<DateTime> changedAt,
      Value<String?> remarks,
    });
typedef $$ProductPriceHistoriesTableUpdateCompanionBuilder =
    ProductPriceHistoriesCompanion Function({
      Value<int> id,
      Value<int> productId,
      Value<int?> supplierId,
      Value<double> oldPurchasePrice,
      Value<double> newPurchasePrice,
      Value<double> oldSellingPrice,
      Value<double> newSellingPrice,
      Value<double> inflationPercentage,
      Value<DateTime> changedAt,
      Value<String?> remarks,
    });

class $$ProductPriceHistoriesTableFilterComposer
    extends Composer<_$AppDatabase, $ProductPriceHistoriesTable> {
  $$ProductPriceHistoriesTableFilterComposer({
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

  ColumnFilters<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get oldPurchasePrice => $composableBuilder(
    column: $table.oldPurchasePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get newPurchasePrice => $composableBuilder(
    column: $table.newPurchasePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get oldSellingPrice => $composableBuilder(
    column: $table.oldSellingPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get newSellingPrice => $composableBuilder(
    column: $table.newSellingPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get inflationPercentage => $composableBuilder(
    column: $table.inflationPercentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get changedAt => $composableBuilder(
    column: $table.changedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remarks => $composableBuilder(
    column: $table.remarks,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductPriceHistoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductPriceHistoriesTable> {
  $$ProductPriceHistoriesTableOrderingComposer({
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

  ColumnOrderings<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get oldPurchasePrice => $composableBuilder(
    column: $table.oldPurchasePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get newPurchasePrice => $composableBuilder(
    column: $table.newPurchasePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get oldSellingPrice => $composableBuilder(
    column: $table.oldSellingPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get newSellingPrice => $composableBuilder(
    column: $table.newSellingPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get inflationPercentage => $composableBuilder(
    column: $table.inflationPercentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get changedAt => $composableBuilder(
    column: $table.changedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remarks => $composableBuilder(
    column: $table.remarks,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductPriceHistoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductPriceHistoriesTable> {
  $$ProductPriceHistoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<int> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get oldPurchasePrice => $composableBuilder(
    column: $table.oldPurchasePrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get newPurchasePrice => $composableBuilder(
    column: $table.newPurchasePrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get oldSellingPrice => $composableBuilder(
    column: $table.oldSellingPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get newSellingPrice => $composableBuilder(
    column: $table.newSellingPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get inflationPercentage => $composableBuilder(
    column: $table.inflationPercentage,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get changedAt =>
      $composableBuilder(column: $table.changedAt, builder: (column) => column);

  GeneratedColumn<String> get remarks =>
      $composableBuilder(column: $table.remarks, builder: (column) => column);
}

class $$ProductPriceHistoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductPriceHistoriesTable,
          ProductPriceHistory,
          $$ProductPriceHistoriesTableFilterComposer,
          $$ProductPriceHistoriesTableOrderingComposer,
          $$ProductPriceHistoriesTableAnnotationComposer,
          $$ProductPriceHistoriesTableCreateCompanionBuilder,
          $$ProductPriceHistoriesTableUpdateCompanionBuilder,
          (
            ProductPriceHistory,
            BaseReferences<
              _$AppDatabase,
              $ProductPriceHistoriesTable,
              ProductPriceHistory
            >,
          ),
          ProductPriceHistory,
          PrefetchHooks Function()
        > {
  $$ProductPriceHistoriesTableTableManager(
    _$AppDatabase db,
    $ProductPriceHistoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductPriceHistoriesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ProductPriceHistoriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ProductPriceHistoriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int?> supplierId = const Value.absent(),
                Value<double> oldPurchasePrice = const Value.absent(),
                Value<double> newPurchasePrice = const Value.absent(),
                Value<double> oldSellingPrice = const Value.absent(),
                Value<double> newSellingPrice = const Value.absent(),
                Value<double> inflationPercentage = const Value.absent(),
                Value<DateTime> changedAt = const Value.absent(),
                Value<String?> remarks = const Value.absent(),
              }) => ProductPriceHistoriesCompanion(
                id: id,
                productId: productId,
                supplierId: supplierId,
                oldPurchasePrice: oldPurchasePrice,
                newPurchasePrice: newPurchasePrice,
                oldSellingPrice: oldSellingPrice,
                newSellingPrice: newSellingPrice,
                inflationPercentage: inflationPercentage,
                changedAt: changedAt,
                remarks: remarks,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int productId,
                Value<int?> supplierId = const Value.absent(),
                required double oldPurchasePrice,
                required double newPurchasePrice,
                required double oldSellingPrice,
                required double newSellingPrice,
                Value<double> inflationPercentage = const Value.absent(),
                Value<DateTime> changedAt = const Value.absent(),
                Value<String?> remarks = const Value.absent(),
              }) => ProductPriceHistoriesCompanion.insert(
                id: id,
                productId: productId,
                supplierId: supplierId,
                oldPurchasePrice: oldPurchasePrice,
                newPurchasePrice: newPurchasePrice,
                oldSellingPrice: oldSellingPrice,
                newSellingPrice: newSellingPrice,
                inflationPercentage: inflationPercentage,
                changedAt: changedAt,
                remarks: remarks,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductPriceHistoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductPriceHistoriesTable,
      ProductPriceHistory,
      $$ProductPriceHistoriesTableFilterComposer,
      $$ProductPriceHistoriesTableOrderingComposer,
      $$ProductPriceHistoriesTableAnnotationComposer,
      $$ProductPriceHistoriesTableCreateCompanionBuilder,
      $$ProductPriceHistoriesTableUpdateCompanionBuilder,
      (
        ProductPriceHistory,
        BaseReferences<
          _$AppDatabase,
          $ProductPriceHistoriesTable,
          ProductPriceHistory
        >,
      ),
      ProductPriceHistory,
      PrefetchHooks Function()
    >;
typedef $$CustomerNotesTableCreateCompanionBuilder =
    CustomerNotesCompanion Function({
      Value<int> id,
      required int customerId,
      required String note,
      Value<DateTime> createdAt,
    });
typedef $$CustomerNotesTableUpdateCompanionBuilder =
    CustomerNotesCompanion Function({
      Value<int> id,
      Value<int> customerId,
      Value<String> note,
      Value<DateTime> createdAt,
    });

class $$CustomerNotesTableFilterComposer
    extends Composer<_$AppDatabase, $CustomerNotesTable> {
  $$CustomerNotesTableFilterComposer({
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

  ColumnFilters<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CustomerNotesTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomerNotesTable> {
  $$CustomerNotesTableOrderingComposer({
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

  ColumnOrderings<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomerNotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomerNotesTable> {
  $$CustomerNotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CustomerNotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomerNotesTable,
          CustomerNote,
          $$CustomerNotesTableFilterComposer,
          $$CustomerNotesTableOrderingComposer,
          $$CustomerNotesTableAnnotationComposer,
          $$CustomerNotesTableCreateCompanionBuilder,
          $$CustomerNotesTableUpdateCompanionBuilder,
          (
            CustomerNote,
            BaseReferences<_$AppDatabase, $CustomerNotesTable, CustomerNote>,
          ),
          CustomerNote,
          PrefetchHooks Function()
        > {
  $$CustomerNotesTableTableManager(_$AppDatabase db, $CustomerNotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomerNotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomerNotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomerNotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> customerId = const Value.absent(),
                Value<String> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CustomerNotesCompanion(
                id: id,
                customerId: customerId,
                note: note,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int customerId,
                required String note,
                Value<DateTime> createdAt = const Value.absent(),
              }) => CustomerNotesCompanion.insert(
                id: id,
                customerId: customerId,
                note: note,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CustomerNotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomerNotesTable,
      CustomerNote,
      $$CustomerNotesTableFilterComposer,
      $$CustomerNotesTableOrderingComposer,
      $$CustomerNotesTableAnnotationComposer,
      $$CustomerNotesTableCreateCompanionBuilder,
      $$CustomerNotesTableUpdateCompanionBuilder,
      (
        CustomerNote,
        BaseReferences<_$AppDatabase, $CustomerNotesTable, CustomerNote>,
      ),
      CustomerNote,
      PrefetchHooks Function()
    >;
typedef $$CustomerDocumentsTableCreateCompanionBuilder =
    CustomerDocumentsCompanion Function({
      Value<int> id,
      required int customerId,
      required String name,
      required String filePath,
      Value<DateTime> createdAt,
    });
typedef $$CustomerDocumentsTableUpdateCompanionBuilder =
    CustomerDocumentsCompanion Function({
      Value<int> id,
      Value<int> customerId,
      Value<String> name,
      Value<String> filePath,
      Value<DateTime> createdAt,
    });

class $$CustomerDocumentsTableFilterComposer
    extends Composer<_$AppDatabase, $CustomerDocumentsTable> {
  $$CustomerDocumentsTableFilterComposer({
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

  ColumnFilters<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CustomerDocumentsTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomerDocumentsTable> {
  $$CustomerDocumentsTableOrderingComposer({
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

  ColumnOrderings<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomerDocumentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomerDocumentsTable> {
  $$CustomerDocumentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CustomerDocumentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomerDocumentsTable,
          CustomerDocument,
          $$CustomerDocumentsTableFilterComposer,
          $$CustomerDocumentsTableOrderingComposer,
          $$CustomerDocumentsTableAnnotationComposer,
          $$CustomerDocumentsTableCreateCompanionBuilder,
          $$CustomerDocumentsTableUpdateCompanionBuilder,
          (
            CustomerDocument,
            BaseReferences<
              _$AppDatabase,
              $CustomerDocumentsTable,
              CustomerDocument
            >,
          ),
          CustomerDocument,
          PrefetchHooks Function()
        > {
  $$CustomerDocumentsTableTableManager(
    _$AppDatabase db,
    $CustomerDocumentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomerDocumentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomerDocumentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomerDocumentsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> customerId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CustomerDocumentsCompanion(
                id: id,
                customerId: customerId,
                name: name,
                filePath: filePath,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int customerId,
                required String name,
                required String filePath,
                Value<DateTime> createdAt = const Value.absent(),
              }) => CustomerDocumentsCompanion.insert(
                id: id,
                customerId: customerId,
                name: name,
                filePath: filePath,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CustomerDocumentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomerDocumentsTable,
      CustomerDocument,
      $$CustomerDocumentsTableFilterComposer,
      $$CustomerDocumentsTableOrderingComposer,
      $$CustomerDocumentsTableAnnotationComposer,
      $$CustomerDocumentsTableCreateCompanionBuilder,
      $$CustomerDocumentsTableUpdateCompanionBuilder,
      (
        CustomerDocument,
        BaseReferences<
          _$AppDatabase,
          $CustomerDocumentsTable,
          CustomerDocument
        >,
      ),
      CustomerDocument,
      PrefetchHooks Function()
    >;
typedef $$CustomerFollowUpsTableCreateCompanionBuilder =
    CustomerFollowUpsCompanion Function({
      Value<int> id,
      required int customerId,
      required String title,
      Value<String?> description,
      required DateTime followUpDate,
      Value<bool> completed,
      Value<DateTime> createdAt,
    });
typedef $$CustomerFollowUpsTableUpdateCompanionBuilder =
    CustomerFollowUpsCompanion Function({
      Value<int> id,
      Value<int> customerId,
      Value<String> title,
      Value<String?> description,
      Value<DateTime> followUpDate,
      Value<bool> completed,
      Value<DateTime> createdAt,
    });

class $$CustomerFollowUpsTableFilterComposer
    extends Composer<_$AppDatabase, $CustomerFollowUpsTable> {
  $$CustomerFollowUpsTableFilterComposer({
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

  ColumnFilters<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get followUpDate => $composableBuilder(
    column: $table.followUpDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CustomerFollowUpsTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomerFollowUpsTable> {
  $$CustomerFollowUpsTableOrderingComposer({
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

  ColumnOrderings<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get followUpDate => $composableBuilder(
    column: $table.followUpDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomerFollowUpsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomerFollowUpsTable> {
  $$CustomerFollowUpsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get followUpDate => $composableBuilder(
    column: $table.followUpDate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CustomerFollowUpsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomerFollowUpsTable,
          CustomerFollowUp,
          $$CustomerFollowUpsTableFilterComposer,
          $$CustomerFollowUpsTableOrderingComposer,
          $$CustomerFollowUpsTableAnnotationComposer,
          $$CustomerFollowUpsTableCreateCompanionBuilder,
          $$CustomerFollowUpsTableUpdateCompanionBuilder,
          (
            CustomerFollowUp,
            BaseReferences<
              _$AppDatabase,
              $CustomerFollowUpsTable,
              CustomerFollowUp
            >,
          ),
          CustomerFollowUp,
          PrefetchHooks Function()
        > {
  $$CustomerFollowUpsTableTableManager(
    _$AppDatabase db,
    $CustomerFollowUpsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomerFollowUpsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomerFollowUpsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomerFollowUpsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> customerId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> followUpDate = const Value.absent(),
                Value<bool> completed = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CustomerFollowUpsCompanion(
                id: id,
                customerId: customerId,
                title: title,
                description: description,
                followUpDate: followUpDate,
                completed: completed,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int customerId,
                required String title,
                Value<String?> description = const Value.absent(),
                required DateTime followUpDate,
                Value<bool> completed = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CustomerFollowUpsCompanion.insert(
                id: id,
                customerId: customerId,
                title: title,
                description: description,
                followUpDate: followUpDate,
                completed: completed,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CustomerFollowUpsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomerFollowUpsTable,
      CustomerFollowUp,
      $$CustomerFollowUpsTableFilterComposer,
      $$CustomerFollowUpsTableOrderingComposer,
      $$CustomerFollowUpsTableAnnotationComposer,
      $$CustomerFollowUpsTableCreateCompanionBuilder,
      $$CustomerFollowUpsTableUpdateCompanionBuilder,
      (
        CustomerFollowUp,
        BaseReferences<
          _$AppDatabase,
          $CustomerFollowUpsTable,
          CustomerFollowUp
        >,
      ),
      CustomerFollowUp,
      PrefetchHooks Function()
    >;
typedef $$CustomerLoyaltiesTableCreateCompanionBuilder =
    CustomerLoyaltiesCompanion Function({
      Value<int> id,
      required int customerId,
      Value<int> points,
      Value<String> tier,
      Value<DateTime> updatedAt,
    });
typedef $$CustomerLoyaltiesTableUpdateCompanionBuilder =
    CustomerLoyaltiesCompanion Function({
      Value<int> id,
      Value<int> customerId,
      Value<int> points,
      Value<String> tier,
      Value<DateTime> updatedAt,
    });

class $$CustomerLoyaltiesTableFilterComposer
    extends Composer<_$AppDatabase, $CustomerLoyaltiesTable> {
  $$CustomerLoyaltiesTableFilterComposer({
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

  ColumnFilters<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get points => $composableBuilder(
    column: $table.points,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tier => $composableBuilder(
    column: $table.tier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CustomerLoyaltiesTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomerLoyaltiesTable> {
  $$CustomerLoyaltiesTableOrderingComposer({
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

  ColumnOrderings<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get points => $composableBuilder(
    column: $table.points,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tier => $composableBuilder(
    column: $table.tier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomerLoyaltiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomerLoyaltiesTable> {
  $$CustomerLoyaltiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get points =>
      $composableBuilder(column: $table.points, builder: (column) => column);

  GeneratedColumn<String> get tier =>
      $composableBuilder(column: $table.tier, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CustomerLoyaltiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomerLoyaltiesTable,
          CustomerLoyalty,
          $$CustomerLoyaltiesTableFilterComposer,
          $$CustomerLoyaltiesTableOrderingComposer,
          $$CustomerLoyaltiesTableAnnotationComposer,
          $$CustomerLoyaltiesTableCreateCompanionBuilder,
          $$CustomerLoyaltiesTableUpdateCompanionBuilder,
          (
            CustomerLoyalty,
            BaseReferences<
              _$AppDatabase,
              $CustomerLoyaltiesTable,
              CustomerLoyalty
            >,
          ),
          CustomerLoyalty,
          PrefetchHooks Function()
        > {
  $$CustomerLoyaltiesTableTableManager(
    _$AppDatabase db,
    $CustomerLoyaltiesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomerLoyaltiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomerLoyaltiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomerLoyaltiesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> customerId = const Value.absent(),
                Value<int> points = const Value.absent(),
                Value<String> tier = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CustomerLoyaltiesCompanion(
                id: id,
                customerId: customerId,
                points: points,
                tier: tier,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int customerId,
                Value<int> points = const Value.absent(),
                Value<String> tier = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CustomerLoyaltiesCompanion.insert(
                id: id,
                customerId: customerId,
                points: points,
                tier: tier,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CustomerLoyaltiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomerLoyaltiesTable,
      CustomerLoyalty,
      $$CustomerLoyaltiesTableFilterComposer,
      $$CustomerLoyaltiesTableOrderingComposer,
      $$CustomerLoyaltiesTableAnnotationComposer,
      $$CustomerLoyaltiesTableCreateCompanionBuilder,
      $$CustomerLoyaltiesTableUpdateCompanionBuilder,
      (
        CustomerLoyalty,
        BaseReferences<_$AppDatabase, $CustomerLoyaltiesTable, CustomerLoyalty>,
      ),
      CustomerLoyalty,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
  $$SuppliersTableTableManager get suppliers =>
      $$SuppliersTableTableManager(_db, _db.suppliers);
  $$SalesTableTableManager get sales =>
      $$SalesTableTableManager(_db, _db.sales);
  $$SaleItemsTableTableManager get saleItems =>
      $$SaleItemsTableTableManager(_db, _db.saleItems);
  $$PurchasesTableTableManager get purchases =>
      $$PurchasesTableTableManager(_db, _db.purchases);
  $$PurchaseItemsTableTableManager get purchaseItems =>
      $$PurchaseItemsTableTableManager(_db, _db.purchaseItems);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
  $$InvoicesTableTableManager get invoices =>
      $$InvoicesTableTableManager(_db, _db.invoices);
  $$InvoiceItemsTableTableManager get invoiceItems =>
      $$InvoiceItemsTableTableManager(_db, _db.invoiceItems);
  $$PaymentHistoriesTableTableManager get paymentHistories =>
      $$PaymentHistoriesTableTableManager(_db, _db.paymentHistories);
  $$ProductVariantsTableTableManager get productVariants =>
      $$ProductVariantsTableTableManager(_db, _db.productVariants);
  $$SupplierPaymentHistoriesTableTableManager get supplierPaymentHistories =>
      $$SupplierPaymentHistoriesTableTableManager(
        _db,
        _db.supplierPaymentHistories,
      );
  $$PurchaseReturnsTableTableManager get purchaseReturns =>
      $$PurchaseReturnsTableTableManager(_db, _db.purchaseReturns);
  $$SalesReturnsTableTableManager get salesReturns =>
      $$SalesReturnsTableTableManager(_db, _db.salesReturns);
  $$BusinessSettingsTableTableManager get businessSettings =>
      $$BusinessSettingsTableTableManager(_db, _db.businessSettings);
  $$ProductPriceHistoriesTableTableManager get productPriceHistories =>
      $$ProductPriceHistoriesTableTableManager(_db, _db.productPriceHistories);
  $$CustomerNotesTableTableManager get customerNotes =>
      $$CustomerNotesTableTableManager(_db, _db.customerNotes);
  $$CustomerDocumentsTableTableManager get customerDocuments =>
      $$CustomerDocumentsTableTableManager(_db, _db.customerDocuments);
  $$CustomerFollowUpsTableTableManager get customerFollowUps =>
      $$CustomerFollowUpsTableTableManager(_db, _db.customerFollowUps);
  $$CustomerLoyaltiesTableTableManager get customerLoyalties =>
      $$CustomerLoyaltiesTableTableManager(_db, _db.customerLoyalties);
}
