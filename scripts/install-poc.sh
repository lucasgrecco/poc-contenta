#!/usr/bin/env bash

echo "                                                                                "
echo "                                                                                "
echo " ##:  :##    :##:     ######"
echo " ##    ##     ##      ######"
echo " :##  ##:    ####       ##"
echo " :##  ##:    ####       ##"
echo "  ## .##    :#  #:      ##"
echo "  ##::##     #::#       ##"
echo "  ##::##    ##  ##      ##"
echo "  :####:    ######      ##"
echo "  .####.   .######.     ##"
echo "   ####    :##  ##:     ##"
echo "   ####    ###  ###   ######"
echo "    ##     ##:  :##   ######"
echo "                                                                                "
echo "                                                                                "
echo "                                                                                "
echo "                              ##################################################"
echo "                                                                                "
echo "                                                                                "
echo "                                                                                "
echo "   :####:   .####.   ###  ###  ########    :####:    :##:    ######:      ##"
echo "   ######   ######   ###  ###  ########    ######     ##     #######      ##"
echo " :##:  .#  :##  ##:  ###::###  ##        :##:  .#    ####    ##   :##     ##"
echo " ##        ##:  :##  ###  ###  ##        ##          ####    ##    ##     ##"
echo " ##.       ##    ##  ## ## ##  ##        ##.        :#  #:   ##   :##     ##"
echo " ##        ##    ##  ##:##:##  #######   ##          #::#    #######:     ##"
echo " ##        ##    ##  ##.##.##  #######   ##         ##  ##   ######       ##"
echo " ##.       ##    ##  ## ## ##  ##        ##.        ######   ##   ##.     ##"
echo " ##        ##:  :##  ##    ##  ##        ##        .######.  ##   ##"
echo " :##:  .#  :##  ##:  ##    ##  ##        :##:  .#  :##  ##:  ##   :##"
echo "   ######   ######   ##    ##  ########    ######  ###  ###  ##    ##:    ##"
echo "   :####:   .####.   ##    ##  ########    :####:  ##:  :##  ##    ###    ##"
echo "                                              :"
echo "                                             .#"
echo "                                            ##"
echo "                                                                                "
echo ""

function erroMysql() {
    if [[ "$RESULT" -eq 1 ]]
    then
        echo "Algo deu errado durante a importação de sua base. Verifique se as informações passadas estão corretas e tente novamente!"
        exit 1
    fi
}


echo ""
echo Dando permissões ao diretório. Insira sua senha.
sudo chmod 777 -Rf ../

COMPOSER_DIR="$(which composer)"
WGET_DIR="$(which wget)"
PHP_DIR="$(which wget)"
MYSQL_DIR="$(which wget)"

if [ -z "$WGET_DIR" ]
then
    echo "Parece que o WGET não está instalado. Instale o WGET e tente novamente."
    exit 1
fi

if [ -z "$PHP_DIR" ]
then
    echo "Parece que o PHP não está instalado. Instale o PHP e tente novamente."
    exit 1
fi

if [ -z "$MYSQL_DIR" ]
then
    echo "Parece que o Mysql/MariaDB não está instalado. Instale o Mysql ou o MariaDB e tente novamente."
    exit 1
fi

if [ -z "$COMPOSER_DIR" ]
then
    echo -e "Não encontrei o composer instalado. Vou instalar, perai!"
    EXPECTED_SIGNATURE="$(wget -q -O - https://composer.github.io/installer.sig)"
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    ACTUAL_SIGNATURE="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

    if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
    then
        >&2 echo 'ERROR: Invalid installer signature'
        rm composer-setup.php
        exit 1
    fi

    php composer-setup.php #--quiet
    RESULT=$?
    rm composer-setup.php
    sudo mv composer.phar /usr/local/bin/composer
#    echo $RESULT
    if [[ "$RESULT" -eq 0 ]]
    then
        echo "Algo deu errado! Tente instalar manualmente: https://getcomposer.org/doc/00-intro.md#installation-linux-unix-macos"
        exit 1
    fi
fi

#exit
echo Copiando o settings padrão
cp ../web/sites/default/settings.default.php ../web/sites/default/settings.local.php

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

if [[ -z $dbnamevar || -z $hostvar || -z $passvar || -z $uservar ]]
then
    echo "Você precisa preencher as informações de acesso ao MySQL"
    exit 1
fi

echo "Dropando banco com nome ${dbnamevar}"
echo ""
mysql -u$uservar -p$passvar -e "drop database ${dbnamevar}"
RESULT=$?
#erroMysql

echo "Criando banco com nome ${dbnamevar}"
echo ""
mysql -u$uservar -p$passvar -e "create database ${dbnamevar}"
RESULT=$?
erroMysql

echo  'Importando o banco'
echo ""
mysql -u$uservar -p$passvar $dbnamevar < ./contenta.sql
RESULT=$?
erroMysql

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
\$config_directories['sync'] = 'profiles/contrib/contenta_jsonapi/config/sync';" >> ../web/sites/default/settings.local.php

echo 'Instalando dependencias do composer.'
echo  'Importando o banco'
echo ""
cd ../
composer install

echo "                                        "
echo " ########   .####.    ######      ##"
echo " ########   ######    ######      ##"
echo " ##        :##  ##:     ##        ##"
echo " ##        ##:  :##     ##        ##"
echo " ##        ##    ##     ##        ##"
echo " #######   ##    ##     ##        ##"
echo " #######   ##    ##     ##        ##"
echo " ##        ##    ##     ##        ##"
echo " ##        ##:  :##     ##"
echo " ##        :##  ##:     ##"
echo " ##         ######    ######      ##"
echo " ##         .####.    ######      ##"