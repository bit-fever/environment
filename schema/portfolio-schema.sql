-- ======================================================================
-- ===   Sql Script for Database : Portfolio Trader
-- ===
-- === Build : 36
-- ======================================================================

CREATE TABLE portfolio
  (
    id          int           auto_increment,
    name        varchar(64)   unique not null,
    created_at  datetime      not null,
    updated_at  datetime,

    primary key(id)
  )
 ENGINE = InnoDB ;

-- ======================================================================

CREATE TABLE instrument
  (
    id          int           auto_increment,
    ticker      varchar(16)   unique not null,
    name        varchar(64)   not null,
    created_at  datetime      not null,
    updated_at  datetime,

    primary key(id)
  )
 ENGINE = InnoDB ;

-- ======================================================================

CREATE TABLE trading_system
  (
    id                int             auto_increment,
    code              varchar(36)     unique not null,
    name              varchar(64)     not null,
    instrument_id     int             not null,
    portfolio_id      int             not null,
    created_at        datetime        not null,
    updated_at        datetime,
    first_update      int,
    last_update       int,
    last_pl           double(12,5),
    trading_days      int,
    num_trades        int,
    filter_type       int             not null,
    filter            varchar(1024),
    suggested_action  int             not null,

    primary key(id),

    foreign key(instrument_id) references instrument(id),
    foreign key(portfolio_id) references portfolio(id)
  )
 ENGINE = InnoDB ;

-- ======================================================================

CREATE TABLE ts_daily_info
  (
    id                 int            auto_increment,
    trading_system_id  int            not null,
    day                int            not null,
    open_profit        double(12,5)   not null,
    position           int            not null,
    gap_value          double(12,5)   not null,
    true_range         double(12,5)   not null,
    num_trades         int            not null,

    primary key(id),

    foreign key(trading_system_id) references trading_system(id)
  )
 ENGINE = InnoDB ;

-- ======================================================================

