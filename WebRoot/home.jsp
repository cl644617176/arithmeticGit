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
	<meta name="description" content="free-educational-responsive-web-template-webEdu">
	<meta name="author" content="webThemez.com">
	<title>主页</title>
	<link rel="favicon" href="assets/images/favicon.png">
	<link rel="stylesheet" media="screen" href="http://fonts.useso.com/css?family=Open+Sans:300,400,700">
	<link rel="stylesheet" href="assets/css/bootstrap.min.css">
	<link rel="stylesheet" href="assets/css/font-awesome.min.css"> 
	<link rel="stylesheet" href="assets/css/bootstrap-theme.css" media="screen"> 
	<link rel="stylesheet" href="assets/css/style.css">
    <link rel='stylesheet' id='camera-css'  href='assets/css/camera.css' type='text/css' media='all'> 
    <script type="text/javascript" src="<%=basePath%>js/jquery-1.8.3.js"></script>
    <script type="text/javascript">
    window.onload = function(){
    	var yy = '<%=session.getAttribute("number")%>';
    	if(yy!='null'){
    	document.getElementById("login").style.display = 'none';
    	}else{
    		document.getElementById("person").style.display = 'none';
    		document.getElementById("rank").style.display = 'none';
    		document.getElementById("test").style.display = 'none';
    		document.getElementById("find").style.display = 'none';
    		document.getElementById("exam").style.display = 'none';
    		document.getElementById("logout").style.display = 'none';
    	}
    }
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
	<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
	<script src="assets/js/html5shiv.js"></script>
	<script src="assets/js/respond.min.js"></script>
	<![endif]-->
