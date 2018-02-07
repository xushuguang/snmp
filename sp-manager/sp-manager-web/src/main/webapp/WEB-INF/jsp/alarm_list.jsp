<%--
  User: james.xu
  Date: 2018/1/18
  Time: 14:22
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<div id="alarmListToolbar">
    <div style="padding: 5px; background-color: #fff;">
        <from id="alarmForm">
        <label>告警网元：</label>
        <input class="easyui-textbox" type="text" id="qkdIp">
        &nbsp;&nbsp;
        <label>告警级别：</label>
        <select id="alarmSeverity" class="easyui-combobox">
            <option value="" disabled selected>请选择</option>
            <option value="Fatal">Fatal</option>
            <option value="Error">Error</option>
            <option value="Warning">Warning</option>
            <option value="Info">Info</option>
        </select>
        &nbsp;&nbsp;
        <label>告警时间：</label>
        从：<input type="text" id="time1" style="width: 195px" editable="false"
                 class="easyui-datetimebox"/>
        到：<input type="text" id="time2" style="width: 195px" editable="false"
                 class="easyui-datetimebox"/>
        &nbsp;&nbsp;
            <button onclick="searchForm()" type="button" class="easyui-linkbutton">搜索</button>
            <button onclick="clearForm()" type="button" class="easyui-linkbutton">重置</button>
        </from>
    </div>
    <div>
        <button onclick="start()" class="easyui-linkbutton" data-options="iconCls:'icon-up',plain:true">开始</button>
        <button onclick="stop()" class="easyui-linkbutton" data-options="iconCls:'icon-down',plain:true">停止</button>
        <button onclick="remove()" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除</button>
    </div>
</div>
<%--容器放好--%>
<table id="dgAlarms"></table>

<%--通过js代码来渲染容器--%>
<script>
    //定时刷新
    setTimeout(function () {
        $('#dgAlarms').datagrid('reload');
    },1000);
    //点击搜索按钮动作
    function searchForm() {
        $('#dgAlarms').datagrid('load',{
            qkdIp:$('#qkdIp').val(),
            alarmSeverity:$('#alarmSeverity').combobox('getValue'),
            time1:$("#time1").datetimebox("getValue"),
            time2:$('#time2').datetimebox("getValue")
        });
    }
    //点击重置按钮动作
    function clearForm() {
        $('#alarmForm').form('clear');
        searchForm();
    }
    //开始监控按钮
    function start() {
        $.messager.confirm('确认', '您确定要开始监控吗？', function (r) {
            if (r) {
                //发出ajax请求
                //$.ajax() $.post() $.get()
                $.get(
                    //url，提交给后台谁去处理
                    'startTrap',
                    function () {
                        $('#dgAlarms').datagrid('reload');
                    }
                );
            }
        } );
    }
    //停止监控按钮
    function stop() {
        $.messager.confirm('确认', '您确定要停止监控吗？', function (r) {
            if (r) {
                //发出ajax请求
                //$.ajax() $.post() $.get()
                $.get(
                    //url，提交给后台谁去处理
                    'stopTrap',
                    function () {
                        $('#dgAlarms').datagrid('reload');
                    }
                );
            }
        } );
    }//停止监控按钮
    function remove() {
        $.messager.confirm('确认', '您确定要删除实时监控信息吗？', function (r) {
            if (r) {
                //发出ajax请求
                //$.ajax() $.post() $.get()
                $.get(
                    //url，提交给后台谁去处理
                    'removeRTAlarms',
                    function () {
                        //刷新
                        $('#dgAlarms').datagrid('reload');
                    }
                );
            }
        } );
    }
    //初始化数据表格代码
    $('#dgAlarms').datagrid({
        //数据表格的标题
        title: '告警主列表',
       // 显示行号
        rownumbers: true,
        //添加工具栏
        toolbar: '#alarmListToolbar',
        //初始化页面数据条数
        pageSize: 20,
        //在设置分页属性的时候 初始化页面大小选择列表
        pageList: [20, 50, 100],
        //请求服务器端数据
        url: 'listRTAlarms',
        //请求方式，默认是POST
        method: 'get',
        //是否显示分页工具栏
        pagination: true,
        //自适应父容器
        fit: true,
        //列属性
        columns: [[
            {field: 'alarmType', title: '告警类型'},
            {field: 'alarmSeverity', title: '告警级别'},
            {field: 'alarmTime', title: '发生时间',formatter: function (value, rows, index) {
                return moment(value).format('YYYY-MM-DD HH:mm:ss:m');
            }},
            {field: 'qkdIp', title: '告警网元'}
        ]]
    });
</script>