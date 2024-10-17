import 'package:flutter/material.dart';
import 'package:gerenciador_tarefas/models/tarefa.dart';
import 'database_helper.dart';

class TelaTarefasArquivadas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas Arquivadas'),
      ),
      body: FutureBuilder<List<Tarefa>>(
        future: DatabaseHelper().obterTarefasArquivadas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma tarefa arquivada.'));
          }

          final tarefasArquivadas = snapshot.data!;
          return ListView.builder(
            itemCount: tarefasArquivadas.length,
            itemBuilder: (context, index) {
              final tarefa = tarefasArquivadas[index];
              return ListTile(
                title: Text(tarefa.titulo),
                subtitle: Text(tarefa.descricao),
              );
            },
          );
        },
      ),
    );
  }
}