CREATE TABLE "states" (
	"id" SERIAL PRIMARY KEY,
	"name" TEXT NOT NULL
);

CREATE TABLE "cities" (
	"id" SERIAL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "stateId" INTEGER REFERENCES "states"("id") 
);

CREATE TABLE "customers" (
	"id" SERIAL PRIMARY KEY,
    "fullName" TEXT NOT NULL, 
    "cpf" VARCHAR(11) UNIQUE NOT NULL, 
    "email" TEXT UNIQUE NOT NULL ,
    "password" TEXT NOT NULL
);

CREATE TABLE "bankAccount" (
	"id" SERIAL PRIMARY KEY,
	"customerId" INTEGER REFERENCES "customers"("id"),
    "accountNumber" TEXT NOT NULL UNIQUE , 
    "agency" TEXT NOT NULL ,
    "openDate" TIMESTAMP NOT NULL DEFAULT NOW() ,
    "closeDate" TIMESTAMP DEFAULT NULL
);

CREATE TABLE "customerAddresses" (
	"id" SERIAL PRIMARY KEY,
	"customerId" INTEGER UNIQUE REFERENCES "customers"("id"),
    "street" TEXT NOT NULL,
    "number" INTEGER NOT NULL ,
    "complement"  TEXT,
    "postalCode" VARCHAR(8) NOT NULL,
    "cityId" INTEGER REFERENCES "cities"("id") 
);

CREATE TABLE "customerPhones" (
	"id" SERIAL PRIMARY KEY,
	"customerId" INTEGER REFERENCES "customers"("id"),
    "number" VARCHAR(11) UNIQUE NOT NULL,
    "type" TEXT NOT NULL,
    CONSTRAINT CHK_type CHECK (type='landline' OR type ='mobile')
);

CREATE TABLE "transactions" (
	"id" SERIAL PRIMARY KEY,
    "bankAccountId" INTEGER REFERENCES "bankAccount"("id"), 
    "amount" INTEGER NOT NULL, 
    "type" TEXT NOT NULL ,
    "time" TIMESTAMP NOT NULL DEFAULT NOW(), 
    "description" TEXT , 
    "cancelled" BOOLEAN NOT NULL DEFAULT false
    CONSTRAINT CHK_type CHECK (type='deposit' OR type ='withdraw')
);

CREATE TABLE "creditCards" (
	"id" SERIAL PRIMARY KEY,
    "bankAccountId" INTEGER REFERENCES "bankAccount"("id"), 
    "name" TEXT NOT NULL,
    "number" TEXT NOT NULL,
    "securityCode" VARCHAR(4) NOT NULL , 
    "expirationYear" TIMESTAMP NOT NULL,
    "password" TEXT NOT NULL ,
    "limit" INTEGER NOT NULL
);