# POC Contenta
A POC consiste em alguns tipos de conteúdo com diversos conteúdos criados.
Para essa POC foi utilizado o padrão [JsonAPI](https://jsonapi.org/). É importante entender esse padrão, pois inicialmente pode parecer que algumas operações são mais complexas do que elas realmente são.


1. Instalação
  * 1.1 Requisitos
      * 1.1.1 PHP
      * 1.1.2 Apache
  * 1.2 Script de instalação
2. Projeto Postman

## 1. Instalação
A instalação requer um stack básico de APACHE, PHP e MYSQL.
Tudo que não for padrão na instalação do LAMP será exemplificado aqui.

### 1.1 Requisitos
#### 1.1.1 PHP 7.0+

#####Extensões
  
   1. OP Cache
   2. Curl
   3. GD
   4. Imap
   5. INTL
   6. Json
   7. Mbstring
   8. Mcrypt
  
#### 1.1.2 Apache 2.4
  
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
     
Após configurar o vhost, não se esqueça de adicionar o "contenta.local" ao seu arquivo de host.
No linux/mac o arquivo fica em **/etc/hosts**
#### Composer

Caso não tenha instalado em sua máquina, o script de instalação da POC pode fazer isso.
Mas caso queira instalar manualmente:

[Como instalar o Composer!](https://getcomposer.org/doc/00-intro.md)



### 1.2 Script de Instalação

O script de instalação se encontra no diretório scripts, localizado na raíz do projeto. O nome do script é **install-poc.sh**.
Durante a instalação o script valida as dependências do projeto, como PHP, MySQL, Composer, etc.

É fundamental que minimamente o PHP, Apache e Mysql estejam configurados.


Para iniciar a instalação, acesse o diretório de scripts através de seu bash (linha de comando) **execute:**
          
           sh ./install-poc.sh

Ao longo da instalação sua senha pode ser requisitada. A primeira delas é logo que executar o script, ele pede sua senha para dar permissão aos diretórios do projeto.
A segunda vez é na instalação do composer.

## 2. Projeto do Postman

Dentro do diretório postman_project está o JSON com o projeto do Postman.
La existem exemplos de como receber, inserir, filtrar, limitar os resultado, etc trazidos das APIs.


## 3. Credenciais

Se você seguiu a risca meu exemplo de instalação, o acesso da administração do Drupal s encontra em:

http://contenta.local/user/login

       User: admin
       Pass: admin

@TODO AJUSTAR PERMISSOES DAS CHAVES DE AUTH