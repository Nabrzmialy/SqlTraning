-- Login with roles to create db and logins


CREATE LOGIN [JohnnyBravo] WITH PASSWORD=N'password', 
DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO


ALTER SERVER ROLE [securityadmin] ADD MEMBER [JohnnyBravo]
GO

ALTER SERVER ROLE [dbcreator] ADD MEMBER [JohnnyBravo]
GO

-- Remove right to access database

CREATE LOGIN [JohnnyBravo2] WITH PASSWORD=N'password', 
DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO


ALTER SERVER ROLE [securityadmin] ADD MEMBER [JohnnyBravo]
GO



