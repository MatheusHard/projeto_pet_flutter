
class TipoVacinaDataModel{

  static const String TABELA = "tabelaTipoVacina";
  static const String id = "id";
  static const String nomeVacina = "nomeVacina";
  static const String dataCadastro = "dataCadastro";



  static String queryCriarTabela = "";

  static String criarTabela() {

    return '''CREATE TABLE $TABELA ($id INTEGER PRIMARY KEY, $nomeVacina TEXT, $dataCadastro TEXT);''';
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
    return '''$TABELA.id, $TABELA.nomeVacina, $TABELA.dataCadastro''';
  }
}

