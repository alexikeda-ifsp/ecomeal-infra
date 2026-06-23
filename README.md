# EcoMeal

## Infraestrutura do projeto EcoMeal utilizando:

- Vagrant para provisionamento da VM
- Ansible para configuração automática do servidor
- Docker / Docker Compose para execução dos serviços
- Microsserviços em FastAPI
- Front-end Flutter Web
- PostgreSQL
- RabbitMQ

---

## Arquitetura

Serviços executados:

| Serviço | Tecnologia | Porta |
|---|---|---|
| Frontend | Flutter Web + Nginx | 80 |
| Paciente API | FastAPI | 8002 |
| Plano Alimentar API | FastAPI | 8000 |
| Refeições API | FastAPI | 8003 |
| Recomendação API | FastAPI | 8001 |
| PostgreSQL | Banco de dados | 5432 |
| RabbitMQ | Mensageria | 5672 / 15672 |

---

## Pré-requisitos

Instalar:

- VirtualBox
- Vagrant
- Git

Verificar instalações:

```bash
vagrant --version
````

```bash
docker --version
```

---

# Executando o projeto

## 1. Clonar este repositório

```bash
git clone https://github.com/alexikeda-ifsp/ecomeal-infra.git
```

Entrar na pasta:

```bash
cd ecomeal-infra
```

---

## 2. Subir a máquina virtual

Execute:

```bash
vagrant up
```

O Vagrant irá:

* Criar a VM Ubuntu
* Instalar Docker
* Instalar Docker Compose
* Clonar os microsserviços
* Criar variáveis de ambiente
* Subir todos os containers

---

## 3. Acessar o ambiente

Para acessar o ambiente, basta digitar o endereço abaixo em seu navegador:

```
http://192.168.56.10/
```

---

# Acessar a VM

No diretório "ecomeal-infra", execute o comando para acessar a máquina virtual:

```bash
vagrant ssh
```

Entrar no workspace:

```bash
cd ~/ecomeal-workspace
```

---

# Executando manualmente os containers

Caso precise reconstruir o ambiente:

Parar containers:

```bash
docker compose down
```

Construir imagens:

```bash
docker compose build --no-cache
```

Subir ambiente:

```bash
docker compose up -d
```

---

# Verificar serviços

Listar containers:

```bash
docker ps
```

Resultado esperado:

```
frontend
paciente-service
planoalimentar-service
refeicoes-service
recomendacao-service
postgres
rabbitmq
```

---

# Acesso ao sistema

Com a VM iniciada:

Frontend:

```
http://192.168.56.10/
```

APIs:

Paciente:

```
http://192.168.56.10:8002
```

Plano alimentar:

```
http://192.168.56.10:8000
```

Refeições:

```
http://192.168.56.10:8003
```

Recomendação:

```
http://192.168.56.10:8001
```

Documentação Swagger:

Exemplo:

```
http://192.168.56.10:8002/docs
```

---

# RabbitMQ

Painel administrativo:

```
http://192.168.56.10:15672
```

Credenciais:

```
Usuário:
definido no arquivo .env

Senha:
definida no arquivo .env
```

---

# Banco de dados

PostgreSQL:

Host:

```
postgres
```

Porta:

```
5432
```

Banco:

```
ecomeal_paciente
ecomeal_planoalimentar
ecomeal_recomendacao
```

---

# Estrutura do projeto

```
ecomeal-infra
│
├── ansible
│   └── playbook.yml
│
├── config
│   └── .env.example
│
├── postgres
│   └── init.sql
│
├── docker-compose.yml
│
├── Vagrantfile
│
└── Serviços clonados na VM
    │
    ├── ecomeal-frontend
    │
    ├── ecomeal-paciente-service
    │   └── paciente-api
    │
    ├── ecomeal-planoalimentar-service
    │   ├── plano-alimentar-api
    │   └── refeicoes-api
    │
    └── ecomeal-recomendacao-service
        └── sugestoes-api
```

---

# Atualizando código dos serviços

O provisionamento utiliza:

```yaml
update: yes
force: yes
```

Portanto, para atualizar os serviços:

```bash
vagrant provision
```

Depois:

```bash
vagrant ssh
```

E:

```bash
cd ~/ecomeal-workspace

docker compose up -d --build
```

---

# Parando o ambiente

Na VM:

```bash
cd ~/ecomeal-workspace

docker compose down
```

Desligar VM:

```bash
exit

vagrant halt
```

---

# Remover ambiente completo

Caso precise recriar do zero:

```bash
vagrant destroy -f
```

Depois:

```bash
vagrant up
```

---

# Troubleshooting

Ver containers parados:

```bash
docker ps -a
```

Ver logs:

```bash
docker logs nome-do-container
```

Reconstruir tudo:

```bash
docker compose down

docker compose build --no-cache

docker compose up -d
```

---

## Status esperado

Ao final todos os serviços devem estar:

```
✔ frontend
✔ paciente-service
✔ planoalimentar-service
✔ refeicoes-service
✔ recomendacao-service
✔ postgres
✔ rabbitmq
```

O ambiente estará disponível em:

```
http://192.168.56.10/
```
