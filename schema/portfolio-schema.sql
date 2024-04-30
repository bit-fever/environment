-- ======================================================================
-- ===   Sql Script for Database : Portfolio Trader
-- ===
-- === Build : 93
-- ======================================================================

CREATE TABLE trading_system
  (
    id                 int            auto_increment,
    source_id          int            unique not null,
    username           varchar(32)    not null,
    workspace_code     varchar(36)    unique not null,
    name               varchar(64)    not null,
    status             char(2)        not null,
    first_update       int,
    last_update        int,
    closed_profit      double(12,5),
    trading_days       int,
    num_trades         int,
    product_broker_id  int            not null,
    broker_symbol      varchar(16)    not null,
    point_value        float          not null,
    cost_per_trade     float          not null,
    margin_value       float          not null,
    currency_id        int            not null,
    currency_code      varchar(16)    not null,

    primary key(id)
  )
 ENGINE = InnoDB ;

CREATE INDEX trading_systemIDX1 ON trading_system(username);

-- ======================================================================

CREATE TABLE trading_filter
  (
    trading_system_id  int,
    equ_avg_enabled    tinyint   not null,
    equ_avg_days       tinyint   not null,
    pos_pro_enabled    tinyint   not null,
    pos_pro_days       tinyint   not null,
    win_per_enabled    tinyint   not null,
    win_per_days       tinyint   not null,
    win_per_value      tinyint   not null,
    old_new_enabled    tinyint   not null,
    old_new_old_days   tinyint   not null,
    old_new_old_perc   tinyint   not null,
    old_new_new_days   tinyint   not null,

    primary key(trading_system_id),

    foreign key(trading_system_id) references trading_system(id)
  )
 ENGINE = InnoDB ;

-- ======================================================================

CREATE TABLE daily_info
  (
    id                 int            auto_increment,
    trading_system_id  int            not null,
    day                int            not null,
    open_profit        double(12,5)   not null,
    closed_profit      double(12,5)   not null,
    position           int            not null,
    num_trades         int            not null,

    primary key(id),
    unique(trading_system_id,day),

    foreign key(trading_system_id) references trading_system(id)
  )
 ENGINE = InnoDB ;

-- ======================================================================

