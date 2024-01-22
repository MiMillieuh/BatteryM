#!/bin/bash

if [[ "$USER" != "root" ]]; then
    echo "Error: script not running as root or with sudo! Exiting..."
    exit 1
fi

cp systemd/batterym.service /etc/systemd/system/

cp -r batterym /opt

mkdir -p /opt/batterym/onbatteryscripts
mkdir -p /opt/batterym/plugedincripts

systemctl enable --now batterym.service

echo "batterym install done"
