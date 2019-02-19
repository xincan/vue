/*数据分页*/
var DBHelper = require('DBHelper.js');
//创建一个新的数据库方法对象
var database = new DBHelper('localhost','root','123456','3306','xincan');
var obj=null;

function Result(express) {
    //创建路由
    this.router = express.Router();
    this.execute();
};

//此函数检查该表中的数据条数
Result.prototype.count = function(sql,fun){
    var cSql  = "select count(*) from ("+sql+")";
    //通过对象调用函数创建连接
    var con = database.getConnection();
    //调用函数接收数据
    database.excuteQuery(cSql,con,function(data){
        fun(parseInt(data));
    })
}

//此函数通过linmit方法获取表中需要的数据
Result.prototype.limtModel = function(sql,start,pageSize,fun){
    //返回从start行开始，到pageSize中的数据
    var limitSql="select * from ("+sql+") aa limit "+start+","+pageSize;
    console.log(limitSql);
    var con=database.getConnection();
    database.excuteQuery(limitSql,con,function(data){
        fun(data.data)
    })
}

Result.prototype.execute = function(){
    var obj=this;
    //创建路由路径
    this.router.get("/user",function(req,res){
        //初始从第几页开始
        var currentPage = 2;
        //每页显示的数据条数
        var pageSize = 5;
        var sql="select * from employee where 1=1 order by s_date desc";
        //返回url中属性使currPafe的参数
        var cP=req.query.currPage;

        if(cP!=null&&(typeof cP)!=undefined){
            currentPage=cP;
        }
        obj.count(sql,function(count){
            //最大页数
            var maxPage=(count+pageSize-1)/pageSize;
            //如果此页大于最大页数，则吧最大页数赋给此页
            if(currentPage>maxPage){
                currentPage = maxPage;
            }
            //此页小于1则将此页置为一，从第一页开始显示
            if(currentPage<1){
                currentPage = 1;
            }
            /*
            * 第一个参数：sql:需要分页的数据
            * 第二个参数：通过当前的页数，和每页需要显示的数据条数，得出这一页数据开始是哪一条数据
            * 第三个参数：获得确定这页数据的最后一条数据是那一条数据
            * */

            var addr=req.protocol+"://"+ req.hostname+":3000/";
            obj.limtModel(sql,(currentPage-1)*pageSize,pageSize,function(data){
                res.render("qh/message",{args:data,cp:currentPage,addr:addr,last:maxPage});
            });
        })
    })
}

module.exports=Result;