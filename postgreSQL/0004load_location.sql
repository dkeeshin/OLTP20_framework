
SELECT * from stage.location;
--TRUNCATE table stage.location;

SELECT * from reference.location;
--TRUNCATE table reference.location CASCADE;

-- encode((sha256(CAST(( '40.692532'|| '-73.990997') as bytea))), 'hex')
INSERT INTO stage.location (locationid, name, latitude, longitude) SELECT encode((sha256(CAST(( '42.052158'|| '-87.687866') as bytea))), 'hex'),
'Evanston, IL USA', '42.052158','-87.687866';

INSERT INTO stage.location (locationid, name, latitude, longitude) SELECT encode((sha256(CAST(( '41.897217'|| '-87.6210423') as bytea))), 'hex'),
'Chicago, IL USA', '41.897217','-87.6210423';	

INSERT INTO stage.location (locationid, name, latitude, longitude) SELECT encode((sha256(CAST(( '42.1900249'|| '-87.9084039') as bytea))), 'hex'),
'LincolnShire, IL USA', '42.1900249','87.9084039';	

INSERT INTO stage.location (locationid, name, latitude, longitude) SELECT encode((sha256(CAST(( '40.692532'|| '-73.990997') as bytea))), 'hex'),
'Brooklyn, NY USA', '40.692532','-73.990997';	

INSERT INTO stage.location (locationid, name, latitude, longitude) SELECT encode((sha256(CAST(( '49.24966'|| '-123.11934') as bytea))), 'hex'),
'Vancouver BC CA', '49.24966','-123.11934';	
