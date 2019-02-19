
<!--左右布局2-->

<template>
    <div class="hatech">

        <div class="hatech-panel">
          <div class="hatech-panel-item">adsf</div>
          <div class="hatech-panel-item">dasf</div>
          <div class="hatech-panel-item">sadf</div>
        </div>

        <div class="hatech-panel">
          <div class="hatech-panel-item">sdaf</div>
          <div class="hatech-panel-item">dsaf</div>
        </div>
      <div class="hatech-panel">
        <div class="hatech-panel-item">sdaf</div>
        <div class="hatech-panel-item">dsaf</div>
        <div class="hatech-panel-item">sdaf</div>
        <div class="hatech-panel-item">dsaf</div>
        <div class="hatech-panel-item">sdaf</div>
      </div>
    </div>
</template>

<script>
    export default {
        name: "LeftRightPanel"
    }
</script>

<style scoped lang="scss">
    .hatech {

        height: 100%;
        & .hatech-panel{
            display:flex;
            display: -webkit-flex;
            flex-direction: row;
            flex-wrap: wrap;
            padding: 5px 5px 0px 5px;
            justify-content:space-between;
            flex: 12;
            &:first-child{
                margin-top: 5px;
            }
            & .hatech-panel-item {
                flex: 3;
                -webkit-flex: 3;
                margin: 0 5px;
                background: #5BBBBB;
            }
        }
    }
</style>
