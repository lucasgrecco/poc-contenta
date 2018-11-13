# POC Contenta

## Instalação
A instalação requer um stack básico de APACHE, PHP e MYSQL.
Tudo que não for padrão na instalação do LAMP será exemplificado aqui.

### Requisitos
#### 1. PHP 7.0+

#####Extensões
    
    1. OP Cache
    2. Curl
    3. GD
    4. Imap
    5. INTL
    6. Json
    7. Mbstring
    8. Mcrypt
    
#### 2. Apache 2.4
    
##### Módulos do Apache
    1. Mod Rewrite
    2. Proxy
    
##### Configuração do Vhost
           
       <VirtualHost *:80>
        #URL que deseja utilizar para acessar o projeto
        ServerName contenta.local
       
        ServerAdmin webmaster@localhost
        #Diretório onde se encontra a aplicação
        DocumentRoot /home/grecco/projects/php/contenta/web
        #Configurações do diretório
        <Directory /home/grecco/projects/php/contenta/web>
            Options Indexes FollowSymLinks MultiViews
            Order allow,deny
            Allow from all
            AllowOverride all
        </Directory>
        
        #Apontamento dos logs de acesso e erros
        ErrorLog /home/grecco/projects/php/contenta-error.log
        CustomLog /home/grecco/projects/php/contenta-access.log combined
       
       </VirtualHost>

#### 3. Composer

[Como instalar o Composer!](https://getcomposer.org/doc/00-intro.md)

