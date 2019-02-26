
<!--上下布局-->

<template>
    <div class="hatech">


      <el-form style="width: 40%;border: 1px solid #ccc5c5;position:relative;padding: 10px;top: 50px;left: 30%;">

          <el-form-item><li v-text="'选中数据：' + value" style="list-style: none"></li></el-form-item>

          <el-form-item><el-input></el-input></el-form-item>

          <el-form-item>
            <treeselect
              v-model="value"
              :multiple="true"
              :options="options"
              :default-expand-level="1"
            />
          </el-form-item>

      </el-form>

    </div>
</template>

<script>
    import Treeselect from '@riophae/vue-treeselect'
    import '@riophae/vue-treeselect/dist/vue-treeselect.css'
    export default {
        name: "Select"
        ,components:{ Treeselect }

        ,data(){
            return {
              value: null,
              options: [{
                id: '1',
                label: '张三',
                children: [{
                  id: '11',
                  label: '李四',
                  children:[{
                    id:'111',
                    label:'asdf'
                  }]
                }, {
                  id: '12',
                  label: '王五',
                }]
              },{
                id: '2',
                label: '赵六',
              },{
                id: '3',
                label: '陈皮',
              }]
            }
        }
        ,method(){
        }
    }
</script>

<style scoped lang="scss">

</style>
