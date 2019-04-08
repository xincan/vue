
<!--
    Table表格开发
-->

<template>

    <div class="hatech-plugin-table">

        <!-- 按条件查询模块 -->
        <div class="hatech-search">
            <el-form :inline="true" :model="table.search" class="demo-form-inline">
                <el-form-item><el-input v-model="table.search.loginName" placeholder="请输入登录名称"></el-input></el-form-item>
                <el-form-item><el-input v-model="table.search.name" placeholder="请输入用户名称"></el-input></el-form-item>
                <el-form-item>
                  <el-select v-model="table.search.sex" placeholder="请选择性别">
                    <el-option label="请选择性别" value=""></el-option>
                    <el-option label="男" value="1"></el-option>
                    <el-option label="女" value="0"></el-option>
                  </el-select>
                </el-form-item>
                <el-form-item><el-input v-model="table.search.areaId" placeholder="请出入用户所在地区"></el-input></el-form-item>
                <el-form-item><el-input v-model="table.search.organizationId" placeholder="请输入用户所属机构"></el-input></el-form-item>
                <el-form-item>
                    <el-button type="primary" size="small" @click="onTableSearch" icon="el-icon-search">查询</el-button>
                    <el-button type="warning" size="small" @click="onTableReset" icon="el-icon-delete">清空</el-button>
                </el-form-item>
            </el-form>
        </div>

        <div class="hatech-table">
            <!-- 表格头部布局 -->
            <div class="hatech-table-header">
                <div class="hatech-table-header-left"><ul><li>{{table.title}}</li></ul></div>
                <div class="hatech-table-header-right" v-if="table.showHeaderOption">
                    <ul>
                        <li title="添加" @click="onAddBar"><i class="el-icon-edit"></i></li>
                        <li title="上传"><i class="el-icon-upload2"></i></li>
                        <li title="下载"><i class="el-icon-download"></i></li>
                        <li title="删除" @click="onDeleteBatchBar"><i class="el-icon-delete"></i></li>
                        <li title="显隐列">
                            <el-popover placement="bottom" width="200" trigger="click">
                                <el-checkbox v-for="(column,key) in table.column" :key="key" :checked="column.isHide" :name="column.prop" @change="onIsCellHide(column)">{{column.label}}</el-checkbox>
                                <i class="el-icon-menu" slot="reference"></i>
                            </el-popover>
                        </li>
                    </ul>
                </div>
            </div>
            <!-- 表格主体布局 -->
            <div class="hatech-table-body">
                <el-table
                    stripe
                    border
                    resizable
                    size="small"
                    :data="table.data"
                    @selection-change="tableChangeRows"
                    @header-dragend="tableCellDragend"
                >
                    <!-- 表格多选设置 -->
                    <el-table-column type="selection" align="center" width="40" fixed="left"></el-table-column>
                    <!-- 表格编号设置 -->
                    <el-table-column label="编号" v-if="table.isIndexShow" type="index"  align="center" width="70" fixed="left" :index="tableIndex"></el-table-column>
                    <!-- 表格列循环设置 -->
                    <el-table-column
                        header-align = "center"
                        align = "left"
                        sortable show-overflow-tooltip
                        v-if="column.isHide"
                        v-for = "(column, key) in table.column"
                        :key="key"
                        :prop = "column.prop"
                        :label = "column.label"
                        :width = "column.width"
                        :formatter = 'column.formatter'
                    ></el-table-column>
                    <!-- 表格操作列设置 -->
                    <el-table-column prop="option" v-if="table.showTableOption" header-align="center" align="center" label="操作" fixed="right">
                        <template slot-scope="scope">
                            <i  title="编辑" class="el-icon-edit-outline" @click="editTableRowOption(scope.$index, scope.row)"></i>
                            <i  title="删除" class="el-icon-delete" @click="deleteTableRowOption(scope.$index, scope.row)"></i>
                        </template>
                    </el-table-column>
                </el-table>
            </div>
            <!--
                表格底部布局，表格分页设置
            -->
            <div class="hatech-table-footer">
                <el-pagination
                    background
                    layout="total, sizes, prev, pager, next, jumper"
                    :current-page="table.page" :page-sizes="table.pageSize" :page-size="table.size" :total="table.count"
                    @size-change="tableSizeChange"
                    @current-change="tableCurrentChange"
                ></el-pagination>
            </div>
        </div>

        <div class="hatech-table-dialog">
            <!--
                编辑用户信息
                公用一个弹出层时需要加上v-if判断使之重新渲染组件 避免重置按钮出现数据混乱现象

                custom-class="hatech-dialog"              自定义弹出层class名称
                v-if="form.dialogFormVisible"             判断弹出层是否显示、隐藏（重新加载渲染弹出层）
                :title="form.title"                       设置弹出层标题
                :visible.sync="form.dialogFormVisible"    判断弹出层是否显示、隐藏（不重新加载渲染弹出层）
                :width="form.formWidth"                   设置弹出层宽度
                :before-close="formClose"                 弹出层右上角关闭icon
            -->
            <el-dialog
                custom-class="hatech-table-dialog"
                v-if="form.dialogFormVisible"
                :title="form.title"
                :visible.sync="form.dialogFormVisible"
                :width="form.formWidth"
                :before-close="formClose"
            >
                <div class="hatech-top-line"></div>     <!-- 弹出层划线，上 -->
                <!--
                    表单设置
                    status-icon               设置表单校验时：是否在输入框中显示校验结果反馈图标
                    :ref="form.name"          设置表单名称
                    :model="form.data"        设置表单数据并绑定数据
                    :rules="form.rules"       设置表单验证规则
                -->
                <el-form
                    status-icon
                    :ref="form.name"
                    :model="form.data"
                    :rules="form.rules"
                >
                    <el-form-item label="登录名称" prop="loginName" :label-width="form.formLabelWidth" >
                        <el-input v-model="form.data.loginName" autocomplete="off" placeholder="请输入登录名称" :style="{width: form.formInputWidth}"></el-input>
                    </el-form-item>
                    <el-form-item label="登录密码" prop="loginPassword" :label-width="form.formLabelWidth">
                        <el-input v-model="form.data.loginPassword" autocomplete="off" placeholder="请输入登录密码" :style="{width: form.formInputWidth}"></el-input>
                    </el-form-item>
                    <el-form-item label="用户名称" prop="name" :label-width="form.formLabelWidth">
                        <el-input v-model="form.data.name" autocomplete="off" placeholder="请输入用户名称" :style="{width: form.formInputWidth}"></el-input>
                    </el-form-item>
                    <el-form-item label="用户性别" :label-width="form.formLabelWidth">
                        <el-radio-group v-model="form.data.sex">
                            <el-radio :label="0">女</el-radio>
                            <el-radio :label="1">男</el-radio>
                        </el-radio-group>
                    </el-form-item>
                    <el-form-item label="用户电话" prop="phone" :label-width="form.formLabelWidth">
                        <el-input v-model="form.data.phone" autocomplete="off" placeholder="请输入用户电话" :style="{width: form.formInputWidth}"></el-input>
                    </el-form-item>
                    <el-form-item label="用户邮箱" prop="email" :label-width="form.formLabelWidth">
                        <el-input v-model="form.data.email" autocomplete="off" placeholder="请输入用户邮箱" :style="{width: form.formInputWidth}"></el-input>
                    </el-form-item>
                    <el-form-item label="所属地区" :label-width="form.formLabelWidth">
                        <el-input v-model="form.data.areaId" autocomplete="off" placeholder="请输入用户所属地区" :style="{width: form.formInputWidth}"></el-input>
                    </el-form-item>
                    <el-form-item label="所属机构" :label-width="form.formLabelWidth">
                        <el-input v-model="form.data.organizationId" autocomplete="off" placeholder="请输入用户所属机构" :style="{width: form.formInputWidth}"></el-input>
                    </el-form-item>
                </el-form>
                <div class="hatech-bottom-line"></div>    <!-- 弹出层划线，上 -->
                <div slot="footer" class="dialog-footer">
                    <el-button type="primary" size="mini" @click="formSubmit()">确 定</el-button>
                    <el-button type="warning" size="mini" @click="formReset()">重 置</el-button>
                    <el-button size="mini" @click="formConsole()">取 消</el-button>
                </div>
            </el-dialog>
        </div>
    </div>
