# Contact App

Une application de gestion de contacts avec support multilingue et thème adaptatif.

## Fonctionnalités

- Gestion des contacts (liste, détails)
- Thème sombre/clair automatique et manuel
- Localisation FR/EN avec détection automatique
- Pagination infinie
- Appels directs et emails depuis l'application

## Architecture

Application structurée en Clean Architecture:
lib/
├── core/          # Configuration, réseau, thème
├── data/          # Sources de données et modèles
├── domain/        # Logique métier
├── l10n/          # Traductions FR/EN
└── presentation/  # Interface utilisateur (Blocs, Pages)

## Installation

1. Cloner le repository
```bash
git clone ...
flutter pub get
flutter run
```

## Configuration

### Thème

Mode sombre/clair automatique selon les paramètres système
Adaptation des couleurs et contrastes pour chaque thème

### Langue

🇫🇷 Français (défaut)
🇬🇧 Anglais
Détection automatique de la langue système

### Navigation

Splash → Onboarding (première utilisation) → Home
Splash → Home (utilisations suivantes)

## Développement
La structure suit les principes SOLID et utilise:

Bloc pour la gestion d'état
Go Router pour la navigation
Dio pour les requêtes HTTP
Clean Architecture pour la séparation des responsabilités