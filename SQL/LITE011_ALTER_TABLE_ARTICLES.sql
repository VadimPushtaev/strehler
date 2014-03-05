DROP TABLE IF EXISTS ARTICLES;
CREATE TABLE ARTICLES
(ID INTEGER PRIMARY KEY AUTO_INCREMENT,
 IMAGE VARCHAR(50),
 CATEGORY INTEGER,
 DISPLAY_ORDER INTEGER,
 PUBLISH_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 PUBLISHED TINYINT(1)
);
