let express 	= require('express');
let app 		= express();
let url 		= require("url");
let bodyParser 	= require('body-parser');
let mysql      	= require('mysql');
//引用bodyParser 这个不要忘了写
app.use(bodyParser.json()); // for parsing application/json
app.use(bodyParser.urlencoded({ extended: true })); // for parsing application/x-www-form-urlencoded
//设置跨域访问
app.all('*', function(req, res, next) {
	res.header("Access-Control-Allow-Origin", "*");
	res.header("Access-Control-Allow-Headers", "X-Requested-With");
	res.header("Access-Control-Allow-Methods","PUT,POST,GET,DELETE,OPTIONS");
	res.header("X-Powered-By",' 3.2.1');
	res.header("Content-Type", "application/json;charset=UTF-8");
	next();
 });

// 连接mysql
const connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : '123456',
  database : 'vue-xincan'
});
connection.connect();
let dataBaseOption = function(sql, callback){
	connection.query(sql, function (error, results, fields) {
		  if (error) throw error;
		  callback(results);
		  results = '';
	});
};

///////////////////////////////////////////////通用表格处理///////////////////////////////////////////////////////

// 表格显隐列样式 获取当前表格列的信息
app.get('/api/app/table/select',function(req,res){
	let param = url.parse(req.url,true).query;
	let sql = "SELECT * FROM table_cell_show where name = '" + param.name + "'";
	dataBaseOption(sql, function(result){
		let resultObject = {
			code:200
			,msg: "查询成功"
			,data: result
		};
		res.status(200);
		res.json(resultObject);
	});
});

// 表格显隐列样式 更新当前表格列的信息
app.get('/api/app/table/status',function(req,res){
	let param = url.parse(req.url,true).query;
	let deleteSql = "delete from table_cell_show where name = '" + param.name + "'";
	let insertSql = "insert into table_cell_show (id, name, content, create_time) " +
		"value (replace(UUID(), '-', ''), '" + param.name + "', '" + param.content + "', now())";
	// 删除显隐列数据
	dataBaseOption(deleteSql, function(result){
		// 增加显隐列数据
		dataBaseOption(insertSql, function(result){
			let resultObject = { code:200, msg: "更新成功", data: result };
			res.status(200);
			res.json(resultObject);
		});
	});
});



// 用户操作 根据条件查询用户分页信息
app.get('/api/app/user',function(req,res){
	let  param = url.parse(req.url,true).query
		,page = (param.page - 1) * param.size
		,size = param.size;

		let sortName = "";
		let sortType = param.sortType;
		console.log(param);

		if(param.sortName !== undefined && param.sortName.length !== 0){
			sortName = param.sortName.replace(/([A-Z])/g,"_$1").toLowerCase();
			sortType = param.sortType;
		}

		let sqlCount = "SELECT count(*) count FROM employee where 1=1 ";
		let sql  = "SELECT ";
		sql += "id ";
		sql += ",login_name loginName ";
		sql += ",login_password loginPassword ";
		sql += ",name ";
		sql += ",sex ";
		sql += ",phone ";
		sql += ",email ";
		sql += ",is_admin isAdmin ";
		sql += ",area_id areaId ";
		sql += ",organization_id organizationId ";
		sql += ",date_format(create_time,'%Y-%m-%d %H:%m:%i') as createTime";
		sql += " FROM employee where 1=1 "; // 查询用户信息

		console.log(sortName);
		console.log(sortType);

	if(param != null){
		if(param.loginName != undefined & param.loginName != ''){
			sqlCount += " and login_name like '" + param.loginName + "%'";
			sql += " and login_name like '" + param.loginName + "%'";
		}
		if(param.name != undefined & param.name != ''){
			sqlCount += " and name='" + param.name + "'";
			sql += " and name='" + param.name + "'";
		}
		if(param.sex != undefined & param.sex != ''){
			sqlCount += " and sex='" + param.sex + "'";
			sql += " and sex='" + param.sex + "'";
		}
		if(param.areaId != undefined & param.areaId != ''){
			sqlCount += " and area_id='" + param.areaId + "'";
			sql += " and area_id='" + param.areaId + "'";
		}
		if(param.organizationId != undefined & param.organizationId != ''){
			sqlCount += " and organization_id='" + param.organizationId + "'";
			sql += " and organization_id='" + param.organizationId + "'";
		}
	}
	sql += " order by " + (sortName.length === 0 ? "create_time" : sortName) + " " + sortType;
	sql += " limit " + page + ", " + size;
	console.log("-----------------查询总数-------------------------");
	console.log(sqlCount);
	console.log("-----------------查询当前信息-------------------------");
	console.log(sql);
	console.log("------------------------------------------");

	// 查询总条数
	dataBaseOption(sqlCount, function(total){
		let count = total[0].count;
		dataBaseOption(sql, function(result){
			res.status(200),
			res.json({count:count,msg:'查询成功', data:result});
		});
	});

});


////////////////////////////////////////////用户管理//////////////////////////////////////////////////////////

