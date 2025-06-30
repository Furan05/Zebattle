# Défi Technique

## Stack pour le défi :

- Rails 7 ou plus
- Maria DB
- VS code

## Notions

- Créer des table dans une bdd (migration)
- Model avec des conditions de validation
- Les Controller et leurs actions
- Créer des View avec un formulaire
- Routing (Resources, Collection, Member)
- Table relationnel (Belongs to, Has many)
- Request basic en bdd
- Créer des Helper

## Descriptions

Le but de cet exercice est de connaitre l'étendu des connaissances et la capacité d’adaptation du participant

Vous devez créer une interface web permettant de créer X équipes composé de 11 joueurs.
Chaque joueur dispose d'un nom, et d'un poste sur le terrain.

Lors d'un match deux équipent complètes précédemment créées s'affrontent. Un nombre de kill aléatoire (entre 0 et 5) est marqué par chacune des équipes.

Un tournois se déroule entre 8 équipes. Chaque équipe ne rencontre qu'une seule fois une autre équipe.
Une victoire donne 3 points, un match nul 1 point et une défaite 0 point.

Un classement final sera attendu sous cette forme :

| Equipe | Points | kill reçu | kill marqués |
| --- | --- | --- | --- |
| nom_equipe1 | 19 | 12 | 33 |
| nom_equipe3 | 15 | 22 | 23 |
| nom_equipe2 | 5 | 40 | 10 |

## La base (50 %)

### Première étape : Créer une équipe (Niveau Basic)

- [ ]  L'équipe doit disposer d'un nom. (Nombre de caractère maximum 50)
- [ ]  L'équipe doit disposer d'une ville.
- [ ]  Le routing est correct.
- [ ]  Le model est correct.
- [ ]  Le controller est correct.

### Deuxième étape : Créer les joueurs (Niveau Basic)

- [ ]  Un joueur doit avoir un nom
- [ ]  Un joueur doit avoir un poste (Heal/Tank/DPS)
- [ ]  Le poste est selectable dans un dropdown (liste déroulante)

### Troisième étape : Affecter des joueurs à une équipe (Niveau intermédiaire)

- [ ]  Un dropdown permet de sélectionner une équipe précédemment créer dans lequel intégrer le joueur
- [ ]  11 *joueurs maximum par équipe*

### Quatrième étape : Le tournois (Niveau confirmé)

- [ ]  Un bouton permet de créer et peupler automatiquement 8 équipes de 11 joueurs
- [ ]  Chaque équipe affronte une seule et unique fois une autre équipe (Attribué un score aléatoire suffit)
- [ ]  Le résultat des matchs est afficher correctement (Voir Tableau ci-dessus pour la méthode de calcul)

### Dockerisé le projet

- [ ] Créer un docker pour faire tourner votre projet

### Apporter vos idées pour donner de la valeur au projet (50 %)

_Le but étant de montrer ce que vous êtes capable_
_Notre objectif et d'engager des personnes qui savent être force de propposition_
