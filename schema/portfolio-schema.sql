-- ======================================================================
-- ===   Sql Script for Database : Portfolio Trader
-- ===
-- === Build : 190
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

CREATE TABLE trading_system
  (
    id                  int,
    username            varchar(32)    not null,
    name                varchar(64)    not null,
    timeframe           int            not null,
    data_product_id     int            not null,
    data_symbol         varchar(16)    not null,
    broker_product_id   int            not null,
    broker_symbol       varchar(16)    not null,
    point_value         float          not null,
    cost_per_operation  float          not null,
    margin_value        float          not null,
    increment           double         not null,
    market_type         char(2)        not null,
    currency_id         int            not null,
    currency_code       varchar(16)    not null,
    trading_session_id  int            not null,
    session_name        varchar(32)    not null,
    session_config      text           not null,
    external            tinyint        not null,
    strategy_type       char(2)        not null,
    overnight           tinyint        not null,
    tags                varchar(255),
    finalized           tinyint        not null,
    trading             tinyint        not null,
    running             tinyint        not null,
    auto_activation     tinyint        not null,
    active              tinyint        not null,
    status              tinyint        not null,
    suggested_action    tinyint        not null,
    first_trade         datetime,
    last_trade          datetime,
    last_net_profit     double,
    last_net_avg_trade  double,
    last_num_trades     int,
    portfolio_id        int,

    primary key(id),

    foreign key(portfolio_id) references portfolio(id)
  )
 ENGINE = InnoDB ;

CREATE INDEX trading_systemIDX1 ON trading_system(username);

-- ======================================================================

CREATE TABLE trading_filter
  (
    trading_system_id  int,
    equ_avg_enabled    tinyint    not null,
    equ_avg_len        smallint   not null,
    pos_pro_enabled    tinyint    not null,
    pos_pro_len        smallint   not null,
    win_per_enabled    tinyint    not null,
    win_per_len        tinyint    not null,
    win_per_value      tinyint    not null,
    old_new_enabled    tinyint    not null,
    old_new_old_len    smallint   not null,
    old_new_old_perc   smallint   not null,
    old_new_new_len    smallint   not null,
    trendline_enabled  tinyint    not null,
    trendline_len      smallint   not null,
    trendline_value    smallint   not null,

    primary key(trading_system_id),

    foreign key(trading_system_id) references trading_system(id)
  )
 ENGINE = InnoDB ;

-- ======================================================================

CREATE TABLE trade
  (
    id                 int           auto_increment,
    trading_system_id  int           not null,
    trade_type         char(2)       not null,
    entry_date         datetime      not null,
    entry_price        double        not null,
    entry_label        varchar(64),
    exit_date          datetime,
    exit_price         double,
    exit_label         varchar(64),
    gross_profit       double,
    contracts          int           not null,

    primary key(id),

    foreign key(trading_system_id) references trading_system(id)
  )
 ENGINE = InnoDB ;

CREATE INDEX tradeIDX1 ON trade(trading_system_id);

-- ======================================================================

