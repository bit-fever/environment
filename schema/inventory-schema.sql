-- ======================================================================
-- ===   Sql Script for Database : Inventory Server
-- ===
-- === Build : 102
-- ======================================================================

CREATE TABLE portfolio
  (
    id          int           auto_increment,
    username    varchar(32)   not null,
    parent_id   int,
    name        varchar(64)   not null,
    created_at  datetime      not null,
    updated_at  datetime,

    primary key(id),

    foreign key(parent_id) references portfolio(id)
  )
 ENGINE = InnoDB ;

CREATE INDEX portfolioIDX1 ON portfolio(username);

-- ======================================================================

CREATE TABLE trading_session
  (
    id          int           auto_increment,
    username    varchar(32)   not null,
    name        varchar(32)   not null,
    config      text          not null,
    created_at  datetime      not null,
    updated_at  datetime,

    primary key(id)
  )
 ENGINE = InnoDB ;

CREATE INDEX trading_sessionIDX1 ON trading_session(username);

-- ======================================================================

CREATE TABLE currency
  (
    id    int           auto_increment,
    code  varchar(16)   unique not null,
    name  varchar(32)   not null,

    primary key(id)
  )
 ENGINE = InnoDB ;

-- ======================================================================

CREATE TABLE connection
  (
    id                       int           auto_increment,
    username                 varchar(32)   not null,
    code                     varchar(8)    not null,
    name                     varchar(32)   not null,
    system_code              varchar(8)    not null,
    system_name              varchar(32)   not null,
    system_config            text,
    connection_code          varchar(36),
    supports_data            tinyint       not null,
    supports_broker          tinyint       not null,
    supports_multiple_feeds  tinyint       not null,
    supports_inventory       tinyint       not null,
    created_at               datetime      not null,
    updated_at               datetime,

    primary key(id),
    unique(username,code)
  )
 ENGINE = InnoDB ;

CREATE INDEX connectionIDX1 ON connection(username);

-- ======================================================================

CREATE TABLE exchange
  (
    id           int            auto_increment,
    currency_id  int            not null,
    code         varchar(16)    not null,
    name         varchar(64)    not null,
    timezone     varchar(32)    not null,
    url          varchar(255),

    primary key(id),

    foreign key(currency_id) references currency(id)
  )
 ENGINE = InnoDB ;

-- ======================================================================

CREATE TABLE product_data
  (
    id             int           auto_increment,
    connection_id  int           not null,
    exchange_id    int           not null,
    username       varchar(32)   not null,
    symbol         varchar(16)   not null,
    name           varchar(64)   not null,
    increment      double        not null,
    market_type    char(2)       not null,
    product_type   char(2)       not null,
    local_class    varchar(8)    not null,
    created_at     datetime      not null,
    updated_at     datetime,

    primary key(id),
    unique(exchange_id,username,symbol),

    foreign key(connection_id) references connection(id),
    foreign key(exchange_id) references exchange(id)
  )
 ENGINE = InnoDB ;

CREATE INDEX product_dataIDX1 ON product_data(username);

-- ======================================================================

CREATE TABLE instrument_data
  (
    id               int           auto_increment,
    product_data_id  int           not null,
    contract_id      int           not null,
    symbol           varchar(16)   not null,
    name             varchar(64)   not null,
    expiration_date  int,
    is_continuous    tinyint       not null,

    primary key(id),

    foreign key(product_data_id) references product_data(id)
  )
 ENGINE = InnoDB ;

CREATE INDEX instrument_dataIDX1 ON instrument_data(product_data_id);

-- ======================================================================

CREATE TABLE product_broker
  (
    id              int           auto_increment,
    connection_id   int           not null,
    exchange_id     int           not null,
    username        varchar(32)   not null,
    symbol          varchar(16)   not null,
    name            varchar(64)   not null,
    point_value     float         not null,
    cost_per_trade  float         not null,
    margin_value    float         not null,
    market_type     char(2)       not null,
    product_type    char(2)       not null,
    local_class     varchar(8)    not null,
    created_at      datetime      not null,
    updated_at      datetime,

    primary key(id),
    unique(exchange_id,username,symbol),

    foreign key(connection_id) references connection(id),
    foreign key(exchange_id) references exchange(id)
  )
 ENGINE = InnoDB ;

CREATE INDEX product_brokerIDX1 ON product_broker(username);

-- ======================================================================

CREATE TABLE instrument_broker
  (
    id                 int           auto_increment,
    product_broker_id  int           not null,
    contract_id        int           not null,
    symbol             varchar(16)   not null,
    name               varchar(64)   not null,
    expiration_date    int           not null,

    primary key(id),

    foreign key(product_broker_id) references product_broker(id)
  )
 ENGINE = InnoDB ;

CREATE INDEX instrument_brokerIDX1 ON instrument_broker(product_broker_id);

-- ======================================================================

CREATE TABLE trading_system
  (
    id                  int           auto_increment,
    portfolio_id        int           not null,
    username            varchar(32)   not null,
    product_data_id     int           not null,
    product_broker_id   int           not null,
    trading_session_id  int           not null,
    workspace_code      varchar(36)   unique not null,
    name                varchar(64)   not null,
    created_at          datetime      not null,
    updated_at          datetime,

    primary key(id),

    foreign key(portfolio_id) references portfolio(id),
    foreign key(product_data_id) references product_data(id),
    foreign key(product_broker_id) references product_broker(id),
    foreign key(trading_session_id) references trading_session(id)
  )
 ENGINE = InnoDB ;

CREATE INDEX trading_systemIDX1 ON trading_system(username);

-- ======================================================================

