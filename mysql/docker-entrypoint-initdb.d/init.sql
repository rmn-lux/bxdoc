UPDATE b_option
SET value = 'default.com' 
WHERE MODULE_ID = 'main' AND name = 'site_name';

UPDATE b_option
SET value = 'default.com' 
WHERE MODULE_ID = 'main' AND name = 'server_name';

UPDATE b_option
SET value = 'Y'
WHERE MODULE_ID = 'main' AND name = 'update_devsrv';

DELETE FROM b_lang_domain WHERE LID = 's1'; 
INSERT b_lang_domain(LID, DOMAIN) VALUES ('s1', 'default.com'); 
UPDATE b_lang SET SERVER_NAME = 'default.com' WHERE LID = 's1';