// 用户操作 根据条件添加修改用户信息
app.put('/api/app/user/edit',function(req,res){
    console.log(req.body);
	let param = req.body
		,sql = "";

	if(param.id == undefined){
		sql  = "insert into employee (id, login_name, login_password, name, sex, phone, email, area_id, organization_id, is_admin, create_time) ";
		sql += "value ";
		sql += "(replace(UUID(), '-', ''), '" +param.loginName+ "', '" +param.loginPassword+ "', '" +param.name+ "', '" +param.sex+ "', '"
		+param.phone+ "', '" +param.email+ "', '" +param.areaId+ "', '" +param.organizationId+ "','" + param.isAdmin + "', now())";
		console.log("------------------新增信息------------------------");
		console.log(sql);
		console.log("------------------------------------------");
	}else{
		sql  = "update employee set ";
		sql += " login_name = '" + param.loginName + "'";
		sql += ", login_password = '" + param.loginPassword + "'";
		sql += ", name = '" + param.name + "'";
		sql += ", sex = '" + param.sex + "'";
		sql += ", phone = '" + param.phone + "'";
		sql += ", email = '" + param.email + "'";
		sql += ", area_id = '" + param.areaId + "'";
		sql += ",is_admin = '" + param.isAdmin + "'";
		sql += ", organization_id = '" + param.organizationId + "'";
		sql += ", create_time = now() ";
		sql += "where id = '" + param.id+ "'";
		console.log("-------------------修改信息-----------------------");
		console.log(sql);
		console.log("------------------------------------------");
	}

	dataBaseOption(sql, function(result){
		let resultObject = {
			code:200
			,msg: param.id === undefined ? "添加成功": "修改成功"
			,data: result
		};
		res.status(200);
		res.json(resultObject);
	});
});

// 用户操作 根据条件添加修改用户信息
app.post('/api/app/user/delete',function(req,res){
	let param = req.body;
	let id = "";
	let ids = param.id.split(",");
	for(let i  = 0; i < ids.length; i++){
		id += ",'" + ids[i] + "'";
	}
	let sql = "DELETE FROM employee where id in (" + id.substr(1) + ")";
	console.log("-----------------------删除信息---------------------------------");
	console.log(sql);
	console.log("--------------------------------------------------------");
	dataBaseOption(sql, function(result){
		let resultObject = { code:200, msg: "删除成功", data: result };
		res.status(200);
		res.json(resultObject);
	});
});

///////////////////////////////////////////////预案处理///////////////////////////////////////////////////////

// 用户操作 根据条件查询预案计划类型信息
app.get('/api/app/plan/type',function(req,res){

	let getTree = function(id, result){
		let items = [];
		for (let rlt of result) {
			// 遍历所有节点，将父菜单id与传过来的id比较
			if (rlt.parentId === id) {
				rlt.label = rlt.name;
				delete rlt.name;
				items.push(rlt);
				if(items.length !== 0){
					let tree = getTree(rlt.id, result);
					if(tree.length > 0){
						rlt.children = tree;
					}
				}
			}
		}
		return items;
	};

	let sql  = "SELECT id ,name ,parent_id parentId ,code ,description FROM plan_type"; // 查询用户信息
	// 查询总条数
	dataBaseOption(sql, function(result){

		let item = getTree(0, result);

		res.status(200),
			res.json({count:result.length,msg:'查询成功', data:item});
	});

});

// 根据条件查询预案分页信息
app.get('/api/app/plan',function(req,res){
	let  param = url.parse(req.url,true).query
		,page = (param.page - 1) * param.size
		,size = param.size;

	let sortName = "";
	let sortType = param.sortType;

	if(param.sortName !== undefined && param.sortName.length !== 0){
		sortName = param.sortName.replace(/([A-Z])/g,"_$1").toLowerCase();
		sortType = param.sortType;
	}

	let sqlCount = "SELECT count(*) count FROM plan where 1=1 ";
	let sql  = "SELECT ";
		sql += "p.id id ";
		sql += ",p.plan_name planName ";
		sql += ",p.version version ";
		sql += ",p.description description ";
		sql += ",p.plan_type_id planTypeId ";
		sql += ",(select name from plan_type pt where pt.id = p.plan_type_id) typeName ";
		sql += ",p.status status ";
		sql += ",p.edit_time editTime ";
		sql += " FROM plan p where 1=1 "; // 查询用户信息

		sql += " order by " + (sortName.length === 0 ? "p.edit_time" : sortName) + " " + sortType;
		sql += " limit " + page + ", " + size;

	// 查询总条数
	dataBaseOption(sqlCount, function(total){
		let count = total[0].count;
		dataBaseOption(sql, function(result){
			res.status(200),
				res.json({count:count,msg:'查询成功', data:result});
		});
	});
});


// 根据条件查询预案分页信息
app.get('/api/app/word/outline',function(req,res){
	let  param = url.parse(req.url,true).query;

	let getTree = function(id, result){
		let items = [];
		for (let rlt of result) {
			// 遍历所有节点，将父菜单id与传过来的id比较
			if (rlt.parentId === id) {
				rlt.label = rlt.num +"  "+ rlt.menu;
				items.push(rlt);
				if(items.length !== 0){
					let tree = getTree(rlt.id, result);
					if(tree.length > 0){
						rlt.children = tree;
					}
				}
			}
		}
		return items;
	};

	let sql  = "SELECT";
	sql += " id";
	sql += ", num";
	sql += ", menu";
	sql += ", parent_id parentId";
	sql += " FROM word_outline where 1=1 "; // 查询用户信息

	dataBaseOption(sql, function(result){
		let item = getTree(0, result);
		res.status(200),
		res.json({count:result.count,msg:'查询成功', data:item});
	});

});

//配置服务端口
let server = app.listen(3000, function () {

	let host = server.address().address;

	let port = server.address().port;

	console.log('Example app listening at http://%s:%s', host, port);
});




