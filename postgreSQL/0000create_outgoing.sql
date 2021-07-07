CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

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
	




