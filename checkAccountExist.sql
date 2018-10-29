CREATE DEFINER=`slava`@`%` PROCEDURE `checkAccountExist`(IN newNumber VARCHAR(20), OUT accountAlreadyExist BOOLEAN)
BEGIN
	IF NOT EXISTS(SELECT 1 FROM Accounts WHERE PhoneNumber=newNumber) THEN
        SET accountAlreadyExist = FALSE;
	ELSE
		SET accountAlreadyExist = TRUE;
    END IF;
    SELECT accountAlreadyExist;
END