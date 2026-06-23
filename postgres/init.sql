-- ==================================================
-- EcoMeal
-- Criação dos bancos por microsserviço
-- Database per Service
-- ==================================================


-- ==================================================
-- Banco do PacienteService
-- ==================================================

CREATE DATABASE ecomeal_paciente;


-- ==================================================
-- Banco do PlanoAlimentarService
-- ==================================================

CREATE DATABASE ecomeal_planoalimentar;


-- ==================================================
-- Banco do RecomendacaoService
-- ==================================================

CREATE DATABASE ecomeal_recomendacao;



-- ==================================================
-- Permissões do usuário da aplicação
-- ==================================================

GRANT ALL PRIVILEGES
ON DATABASE ecomeal_paciente
TO ecomeal;


GRANT ALL PRIVILEGES
ON DATABASE ecomeal_planoalimentar
TO ecomeal;


GRANT ALL PRIVILEGES
ON DATABASE ecomeal_recomendacao
TO ecomeal;