-- *************** SqlDBM: PostgreSQL ****************;
-- ***************************************************;


-- ************************************** reference.location

\c oltp20_control

BEGIN TRANSACTION;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- *************** SqlDBM: PostgreSQL ****************;
-- ***************************************************;


-- ************************************** stage.route_map

CREATE TABLE stage.route_map
(
 hub_ip       varchar(50) NULL,
 "id"           uuid NOT NULL DEFAULT uuid_generate_v4(),
 member_ip    varchar(50) NULL,
 peer_group_ip varchar(50) NULL,
 CONSTRAINT PK_route_map PRIMARY KEY ( "id" )
);


-- ************************************** reference.location

CREATE TABLE reference.location
(
 location_id uuid NOT NULL DEFAULT uuid_generate_v4(),
 name        varchar(72) NOT NULL,
 latitude    varchar(16) NOT NULL,
 longitude  varchar(16) NOT NULL,
 CONSTRAINT PK_location PRIMARY KEY ( location_id )
);




-- ************************************** setup.hub_peer_group

CREATE TABLE setup.hub_peer_group
(
 peer_group_ip varchar(32) NOT NULL,
 location_id  uuid NOT NULL,
 name         varchar(72) NOT NULL,
 hash_value   bytea NULL,
 create_date  date NOT NULL,
 "source"       varchar(64) NOT NULL,
 CONSTRAINT PK_group_hub PRIMARY KEY ( peer_group_ip ),
 CONSTRAINT FK_62 FOREIGN KEY ( location_id ) REFERENCES reference.location ( location_id )
);

CREATE INDEX fkIdx_63 ON setup.hub_peer_group
(
 location_id
);








-- ************************************** setup.member_profile

CREATE TABLE setup.member_profile
(
 member_profile_ip varchar(32) NOT NULL,
 location_id       uuid NOT NULL,
 name              varchar(72) NOT NULL,
 hash_value        bytea NULL,
 create_date       date NOT NULL,
 "source"            varchar(64) NOT NULL,
 CONSTRAINT PK_member_profile PRIMARY KEY ( member_profile_ip ),
 CONSTRAINT FK_88 FOREIGN KEY ( location_id ) REFERENCES reference.location ( location_id )
);

CREATE INDEX fkIdx_89 ON setup.member_profile
(
 location_id
);








-- ************************************** setup.hub_profile

CREATE TABLE setup.hub_profile
(
 hub_profile_ip varchar(32) NOT NULL,
 location_id    uuid NOT NULL,
 name           varchar(64) NOT NULL,
 hash_value     bytea NULL,
 create_date    date NOT NULL,
 "source"         varchar(72) NOT NULL,
 CONSTRAINT PK_profile PRIMARY KEY ( hub_profile_ip ),
 CONSTRAINT FK_82 FOREIGN KEY ( location_id ) REFERENCES reference.location ( location_id )
);

CREATE INDEX fkIdx_83 ON setup.hub_profile
(
 location_id
);








-- ************************************** setup.member_route

CREATE TABLE setup.member_route
(
 member_route_id   uuid NOT NULL DEFAULT uuid_generate_v4(),
 member_profile_ip varchar(32) NOT NULL,
 hub_profile_ip    varchar(32) NOT NULL,
 CONSTRAINT PK_hub_peer_group_member PRIMARY KEY ( member_route_id ),
 CONSTRAINT FK_76 FOREIGN KEY ( member_profile_ip ) REFERENCES setup.member_profile ( member_profile_ip ),
 CONSTRAINT FK_85 FOREIGN KEY ( hub_profile_ip ) REFERENCES setup.hub_profile ( hub_profile_ip )
);

CREATE INDEX fkIdx_77 ON setup.member_route
(
 member_profile_ip
);

CREATE INDEX fkIdx_86 ON setup.member_route
(
 hub_profile_ip
);








-- ************************************** setup.hub_route

