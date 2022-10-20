import 'package:projeto_pet/ui/database/data_model/pet_data_model.dart';
import 'package:projeto_pet/ui/database/data_model/tipo_pet_data_model.dart';
import 'package:projeto_pet/ui/models/pet.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';


class DBHelper{


  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async => _database ??= await _initDB();


  _initDB () async {
    Directory documentoDiretorio = await getApplicationDocumentsDirectory();
    String caminho = join(documentoDiretorio.path, "db_gastos.db");// home://directory/files/db_gastos.db

    return  await  openDatabase(
        caminho,
        version: 1,
        onCreate: _onCreate);

  }

  void _onCreate(Database db, int version) async{

    await db.execute(PetDataModel.criarTabela());
    await db.execute(TipoPetDataModel.criarTabela());

  }

  /******CRUD PET******/

  Future<List<Pet>>getPets() async {
    Database db = await instance.database;
    var pets = await db.query(PetDataModel.getTabela(), orderBy: PetDataModel.nome);
    List<Pet> petList = pets.isNotEmpty
          ? pets.map((p) => Pet.fromMap(p)).toList()
          : [];
    return petList;
  }

  Future<int> addPet(Pet pet) async {
    Database db = await instance.database;
    return await db.insert(PetDataModel.getTabela(), pet.toMap());
  }

  Future<int> update(Pet pet) async {
    Database db = await instance.database;
    return await db.update(PetDataModel.getTabela(), pet.toMap(),
        where: '${PetDataModel.id} = ?', whereArgs: [pet.id]);
  }

  Future close() async {
    Database db = await instance.database;
    db.close();
  }

/******CRUD TIPO PETS******/


  Future<int> removeSubEspecificacao(int id) async{
    Database db = await instance.database;
    return await db.delete(PetDataModel.TABELA, where: 'id = ?', whereArgs: [id]);
  }



  /*Future<List> getFuncionarioSetor(String cpf) async {
    Database db = await instance.database;
    var res = await db.rawQuery('''SELECT f.${FuncionarioDataModel.id}, f.${FuncionarioDataModel.cpf}, f.${FuncionarioDataModel.email},
                                f.${FuncionarioDataModel.nome}, f.${FuncionarioDataModel.telefone}, f.${FuncionarioDataModel.password},
                                s.${SetorDataModel.descricao_setor}       
                                FROM ${FuncionarioDataModel.getTabela()} f
                                INNER JOIN ${SetorDataModel.getTabela()} s ON s.${SetorDataModel.id} = f.${FuncionarioDataModel.setor_id} 
                             WHERE f.${FuncionarioDataModel.cpf} = '$cpf' ''');
    return res.toList();
  }*/



}





















