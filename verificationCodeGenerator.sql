CREATE DEFINER=`slava`@`%` PROCEDURE `verificationCodeGenerator`(IN phoneNumberFromApp VARCHAR(20))
BEGIN
	DECLARE verificationCode  INT(6);
    SET verificationCode = (SELECT floor(rand()*900000)+100000);
    
    IF EXISTS ( SELECT * FROM PrevalidPhones WHERE PhoneNumber=phoneNumberFromApp ) THEN
		UPDATE PrevalidPhones SET VerificationCode=verificationCode WHERE PhoneNumber=phoneNumberFromApp;
	ELSE
		INSERT INTO PrevalidPhones (PhoneNumber, VerificationCode, RegistrationDate)
		VALUES (phoneNumberFromApp, verificationCode, NOW());
    END IF;
    
    SELECT verificationCode;
END