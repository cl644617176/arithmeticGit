package ljf.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ljf.pojo.Exam;
import ljf.pojo.Grade;
import ljf.pojo.Rank;
import ljf.pojo.Student;
import ljf.service.ExamService;
import ljf.service.GradeService;
import ljf.service.StudentService;
import ljf.service.impl.ExamServiceImpl;
import ljf.service.impl.GradeServiceImpl;
import ljf.service.impl.StudentServiceImpl;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import utils.JsonTools;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class GradeRecordAction extends ActionSupport implements
		ServletRequestAware, ServletResponseAware {
	private HttpServletResponse resp;
	private HttpServletRequest req;
	private GradeService gs = new GradeServiceImpl();
	private ExamService es = new ExamServiceImpl();
	private StudentService ss = new StudentServiceImpl();
	private Map<String, Object> session=ActionContext.getContext().getSession();

	// ��ʶ������ǵڼ�ҳ������
	public String askPageNum;

	public String InforGid;

	public String snu_tea;
	
	//��תȥ�鿴�ɼ�����ͼ  ѧ���Ĺ���
	
	public String goScore(){
		return "goScore";
	}

	public void getScore() {
		//ǰʮ��
		List<Grade> listP = new ArrayList<Grade>();
		List<Grade> listM = new ArrayList<Grade>();
		List<Grade> listH = new ArrayList<Grade>();
		if (snu_tea == null || snu_tea.equals("")) {
			listP = gs.getFrontRecordByLevel((String)session.get("number"), "primary");
			listM = gs.getFrontRecordByLevel((String)session.get("number"), "medium");
			listH = gs.getFrontRecordByLevel((String)session.get("number"), "higher");
		} else {
			listP = gs.getFrontRecordByLevel(snu_tea, "primary");
			listM = gs.getFrontRecordByLevel(snu_tea, "medium");
			listH = gs.getFrontRecordByLevel(snu_tea, "higher");
		}
		if(listP.size()>10){
			listP=getTopTen(listP);
		}
		if(listM.size()>10){
			listM=getTopTen(listM);
		}
		if(listH.size()>10){
			listH=getTopTen(listH);
		}

		System.out.println(listP.size() + "***" + listM.size() + "*********"
				+ listH.size());
		List<List<Grade>> list = new ArrayList<List<Grade>>();
		list.add(listP);
		list.add(listM);
		list.add(listH);
		try {
			System.out.println(JsonTools.createJsonString(list));
			resp.setCharacterEncoding("UTF-8");
			resp.getWriter().print(JsonTools.createJsonString(list));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	
	//�õ�ǰʮ������
	public List<Grade> getTopTen(List<Grade> data){
		List<Grade> list=new ArrayList<Grade>();
		for(int i=0;i<10;i++){
			list.add(data.get(i));
		}
		return list;
	}

	public String gradeInfor() {

		Grade grade = gs.getByHql("from Grade where gid='" + InforGid + "'");
		List<Exam> listExam = es.find("from Exam where gid='" + InforGid + "'");
		Student stu = ss.getByHql("from Student where snumber='"
				+ grade.getSnumber() + "'");
		req.setAttribute("name", stu.getSname());

		req.setAttribute("grade", grade);
		req.setAttribute("listExam", listExam);
		if(session.get("role").equals("student")){
			return "gradeDetail";
		}else{
			return "tgradeDetail";
		}

		
	}

	// ����ѧ�Ż�������еĿ��Լ�¼ ��ҳ��ʾ һҳ10��
	public String getRecord() {
		// ����ÿҳ�Ķ��ٸ�
		int pages = 5;
		List<Grade> data=new ArrayList<Grade>();
		if (snu_tea == null || snu_tea.equals("")) {
			data = gs.getFrontRecord((String)session.get("number"));
		}else{
			data = gs.getFrontRecord(snu_tea);
		}
		 
		List<Grade> list = getPageList(data, Integer.parseInt(askPageNum),
				pages);
		req.setAttribute("askList", list);
		req.setAttribute("askPageNum", askPageNum);
		req.setAttribute("totalPages", data.size() % pages == 0 ? data.size()
				/ pages : data.size() / pages + 1);
		if(session.get("role").equals("student")){
			return "gradeRecord";
		}else{
			return "tgradeRecord";
		}
		
	}

	public String getRank() {
		// �õ�ǰʮ����Rank
		List<Grade> data = gs.getRank();
		List<Rank> list = new ArrayList<Rank>();

		for (int i = 0; i < data.size() && i < 10; i++) {
			Student stu = new Student();
			Rank rank = new Rank();
			stu = ss.getByHql("from Student where snumber='"
					+ data.get(i).getSnumber() + "'");
			rank.setGduration(data.get(i).getGduration());
			rank.setGid(data.get(i).getGid());
			rank.setGlevel(data.get(i).getGlevel());
			rank.setName(stu.getSname());
			rank.setSnumber(stu.getSnumber());
			rank.setGscore(data.get(i).getGscore());
			list.add(rank);
		}
		req.setAttribute("rankList", list);
		return "rank";
	}

	// ���������� �Լ������ҳ���� ÿҳ�ĸ���
	public List<Grade> getPageList(List<Grade> data, int pageNum, int pages) {
		List<Grade> list = new ArrayList<Grade>();
		Grade grade=new Grade();
		int f=0,m=0;
		int j = (pageNum - 1) * pages;
		for (int i = 0; i < pages; i++) {
			if ((i + j) < data.size()) {
				grade=data.get(j + i);
				f=grade.getGduration()/60;
				m=grade.getGduration()%60;
				if(f==0){
					grade.setGother(m+"��");
				}else{
					grade.setGother(f+"��"+m+"��");
				}
				f=0;
				m=0;
				list.add(grade);
			}
		}
		return list;
	}

	public String getAskPageNum() {
		return askPageNum;
	}

	public void setAskPageNum(String askPageNum) {
		this.askPageNum = askPageNum;
	}

	public String getInforGid() {
		return InforGid;
	}

	public void setInforGid(String inforGid) {
		InforGid = inforGid;
	}

	@Override
	public void setServletRequest(HttpServletRequest arg0) {
		// TODO Auto-generated method stub
		this.req = arg0;
	}

	public String getSnu_tea() {
		return snu_tea;
	}

	public void setSnu_tea(String snu_tea) {
		this.snu_tea = snu_tea;
	}

	@Override
	public void setServletResponse(HttpServletResponse arg0) {
		// TODO Auto-generated method stub
		this.resp = arg0;
	}

}