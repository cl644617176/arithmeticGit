<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description"
	content="free-educational-responsive-web-template-webEdu">
<meta name="author" content="webThemez.com">
<title>个人中心</title>
<link rel="favicon" href="assets/images/favicon.png">
<link rel="stylesheet" media="screen"
	href="http://fonts.useso.com/css?family=Open+Sans:300,400,700">
<link rel="stylesheet" href="assets/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/css/font-awesome.min.css">
<!-- Custom styles for our template -->
<link rel="stylesheet" href="assets/css/bootstrap-theme.css"
	media="screen">
<link rel="stylesheet" href="assets/css/style.css">
<script type="text/javascript" src="<%=basePath%>js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="<%=basePath%>js/highcharts.js"></script>
	    <script type="text/javascript" src="<%=basePath%>js/exporting.js"></script>
	<script type="text/javascript">
	$(function () {
	var json='${requestScope.mapJSON}';
	var data=[['0-30分',1],['30-60分',1],['60-80分',1],['80-90分',1],['90-100分',1]];
               
	var ob=eval("("+json+")");
	var i=0;
	 for(var o in ob){
		data[i][1]=parseInt(ob[o]);
		i=i+1;
      } 
     
	 
	
    $('#bingzhuangtu').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
        },
        title: {
            text: '我的得分分布区间'
        },
        tooltip: {
        	 pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        	//pointFormat: '{series.name}:{series.data[0][0]} <b>{point.percentage:.1f}%</b>'
           // pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: false,//在页面那些小扇形能不能被点
                cursor: 'pointer',
                dataLabels: {
                    enabled: false
                },
                showInLegend: true,
                point:{
                	events:{
                			legendItemClick:function(){
                				//alert("shabi");
                			},
                			click:function(){
                			//alert("0");
                			}
                	}
                
                }
            }
        },
        series: [{
            type: 'pie',
            name: '占比',
            data: data
        }]
    });
});
	function Logout(){
    	$.ajax({
					type : "POST",
					url : "UserAction_logout",
					dataType : "text",
					//data : "flag=" + flag,
					beforeSend : function(XMLHttpRequest) {
						//Pause(this,1);
					},
					success : function(msg) {
						window.location.href='login.jsp';
					},
					complete : function(XMLHttpRequest, textStatus) {

					},
					error : function() {

					}
				});
    	
    }
	</script>
</head>

<body>
	<!-- Fixed navbar -->
	<div class="navbar navbar-inverse">
		<div class="container">
			<div class="navbar-header">
				<!-- Button for smallest screens -->
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="icon-bar"></span><span class="icon-bar"></span><span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="home.jsp"> <img
					src="assets/images/logo.png" alt="Techro HTML5 template"></a>
			</div>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav pull-right mainNav">
					<li class="c1"><a href="home.jsp">主页</a></li>
					<li class="c2 active"><a href="UserAction_goPerson">个人中心</a></li>
					<li class="c3"><a href="GradeRecordAction_getRecord?askPageNum=1">试题查询</a></li>
					<li class="c4"><a href="GradeRecordAction_goScore">成绩查询</a></li>
					<li class="c5"><a href="GradeRecordAction_getRank">排行榜</a></li>
					<li class="c6 dropdown">
						<a href="ExamAction_goExam?flag=primary" class="dropdown-toggle" data-toggle="dropdown">考试 <b class="caret"></b></a>
						<ul class="dropdown-menu">
							<li><a href="ExamAction_goExam?flag=primary">一级难度</a></li>
							<li><a href="ExamAction_goExam?flag=medium">二级难度</a></li>
							<li><a href="ExamAction_goExam?flag=higher">三级难度</a></li>
						</ul>
					</li>
					<li class="c7"><a href="contact.jsp">联系我们</a></li>
					<li class="c4" id="logout"><a href="javaScript:Logout();">注销</a></li>


				</ul>
			</div>
			<!--/.nav-collapse -->
		</div>
	</div>
	<!-- /.navbar -->



	<div class="container-fluid">
		<div class="container" style="width:100%;">
			<div class="col-md-4" style="margin-left:70px;float: left; width: 200px;">
				<ul class="nav nav-list">
					<li class="nav-header">
						<h3>个人中心</h3>
					</li>
					<li><a href="UserAction_personToUpdate">信息修改</a></li>
					<li class="active"><a href="UserAction_inforTJ">信息统计</a></li>
					<li><a href="#">私人定制</a></li>
					<li class="divider"></li>
					<li><a href="#">帮助</a></li>
				</ul>
			</div>
			<div class="col-md-8" style="width:900px;float: left;">
			<div id="bingzhuangtu" style="width:600px; height: 400px;float: left;"></div>
			
			<div style="text-align:left; width:250px;height: 400px;float: left;">
				<div style="margin-top: 100px;color: #5EC64D;font-size: 30;">
				总做题量：<%=request.getAttribute("totalNumber") %>道
				</div>
				<div style="color: #29AAE2;font-size:30;">
				正确题数：<%=request.getAttribute("trueNumber") %>道
				</div>
				<div style=";color: #FFC225;font-size:30;">
				最高分：<%=request.getAttribute("max") %>分
				</div>
				<div style="color: #ED47C5;font-size:30;">
				最低分：<%=request.getAttribute("min") %>分
				</div>
				
			</div>
			
			
				
			</div>
		</div>
	</div>

	<footer id="footer" style="position: fixed;bottom: 0px; width:100%;">

		<div class="container">
			<div class="row">
				<div class="footerbottom">
					<div class="col-md-3 col-sm-6">
						<div class="footerwidget">
							<h4>
								<i class="fa fa-map-marker"></i> 天津大学软件学院
							</h4>
						</div>
					</div>
					<div class="col-md-3 col-sm-6">
						<div class="footerwidget">
							<h4>
								<i class="fa fa-phone"></i>+00 000 000 000 <br>
							</h4>
						</div>
					</div>
					<div class="col-md-3 col-sm-6">
						<div class="footerwidget">
							<h4>
								<i class="fa fa-envelope-o"></i> 644617176@qq.com
							</h4>
						</div>
					</div>
					<div class="col-md-3 col-sm-6">
						<div class="footerwidget">
							<h4>Welcome To Contact</h4>
						</div>
						<!-- end widget -->
					</div>
				</div>
			</div>
		</div>
	</footer>



	<!-- JavaScript libs are placed at the end of the document so the pages load faster -->
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/bootstrap.min.js"></script>
	<script src="assets/js/custom.js"></script>
</body>
</html>
