-- PROJETO OFICINA

-- criação do banco de dados para uma oficina
CREATE DATABASE Oficina;
USE Oficina;


-- tabela Cliente
CREATE TABLE Cliente(
    idCliente  INT AUTO_INCREMENT PRIMARY KEY,
    nome       VARCHAR(50) NOT NULL,
    contato    CHAR(1) NOT NULL,
    cpf        CHAR(11) NOT NULL,
    cep        CHAR(8) NOT NULL,
    uf         CHAR(2) NOT NULL,
    cidade     VARCHAR(45) NOT NULL,
    bairro     VARCHAR(45) NOT NULL,
    logradouro VARCHAR(45) NOT NULL,
    numero     VARCHAR(5) NOT NULL,
    CONSTRAINT unique_cpf_cliente UNIQUE(cpf)
);


-- tabela OrdemDeServico
CREATE TABLE OrdemDeServico(
    idOrdemDeServico INT AUTO_INCREMENT PRIMARY KEY,
    status           ENUM('Em espera', 'Sendo reparado', 'Finalizado', 'Entregue') NOT NULL, 
    data_entrada     DATE NOT NULL,
    previsao_entrega DATE NOT NULL,
    valor            FLOAT NOT NULL,
    atendente        VARCHAR(50) NOT NULL,
    CONSTRAINT fk_cliente_ordem FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
    CONSTRAINT fk_veiculo_ordem FOREIGN KEY (idVeiculo) REFERENCES Veiculo(idVeiculo),
    CONSTRAINT fk_orcamento_ordem FOREIGN KEY (idOrcamento) REFERENCES Orcamento(idOrcamento),
    CONSTRAINT fk_servico_ordem FOREIGN KEY (idServico) REFERENCES Servico(idServico)
);


-- tabela Servico
CREATE TABLE Servico(
    idServico INT AUTO_INCREMENT PRIMARY KEY,
    sevicos   VARCHAR(60)
);


-- tabela Veiculo
CREATE TABLE Veiculo(
    idServico      INT AUTO_INCREMENT PRIMARY KEY,
    placa          CHAR(7) NOT NULL,
    modelo         VARCHAR(30) NOT NULL,
    cor            VARCHAR(15),
    ano_fabricacao CHAR(4) NOT NULL,
    km_atual       INT NOT NULL,
    CONSTRAINT unique_placa_veiculo UNIQUE(placa)
);


-- tabela Orcamento
CREATE TABLE Orcamento(
    idOrcamento INT AUTO_INCREMENT PRIMARY KEY,
    mao_de_obra FLOAT NOT NULL,
    desconto    FLOAT DEFAULT 0,
    valor_total FLOAT NOT NULL,
    CONSTRAINT fk_peca_orcamento FOREIGN KEY (idPeca) REFERENCES Peca(idPeca)
);


-- tabela Peca
CREATE TABLE Peca(
    idPeca     INT AUTO_INCREMENT PRIMARY KEY,
    nome       VARCHAR(40) NOT NULL,
    quantidade INT DEFAULT 1,
    valor      FLOAT NOT NULL
);


-- tabela PecaEmEstoque
CREATE TABLE PecaEmEstoque(
    CONSTRAINT fk_estoque FOREIGN KEY (idEstoque) REFERENCES Estoque(idEstoque),
    CONSTRAINT fk_peca_em_estoque FOREIGN KEY (idPeca) REFERENCES Peca(idPeca)
);


-- tabela Estoque
CREATE TABLE Estoque(
    idEstoque             INT AUTO_INCREMENT PRIMARY KEY,
    quantidade_disponivel INT NOT NULL
);