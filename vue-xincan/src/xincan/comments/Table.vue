<template>

    <div class="hatech">

        <div class="hatech-search">
            <el-form :inline="true" :model="table.param" class="demo-form-inline">

                <el-form-item><el-input v-model="table.param.loginName" placeholder="请输入登录名称"></el-input></el-form-item>

                <el-form-item><el-input v-model="table.param.name" placeholder="请输入用户名称"></el-input></el-form-item>

                <el-form-item>
                  <el-select v-model="table.param.sex" placeholder="请选择性别">
                    <el-option label="请选择性别" value=""></el-option>
                    <el-option label="男" value="1"></el-option>
                    <el-option label="女" value="0"></el-option>
                  </el-select>
                </el-form-item>

                <el-form-item><el-input v-model="table.param.areaId" placeholder="请出入用户所在地区"></el-input></el-form-item>

                <el-form-item><el-input v-model="table.param.organizationId" placeholder="请输入用户所属机构"></el-input></el-form-item>

                <el-form-item>
                    <el-button type="primary" size="small" @click="onTableSearch" icon="el-icon-search">查询</el-button>
                    <el-button type="warning" size="small" @click="onTableReset" icon="el-icon-delete">清空</el-button>
                </el-form-item>

            </el-form>
        </div>

        <div class="hatech-table">
            <div class="hatech-table-header">
                <div class="hatech-table-header-left"><ul><li>{{table.title}}</li></ul></div>
                <div class="hatech-table-header-right" v-if="table.showHeaderOption">
                    <ul>
                        <li title="添加" @click="onAddBar"><i class="el-icon-edit"></i></li>
                        <li title="上传"><i class="el-icon-upload2"></i></li>
                        <li title="下载"><i class="el-icon-download"></i></li>
                        <li title="删除" @click="onDeleteBatchBar"><i class="el-icon-delete"></i></li>
                        <li title="显隐列">
                            <el-popover
                              placement="bottom"
                              width="200"
                              trigger="click">
                                <el-checkbox v-for="(column,key) in table.column" :key="key" :checked="column.isHide" :name="column.prop" @change="isShow(column)">{{column.label}}</el-checkbox>
                                <i class="el-icon-menu" slot="reference"></i>
                            </el-popover>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="hatech-table-body">
                <el-table
                  :data="table.data" stripe border size="small" resizable
                  @selection-change="tableChangeRows"
                >
                    <!-- 表格多选设置 -->
                    <el-table-column type="selection" header-align="center" align="center" width="40" fixed="left"></el-table-column>
                    <!-- 表格列循环设置 -->
                    <el-table-column
                      v-for = "(column, key) in table.column"
                      v-if="column.isHide"
                      :prop = "column.prop" :label = "column.label" :key="key" :formatter = 'column.formatter'
                      header-align = "center" align = "left" sortable show-overflow-tooltip
                    ></el-table-column>
                    <!-- 表格操作列设置 -->
                    <el-table-column prop="option" v-if="table.showTableOption" header-align="center" align="center" label="操作" fixed="right">
                        <template slot-scope="scope">
                            <i  title="编辑" class="el-icon-edit-outline" @click="editUserOption(scope.$index, scope.row)"></i>
                            <i  title="删除" class="el-icon-delete" @click="deleteUserOption(scope.$index, scope.row)"></i>
                        </template>
                    </el-table-column>
                </el-table>
            </div>
            <div class="hatech-table-footer">
                <el-pagination
                  background
                  layout="total, sizes, prev, pager, next, jumper"
                  :current-page="table.page" :page-sizes="table.pageSize" :page-size="table.size" :total="table.count"
                  @size-change="tableSizeChange"
                  @current-change="tableCurrentChange"
                >
                </el-pagination>
            </div>
        </div>

        <!-- 编辑用户信息 -->
        <el-dialog custom-class="hatech-dialog" :title="editForm.title" :visible.sync="editForm.dialogFormVisible" :width="editForm.formWidth">
            <div class="hatech-top-line"></div>
            <el-form :model="editForm">

                <el-form-item label="登录名称" :label-width="editForm.formLabelWidth">
                  <el-input v-model="editForm.data.loginName" autocomplete="off" placeholder="请输入登录名称" :style="'width: ' + editForm.formBqWidth"></el-input>
                </el-form-item>
                <el-form-item label="登录密码" :label-width="editForm.formLabelWidth">
                  <el-input v-model="editForm.data.loginPassword" autocomplete="off" placeholder="请输入登录密码" :style="'width: ' + editForm.formBqWidth"></el-input>
                </el-form-item>
                <el-form-item label="用户名称" :label-width="editForm.formLabelWidth">
                    <el-input v-model="editForm.data.name" autocomplete="off" placeholder="请输入用户名称" :style="'width: ' + editForm.formBqWidth"></el-input>
                </el-form-item>
                <el-form-item label="用户性别" :label-width="editForm.formLabelWidth">
                  <el-radio-group v-model="editForm.data.sex">
                    <el-radio :label="0">女</el-radio>
                    <el-radio :label="1">男</el-radio>
                  </el-radio-group>
                </el-form-item>
                <el-form-item label="用户电话" :label-width="editForm.formLabelWidth">
                  <el-input v-model="editForm.data.phone" autocomplete="off" placeholder="请输入用户电话" :style="'width: ' + editForm.formBqWidth"></el-input>
                </el-form-item>
                <el-form-item label="用户邮箱" :label-width="editForm.formLabelWidth">
                  <el-input v-model="editForm.data.email" autocomplete="off" placeholder="请输入用户邮箱" :style="'width: ' + editForm.formBqWidth"></el-input>
                </el-form-item>
                <el-form-item label="所属地区" :label-width="editForm.formLabelWidth">
                  <el-input v-model="editForm.data.areaId" autocomplete="off" placeholder="请输入用户所属地区" :style="'width: ' + editForm.formBqWidth"></el-input>
                </el-form-item>
                <el-form-item label="所属机构" :label-width="editForm.formLabelWidth">
                  <el-input v-model="editForm.data.organizationId" autocomplete="off" placeholder="请输入用户所属机构" :style="'width: ' + editForm.formBqWidth"></el-input>
                </el-form-item>
            </el-form>
            <div class="hatech-bottom-line"></div>
            <div slot="footer" class="dialog-footer">
                <el-button type="primary" size="mini" @click="editFormSubmit">确 定</el-button>
                <el-button size="mini" @click="editForm.dialogFormVisible = false">取 消</el-button>
            </div>
        </el-dialog>
    </div>