CREATE TABLE setup.hub_route
(
 route_id       uuid NOT NULL DEFAULT uuid_generate_v4(),
 hub_profile_ip varchar(32) NOT NULL,
 peer_group_ip   varchar(32) NOT NULL,
 CONSTRAINT PK_hub_peer_group PRIMARY KEY ( route_id ),
 CONSTRAINT FK_47 FOREIGN KEY ( hub_profile_ip ) REFERENCES setup.hub_profile ( hub_profile_ip ),
 CONSTRAINT FK_56 FOREIGN KEY ( peer_group_ip ) REFERENCES setup.hub_peer_group ( peer_group_ip )
);

CREATE INDEX fkIdx_48 ON setup.hub_route
(
 hub_profile_ip
);

CREATE INDEX fkIdx_57 ON setup.hub_route
(
 peer_group_ip
);








-- ************************************** setup.alternate_member_route

CREATE TABLE setup.alternate_member_route
(
 alternate_id      uuid NOT NULL DEFAULT uuid_generate_v4(),
 peer_group_ip      varchar(32) NOT NULL,
 member_profile_ip varchar(32) NOT NULL,
 CONSTRAINT PK_alternate_member_route PRIMARY KEY ( alternate_id ),
 CONSTRAINT FK_94 FOREIGN KEY ( peer_group_ip ) REFERENCES setup.hub_peer_group ( peer_group_ip ),
 CONSTRAINT FK_97 FOREIGN KEY ( member_profile_ip ) REFERENCES setup.member_profile ( member_profile_ip )
);

CREATE INDEX fkIdx_95 ON setup.alternate_member_route
(
 peer_group_ip
);

CREATE INDEX fkIdx_98 ON setup.alternate_member_route
(
 member_profile_ip
);

CREATE TABLE IF NOT EXISTS  message.outgoing (id uuid NOT NULL DEFAULT uuid_generate_v4(),
							  type varchar(32),
							  date date,
							  payload varchar(64) );
							  
CREATE OR REPLACE  FUNCTION notify_event() RETURNS TRIGGER AS $$

    DECLARE 
        data json;
        notification json;
    BEGIN
       
        IF (TG_OP = 'INSERT') THEN
            data = row_to_json(NEW);
		END IF;
        
        -- Contruct the notification .
        notification = json_build_object( 'table',TG_TABLE_NAME,
                          'action', TG_OP,
                        'data', data);
				
		PERFORM pg_notify('events',notification::text);
          -- Result is ignored since this is an AFTER trigger
        RETURN NULL; 
    END;
    
$$ LANGUAGE plpgsql; 

DROP TRIGGER IF EXISTS message_notify_event on message.outgoing CASCADE;

CREATE TRIGGER message_notify_event
AFTER INSERT ON message.outgoing    
    FOR EACH ROW EXECUTE PROCEDURE notify_event();

CREATE TABLE stage.location
(
    location_id uuid NOT NULL DEFAULT uuid_generate_v4(),
    name character varying(72) COLLATE pg_catalog."default" NOT NULL,
    latitude character varying(16) COLLATE pg_catalog."default" NOT NULL,
    longitude character varying(16) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_location PRIMARY KEY (location_id)
)

TABLESPACE pg_default;

ALTER TABLE reference.location
    OWNER to postgres;

CREATE OR REPLACE  FUNCTION notify_event2() RETURNS TRIGGER AS $$
     
	 DECLARE 
        j_data json;
		      
    BEGIN
       
        IF (TG_OP = 'INSERT') THEN
			j_data = row_to_json(NEW);
	    END IF;
        
		PERFORM pg_notify('events',j_data::text );
	    --RAISE NOTICE 'NEW is currently %', j_data;   --for TESTING
        -- Result is ignored since this is an AFTER trigger
        RETURN NULL; 
    END;
    
$$ LANGUAGE plpgsql; 


COMMIT TRANSACTION;






