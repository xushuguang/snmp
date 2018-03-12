<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<style>
    #sercretKeyManager{
        position: absolute;
        width: 60%;
        height: 90%;
        left:0;
        top:6%;
    }
</style>
<div id="sercretKeyManager"></div>
<script>
    //ajax动态生成设备拓扑图
    $.ajax({
        type: "get",
        async : true,
        url: 'listNetElementVo',
        dataType: "json",
        success : function (data) {
            // 绘制图表。
            echarts.init(document.getElementById('sercretKeyManager')).setOption({
                title: {
                    text:"密钥管理层"
                },
                tooltip : {
                    show : true,   //默认显示
                    showContent:true, //是否显示提示框浮层
                    trigger:'item',//触发类型，默认数据项触发
                    triggerOn:'click',//提示触发条件，mousemove鼠标移至触发，还有click点击触发
                    alwaysShowContent:false, //默认离开提示框区域隐藏，true为一直显示
                    showDelay:0,//浮层显示的延迟，单位为 ms，默认没有延迟，也不建议设置。在 triggerOn 为 'mousemove' 时有效。
                    hideDelay:200,//浮层隐藏的延迟，单位为 ms，在 alwaysShowContent 为 true 的时候无效。
                    enterable:true,//鼠标是否可进入提示框浮层中，默认为false，如需详情内交互，如添加链接，按钮，可设置为 true。
                    position:'right',//提示框浮层的位置，默认不设置时位置会跟随鼠标的位置。只在 trigger 为'item'的时候有效。
                    confine:false,//是否将 tooltip 框限制在图表的区域内。外层的 dom 被设置为 'overflow: hidden'，或者移动端窄屏，导致 tooltip 超出外界被截断时，此配置比较有用。
                    transitionDuration:0.4,//提示框浮层的移动动画过渡时间，单位是 s，设置为 0 的时候会紧跟着鼠标移动。
                    formatter: function (params,ticket,callback) {
                        var neName=params.data.name;//当前选中节点数据
                        $.ajax({
                            async : true,//设置异、同步加载
                            cache : false,//false就不会从浏览器缓存中加载请求信息了
                            type : 'post',
                            data:{'neName':neName},
                            dataType : "json",
                            url : 'getNEDetails',
                            success : function(data) { //请求成功后处理函数。
                                var res = "<table><caption align='top'>网元设备</caption><tr><td width='100px'>设备名</td><td width='150px'>设备IP</td><td width='100px'>设备状态</td><td width='50px'>操作</td></tr>";
                                for (var i =0;i<data.length;i++){
                                    var id = data[i].id;
                                    res += "<tr><td>"+data[i].neName+"</td><td>"+data[i].neIp+"</td><td>";
                                    console.log(data[i].state)
                                    if(data[i].state==0){
                                        res +="<div style='width: 15px;height: 15px;background-color: red ;border-radius: 50%;'></div></td>";
                                    }else if(data[i].state==1){
                                        res +="<div style='width: 15px;height: 15px;background-color: yellow   ;border-radius: 50%;'></div></td>";
                                    }else if(data[i].state==2){
                                        res +="<div style='width: 15px;height: 15px;background-color: green ;border-radius: 50%;'></div></td>";
                                    }
                                    res += "<td><button onclick='neDetails("+data[i].id+")'>详情</button></td>";
                                }
                                res += '</tr></table>';
                                callback(ticket,res);
                            },
                            error : function() {//请求失败处理函数
                                $.messager.alert('警告', '请求失败！', 'warning');
                            }
                        });
                        return 'Loading';
                    }
                },
                series: [{
                    itemStyle: {
                        normal: {
                            label: {
                                position: 'top',
                                show: true,
                                textStyle: {
                                    color: '#333'
                                }
                            },
                            nodeStyle: {
                                brushType: 'both',
                                borderColor: 'rgb(240,255,255)',
                                borderWidth: 1
                            },
                            linkStyle: {
                                normal: {
                                    color: 'source',
                                    curveness: 0,
                                    type: "solid"
                                }
                            }
                        },

                    },
                    force:{
                        initLayout: 'circular',//初始布局
                        repulsion:1000,//斥力大小
                    },

                    animation: false,
                    name:"",
                    type: 'graph',//关系图类型
                    layout: 'force',//引力布局
                    roam: false,//可以拖动
                    //legendHoverLink: true,//是否启用图例 hover(悬停) 时的联动高亮。
                    hoverAnimation: true,//是否开启鼠标悬停节点的显示动画
                    //coordinateSystem: null,//坐标系可选
                    //  xAxisIndex: 0, //x轴坐标 有多种坐标系轴坐标选项
                    //  yAxisIndex: 0, //y轴坐标
                    // ribbonType: true,
                    useWorker: false,
                    minRadius: 15,
                    maxRadius: 25,
                    gravity: 1.1,
                    scaling: 1.1,
                    nodes: data.nodes,
                    links: data.links
                }]
            });
        }
    });
    function neDetails(id) {
        console.log(id);
        sessionStorage.setItem("id",id);
        snmp.addTabs("设备详情","ne_details");
    }
</script>
