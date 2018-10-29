CREATE DEFINER=`slava`@`%` PROCEDURE `createAccount`(IN phoneNumberFromApp VARCHAR(20), OUT idToApp INT(20), OUT exist BOOLEAN, OUT firstNameFromApp VARCHAR(255), OUT lastNameFromApp VARCHAR(255))
BEGIN
    SET idToApp = 0;
    SET firstNameFromApp = "";
    SET lastNameFromApp = "";
    
	IF NOT EXISTS ( SELECT 1 FROM Accounts WHERE PhoneNumber=phoneNumberFromApp ) THEN
		INSERT INTO Accounts (PhoneNumber, RegistrationDate)
		VALUES (phoneNumberFromApp, NOW());
			
		SET idToApp = ( SELECT ID FROM Accounts WHERE PhoneNumber=phoneNumberFromApp );
        IF (((idToApp - 10000000) MOD 1000) = 0) THEN
			CALL addReceiptsPartition(idToApp);
        END IF;
        
		SET exist = FALSE;
	ELSE
		SET exist = TRUE;
		SET firstNameFromApp = ( SELECT FirstName FROM AccountInfo WHERE ID = ( SELECT ID FROM Accounts WHERE PhoneNumber=phoneNumberFromApp ));
		SET lastNameFromApp = ( SELECT LastName FROM AccountInfo WHERE ID = ( SELECT ID FROM Accounts WHERE PhoneNumber=phoneNumberFromApp ));
        SET idToApp = ( SELECT ID FROM Accounts WHERE PhoneNumber=phoneNumberFromApp );
	END IF;
    
    SELECT idToApp, exist, firstNameFromApp, lastNameFromApp;
END