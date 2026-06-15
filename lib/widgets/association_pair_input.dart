import 'package:flutter/material.dart';

class AssociationPairInput extends StatelessWidget {
  final int index;
  final TextEditingController itemController;
  final TextEditingController descriptionController;
  final VoidCallback onDelete;

  const AssociationPairInput({
    super.key,
    required this.index,
    required this.itemController,
    required this.descriptionController,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Index e Lixeira superior
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: const Color(0xFF8B5CF6),
                child: Text('${index + 1}', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              )
            ],
          ),
          const SizedBox(height: 12),
          
          // Inputs lado a lado ou empilhados dependendo da tela
          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 500;
              
              final fields = [
                Expanded(
                  flex: isMobile ? 0 : 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Item / Elemento', style: TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w500)),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: itemController,
                        decoration: const InputDecoration(hintText: 'Ex: Béquer', contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10), border: OutlineInputBorder()),
                        validator: (value) => value!.isEmpty ? 'Obrigatório' : null,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 12, vertical: isMobile ? 8 : 0),
                  child: Icon(isMobile ? Icons.arrow_downward : Icons.arrow_forward, color: const Color(0xFF8B5CF6)),
                ),
                Expanded(
                  flex: isMobile ? 0 : 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Função / Descrição', style: TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w500)),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: descriptionController,
                        decoration: const InputDecoration(hintText: 'Ex: Misturar e aquecer líquidos', contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10), border: OutlineInputBorder()),
                        validator: (value) => value!.isEmpty ? 'Obrigatório' : null,
                      ),
                    ],
                  ),
                ),
              ];

              return isMobile ? Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: fields) : Row(children: fields);
            },
          )
        ],
      ),
    );
  }
}