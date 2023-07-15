-- ============================================================================= 
-- This conversion script was created to migrate from Sakai 22.3 to Sakai 23.0
-- If your migrating from a previous release run all the appropriate scripts
--   until 22.3
-- If your migrating from a post 22.3 release to 23.0 you should review the post
--   scripts make adjustments as necessary
-- ============================================================================= 

-- clear unchanged bundle properties
DELETE SAKAI_MESSAGE_BUNDLE from SAKAI_MESSAGE_BUNDLE where PROP_VALUE is NULL;

-- SAK-48444
CREATE TABLE PINNED_SITES
  (
     ID       BIGINT AUTO_INCREMENT NOT NULL,
     POSITION INT NOT NULL,
     SITE_ID  VARCHAR(99) NOT NULL,
     USER_ID  VARCHAR(99) NOT NULL,
     CONSTRAINT PK_PINNED_SITES PRIMARY KEY (ID)
  );

ALTER TABLE PINNED_SITES ADD CONSTRAINT UNIQUEPINNING UNIQUE (USER_ID, SITE_ID);

CREATE INDEX pinned_sites_site_idx ON PINNED_SITES(SITE_ID);
CREATE INDEX pinned_sites_user_idx ON PINNED_SITES(USER_ID);

CREATE TABLE RECENT_SITES
  (
     ID      BIGINT AUTO_INCREMENT NOT NULL,
     CREATED DATETIME NOT NULL,
     SITE_ID VARCHAR(99) NOT NULL,
     USER_ID VARCHAR(99) NOT NULL,
     CONSTRAINT PK_RECENT_SITES PRIMARY KEY (ID)
  );

ALTER TABLE RECENT_SITES ADD CONSTRAINT UniqueRecentSite UNIQUE (USER_ID, SITE_ID);

CREATE INDEX recent_sites_site_idx ON RECENT_SITES(SITE_ID);
CREATE INDEX recent_sites_user_idx ON RECENT_SITES(USER_ID);

-- END SAK-48444

-- SAK-47852
CREATE TABLE PLUS_CONTEXT
  (
     CONTEXT_GUID        VARCHAR(36) NOT NULL,
     CREATED_AT          DATETIME DEFAULT NULL NULL,
     DEBUG_LOG           LONGTEXT NULL,
     DELETED             BIT DEFAULT 0 NULL,
     DELETED_AT          DATETIME DEFAULT NULL NULL,
     DELETOR             VARCHAR(99) NULL,
     JSON                LONGTEXT NULL,
     LOGIN_AT            DATETIME DEFAULT NULL NULL,
     LOGIN_COUNT         INT DEFAULT NULL NULL,
     LOGIN_IP            VARCHAR(64) NULL,
     LOGIN_USER          VARCHAR(99) NULL,
     MODIFIED_AT         DATETIME DEFAULT NULL NULL,
     MODIFIER            VARCHAR(99) NULL,
     SENT_AT             DATETIME DEFAULT NULL NULL,
     STATUS              VARCHAR(200) NULL,
     SUCCESS             BIT DEFAULT 0 NULL,
     UPDATED_AT          DATETIME DEFAULT NULL NULL,
     CONTEXT             VARCHAR(200) NOT NULL,
     CONTEXT_MEMBERSHIPS VARCHAR(500) NULL,
     DEPLOYMENT_ID       VARCHAR(200) NULL,
     GRADE_TOKEN         VARCHAR(500) NULL,
     LABEL               VARCHAR(500) NULL,
     LINEITEMS           VARCHAR(500) NULL,
     LINEITEMS_TOKEN     VARCHAR(500) NULL,
     NRPS_JOB_COUNT      BIGINT DEFAULT NULL NULL,
     NRPS_JOB_FINISH     DATETIME DEFAULT NULL NULL,
     NRPS_JOB_START      DATETIME DEFAULT NULL NULL,
     NRPS_JOB_STATUS     VARCHAR(500) NULL,
     NRPS_TOKEN          VARCHAR(500) NULL,
     SAKAI_SITE_ID       VARCHAR(99) NULL,
     TITLE               VARCHAR(500) NULL,
     TENANT_GUID         VARCHAR(36) NOT NULL,
     CONSTRAINT PK_PLUS_CONTEXT PRIMARY KEY (CONTEXT_GUID)
  );

CREATE TABLE PLUS_CONTEXT_LOG
  (
     CONTEXT_LOG_ID BIGINT auto_increment NOT NULL,
     ACTION         VARCHAR(2000) NULL,
     COUNT          BIGINT DEFAULT NULL NULL,
     CREATED_AT     DATETIME DEFAULT NULL NULL,
     DEBUG_LOG      LONGTEXT NULL,
     HTTP_RESPONSE  INT DEFAULT NULL NULL,
     STATUS         VARCHAR(200) NULL,
     SUCCESS        BIT DEFAULT 0 NULL,
     LOG_TYPE       INT DEFAULT NULL NULL,
     CONTEXT_GUID   VARCHAR(36) NOT NULL,
     SUBJECT_GUID   VARCHAR(36) NULL,
     CONSTRAINT PK_PLUS_CONTEXT_LOG PRIMARY KEY (CONTEXT_LOG_ID)
  );

