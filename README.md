# Inception - Infrastructure Docker sécurisée (42)

Projet d'infrastructure système réalisé dans le cadre du cursus 42 Paris.
Projet réalisé par 500de42/Kalvin.

Objectif: concevoir et déployer une stack web complète en conteneurs Docker, sans images prêtes à l'emploi, avec une approche orientée sécurité, isolation des services et persistance des données.

Ce dépôt met en avant ma capacité à:
- architecturer un système multi-services en environnement Linux
- automatiser un déploiement reproductible avec Docker Compose
- manipuler des secrets, des volumes bindés et des réseaux isolés
- intégrer des services bonus utiles en production (cache, monitoring, FTP, administration DB)

## Sommaire

- [Vue d'ensemble](#vue-densemble)
- [Architecture](#architecture)
- [Stack technique](#stack-technique)
- [Fonctionnalités](#fonctionnalités)
- [Arborescence du projet](#arborescence-du-projet)
- [Prérequis](#prérequis)
- [Configuration](#configuration)
- [Lancement rapide](#lancement-rapide)
- [Accès aux services](#accès-aux-services)
- [Commandes Make](#commandes-make)
- [Compétences démontrées](#compétences-démontrées)

## Vue d'ensemble

La plateforme repose sur:
- NGINX en reverse proxy TLS (port 443)
- WordPress avec PHP-FPM
- MariaDB pour la persistance applicative

Services bonus:
- Redis pour le cache WordPress
- FTP en lecture seule pour consulter les fichiers WordPress
- Adminer pour l'administration de base de données
- Site statique servi par un micro serveur HTTP
- Netdata pour le monitoring du runtime Docker

Toutes les briques communiquent via un réseau Docker dédié, avec des volumes persistants montés sur l'hôte.

## Architecture

Flux principal:

1. Le client accède à NGINX en HTTPS sur le port 443.
2. NGINX transmet les requêtes PHP à WordPress (PHP-FPM:9000).
3. WordPress interroge MariaDB et exploite Redis pour le cache.
4. NGINX reverse-proxy aussi:
	 - /static/ vers le service site statique
	 - /netdata/ vers Netdata

Ressources persistantes:
- Données MariaDB: /home/kcharbon/data/wordpressDB
- Données WordPress: /home/kcharbon/data/wordpressData
- Données Redis: /home/kcharbon/data/redis
- Données Netdata: /home/kcharbon/data/netdata

## Stack technique

- OS de base des conteneurs: Alpine Linux 3.21
- Orchestration: Docker Compose
- Front web: NGINX + TLS autosigné
- Back office CMS: WordPress + PHP 8.2 (FPM)
- Base de données: MariaDB
- Cache: Redis
- Monitoring: Netdata
- Administration DB: Adminer
- Automatisation locale: Makefile

## Fonctionnalités

- Déploiement complet via une seule commande Make.
- Isolation réseau des services via bridge dédié.
- Persistance des données grâce aux volumes bindés sur l'hôte.
- Injection de secrets via Docker secrets (mots de passe DB, WP, FTP).
- Provisioning automatisé:
	- initialisation SQL MariaDB
	- installation WordPress via WP-CLI
	- création d'un compte admin et d'un second utilisateur
	- activation du cache Redis côté WordPress
- Monitoring et observabilité avec Netdata.

## Arborescence du projet

Le projet est structuré autour:
- srcs/docker-compose.yml: définition des services, secrets, volumes, réseau
- srcs/requierements/: Dockerfiles et configurations de chaque service
- secrets/: fichiers de secrets montés dans les conteneurs
- Makefile: commandes de build, run et nettoyage

## Prérequis

- Linux
- Docker Engine
- Docker Compose plugin
- Make
- Accès root/sudo pour gérer Docker et, si nécessaire, le fichier hosts

## Configuration

### 1) Variables d'environnement

Le fichier srcs/.env définit les variables nécessaires (utilisateurs, base, domaine, emails, etc.).

Variables principales attendues:
- MARIADB_USER
- MARIADB_USER2
- MARIADB_DATABASE
- DOMAIN_NAME
- USER_WP
- USER_WP2
- WP_ADMIN_EMAIL
- WP_ADMIN_EMAIL2

### 2) Secrets

Les mots de passe sont lus depuis des fichiers montés via Docker secrets:
- secrets/db_password.txt
- secrets/db_password2.txt
- secrets/mariadb_root_password.txt
- secrets/wp_password.txt
- secrets/wp_password2.txt
- secrets/ftp_password.txt

Remarque : pour faciliter l'exécution locale de ce projet scolaire, le dépôt contient les fichiers `secrets/` et `srcs/.env` avec les mots de passe et la configuration — ils ont été push volontairement pour permettre d'exécuter le projet immédiatement.

### 3) Résolution DNS locale

Le serveur NGINX est configuré pour le domaine:
- kcharbon.42.fr

Ajouter une entrée locale si nécessaire:

127.0.0.1 kcharbon.42.fr

## Lancement rapide

Depuis la racine du projet:

1. Vérifier que Docker est actif.
2. Vérifier le contenu de srcs/.env et des fichiers dans secrets/.
3. Lancer:

make up

Le premier démarrage peut prendre un peu de temps (build des images + provisioning).

## Accès aux services

- Application principale: https://kcharbon.42.fr
- Site statique: https://kcharbon.42.fr/static/
- Monitoring Netdata: https://kcharbon.42.fr/netdata/
- Adminer (si présent dans le volume WordPress): https://kcharbon.42.fr/adminer/

Note: selon la configuration locale, l'accès peut nécessiter d'accepter le certificat autosigné.

## Commandes Make

- make up: build et lancement des services
- make down: arrêt des services
- make downv: arrêt + suppression des volumes Compose
- make build: build des images
- make clean: prune Docker (images/containers/réseaux non utilisés)
- make fclean: prune Docker + volumes
- make re: nettoyage complet puis rebuild + relance

## Compétences démontrées

- Conteneurisation avancée de services web et système
- Conception d'une architecture réseau Docker multi-conteneurs
- Gestion de secrets et bonnes pratiques d'isolation
- Automatisation d'installation applicative (scripts shell, WP-CLI, SQL)
- Intégration de services transverses (cache, monitoring, administration)
- Diagnostic d'environnement Linux et exploitation des logs runtime
