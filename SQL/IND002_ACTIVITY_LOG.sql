ALTER TABLE `ACTIVITY_LOG` ENGINE = InnoDB;
CREATE INDEX user_log ON ACTIVITY_LOG (USER);
ALTER TABLE `ACTIVITY_LOG` 
ADD CONSTRAINT user_of_log FOREIGN KEY ( `USER` ) 
REFERENCES `USERS` (`ID` );