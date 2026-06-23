-- =====================================================
-- EcoMeal - Database Initialization
-- PostgreSQL 16
-- =====================================================



-- =====================================================
-- CRIAÇÃO DOS DATABASES
-- =====================================================

CREATE DATABASE ecomeal_paciente;
CREATE DATABASE ecomeal_planoalimentar;
CREATE DATABASE ecomeal_refeicoes;
CREATE DATABASE ecomeal_recomendacao;


-- =====================================================
-- UUID support
-- =====================================================

CREATE EXTENSION IF NOT EXISTS "pgcrypto";


-- =====================================================
-- Tabela PACIENTE
-- =====================================================

CREATE TABLE paciente (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    auth_user_id UUID UNIQUE,

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



-- =====================================================
-- Tabela PLANO ALIMENTAR
-- =====================================================

CREATE TABLE plano_alimentar (

    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    paciente_id UUID NOT NULL,

    objetivo TEXT NOT NULL,

    data_criacao TIMESTAMP WITH TIME ZONE DEFAULT NOW(),

    data_atualizacao TIMESTAMP WITH TIME ZONE DEFAULT NOW(),


    CONSTRAINT fk_plano_paciente
        FOREIGN KEY (paciente_id)
        REFERENCES paciente(id)
        ON DELETE CASCADE
);



-- =====================================================
-- Tabela REFEICAO
-- =====================================================

CREATE TABLE refeicao (

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

    observacoes TEXT,


    CONSTRAINT fk_refeicao_plano
        FOREIGN KEY (plano_id)
        REFERENCES plano_alimentar(id)
        ON DELETE CASCADE
);



-- =====================================================
-- Tabela SUGESTAO MARMITA
-- =====================================================

CREATE TABLE sugestao_marmita (

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


    data_geracao TIMESTAMP WITH TIME ZONE
        DEFAULT NOW(),


    CONSTRAINT fk_marmita_paciente
        FOREIGN KEY (paciente_id)
        REFERENCES paciente(id)
        ON DELETE CASCADE
);



-- =====================================================
-- DADOS INICIAIS
-- =====================================================


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
-- PLANOS
-- =====================================================

INSERT INTO plano_alimentar
(
paciente_id,
objetivo
)
SELECT
id,
objetivo
FROM paciente;



-- =====================================================
-- REFEIÇÕES
-- =====================================================

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
lipidios,
qtd_l,
medida_l,
gramas_lipidios,
vegetais,
qtd_v,
medida_v,
gramas_vegetais,
fruta,
qtd_fruta,
medida_f,
gramas_fruta,
bebida,
qtd_bebida,
medida_bebida,
ml_bebida,
calorias_totais,
observacoes
)

SELECT

id,
'Café da Manhã',
'Ovo Mexido',
2,
'unidade',
100,
'Pão Integral',
2,
'fatia',
60,
'Pasta de Amendoim',
1,
'colher',
15,
'Cenoura',
1,
'xícara',
100,
'Banana',
1,
'unidade',
100,
'Leite Desnatado',
1,
'copo',
200,
450,
'Café da manhã balanceado'

FROM plano_alimentar;



-- =====================================================
-- SUGESTÕES DE MARMITA
-- =====================================================


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
lipidios,
qtd_l,
medida_l,
gramas_lipidios,
vegetais,
qtd_v,
medida_v,
gramas_vegetais,
fruta,
qtd_fruta,
medida_f,
gramas_fruta,
bebida,
qtd_b,
medida_b,
ml_b,
calorias_totais,
descricao
)


SELECT

id,
'Marmita Ganho de Massa',
'Patinho Moido',
1,
'porcao',
180,
'Batata Doce',
6,
'colher',
180,
'Castanhas',
6,
'unidade',
20,
'Cenoura',
1,
'xicara',
100,
'Banana',
1,
'unidade',
120,
'Suco Natural',
1,
'copo',
300,
850,
'Sugestao para hipertrofia muscular'


FROM paciente;



-- FIM