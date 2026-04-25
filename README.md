# 📱 OS 804 - Ordem de Serviço

Aplicativo mobile desenvolvido em **Flutter** para criação e gerenciamento de Ordens de Serviço (OS) de forma simples e rápida.

---

## 🚀 Funcionalidades

* 📄 Cadastro de Ordem de Serviço
* ➕ Adição de múltiplos produtos
* 💰 Cálculo automático de valores
* 👀 Visualização (preview) da OS
* 📥 Geração de PDF
* 🔄 Limpar formulário
* 🎨 Interface simples e intuitiva

---

## 📸 Preview

O app possui duas telas principais:

* **Tela inicial** (apresentação)
* **Formulário de OS**
* **Preview da OS (com exportação em PDF)**

---

## 🛠️ Tecnologias utilizadas

* Flutter
* Dart
* Package `pdf`
* Package `printing`

---

## 📂 Estrutura do projeto

```
lib/
├── main.dart
├── models/
│   └── produto.dart
├── pages/
│   ├── home_page.dart
│   ├── form_page.dart
│   └── preview_page.dart
├── services/
│   └── pdf_service.dart
```

---

## ▶️ Como executar

```bash
# Clonar o repositório
git clone https://github.com/DanatiellyCP/app_os

# Entrar na pasta
cd os804

# Instalar dependências
flutter pub get

# Rodar o app
flutter run
```

---

## 📦 Gerar APK

```bash
flutter build apk
```

O APK será gerado em:

```
build/app/outputs/flutter-apk/app-release.apk
```

---

## 🎯 Objetivo

Este projeto foi desenvolvido como uma solução simples para digitalização de ordens de serviço, podendo evoluir para um sistema completo com backend e integração em nuvem.

---

## 🚀 Futuras melhorias

* 🔐 Autenticação de usuários
* ☁️ Integração com backend (Django)
* 📊 Histórico de ordens de serviço
* 🖼️ Upload de imagens
* 📤 Compartilhamento via WhatsApp

---

## 👩‍💻 Desenvolvido por

**Danatielly Costa**
💙 Blue Hause

---
