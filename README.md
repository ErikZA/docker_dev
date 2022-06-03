# FARM-SYSTEM - Ambiente de desenvolvimento

Este pacote agrupa os scripts para execução dos serviços da FARM-SYSTEM e de terceiros, que são requisitos para execução.

## Executando serviços

### Serviços essenciais

Executando os serviços:

```shell
docker-compose -f config-essential-1.yml up -d
# aguardar o postgres responder no log, que está pronto para receber conexões
docker-compose -f config-essential-2.yml up -d
```

Parando os serviços:

```shell
docker-compose -f config-essential-2.yml down --remove-orphans
```

### Serviços FARM-SYSTEM

Serviços de autenticação, relatorios, etc.

Executando os serviços:

```shell
# aguardar o keycloak estar disponivel
docker-compose -f config-farm-system.yml up -d
```

Parando os serviços:

```shell
docker-compose -f config-farm-system.yml down
```

- Endereços para acessar os serviços de gerenciamento:
  - RabbitMQ Management: http://localhost:15672
  - Postgres pgAdmin : http://localhost:16549
    - no primeiro acesso será necessário adicionar um novo servidor ao pgadmin, seguir as orientações do próximo item
    - dentro do pgadmin, clicar com o botão direito em servers (à esquerda) > create > server
    - informar um nome, exemplo: Farm
    - na aba Connection, informar:
      - host name: postgres
      - user name: postgres
      - password: postgres
    - clicar em salvar
    - se aparecer mensagem informando que não foi possível conectar, verificar as seguintes configurações
      - garantir que o pgadmin e o postgres dentro do docker estão em execução usando o comando docker stats
      - verificar o hostname, POSTGRES_USER e POSTGRES_PASSWORD no service postgres do arquivo config-essential-1.yml
      - usar esses valores na configuração de conexão com o banco de dados

## Comandos uteis

Verificar status de cada serviço além de irformações do id da imagem e outros:

```shell
docker ps -a
```

### Limpeza

Remoção de todos os objetos do docker que perderam a referencia:

```shell
docker system prune -f
```

## Solução de problemas

1. Keycloak reiniciando constantemente

   - Caso o keykloak entre em loop reiniciando, a causa mais comum é a conexão com o postgres não ter sido estabelecida. Isso acontece se o keykloak for iniciado enquanto o postgres ainda não terminou de incializar. Reiniciar o keykloak e garantir que o postgres esta aceitando conexões geralmente resolve.

2. Caso você tenha erro em algum serviço que foi executado você deve:

   - Executar o comando 'docker ps -a' verificar o id do serviço com erro e exclui-lo (docker rm id).
   - Executar o comando 'docker ps -a' verificar o nome da imagem do serviço com erro e exclui-lo (docker rmi name).
   - Após executa esses passos, basta descobrir qual o erro e executar novamente o comando que da o up neste serviço.

3. Primeira execução do config-monitor.yml apresenta erros de permissão em diretorios no pgadmin
   - O serviço do pgadmin mapeia um volume para o diretorio local, para que as conexões com servidor que forem configuradas não sejam perdidas ao reiniciar o pgadmin.
   - A pasta do volume só é criada localmente apos a primeira execução e precisa ter um dono específico, de id 5050.
   - Se o erro abaixo for o que voce encontrar:
   - ![Erro pgadmin](./readme-assets/pgadmin-error.png)
   - A solução, usando linux, é a seguinte:
   - Estando no diretorio raiz deste projeto, execute o seguinte comando: `sudo chown -R 5050:5050 ./data/pgadmin && sudo chmod -R 777 ./data/pgadmin` e reinicie o compose config-monitor.yml.
   - Se voce utiliza windows, a solução mais facil é comentar a configuração de volumes do serviço do pgadmin no config-monitor.yml.

## TODO's

- [ ] Documentar o resto deste script de ambiente
- [ ] Corrigir os scripts de compilação e pull
- [ ] Criar variaveis padroes para volumes, portas etc
- [ ] Criar template de arquivo .env > https://docs.docker.com/compose/compose-file/#variable-substitution
- [ ] Criar logger padrao > https://docs.docker.com/compose/compose-file/#extension-fields