</head>
<body>
	<!-- Fixed navbar -->
	<div class="navbar navbar-inverse">
		<div class="container">
			<div class="navbar-header">
				<!-- Button for smallest screens -->
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse"><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button>
				<a class="navbar-brand" href="home.jsp">
					<img src="assets/images/logo.png" alt="Techro HTML5 template"></a>
			</div>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav pull-right mainNav">
					<li class="c1 active"><a href="home.jsp">主页</a></li>
					<li class="c2" id="person"><a href="UserAction_goPerson">个人中心</a></li>
					<li class="c3" id="test"><a href="GradeRecordAction_getRecord?askPageNum=1">试题查询</a></li>
					<li class="c4" id="find"><a href="GradeRecordAction_goScore">成绩查询</a></li>
					<li class="c5" id="rank"><a href="GradeRecordAction_getRank">排行榜</a></li>
					<li class="c6 dropdown" id="exam" onmousemove="" >
						<a href="ExamAction_goExam?flag=primary" class="dropdown-toggle" data-toggle="dropdown">考试 <b class="caret"></b></a>
						<ul class="dropdown-menu">
							<li><a href="ExamAction_goExam?flag=primary">一级难度</a></li>
							<li><a href="ExamAction_goExam?flag=medium">二级难度</a></li>
							<li><a href="ExamAction_goExam?flag=higher">三级难度</a></li>
						</ul>
					</li>
					<li class="c7"><a href="contact.jsp">联系我们</a></li>
					<li class="c4" id="login"><a href="login.jsp">登陆</a></li>
					<li class="c4" id="logout"><a href="javaScript:Logout();">注销</a></li>

				</ul>
			</div>
			<!--/.nav-collapse -->
		</div>
	</div>
	<!-- /.navbar -->

	<!-- Header -->
	<header id="head">
		<div class="container" >
             <div class="heading-text">							
							<h1 class="animated flipInY delay1">小学生数学考试系统</h1> <br/>
							<p>欢迎大家进入小学生数学在线考试系统</p>
						</div>
            
					<div class="fluid_container">                       
                    <div class="camera_wrap camera_emboss pattern_1" id="camera_wrap_4">
                        <div data-thumb="assets/images/slides/thumbs/img1.jpg" data-src="assets/images/slides/img1.jpg">
                            <h2>We develop.</h2>
                        </div> 
                        <div data-thumb="assets/images/slides/thumbs/img2.jpg" data-src="assets/images/slides/img2.jpg">
                        </div>
                        <div data-thumb="assets/images/slides/thumbs/img3.jpg" data-src="assets/images/slides/img3.jpg">
                        </div> 
                    </div><!-- #camera_wrap_3 -->
                </div><!-- .fluid_container -->
		</div>
	</header>
	<!-- /Header -->

  <div class="container">
    <div class="row">
					<div class="col-md-3">
						<div class="grey-box-icon b1"> 
							<h4 style="font-weight:bold;">在线练习</h4>
							<p><img src="image/add.jpg" alt=""></p>
     						<p><a href="exercise.jsp?type=add"><em>开始练习</em></a></p>
						</div><!--grey box -->
					</div><!--/span3-->
					<div class="col-md-3">
						<div class="grey-box-icon b2"> 
							<h4 style="font-weight:bold;">在线练习</h4>
							<p><img src="image/sub.jpg" alt=""></p>
     						<p><a href="exercise.jsp?type=sub"><em>开始练习</em></a></p>
						</div><!--grey box -->
					</div><!--/span3-->
					<div class="col-md-3">
						<div class="grey-box-icon b3"> 
							<h4 style="font-weight:bold;">在线练习</h4>
							<p><img src="image/mul.jpg" alt=""></p>
     						<p><a href="exercise.jsp?type=mul"><em>开始练习</em></a></p>
						</div><!--grey box -->
					</div><!--/span3-->
					<div class="col-md-3">
						<div class="grey-box-icon b4">  
							<h4 style="font-weight:bold;">在线练习</h4>
							<p><img src="image/div.jpg" alt=""></p>
     						<p><a href="exercise.jsp?type=div"><em>开始练习</em></a></p>
						</div><!--grey box -->
					</div><!--/span3-->
				</div>
    </div>
      <section class="news-box top-margin">
        <div class="container">
            <h2><span>考试难度</span></h2>
            <div class="row">
       
                <div class="col-lg-4 col-md-4 col-sm-12">
                    <div class="newsBox">
                        <div class="thumbnail">
                            <a href="ExamAction_goExam?flag=primary"><figure><img src="image/easy.jpg" alt=""></figure></a>
                            <div class="caption maxheight2">
                            <div class="box_inner">
                                        <div class="box">
                                            <p class="title"><h5>简单     </h5></p>
                                            <p>该难度适合小学1-2年纪学生，主要是2-5操作数（整数）的加减乘除混合四则运算。</p>
                                        </div> 
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-4 col-sm-12">
                    <div class="newsBox">
                        <div class="thumbnail">
                            <a href="ExamAction_goExam?flag=medium"><figure><img src="image/middle.jpg" alt=""></figure></a>
                            <div class="caption maxheight2">
                            <div class="box_inner">
                                        <div class="box">
                                            <p class="title"><h5>一般     </h5></p>
                                            <p>该难度适合小学3-4年纪学生，主要是2-4操作数（整数和分数）的加减乘除混合四则运算。</p>
                                        </div> 
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-4 col-sm-12">
                    <div class="newsBox">
                        <div class="thumbnail">
                            <a href="ExamAction_goExam?flag=higher"><figure><img src="image/difficult.jpg" alt=""></figure></a>
                            <div class="caption maxheight2">
                           <div class="box_inner">
                                        <div class="box">
                                            <p class="title"><h5>困难</h5></p>
                                            <p>该难度适合小学5-6年纪学生，主要是5-6操作数（整数和分数）的加减乘除混合四则运算。</p>
                                        </div> 
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
   
  
	
      
      
    	 
    <footer id="footer">
 
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

	<!-- JavaScript libs are placed at the end of the document so the pages load faster -->
	<script src="assets/js/modernizr-latest.js"></script> 
	<script type='text/javascript' src='assets/js/jquery.min.js'></script>
    <script type='text/javascript' src='assets/js/fancybox/jquery.fancybox.pack.js'></script>
    
    <script type='text/javascript' src='assets/js/jquery.mobile.customized.min.js'></script>
    <script type='text/javascript' src='assets/js/jquery.easing.1.3.js'></script> 
    <script type='text/javascript' src='assets/js/camera.min.js'></script> 
    <script src="assets/js/bootstrap.min.js"></script> 
	<script src="assets/js/custom.js"></script>
    <script>
		jQuery(function(){
			
			jQuery('#camera_wrap_4').camera({
                transPeriod: 500,
                time: 3000,
				height: '600',
				loader: 'false',
				pagination: true,
				thumbnails: false,
				hover: false,
                playPause: false,
                navigation: false,
				opacityOnGrid: false,
				imagePath: 'assets/images/'
			});

		});
      
	</script>
    
</body>
</html>