
class VacinaDataModel{

  static const String TABELA = "tabelaVacina";
  static const String id = "id";
  static const String dataCadastro = "dataCadastro";
  static const String dataAplicacao = "dataAplicacao";
  static const String nomeVacina = "nomeVacina";
  static const String dose = "dose";
  static const String petId = "petId";


  static String queryCriarTabela = "";

  static String criarTabela() {

    return '''CREATE TABLE $TABELA ($id INTEGER PRIMARY KEY, $nomeVacina TEXT, $dataCadastro TEXT,
                $dataAplicacao TEXT, $dose TEXT, $petId INTEGER);''';
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
    return '''$TABELA.id, $TABELA.nomeVacina, $TABELA.dose, $TABELA.dataCadastro, $TABELA.dataAplicacao, $TABELA.petId''';
  }
}

