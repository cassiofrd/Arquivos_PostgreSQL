CREATE SCHEMA Dimensional;

CREATE SEQUENCE Dimensional.ChaveVendedor;
CREATE TABLE Dimensional.DimensaoVendedor(
  ChaveVendedor int default nextval('Dimensional.ChaveVendedor'::regclass) PRIMARY KEY,
  IDVendedor int,
  Nome Varchar(50),
  DataInicioValidade date not null,
  DataFimValidade date
);

CREATE SEQUENCE Dimensional.ChaveCliente;
CREATE TABLE Dimensional.DimensaoCliente(
  ChaveCliente int default nextval('Dimensional.ChaveCliente'::regclass) PRIMARY KEY,
  IDCliente int,
  Cliente Varchar(50),
  Estado Varchar(2),
  Sexo Char(1),
  Status Varchar(50),
  DataInicioValidade date not null,
  DataFimValidade date
);

CREATE SEQUENCE Dimensional.ChaveProduto;
CREATE TABLE Dimensional.DimensaoProduto(
  ChaveProduto int default nextval('Dimensional.ChaveProduto'::regclass) PRIMARY KEY,
  IDProduto int,
  Produto Varchar(100),
  DataInicioValidade date not null,
  DataFimValidade date
);

CREATE SEQUENCE Dimensional.ChaveTempo;
CREATE TABLE Dimensional.DimensaoTempo(
  ChaveTempo int default nextval('Dimensional.ChaveTempo'::regclass) PRIMARY KEY,
  Data Date,
  Dia int,
  Mes int,
  Ano int,
  DiaSemana int,
  Trimestre int
);

CREATE SEQUENCE Dimensional.ChaveVendas;
CREATE TABLE Dimensional.FatoVendas(
  ChaveVendas int default nextval('Dimensional.ChaveVendas'::regclass) PRIMARY KEY,
  ChaveVendedor int references Dimensional.DimensaoVendedor (ChaveVendedor),
  ChaveCliente int references Dimensional.DimensaoCliente (ChaveCliente),
  ChaveProduto int references Dimensional.DimensaoProduto (ChaveProduto),
  ChaveTempo int references Dimensional.DimensaoTempo (ChaveTempo),
  Quantidade int,
  ValorUnitario Numeric(10,2),
  ValorTotal Numeric(10,2),
  Desconto Numeric(10,2)
);

INSERT INTO Dimensional.DimensaoTempo(data, dia, mes, ano, diasemana, trimestre)
SELECT datum AS Data,
       EXTRACT(DAY FROM datum) AS Dia,
       EXTRACT(MONTH FROM datum) AS Mes,
       EXTRACT(year FROM datum) AS Ano,
       EXTRACT(dow FROM datum) AS DiaSemana,
	   EXTRACT(quarter FROM datum) AS Trimestre
FROM (SELECT '1970-01-01'::DATE+ SEQUENCE.DAY AS datum
      FROM GENERATE_SERIES (0,29219) AS SEQUENCE (DAY)
      GROUP BY SEQUENCE.DAY) DQ
ORDER BY 1;

select * from dimensional.dimensaotempo ;