</template>

<script>

    export default {

        data() {

            /**
             * 统一form表单验证入口
             * @Method validateForm
             */
            let validateForm = {

                /**
                 * 密码验证
                 * @Method v_loginPassword
                 */
                v_loginPassword: (rule, value, callback) => {
                    if (value === undefined || value === '') {
                        return callback(new Error('请输入登录密码'));
                    }else{
                        if (this.form.data.loginPassword.length != 6) {
                          callback(new Error('登录密码为6位字符'));
                        }else {
                          callback();
                        }
                    }
                }

                /**
                 * 手机号码验证
                 * @Method v_phone
                 */
                ,v_phone: (rule, value, callback) => {
                    const phoneReg = /^1[3|4|5|7|8][0-9]{9}$/;
                    if (!value) {
                        return callback(new Error('电话号码不能为空'))
                    }
                    setTimeout(() => {
                        // Number.isInteger是es6验证数字是否为整数的方法,但是我实际用的时候输入的数字总是识别成字符串
                        // 所以我就在前面加了一个+实现隐式转换
                        if (!Number.isInteger(+value)) {
                            callback(new Error('请输入数字'))
                        } else {
                          if (phoneReg.test(value)) {
                              callback();
                          } else {
                              callback(new Error('电话号码格式不正确'))
                          }
                        }
                    }, 100);
                }

                /**
                 * 邮箱验证
                 * @Method v_email
                 */
                ,v_email: (rule, value, callback) => {
                    const mailReg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/
                    if (!value) {
                        return callback(new Error('邮箱不能为空'));
                    }
                    setTimeout(() => {
                        if (mailReg.test(value)) {
                            callback();
                        } else {
                            callback(new Error('请输入正确的邮箱格式'));
                        }
                    }, 100);
                }
            };

            return {
                // 表格信息设置
                table:{
                     title:'用户列表'                    // 表格名称
                    ,id:''                              // 表格ID，系统中表格唯一
                    ,page:1                             // 分页，当前页
                    ,size:10                            // 分页，每页默认显示10条数据
                    ,sortName:""                        // 分页排序字段名称
                    ,sortType:"ASC"                     // 分页排序方式DESC,ASC
                    ,pageSize: [10, 20, 30, 50]         // 分页，设置默认页数
                    ,search:{                           // 查询条件
                    }
                    ,param:{                            // 查询条件
                        loginName: ''
                        ,name: ''
                        ,sex: ''
                        ,areaId: ''
                        ,organizationId: ''
                    }
                    ,isIndexShow: true                  // 表格编号列显示隐藏设置
                    ,column:[]                          // 表格头部信息、列的显隐设置
                    ,data: []                           // 表格数据渲染
                    ,select: []                         // 数据多选
                    ,count: 0                           // 当前表格数据总数
                    ,showHeaderOption: true             // 是否显示头部右侧操作按钮
                    ,showTableOption: true              // 是否显示列表右侧操作按钮
                }
                // 表单信息设置
                ,form: {
                    name:'form'                         // 表单名称
                    ,title: ''                          // 表单标题
                    ,formWidth: '40%'                   // 表单宽度
                    ,dialogFormVisible: false           // 表单是否隐藏
                    ,formLabelWidth: '100px'            // 表单元素标题宽度
                    ,formInputWidth: 'calc(100% - 30px)'   // 表单输入框等宽度
                    ,rules:{                            // 表单各项元素校验
                        loginName: [
                            { required: true, message: '请输入登录名称', trigger: 'blur' },
                            { min: 5, max: 10, message: '长度在5到10个字符', trigger: 'blur' }
                        ]
                        ,loginPassword: [
                            { required: true, validator: validateForm.v_loginPassword, trigger: 'blur' }
                        ]
                        ,name: [
                           { required: true, message: '请输入用户名称', trigger: 'blur' },
                           { min: 2, max: 20, message: '长度在3到20个字符', trigger: 'blur' }
                        ]
                        ,phone: [
                            { required: true, validator: validateForm.v_phone, trigger: 'blur' }
                        ]
                        ,email: [
                            { required: true, validator: validateForm.v_email, trigger: 'blur' }
                        ]
                    }
                    ,data: {                            // 表单数据数据
                        loginName: ''
                        ,loginPassword: ''
                        ,name: ''
                        ,sex: 1
                        ,phone: ''
                        ,email: ''
                        ,areaId: ''
                        ,organizationId: ''
                    }
                }
            }
        }
        ,mounted() {

            // 当前登录用户名称（唯一）+ - + 当前表格名称（唯一）可以自定义
            this.table.id = 'admin' + '-' + 'user-table';
            // 表格显隐列设置
            this.table.column = [
                {label:'登录名称',  prop: 'loginName',      width:'auto', isHide: true}
                ,{label:'登录密码', prop: 'loginPassword',  width:'auto', isHide: true}
                ,{label:'用户名称', prop: 'name',           width:'auto', isHide: true}
                ,{label:'用户性别', prop: 'sex',            width:'auto', isHide: true, formatter: this.sexFormatter}
                ,{label:'用户电话', prop: 'phone',          width:'auto', isHide: true}
                ,{label:'用户邮箱', prop: 'email',          width:'auto', isHide: true}
                ,{label:'所属地区', prop: 'areaId',         width:'auto', isHide: true}
                ,{label:'所属机构', prop: 'organizationId', width:'auto', isHide: true}
                ,{label:'创建时间', prop: 'createTime',     width:'auto', isHide: true}
            ];
            // 通过数据库查询用户保存的表格显隐列显示方式
            this.initCellIsHide();
            // 初始化加载后台表格数据
            this.initTableData();
        }

        ,methods: {

            /**
             * 初始化数据
             * 初始化读取数据库隐藏列,每列的宽度
             * @Method initCellIsHide
             */
            initCellIsHide(){
                let that = this;
                this.$get("/api/app/table/select", {
                  name:this.table.id
                }).then( response => {
                    // 将后台读取字符串JSON数据，转换成JSON数据
                    let cell = JSON.parse(response.data[0].content);
                    if(cell.length > 0){
                        let newColumn = [];
                        // 比对两个集合修改列显示状态
                        that.table.column.forEach(clm => {
                            cell.forEach(cel => {
                                if(clm.prop === cel.prop){
                                    clm.isHide = cel.isHide;
                                    clm.width = cel.width;
                                    newColumn.push(clm);
                                }
                            });
                        });
                        that.table.column=[];   // 清空列显示数据，后续紧跟着渲染使之vue执行树双向绑定
                        this.$nextTick(() => {
                            that.table.column = newColumn;
                        });
                    }
                }).catch( error => {console.log(error);});
            }


            /**
             * 表格处理操作
             * 勾选表格列数据显示隐藏
             * type说明：
             * 【1: table列的显示隐藏，2：table列的拖拽】
             * @Method excuteTable
             */
            ,excuteTable(column, type){
                let cellString = '';
                // 遍历表头，更改表头数据模型，并拼接表头数据
                this.table.column.forEach( cell => {
                    if( cell.prop === column.prop){
                        if(type === 1){ // 隐藏处理
                            cell.isHide = !column.isHide;
                        }else{          // 拖拽宽度处理
                            cell.width = column.width;
                        }
                    }
                    cellString += ',' + '{"prop":\"' + cell.prop + '\", \"width\":\"' + cell.width + '\" , \"isHide\": ' + cell.isHide + '}';
                });
                // 将操作的显隐列数据保存到后台
                this.$get("/api/app/table/status", {
                  name:this.table.id, content: "["+cellString.substr(1)+"]"
                }).then( response => {
                }).catch( error => {console.log(error);});

            }

            /**
             * 表格头部按钮操作
             * 勾选表格列数据显示隐藏
             * @Method onIsCellHide
             */
            ,onIsCellHide(column) {
                this.excuteTable(column,1);
            }

            /**
             * 表格头部列拖拽操作
             * 选中列边框进行左右拖拽，改变列的宽度，并更改模型数据，将其保存到数据库中
             * @Method onIsCellHide
             */
            ,tableCellDragend(newWidth, oldWidth, column, event){
                let  cell = {prop: column.property, width: column.width};
                this.excuteTable(cell,2);
            }

            /**
             * 表格列下标操作
             * 重新计算数据下标
             * @Method onIsCellHide
             */
            ,tableIndex(index){
                return ((this.table.page - 1) * this.table.size) + index + 1;
            }
            /**
             * 初始化数据
             * 初始化加载列表数据
             * @Method initTableData
             */
            ,initTableData(){
                let that = this;
                this.$get("/api/app/user", {
                  page:this.table.page
                  ,size:this.table.size
                  ,sortName:this.table.sortName
                  ,sortType: this.table.sortType
                  ,param:this.table.search
                }).then( response => {
                      that.table.count = response.count;
                      that.table.data = response.data;
                }).catch( error => {console.log(error);});
            }

            /**
             * 表格分页
             * 点击每页条数下拉列表进行选择数据进行查询
             * @Method tableSizeChange
             */
            ,tableSizeChange(size) {
                this.table.size = size;
                this.initTableData();
            }

            /**
             * 表格分页
             * 首先数据选择渲染this.table.page数据
             * 其次调用初始化table数据
             * @Method 当前页选择操作
             */
            ,tableCurrentChange(page) {
                this.table.page = page;
                this.initTableData();
            }

            /**
             * 表格操作
             * 表格数据多选操作
             * @Method tableChangeRows
             */
            ,tableChangeRows(row){
                this.table.select = row;
            }

            /**
             * 头部表单操作
             * 触发表单查询按钮，通过表单数据查询表格
             * @Method onTableSearch
             */
            ,onTableSearch(){
                this.initTableData();
            }

            /**
             * 头部表单操作
             * 触发表单清空按钮，还原表单数据
             * @Method onTableReset
             */
            ,onTableReset(){
                this.table.param = {loginName: '' ,name: '' ,sex: '' ,areaId: '' ,organizationId: ''};
            }

            /**
             * 表格列数据格式化
             * 性别格式化
             * @Method sexFormatter
             */
            ,sexFormatter(row){
                return row.sex === 1 ? "男" : "女";
            }

            /**
             * 表格头部操作
             * 添加按钮操作，初始赋值，然后显示添加表单
             * @Method onAddBar
             */
            ,onAddBar(){
                this.form.title = '新增用户信息';
                this.form.data = {sex:1};
                this.form.dialogFormVisible = true;
            }

            /**
             * 表格头部操作
             * 批量删除操作
             * 判断表格是否有数据选中，如果没有选中，则显示友好提示信息，如果有选中项，则提示是否删除，否则取消删除
             * @Method onDeleteBatchBar
             */
            ,onDeleteBatchBar() {
                let that = this
                    ,selected = that.table.select
                    ,id = "";
                if(selected.length  == 0){
                    that.$message({message: "请选择要删除的数据",center: true ,type: 'success'});
                    return false;
                }
                that.$confirm('确定要删除吗?', '温馨提示', {
                  confirmButtonText: '确定',
                  cancelButtonText: '取消',
                  type: 'warning',
                  center: true
                }).then(() => {
                    selected.forEach(item => {
                        id += "," + item.id;
                    });
                    that.$get("/api/app/user/delete", {
                        id:id.substr(1)
                    }).then(function (response) {
                        that.$message({message: response.msg ,center: true ,type: 'success'});
                        that.$nextTick(()=>{ that.initTableData(); });
                    }).catch(function (error) {console.log(error)});
                }).catch(() => {});
            }

            /**
             * 表格右侧列操作
             * 编辑表格行数据信息
             * 点击编辑按钮，进行选中数据双向绑定并显示编辑弹出层
             * @Method editTableRowOption
             */
            ,editTableRowOption(index, row) {
                this.form.title = '编辑用户信息';
                this.form.data = row;
                this.form.dialogFormVisible = true;
            }

            /**
             * 表格右侧列操作
             * 删除表格行数据信息
             * 点击删除按钮，根据选中数据ID进行删除
             * @Method
             */
            ,deleteTableRowOption(index, row) {
                let that = this;
                that.$confirm('确定要删除吗?', '温馨提示', {
                  confirmButtonText: '确定'
                  ,cancelButtonText: '取消'
                  ,type: 'warning'
                }).then(() => {
                    that.$get("/api/app/user/delete", {
                        id:row.id
                    }).then( response => {
                        that.$message({message: response.msg ,center: true ,type: 'success'});
                        that.$nextTick(()=>{ that.initTableData(); });
                    }).catch( error => {console.log(error);});
                }).catch(() => {});
            }

            /**
             * 弹出层操作
             * 提交弹出层中form表单数据信息
             * @Method formSubmit
             */
            ,formSubmit(){
                let that = this;
                this.$refs[this.form.name].validate(valid => {

                    // 如果所有验证不通过则直接拦截，不向下执行
                    if (!valid) return false;

                    that.$confirm('确定要'+(this.form.data.id ? '修改' : '增加')+'吗?', '温馨提示', {
                      confirmButtonText: '确定'
                      ,cancelButtonText: '取消'
                      ,type: 'warning'
                    }).then(() => {

                        // 关闭弹出层
                        that.form.dialogFormVisible = false;
                        that.$get("/api/app/user/edit",
                          this.form.data
                        ).then(function (response) {
                          that.$message({message: response.msg ,center: true ,type: 'success'});
                          that.$nextTick(()=>{ that.initTableData(); });
                        }).catch(function (error) {
                          that.$message({message: "数据操作失败" ,center: true ,type: 'success'});
                        });

                    }).catch(() => {});
                });

            }

            /**
             * 弹出层操作
             * 表单重置数据信息，重置表单弹出时原始数据
             * @Method formSubmit
             */
            ,formReset(){
              this.$refs[this.form.name].resetFields();
            }
            /**
             * 弹出层操作
             * 表单取消操作，重置表单数据，关闭弹出层
             * @Method formSubmit
             */
            ,formConsole(){
                this.$refs[this.form.name].resetFields();
                this.form.dialogFormVisible = false;
            }
            /**
             * 弹出层操作
             * 表单取消操作, 回归重置表单、列表数据然后关闭
             * @Method formSubmit
             */
            ,formClose(done){
                this.$refs[this.form.name].resetFields();
                done();
            }
        }
    }
</script>


<style scoped lang="scss">
    @import "../../assets/css/table";
    @import "../../assets/css/dialog";
</style>
