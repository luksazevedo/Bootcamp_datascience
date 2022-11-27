-- PROJETO E-COMMERCE

-- criação de banco de dados para e-commerce
create database ecommerce;
use ecommerce;


-- criar tabela Cliente
create table Cliente(
	idCliente int auto_increment primary key,
	email varchar(40) not null,
	telefone char(11) not null
);


-- criar tabela PessoaFisica
create table PessoaFisica(
	idPessoaFisica int auto_increment primary key,
	nome varchar(50) not null,
	cpf char(11) not null,
	constraint unique_cpf_cliente unique(cpf),
	constraint fk_cliente_pf foreign key (idCliente) references Cliente(idCliente)
);


-- criar tabela PessoaJuridica
create table PessoaJuridica(
	idPessoaJuridica int auto_increment primary key,
	razao_social varchar(50) not null,
	cnpj char(45) not null,
	constraint unique_cnpj_cliente unique(cnpj),
	constraint fk_cliente_pj foreign key (idCliente) references Cliente(idCliente)
);


-- criar tabela FormaDePagamento
create table FormaDePagamento(
	constraint fk_pedido_forma_de_pagamento foreign key (idPedido) references Pedido(idPedido),
	constraint fk_cliente_forma_de_pagamento foreign key (idCliente) references Cliente(idCliente),
	constraint fk_pix foreign key (idPix) references Pix(idCPix),
	constraint fk_boleto foreign key (idBoleto) references Boleto(idBoleto),
	constraint fk_cartao foreign key (idCartao) references Cartao(idCartao)
);


-- criar tabela Pix
create table Pix(
	idPix int auto_increment primary key,
	pagador varchar(45) not null,
	chave_pix varchar(60) not null,
	instituicao_bancaria varchar(40) not null,
	agencia varchar(6) not null,
	conta varchar(15) not null,
	descricao varchar(100),
	data_transacao date not null,
	constraint unique_chave_pix unique(chave_pix)
);


-- criar tabela Boleto
create table Boleto(
	idBoleto int auto_increment primary key,
	codigo_de_barras varchar(50) not null,
	data_vencimento date not null,
	data_documento date not null,
	codigo_banco char(4) not null,
	constraint unique_codigo_de_barras unique(codigo_de_barras)
);


-- criar tabela Cartao
create table Cartao(
	idCartao int auto_increment primary key,
	nome_titular varchar(45) not null,
	numero char(16) not null,
	codigo_seguranca char(3) not null,
	data_validade char(4) not null,
	bandeira enum('Mastercard','Visa','Elo','Hipercard', 'American Express') not null, 
	parcelas int not null default 1,
	constraint unique_numero_cartao unique(numero)
	constraint unique_codigo_seguranca unique(codigo_seguranca)	
);


-- criar tabela EnderecoCliente
create table EnderecoCliente(
	constraint fk_endereco foreign key (idEndereco) references Endereco(idEndereco),
	constraint fk_cliente foreign key (idCliente) references Cliente(idCliente)
);


-- criar tabela Endereco
create table Endereco(
	idEndereco int auto_increment primary key,
	cep char(8) not null,
	sigla_estado char(2) not null,
	cidade varchar(40) not null,
	bairro varchar(40) not null,
	logradouro varchar(45)not null,
	numero varchar(5) not null,
	complemento varchar(40)
);


-- criar tabela Entrega
create table Entrega(
	idEntrega int auto_increment primary key,
	status enum('Entregue a transportadora', 'Em trânsito', 'Entregue ao cliente') not null,
	codigo_rastreio varchar(30) not null,
	valor_frete float not null,
	previsao_entrega date not null,
	constraint fk_endereco_entrega foreign key (idEndereco) references Endereco(idEndereco),
	constraint fk_transportadora_entrega foreign key (idTransportadora) references Transportadora(idTransportadora)
);


-- criar tabela Transportadora
create table Transportadora(
	idTransportadora int auto_increment primary key,
	razao_social varchar(40) not null,
	cnpj varchar(40) not null,
	telefone char(11) not null,
	email varchar(45) not null,
	constraint unique_cnpj_transportadora unique(cnpj)
);


-- criar tabela Pedido
create table Pedido(
	idPedido int auto_increment primary key,
	data_compra date not null,
	satus enum('Pagamento pendente', 'Cancelado', 'Confirmado') not null,
	constraint fk_cliente_pedido foreign key (idCliente) references Cliente(idCliente),
	constraint fk_forma_de_pagamento_pedido foreign key (idPedido) references Pedido(idPedido),
	constraint fk_entrega_pedido foreign key (idEntrega) references Entrega(idEntrega)
);


-- criar tabela CestaDeCompras
create table CestaDeCompras(
	idCestaDeCompras int auto_increment primary key,
	quantidade int not null,
	valor_total float not null,
	constraint fk_pedido_cesta foreign key (idPedido) references Pedido(idPedido),
	constraint fk_produto_cesta foreign key (idProduto) references Produto(idProduto)
);


-- criar tabela Produto
create table Produto(
	idProduto int auto_increment primary key,
	nome_produto varchar(30) not null,
	descricao varchar(60),
	valor_unitario float not null,
	codigo_de_barras varchar(40) not null,
	avaliacao float	default 0,
	constraint unique_codigo_de_barras_produto unique(codigo_de_barras)
);


-- criar tabela EmEstoque
create table EmEstoque(
	quantidade int not null,
	constraint fk_produto_em_estoque foreign key (idProduto) references Produto(idProduto),
	constraint fk_em_estoque foreign key (idEstoque) references Estoque(idEstoque)
);


-- criar tabela Estoque
create table Estoque(
	idEstoque int auto_increment primary key,
	cidade varchar(40),
	siga_estado char(2),
	bairro varchar(40), 
	logradouro varchar(40),
	numero varchar(5)
);


-- criar tabela Fornecimento
create table Fornecimento(
	quantidade int not null,
	constraint fk_estoque_fornecimento foreign key (idEstoque) references Estoque(idEstoque),
	constraint fk_fornecedor foreign key (idFornecedor) references Fornecedor(idFornecedor)
);


-- criar tabela Fornecedor
create table Fornecedor(
	idFornecedor int auto_increment primary key,
	razao_social varchar(45),
	cnpj varchar(45),
	telefone char(11),
	email varchar(45),
	constraint unique_cnpj_fornecedor unique(cnpj)
);
