import 'package:extra/entity/extra_job.dart';
import 'package:extra/entity/profile.dart';
import 'package:extra/utils/colors.dart';
import 'package:extra/utils/consts.dart';
import 'package:extra/utils/event_bus.dart';
import 'package:extra/utils/strings.dart';
import 'package:extra/utils/utils.dart';
import 'package:extra/widgets/loading.dart';
import 'package:extra/widgets/no_has_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nice_button/nice_button.dart';
import 'package:toast/toast.dart';

class Extra extends StatefulWidget {

  ExtraJob editJob;
  int indice; //has indice is edit
  Extra({ this.editJob, this.indice = -1 });

  @override
  _ExtraState createState() => _ExtraState();
}

class _ExtraState extends State<Extra> {
  var city = TextEditingController();
  var _where = TextEditingController();
  var _description = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  List<ExtraJob> list;
  Profile p;
  bool isLoading = true;
  bool qtdExtra = false;

  @override
  void initState() {
    _load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Strings.EXTRA),
        ),
        body: isLoading
            ? Loading()
            : Center(
                child: (qtdExtra  && widget.indice == -1 )
                    ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _warning(),
                    )
                    : ListView(
                        shrinkWrap: true,
                        children: [
                          _form(),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      )));
  }

  _warning() {
    return Card(
      elevation: 8,
      child: Container(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Utils().title(context, Strings.OPS, t1: 12, t2: 12, t3: 12),
              Divider(
                color: MyColors.PRIMARY_COLOR,
              ),
              Text(
                Strings.ONE_EXTRA,
                style: GoogleFonts.portLligatSans(
                  textStyle: Theme.of(context).textTheme.display1,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _form() {
    return Column(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: _textFields(),
          ),
        ),
        NiceButton(
          width: double.infinity,
          gradientColors: [MyColors.PRIMARY_COLOR, MyColors.ACCENT_COLOR],
          onPressed: () async {
            if (_formKey.currentState.validate()) {

              if( widget.indice >= 0 ){
                _edit();
              }else{
                _create();
              }
              _load();
            } else {
              return null;
            }
          },
          text: widget.indice >= 0 ?Strings.EDIT : Strings.CREATE,
        ),
      ],
    );
  }

  _load() async {
    p = await Profile.get();

    if (p != null)
      _updateView(false, qtd: (p.extras != null && p.extras.isNotEmpty));

    if( widget.indice >= 0){
      _where.text = widget.editJob.where;
      _description.text = widget.editJob.description;
      _updateView(false);
    }


  }

  void _updateView(bool load, {bool qtd = true}) {

    setState(() {
      isLoading = load;
      qtdExtra = qtd;
    });
  }

  _entryField(String title, String hint, FormFieldValidator<String> validator,
      TextEditingController controller,
      {bool isDesc = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
              validator: validator,
              controller: controller,
              maxLength: isDesc ? 300 : 70,
              maxLines: isDesc ? 10 : 1,
              decoration: InputDecoration(
                  hintText: hint,
                  labelText: title,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  fillColor: Color(0xfff),
                  filled: true))
        ],
      ),
    );
  }

  String _validate(str) => Utils().validations(Consts.TYPE_TEXT, str);

  _textFields() {
    return Column(
      children: <Widget>[
        _entryField(
          Strings.WORK_WHERE,
          Strings.WORK_CITY,
          _validate,
          _where,
        ),

        _entryField(Strings.WHAT_DO_YOU_WANT, Strings.WHAT_DO_YOU_WANT_HINT,
            _validate, _description,
            isDesc: true),
        //_entryField("Senha", isPassword: true),
      ],
    );
  }

  void _create() {
    ExtraJob extra =
    ExtraJob(description: _description.text, where: _where.text);
    list = p.extras;
    if (list == null) {
      list = List();
    }
    list.add(extra);
    p.extras = list;
    _save();

  }

  void _edit() {

    list = p.extras;
    list.removeAt(widget.indice);
    widget.editJob.description = _description.text;
    widget.editJob.where = _where.text.toLowerCase();
    list.add(widget.editJob);
    p.extras = list;
    _save(qtd:false);
    _toast();
  }

  void _save({qtd = true }) {
    p.save();
    _updateView(true, qtd: qtd);
    _description.clear();
    _where.clear();
    _toast();
  }

  _toast(){
    Utils().toast(Strings.CREATE_SUCCESS,  context);
    EventBus.get(context)
        .sendEvent(ExtraJob(actionEvent: Consts.EVENT_JOB));
  }
}