CREATE TABLE PLUS_LINEITEM
  (
     SAKAI_GRADABLE_OBJECT_ID BIGINT NOT NULL,
     CREATED_AT               DATETIME DEFAULT NULL NULL,
     DEBUG_LOG                LONGTEXT NULL,
     DELETED                  BIT DEFAULT 0 NULL,
     DELETED_AT               DATETIME DEFAULT NULL NULL,
     DELETOR                  VARCHAR(99) NULL,
     JSON                     LONGTEXT NULL,
     LOGIN_AT                 DATETIME DEFAULT NULL NULL,
     LOGIN_COUNT              INT DEFAULT NULL NULL,
     LOGIN_IP                 VARCHAR(64) NULL,
     LOGIN_USER               VARCHAR(99) NULL,
     MODIFIED_AT              DATETIME DEFAULT NULL NULL,
     MODIFIER                 VARCHAR(99) NULL,
     SENT_AT                  DATETIME DEFAULT NULL NULL,
     STATUS                   VARCHAR(200) NULL,
     SUCCESS                  BIT DEFAULT 0 NULL,
     UPDATED_AT               DATETIME DEFAULT NULL NULL,
     ENDDATETIME              DATETIME DEFAULT NULL NULL,
     LABEL                    VARCHAR(500) NULL,
     RESOURCE_ID              VARCHAR(200) NULL,
     SCOREMAXIMUM             DOUBLE DEFAULT NULL NULL,
     STARTDATETIME            DATETIME DEFAULT NULL NULL,
     TAG                      VARCHAR(200) NULL,
     CONTEXT_GUID             VARCHAR(36) NOT NULL,
     LINK_GUID                VARCHAR(36) NULL,
     CONSTRAINT PK_PLUS_LINEITEM PRIMARY KEY (SAKAI_GRADABLE_OBJECT_ID)
  );

CREATE TABLE PLUS_LINK
  (
     LINK_GUID     VARCHAR(36) NOT NULL,
     CREATED_AT    DATETIME DEFAULT NULL NULL,
     DEBUG_LOG     LONGTEXT NULL,
     DELETED       BIT DEFAULT 0 NULL,
     DELETED_AT    DATETIME DEFAULT NULL NULL,
     DELETOR       VARCHAR(99) NULL,
     JSON          LONGTEXT NULL,
     LOGIN_AT      DATETIME DEFAULT NULL NULL,
     LOGIN_COUNT   INT DEFAULT NULL NULL,
     LOGIN_IP      VARCHAR(64) NULL,
     LOGIN_USER    VARCHAR(99) NULL,
     MODIFIED_AT   DATETIME DEFAULT NULL NULL,
     MODIFIER      VARCHAR(99) NULL,
     SENT_AT       DATETIME DEFAULT NULL NULL,
     STATUS        VARCHAR(200) NULL,
     SUCCESS       BIT DEFAULT 0 NULL,
     UPDATED_AT    DATETIME DEFAULT NULL NULL,
     `DESCRIPTION` VARCHAR(4000) NULL,
     LINK          VARCHAR(200) NOT NULL,
     SAKAI_TOOL_ID VARCHAR(99) NULL,
     TITLE         VARCHAR(500) NULL,
     CONTEXT_GUID  VARCHAR(36) NOT NULL,
     CONSTRAINT PK_PLUS_LINK PRIMARY KEY (LINK_GUID)
  );

CREATE TABLE PLUS_MEMBERSHIP
  (
     MEMBERSHIP_ID      BIGINT auto_increment NOT NULL,
     CREATED_AT         DATETIME DEFAULT NULL NULL,
     DEBUG_LOG          LONGTEXT NULL,
     DELETED            BIT DEFAULT 0 NULL,
     DELETED_AT         DATETIME DEFAULT NULL NULL,
     DELETOR            VARCHAR(99) NULL,
     JSON               LONGTEXT NULL,
     LOGIN_AT           DATETIME DEFAULT NULL NULL,
     LOGIN_COUNT        INT DEFAULT NULL NULL,
     LOGIN_IP           VARCHAR(64) NULL,
     LOGIN_USER         VARCHAR(99) NULL,
     MODIFIED_AT        DATETIME DEFAULT NULL NULL,
     MODIFIER           VARCHAR(99) NULL,
     SENT_AT            DATETIME DEFAULT NULL NULL,
     STATUS             VARCHAR(200) NULL,
     SUCCESS            BIT DEFAULT 0 NULL,
     UPDATED_AT         DATETIME DEFAULT NULL NULL,
     LTI_ROLES          LONGTEXT NULL,
     LTI_ROLES_OVERRIDE LONGTEXT NULL,
     CONTEXT_GUID       VARCHAR(36) NOT NULL,
     SUBJECT_GUID       VARCHAR(36) NOT NULL,
     CONSTRAINT PK_PLUS_MEMBERSHIP PRIMARY KEY (MEMBERSHIP_ID)
  );

CREATE TABLE PLUS_SCORE
  (
     SCORE_GUID               VARCHAR(36) NOT NULL,
     ACTIVITY_PROGRESS        INT DEFAULT NULL NULL,
     COMMENT                  VARCHAR(200) NULL,
     DEBUG_LOG                LONGTEXT NULL,
     SAKAI_GRADABLE_OBJECT_ID BIGINT NOT NULL,
     GRADING_PROGRESS         INT DEFAULT NULL NULL,
     SCORE_GIVEN              DOUBLE DEFAULT NULL NULL,
     SCORE_MAXIMUM            DOUBLE DEFAULT NULL NULL,
     SENT_AT                  DATETIME DEFAULT NULL NULL,
     STATUS                   VARCHAR(200) NULL,
     SUCCESS                  BIT DEFAULT 0 NULL,
     UPDATED_AT               DATETIME DEFAULT NULL NULL,
     SUBJECT_GUID             VARCHAR(36) NOT NULL,
     CONSTRAINT PK_PLUS_SCORE PRIMARY KEY (SCORE_GUID)
  );

