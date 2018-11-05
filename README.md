# f1factory-datahub-server
Server side of the Formula 1 Factory DataHub 

Data stored in MySQL database on this http server which translates query sent by the app to the database and returns data in a JSON object.  
DDL schema for database along with idef1x model (prev. version, will update later) is present in db_src folder  

Min requirements for the server:  
PHP 7.0 or higher  
Maria DB 10.1.26 or higher
