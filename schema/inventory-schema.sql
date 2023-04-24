-- ======================================================================
-- ===   Sql Script for Database : Inventory Server
-- ===
-- === Build : 19
-- ======================================================================

CREATE TABLE exchange
  (
    id    int           auto_increment,
    code  varchar(16)   unique not null,
    name  varchar(64)   not null,

    primary key(id)
  )
 ENGINE = InnoDB ;

-- ======================================================================

CREATE TABLE datasource
  (
    id     int           auto_increment,
    code   varchar(32)   unique not null,
    name   varchar(32)   not null,
    local  tinyint       not null,

    primary key(id)
  )
 ENGINE = InnoDB ;

-- ======================================================================

CREATE TABLE currency
  (
    id    int           auto_increment,
    code  varchar(16)   unique not null,
    name  varchar(16)   not null,

    primary key(id)
  )
 ENGINE = InnoDB ;

-- ======================================================================

CREATE TABLE portfolio
  (
    id    int           auto_increment,
    name  varchar(64)   unique not null,

    primary key(id)
  )
 ENGINE = InnoDB ;

-- ======================================================================

CREATE TABLE trading_system
  (
    id            int           auto_increment,
    portfolio_id  int           not null,
    name          varchar(64)   unique not null,

    primary key(id),

    foreign key(portfolio_id) references portfolio(id)
  )
 ENGINE = InnoDB ;

-- ======================================================================

CREATE TABLE instrument
  (
    id               int           auto_increment,
    exchange_id      int           not null,
    datasource_id    int           not null,
    symbol           varchar(16)   not null,
    name             varchar(64)   not null,
    expiration_date  datetime,
    price_scale      int           not null,
    min_movement     float         not null,
    big_point_value  int           not null,
    currency_id      int           not null,
    market_type      char(2)       not null,
    security_type    char(2)       not null,

    primary key(id),
    unique(datasource_id,symbol),

    foreign key(exchange_id) references exchange(id),
    foreign key(datasource_id) references datasource(id),
    foreign key(currency_id) references currency(id)
  )
 ENGINE = InnoDB ;

-- ======================================================================

