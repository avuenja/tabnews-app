# TabNews App

[![Android APK](https://github.com/avuenja/tabnews-app/actions/workflows/android.yml/badge.svg)](https://github.com/avuenja/tabnews-app/actions/workflows/android.yml)

Aplicativo TabNews feito com muito ♥️ e Flutter pela comunidade, para o site [TabNews](https://www.tabnews.com.br).

## Features:

- [x] Dark mode
- [x] Leitura de conteúdos
- [x] Pull To Refresh
- [x] Infite Scroll
- [x] Visualização de Comentários das publicações
- [x] Login do usuário
- [x] Meus conteúdos
- [x] Gerencimaneto de conta
- [x] Criação de conta pelo App
- [x] Resposta dos conteúdos
- [x] Interação com Tabcoins
- [x] Postagens de conteúdos
- [x] Visualização do perfil de outros usuários
- [x] Favoritos (local database)
- [ ] Opção ler mais tarde (local database)
- [ ] Buscar conteúdos (?)

## Instalar e rodar o projeto

### Dependências globais

Você precisa ter o Flutter instalado e configurado na sua máquina:

- [Flutter](https://docs.flutter.dev/get-started/install) 3.0 (ou qualquer versão **3** superior)

### Dependências locais

Então após baixar/clonar o repositório, não se esqueça de instalar as dependências locais do projeto:

```bash
flutter pub get
```

### Rodar o projeto

Para rodar o projeto localmente, basta rodar o comando abaixo:

```bash
flutter run
```

Isto irá rodar o projeto no seu emulador/simulador ou dispositivo real conectado.

**Lembrando que as vezes é necessário abrir o emulador/simulador antes de rodar o comando de run.**

### Buildar o projeto

Para buildar o projeto, basta rodar o seguitne comando:

**Android APK**

```
flutter build apk
```

Diretório de saída do APK: _(build/app/outputs/flutter-apk/app-release.apk)_

**Apple iOS**

_Sugiro buildar diretamente pelo **Xcode**, selecionando seu dispositivo como device. E também para utilizar sem a conexão USB, é necessário buildar utilizando o mode **Profile**_

## Showcase:

![Alpha](https://user-images.githubusercontent.com/5226773/203870853-5f5a3706-b0aa-459a-b46d-1d9ef9bdb2c3.gif)

<img src="https://user-images.githubusercontent.com/5226773/203336162-7af83c42-9ec0-4b6c-8be6-e7be32426527.PNG" width="300px" alt="Home - Dark" />
<img src="https://user-images.githubusercontent.com/5226773/203336292-724ab6e6-d3fe-400a-a1ee-12ef5db0a54c.PNG" width="300px" alt="Leitura - Dark" />

## Commit das alterações

O projeto utiliza a especificação de [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/).  
O sistema foi configurado com o [lefthook](https://github.com/evilmartians/lefthook), e adiconado as configurações em `lefthook.yml` e criado as configurações das mensagens em `bin/commit_message.dart`.

## Contribuidores

Acesse a página de [Insights](https://github.com/avuenja/tabnews-app/graphs/contributors) do projeto.
