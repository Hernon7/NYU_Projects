import cx_Oracle as mydb
ip = 'localhost'
port = 1522
SID = 'app12c'
db_username='MASY_HL3480'
db_password='MASY_HL3480'
dsn_tns=mydb.makedsn(ip,port,SID)
connection = mydb.connect(db_username,db_password,dsn_tns)