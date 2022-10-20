
class PetDataModel{

  static const String TABELA = "tabelaPet";
  static const String id = "id";
  static const String nome = "nome";
  static const String especiePet = "especiePet";
  static const String idade = "idade";
  static const String dataNascimento = "dataNascimento";
  static const String sexo = "sexo";

   static String queryCriarTabela = "";

   static String criarTabela() {

    return '''CREATE TABLE $TABELA ($id INTEGER PRIMARY KEY,
              $dataNascimento DATETIME, $nome TEXT, $especiePet INTEGER,
              $idade INTEGER, $sexo boolean NOT NULL default 0);''';
   }

   static String dropTable(){
    return   "DROP TABLE IF EXISTS $TABELA;";
  }

   static String zerarTabela() {

    return "DELETE FROM $TABELA;";
  }

   static String getTabela(){
    return TABELA;
  }

  static String getAtributos(){
     return '''$TABELA.id, $TABELA.nome, $TABELA.data_final, $TABELA.gasto_total, $TABELA.saldo, $TABELA.cidade_id, $TABELA.funcionario_id''';
  }
}

