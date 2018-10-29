CREATE DEFINER=`slava`@`%` PROCEDURE `deleteAccount`(IN accountID INT(20))
BEGIN   
	SET @partitionName = (SELECT PartitionName FROM AccountInfo where ID=accountID);
	SET @command = concat('DELETE FROM Receipts PARTITION (', @partitionName, ') WHERE UserID=', accountID);
	PREPARE stmt1 FROM @command;
	EXECUTE stmt1; 
	DEALLOCATE PREPARE stmt1;
    
    DELETE FROM Accounts WHERE ID=accountID;
    DELETE FROM AccountInfo WHERE ID=accountID;
    DELETE FROM RegistrationTokens WHERE ID=accountID;
END