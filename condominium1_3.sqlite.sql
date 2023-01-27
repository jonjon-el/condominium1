BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "persons" (
	"id"	INTEGER NOT NULL,
	"nic"	VARCHAR(20) NOT NULL UNIQUE,
	"firstName"	VARCHAR(50) NOT NULL,
	"lastName"	VARCHAR(50) NOT NULL,
	"birthDay"	INTEGER NOT NULL,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "properties" (
	"id"	INTEGER NOT NULL,
	"name"	VARCHAR(20) NOT NULL UNIQUE,
	"alicuota"	NUMERIC(10, 2) NOT NULL,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "payments" (
	"id"	INTEGER NOT NULL,
	"id_property"	VARCHAR(20) NOT NULL,
	"id_person"	INTEGER NOT NULL,
	"amount"	NUMERIC(10, 2) NOT NULL,
	"date"	INTEGER NOT NULL,
	"id_bank"	VARCHAR(20) UNIQUE,
	PRIMARY KEY("id"),
	FOREIGN KEY("id_property") REFERENCES "properties"("id"),
	FOREIGN KEY("id_person") REFERENCES "persons"("id")
);
CREATE TABLE IF NOT EXISTS "debts" (
	"id"	INTEGER NOT NULL,
	"id_person"	INTEGER NOT NULL,
	"amount"	NUMERIC(10, 2) NOT NULL,
	"date"	INTEGER NOT NULL,
	PRIMARY KEY("id"),
	FOREIGN KEY("id_person") REFERENCES "persons"("id")
);
CREATE TABLE IF NOT EXISTS "propietaries" (
	"id_owner"	INTEGER NOT NULL,
	"id_property"	INTEGER NOT NULL,
	FOREIGN KEY("id_property") REFERENCES "properties"("id"),
	FOREIGN KEY("id_owner") REFERENCES "persons"("id")
);
CREATE TABLE IF NOT EXISTS "kinds" (
	"id"	INTEGER,
	"description"	TEXT NOT NULL,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "debts_contracted" (
	"id"	INTEGER,
	"id_person"	INTEGER NOT NULL,
	"amount"	REAL NOT NULL,
	"date"	INTEGER NOT NULL,
	"kind"	INTEGER NOT NULL,
	"reason"	TEXT,
	FOREIGN KEY("id_person") REFERENCES "persons"("id"),
	FOREIGN KEY("kind") REFERENCES "kinds"("id"),
	PRIMARY KEY("id")
);
INSERT INTO "persons" VALUES (1,'18166030','Nelson Antonio','Sandoval Puente',592531200);
INSERT INTO "persons" VALUES (2,'21457069','Timothy Nelson Andrés','Sandoval Puente',645667200);
INSERT INTO "persons" VALUES (3,'8002451','Judith Gerarda','Puente Sosa',-358128000);
INSERT INTO "persons" VALUES (4,'4829858','Nelson Antonio','Sandoval',-415756800);
INSERT INTO "persons" VALUES (5,'j','','',0);
INSERT INTO "properties" VALUES (1,'A4-4',0.0167);
INSERT INTO "properties" VALUES (2,'A4-5',0.0167);
INSERT INTO "properties" VALUES (3,'B4-1',0.032);
INSERT INTO "properties" VALUES (4,'A4-6',0.0167);
INSERT INTO "properties" VALUES (5,'A4-3',0.0167);
INSERT INTO "payments" VALUES (1,'1',1,20,0,'1');
INSERT INTO "payments" VALUES (2,'1',2,300,31536000,'2');
INSERT INTO "debts" VALUES (1,1,10,0);
INSERT INTO "debts" VALUES (2,4,100,0);
INSERT INTO "propietaries" VALUES (1,1);
INSERT INTO "propietaries" VALUES (1,2);
INSERT INTO "propietaries" VALUES (3,3);
INSERT INTO "propietaries" VALUES (4,3);
INSERT INTO "propietaries" VALUES (2,4);
INSERT INTO "kinds" VALUES (1,'salary');
INSERT INTO "kinds" VALUES (2,'material');
INSERT INTO "kinds" VALUES (3,'service');
INSERT INTO "kinds" VALUES (4,'building');
INSERT INTO "debts_contracted" VALUES (1,1,100.0,1669766400,1,NULL);
INSERT INTO "debts_contracted" VALUES (2,2,25.0,1669766400,1,NULL);
INSERT INTO "debts_contracted" VALUES (3,2,50.0,0,3,'main door');
COMMIT;
