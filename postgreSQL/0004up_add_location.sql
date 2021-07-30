create or replace procedure reference.up_add_location(
   v_name varchar,
   v_latitude varchar, 
   v_longitude varchar
)
language plpgsql    
as $$
begin

	INSERT INTO stage.location (locationid, name, latitude, longitude) SELECT encode((sha256(CAST(( v_latitude||v_longitude) as bytea))), 'hex'),
	v_name, v_latitude,v_longitude;	
	commit;
	
end;$$


