// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

import 'package:job_timer/app/modules/project/register/controller/project_register_controller.dart';

class ProjectRegisterPage extends StatefulWidget {
  final ProjectRegisterController controller;

  const ProjectRegisterPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<ProjectRegisterPage> createState() => _ProjectRegisterPageState();
}

class _ProjectRegisterPageState extends State<ProjectRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _estimateEC = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _estimateEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectRegisterController, ProjectRegisterStatus>(
      bloc: widget.controller,
      //listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        switch (state) {
          case ProjectRegisterStatus.success:
            AsukaSnackbar.success('Projeto cadastrado com sucesso').show();
            Modular.to.pop();
            break;
          case ProjectRegisterStatus.failure:
            AsukaSnackbar.alert('Erro ao cadastrar projeto').show();
            break;
          default:
          break;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Criar novo Projeto',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 0,
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  validator: Validatorless.required('Nome obrigatório'),
                  controller: _nameEC,
                  decoration: InputDecoration(
                    label: Text('Nome do projeto'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: Validatorless.multiple([
                    Validatorless.required('Estimátiva obrigatória'),
                    Validatorless.number('Permitido somente números'),
                    Validatorless.min(0, 'Estimativa deve ser maior que zero'),
                  ]),
                  controller: _estimateEC,
                  decoration: InputDecoration(
                    label: Text('Estimativa de horas'),
                  ),
                ),
                BlocSelector<ProjectRegisterController, ProjectRegisterStatus,
                    bool>(
                  bloc: widget.controller,
                  selector: (state) {
                    return state == ProjectRegisterStatus.loading;
                  },
                  builder: (context, showLoading) {
                    return Visibility(
                      visible: showLoading,
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 49,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      final formValid =
                          _formKey.currentState?.validate() ?? false;
                      if (formValid) {
                        final name = _nameEC.text;
                        final estimate = int.parse(_estimateEC.text);

                        await widget.controller.registerProject(name, estimate);
                      }
                    },
                    child: Text('Salvar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
