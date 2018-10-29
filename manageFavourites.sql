CREATE DEFINER=`slava`@`%` PROCEDURE `manageFavourites`(IN accountID INT(20), IN receiptName VARCHAR(100), IN favourite BOOLEAN)
BEGIN
	SET @partitionName = (SELECT PartitionName FROM AccountInfo where ID=accountID);
	SET @command = concat('UPDATE Receipts PARTITION (', @partitionName, ') SET IsFavourite=', favourite,' WHERE Name=\'', receiptName,'\' AND UserID=', accountID);
    Select @command;
	PREPARE stmt1 FROM @command;
	EXECUTE stmt1; 
	DEALLOCATE PREPARE stmt1;
END