CREATE TABLE PLUS_SUBJECT
  (
     SUBJECT_GUID  VARCHAR(36) NOT NULL,
     CREATED_AT    DATETIME DEFAULT NULL NULL,
     DEBUG_LOG     LONGTEXT NULL,
     DELETED       BIT DEFAULT 0 NULL,
     DELETED_AT    DATETIME DEFAULT NULL NULL,
     DELETOR       VARCHAR(99) NULL,
     JSON          LONGTEXT NULL,
     LOGIN_AT      DATETIME DEFAULT NULL NULL,
     LOGIN_COUNT   INT DEFAULT NULL NULL,
     LOGIN_IP      VARCHAR(64) NULL,
     LOGIN_USER    VARCHAR(99) NULL,
     MODIFIED_AT   DATETIME DEFAULT NULL NULL,
     MODIFIER      VARCHAR(99) NULL,
     SENT_AT       DATETIME DEFAULT NULL NULL,
     STATUS        VARCHAR(200) NULL,
     SUCCESS       BIT DEFAULT 0 NULL,
     UPDATED_AT    DATETIME DEFAULT NULL NULL,
     DISPLAYNAME   VARCHAR(500) NULL,
     EMAIL         VARCHAR(500) NULL,
     LOCALE        VARCHAR(500) NULL,
     SAKAI_USER_ID VARCHAR(99) NULL,
     SUBJECT       VARCHAR(500) NOT NULL,
     TENANT_GUID   VARCHAR(36) NOT NULL,
     CONSTRAINT PK_PLUS_SUBJECT PRIMARY KEY (SUBJECT_GUID)
  );

CREATE TABLE PLUS_TENANT
  (
     TENANT_GUID                VARCHAR(36) NOT NULL,
     CREATED_AT                 DATETIME DEFAULT NULL NULL,
     DEBUG_LOG                  LONGTEXT NULL,
     DELETED                    BIT DEFAULT 0 NULL,
     DELETED_AT                 DATETIME DEFAULT NULL NULL,
     DELETOR                    VARCHAR(99) NULL,
     JSON                       LONGTEXT NULL,
     LOGIN_AT                   DATETIME DEFAULT NULL NULL,
     LOGIN_COUNT                INT DEFAULT NULL NULL,
     LOGIN_IP                   VARCHAR(64) NULL,
     LOGIN_USER                 VARCHAR(99) NULL,
     MODIFIED_AT                DATETIME DEFAULT NULL NULL,
     MODIFIER                   VARCHAR(99) NULL,
     SENT_AT                    DATETIME DEFAULT NULL NULL,
     STATUS                     VARCHAR(200) NULL,
     SUCCESS                    BIT DEFAULT 0 NULL,
     UPDATED_AT                 DATETIME DEFAULT NULL NULL,
     ALLOWED_TOOLS              VARCHAR(500) NULL,
     CACHE_KEYSET               LONGTEXT NULL,
     CLIENT_ID                  VARCHAR(200) NULL,
     DEPLOYMENT_ID              VARCHAR(200) NULL,
     `DESCRIPTION`              VARCHAR(4000) NULL,
     INBOUND_ROLE_MAP           LONGTEXT NULL,
     ISSUER                     VARCHAR(200) NULL,
     NEW_WINDOW_TOOLS           VARCHAR(500) NULL,
     OIDC_AUDIENCE              VARCHAR(200) NULL,
     OIDC_AUTH                  VARCHAR(500) NULL,
     OIDC_KEYSET                VARCHAR(500) NULL,
     OIDC_REGISTRATION          LONGTEXT NULL,
     OIDC_REGISTRATION_ENDPOINT VARCHAR(500) NULL,
     OIDC_REGISTRATION_LOCK     VARCHAR(200) NULL,
     OIDC_TOKEN                 VARCHAR(500) NULL,
     REALM_TEMPLATE             VARCHAR(99) NULL,
     RETRY_AT                   DATETIME DEFAULT NULL NULL,
     SITE_TEMPLATE              VARCHAR(99) NULL,
     TIMEZONE                   VARCHAR(100) NULL,
     TITLE                      VARCHAR(500) NOT NULL,
     TRUST_EMAIL                BIT DEFAULT 0 NULL,
     VERBOSE                    BIT DEFAULT 0 NULL,
     CONSTRAINT PK_PLUS_TENANT PRIMARY KEY (TENANT_GUID)
  );

ALTER TABLE PLUS_SCORE ADD CONSTRAINT UK2dswra9m6fw90bf3cguu3vci8 UNIQUE (SUBJECT_GUID, SAKAI_GRADABLE_OBJECT_ID);
ALTER TABLE PLUS_CONTEXT ADD CONSTRAINT UK7nqm58pyma0q8947tdti52yii UNIQUE (CONTEXT, TENANT_GUID);
ALTER TABLE PLUS_MEMBERSHIP ADD CONSTRAINT UK99my9blfq9m9p2bbcynwckmi6 UNIQUE (SUBJECT_GUID, CONTEXT_GUID);
ALTER TABLE PLUS_LINK ADD CONSTRAINT UKbsq0x608l5qkejhm4h6a06uf5 UNIQUE (LINK, CONTEXT_GUID);
ALTER TABLE PLUS_TENANT ADD CONSTRAINT UKhrxy340baghd9nrrek5ug66pc UNIQUE (ISSUER, CLIENT_ID);
ALTER TABLE PLUS_LINEITEM ADD CONSTRAINT UKr31snn61u7inlred585aimyf0 UNIQUE (RESOURCE_ID, CONTEXT_GUID);

