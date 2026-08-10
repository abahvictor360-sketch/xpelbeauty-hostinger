-- Sets the contact page + footer address, if this database's site_content
-- table has its own saved payload (rather than falling back to code
-- defaults, which now also default to empty/placeholder for this field).
-- Safe to run more than once.
--
-- Run this in Hostinger's phpMyAdmin / SQL tool against the xpel database.

UPDATE site_content
SET data = JSON_SET(
  data,
  '$.contactAddress', 'Zeal Plaza, Adjacent First Bank BBA, Beside Anambra Clusters, Trade Fair International Market, Lagos',
  '$.footerAddress',  'Zeal Plaza, Adjacent First Bank BBA, Beside Anambra Clusters, Trade Fair International Market, Lagos'
)
WHERE id = 1;
