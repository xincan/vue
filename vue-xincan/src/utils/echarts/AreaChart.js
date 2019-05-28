/**
 * 各种画echarts图表的方法都封装在这里
 * 注意：这里echarts没有采用按需引入的方式，只是为了方便学习
 */


import echarts from 'echarts';
import axios from 'axios';
const install = function(Vue) {
    Object.defineProperties(Vue.prototype, {
        $chart: {

            get() {

                // 省级地图数据获取
                function provinceMapData(){
                  return axios.get("/static/area/data/china.json", {});
                };

                // 市级数据获取
                 function cityMapData(provinceId){
                     return axios.get("/static/area/data/geometryProvince/" + provinceId + ".json", {})
                };

                // 处理数据集合
                async function getMapData() {
                    let data = {},
                      prov = await provinceMapData();
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

                let items = series => {
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
                                areaColor: '#507fc6',
                                borderColor: 'white'
                            },
                            emphasis: {
                                areaColor: '#218fc6',
                                borderColor: 'orange'
                            }
                        }
                    }
                };

                return {

                    area: async function (id, result) {
                      let color = ['orange', 'aqua'];
                      let series = await [];

                      let {data, chinaMap} = await getMapData();

                      if(data !== undefined && chinaMap !== undefined){
                          for(let item of result) {
                              item.color = color[item.status];
                              item.data = function () {
                                  return [{
                                      name: item.bank,
                                      value: data[item.area].concat([item.status])
                                  }];
                              }();
                              series.push(items(item));
                          }
                          option.series = series;
                          let myChart = echarts.init(document.getElementById(id));
                          echarts.registerMap('china', chinaMap); //注册
                          myChart.setOption(option,true);
                      }
                    }
                }
            }
        }
    });
}

export default {
  install
}