CREATE INDEX FK4upex2cxuuyi4vf0krui7ogxa ON PLUS_CONTEXT_LOG(CONTEXT_GUID);
CREATE INDEX FK6yeawagjhbjmoi31ixldeqi7m ON PLUS_CONTEXT(TENANT_GUID);
CREATE INDEX FKd8x83boewqcpikjad8lydwqti ON PLUS_MEMBERSHIP(CONTEXT_GUID);
CREATE INDEX FKhmq3g82gmw7ppe98rj9x70dfo ON PLUS_SUBJECT(TENANT_GUID);
CREATE INDEX FKkkk4mde848fcoqo0mpdce54io ON PLUS_CONTEXT_LOG(SUBJECT_GUID);
CREATE INDEX FKoh29t39k6bikp4wu008i2gu7f ON PLUS_LINK(CONTEXT_GUID);
CREATE INDEX FKpp0kg7fx475b1kergsaoj202m ON PLUS_LINEITEM(CONTEXT_GUID);
CREATE INDEX FKq58ue8aq8212glh24mmb4u34w ON PLUS_LINEITEM(LINK_GUID);
CREATE INDEX IDX9oyjtm919c6qu4a54jmle2yf ON PLUS_CONTEXT(CONTEXT, TENANT_GUID, SAKAI_SITE_ID);
CREATE INDEX IDXpuhale7gtnckysrvjk9hmbekj ON PLUS_LINK(LINK, CONTEXT_GUID, SAKAI_TOOL_ID);

ALTER TABLE GB_GRADABLE_OBJECT_T ADD PLUS_LINE_ITEM VARCHAR(255) NULL;
-- END SAK-47852

-- SAK-48188
CREATE TABLE USER_NOTIFICATIONS
  (
     ID         BIGINT AUTO_INCREMENT NOT NULL,
     DEFERRED   BIT NOT NULL,
     EVENT      VARCHAR(32) NOT NULL,
     EVENT_DATE DATETIME NOT NULL,
     FROM_USER  VARCHAR(99) NOT NULL,
     REF        VARCHAR(255) NOT NULL,
     SITE_ID    VARCHAR(99) NULL,
     TITLE      VARCHAR(255) NULL,
     TO_USER    VARCHAR(99) NOT NULL,
     URL        VARCHAR(2048) NOT NULL,
     VIEWED     BIT DEFAULT 0 NULL,
     CONSTRAINT PK_USER_NOTIFICATIONS PRIMARY KEY (ID)
  );

CREATE INDEX IDX_USER_NOTIFICATIONS_EVENT_REF ON USER_NOTIFICATIONS(EVENT, REF);

CREATE INDEX IDX_USER_NOTIFICATIONS_TO_USER ON USER_NOTIFICATIONS(TO_USER);

DROP TABLE BULLHORN_ALERTS;

-- END SAK-48188

-- SAK-47876
ALTER TABLE rbc_rubric ADD max_points DOUBLE DEFAULT null NULL;
-- END SAK-47876

-- SAK-45041
ALTER TABLE GB_GRADABLE_OBJECT_T ADD `REFERENCE` VARCHAR(255) NULL;
-- END SAK-45041

-- SAK-46786
ALTER TABLE CONV_TOPICS ADD DUE_DATE_CALENDAR_EVENT_ID VARCHAR(36) NULL;
-- END SAK-46786

-- SAK-25018
ALTER TABLE MFR_OPEN_FORUM_T ADD LOCKED_AFTER_CLOSED BIT DEFAULT 0 NOT NULL;
ALTER TABLE MFR_TOPIC_T ADD LOCKED_AFTER_CLOSED BIT DEFAULT 0 NOT NULL;
-- END SAK-25018

-- SAK-47609
ALTER TABLE CONV_TOPICS ADD SHOW_MESSAGE_SCHEDULE_ID VARCHAR(36) NULL;
-- END SAK-47609

-- SAK-46974
ALTER TABLE MFR_MESSAGE_T ADD COLUMN SCHEDULER bit(1) DEFAULT 0 NOT NULL;
ALTER TABLE MFR_MESSAGE_T ADD COLUMN SCHEDULED_DATE DATETIME DEFAULT NULL;
-- End SAK-46974

-- SAK-43542
ALTER TABLE ASN_ASSIGNMENT ADD SOFT_REMOVED_DATE datetime DEFAULT NULL;
-- END SAK-43542

-- SAK-46157
CREATE INDEX FK_ASN_ASSIGMENTS_PROP_I ON ASN_ASSIGNMENT_PROPERTIES(ASSIGNMENT_ID);

CREATE INDEX FK_ASN_SUBMISSION_PROP ON ASN_SUBMISSION_PROPERTIES(SUBMISSION_ID);

CREATE INDEX FK_ASN_SUBMISSION_SUB_I ON ASN_SUBMISSION_SUBMITTER(SUBMISSION_ID);
-- END SAK-46157

-- SAK-40437
CREATE INDEX GB_GRADABLE_OBJ_ASN_IDX ON GB_GRADABLE_OBJECT_T(OBJECT_TYPE_ID, GRADEBOOK_ID, NAME, REMOVED);
CREATE INDEX GB_GRADE_RECORD_G_O_IDX ON GB_GRADE_RECORD_T(GRADABLE_OBJECT_ID);
CREATE INDEX GB_GRADING_EVENT_T_DATE_OBJ_ID ON GB_GRADING_EVENT_T(DATE_GRADED, GRADABLE_OBJECT_ID);
CREATE INDEX GB_GRADING_EVENT_T_STU_OBJ_ID ON GB_GRADING_EVENT_T(STUDENT_ID, GRADABLE_OBJECT_ID);
CREATE INDEX IDX998q3mh96ommuoptyhoet9vo7 ON GB_GRADING_SCALE_GRADES_T(GRADING_SCALE_ID);
-- END SAK-40437

-- SAK-12148
ALTER TABLE SAM_ASSESSMENTGRADING_T MODIFY AGENTID VARCHAR(99);
ALTER TABLE SAM_GRADINGSUMMARY_T MODIFY AGENTID VARCHAR(99);
ALTER TABLE SAM_ITEMGRADING_T MODIFY AGENTID VARCHAR(99);
ALTER TABLE SAM_STUDENTGRADINGSUMMARY_T MODIFY AGENTID VARCHAR(99);
ALTER TABLE SAM_ASSESSMENTGRADING_T MODIFY GRADEDBY VARCHAR(99);
ALTER TABLE SAM_ITEMGRADING_T MODIFY GRADEDBY VARCHAR(99);

