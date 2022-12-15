import 'package:flutter/material.dart';
import 'package:tabnews/src/ui/widgets/markdown.dart';
import 'package:tabnews/src/ui/widgets/top_bar.dart';

class UseTermsPage extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  UseTermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const Text(
              'Termos de Uso',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Divider(height: 50),
            MarkedownReader(
              controller: _scrollController,
              body:
                  '''O Aplicativo TabNews, é um projeto desenvolvido pela comunidade open-source, **e não é um client oficial** da plataforma TabNews.   
                  A marca **TabNews**, junto com o serviço e o domínio **tabnews.com.br** são propriedades intelectuais de uma empresa que temos localizada no Canadá chamada **Filipe Deschamps Tech Inc.**  
                  ---   
                  Lembrando que todos os termos de uso contidos na plataforma TabNews, ainda valem quando você utiliza o Appi para postagem de conteúdos.   
                  ---    
                  https://www.tabnews.com.br/termos-de-uso''',
            ),
          ],
        ),
      ),
    );
  }
}
