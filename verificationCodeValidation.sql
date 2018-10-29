CREATE DEFINER=`slava`@`%` PROCEDURE `verificationCodeValidation`(IN phoneNumberFromApp VARCHAR(20), IN verificationCodeFromApp INT(6), OUT valid INT(1))
BEGIN
    DECLARE verificationCodeFromTable  INT(6);
	SET verificationCodeFromTable = (SELECT VerificationCode FROM PrevalidPhones WHERE  PhoneNumber=phoneNumberFromApp);
    
    IF (verificationCodeFromTable IS NULL) THEN
		SET valid = -1; # code expired.
    ELSE
		IF (verificationCodeFromTable = verificationCodeFromApp) THEN
			DELETE from PrevalidPhones WHERE VerificationCode=verificationCodeFromApp AND PhoneNumber=phoneNumberFromApp;
			SET valid = 1; # code valid.
		ELSE
			SET valid = 0; # wrong number.
		END IF;
    END IF;
    
    SELECT valid;
END