CREATE INDEX SAM_AG_AGENTID_I ON SAM_GRADINGSUMMARY_T(AGENTID);
CREATE INDEX SAM_ASSGRAD_AID_PUBASSEID_T ON SAM_ASSESSMENTGRADING_T(AGENTID, PUBLISHEDASSESSMENTID);
-- END SAK-12148

-- SAK-46178
CREATE INDEX rbc_eval_association_idx ON rbc_evaluation(association_id);
CREATE INDEX rbc_param_association_idx ON rbc_tool_item_rbc_assoc_conf(association_id);
-- END SAK-46178

-- SAK-47194
DROP INDEX GB_GRADE_RECORD_STUDENT_ID_IDX ON GB_GRADE_RECORD_T;
-- END SAK-47194

-- SAK-47246
ALTER TABLE SAKAI_MESSAGE_BUNDLE DROP KEY SMB_SEARCH;
ALTER TABLE SAKAI_MESSAGE_BUNDLE ADD CONSTRAINT SMB_SEARCH UNIQUE (BASENAME, MODULE_NAME, LOCALE, PROP_NAME);
-- END SAK-47246

-- SAK-47784 Rubrics: Save Rubrics as Draft
ALTER TABLE rbc_rubric ADD draft bit(1) NOT NULL DEFAULT 0;
-- END SAK-47784

-- SAK-47992 START
INSERT INTO SAKAI_REALM_FUNCTION (FUNCTION_NAME) VALUES('roster.viewcandidatedetails');

INSERT INTO SAKAI_REALM_RL_FN VALUES (
    (SELECT REALM_KEY from SAKAI_REALM where REALM_ID = '!site.template'),
    (SELECT ROLE_KEY from SAKAI_REALM_ROLE where ROLE_NAME = 'maintain'),
    (SELECT FUNCTION_KEY  from SAKAI_REALM_FUNCTION where FUNCTION_NAME = 'roster.viewcandidatedetails')
);

INSERT INTO SAKAI_REALM_RL_FN (REALM_KEY, ROLE_KEY, FUNCTION_KEY) VALUES (
    (SELECT REALM_KEY FROM SAKAI_REALM WHERE REALM_ID = '!site.template.course'),
    (SELECT ROLE_KEY FROM SAKAI_REALM_ROLE WHERE ROLE_NAME = 'Instructor'),
    (SELECT FUNCTION_KEY FROM SAKAI_REALM_FUNCTION WHERE FUNCTION_NAME = 'roster.viewcandidatedetails')
);

CREATE TABLE PERMISSIONS_SRC_TEMP (ROLE_NAME VARCHAR(99), FUNCTION_NAME VARCHAR(99));

INSERT INTO PERMISSIONS_SRC_TEMP VALUES('maintain','roster.viewcandidatedetails');
INSERT INTO PERMISSIONS_SRC_TEMP VALUES('Instructor','roster.viewcandidatedetails');

CREATE TABLE PERMISSIONS_TEMP (ROLE_KEY INTEGER, FUNCTION_KEY INTEGER);
INSERT INTO PERMISSIONS_TEMP (ROLE_KEY, FUNCTION_KEY)
SELECT SRR.ROLE_KEY, SRF.FUNCTION_KEY
FROM PERMISSIONS_SRC_TEMP TMPSRC
JOIN SAKAI_REALM_ROLE SRR ON (TMPSRC.ROLE_NAME = SRR.ROLE_NAME)
JOIN SAKAI_REALM_FUNCTION SRF ON (TMPSRC.FUNCTION_NAME = SRF.FUNCTION_NAME);

INSERT INTO SAKAI_REALM_RL_FN (REALM_KEY, ROLE_KEY, FUNCTION_KEY)
SELECT
    SRRFD.REALM_KEY, SRRFD.ROLE_KEY, TMP.FUNCTION_KEY
FROM
    (SELECT DISTINCT SRRF.REALM_KEY, SRRF.ROLE_KEY FROM SAKAI_REALM_RL_FN SRRF) SRRFD
    JOIN PERMISSIONS_TEMP TMP ON (SRRFD.ROLE_KEY = TMP.ROLE_KEY)
    JOIN SAKAI_REALM SR ON (SRRFD.REALM_KEY = SR.REALM_KEY)
    WHERE SR.REALM_ID != '!site.helper'
    AND NOT EXISTS (
        SELECT 1
            FROM SAKAI_REALM_RL_FN SRRFI
            WHERE SRRFI.REALM_KEY=SRRFD.REALM_KEY AND SRRFI.ROLE_KEY=SRRFD.ROLE_KEY AND SRRFI.FUNCTION_KEY=TMP.FUNCTION_KEY
    );

-- clean up the temp tables
DROP TABLE PERMISSIONS_TEMP;
DROP TABLE PERMISSIONS_SRC_TEMP;
-- SAK-47992 END

-- SAK-48034 User Properties can be also assigned to external users.
-- IMPORTANT: Replace sakai_user_property_ibfk_1 by your foreign key name associated to the sakai_user_property table.
ALTER TABLE SAKAI_USER_PROPERTY DROP FOREIGN KEY sakai_user_property_ibfk_1;
-- END SAK-48034 User Properties can be also assigned to external users.

-- SAK-48021

-- Create the !plussite site.

