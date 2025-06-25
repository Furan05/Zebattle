# 🏆 Groudonbattle - Plateforme de Tournois Épiques

> **Application web moderne de gestion d'équipes et tournois esports**

[![Rails](https://img.shields.io/badge/Rails-7.1+-red.svg)](https://rubyonrails.org/)
[![Ruby](https://img.shields.io/badge/Ruby-3.3+-red.svg)](https://www.ruby-lang.org/)
[![MariaDB](https://img.shields.io/badge/MariaDB-Compatible-blue.svg)](https://mariadb.org/)
[![Bootstrap](https://img.shields.io/badge/Bootstrap-5.3-purple.svg)](https://getbootstrap.com/)

## ✨ Aperçu

Groudonbattle est une plateforme web complète permettant de créer et gérer des équipes de gaming, organiser des tournois automatiques et suivre des statistiques détaillées. Conçue avec une interface gaming moderne et des animations fluides.

### 🌟 Page d'Accueil Moderne

- **Design Gaming/Esports** : Interface sombre avec gradients et effets glassmorphism
- **Animations Fluides** : Éléments flottants, compteurs animés, transitions smooth
- **Statistiques Temps Réel** : Affichage dynamique des données de l'application
- **Call-to-Actions Optimisés** : Navigation intuitive vers toutes les fonctionnalités
- **Responsive Design** : Parfaitement adapté mobile, tablette et desktop

## 🚀 Fonctionnalités Principales

### 👥 Gestion d'Équipes
- **Création d'équipes** avec nom (max 50 caractères) et ville
- **Limitation à 11 joueurs** par équipe pour respecter les compositions classiques
- **Interface de gestion** complète avec modification/suppression
- **Validation en temps réel** de la composition des équipes

### ⚔️ Système de Joueurs
- **Trois rôles spécialisés** : Tank (défenseur), Heal (soigneur), DPS (attaquant)
- **Interface avec dropdown** pour sélectionner l'équipe d'affectation
- **Gestion centralisée** : Vue globale de tous les joueurs avec filtres
- **Validations avancées** : Unicité des noms par équipe, vérification des limites

### 🏆 Tournois Automatiques
- **Génération instantanée** de 8 équipes complètes (88 joueurs au total)
- **Deux modes de création** :
  - **Mode Classique** : Thème fantasy médiéval cohérent (Dragons de Feu, Aragorn le Brave...)
  - **Mode Faker** : Noms créatifs et aléatoires (gem Faker : superhéros, jeux vidéo, fantasy...)
- **Système de matchs** : Chaque équipe affronte chaque autre une seule fois (28 matchs total)
- **Scores aléatoires** : Entre 0-5 kills par équipe pour un réalisme gaming

### 📊 Classements et Statistiques
- **Tableau de classement** au format exact des consignes :
  - Points (3 victoire, 1 nul, 0 défaite)
  - Kills reçus et marqués
  - Différence de kills
  - Ratio victoires/défaites
- **Podium visuel** avec médailles 🥇🥈🥉
- **Résultats détaillés** de tous les matchs
- **Statistiques globales** : nombre d'équipes, joueurs, tournois, etc.

## 🛠️ Stack Technique

### Backend
- **Ruby 3.3.5** - Langage de programmation moderne
- **Rails 7.1.5+** - Framework web robuste et scalable
- **MariaDB** - Base de données relationnelle performante

### Frontend
- **Bootstrap 5.3** - Framework CSS responsive
- **Font Awesome 6.4** - Icons moderne et élégante
- **CSS3 Avancé** - Gradients, animations, glassmorphism
- **JavaScript Vanilla** - Animations scroll, compteurs, interactions

### Architecture
- **Modèles relationnels** : Team ↔ Player, Tournament ↔ Match
- **Validations complètes** : Contraintes métier respectées
- **Routes RESTful** : API claire et logique
- **Helpers personnalisés** : Code réutilisable et maintenable

## 📁 Structure du Projet

```
app/
├── controllers/
│   ├── home_controller.rb          # Page d'accueil moderne
│   ├── teams_controller.rb         # Gestion des équipes
│   ├── players_controller.rb       # Gestion des joueurs
│   └── tournaments_controller.rb   # Tournois et classements
├── models/
│   ├── team.rb                     # Modèle équipe avec validations
│   ├── player.rb                   # Modèle joueur avec rôles
│   ├── tournament.rb               # Logique de tournois
│   └── match.rb                    # Système de matchs
├── views/
│   ├── home/
│   │   └── index.html.erb          # Page d'accueil design gaming
│   ├── layouts/
│   │   ├── application.html.erb    # Layout principal
│   │   └── home.html.erb          # Layout spécifique home
│   ├── teams/                      # Vues gestion équipes
│   ├── players/                    # Vues gestion joueurs
│   └── tournaments/                # Vues tournois et classements
└── helpers/
    └── application_helper.rb       # Helpers pour UI/UX
```

## 🚀 Installation et Démarrage

### Prérequis
- Ruby 3.3.5+
- Rails 7.1+
- MariaDB ou MySQL
- Git

### Installation

```bash
# Cloner le projet
git clone git@github.com:Furan05/Zebattle.git
cd Zebattle

# Installer les dépendances
bundle install

# Configuration base de données
# Modifier config/database.yml avec vos identifiants

# Créer et migrer la base de données
rails db:create
rails db:migrate

# Démarrer l'application
rails server
```

### Accès à l'application
- **URL** : http://localhost:3000
- **Home Page** : Interface gaming moderne avec stats temps réel
- **Navigation** : Menu avec accès direct aux équipes, joueurs et tournois

## 🎮 Guide d'Utilisation

### 1. Première Visite
1. **Page d'accueil** affiche les statistiques actuelles
2. **Boutons CTA** pour commencer rapidement
3. **Navigation** claire vers toutes les sections

### 2. Créer des Équipes
```
/teams → Nouvelle équipe → Saisir nom + ville → Valider
```

### 3. Ajouter des Joueurs
```bash
# Méthode 1 : Depuis une équipe
/teams/[id] → Ajouter un joueur → Nom + Poste

# Méthode 2 : Interface globale avec dropdown
/players/new → Nom + Poste + Sélection équipe
```

### 4. Lancer un Tournoi
```
/tournaments → Générer Tournoi Auto OU Tournoi Faker
→ 8 équipes + 88 joueurs créés automatiquement
→ 28 matchs joués avec scores aléatoires
→ Classement généré instantanément
```

## 📊 Respect des Consignes

### ✅ Stack Technique
- ✅ Rails 7+
- ✅ MariaDB
- ✅ VS Code compatible

### ✅ Notions Techniques
- ✅ Migrations (tables teams, players, tournaments, matches)
- ✅ Modèles avec validations complètes
- ✅ Contrôleurs RESTful avec toutes les actions
- ✅ Vues avec formulaires Bootstrap
- ✅ Routing (Resources, Collection, Member)
- ✅ Relations (belongs_to, has_many)
- ✅ Requêtes BDD optimisées
- ✅ Helpers personnalisés

### ✅ Fonctionnalités Métier
- ✅ **Équipes** : Nom (max 50 char) + ville + validation unicité
- ✅ **Joueurs** : Nom + poste (Heal/Tank/DPS) avec dropdown
- ✅ **Affectation** : Dropdown sélection équipe + limite 11 joueurs
- ✅ **Tournois** : Génération auto 8 équipes + matchs complets
- ✅ **Classement** : Format exact demandé (Points, kills reçus/marqués)

## 🎨 Interface Utilisateur

### Design Gaming Moderne
- **Couleurs** : Palette sombre avec accents colorés
- **Typographie** : Fonts gaming avec effets lumineux
- **Animations** : Smooth transitions, hover effects
- **Glassmorphism** : Cards semi-transparentes avec blur
- **Responsive** : Mobile-first design

### Expérience Utilisateur
- **Navigation intuitive** : Menu fixe avec icons
- **Feedback visuel** : Notifications, états de chargement
- **Accessibilité** : Contrastes respectés, semantic HTML
- **Performance** : Animations 60fps, lazy loading

## 🔧 Architecture et Bonnes Pratiques

### Code Quality
- **DRY** : Helpers réutilisables, partials
- **SOLID** : Responsabilités séparées
- **Conventions Rails** : Structure standardisée
- **Validations** : Sécurité et intégrité des données

### Sécurité
- **CSRF Protection** : Tokens automatiques
- **Strong Parameters** : Paramètres filtrés
- **SQL Injection** : ActiveRecord sécurisé
- **XSS Protection** : Échappement automatique

## 🚀 Déploiement

### Environnements
- **Development** : Configuration locale
- **Production** : Prêt pour Heroku, Docker
- **Docker** : Dockerfile inclus
- **Assets** : Precompilation automatique

### Variables d'environnement
```bash
RAILS_ENV=production
DATABASE_URL=mysql2://user:pass@host:port/db
RAILS_MASTER_KEY=your_master_key
```

## 🤝 Contribution

Ce projet respecte exactement les consignes du défi technique :
- Architecture Rails robuste
- Fonctionnalités métier complètes
- Interface utilisateur moderne
- Code maintenable et extensible

## 📝 Licence

Projet développé dans le cadre d'un défi technique Rails.

---

**Développé avec ❤️ pour les vrais guerriers de l'arène !** ⚔️🏆
