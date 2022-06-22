------------------------------------------------------
/*  DDL for Table APPLICATION_PARAMS*/
------------------------------------------------------

CREATE TABLE APPLICATION_PARAMS (
	CODE        VARCHAR2(30 CHAR),
	NAME        VARCHAR2(200 CHAR),
	VALUE       VARCHAR2(200 CHAR),
	DESCRIPTION VARCHAR2(4000 CHAR),
	SCOPE       VARCHAR2(200 CHAR),
	PARAM_TYPE  VARCHAR2(50 CHAR) DEFAULT 'VARCHAR2',
	IS_EDITABLE VARCHAR2(20 CHAR) DEFAULT 1
);