-- Criação do banco de dados

create DATABASE sistema_orcamento_vendas;
USE sistema_orcamento_vendas;

-- Tabela: vendedores
CREATE TABLE vendedores (
    id_vendedor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    matricula VARCHAR(50) UNIQUE NOT NULL,
    departamento VARCHAR(100) NOT NULL
);

-- Tabela: clientes
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    endereco TEXT NOT NULL,
    cnpj VARCHAR(18) UNIQUE NOT NULL
);

-- Tabela: produtos

CREATE TABLE produtos(
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    desenho LONGBLOB, -- Armazena o arquivo do desenho técnico (imagem ou PDF)
    prazo_entrega INT NOT NULL, -- Prazo em dias
    condicoes_pagamento TEXT NOT NULL, -- Detalhes das condições de pagamento
    forma_entrega ENUM('CIF', 'FOB') NOT NULL -- Define a forma de entrega
);

-- Tabela: orçamentos
CREATE TABLE orcamentos (
    id_orcamento INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_vendedor INT NOT NULL,
    status ENUM('Gerado', 'Aprovado', 'Em Produção', 'Fabricado', 'Entregue', 'Pago') NOT NULL DEFAULT 'Gerado',
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    proximo_followup DATETIME,
    data_aprovacao DATETIME,
    data_em_producao DATETIME,
    data_fabricacao DATETIME,
    data_entrega DATETIME,
    data_pagamento DATETIME,
    forma_entrega ENUM('CIF', 'FOB') NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor)
);

-- Tabela: orcamento_produtos
CREATE TABLE orcamento_produtos (
    id_orcamento_produto INT AUTO_INCREMENT PRIMARY KEY,
    id_orcamento INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_orcamento) REFERENCES orcamentos(id_orcamento),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);
