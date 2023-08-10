create SCHEMA if not exists ecommerce;

use ecommerce;

create table if not exists cliente(
	idCliente int auto_increment primary key,
    Fnome varchar(10),
    minit char(3),
    Lnome varchar(20),
    CPF char(11) not null,
    Endereco varchar(50) not null,
    constraint cpf_client unique (CPF)
    
);

create table if not exists produto(
	idProduto int auto_increment primary key,
    Pnome varchar(30) not null,
    classificacao_kids bool,
    categoria enum('informática', 'eletrônico', 'vestuário', 'brinquedos') not null,
    avaliacao float default 0,
    tamanho varchar(10)
);

create table if not exists pagamento(
	idPagamento int,
    idCliente int,
    tipoPagamento enum('Boleto', 'Cartão', 'Dois Cartões'),
    limitAvaliable float,
    primary key (idPagamento, idCliente)
    );

create table if not exists pedido(
	idPedido int auto_increment primary key,
    idCliente int,
    status enum('Processando', 'cancelado', 'confirmado') default 'Processando',
    description varchar(255),
    frete float default 10,
    paymentCash bool default false,
    idPagamento int,
    constraint fk_request_cliente foreign key(idCliente) references cliente(idCliente),
    constraint fk_request_Pagamento foreign key(idPagamento, idCliente) references pagamento(idPagamento, idCliente)
);

create table if not exists estoque(
	idEstoque int primary key,
    localizacao varchar(255),
    quantidade int default 0
);

create table if not exists fornecedor(
	idFornecedor int primary key,
    CNPJ char(15) not null,
    nome varchar(255) not null,
    contato char(11) not null,
    constraint unique_fornecedor unique(CNPJ)
);

create table if not exists vendedor(
	idVendedor int primary key,
    CNPJ char(15),
    CPF char(9),
    socialNome varchar(255) not null,
    AbsNome varchar(255),
    contato char(11) not null,
    Endereço varchar(255),
    constraint unique_CPF_vendedor unique(CPF),
    constraint unique_CNPJ_vendedor unique(CNPJ)
);

-- criar relacionamento produto_vendedor

create table if not exists produto_vendedor(
	idproduto int,
    idVendedor int,
    quantidade int default 1,
    primary key(idProduto, idVendedor),
    constraint fk_produto_vendedor foreign key(idVendedor) references vendedor(idVendedor),
    constraint fk_produto_produto foreign key(idProduto) references produto(idProduto)
);

-- criar tabela de relacionamento produto_pedido
create table if not exists produto_pedido(
	idProduto int,
    idPedido int,
    quantidade int,
    status enum('Processando', 'cancelado', 'confirmado') default 'Processando',
    primary key(idProduto, idPedido),
    constraint fk_produto_pedido foreign key(idProduto) references produto(idProduto),
    constraint fk_request_produto foreign key(idPedido) references Pedido(idPedido)
);

-- criar tabela estoque
create table if not exists estoque_localizacao(
	idProduto int,
    idEstoque int,
    localizacao varchar(255) not null,
    primary key (idProduto, idEstoque),
    constraint fk_Estoque_localizacao_produto foreign key(idProduto) references produto(idProduto),
    constraint fk_Estoque_Produto foreign key(idEstoque) references estoque(idEstoque)
);


-- criar tabela de relacionameto produto/fornecedor
create table if not exists produto_fornecedor(
	idFornecedor int,
    idProduto int,
    quantidade int not null,
    primary key (idFornecedor, idProduto),
    constraint fk_Fornecedor_Fornecedor foreign key(idFornecedor) references fornecedor(idFornecedor),
    constraint fk_product_Fornecedor foreign key(idProduto) references produto(idProduto)
);
    

    
