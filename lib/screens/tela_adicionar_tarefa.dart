import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TelaAdicionarTarefa extends StatelessWidget {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final List<String> cores = ['Red', 'Green', 'Blue', 'Yellow', 'Purple'];
  String corSelecionada = 'Red';

  TelaAdicionarTarefa({super.key}); // Valor padrão

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Tarefa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(labelText: 'Título da Tarefa'),
            ),
            TextField(
              controller: _descricaoController,
              decoration: const InputDecoration(labelText: 'Descrição da Tarefa'),
            ),
            DropdownButton<String>(
              value: corSelecionada,
              onChanged: (String? newValue) {
                corSelecionada = newValue!;
              },
              items: cores.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  {
                    'titulo': _tituloController.text,
                    'descricao': _descricaoController.text,
                    'cor': corSelecionada,
                  },
                );
              },
              child: const Text('Adicionar'),
            ),
          ],
        ),
      ),
    );
  }
}