</template>

<script>
  import Axios from 'axios';

  export default {
      data() {
          return {
              // 表格信息设置
              table:{
                   title:'用户列表'              // 表格名称
                  ,id:''                        // 表格ID，系统中表格唯一
                  ,page:1                       // 分页，当前页
                  ,size:10                      // 分页，每页默认显示10条数据
                  ,pageSize: [10, 20, 30, 50]   // 分页，设置默认页数
                  ,param:{                      // 查询条件
                      loginName: ''
                      ,name: ''
                      ,sex: ''
                      ,areaId: ''
                      ,organizationId: ''
                  }
                  ,column:[]                // 表格列的显隐设置
                  ,data: []                 // 表格数据渲染
                  ,select: []               // 数据多选
                  ,count: 0                 // 当前表格数据总数
                  ,showHeaderOption: true   // 是否显示头部右侧操作按钮
                  ,showTableOption: true    // 是否显示列表右侧操作按钮
              }
              // 表单信息设置
              ,editForm: {
                   title: '编辑用户信息'               // 表单标题
                  ,formWidth: '40%'                   // 表单宽度
                  ,dialogFormVisible: false           // 表单是否隐藏
                  ,formLabelWidth: '100px'            // 表单元素标题宽度
                  ,formBqWidth: 'calc(100% - 30px)'   // 表单输入框等宽度
                  ,data: {                            // 表格数据
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
              {label:'登录名称',  prop: 'loginName',      isHide: true}
              ,{label:'登录密码', prop: 'loginPassword',  isHide: true}
              ,{label:'用户名称', prop: 'name',           isHide: true}
              ,{label:'用户性别', prop: 'sex',            isHide: true, formatter: this.sexFormatter}
              ,{label:'用户电话', prop: 'phone',          isHide: true}
              ,{label:'用户邮箱', prop: 'email',          isHide: true}
              ,{label:'所属地区', prop: 'areaId',         isHide: true}
              ,{label:'所属机构', prop: 'organizationId', isHide: true}
              ,{label:'创建时间', prop: 'createTime',     isHide: true}
          ];
          // 通过数据库查询用户保存的显隐列显示方式
          this.getCellHide();
          // 初始化加载后台表格数据
          this.initTableData();
      }

      ,methods: {

          // 初始化化读取数据库隐藏列
          getCellHide(){
              let that = this;
              Axios.get("http://127.0.0.1:3000/select/cell", {
                params: {name:this.table.id}
              }).then( response => {
                  let cell = JSON.parse(response.data[0].content);
                  if(cell.length > 0){
                      let newColumn = [];
                      that.table.column.forEach(clm => {
                          cell.forEach(cel => {
                              if(clm.prop === cel.prop){
                                  clm.isHide = cel.isHide;
                                  newColumn.push(clm);
                              }
                          });
                      });
                      that.table.column=[];
                      that.$nextTick(()=>{
                          that.table.column = newColumn;
                      });
                  }

              }).catch( error => {
                  console.log(error);
              });
          }

          /**
           * @Method 显隐列操作
           */
          ,isShow(column) {
              let cellString = '';
              this.table.column.forEach( cell => {
                  if( cell.prop === column.prop){
                      cell.isHide = !column.isHide;
                  }
                  cellString += ',' + '{"prop":\"' + cell.prop + '\", "isHide\": ' + cell.isHide + '}';
              });

              Axios.get("http://127.0.0.1:3000/update/status", {
                  params: {
                      name:this.table.id
                      ,content: "["+cellString.substr(1)+"]"
                  }
              }).then(function (response) {})
                .catch(function (error) {});
          }

          // 初始化加载列表数据
          ,initTableData(param){
              let that = this;
              Axios.get("http://127.0.0.1:3000/user", {
                  params: {
                      page:this.table.page
                      ,size:this.table.size
                      ,param:this.table.param
                  }
              }).then(function (response) {
                  that.$nextTick(()=>{
                      let data = response.data;
                      that.table.count = data.count;
                      that.table.data = data.data;
                  });

              }).catch(function (error) {});
          }

          /**
           * 表格分页
           * @Method 每页条数
           */
          ,tableSizeChange(size) {
              this.table.size = size;
              this.initTableData();
          }

          /**
           * 表格分页
           * @Method 当前页
           */
          ,tableCurrentChange(page) {
              this.table.page = page;
              this.initTableData();
          }

          /**
           * 表格数据选中行
           * @Method checkbox选中
           */
          ,tableChangeRows(row){
              this.table.select = row;
          }

          /**
           * 表格自定义查询条件
           * @Method 查询
           */
          ,onTableSearch(){
              this.initTableData();
          }

          /**
           * 表格自定义查询条件
           * @Method 清空
           */
          ,onTableReset(){
              this.table.param = {loginName: '' ,name: '' ,sex: '' ,areaId: '' ,organizationId: ''};
          }

          /**
           * 表格数据格式化
           * @Method 性别格式化
           */
          ,sexFormatter(row, column, cellValue, index){
              return row.sex === 1 ? "男" : "女";
          }

          /**
           * 表格导航栏
           * @Method 添加按钮操作
           */
          ,onAddBar(){
              this.editForm.data = {sex:1};
              this.editForm.dialogFormVisible = true;
          }

          /**
           * 表格数据操作
           * @Method 批量删除操作
           */
          ,onDeleteBatchBar() {
              let that = this
                ,selected = that.table.select
                ,id = "";
              if(selected.length  == 0){
                this.$message({message: "请选择要删除的数据",center: true ,type: 'success'});
                return false;
              }
              selected.forEach(item => {
                  id += "," + item.id;
              });
              Axios.get("http://127.0.0.1:3000/user/delete", {
                params: {id:id.substr(1)}
              }).then(function (response) {
                that.$message({message: response.data.msg ,center: true ,type: 'success'});
                that.$nextTick(()=>{ that.initTableData(); });
              }).catch(function (error) {
                that.$message({message: "数据操作失败" ,center: true ,type: 'fail'});
              });

          }

          /**
           * @Method 修改
           */
          ,editUserOption(index, row) {
              this.editForm.data = row;
              this.editForm.dialogFormVisible = true;
          }

          /**
           * @Method 删除
           */
          ,deleteUserOption(index, row) {
              let that = this;
              Axios.get("http://127.0.0.1:3000/user/delete", {
                params: {id:row.id}
              }).then( response => {
                  that.$message({message: response.data.msg ,center: true ,type: 'success'});
                  that.$nextTick(()=>{ that.initTableData(); });
              }).catch( error => {
                  that.$message({message: "数据操作失败" ,center: true ,type: 'fail'});
              });
          }

          /** 弹出层
           * @Method 弹出层提交
           */
          ,editFormSubmit(){
              let that = this;
              // 关闭弹出层
              this.editForm.dialogFormVisible = false;
              Axios.get("http://127.0.0.1:3000/user/edit", {
                  params: this.editForm.data
              }).then(function (response) {
                  that.$message({message: response.data.msg ,center: true ,type: 'success'});
                  that.$nextTick(()=>{ that.initTableData(); });
              }).catch(function (error) {
                  that.$message({message: "数据操作失败" ,center: true ,type: 'fail'});
              });
          }

      }
  }
</script>


<style scoped lang="scss">
    @import "../../../static/css/table";
    @import "../../../static/css/dialog";
</style>
