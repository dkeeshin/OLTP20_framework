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
 "id"           varchar(64) NOT NULL,
 member_ip    varchar(50) NULL,
 peer_group_ip varchar(50) NULL,
 CONSTRAINT PK_route_map PRIMARY KEY ( "id" )
);


-- ************************************** reference.location

CREATE TABLE reference.location
(
 locationid varchar(64) NOT NULL,
 name        varchar(72) NOT NULL,
 latitude    varchar(16) NOT NULL,
 longitude  varchar(16) NOT NULL,
 CONSTRAINT PK_location PRIMARY KEY ( locationid )
);




-- ************************************** setup.hub_peer_group

CREATE TABLE setup.hub_peer_group
(
 peer_group_ip varchar(24) NOT NULL,
 locationid varchar(64)  NOT NULL,
 name         varchar(72) NOT NULL,
 enable         boolean NOT NULL,
 hash_value   varchar(64) NULL,
 create_date  date NOT NULL,
 "source"       varchar(64) NOT NULL,
 CONSTRAINT PK_group_hub PRIMARY KEY ( peer_group_ip ),
 CONSTRAINT FK_62 FOREIGN KEY ( locationid ) REFERENCES reference.location ( locationid )
);

CREATE INDEX fkIdx_63 ON setup.hub_peer_group
(
 locationid
);








-- ************************************** setup.member_profile

CREATE TABLE setup.member_profile
(
 member_profile_ip varchar(24) NOT NULL,
 locationid varchar(64)  NOT NULL,
 name              varchar(72) NOT NULL,
 enable             boolean NOT NULL,
 hash_value        varchar(64) NULL,
 create_date       date NOT NULL,
 "source"            varchar(64) NOT NULL,
 CONSTRAINT PK_member_profile PRIMARY KEY ( member_profile_ip ),
 CONSTRAINT FK_88 FOREIGN KEY ( locationid ) REFERENCES reference.location ( locationid )
);

CREATE INDEX fkIdx_89 ON setup.member_profile
(
 locationid
);








-- ************************************** setup.hub_profile

CREATE TABLE setup.hub_profile
(
 hub_profile_ip varchar(24) NOT NULL,
locationid varchar(64)  NOT NULL,
 name           varchar(64) NOT NULL,
 hash_value     varchar(64) NULL,
 create_date    date NOT NULL,
 "source"         varchar(72) NOT NULL,
 CONSTRAINT PK_profile PRIMARY KEY ( hub_profile_ip ),
 CONSTRAINT FK_82 FOREIGN KEY ( locationid ) REFERENCES reference.location ( locationid )
);

CREATE INDEX fkIdx_83 ON setup.hub_profile
(
 locationid
);








-- ************************************** setup.member_route

CREATE TABLE setup.member_route
(
 member_route_id   varchar(64) NOT NULL,
 member_profile_ip varchar(24) NOT NULL,
 hub_profile_ip    varchar(24) NOT NULL,
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
 route_id       varchar(64) NOT NULL,
 hub_profile_ip varchar(24) NOT NULL,
 peer_group_ip   varchar(24) NOT NULL,
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
 alternate_id      varchar(64) NOT NULL,
 peer_group_ip      varchar(24) NOT NULL,
 member_profile_ip varchar(24) NOT NULL,
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

CREATE TABLE IF NOT EXISTS  message.outgoing (id varchar(64) NOT NULL,
							  type varchar(24),
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
    locationid varchar(64) NOT NULL ,
    name character varying(72) COLLATE pg_catalog."default" NOT NULL,
    latitude character varying(16) COLLATE pg_catalog."default" NOT NULL,
    longitude character varying(16) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_location PRIMARY KEY (locationid)
)

TABLESPACE pg_default;

ALTER TABLE reference.location
    OWNER to postgres;

CREATE OR REPLACE  FUNCTION notify_event_02() RETURNS TRIGGER AS $$
     
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


DROP TRIGGER IF EXISTS stage_location_notify_event ON stage.location CASCADE;

CREATE TRIGGER stage_location_notify_event
    AFTER INSERT
    ON stage.location
    FOR EACH ROW
    EXECUTE FUNCTION public.notify_event_02();



-- drop function setup.uf_get_peer_group_ip();
create function setup.uf_get_peer_group_ip()
returns table (ip varchar)
language plpgsql
as
$$
begin
return query
   select peer_group_ip 
   from setup.hub_peer_group where enable = true;
end;
$$;

--notice syntax
CREATE PROCEDURE reference.up_add_location(
   p_locationid varchar,
   p_name varchar, 
   p_latitude varchar,
   p_longitude varchar	
)
AS $$
BEGIN
   
	INSERT INTO reference.location (locationid, name, latitude, longitude) VALUES (p_locationid,
	p_name, p_latitude,p_longitude);

END;
$$
LANGUAGE plpgsql ;


COMMIT TRANSACTION;






