
class TipoPetDataModel{

  static const String TABELA = "tabelaTipoPet";
  static const String id = "id";
  static const String descricao = "descricao";

  static String queryCriarTabela = "";

  static String criarTabela() {

    return '''CREATE TABLE $TABELA ($id INTEGER PRIMARY KEY, $descricao TEXT);''';
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
    return '''$TABELA.id, $TABELA.descricao''';
  }
}

