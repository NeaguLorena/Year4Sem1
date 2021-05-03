create table circuits
(
    circuitId  int not null
        constraint circuits_pk
            primary key nonclustered,
    circuitRef varchar(max),
    name       varchar(max),
    location   varchar(max),
    country    varchar(max),
    lat        float,
    lng        float,
    alt        varchar(max),
    url        varchar(max)
)
go

create table constructor_results
(
    constructorResultsId int not null
        constraint constructor_results_pk
            primary key nonclustered,
    raceId               int,
    constructorId        int,
    points               float,
    status               varchar(max)
)
go

create table constructor_standings
(
    constructorStandingsId int not null
        constraint constructor_standings_pk
            primary key nonclustered,
    raceId                 int,
    constructorId          int,
    points                 varchar(max),
    position               int,
    positionText           varchar(max),
    wins                   int
)
go

create table constructors
(
    constructorId  int not null
        constraint constructors_pk
            primary key nonclustered,
    constructorRef varchar(max),
    name           varchar(max),
    nationality    varchar(max),
    url            varchar(max)
)
go

create table driver_standings
(
    driverStandingsId int not null
        constraint driver_standings_pk
            primary key nonclustered,
    raceId            int,
    driverId          int,
    points            varchar(max),
    position          int,
    positionText      varchar(max),
    wins              int
)
go

create table drivers
(
    driverId    int not null
        constraint drivers_pk
            primary key nonclustered,
    driverRef   varchar(max),
    number      varchar(max),
    code        varchar(max),
    forename    varchar(max),
    surname     varchar(max),
    dob         date,
    nationality varchar(max),
    url         varchar(max)
)
go

create table lap_times
(
    raceId       int not null,
    driverId     int not null,
    lap          int not null,
    position     int,
    time         varchar(max),
    milliseconds int,
    constraint lap_times_pk
        primary key nonclustered (raceId, driverId, lap)
)
go

create table pit_stops
(
    raceId       int not null,
    driverId     int not null,
    stop         int not null,
    lap          int,
    time         datetime2,
    duration     varchar(max),
    milliseconds int,
    constraint pit_stops_pk
        primary key nonclustered (raceId, driverId, stop)
)
go

create table qualifying
(
    qualifyId     int not null
        constraint qualifying_pk
            primary key nonclustered,
    raceId        int,
    driverId      int,
    constructorId int,
    number        int,
    position      int,
    q1            varchar(max),
    q2            varchar(max),
    q3            varchar(max)
)
go

create table races
(
    raceId    int not null
        constraint races_pk
            primary key nonclustered,
    year      int,
    round     int,
    circuitId int,
    name      varchar(max),
    date      date,
    time      varchar(max),
    url       varchar(max)
)
go

create table results
(
    resultId        int not null
        constraint results_pk
            primary key nonclustered,
    raceId          int,
    constructorId   int,
    driverId        int,
    number          varchar(max),
    grid            int,
    position        varchar(max),
    positionText    varchar(max),
    positionOrder   int,
    points          varchar(max),
    laps            int,
    time            varchar(max),
    milliseconds    varchar(max),
    fastestLap      varchar(max),
    rank            varchar(max),
    fastestLapTime  varchar(max),
    fastestLapSpeed varchar(max),
    statusId        int
)
go

create table seasons
(
    year int not null
        constraint seasons_pk
            primary key nonclustered,
    url  varchar(max)
)
go

create table status
(
    statusId int not null
        constraint status_pk
            primary key nonclustered,
    status   varchar(max)
)
go


