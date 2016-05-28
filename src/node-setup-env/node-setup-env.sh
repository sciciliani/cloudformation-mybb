#!/bin/bash

WWW_DIR=/var/www/html
INST_DIR=/tmp/setup

echo "Parameters: Admin Email: $ADMIN_EMAIL - Forum Web Url: $FORUM_WEB_URL - DB Name: $DATABASE_NAME - DB User: $DATABASE_USER - DB PW: $DATABASE_PASSWORD - DB Server: $DATABASE_MASTER_HOST - DB Rep1: $DATABASE_READ_HOST - DB Rep2: $DATABASE_READ_HOST_2 - Memcached Server: $MEMCACHE_MASTER_HOST - Memcached Port: $MEMCACHE_MASTER_PORT" >> /tmp/log-node-setup.log

echo "=========== INITIATING INSTALLATION ============"

mkdir -p ${INST_DIR}
cd ${INST_DIR}

unzip -o mybb_1807.zip
mv Upload/* $WWW_DIR

tar -xvzf cache.tgz
rm -rf $WWW_DIR/cache
mv cache $WWW_DIR

sed -e "s/DATABASE_NAME/${DATABASE_NAME}/g" \
    -e "s/DATABASE_USER/${DATABASE_USER}/g" \
    -e "s/DATABASE_PASSWORD/${DATABASE_PASSWORD}/g" \
    -e "s/DATABASE_MASTER_HOST/${DATABASE_MASTER_HOST}/g" \
    -e "s/DATABASE_READ_HOST_2/${DATABASE_READ_HOST_2}/g" \
    -e "s/DATABASE_READ_HOST/${DATABASE_READ_HOST}/g" \
    -e "s/MEMCACHE_MASTER_HOST/${MEMCACHE_MASTER_HOST}/g" \
    -e "s/MEMCACHE_MASTER_PORT/${MEMCACHE_MASTER_PORT}/g" \
    config.php > $WWW_DIR/inc/config.php

sed -e "s/ADMIN_EMAIL/${ADMIN_EMAIL}/g" \
    -e "s/FORUM_WEB_URL/${FORUM_WEB_URL}/g" \
    settings.php > $WWW_DIR/inc/settings.php

echo `hostname` > $WWW_DIR/hb.html
touch $WWW_DIR/install/lock

chown -R apache.apache $WWW_DIR

echo "=========== INSTALLATION COMPLETE ============"


