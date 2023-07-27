-- ======================================================================
-- ===   Sql Script for Database : Portfolio Trader
-- ===
-- === Build : 27
-- ======================================================================

CREATE TABLE account
  (
    id            int            auto_increment,
    code          varchar(32)    not null,
    broker_code   varchar(16)    not null,
    last_balance  double(12,5),
    last_equity   double(12,5),
    last_day      int,

    primary key(id),
    unique(code,broker_code)
  )
 ENGINE = InnoDB ;

-- ======================================================================

CREATE TABLE portfolio
  (
    id          int           auto_increment,
    account_id  int           not null,
    name        varchar(32)   unique not null,

    primary key(id),

    foreign key(account_id) references account(id)
  )
 ENGINE = InnoDB ;

-- ======================================================================

CREATE TABLE trading_system
  (
    id            int           auto_increment,
    portfolio_id  int           not null,
    ticker        varchar(16)   not null,
    code          varchar(36)   not null,

    primary key(id),

    foreign key(portfolio_id) references portfolio(id)
  )
 ENGINE = InnoDB ;

-- ======================================================================

CREATE TABLE daily_profit_info
  (
    id                 int            auto_increment,
    trading_system_id  int            not null,
    day                int            not null,
    open_profit        double(12,5)   not null,
    close_profit       double(12,5)   not null,
    true_range         double(12,5)   not null,
    num_trades         int            not null,

    primary key(id),

    foreign key(trading_system_id) references trading_system(id)
  )
 ENGINE = InnoDB ;

-- ======================================================================

CREATE TABLE daily_account_info
  (
    id          int            auto_increment,
    account_id  int            not null,
    day         int            not null,
    balance     double(12,5)   not null,
    equity      double(12,5)   not null,

    primary key(id),

    foreign key(account_id) references account(id)
  )
 ENGINE = InnoDB ;

-- ======================================================================