INSERT INTO SAKAI_SITE VALUES('!plussite', 'plussite', null, 'SakaiPlus Template', 'Default template used when SakaiPlus creates a new site', null, null, null, 0, 0, 0, 'access', 'admin', 'admin', NOW(), NOW(), 1, 0, 0, 0, null);
INSERT INTO SAKAI_SITE_PAGE VALUES('!plussite-100', '!plussite', 'Dashboard', '1', 1, '0' );
INSERT INTO SAKAI_SITE_TOOL VALUES('!plussite-110', '!plussite-100', '!plussite', 'sakai.dashboard', 1, 'Dashboard', NULL );
INSERT INTO SAKAI_SITE_PAGE VALUES('!plussite-200', '!plussite', 'Announcements', '0', 2, '0' );
INSERT INTO SAKAI_SITE_TOOL VALUES('!plussite-210', '!plussite-200', '!plussite', 'sakai.announcements', 1, 'Announcements', NULL );
INSERT INTO SAKAI_SITE_PAGE VALUES('!plussite-300', '!plussite', 'Assignments', '0', 3, '0' );
INSERT INTO SAKAI_SITE_TOOL VALUES('!plussite-310', '!plussite-300', '!plussite', 'sakai.assignment.grades', 1, 'Assignments', NULL );
INSERT INTO SAKAI_SITE_PAGE VALUES('!plussite-400', '!plussite', 'Grades', '0', 4, '0' );
INSERT INTO SAKAI_SITE_TOOL VALUES('!plussite-410', '!plussite-400', '!plussite', 'sakai.gradebookng', 1, 'Grades', NULL );
INSERT INTO SAKAI_SITE_PAGE VALUES('!plussite-500', '!plussite', 'Lessons', '0', 5, '0' );
INSERT INTO SAKAI_SITE_TOOL VALUES('!plussite-510', '!plussite-500', '!plussite', 'sakai.lessonbuildertool', 1, 'Lessons', NULL );
INSERT INTO SAKAI_SITE_PAGE VALUES('!plussite-600', '!plussite', 'Resources', '0', 6, '0' );
INSERT INTO SAKAI_SITE_TOOL VALUES('!plussite-610', '!plussite-600', '!plussite', 'sakai.resources', 1, 'Resources', NULL );
INSERT INTO SAKAI_SITE_PAGE VALUES('!plussite-700', '!plussite', 'Conversations', '0', 7, '0' );
INSERT INTO SAKAI_SITE_TOOL VALUES('!plussite-710', '!plussite-700', '!plussite', 'sakai.conversations', 1, 'Conversations', NULL );
INSERT INTO SAKAI_SITE_PAGE VALUES('!plussite-800', '!plussite', 'Chat', '0', 8, '0' );
INSERT INTO SAKAI_SITE_TOOL VALUES('!plussite-810', '!plussite-800', '!plussite', 'sakai.chat', 1, 'Chat', NULL );
INSERT INTO SAKAI_SITE_TOOL_PROPERTY VALUES('!plussite', '!plussite-810', 'display-date', 'true' );
INSERT INTO SAKAI_SITE_TOOL_PROPERTY VALUES('!plussite', '!plussite-810', 'filter-param', '3' );
INSERT INTO SAKAI_SITE_TOOL_PROPERTY VALUES('!plussite', '!plussite-810', 'display-time', 'true' );
INSERT INTO SAKAI_SITE_TOOL_PROPERTY VALUES('!plussite', '!plussite-810', 'sound-alert', 'true' );
INSERT INTO SAKAI_SITE_TOOL_PROPERTY VALUES('!plussite', '!plussite-810', 'filter-type', 'SelectMessagesByTime' );
INSERT INTO SAKAI_SITE_TOOL_PROPERTY VALUES('!plussite', '!plussite-810', 'display-user', 'true' );
INSERT INTO SAKAI_SITE_PAGE VALUES('!plussite-900', '!plussite', 'Calendar', '0', 9, '0' );
INSERT INTO SAKAI_SITE_TOOL VALUES('!plussite-910', '!plussite-900', '!plussite', 'sakai.schedule', 1, 'Calendar', NULL );
INSERT INTO SAKAI_SITE_PAGE VALUES('!plussite-1000', '!plussite', 'Roster', '0', 10, '0' );
INSERT INTO SAKAI_SITE_TOOL VALUES('!plussite-1010', '!plussite-1000', '!plussite', 'sakai.site.roster2', 1, 'Roster', NULL );
INSERT INTO SAKAI_SITE_PAGE VALUES('!plussite-1100', '!plussite', 'Site Info', '0', 11, '0' );
INSERT INTO SAKAI_SITE_TOOL VALUES('!plussite-1110', '!plussite-1100', '!plussite', 'sakai.siteinfo', 1, 'Site Info', NULL );
INSERT INTO SAKAI_SITE_PAGE VALUES('!plussite-1200', '!plussite', 'Sakai Plus', '0', 12, '0' );
INSERT INTO SAKAI_SITE_TOOL VALUES('!plussite-1210', '!plussite-1200', '!plussite', 'sakai.plus', 1, 'Sakai Plus', NULL );
INSERT INTO SAKAI_SITE_TOOL_PROPERTY VALUES('!plussite', '!plussite-1210', 'sakai-portal:visible', 'false' );
INSERT INTO SAKAI_SITE_PAGE VALUES('!plussite-1300', '!plussite', 'Statistics', '0', 13, '0' );
INSERT INTO SAKAI_SITE_TOOL VALUES('!plussite-1310', '!plussite-1300', '!plussite', 'sakai.sitestats', 1, 'Statistics', NULL );
INSERT INTO SAKAI_SITE_TOOL_PROPERTY VALUES('!plussite', '!plussite-1310', 'sakai-portal:visible', 'false' );

-- END SAK-48021

-- SAK-48085

-- Add a few more roles from the LTI Spec
INSERT INTO SAKAI_REALM_ROLE VALUES (DEFAULT, 'ContentDeveloper');
INSERT INTO SAKAI_REALM_ROLE VALUES (DEFAULT, 'Manager');
INSERT INTO SAKAI_REALM_ROLE VALUES (DEFAULT, 'None');
INSERT INTO SAKAI_REALM_ROLE VALUES (DEFAULT, 'Officer');

