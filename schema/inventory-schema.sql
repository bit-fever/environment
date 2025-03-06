-- ======================================================================
-- ===   Sql Script for Database : Inventory Server
-- ===
-- === Build : 183
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
    id                      int           auto_increment,
    username                varchar(32)   not null,
    code                    varchar(8)    not null,
    name                    varchar(32)   not null,
    system_code             varchar(8)    not null,
    system_name             varchar(32)   not null,
    system_config           text,
    instance_code           varchar(36),
    supports_data           tinyint       not null,
    supports_broker         tinyint       not null,
    supports_multiple_data  tinyint       not null,
    supports_inventory      tinyint       not null,
    created_at              datetime      not null,
    updated_at              datetime,

    primary key(id),
    unique(username,code)
  )
 ENGINE = InnoDB ;

CREATE INDEX connectionIDX1 ON connection(username);

-- ======================================================================

CREATE TABLE agent_profile
  (
    id             int            auto_increment,
    username       varchar(32)    not null,
    name           varchar(64)    not null,
    remote_url     varchar(255)   not null,
    ssl_key_ref    varchar(36),
    ssl_cert_ref   varchar(36),
    scan_interval  int            not null,
    created_at     datetime       not null,
    updated_at     datetime,

    primary key(id)
  )
 ENGINE = InnoDB ;

CREATE INDEX agent_profileIDX1 ON agent_profile(username);

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

CREATE TABLE data_product
  (
    id             int           auto_increment,
    exchange_id    int           not null,
    connection_id  int           not null,
    username       varchar(32)   not null,
    symbol         varchar(16)   not null,
    name           varchar(64)   not null,
    market_type    char(2)       not null,
    product_type   char(2)       not null,
    created_at     datetime      not null,
    updated_at     datetime,

    primary key(id),
    unique(connection_id,username,symbol),

    foreign key(exchange_id) references exchange(id),
    foreign key(connection_id) references connection(id)
  )
 ENGINE = InnoDB ;

CREATE INDEX data_productIDX1 ON data_product(username);

-- ======================================================================

CREATE TABLE broker_product
  (
    id                  int           auto_increment,
    exchange_id         int           not null,
    connection_id       int           not null,
    username            varchar(32)   not null,
    symbol              varchar(16)   not null,
    name                varchar(64)   not null,
    point_value         float         not null,
    cost_per_operation  float         not null,
    margin_value        float         not null,
    increment           double        not null,
    market_type         char(2)       not null,
    product_type        char(2)       not null,
    created_at          datetime      not null,
    updated_at          datetime,

    primary key(id),
    unique(connection_id,username,symbol),

    foreign key(exchange_id) references exchange(id),
    foreign key(connection_id) references connection(id)
  )
 ENGINE = InnoDB ;

CREATE INDEX broker_productIDX1 ON broker_product(username);

-- ======================================================================

CREATE TABLE broker_instrument
  (
    id                 int           auto_increment,
    broker_product_id  int           not null,
    symbol             varchar(16)   not null,
    name               varchar(64)   not null,
    expiration_date    int           not null,

    primary key(id),
    unique(broker_product_id,symbol),

    foreign key(broker_product_id) references broker_product(id)
  )
 ENGINE = InnoDB ;

CREATE INDEX broker_instrumentIDX1 ON broker_instrument(broker_product_id);

-- ======================================================================

CREATE TABLE trading_system
  (
    id                  int            auto_increment,
    username            varchar(32)    not null,
    data_product_id     int            not null,
    broker_product_id   int            not null,
    trading_session_id  int            not null,
    name                varchar(64)    not null,
    scope               char(2)        not null,
    timeframe           int            not null,
    strategy_type       char(2)        not null,
    overnight           tinyint        not null,
    tags                varchar(255),
    agent_profile_id    int,
    external_ref        varchar(64),
    created_at          datetime       not null,
    updated_at          datetime,

    primary key(id),
    unique(username,external_ref),

    foreign key(data_product_id) references data_product(id),
    foreign key(broker_product_id) references broker_product(id),
    foreign key(trading_session_id) references trading_session(id),
    foreign key(agent_profile_id) references agent_profile(id)
  )
 ENGINE = InnoDB ;

CREATE INDEX trading_systemIDX1 ON trading_system(username);

-- ======================================================================

