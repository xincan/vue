/**
 * 创建数据库连接，并获取数据
 */
var mysql = require('mysql');
//获取用户名，连接地址，密码，数据库名
function DBHelper(host,user,pwd,port,database){
    this.host = host;
    this.user = user;
    this.pwd = pwd;
    this.port = port;
    this.database = database;
}
//获取数据
DBHelper.prototype.excuteQuery = function(sql,connection,fun){
    connection.query(sql, function (error, rows) {
        var result="";
        if (error) {
            result = {
                "status": "500",
                "message": "服务器错误"
            }
        }else{
            result = {
                "status": "200",
                "message": "success",
                "data":rows
            }
        }
        fun(result);
    });
}
//建立连接
DBHelper.prototype.getConnection = function(){
    var connection = mysql.createConnection({
        host: this.host,
        user: this.user,
        password:this.pwd,
        port: this.port,
        database: this.database
    });
    connection.connect();
    return  connection;
}
module.exports=DBHelper;