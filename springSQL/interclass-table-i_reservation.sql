CREATE TABLE "HR"."I_RESERVATION" 
   ("RNUM" NUMBER, 
	"LECTURENUM" NUMBER(*,0), 
	"MID" VARCHAR2(20 BYTE), 
	"ORDERDATE" DATE DEFAULT sysdate, 
	"STARTDATE" VARCHAR2(10 BYTE), 
	"ONVALUE" NUMBER DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
  
REM INSERTING into HR.I_RESERVATION
SET DEFINE OFF;

CREATE UNIQUE INDEX "HR"."SYS_C007134" ON "HR"."I_RESERVATION" ("RNUM") 
PCTFREE 10 INITRANS 2 MAXTRANS 255 
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE "USERS" ;

ALTER TABLE "HR"."I_RESERVATION" ADD PRIMARY KEY ("RNUM")
USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE "USERS"  ENABLE;
  
ALTER TABLE "HR"."I_RESERVATION" ADD CONSTRAINT "FK_I_LECTURE" FOREIGN KEY ("LECTURENUM")
REFERENCES "HR"."I_LECTURECLASS" ("LECTURENUM") ON DELETE SET NULL ENABLE;
      
ALTER TABLE "HR"."I_RESERVATION" ADD CONSTRAINT "FK_I_MEMBER" FOREIGN KEY ("MID")
REFERENCES "HR"."I_MEMBER" ("MID") ON DELETE SET NULL ENABLE;