import 'package:projeto_pet/ui/database/data_model/dono_data_model.dart';
import 'package:projeto_pet/ui/database/data_model/pet_data_model.dart';
import 'package:projeto_pet/ui/database/data_model/tipo_pet_data_model.dart';
import 'package:projeto_pet/ui/models/dono.dart';
import 'package:projeto_pet/ui/models/pet.dart';
import 'package:projeto_pet/ui/models/tipo_pet.dart';
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

  Future<int> removeAllPets() async{
    Database db = await instance.database;
    return await db.rawDelete(PetDataModel.zerarTabela());
  }
  Future close() async {
    Database db = await instance.database;
    db.close();
  }



/******CRUD TIPO PETS******/

  Future<List>getAllTiposPets() async {
   /* Database db = await instance.database;
    var tiposPets = await db.query(TipoPetDataModel.getTabela(), orderBy: TipoPetDataModel.descricao);
    List<TipoPet> list = tiposPets.isNotEmpty
        ? tiposPets.map((p) => TipoPet.fromMap(p)).toList()
        : [];
    return list;*/

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
Future<List> getPetsJoinTipo() async {

    Database db = await instance.database;
    var res = await db.rawQuery('''SELECT p.${PetDataModel.id}, p.${PetDataModel.nome},
                                p.${PetDataModel.dataNascimento}, p.${PetDataModel.sexo},
                                e.${TipoPetDataModel.descricao}        
                                FROM ${PetDataModel.getTabela()} p
                                INNER JOIN ${TipoPetDataModel.getTabela()} e ON p.${PetDataModel.tipoPet} = 
                                e.${TipoPetDataModel.id} 
                             ''');
    return res.toList();
}

///Crud Dono
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
           p.${PetDataModel.id}, p.${PetDataModel.nome}, p.${PetDataModel.dataNascimento}, p.${PetDataModel.sexo},
           e.${TipoPetDataModel.descricao} 
           FROM ${DonoDataModel.getTabela()} d
           LEFT JOIN ${PetDataModel.getTabela()} p ON p.${PetDataModel.donoPet} = d.${DonoDataModel.id}
           LEFT JOIN ${TipoPetDataModel.getTabela()} e ON p.${PetDataModel.tipoPet} = e.${TipoPetDataModel.id}''');

    return res.toList();
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





















