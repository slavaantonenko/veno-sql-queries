CREATE DEFINER=`slava`@`%` PROCEDURE `getAccountReceipts`(IN accountID INT(20), IN mostRecentDate DATETIME)
BEGIN
	SET @partitionName = (SELECT PartitionName FROM AccountInfo where ID=accountID);
	SET @command = concat('SELECT * FROM Receipts Partition (', @partitionName, ') WHERE CreatedDate > \'', mostRecentDate,'\' AND UserID=', accountID);
	PREPARE stmt1 FROM @command;
	EXECUTE stmt1; 
	DEALLOCATE PREPARE stmt1;
END