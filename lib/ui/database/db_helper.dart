import 'package:projeto_pet/ui/database/data_model/dono_data_model.dart';
import 'package:projeto_pet/ui/database/data_model/pet_data_model.dart';
import 'package:projeto_pet/ui/database/data_model/tipo_pet_data_model.dart';
import 'package:projeto_pet/ui/database/data_model/tipo_vacina_data_model.dart';
import 'package:projeto_pet/ui/models/dono.dart';
import 'package:projeto_pet/ui/models/pet.dart';
import 'package:projeto_pet/ui/models/tipo_pet.dart';
import 'package:projeto_pet/ui/models/tipo_vacina.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'data_model/vacina_data_model.dart';


class DBHelper{


  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async => _database ??= await _initDB();


  _initDB () async {
    Directory documentoDiretorio = await getApplicationDocumentsDirectory();
    String caminho = join(documentoDiretorio.path, "db_pets.db");// home://directory/files/db_gastos.db

    return  await  openDatabase(
        caminho,
        version: 1,
        onCreate: _onCreate);

  }

  void _onCreate(Database db, int version) async{
    await db.execute(PetDataModel.criarTabela());
    await db.execute(TipoPetDataModel.criarTabela());
    await db.execute(DonoDataModel.criarTabela());
    await db.execute(TipoVacinaDataModel.criarTabela());
    await db.execute(VacinaDataModel.criarTabela());

  }


  ///CRUD TIPO VACINA
  Future<List<TipoVacina>>getAllTiposVacinas() async {
    Database db = await instance.database;
    var tiposVacinas = await db.query(TipoVacinaDataModel.getTabela(), orderBy: TipoVacinaDataModel.nomeVacina);
    List<TipoVacina> list = tiposVacinas.isNotEmpty
        ? tiposVacinas.map((p) => TipoVacina.fromMap(p)).toList()
        : [];
    return list;
  }

  Future<int> addTipoVacina(TipoVacina tv) async {
    Database db = await instance.database;
    return await db.insert(TipoVacinaDataModel.getTabela(), tv.toMap());
  }
  Future<int> removeAllTiposVacinas() async{
    Database db = await instance.database;
    return await db.rawDelete(TipoVacinaDataModel.zerarTabela());
  }

  ///CRUD PET
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

  Future<int> updatePet(Pet pet) async {
    Database db = await instance.database;
    return await db.update(PetDataModel.getTabela(), pet.toMap(),
        where: '${PetDataModel.id} = ?', whereArgs: [pet.id]);
  }

  Future<int> removeAllPets() async{
    Database db = await instance.database;
    return await db.rawDelete(PetDataModel.zerarTabela());
  }


/******CRUD TIPO PETS******/

  Future<List>getAllTiposPets() async {
      Database db = await instance.database;
    var res = await db.rawQuery("SELECT ${TipoPetDataModel.getAtributos()} FROM ${TipoPetDataModel.getTabela()} ORDER BY ${TipoPetDataModel.descricao}");
    return res.toList();
  }
  /*Future<int> removeSubEspecificacao(int id) async{
    Database db = await instance.database;
    return await db.delete(PetDataModel.TABELA, where: 'id = ?', whereArgs: [id]);
  }*/
  Future<int> addTipoPet(TipoPet tipoPet) async {
    Database db = await instance.database;
    return await db.insert(TipoPetDataModel.getTabela(), tipoPet.toMap());
  }

  Future<int> removeAllTiposPets() async{
    Database db = await instance.database;
    return await db.rawDelete(TipoPetDataModel.zerarTabela());
  }

  Future<List>getAllPets() async {
    Database db = await instance.database;
    var res = await db.rawQuery("SELECT ${PetDataModel.getAtributos()} FROM ${PetDataModel.getTabela()} ORDER BY ${PetDataModel.nome}");
    return res.toList();
  }
Future<List> getPetsJoinTipo() async {

    Database db = await instance.database;
    var res = await db.rawQuery('''SELECT p.${PetDataModel.id}, p.${PetDataModel.nome},
                                p.${PetDataModel.dataNascimento}, p.${PetDataModel.sexo},
                                p.${PetDataModel.imagePet}, e.${TipoPetDataModel.descricao}        
                                FROM ${PetDataModel.getTabela()} p
                                INNER JOIN ${TipoPetDataModel.getTabela()} e ON p.${PetDataModel.tipoPet} = 
                                e.${TipoPetDataModel.id} 
                             ''');
    return res.toList();
}

///CRUD DONO
  Future<int> addDono(Dono dono) async {
    Database db = await instance.database;
    return await db.insert(DonoDataModel.getTabela(), dono.toMap());
  }
  Future<int> removeAllDonos() async{
    Database db = await instance.database;
    return await db.rawDelete(DonoDataModel.zerarTabela());
  }
  Future<List> getDonoPets() async {

    Database db = await instance.database;
    var res = await db.rawQuery(
        '''SELECT d.${DonoDataModel.id}, d.${DonoDataModel.nome}, d.${DonoDataModel.cpf}, d.${DonoDataModel.password},
           p.${PetDataModel.id}, p.${PetDataModel.nome} AS nomePet, p.${PetDataModel.dataNascimento}, p.${PetDataModel.sexo},
           e.${TipoPetDataModel.descricao} 
           FROM ${DonoDataModel.getTabela()} d
           LEFT JOIN ${PetDataModel.getTabela()} p ON p.${PetDataModel.donoPet} = d.${DonoDataModel.id}
           LEFT JOIN ${TipoPetDataModel.getTabela()} e ON p.${PetDataModel.tipoPet} = e.${TipoPetDataModel.id}''');

    return res.toList();
  }

  Future close() async {
    Database db = await instance.database;
    db.close();
  }


}





















