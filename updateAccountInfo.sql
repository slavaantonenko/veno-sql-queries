CREATE DEFINER=`slava`@`%` PROCEDURE `updateAccountInfo`(IN accountID INT(20), IN firstNameFromApp VARCHAR(50), IN lastNameFromApp VARCHAR(50), IN updateAccountDetails BOOLEAN)
BEGIN
	IF NOT EXISTS ( SELECT 1 FROM AccountInfo WHERE ID=accountID) THEN
		INSERT INTO AccountInfo (ID, FirstName, LastName, PartitionName)
		VALUES (accountID, firstNameFromApp, lastNameFromApp, concat("p", (accountID - 10000000) DIV 1000));
	ELSEIF updateAccountDetails = 1 THEN
		UPDATE AccountInfo SET FirstName=firstNameFromApp, LastName=lastNameFromApp WHERE ID=accountID;
	END IF;
END