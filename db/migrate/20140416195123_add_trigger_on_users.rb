class AddTriggerOnUsers < ActiveRecord::Migration
  def up
    sql =<<STR

CREATE OR REPLACE FUNCTION log_user_activity_func() RETURNS TRIGGER AS $$
    BEGIN
        IF (TG_OP = 'DELETE') THEN
            INSERT INTO logs(message) VALUES(concat('delete-', OLD.name));
        ELSIF (TG_OP = 'UPDATE') THEN
            INSERT INTO logs(message) VALUES(concat('update-', NEW.name));
        ELSIF (TG_OP = 'INSERT') THEN
            INSERT INTO logs(message) VALUES(concat('insert-', NEW.name));
        END IF;
        RETURN NULL;
    END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS log_user_activity_trigger
ON users;

CREATE TRIGGER log_user_activity_trigger
AFTER INSERT OR UPDATE OR DELETE ON users
    FOR EACH ROW EXECUTE PROCEDURE log_user_activity_func();


STR
    execute sql
  end

  def down

  end
end
