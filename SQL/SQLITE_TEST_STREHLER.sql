CREATE TABLE USERS
(ID INTEGER PRIMARY KEY AUTOINCREMENT,
 USER VARCHAR(50),
 PASSWORD CHAR(32),
 ROLE VARCHAR(50));
CREATE TABLE CATEGORIES
(ID INTEGER PRIMARY KEY AUTOINCREMENT,
  CATEGORY VARCHAR(120)
);
CREATE TABLE TAGS
(ID INTEGER PRIMARY KEY AUTOINCREMENT,
 TAG VARCHAR(120),
 ITEM_ID INTEGER,
 ITEM_TYPE VARCHAR(20)
);
CREATE TABLE CONFIGURED_TAGS
(ID INTEGER PRIMARY KEY AUTOINCREMENT,
 TAG VARCHAR(120),
 CATEGORY_ID INTEGER,
 ITEM_TYPE VARCHAR(20),
 DEFAULT_TAG TINYINT(1)
);
CREATE TABLE ARTICLES
(ID INTEGER PRIMARY KEY AUTOINCREMENT,
 IMAGE VARCHAR(50),
 CATEGORY INTEGER,
 DISPLAY_ORDER INTEGER,
 PUBLISH_DATE TIMESTAMP,
 PUBLISHED TINYINT(1)
);
CREATE TABLE CONTENTS
(ID INTEGER PRIMARY KEY AUTOINCREMENT,
 ARTICLE INTEGER,
 TITLE VARCHAR(120),
 SLUG VARCHAR(120),
 TEXT LONGTEXT,
 LANGUAGE VARCHAR(2));
CREATE TABLE IMAGES
(ID INTEGER PRIMARY KEY AUTOINCREMENT,
 IMAGE VARCHAR(50),
 CATEGORY INTEGER
);
CREATE TABLE DESCRIPTIONS
(ID INTEGER PRIMARY KEY AUTOINCREMENT,
 IMAGE INTEGER,
 TITLE VARCHAR(50),
 DESCRIPTION TEXT,
 LANGUAGE VARCHAR(2));
ALTER TABLE CATEGORIES
ADD PARENT INTEGER DEFAULT NULL;
DROP TABLE IF EXISTS USERS;
CREATE TABLE USERS
(ID INTEGER PRIMARY KEY AUTOINCREMENT,
 USER VARCHAR(50),
 PASSWORD_HASH CHAR(31),
 PASSWORD_SALT CHAR(22),
 ROLE VARCHAR(50));
DROP TABLE IF EXISTS ARTICLES;
CREATE TABLE ARTICLES
(ID INTEGER PRIMARY KEY AUTOINCREMENT,
 IMAGE VARCHAR(50),
 CATEGORY INTEGER,
 DISPLAY_ORDER INTEGER,
 PUBLISH_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 PUBLISHED TINYINT(1)
);
CREATE TABLE ACTIVITY_LOG
(ID INTEGER PRIMARY KEY AUTOINCREMENT,
 USER VARCHAR(100),
 ACTION VARCHAR(100),
 ENTITY_TYPE VARCHAR(100),
 ENTITY_ID INTEGER,
 TIMESTAMP TIMESTAMP
);
DROP TABLE IF EXISTS ARTICLES;
CREATE TABLE ARTICLES
(ID INTEGER PRIMARY KEY AUTOINCREMENT,
 IMAGE VARCHAR(50),
 CATEGORY INTEGER,
 DISPLAY_ORDER INTEGER,
 PUBLISH_DATE DATE,
 PUBLISHED TINYINT(1)
);
DROP TABLE IF EXISTS ACTIVITY_LOG;
CREATE TABLE ACTIVITY_LOG
(ID INTEGER PRIMARY KEY AUTOINCREMENT,
 USER VARCHAR(100),
 ACTION VARCHAR(100),
 ENTITY_TYPE VARCHAR(100),
 ENTITY_ID INTEGER,
 TIMESTAMP DATETIME
);
INSERT INTO USERS (USER, PASSWORD_HASH, PASSWORD_SALT, ROLE) 
VALUES ('admin', 'SnbwVypRtNBehDfZrMMUKEIVfCEDZcW', 
'AdFvGp4nXVVfj984NWlYI.', 'admin');
INSERT INTO USERS (USER, PASSWORD_HASH, PASSWORD_SALT, ROLE) VALUES ('editor', 'eeweUXIyBjo57zOGiMgL8o8w9U.nWfa', 'cyQydJO6C6mxueKrDdFAE.', 'editor');