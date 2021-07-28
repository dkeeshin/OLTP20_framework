BEGIN TRANSACTION;


do $$
begin

INSERT INTO reference.location (locationid, name, latitude, longitude) SELECT encode((sha256(CAST(( '42.052158'|| '-87.687866') as bytea))), 'hex'),
'Evanston, IL USA', '42.052158','-87.687866';

INSERT INTO reference.location (locationid, name, latitude, longitude) SELECT encode((sha256(CAST(( '41.897217'|| '-87.6210423') as bytea))), 'hex'),
'Chicago, IL USA', '41.897217','-87.6210423';	

INSERT INTO reference.location (locationid, name, latitude, longitude) SELECT encode((sha256(CAST(( '42.1900249'|| '-87.9084039') as bytea))), 'hex'),
'LincolnShire, IL USA', '42.1900249','87.9084039';	

INSERT INTO reference.location (locationid, name, latitude, longitude) SELECT encode((sha256(CAST(( '40.692532'|| '-73.990997') as bytea))), 'hex'),
'Brooklyn, NY USA', '40.692532','-73.990997';	

INSERT INTO stage.location (locationid, name, latitude, longitude) SELECT encode((sha256(CAST(( '49.24966'|| '-123.11934') as bytea))), 'hex'),
'Vancouver BC CA', '49.24966','-123.11934';	


end; $$;

do $$
declare id reference.location.locationid%type;

begin
select locationid from reference.location
into id WHERE name like 'Evanston%';

INSERT INTO setup.hub_profile (hub_profile_ip, locationid, name, create_date, source) 
VALUES ('localhost:50051', id, 'North Hub', '2021-07-08', 'kDS');
end; $$;

--select * from reference.location;

do $$

declare id reference.location.locationid%type;

begin
select locationid from reference.location
into id WHERE name like 'Lincoln%';

INSERT INTO setup.hub_peer_group (peer_group_ip,  locationid, name, enable, create_date, source) 
VALUES ('localhost:50052', id , 'West Hub', true, '2021-07-08', 'kDS');

end; $$;

do $$

declare id reference.location.locationid%type;

begin
select locationid from reference.location
into id WHERE name like 'Chicago%';

INSERT INTO setup.hub_peer_group (peer_group_ip,  locationid, name, enable, create_date, source) 
VALUES ('localhost:50053', id , 'South Hub', true, '2021-07-08', 'kDS');

end; $$;

do $$

declare id reference.location.locationid%type;

begin
select locationid from reference.location
into id WHERE name like 'Brookl%';

INSERT INTO setup.hub_peer_group (peer_group_ip,  locationid, name, enable, create_date, source) 
VALUES ('localhost:50054', id , 'East Hub', true, '2021-07-08', 'kDS');

end; $$;

INSERT INTO setup.hub_route (route_id, hub_profile_ip, peer_group_ip ) SELECT encode((sha256(CAST(( 'localhost:50051'||'localhost:50052') as bytea))), 'hex'), 'localhost:50051', 'localhost:50052';   
INSERT INTO setup.hub_route (route_id, hub_profile_ip, peer_group_ip ) SELECT encode((sha256(CAST(( 'localhost:50051'||'localhost:50053') as bytea))), 'hex'), 'localhost:50051', 'localhost:50053';   
INSERT INTO setup.hub_route (route_id, hub_profile_ip, peer_group_ip ) SELECT encode((sha256(CAST(( 'localhost:50051'||'localhost:50054') as bytea))), 'hex'), 'localhost:50051', 'localhost:50054';   

do $$

declare id reference.location.locationid%type;
begin
select locationid from reference.location
into id WHERE name like 'Evanston%';

INSERT INTO setup.member_profile (member_profile_ip, locationid, name, enable, create_date, source) 
VALUES ('localhost:50055', id, 'Member A', true, '2021-07-08', 'kDS');

INSERT INTO setup.member_profile (member_profile_ip, locationid, name, enable, create_date, source) 
VALUES ('localhost:50056', id, 'Member B',  true, '2021-07-08', 'kDS');

INSERT INTO setup.member_profile (member_profile_ip, locationid, name, enable, create_date, source) 
VALUES ('localhost:50057', id, 'Member C', true, '2021-07-08', 'kDS');


INSERT INTO setup.member_route (member_route_id, member_profile_ip, hub_profile_ip ) SELECT encode((sha256(CAST(( 'localhost:50055'||'localhost:50051') as bytea))), 'hex'), 'localhost:50055', 'localhost:50051';   
INSERT INTO setup.member_route (member_route_id, member_profile_ip, hub_profile_ip ) SELECT encode((sha256(CAST(( 'localhost:50056'||'localhost:50051') as bytea))), 'hex'), 'localhost:50056', 'localhost:50051';   
INSERT INTO setup.member_route (member_route_id, member_profile_ip, hub_profile_ip ) SELECT encode((sha256(CAST(( 'localhost:50057'||'localhost:50051') as bytea))), 'hex'), 'localhost:50057', 'localhost:50051';   

end; $$;


COMMIT;










