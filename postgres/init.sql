-- =====================================================
-- EcoMeal - Database Initialization
-- PostgreSQL 16
-- Microsserviços
-- =====================================================


-- =====================================================
-- CRIAÇÃO DOS DATABASES
-- =====================================================

CREATE DATABASE ecomeal_paciente;
CREATE DATABASE ecomeal_planoalimentar;
CREATE DATABASE ecomeal_refeicoes;
CREATE DATABASE ecomeal_recomendacao;



-- =====================================================
-- BANCO PACIENTE
-- =====================================================

\connect ecomeal_paciente


CREATE EXTENSION IF NOT EXISTS "pgcrypto";


CREATE TABLE paciente (

    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    nome VARCHAR(150) NOT NULL,

    email VARCHAR(255) UNIQUE NOT NULL,

    idade INTEGER,

    data_nascimento DATE,

    altura DECIMAL,

    peso DECIMAL,

    estado VARCHAR(150),

    cidade VARCHAR(150),

    imc DECIMAL,

    objetivo VARCHAR(100),

    data_cadastro TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);



INSERT INTO paciente
(
nome,
email,
idade,
data_nascimento,
altura,
peso,
imc,
objetivo,
estado,
cidade
)
VALUES

(
'João Pedro Almeida',
'joao.almeida@ecomeal.com',
28,
'1998-03-10',
1.78,
92,
29,
'Emagrecimento',
'São Paulo',
'Campinas'
),

(
'Maria Eduarda Souza',
'maria.souza@ecomeal.com',
31,
'1995-07-22',
1.62,
58,
22.1,
'Ganho de massa muscular',
'Rio de Janeiro',
'Niterói'
),

(
'Carlos Henrique Lima',
'carlos.lima@ecomeal.com',
35,
'1991-11-08',
1.80,
84,
25.9,
'Reeducação alimentar',
'Minas Gerais',
'Belo Horizonte'
),

(
'Ana Clara Ferreira',
'ana.ferreira@ecomeal.com',
26,
'2000-01-18',
1.68,
55,
19.5,
'Ganho de massa muscular',
'Paraná',
'Curitiba'
),

(
'Rafael Martins Rocha',
'rafael.rocha@ecomeal.com',
40,
'1986-09-30',
1.75,
105,
34.3,
'Emagrecimento',
'Bahia',
'Salvador'
);





-- =====================================================
-- BANCO PLANO ALIMENTAR
-- =====================================================


\connect ecomeal_planoalimentar


CREATE EXTENSION IF NOT EXISTS "pgcrypto";


CREATE TABLE plano_alimentar
(

    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    paciente_id UUID NOT NULL,

    objetivo TEXT NOT NULL,

    data_criacao TIMESTAMP WITH TIME ZONE DEFAULT NOW(),

    data_atualizacao TIMESTAMP WITH TIME ZONE DEFAULT NOW()

);



INSERT INTO plano_alimentar
(
paciente_id,
objetivo
)
VALUES
(
'00000000-0000-0000-0000-000000000001',
'Emagrecimento'
),

(
'00000000-0000-0000-0000-000000000002',
'Ganho de massa muscular'
),

(
'00000000-0000-0000-0000-000000000003',
'Reeducação alimentar'
);





-- =====================================================
-- BANCO REFEIÇÕES
-- =====================================================


\connect ecomeal_refeicoes


CREATE EXTENSION IF NOT EXISTS "pgcrypto";


CREATE TABLE refeicao
(

id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

plano_id UUID NOT NULL,


tipo_refeicao VARCHAR(50) NOT NULL,


proteina VARCHAR(100),
qtd_p DECIMAL(5,2),
medida_p VARCHAR(30),
gramas_proteina DECIMAL(6,2),


carboidrato VARCHAR(100),
qtd_c DECIMAL(5,2),
medida_c VARCHAR(30),
gramas_carboidrato DECIMAL(6,2),


lipidios VARCHAR(100),
qtd_l DECIMAL(5,2),
medida_l VARCHAR(30),
gramas_lipidios DECIMAL(6,2),


vegetais VARCHAR(100),
qtd_v DECIMAL(5,2),
medida_v VARCHAR(30),
gramas_vegetais DECIMAL(6,2),


fruta VARCHAR(100),
qtd_fruta DECIMAL(5,2),
medida_f VARCHAR(30),
gramas_fruta DECIMAL(6,2),


bebida VARCHAR(100),
qtd_bebida DECIMAL(5,2),
medida_bebida VARCHAR(30),
ml_bebida DECIMAL(6,2),


calorias_totais DECIMAL(7,2),

observacoes TEXT

);



INSERT INTO refeicao
(
plano_id,
tipo_refeicao,
proteina,
qtd_p,
medida_p,
gramas_proteina,
carboidrato,
qtd_c,
medida_c,
gramas_carboidrato,
calorias_totais,
observacoes
)
VALUES
(
'00000000-0000-0000-0000-000000000001',
'Café da Manhã',
'Ovo Mexido',
2,
'unidade',
100,
'Pão Integral',
2,
'fatia',
60,
450,
'Café da manhã balanceado'
);





-- =====================================================
-- BANCO RECOMENDAÇÃO
-- =====================================================


\connect ecomeal_recomendacao


CREATE EXTENSION IF NOT EXISTS "pgcrypto";


CREATE TABLE sugestao_marmita
(

id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

paciente_id UUID NOT NULL,


nome_combo VARCHAR(150) NOT NULL,


status VARCHAR(20)
DEFAULT 'Pendente',


proteina VARCHAR(100),

qtd_p DECIMAL(5,2),

medida_p VARCHAR(30),

gramas_proteina DECIMAL(6,2),


carboidrato VARCHAR(100),

qtd_c DECIMAL(5,2),

medida_c VARCHAR(30),

gramas_carboidrato DECIMAL(6,2),


lipidios VARCHAR(100),

qtd_l DECIMAL(5,2),

medida_l VARCHAR(30),

gramas_lipidios DECIMAL(6,2),


vegetais VARCHAR(100),

qtd_v DECIMAL(5,2),

medida_v VARCHAR(30),

gramas_vegetais DECIMAL(6,2),


fruta VARCHAR(100),

qtd_fruta DECIMAL(5,2),

medida_f VARCHAR(30),

gramas_fruta DECIMAL(6,2),


bebida VARCHAR(100),

qtd_b DECIMAL(5,2),

medida_b VARCHAR(30),

ml_b DECIMAL(6,2),


calorias_totais DECIMAL(7,2),


descricao TEXT,


data_geracao TIMESTAMP WITH TIME ZONE DEFAULT NOW()

);



INSERT INTO sugestao_marmita
(
paciente_id,
nome_combo,
proteina,
qtd_p,
medida_p,
gramas_proteina,
carboidrato,
qtd_c,
medida_c,
gramas_carboidrato,
calorias_totais,
descricao
)
VALUES
(
'00000000-0000-0000-0000-000000000001',
'Marmita Ganho de Massa',
'Patinho Moido',
1,
'porcao',
180,
'Batata Doce',
6,
'colher',
180,
850,
'Sugestao para hipertrofia muscular'
);