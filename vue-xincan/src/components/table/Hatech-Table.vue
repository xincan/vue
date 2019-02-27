
<!--
    Table表格开发
-->

<template>

    <div class="hatech">

        <!-- 按条件查询模块 -->
        <slot name="hatech-search"></slot>

        <div class="hatech-table">
            <!-- 表格头部布局 -->
              <div class="hatech-table-header">
                  <div class="hatech-table-header-left"><ul><li>{{table.title}}</li></ul></div>
                  <div class="hatech-table-header-right" v-if="table.showHeaderOption">
                      <ul>
                          <li
                              v-for="(option, key) in table.headerOption"
                              v-if="option.isShow"
                              :key="key"
                              :title="option.name"
                              @click="hatechTableOptionBtn({key:key, type:option.type})"
                          >
                              <i :class="option.icon"></i>
                          </li>
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
                              <i
                                  v-for="(option,key) in table.cellOption"
                                  v-if="option.isShow"
                                  :key="key"
                                  :title="option.name"
                                  :class="option.icon"
                                  @click="hatechTableOptionBtn({key: key, type: option.type, index: scope.$index, row: scope.row})"
                              ></i>
                          </template>
                      </el-table-column>
                  </el-table>
            </div>
              <!--表格底部布局，表格分页设置-->
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

        <!-- 按条件查询模块 -->
        <div class="hatech-dialog">
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
              v-if="form.dialogFormVisible"
              :title="form.title"
              :visible.sync="form.dialogFormVisible"
              :width="form.formWidth"
              :before-close="formClose"
          >
              <div class="hatech-top-line"></div>     <!-- 弹出层划线，上 -->

              <!-- 弹出层form表单插槽定义 -->
              <slot name="hatech-dialog-from"></slot>

              <div class="hatech-bottom-line"></div>    <!-- 弹出层划线，上 -->
              <div slot="footer" class="dialog-footer">
                <el-button type="primary" size="mini" @click="formSubmit">确 定</el-button>
                <el-button type="warning" size="mini" @click="formReset">重 置</el-button>
                <el-button size="mini" @click="formConsole">取 消</el-button>
              </div>
          </el-dialog>
        </div>
    </div>
</template>

<script>

    // 引用Axios异步数据获取插件
    import Axios from 'axios';

    export default {
        components: { }
        ,props: {
            table:  {
                type: Object
                ,required: true
            }
            ,form: {
                type: Object
                ,required: true
            }

        }
        ,data() {
            return {

            }
        }
        ,mounted() {
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
              Axios.get(this.table.showCellUrl, {
                params: {name:this.table.id}
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
                    that.$nextTick(()=>{    // 数据DOM元素重新渲染之前，加载数据
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
                // 将操作列数据保存到后台
                Axios.get(this.table.dropCellUrl, {
                    params: {name:this.table.id, content: "["+cellString.substr(1)+"]" }
                }).then( response => {}).catch( error => {console.log(error);});

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
                Axios.get(this.table.url, {
                  params: { page:this.table.page, size:this.table.size, param:this.table.search }
                }).then( response => {
                    that.$nextTick( ()=> {
                        that.table.count = response.data.count;
                        that.table.data = response.data.data;
                    });
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
                    Axios.get("http://localhost:3000/user/delete", {
                        params: {id:id.substr(1)}
                    }).then(function (response) {
                        that.$message({message: response.data.msg ,center: true ,type: 'success'});
                        that.$nextTick(()=>{ that.initTableData(); });
                    }).catch(function (error) {console.log(error)});
                }).catch(() => {});
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
                    Axios.get("http://localhost:3000/user/delete", {
                        params: {id:row.id}
                    }).then( response => {
                        that.$message({message: response.data.msg ,center: true ,type: 'success'});
                        that.$nextTick(()=>{ that.initTableData(); });
                    }).catch( error => {console.log(error);});
                }).catch(() => {});
            }

            /**
             * 自定义表格按钮统一操作
             *  判断父组件函数是否存在，如果存在则执行，否则不执行
             * @Method formSubmit
             */
            ,hatechTableOptionBtn(param){
                this.$parent[param.type] ? this.$parent[param.type].call(this, param) : '';
            }

            /**
             * 弹出层操作
             * 提交弹出层中form表单数据信息
             * @Method formSubmit
             */
            ,formSubmit(){
                let that = this;
                this.$parent.$refs[this.form.name].validate(valid => {

                    // 如果所有验证不通过则直接拦截，不向下执行
                    if (!valid) return false;

                    that.$confirm('确定要'+(this.form.data.id ? '修改' : '增加')+'吗?', '温馨提示', {
                        confirmButtonText: '确定'
                        ,cancelButtonText: '取消'
                        ,type: 'warning'
                    }).then(() => {
                        // 关闭弹出层
                        that.form.dialogFormVisible = false;
                        Axios.get("http://localhost:3000/user/edit", {
                            params: this.form.data
                        }).then(function (response) {
                            that.$message({message: response.data.msg ,center: true ,type: 'success'});
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
                this.$parent.$refs[this.form.name].resetFields();
            }
            /**
             * 弹出层操作
             * 表单取消操作，重置表单数据，关闭弹出层
             * @Method formSubmit
             */
            ,formConsole(){
                this.$parent.$refs[this.form.name].resetFields();
                this.form.dialogFormVisible = false;
            }
            /**
             * 弹出层操作
             * 表单取消操作, 回归重置表单、列表数据然后关闭
             * @Method formSubmit
             */
            ,formClose(done){
                this.$parent.$refs[this.form.name].resetFields();
                done();
            }

        }
    }
</script>


<style scoped lang="scss">
  @import "../../../static/css/table";
  @import "../../../static/css/dialog";
</style>
