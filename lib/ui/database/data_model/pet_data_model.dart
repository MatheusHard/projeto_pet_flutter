
class PetDataModel{

  static const String TABELA = "tabelaPet";
  static const String id = "id";
  static const String nome = "nome";
  static const String tipoPet = "tipoPet";
  static const String imagePet = "imagePet";
  static const String donoPet = "donoPet";
  static const String dataNascimento = "dataNascimento";
  static const String sexo = "sexo";

   static String queryCriarTabela = "";

   static String criarTabela() {

    return '''CREATE TABLE $TABELA ($id TEXT PRIMARY KEY,
              $dataNascimento DATETIME, $nome TEXT, $tipoPet INTEGER,
              $imagePet TEXT, $sexo boolean NOT NULL default 0, 
              $donoPet INTEGER);''';
   }

   static String dropTable(){
    return "DROP TABLE IF EXISTS $TABELA;";
  }

   static String zerarTabela() {

    return "DELETE FROM $TABELA;";
  }

   static String getTabela(){
    return TABELA;
  }

  static String getAtributos(){
     return '''$TABELA.id, $TABELA.nome, $TABELA.tipoPet, $TABELA.imagePet, $TABELA.donoPet, $TABELA.dataNascimento, $TABELA.sexo''';
  }
}