-- Switch the approach from explicitly inserting all the roles into !site.template.lti (in SAK-39496 / KNL-879) To deriving
-- the roles in !site.template.lti from !site.template.course

DELETE FROM SAKAI_REALM_RL_FN WHERE REALM_KEY = (select REALM_KEY from SAKAI_REALM where REALM_ID = '!site.template.lti');

-- Instructor like roles pull roles from !site.template.course / Instructor
INSERT INTO SAKAI_REALM_RL_FN SELECT (select REALM_KEY from SAKAI_REALM where REALM_ID = '!site.template.lti') AS REALM_KEY, (select ROLE_KEY from SAKAI_REALM_ROLE where ROLE_NAME = 'Instructor') AS ROLE_KEY, FUNCTION_KEY FROM SAKAI_REALM_RL_FN WHERE REALM_KEY = (select REALM_KEY from SAKAI_REALM where REALM_ID = '!site.template.course') AND ROLE_KEY = (select ROLE_KEY from SAKAI_REALM_ROLE where ROLE_NAME = 'Instructor');
INSERT INTO SAKAI_REALM_RL_FN SELECT (select REALM_KEY from SAKAI_REALM where REALM_ID = '!site.template.lti') AS REALM_KEY, (select ROLE_KEY from SAKAI_REALM_ROLE where ROLE_NAME = 'ContentDeveloper') AS ROLE_KEY, FUNCTION_KEY FROM SAKAI_REALM_RL_FN WHERE REALM_KEY = (select REALM_KEY from SAKAI_REALM where REALM_ID = '!site.template.course') AND ROLE_KEY = (select ROLE_KEY from SAKAI_REALM_ROLE where ROLE_NAME = 'Instructor');

-- Teaching Assistant like roles pull roles from !site.template.course / Teaching Assistant
INSERT INTO SAKAI_REALM_RL_FN SELECT (select REALM_KEY from SAKAI_REALM where REALM_ID = '!site.template.lti') AS REALM_KEY, (select ROLE_KEY from SAKAI_REALM_ROLE where ROLE_NAME = 'Teaching Assistant') AS ROLE_KEY, FUNCTION_KEY FROM SAKAI_REALM_RL_FN WHERE REALM_KEY = (select REALM_KEY from SAKAI_REALM where REALM_ID = '!site.template.course') AND ROLE_KEY = (select ROLE_KEY from SAKAI_REALM_ROLE where ROLE_NAME = 'Teaching Assistant');

-- Student like roles pull roles from !site.template.course / Student
INSERT INTO SAKAI_REALM_RL_FN SELECT (select REALM_KEY from SAKAI_REALM where REALM_ID = '!site.template.lti') AS REALM_KEY, (select ROLE_KEY from SAKAI_REALM_ROLE where ROLE_NAME = 'Student') AS ROLE_KEY, FUNCTION_KEY FROM SAKAI_REALM_RL_FN WHERE REALM_KEY = (select REALM_KEY from SAKAI_REALM where REALM_ID = '!site.template.course') AND ROLE_KEY = (select ROLE_KEY from SAKAI_REALM_ROLE where ROLE_NAME = 'Student');
INSERT INTO SAKAI_REALM_RL_FN SELECT (select REALM_KEY from SAKAI_REALM where REALM_ID = '!site.template.lti') AS REALM_KEY, (select ROLE_KEY from SAKAI_REALM_ROLE where ROLE_NAME = 'Learner') AS ROLE_KEY, FUNCTION_KEY FROM SAKAI_REALM_RL_FN WHERE REALM_KEY = (select REALM_KEY from SAKAI_REALM where REALM_ID = '!site.template.course') AND ROLE_KEY = (select ROLE_KEY from SAKAI_REALM_ROLE where ROLE_NAME = 'Student');

-- Build Mentor by initially copying !site.template.course / Student
INSERT INTO SAKAI_REALM_RL_FN SELECT (select REALM_KEY from SAKAI_REALM where REALM_ID = '!site.template.lti') AS REALM_KEY, (select ROLE_KEY from SAKAI_REALM_ROLE where ROLE_NAME = 'Mentor') AS ROLE_KEY, FUNCTION_KEY FROM SAKAI_REALM_RL_FN WHERE REALM_KEY = (select REALM_KEY from SAKAI_REALM where REALM_ID = '!site.template.course') AND ROLE_KEY = (select ROLE_KEY from SAKAI_REALM_ROLE where ROLE_NAME = 'Student');

