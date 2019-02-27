

<!--

  弹出层封装

-->

<template>
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
      custom-class="hatech-dialog"
      v-if="form.dialogFormVisible"
      :title="form.title"
      :visible.sync="form.dialogFormVisible"
      :width="form.formWidth"
      :before-close="formClose"
    >
      <div class="hatech-top-line"></div>     <!-- 弹出层划线，上 -->

      <!-- 弹出层form表单插槽定义 -->
      <slot name="hatech-dialog"></slot>

      <div class="hatech-bottom-line"></div>    <!-- 弹出层划线，上 -->
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" size="mini" @click="formSubmit()">确 定</el-button>
        <el-button type="warning" size="mini" @click="formReset()">重 置</el-button>
        <el-button size="mini" @click="formConsole()">取 消</el-button>
      </div>
    </el-dialog>
</template>

<script>
    export default {
        name: "Hatech-Dialog"
        ,props:{
            form: {
                type: Object
                ,required: true
            }
        }
        ,data(){
            return {

            }
        }
        ,methods: {
            /**
             * 弹出层操作
             * 提交弹出层中form表单数据信息
             * @Method formSubmit
             */
            formSubmit(){
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

<style scoped>

</style>
