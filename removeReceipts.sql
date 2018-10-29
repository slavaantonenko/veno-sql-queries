CREATE DEFINER=`slava`@`%` PROCEDURE `removeReceipts`(IN accountID INT(20),IN receiptName VARCHAR(100))
BEGIN
	SET @partitionName = (SELECT PartitionName FROM AccountInfo where ID=accountID);
	SET @command = concat('DELETE FROM Receipts PARTITION (', @partitionName, ') WHERE Name=\'', receiptName,'\' AND UserID=', accountID);
	PREPARE stmt1 FROM @command;
	EXECUTE stmt1; 
	DEALLOCATE PREPARE stmt1;
END