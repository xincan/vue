/**
 * 各种画echarts图表的方法都封装在这里
 * 注意：这里echarts没有采用按需引入的方式，只是为了方便学习
 */


import echarts from 'echarts';
// import 'echarts/theme/walden.js';
import axios from 'axios';

const install = function(Vue) {
    Object.defineProperties(Vue.prototype, {
        $chart: {

            get() {

                /**
                 * 渲染地图
                 * @param id
                 * @returns {Promise<void>}
                 */
                async function initMapChart(id, chinaMap, option) {
                    let theme = await getTheme();
                    if(theme !== null && theme !== undefined){
                        echarts.registerTheme("theme", theme.data);
                        let chart = echarts.init(document.getElementById(id), 'theme');
                        echarts.registerMap('china', chinaMap); //注册
                        chart.setOption(option,true);
                        return chart;
                    }
                };

                /**
                 * 渲染基本图表
                 * @param id
                 * @returns {Promise<void>}
                 */
                async function initChart(id, option) {
                    let theme = await getTheme();
                    if(theme !== null && theme !== undefined){
                        echarts.registerTheme("theme", theme.data);
                        let chart = echarts.init(document.getElementById(id), 'theme');
                        chart.setOption(option,true);
                        return chart;
                    }
                };
                /**
                 * 获取echarts自定义皮肤
                 * @returns {*}
                 */
                function getTheme(){
                  return axios.get("/static/echarts/theme/walden.json", {});
                };

                /**
                 * 省级地图数据获取
                 * @returns {*}
                 */
                function provinceMapData(){
                  return axios.get("/static/echarts/map/china.json", {});
                };

                /**
                 * 市级数据获取
                 * @param provinceId
                 * @returns {*}
                 */
                 function cityMapData(provinceId){
                     return axios.get("/static/echarts/map/geometryProvince/" + provinceId + ".json", {})
                };

                /**
                 * 处理地图数据集合
                 * @returns {Promise<{chinaMap: *, data}>}
                 */
                async function getMapData() {
                    let data = {},
                      prov = await provinceMapData();
                      if(prov !== null && prov !== undefined){
                          for(let provinces of prov.data.features){
                              let province = provinces.properties;
                              data[province.name] = province.cp;
                              let cityData = await cityMapData(province.id);
                              for(let cities of cityData.data.features ){
                                  let city = cities.properties;
                                  data[city.name] = city.cp;
                              }
                          }
                          return {data: data, chinaMap: prov.data};
                      }

                }

                /**
                 * 定义地图数据项
                 * @param series
                 * @returns {{symbol: string, data: *, symbolSize: (function(*): number), effect: {shadowBlur: number, show: boolean}, name: (area|string), itemStyle: {normal: {color: (*|string|string), label: {show: boolean}}}, coordinateSystem: string, rippleEffect: {period: number, brushType: string, scale: number}, label: {normal: {formatter: string, show: boolean, position: string}}, type: string}}
                 */
                let mapItems = series => {
                    return {
                        name: series.area,
                        type: 'effectScatter',
                        coordinateSystem: 'geo',
                        rippleEffect: {
                            period: 2,
                            scale: 50,
                            brushType: 'fill' // fill
                        },
                        label: {
                            normal: {
                                show: true,
                                position: 'center',
                                formatter: '{b}'
                            }
                        },
                        symbol: 'emptyCircle',
                        symbolSize: function (val) {
                            return 10 + val / 10;
                        },
                        effect: {
                            show: true,
                            shadowBlur: 0
                        },
                        itemStyle: {
                            normal: {
                                label: {show: true},
                                color: series.color
                            }
                        },
                        data: series.data
                    }
                };

                let option = {
                    geo: {
                        map: 'china',
                        aspectScale: 0.75, // 地图窗宽比
                        zoom: 1.2,  // 地图缩放比
                        roam: true,
                        label: {
                            emphasis: {
                                color:"white"
                            }
                        },
                        itemStyle: {
                            normal: {
                                areaColor: '#1dc7bf',
                                borderColor: 'white'
                            },
                            emphasis: {
                                areaColor: '#1ec3c7',
                                borderColor: 'orange'
                            }
                        }
                    }
                };

                return {
                    /**
                     * 渲染地图
                     * @param id 绑定dam元素
                     * @param result 需要渲染的数据
                     * @returns {Promise<void>}
                     */
                    map: async function (id, result) {

                        let {data, chinaMap} = await getMapData();

                        if(data !== undefined && chinaMap !== undefined){
                            let color = ['orange', 'aqua'];
                            let series = await [];
                            for(let item of result) {
                                item.color = color[item.status];
                                item.data = function () {
                                    return [{
                                        name: item.bank,
                                        value: data[item.area].concat([item.status])
                                    }];
                                }();
                                series.push(mapItems(item));
                            }
                            option.series = series;

                            await initMapChart(id, chinaMap, option);
                        }
                    }

                    /**
                     * 渲染普通圆
                     * @param id
                     * @param result
                     * @returns {Promise<void>}
                     */
                    ,cycle: async function (id, result) {
                        let option = {
                            title : {
                                x:'center'
                            },
                            tooltip : {
                                trigger: 'item',
                                formatter: "{a} <br/>{b} : {c} ({d}%)"
                            },
                            legend: {
                                orient: 'vertical',
                                bottom: 'bottom',
                                data: ['未恢复','已恢复']
                            },
                            series : [
                                {
                                    name: '',
                                    type: 'pie',
                                    radius : ['0%','80%'],
                                    center: ['50%', '50%'],
                                    label:{
                                      show:false
                                    },
                                    data: result
                                }
                            ]
                        };

                        await initChart(id, option);
                    }
                }
            }
        }
    });
}

export default {
  install
}
