CREATE TABLE IF NOT EXISTS temp.location
(
 locationid varchar(64) NOT NULL,
 name        varchar(72) NOT NULL,
 latitude    varchar(16) NOT NULL,
 longitude  varchar(16) NOT NULL,
 CONSTRAINT PK_location PRIMARY KEY ( locationid )
);


CREATE PROCEDURE temp.up_add_location(
   p_locationid varchar,
   p_name varchar, 
   p_latitude varchar,
   p_longitude varchar	
)
AS $$
BEGIN
   
	INSERT INTO temp.location (locationid, name, latitude, longitude) VALUES (p_locationid,
	p_name, p_latitude,p_longitude);

END;
$$
LANGUAGE plpgsql ;
