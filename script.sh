#!/bin/bash

# Vérification des droits d'administration
if [[ $EUID -ne 0 ]]; then
    echo "Ce script doit être exécuté en tant que root (ou avec les droits d'administration)." 
    exit 1
fi

# Installation de snmpd
apt update
apt install -y snmpd

# Configuration de snmpd.conf
snmpd_conf="/etc/snmp/snmpd.conf"

# Vider le fichier snmpd.conf s'il existe
if [[ -f $snmpd_conf ]]; then
    > "$snmpd_conf"
fi

# Ajout des lignes au fichier snmpd.conf
cat << EOF >> "$snmpd_conf"
rocommunity lab 10.0.6.15
    syslocation Strasbourg/Europe
    syscontact contact@leskientz.ovh
EOF

# Redémarrage du service snmpd pour appliquer les changements
systemctl restart snmpd

echo "Le service snmpd a été installé et configuré avec succès."
