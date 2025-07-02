#!/bin/bash

set -e

echo "🐳 Démarrage de Groudonbattle avec Docker..."

# Vérifier que Docker est installé
if ! command -v docker &> /dev/null; then
    echo "❌ Docker n'est pas installé. Veuillez l'installer d'abord."
    exit 1
fi

# Vérifier que Docker fonctionne
if ! docker ps &> /dev/null; then
    echo "❌ Docker n'est pas démarré. Veuillez lancer Docker Desktop."
    exit 1
fi

# Créer le fichier .env s'il n'existe pas
if [ ! -f .env ]; then
    echo "📝 Création du fichier .env..."
    cp .env.example .env
    echo "⚠️  Pensez à éditer le fichier .env avec vos propres valeurs !"
fi

# Construire et démarrer les services
echo "🔨 Construction des images Docker..."
docker compose build

echo "🚀 Démarrage des services..."
docker compose up -d

# Attendre que la base de données soit prête
echo "⏳ Attente de la base de données..."
sleep 10

echo ""
echo "✅ Groudonbattle est maintenant disponible !"
echo "🌐 Application: http://localhost:3000"
echo ""
echo "📋 Commandes utiles :"
echo "   docker compose logs -f     # Voir les logs"
echo "   docker compose down        # Arrêter l'application"
echo "   docker compose restart web # Redémarrer l'app"
