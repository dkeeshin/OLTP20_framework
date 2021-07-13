BEGIN TRANSACTION;
INSERT INTO reference.location (name, latitude, longitude) VALUES ('Evanston, IL USA', '42.052158', '-87.687866');
INSERT INTO reference.location (name, latitude, longitude) VALUES ('Lincolnshire, IL USA', '42.1900249', '-87.9084039');
INSERT INTO reference.location (name, latitude, longitude) VALUES ('Chicago, IL USA', '41.897217','-87.6210423');
INSERT INTO reference.location (name, latitude, longitude) VALUES ('Brooklyn, NY USA', '40.692532','-73.990997');

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

INSERT INTO setup.hub_route (hub_profile_ip, peer_group_ip ) VALUES ('localhost:50051', 'localhost:50052' );   
INSERT INTO setup.hub_route (hub_profile_ip, peer_group_ip ) VALUES ('localhost:50051', 'localhost:50053' );   
INSERT INTO setup.hub_route (hub_profile_ip, peer_group_ip ) VALUES ('localhost:50051', 'localhost:50054' );   

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


INSERT INTO setup.member_route (member_profile_ip, hub_profile_ip ) VALUES ('localhost:50055', 'localhost:50051' );   
INSERT INTO setup.member_route (member_profile_ip,  hub_profile_ip ) VALUES ('localhost:50056', 'localhost:50051' );   
INSERT INTO setup.member_route (member_profile_ip,  hub_profile_ip ) VALUES ('localhost:50057', 'localhost:50051' );   

end; $$;


COMMIT;








