
CREATE TABLE Users (
 login VARCHAR(64) PRIMARY KEY,
 pwd VARCHAR(64),
 name VARCHAR(64)
) ;

CREATE TABLE Documents (
id INTEGER PRIMARY KEY,
title VARCHAR(64),
creator VARCHAR(64) REFERENCES Users(login)
) ;

CREATE TABLE Versions (
 num INTEGER PRIMARY KEY,
 doc INTEGER REFERENCES Documents(id),
 contrib VARCHAR(64) REFERENCES Users(login)
) ;

 INSERT INTO Users (login, pwd, name) VALUES ('karl', 'marx', 'Karl Marx') ;
 INSERT INTO Users (login, pwd, name) VALUES ('al', 'ecm2', 'Albert Einstein') ;
 INSERT INTO Users (login, pwd, name) VALUES ('stc', 'nf17', 'Stéphane Crozat') ;
 INSERT INTO Users (login, pwd, name) VALUES ('paul', 'mot', 'Paul Pagnol') ;

 INSERT INTO Documents (id, title, creator) VALUES (1, 'Le Capital', 'karl') ;
 INSERT INTO Documents (id, title, creator) VALUES (2, 'La théorie de la relativité restreinte et générale', 'al') ;
 INSERT INTO Documents (id, title, creator) VALUES (3, 'Les bases de données', 'stc') ;

INSERT INTO Versions (num, doc, contrib) VALUES (1, 1, 'karl') ;
INSERT INTO Versions (num, doc, contrib) VALUES (2, 1, 'karl') ;
INSERT INTO Versions (num, doc, contrib) VALUES (3, 1, 'karl') ;
INSERT INTO Versions (num, doc, contrib) VALUES (4, 2, 'al') ;
INSERT INTO Versions (num, doc, contrib) VALUES (5, 2, 'stc') ;
INSERT INTO Versions (num, doc, contrib) VALUES (6, 3, 'stc') ;