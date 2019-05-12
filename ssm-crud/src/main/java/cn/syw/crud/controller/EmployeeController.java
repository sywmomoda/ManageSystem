package cn.syw.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import cn.syw.crud.bean.Employee;
import cn.syw.crud.bean.Msg;
import cn.syw.crud.service.EmployeeService;

/*
 * 处理员工增删改查的请求
 */
@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeService;
	
	/**
	 * 根据id删除员工
	 * 可支持批量删除： 1-2-3
	 * 单个删除：1
	 * @param employee
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="emp/{ids}",method=RequestMethod.DELETE)
	public Msg delEmp(@PathVariable("ids") String ids) {
		//批量删除
		if(ids.contains("-")) {
			List<Integer> del_ids = new ArrayList<>();
			String[] str_ids = ids.split("-");
			//组装id的集合
			for(String string : str_ids) {
				del_ids.add(Integer.parseInt(string));
			}
			employeeService.deleteBatch(del_ids);
		}else {//单个删除
			int id = Integer.parseInt(ids);
			employeeService.deleteEmp(id);
		}
		//System.out.println("将要删除的员工id："+empId);

		return Msg.success();
	}
	
	/**
	 * 员工更新方法
	 * @param employee
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	public Msg saveEmp(Employee employee) {
		//System.out.println("将要更新的员工数据："+employee);
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	
	/**
	 *  根据id查询员工
	 * @param id
	 * @return	
	 */
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable Integer id) {
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}
	
	
	/**
	 * 检查用户名是否可用
	 * @param empName
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/checkuser")
	public Msg checkuser(@RequestParam("empName")String empName) {
		//先判断用户名是否是合法的表达式
		String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
		if(!empName.matches(regx)) {
			return Msg.fail().add("va_msg", "用户名格式需为2-15位中文或6-16位字母数字的组合!");
		}
		//再进行数据库用户名重复校验
		boolean b = employeeService.checkUser(empName);
		if(b) {
			return Msg.success();
		}else {
			return Msg.fail().add("va_msg", "用户名不可用！");
		}
	}
	 
	/**
	 * 员工保存
	 * 1.支持JSR303校验
	 * 2.导入Hibernate-Validator
	 * @param employee
	 * @return
	 */
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result) {
		if(result.hasErrors()) {
			//校验失败，返回失败
			Map<String,Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for(FieldError fieldError : errors) {
				System.out.println("错误的字段名："+fieldError.getField());
				System.out.println("错误信息："+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else {
			employeeService.saveEmp(employee); 
			return Msg.success();
		}

	}
	
	/*
	 * 导入jackson包
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(
			@RequestParam(value="pn",defaultValue="1")Integer pn,Model model) {
		//引入PageHelper分页插件
		//在查询之前只需要调用，传入页码，以及每一页的大小
		PageHelper.startPage(pn, 5);
		//startPage后面紧跟的查询就是一个分页查询 
		List<Employee> emps = employeeService.getAll();
		//使用PageInfo包装查询后的结果emps，只需要将PageInfo交给页面就行了
		//封装了详细的分页信息，包括我们查询出来的数据,传入连续显示的页数
		PageInfo<Employee> page = new PageInfo<Employee>(emps,5);
		return Msg.success().add("pageInfo",page);
	}
	
	
	
	
	
	
	//  查询员工数据，分页查询
//	@RequestMapping("/emps")
//	public String getEmps(@RequestParam(value="pn",defaultValue="1")Integer pn,Model model) {
//		
//		//引入PageHelper分页插件
//		//在查询之前只需要调用，传入页码，以及每一页的大小
//		PageHelper.startPage(pn, 5);
//		//startPage后面紧跟的查询就是一个分页查询 
//		List<Employee> emps = employeeService.getAll();
//		//使用PageInfo包装查询后的结果emps，只需要将PageInfo交给页面就行了
//		//封装了详细的分页信息，包括我们查询出来的数据,传入连续显示的页数
//		PageInfo page = new PageInfo(emps,5);
//		model.addAttribute("pageInfo",page);
//		
//		return "list";
//	}
	
}
