-- ======================================================================
-- ===   Sql Script for Database : Inventory Server
-- ===
-- === Build : 22
-- ======================================================================

CREATE TABLE exchanges
  (
    id          int           auto_increment,
    code        varchar(16)   unique not null,
    name        varchar(64)   not null,
    created_at  datetime,
    updated_at  datetime,

    primary key(id)
  )
 ENGINE = InnoDB ;

-- ======================================================================

CREATE TABLE datasources
  (
    id          int           auto_increment,
    code        varchar(32)   unique not null,
    name        varchar(32)   not null,
    local       tinyint       not null,
    created_at  datetime,
    updated_at  datetime,

    primary key(id)
  )
 ENGINE = InnoDB ;

-- ======================================================================

CREATE TABLE currencies
  (
    id    int           auto_increment,
    code  varchar(16)   unique not null,
    name  varchar(16)   not null,

    primary key(id)
  )
 ENGINE = InnoDB ;

-- ======================================================================

CREATE TABLE portfolios
  (
    id    int           auto_increment,
    name  varchar(64)   unique not null,

    primary key(id)
  )
 ENGINE = InnoDB ;

-- ======================================================================

CREATE TABLE trading_systems
  (
    id            int           auto_increment,
    portfolio_id  int           not null,
    name          varchar(64)   unique not null,

    primary key(id),

    foreign key(portfolio_id) references portfolios(id)
  )
 ENGINE = InnoDB ;

-- ======================================================================

CREATE TABLE instruments
  (
    id               int           auto_increment,
    exchange_id      int           not null,
    datasource_id    int           not null,
    symbol           varchar(16)   not null,
    name             varchar(64)   not null,
    expiration_date  int,
    price_scale      int           not null,
    min_movement     float         not null,
    big_point_value  int           not null,
    currency_id      int           not null,
    market_type      char(2)       not null,
    security_type    char(2)       not null,
    created_at       datetime,
    updated_at       datetime,

    primary key(id),
    unique(datasource_id,symbol),

    foreign key(exchange_id) references exchanges(id),
    foreign key(datasource_id) references datasources(id),
    foreign key(currency_id) references currencies(id)
  )
 ENGINE = InnoDB ;

-- ======================================================================

