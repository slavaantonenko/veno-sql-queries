-- DEPRECATED --
CREATE DEFINER=`slava`@`%` PROCEDURE `getAccountFilesPath`(IN secretKey INT(8), OUT path VARCHAR(1000))
BEGIN
	SET path = (SELECT ReceiptsPath FROM AccountInfo WHERE  ID=secretKey);
    SELECT path;
END