<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>学生试题</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
		<link rel="favicon" href="assets/images/favicon.png">
	<link rel="stylesheet" media="screen" href="http://fonts.useso.com/css?family=Open+Sans:300,400,700">
	<link rel="stylesheet" href="assets/css/bootstrap.min.css">
	<link rel="stylesheet" href="assets/css/font-awesome.min.css">
	<!-- Custom styles for our template -->
	<link rel="stylesheet" href="assets/css/bootstrap-theme.css" media="screen">
	<link rel="stylesheet" href="assets/css/style_jh.css">
	<script type="text/javascript">
		function Dow(){
			document.getElementById('form').submit();
		}
	</script>
	 <script type="text/javascript" src="<%=basePath%>js/jquery-1.8.3.js"></script>
	<script type="text/javascript">
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
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse"><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button>
				<a class="navbar-brand" href="TeacherAction_getStudent">
					<img src="assets/images/logo.png" alt="Techro HTML5 template"></a>
			</div>
		<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav pull-right mainNav">
					<li class="c1 active"><a href="TeacherAction_getStudent">主页</a></li>
					<li class="c4" id="logout"><a href="javaScript:Logout();">注销</a></li>

				</ul>
			</div>
			<!--/.nav-collapse -->
		</div>
	</div>
	<!-- /.navbar -->

		<header id="head" class="secondary" style="background:url(image/answer.png) no-repeat; background-size:cover" >
            <div class="container">  
                </div>
    </header>
    <div style="background:url(image/bg11.jpg); background-repeat:no-repeat; background-size:cover;">
    <div style="height:40px"></div>

<!-- 显示此次考试的信息的地方 -->
<div style="height:80px;width: 500px;margin-left:600px;font-size: 60; ">本次得分为：${requestScope.grade.gscore }</div>
 <form id="form" action="DownLoadAction_Dow">
 <input name="gid" type="hidden" value="${requestScope.grade.gid }">
  <input name="name" type="hidden" value="${requestScope.name }">
 </form>
<div style="height:20px" ></div>
   <div >
    <table class="table-striped" style="margin-left:450px; margin-top:30px;" width="850" height="450"; border="2" >
    	<tr  align="center" style="font-size:26px;; font-weight:bolder; font-family:'宋体'">
    		<td style="width:600px">编号</td>
        	<td style="width:290px">试 题</td>
            <td style="width:80px ; text-align:center;">学生答案</td>
            <td style="width:80px; text-align:center;">正确答案</td>
            <td style="width:60px">对/错</td>
        </tr>
        
        <s:iterator value="#request.listExam" var="exam" status="st">
        	<tr align="center" style="font-size:26px;; font-weight:bolder; font-family:'宋体'">
        	<td><s:property value="#st.index+1"/></td>
            <td><s:property value="#exam.exam"/></td>
            <td><s:property value="#exam.studentanswer"/></td>
            <td><s:property value="#exam.trueresult"/></td>
            <td>
			<s:if test="#exam.studentanswer==#exam.trueresult">对</s:if>
			<s:else>错</s:else>
			</td>
        </tr>
        </s:iterator>
        
        
        </table>
</div>
<div style="height:20px"></div>
<div>
	<a href="TeacherAction_getStudent"><button type="button" class="button" style="background-image:url(image/back.jpg) ; margin-left:500px; width:200px; height:60px;"></button></a>
    <button type="button" class="button" style="margin-left:200px; width:55px; height:55px; background:url(image/xiazai.jpg); font-size:18px" onclick="Dow();"></button>
</div>
</div>
<footer id="footer" style="margin-top:0px;">
 
<div class="container" >
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
                </div><!-- end widget --> 
    </div>
  </div>
</div>
</div>
	</footer>
<script src="assets/js/jquery.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/custom.js"></script>
  </body>
</html>
