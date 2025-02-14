-- ======================================================================
-- ===   Sql Script for Database : Portfolio Trader
-- ===
-- === Build : 171
-- ======================================================================

CREATE TABLE trading_system
  (
    id                  int,
    username            varchar(32)   not null,
    workspace_code      varchar(36)   unique not null,
    name                varchar(64)   not null,
    scope               char(2)       not null,
    timeframe           int           not null,
    data_product_id     int           not null,
    data_symbol         varchar(16)   not null,
    broker_product_id   int           not null,
    broker_symbol       varchar(16)   not null,
    point_value         float         not null,
    cost_per_operation  float         not null,
    margin_value        float         not null,
    increment           double        not null,
    market_type         char(2)       not null,
    currency_id         int           not null,
    currency_code       varchar(16)   not null,
    trading_session_id  int           not null,
    session_name        varchar(32)   not null,
    session_config      text          not null,
    running             tinyint       not null,
    auto_activation     tinyint       not null,
    active              tinyint       not null,
    status              tinyint       not null,
    suggested_action    tinyint       not null,
    first_trade         datetime,
    last_trade          datetime,
    last_update         datetime      not null default CURRENT_TIMESTAMP,
    last_net_profit     double,
    last_net_avg_trade  double,
    last_num_trades     int,

    primary key(id)
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
    id                 int        auto_increment,
    trading_system_id  int        not null,
    trade_type         tinyint    not null,
    entry_time         datetime   not null,
    entry_value        double     not null,
    exit_time          datetime,
    exit_value         double,
    gross_profit       double,
    num_contracts      int        not null,

    primary key(id),

    foreign key(trading_system_id) references trading_system(id)
  )
 ENGINE = InnoDB ;

CREATE INDEX tradeIDX1 ON trade(trading_system_id);

-- ======================================================================

