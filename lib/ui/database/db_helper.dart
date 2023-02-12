import 'package:projeto_pet/ui/database/data_model/dono_data_model.dart';
import 'package:projeto_pet/ui/database/data_model/pet_data_model.dart';
import 'package:projeto_pet/ui/database/data_model/tipo_pet_data_model.dart';
import 'package:projeto_pet/ui/database/data_model/tipo_vacina_data_model.dart';
import 'package:projeto_pet/ui/models/dono.dart';
import 'package:projeto_pet/ui/models/pet.dart';
import 'package:projeto_pet/ui/models/tipo_pet.dart';
import 'package:projeto_pet/ui/models/tipo_vacina.dart';
import 'package:projeto_pet/ui/models/vacina.dart';
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


  ///CRUD VACINA
  Future<List<Vacina>>getAllVacinas() async {
    Database db = await instance.database;
    var tiposVacinas = await db.query(VacinaDataModel.getTabela(), orderBy: VacinaDataModel.nomeVacina);
    List<Vacina> list = tiposVacinas.isNotEmpty
        ? tiposVacinas.map((p) => Vacina.fromMap(p)).toList()
        : [];
    return list;
  }
  ///        where: '${PetDataModel.id} = ?', whereArgs: [pet.id]);
  Future<List<Vacina>>getAllVacinasByPet(String petId) async {
    Database db = await instance.database;
    var tiposVacinas = await db.query(VacinaDataModel.getTabela(), orderBy: VacinaDataModel.nomeVacina,
    where: '${VacinaDataModel.petId} = ?', whereArgs: [petId]);
    List<Vacina> list = tiposVacinas.isNotEmpty
        ? tiposVacinas.map((p) => Vacina.fromMap(p)).toList()
        : [];
    return list;
  }
/*  Future<List>getAllVacinasByPet(String petId) async {
    Database db = await instance.database;
    var res = await db.rawQuery('''SELECT v.${VacinaDataModel.id}, v.${VacinaDataModel.nomeVacina},
                                  v.${VacinaDataModel.petId}, v.${VacinaDataModel.dataAplicacao}, 
                                  v.${VacinaDataModel.dataCadastro}, v.${VacinaDataModel.dose}
                                   FROM ${VacinaDataModel.getTabela()} v
                                   WHERE  v.${VacinaDataModel.petId} = '$petId' 
                                   ORDER BY v.${VacinaDataModel.nomeVacina} ''');
                              return res.toList();
    }
*/



  Future<int> addVacina(Vacina v) async {
    Database db = await instance.database;
    return await db.insert(VacinaDataModel.getTabela(), v.toMap());
  }
  Future<int> updateVacina(Vacina v) async {
    Database db = await instance.database;
    return await db.update(VacinaDataModel.getTabela(), v.toMap(),
        where: '${VacinaDataModel.id} = ?', whereArgs: [v.id]);
  }
  Future<int> removeAllVacinas() async{
    Database db = await instance.database;
    return await db.rawDelete(VacinaDataModel.zerarTabela());
  }
  ///CRUD TIPO VACINA
  Future<List>getAllTiposVacinas() async {
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


  ///CRUD TIPO PETS
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
Future<List> getPetsJoinTipo(int DonoPetId) async {

    Database db = await instance.database;
    var res = await db.rawQuery('''SELECT p.${PetDataModel.id}, p.${PetDataModel.nome},
                                p.${PetDataModel.dataNascimento}, p.${PetDataModel.sexo},
                                p.${PetDataModel.imagePet}, e.${TipoPetDataModel.descricao}        
                                FROM ${PetDataModel.getTabela()} p
                                INNER JOIN ${TipoPetDataModel.getTabela()} e ON p.${PetDataModel.tipoPet} = e.${TipoPetDataModel.id}
                                WHERE p.${PetDataModel.donoPet} =  $DonoPetId
                             ''');
    return res.toList();
}

  ///CRUD DONO
  Future<int> addDono(Dono dono) async {
    Database db = await instance.database;
    return await db.insert(DonoDataModel.getTabela(), dono.toMap());
  }
  Future<int> updateDono(Dono dono) async {
    Database db = await instance.database;
    return await db.update(DonoDataModel.getTabela(), dono.toMap(),
        where: '${DonoDataModel.id} = ?', whereArgs: [dono.id]);
    
  }
  Future<int> updateCodigoDono(Dono dono) async {
    Database db = await instance.database;

    return await db.rawUpdate('''
    UPDATE ${DonoDataModel.getTabela()} 
    SET ${DonoDataModel.codigoRecuperacao} = ? 
    WHERE ${DonoDataModel.id} = ?
    ''', [dono.codigoRecuperacao, dono.id]);
  }
  Future<List>getDonoByCpfOrUser(String cpf, String user) async {
    Database db = await instance.database;
    var res = await db.rawQuery('''SELECT ${DonoDataModel.getAtributos()} 
                                   FROM ${DonoDataModel.getTabela()} 
                                   WHERE tabelaDono.${DonoDataModel.cpf} = '$cpf' OR tabelaDono.${DonoDataModel.user} = '$user'
                                   ORDER BY tabelaDono.${DonoDataModel.nome}''');
    return res.toList();
  }

  Future<Dono?>getDonoLogin(String cpf, String user, String password) async {
    Database db = await instance.database;
    var res = await db.rawQuery('''SELECT ${DonoDataModel.getAtributos()} 
                                   FROM ${DonoDataModel.getTabela()} 
                                   WHERE (tabelaDono.${DonoDataModel.cpf} = '$cpf' OR tabelaDono.${DonoDataModel.user} = '$user') 
                                   AND tabelaDono.${DonoDataModel.password} = '$password' 
                                   ORDER BY tabelaDono.${DonoDataModel.nome}''');
    if(res.isNotEmpty) {
      return Dono.fromMap(res.first);
    }else {
      return null;

    }  }

  Future<Dono?>findDonoByCodigo (int id, String codigo) async {

    Database db = await instance.database;
    var res = await db.query(DonoDataModel.getTabela(), where: 'id = ? AND user = ?', whereArgs: [id, codigo]);
    if(res.isNotEmpty) {
      return Dono.fromMap(res.first);
    }else {
      return null;

    }
  }
  Future<Dono?>getDono(String cpf, String user) async {

    Database db = await instance.database;
    var res = await db.query(DonoDataModel.getTabela(), where: 'cpf = ? OR user = ?', whereArgs: [cpf, user]);
   if(res.isNotEmpty) {
     return Dono.fromMap(res.first);
   }else {
     return null;

   }
  }

    Future<int> removeAllDonos() async{
    Database db = await instance.database;
    return await db.rawDelete(DonoDataModel.zerarTabela());
  }
  Future<List> getDonoPets() async {

    Database db = await instance.database;
    var res = await db.rawQuery(
        '''SELECT d.${DonoDataModel.id}, d.${DonoDataModel.nome}, d.${DonoDataModel.cpf}, d.${DonoDataModel.password}, 
           d.${DonoDataModel.user}, d.${DonoDataModel.qtdRowListagem}, p.${PetDataModel.id}, p.${PetDataModel.nome} AS nomePet,
           d.${DonoDataModel.codigoRecuperacao}, p.${PetDataModel.dataNascimento}, p.${PetDataModel.sexo}, e.${TipoPetDataModel.descricao} 
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





















