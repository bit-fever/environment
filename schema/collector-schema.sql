-- ======================================================================
-- ===   Sql Script for Database : Data Collector
-- ===
-- === Build : 133
-- ======================================================================

CREATE TABLE data_product
  (
    id                      int,
    symbol                  varchar(16)   not null,
    username                varchar(32)   not null,
    system_code             varchar(8)    not null,
    connection_code         varchar(8)    not null,
    supports_multiple_data  tinyint       not null,
    timezone                varchar(32)   not null,

    primary key(id),
    unique(symbol,username,system_code)
  )
 ENGINE = InnoDB ;

CREATE INDEX data_productIDX1 ON data_product(username);

-- ======================================================================

CREATE TABLE data_instrument
  (
    id               int           auto_increment,
    data_product_id  int           not null,
    symbol           varchar(16)   not null,
    name             varchar(64)   not null,
    expiration_date  int,
    is_continuous    tinyint       not null,
    status           tinyint       not null,
    data_from        int,
    data_to          int,

    primary key(id),
    unique(data_product_id,symbol),

    foreign key(data_product_id) references data_product(id)
  )
 ENGINE = InnoDB ;

CREATE INDEX data_instrumentIDX1 ON data_instrument(data_product_id);

-- ======================================================================

CREATE TABLE upload_job
  (
    id                  int           auto_increment,
    data_instrument_id  int           not null,
    status              tinyint       not null,
    filename            varchar(64)   not null,
    error               text,
    progress            tinyint       not null,
    records             int           not null,
    bytes               bigint        not null,
    timezone            varchar(64)   not null,
    parser              varchar(64)   not null,

    primary key(id),

    foreign key(data_instrument_id) references data_instrument(id)
  )
 ENGINE = InnoDB ;

CREATE INDEX upload_jobIDX1 ON upload_job(data_instrument_id);

-- ======================================================================

CREATE TABLE broker_product
  (
    id              int,
    symbol          varchar(16)   not null,
    username        varchar(32)   not null,
    name            varchar(64)   not null,
    point_value     float         not null,
    cost_per_trade  float         not null,
    currency_code   varchar(16)   not null,

    primary key(id)
  )
 ENGINE = InnoDB ;

CREATE INDEX broker_productIDX1 ON broker_product(username);

-- ======================================================================

CREATE TABLE loaded_period
  (
    id                  int   auto_increment,
    data_instrument_id  int   not null,
    day                 int   not null,
    status              int   not null,

    primary key(id),

    foreign key(data_instrument_id) references data_instrument(id)
  )
 ENGINE = InnoDB ;

-- ======================================================================

CREATE TABLE bias_analysis
  (
    id                  int           auto_increment,
    username            varchar(32)   not null,
    data_instrument_id  int           not null,
    broker_product_id   int           not null,
    name                varchar(64),
    notes               text,
    created_at          datetime      not null,
    updated_at          datetime,

    primary key(id),

    foreign key(data_instrument_id) references data_instrument(id),
    foreign key(broker_product_id) references broker_product(id)
  )
 ENGINE = InnoDB ;

CREATE INDEX bias_analysisIDX1 ON bias_analysis(username);

-- ======================================================================

CREATE TABLE bias_config
  (
    id                int            auto_increment,
    bias_analysis_id  int            not null,
    start_slot        smallint       not null,
    end_slot          smallint       not null,
    months            smallint       not null,
    excludes          varchar(255),

    primary key(id),

    foreign key(bias_analysis_id) references bias_analysis(id)
  )
 ENGINE = InnoDB ;

CREATE INDEX bias_configIDX1 ON bias_config(bias_analysis_id);

-- ======================================================================

