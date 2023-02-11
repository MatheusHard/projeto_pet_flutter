import 'package:flutter/material.dart';
import 'package:projeto_pet/ui/utils/metods/utils.dart';

import '../../components/widgets/appbar/app_bar_dono.dart';
import '../../utils/core/app_text_styles.dart';
import '../screen_arguments/ScreenArgumentsDono.dart';

class EsqueciAcessoValidacao extends StatefulWidget {
  const EsqueciAcessoValidacao({Key? key}) : super(key: key);

  @override
  State<EsqueciAcessoValidacao> createState() => _EsqueciAcessoValidacaoState();
}

class _EsqueciAcessoValidacaoState extends State<EsqueciAcessoValidacao> {

  final _senhaController = TextEditingController();
  final _repetirSenhaController = TextEditingController();
  final _codigoValidacaoController = TextEditingController();
  final textFieldFocusNode = FocusNode();
  final textFieldFocusNode2 = FocusNode();


  int qtd = 1;
  bool obscured = true;
  bool obscured2 = true;

  bool _flag = false;
  late FocusNode _myFocusNodeSenha;
  late FocusNode _myFocusNodeRepetirSenha;
  bool showWidget = false;


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _myFocusNodeSenha = FocusNode();
    _myFocusNodeRepetirSenha = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenArgumentsDono? argsDono = ModalRoute
        .of(context)
        ?.settings
        .arguments as ScreenArgumentsDono?;

    return Scaffold(
      appBar: AppBarDono(null),
      body: Form(
        key: _formKey,
        child: Stack(
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25, vertical: 30),
                  child: SingleChildScrollView(

                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 30),
                          child: Text(
                            "Inserir o Codigo", style: AppTextStyles.titlePet,),
                        ),


                        ///Codigo de Validacao:
                       wiggetCodigoValidacao(),
                       ///Chave escolha Cpf ou Email
                        showWidget ?  widgetSenhaRepetirSenha() : Container()

                      ],
                    ),
                  )
              ),
            ]
        ),
      ),
    );
  }

  clearControllers() {
    _senhaController.clear();
    _repetirSenhaController.clear();
    _codigoValidacaoController.clear();
  }

  widgetFlagCpfOrEmail() {
    /**SEXO DO PET**/
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: SwitchListTile(
        title: const Text('Tipo de Envio'),
        value: _flag,
        activeColor: Colors.pink,
        inactiveThumbColor: Colors.blue,
        inactiveTrackColor: Colors.lightBlueAccent,

        onChanged: (bool value) {
          setState(() {
            _flag = value;
          });
        },
        subtitle: const Text("E-mail ou Cpf"),
        secondary: const Icon(
            Icons.pets_sharp, color: Colors.blue),
      ),
    );
  }

  wiggetCodigoValidacao(){

    return
      Row(
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
             Flexible(
               child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _codigoValidacaoController,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      //Hides label on focus or if filled
                      labelText: "Codigo",
                      filled: true,
                      // Needed for adding a fill color
                      fillColor: Colors.white60,
                      isDense: true,
                      // Reduces height a bit
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none, // No border
                        borderRadius: BorderRadius.circular(
                            12), // Apply corner radius
                      ),
                      prefixIcon: const Icon(Icons.sms_rounded, size: 24),

                    ),
                    validator: (value) {
                      return null;
                    }
                ),
             ),

               IconButton(
                icon: const Icon(Icons.ads_click),
                 onPressed: () {
                   setState(() {
                     showWidget = !showWidget;
                   });
                 },
            )
            ],);



}

  widgetSenhaRepetirSenha() {

      return

        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
              child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: obscured,
                  focusNode: textFieldFocusNode,
                  controller: _senhaController,

                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    //Hides label on focus or if filled
                    labelText: "Senha",
                    filled: true,
                    // Needed for adding a fill color
                    fillColor: Colors.white60,
                    isDense: true,
                    // Reduces height a bit
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none, // No border
                      borderRadius: BorderRadius.circular(
                          12), // Apply corner radius
                    ),
                    prefixIcon: const Icon(Icons.lock_rounded, size: 24),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                      child: GestureDetector(
                        onTap: _toggleObscuredSenha,
                        child: Icon(
                          obscured ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                validator: (value) {
                  if (value!.isEmpty || value == "") {
                    return "Digite a Senha";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
              child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: obscured2,
                  focusNode: textFieldFocusNode2,
                  controller: _repetirSenhaController,

                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    //Hides label on focus or if filled
                    labelText: "Repetir Senha",
                    filled: true,
                    // Needed for adding a fill color
                    fillColor: Colors.white60,
                    isDense: true,
                    // Reduces height a bit
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none, // No border
                      borderRadius: BorderRadius.circular(
                          12), // Apply corner radius
                    ),
                    prefixIcon: const Icon(Icons.lock_rounded, size: 24),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                      child: GestureDetector(
                        onTap: _toggleObscuredRepetirSenha,
                        child: Icon(
                          obscured2 ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                validator: (value) {
                  if (value!.isEmpty || value == "") {
                    return "Digite a Senha Repetida";
                  }
                  return null;
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 50, vertical: 25),
                child: Center(
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate() && validateSenhas()) {
                            if(validateEquals()){
                            print("OK Validar Senhas");
                            //_sendEmail();
                            //_sendEmaill(_cpfController.text,
                            //  _userController.text);
                          }else{
                              Utils.showDefaultSnackbar(context, "Atenção, senhas divergentes!!!");
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20))),
                        child: Ink(

                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    colors:
                                    [
                                      Color(0xFF57B6E5),
                                      Color.fromRGBO(
                                          130, 87, 229, 0.695),
                                    ]),
                                borderRadius: BorderRadius.circular(
                                    20)),
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .center,
                              children: [
                                const Icon(Icons.lock_rounded),
                                Container(
                                  width: 150,
                                  height: 50,
                                  alignment: Alignment.center,
                                  child: Text('Atualizar', style: AppTextStyles.titleLogin,),

                                ),
                              ],)
                        )
                    )
                )),

          ],);

  }
  ///Validações:
  bool validateSenhas() {
    bool flag = true;

    if (_senhaController.text.isEmpty) return false;
    if (_repetirSenhaController.text.isEmpty) return false;

    return flag;
  }
  bool validateEquals() {
    bool flag = true;

    if (_senhaController.text != _repetirSenhaController.text) return false;

    return flag;
  }
  void _toggleObscuredSenha() {
    setState(() {
      obscured = !obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false;     // Prevents focus if tap on eye
    });
  }
  void _toggleObscuredRepetirSenha() {
    setState(() {
      obscured2 = !obscured2;
      if (textFieldFocusNode2.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
      textFieldFocusNode2.canRequestFocus = false;     // Prevents focus if tap on eye
    });
  }


  }




