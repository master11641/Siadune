import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';
import 'view.list.dart';

part 'model.g.dart';


const tableUser = SqfEntityTable(
    tableName: 'user',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    modelName: null,
    fields: [
      SqfEntityField('firstName', DbType.text),
      SqfEntityField('lastName', DbType.text),
      SqfEntityField('username', DbType.text),
      SqfEntityField('password', DbType.text),
      SqfEntityField('token', DbType.text),      
    ]);
@SqfEntityBuilder(myDbModel)
const myDbModel = SqfEntityModel(
    modelName: 'MyDbModel', // optional
    databaseName: 'siadune.db',
    password: 'Master11641@', // You can set a password if you want to use crypted database 
                   // (For more information: https://github.com/sqlcipher/sqlcipher)

    // put defined tables into the tables list.
    databaseTables: [tableUser],
     // You can define tables to generate add/edit view forms if you want to use Form Generator property
    //formTables: [tableProduct, tableCategory, tableTodo],
    // put defined sequences into the sequences list.
    //sequences: [seqIdentity],
    bundledDatabasePath:
        null // 'assets/sample.db' // This value is optional. When bundledDatabasePath is empty then EntityBase creats a new database when initializing the database
);