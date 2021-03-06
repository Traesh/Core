ALTER TABLE character_db_version CHANGE COLUMN required_s0817_11117_02_characters_world required_s0858_xxxxx_01_characters_characters bit;

ALTER TABLE characters
  ADD COLUMN `exploredZones` longtext AFTER power5,
  ADD COLUMN `equipmentCache` longtext AFTER exploredZones,
  ADD COLUMN `ammoId` int(10) UNSIGNED NOT NULL default '0' AFTER equipmentCache,
  ADD COLUMN `knownTitles` longtext AFTER ammoId,
  ADD COLUMN `actionBars` tinyint(3) UNSIGNED NOT NULL default '0' AFTER knownTitles;

UPDATE characters SET
exploredZones = SUBSTRING(data,
  length(SUBSTRING_INDEX(data, ' ', 1332))+2,
  length(SUBSTRING_INDEX(data, ' ', 1459+1))- length(SUBSTRING_INDEX(data, ' ', 1332)) - 1),
equipmentCache = '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ',
ammoId = SUBSTRING(data,
  length(SUBSTRING_INDEX(data, ' ', 1487))+2,
  length(SUBSTRING_INDEX(data, ' ', 1487+1))- length(SUBSTRING_INDEX(data, ' ', 1487)) - 1),
knownTitles = SUBSTRING(data,
  length(SUBSTRING_INDEX(data, ' ', 924))+2,
  length(SUBSTRING_INDEX(data, ' ', 925+1))- length(SUBSTRING_INDEX(data, ' ', 924)) - 1),
actionBars = ((SUBSTRING(data,
  length(SUBSTRING_INDEX(data, ' ', 1486))+2,
 length(SUBSTRING_INDEX(data, ' ', 1486+1))- length(SUBSTRING_INDEX(data, ' ', 1486)) - 1) & 0xFF0000) >> 16);


CREATE TABLE `data_backup` (
  `guid` int(11) unsigned NOT NULL default '0' COMMENT 'Global Unique Identifier',
  `data` longtext,
  PRIMARY KEY  (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO data_backup (guid, data)  (SELECT guid, data FROM characters);


ALTER TABLE characters
  DROP COLUMN data;
