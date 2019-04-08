

<!--

  弹出层封装

-->

<template>

  <!-- 表格操作对应弹出层 -->
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
      :before-close="hatechDialogClose"
    >
        <div class="hatech-top-line"></div>     <!-- 弹出层划线，上 -->

        <!-- 弹出层form表单插槽定义 -->
        <slot name="hatech-dialog-from"></slot>

        <div class="hatech-bottom-line"></div>    <!-- 弹出层划线，上 -->
        <div slot="footer" class="dialog-footer">
          <el-button v-if="form.isBtnShow" type="primary" size="mini" @click="hatechFormSubmit">确 定</el-button>
          <el-button v-if="form.isBtnShow" type="warning" size="mini" @click="hatechFormReset">重 置</el-button>
          <el-button size="mini" @click="hatechDialogConsole">取 消</el-button>
        </div>
    </el-dialog>
  </div>
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
            hatechFormSubmit(){
                this.$emit("hatech-form-submit", {
                  id: this.form.data.id
                  ,type: this.form.submit
                  ,row: this.form.data
                  ,state: 'dialog'
                });
            }

            /**
             * 弹出层操作
             * 表单重置数据信息，重置表单弹出时原始数据
             * @Method formSubmit
             */
            ,hatechFormReset(){
              this.$emit("hatech-form-reset",{});
              // this.$refs[this.form.name].resetFields();
            }
            /**
             * 弹出层操作
             * 表单取消操作，重置表单数据，关闭弹出层
             * @Method formSubmit
             */
            ,hatechDialogConsole(){
              this.$emit("hatech-dialog-console",{});
              // this.$refs[this.form.name].resetFields();
              // this.form.dialogFormVisible = false;
            }
            /**
             * 弹出层操作
             * 表单取消操作, 回归重置表单、列表数据然后关闭
             * @Method formSubmit
             */
            ,hatechDialogClose(done){
              this.$emit("hatech-dialog-close",{});
              // this.$refs[this.form.name].resetFields();
              done();
            }
        }
    }
</script>

<style scoped lang="scss">
    @import "../../assets/css/dialog";
</style>
