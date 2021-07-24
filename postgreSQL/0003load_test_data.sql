BEGIN TRANSACTION;

DO $$
DECLARE v_location_id bytea;
	p_name varchar;
	p_latitude varchar;
	p_longitude varchar;
BEGIN
	SELECT sha256(CAST(( '42.052158'|| '-87.687866') as bytea)), 'Evanston, IL USA', '42.052158','-87.687866'
	into v_location_id, p_name, p_latitude, p_longitude;
	
	call reference.up_add_location(v_location_id, p_name, p_latitude, p_longitude);
	
	SELECT sha256(CAST(( '42.1900249'|| '-87.9084039') as bytea)),
    'LincolnShire, IL USA', '42.1900249','87.9084039' into v_location_id, p_name, p_latitude, p_longitude;	
	
	call reference.up_add_location(v_location_id, p_name, p_latitude, p_longitude);
	
	SELECT sha256(CAST(( '41.897217'|| '-87.6210423') as bytea)),
	'Chicago, IL USA', '41.897217','-87.6210423' into v_location_id, p_name, p_latitude, p_longitude;	

	call reference.up_add_location(v_location_id, p_name, p_latitude, p_longitude);
	
	 SELECT sha256(CAST(( '40.692532'|| '-73.990997') as bytea)),
	'Brooklyn, NY USA', '40.692532','-73.990997' into v_location_id, p_name, p_latitude, p_longitude;
	
	call reference.up_add_location(v_location_id, p_name, p_latitude, p_longitude);

END $$;

do $$
declare id reference.location.location_id%type;

begin
select location_id from reference.location
into id WHERE name like 'Evanston%';

INSERT INTO setup.hub_profile (hub_profile_ip, location_id, name, create_date, source) 
VALUES ('localhost:50051', id, 'North Hub', '2021-07-08', 'kDS');
end; $$;

--select * from reference.location;

do $$

declare id reference.location.location_id%type;

begin
select location_id from reference.location
into id WHERE name like 'Lincoln%';

INSERT INTO setup.hub_peer_group (peer_group_ip,  location_id, name, create_date, source) 
VALUES ('localhost:50052', id , 'West Hub', '2021-07-08', 'kDS');

end; $$;

do $$

declare id reference.location.location_id%type;

begin
select location_id from reference.location
into id WHERE name like 'Chicago%';

INSERT INTO setup.hub_peer_group (peer_group_ip,  location_id, name, create_date, source) 
VALUES ('localhost:50053', id , 'South Hub', '2021-07-08', 'kDS');

end; $$;

do $$

declare id reference.location.location_id%type;

begin
select location_id from reference.location
into id WHERE name like 'Brookl%';

INSERT INTO setup.hub_peer_group (peer_group_ip,  location_id, name, create_date, source) 
VALUES ('localhost:50054', id , 'East Hub', '2021-07-08', 'kDS');

end; $$;

INSERT INTO setup.hub_route (route_id, hub_profile_ip, peer_group_ip ) SELECT sha256(CAST(( 'localhost:50051'||'localhost:50052') as bytea)), 'localhost:50051', 'localhost:50052';   
INSERT INTO setup.hub_route (route_id, hub_profile_ip, peer_group_ip ) SELECT sha256(CAST(( 'localhost:50051'||'localhost:50053') as bytea)), 'localhost:50051', 'localhost:50053';   
INSERT INTO setup.hub_route (route_id, hub_profile_ip, peer_group_ip ) SELECT sha256(CAST(( 'localhost:50051'||'localhost:50054') as bytea)), 'localhost:50051', 'localhost:50054';   

do $$

declare id reference.location.location_id%type;
begin
select location_id from reference.location
into id WHERE name like 'Evanston%';

INSERT INTO setup.member_profile (member_profile_ip, location_id, name, create_date, source) 
VALUES ('localhost:50055', id, 'Member A', '2021-07-08', 'kDS');

INSERT INTO setup.member_profile (member_profile_ip, location_id, name, create_date, source) 
VALUES ('localhost:50056', id, 'Member B', '2021-07-08', 'kDS');

INSERT INTO setup.member_profile (member_profile_ip, location_id, name, create_date, source) 
VALUES ('localhost:50057', id, 'Member C', '2021-07-08', 'kDS');


INSERT INTO setup.member_route (member_route_id, member_profile_ip, hub_profile_ip ) SELECT sha256(CAST(( 'localhost:50055'||'localhost:50051') as bytea)), 'localhost:50055', 'localhost:50051';   
INSERT INTO setup.member_route (member_route_id, member_profile_ip, hub_profile_ip ) SELECT sha256(CAST(( 'localhost:50056'||'localhost:50051') as bytea)), 'localhost:50056', 'localhost:50051';   
INSERT INTO setup.member_route (member_route_id, member_profile_ip, hub_profile_ip ) SELECT sha256(CAST(( 'localhost:50057'||'localhost:50051') as bytea)), 'localhost:50057', 'localhost:50051';   

end; $$;


COMMIT;










