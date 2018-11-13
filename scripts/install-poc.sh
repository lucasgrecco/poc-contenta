#!/usr/bin/env bash

echo Insira a senha do usuário root
echo Permissões ao diretório atualizadas
chmod 777 -Rf /web
echo Copiando o settings padrão
cp /home/grecco/projects/php/contenta/web/sites/default/settings.default.php /home/grecco/projects/php/contenta/web/sites/default/settings.local.php

echo Insira as credenciais do seu DB.
echo ""
read -p "Ip do MySQL " hostvar
echo ""
read -p "Nome do banco: " dbnamevar
echo ""
read -p "Username: " uservar
echo ""
read -sp "Password: " passvar
echo ""
#echo $uservar
#echo $passvar
#echo $dbnamevar

echo "Dropando banco com nome ${dbnamevar}"
echo ""
mysql -u$uservar -p$passvar -e "drop database ${dbnamevar}"

echo "Criando banco com nome ${dbnamevar}"
echo ""
mysql -u$uservar -p$passvar -e "create database ${dbnamevar}"

echo  'Importando o banco'
echo ""
mysql -u$uservar -p$passvar $dbnamevar < ./contenta.sql

echo  'Atualizando o arquivo settings.local.php'
echo ""
echo "\$databases['default']['default'] = array (
  'database' => '${dbnamevar}',
  'username' => '${uservar}',
  'password' => '${passvar}',
  'prefix' => '',
  'host' => 'localhost',
  'port' => '3306',
  'namespace' => 'Drupal\\Core\\Database\\Driver\\mysql',
  'driver' => 'mysql',
);
\$config_directories['sync'] = 'profiles/contrib/contenta_jsonapi/config/sync';" >> /home/grecco/projects/php/contenta/web/sites/default/settings.local.php

echo 'Instalando dependencias do composer.'
echo  'Importando o banco'
echo ""
cd ../
composer install