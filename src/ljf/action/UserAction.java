package ljf.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ljf.pojo.Grade;
import ljf.pojo.Student;
import ljf.pojo.Teacher;
import ljf.service.GradeService;
import ljf.service.StudentService;
import ljf.service.TeacherService;
import ljf.service.impl.GradeServiceImpl;
import ljf.service.impl.StudentServiceImpl;
import ljf.service.impl.TeacherServiceImpl;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.hibernate.Session;

import utils.HibernateSessionFactory;
import utils.JsonTools;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class UserAction extends ActionSupport implements ServletRequestAware,
		ServletResponseAware, ModelDriven<Student> {

	Session HIsession = null;
	private HttpServletResponse resp;
	private HttpServletRequest req;
	private StudentService ss = new StudentServiceImpl();
	private TeacherService ts = new TeacherServiceImpl();
	private Map<String, Object> session = ActionContext.getContext()
			.getSession();
	private GradeService gs = new GradeServiceImpl();
	// userType String student teacher

	// password number

	public String role;
	public String loginPassword;
	public String loginNumber;
	public Student stu = new Student();
	public String SNumberJudge;
	public String new_pas;
	public String old_pas;
	public String s_number;
	
	
	
	public String inforTJ(){
		//一个list《《string，sttring》》    0-30   30-60   60-80   80-90   90-100
		Map<String, String> map=new HashMap<String, String>();
		List<Integer> list=new ArrayList<Integer>();
		List<Grade> data=gs.find("from Grade where snumber='"+session.get("number")+"'");
		int a1=0,a2=0,a3=0,a4=0,a5=0;
		int trueNumber=0;
		int max=0;
		int min=101;
		for(int i=0;i<data.size();i++){
			int fen=data.get(i).getGscore();
			if(fen>max)
				max=fen;
			if(fen<min)
				min=fen;
			trueNumber=trueNumber+fen/5;
			if(fen>=90)
				a5++;
			else if(fen>=80)
				a4++;
			else if(fen>=60)
				a3++;
			else if(fen>=30)
				a2++;
			else
				a1++;
		}
		map.put("0-30分",a1+"");
		map.put("30-60分",a2+"");
		map.put("60-80分",a3+"");
		map.put("80-90分",a4+"");
		map.put("90-100分",a5+"");
		req.setAttribute("mapJSON", JsonTools.createJsonString(map));
		req.setAttribute("trueNumber", trueNumber);
		req.setAttribute("totalNumber",data.size()*20);
		req.setAttribute("max",max);
		req.setAttribute("min",min==101?0:min);
		return "inforTJ";
		
		
		
	}
	
	public String goPerson(){
		return "goPerson";
	}

	public String personToUpdate() {
		if ((session.get("role") != null)
				&& (((String) session.get("role")).equals("student"))) {
			// 判断登录的是学生 返回学生信息 学号 老师姓名 姓名 原密码
			Student student = ss.getByHql("from Student where snumber='"
					+ (String) session.get("number") + "'");
			req.setAttribute("student", student);
			Teacher teacher = ts.getByHql("from Teacher where tnumber='"
					+ student.getTnumber() + "'");
			req.setAttribute("tname", teacher.getTname());
			return "personToUpdate";
		} else {
			return "goIndex";
		}

	}

	public void personUpdate() {
		System.out.println(new_pas);
		int flag = 0;
		Student student = ss.getByHql("from Student where snumber='" + s_number
				+ "'");
		if (student.getSpassword().equals(old_pas)) {
			// 保存新密码
			student.setSpassword(new_pas);
			try {
				HIsession = HibernateSessionFactory.getSession();// 获得session
				HIsession.beginTransaction();// 开启事务
				HIsession.save(student);
				HIsession.getTransaction().commit();
				flag = 1;
			} catch (Exception e) {
				// TODO: handle exception
				HIsession.getTransaction().rollback();
				flag = 0;
				e.printStackTrace();
			} finally {
				HibernateSessionFactory.closeSession();// 关闭事务
			}
		} else {
			// 告诉前台密码错误
			flag = 0;
		}
		writeStringToResponse(flag + "");

	}

	public String register() {
		try {
			HIsession = HibernateSessionFactory.getSession();// 获得session
			HIsession.beginTransaction();// 开启事务
			HIsession.save(stu);
			HIsession.getTransaction().commit();
		} catch (Exception e) {
			// TODO: handle exception
			HIsession.getTransaction().rollback();
			e.printStackTrace();
		} finally {
			HibernateSessionFactory.closeSession();// 关闭事务
		}

		return "login";
	}

	public void getTeachers() {
		List<Teacher> list = new ArrayList<Teacher>();
		list = ts.find("from Teacher");

		System.out.println(list.get(0).getTname());
		writeStringToResponse(JsonTools.createJsonString(list).toString());

	}
	
	public void logout(){
		session.remove("role");
		session.remove("number");
	}

	public String login() {
		if (role.equals("student")) {
			return "StuLoginSuccess";
		} else {
			// 平均分在80分以上的所有学生
			List<Student> stu = ss.find("from Student where tnumber='"
					+ (String) session.get("number") + "'");
			List<Student> listY = new ArrayList<Student>();
			List<Student> listL = new ArrayList<Student>();
			List<Student> listB = new ArrayList<Student>();
			for (int i = 0; i < stu.size(); i++) {
				List<Grade> listG = gs.find("from Grade where snumber='"
						+ stu.get(i).getSnumber() + "'");
				int total = 0;
				if (listG.size() == 0) {
					listB.add(stu.get(i));
				} else {
					for (int j = 0; j < listG.size(); j++) {
						total += listG.get(j).getGscore();
					}
					int ping=total / listG.size();
					if(ping>=80)
						listY.add(stu.get(i));
					else if(ping>=60)
						listL.add(stu.get(i));
					else
						listB.add(stu.get(i));
				}
			}

			
			System.out.println(listY.size() + "JJ" + listL.size() + "JJJ"
					+ listB.size());
			req.setAttribute("listY", listY);
			req.setAttribute("listL", listL);
			req.setAttribute("listB", listB);
			return "TeaLoginSuccess";
		}
	}

	public void loginCheck() {
		// 0不存在这个用户名 1密码错误 2正确去跳转
		int flag = 0;
		if (role.equals("student")) {

			Student student = ss.getByHql("from Student where snumber='"
					+ loginNumber + "'");
			if (null == student) {
				flag = 0;
			} else if (student.getSpassword().equals(loginPassword)) {
				flag = 2;
				session.put("role", "student");
				session.put("number", loginNumber);
			} else {
				flag = 1;
			}

		} else {
			Teacher teacher = ts.getByHql("from Teacher where tnumber='"
					+ loginNumber + "'");
			if (null == teacher) {
				flag = 0;
			} else if (teacher.getTpassword().equals(loginPassword)) {
				flag = 2;
				session.put("role", "teacher");
				session.put("number", loginNumber);
			} else {
				flag = 1;
			}
		}
		writeStringToResponse(flag + "");
	}

	// 验证学号是否已被注册
	public void judgeSNumber() {
		Student student = ss.getByHql("from Student where snumber='"
				+ SNumberJudge + "'");
		if ((student != null) && (student.getSid() != null)) {
			// 被占用
			writeStringToResponse("1");
		} else {
			writeStringToResponse("0");
		}
	}

	public void writeStringToResponse(String content) {
		try {
			resp.setCharacterEncoding("utf-8");
			PrintWriter pw = resp.getWriter();
			pw.write(content);
			pw.flush();
			pw.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

	@Override
	public void setServletRequest(HttpServletRequest arg0) {
		// TODO Auto-generated method stub
		this.req = arg0;
	}

	@Override
	public void setServletResponse(HttpServletResponse arg0) {
		// TODO Auto-generated method stub
		this.resp = arg0;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getLoginPassword() {
		return loginPassword;
	}

	public void setLoginPassword(String loginPassword) {
		this.loginPassword = loginPassword;
	}

	public String getLoginNumber() {
		return loginNumber;
	}

	public void setLoginNumber(String loginNumber) {
		this.loginNumber = loginNumber;
	}

	public String getSNumberJudge() {
		return SNumberJudge;
	}

	public void setSNumberJudge(String sNumberJudge) {
		SNumberJudge = sNumberJudge;
	}

	public String getNew_pas() {
		return new_pas;
	}

	public void setNew_pas(String new_pas) {
		this.new_pas = new_pas;
	}

	public String getOld_pas() {
		return old_pas;
	}

	public void setOld_pas(String old_pas) {
		this.old_pas = old_pas;
	}

	public String getS_number() {
		return s_number;
	}

	public void setS_number(String s_number) {
		this.s_number = s_number;
	}

	@Override
	public Student getModel() {
		// TODO Auto-generated method stub
		return stu;
	}

}