-- Convert Mentor to a read-only variant or Student by removing functions
DELETE FROM SAKAI_REALM_RL_FN WHERE REALM_KEY = (select REALM_KEY from SAKAI_REALM where REALM_ID = '!site.template.lti') AND ROLE_KEY IN (select ROLE_KEY from SAKAI_REALM_ROLE where ROLE_NAME = 'Mentor') AND FUNCTION_KEY = (SELECT FUNCTION_KEY FROM SAKAI_REALM_FUNCTION where FUNCTION_NAME = 'section.role.student');
DELETE FROM SAKAI_REALM_RL_FN WHERE REALM_KEY = (select REALM_KEY from SAKAI_REALM where REALM_ID = '!site.template.lti') AND ROLE_KEY IN (select ROLE_KEY from SAKAI_REALM_ROLE where ROLE_NAME = 'Mentor') AND FUNCTION_KEY IN (SELECT FUNCTION_KEY FROM SAKAI_REALM_FUNCTION where FUNCTION_NAME LIKE 'assessment%');
DELETE FROM SAKAI_REALM_RL_FN WHERE REALM_KEY = (select REALM_KEY from SAKAI_REALM where REALM_ID = '!site.template.lti') AND ROLE_KEY IN (select ROLE_KEY from SAKAI_REALM_ROLE where ROLE_NAME = 'Mentor') AND FUNCTION_KEY = (SELECT FUNCTION_KEY FROM SAKAI_REALM_FUNCTION where FUNCTION_NAME = 'chat.new');
DELETE FROM SAKAI_REALM_RL_FN WHERE REALM_KEY = (select REALM_KEY from SAKAI_REALM where REALM_ID = '!site.template.lti') AND ROLE_KEY IN (select ROLE_KEY from SAKAI_REALM_ROLE where ROLE_NAME = 'Mentor') AND FUNCTION_KEY IN (SELECT FUNCTION_KEY FROM SAKAI_REALM_FUNCTION where FUNCTION_NAME LIKE 'conversations%');
DELETE FROM SAKAI_REALM_RL_FN WHERE REALM_KEY = (select REALM_KEY from SAKAI_REALM where REALM_ID = '!site.template.lti') AND ROLE_KEY IN (select ROLE_KEY from SAKAI_REALM_ROLE where ROLE_NAME = 'Mentor') AND FUNCTION_KEY IN (SELECT FUNCTION_KEY FROM SAKAI_REALM_FUNCTION where FUNCTION_NAME LIKE 'gradebook%');
DELETE FROM SAKAI_REALM_RL_FN WHERE REALM_KEY = (select REALM_KEY from SAKAI_REALM where REALM_ID = '!site.template.lti') AND ROLE_KEY IN (select ROLE_KEY from SAKAI_REALM_ROLE where ROLE_NAME = 'Mentor') AND FUNCTION_KEY IN (SELECT FUNCTION_KEY FROM SAKAI_REALM_FUNCTION where FUNCTION_NAME LIKE 'dropbox%');
DELETE FROM SAKAI_REALM_RL_FN WHERE REALM_KEY = (select REALM_KEY from SAKAI_REALM where REALM_ID = '!site.template.lti') AND ROLE_KEY IN (select ROLE_KEY from SAKAI_REALM_ROLE where ROLE_NAME = 'Mentor') AND FUNCTION_KEY = (SELECT FUNCTION_KEY FROM SAKAI_REALM_FUNCTION where FUNCTION_NAME = 'mailtool.send');
DELETE FROM SAKAI_REALM_RL_FN WHERE REALM_KEY = (select REALM_KEY from SAKAI_REALM where REALM_ID = '!site.template.lti') AND ROLE_KEY IN (select ROLE_KEY from SAKAI_REALM_ROLE where ROLE_NAME = 'Mentor') AND FUNCTION_KEY = (SELECT FUNCTION_KEY FROM SAKAI_REALM_FUNCTION where FUNCTION_NAME = 'mail.new');
DELETE FROM SAKAI_REALM_RL_FN WHERE REALM_KEY = (select REALM_KEY from SAKAI_REALM where REALM_ID = '!site.template.lti') AND ROLE_KEY IN (select ROLE_KEY from SAKAI_REALM_ROLE where ROLE_NAME = 'Mentor') AND FUNCTION_KEY IN (SELECT FUNCTION_KEY FROM SAKAI_REALM_FUNCTION where FUNCTION_NAME LIKE 'msg%');
DELETE FROM SAKAI_REALM_RL_FN WHERE REALM_KEY = (select REALM_KEY from SAKAI_REALM where REALM_ID = '!site.template.lti') AND ROLE_KEY IN (select ROLE_KEY from SAKAI_REALM_ROLE where ROLE_NAME = 'Mentor') AND FUNCTION_KEY IN (SELECT FUNCTION_KEY FROM SAKAI_REALM_FUNCTION where FUNCTION_NAME LIKE 'roster%');

-- Clone reduced Mentor role into Mentor-like roles
INSERT INTO SAKAI_REALM_RL_FN SELECT (select REALM_KEY from SAKAI_REALM where REALM_ID = '!site.template.lti') AS REALM_KEY, (select ROLE_KEY from SAKAI_REALM_ROLE where ROLE_NAME = 'Manager') AS ROLE_KEY, FUNCTION_KEY FROM SAKAI_REALM_RL_FN WHERE REALM_KEY = (select REALM_KEY from SAKAI_REALM where REALM_ID = '!site.template.lti') AND ROLE_KEY = (select ROLE_KEY from SAKAI_REALM_ROLE where ROLE_NAME = 'Mentor');
INSERT INTO SAKAI_REALM_RL_FN SELECT (select REALM_KEY from SAKAI_REALM where REALM_ID = '!site.template.lti') AS REALM_KEY, (select ROLE_KEY from SAKAI_REALM_ROLE where ROLE_NAME = 'Officer') AS ROLE_KEY, FUNCTION_KEY FROM SAKAI_REALM_RL_FN WHERE REALM_KEY = (select REALM_KEY from SAKAI_REALM where REALM_ID = '!site.template.lti') AND ROLE_KEY = (select ROLE_KEY from SAKAI_REALM_ROLE where ROLE_NAME = 'Mentor');
INSERT INTO SAKAI_REALM_RL_FN SELECT (select REALM_KEY from SAKAI_REALM where REALM_ID = '!site.template.lti') AS REALM_KEY, (select ROLE_KEY from SAKAI_REALM_ROLE where ROLE_NAME = 'Member') AS ROLE_KEY, FUNCTION_KEY FROM SAKAI_REALM_RL_FN WHERE REALM_KEY = (select REALM_KEY from SAKAI_REALM where REALM_ID = '!site.template.lti') AND ROLE_KEY = (select ROLE_KEY from SAKAI_REALM_ROLE where ROLE_NAME = 'Mentor');

-- END SAK-48085

