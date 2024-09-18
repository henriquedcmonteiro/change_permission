<h1> Utilizando um serviço para monitoramento e alteração de permissão constante.</h1>

Este dois arquivos fazem a função de checar arquivos existentes e também novos arquivos a receberem as permissões passadas que desejar, tanto de chown quanto de chmod, podendo ser um complemento quando setfacl não consegue atender a todos os requisitos.

É um script simples em shell script com inotifywait e um arquivo .service que vai iniciar o serviço utilizando o shell script.

Antes de tudo, é necessário instalar a ferramenta inotifywait.

#Sistemas baseados em debian

    sudo apt install inotify-tools -y 

#Sistemas baseados em red hat

    sudo yum install inotify-tools -y

O arquivo .sh deve ser colocado no diretório /usr/local/bin/ e o arquivo .service no diretório /etc/systemd/system/

Também deixe o .sh executavel

    sudo chmod +x /usr/local/bin/alterar_permissao.sh

Por último iniciar o serviço e deixar ele enabled para que se inicie sempre com o sistema

    sudo systemctl start alterar_permissao.service

    sudo systemctl enable alterar_permissao.service
