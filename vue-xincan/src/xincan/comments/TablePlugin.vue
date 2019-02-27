
<!--
    表格插件调用实例
-->

<template>

    <div>
        <HatechTable ref="hatechTable" :table="table" :form="form" >
            <!--
                按条件查询模块
                slot="hatech-search"   slot:表示table组件中的插槽，hatech-search：表示插槽名称，又称为插槽具名：必写项
            -->
            <div slot="hatech-search" class="hatech-search">
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

            <div slot="hatech-dialog-from">
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
            </div>

        </HatechTable>
    </div>

</template>

<script>
    import HatechTable from '@/components/table/Hatech-Table'
    export default {
        components:{ HatechTable }
        ,data() {

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
                     title:'用户列表'                                  // 表格名称
                    ,id:'admin' + '-' + 'user-table'                  // 表格ID，系统中表格唯一
                    ,url:'http://localhost:3000/user'                 // 数据访问路径
                    ,showCellUrl:'http://localhost:3000/table/select' // 显隐列读取用户习惯
                    ,dropCellUrl:'http://localhost:3000/table/status' // 拖拽列保存入库路径，记录用户习惯
                    ,page:1                                           // 分页，当前页
                    ,size:10                                          // 分页，每页默认显示10条数据
                    ,pageSize: [30, 50, 100, 200]                     // 分页，设置默认页数
                    ,isIndexShow: true                                // 表格编号列显示隐藏设置
                    ,data: []                                         // 表格数据渲染
                    ,select: []                                       // 数据多选
                    ,count: 0                                         // 当前表格数据总数
                    ,search:{                                         // 查询条件
                    }
                    ,column: [                                        // 表格头部信息、列的显隐设置
                         {label:'登录名称',   prop: 'loginName',      width:'auto', isHide: true}
                        ,{label:'登录密码',   prop: 'loginPassword',  width:'auto', isHide: true}
                        ,{label:'用户名称',   prop: 'name',           width:'auto', isHide: true}
                        ,{label:'用户性别',   prop: 'sex',            width:'auto', isHide: true, formatter: this.sexFormatter}
                        ,{label:'用户电话',   prop: 'phone',          width:'auto', isHide: true}
                        ,{label:'用户邮箱',   prop: 'email',          width:'auto', isHide: true}
                        ,{label:'所属地区',   prop: 'areaId',         width:'auto', isHide: true}
                        ,{label:'所属机构',   prop: 'organizationId', width:'auto', isHide: true}
                        ,{label:'创建时间',   prop: 'createTime',     width:'auto', isHide: true}
                    ]
                    ,showHeaderOption: true             // 是否显示头部右侧操作按钮
                    ,headerOption:[                     // 表格头部操作按钮集合
                         {name:'增加',        icon:'el-icon-edit',       type:'add',            isShow: true}
                        ,{name:'上传',        icon:'el-icon-upload2',    type:'upload',         isShow: true}
                        ,{name:'下载',        icon:'el-icon-download',   type:'download',       isShow: true}
                        ,{name:'批量删除',    icon:'el-icon-delete',      type:'deleteBatch',    isShow: true}
                    ]
                    ,showTableOption: true              // 是否显示列表右侧操作按钮
                    ,cellOption:[                       // 表格右侧列操作按钮集合
                         {name:'修改',        icon:'el-icon-edit',      type:'edit',    isShow: true}
                        ,{name:'查看',        icon:'el-icon-upload2',   type:'upload',  isShow: false}
                        ,{name:'删除',        icon:'el-icon-delete',    type:'delete',  isShow: true}
                    ]
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
                            { validator: validateForm.v_loginPassword, trigger: 'blur' }
                        ]
                        ,name: [
                            { required: true, message: '请输入用户名称', trigger: 'blur' },
                            { min: 2, max: 20, message: '长度在3到20个字符', trigger: 'blur' }
                        ]
                        ,phone: [
                            { validator: validateForm.v_phone, trigger: 'blur' }
                        ]
                        ,email: [
                            { validator: validateForm.v_email, trigger: 'blur' }
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


        }

        ,methods: {

            /**
             * 表格列数据格式化
             * 性别格式化
             * @Method sexFormatter
             */
            sexFormatter(row){
                return row.sex === 1 ? "男" : "女";
            }

            /**
             * 头部表单：根据自定义条件查询表格数据操作
             * 触发表单查询按钮，通过表单数据查询表格
             * @Method onTableSearch
             */
            ,onTableSearch(){
                console.log("父组件调用子组件函数");
                this.$refs.hatechTable.initTableData();
            }

            /**
             * 头部表单操作
             * 触发表单清空按钮，还原表单数据
             * @Method onTableReset
             */
            ,onTableReset(){
                this.table.search={}
            }

            /**
             * 表格操作按钮集合
             * 对应headerOption数组对象中type值
             * @Method add
             */
            ,add(result){
                this.form.title='新增用户信息';
                this.form.data = {sex: 1};
                this.form.dialogFormVisible=true;
            }

            /**
             * 表格操作按钮集合
             * 对应headerOption数组对象中type值
             * @Method edit
             */
            ,edit(result) {
                this.form.title='修改用户信息';
                this.form.data = result.row;
                this.form.dialogFormVisible=true;
            }

            /**
             * 表格操作按钮集合
             * 对应headerOption数组对象中type值
             * @Method delete
             */
            ,delete(result){
              console.log("父类：" + result);
            }

            /**
             * 表格操作按钮集合
             * 对应headerOption数组对象中type值
             * @Method deleteBatch
             */
            ,deleteBatch(result){
              console.log("父类：" + result);
            }

        }
    }
</script>


<style scoped lang="scss">

</style>
