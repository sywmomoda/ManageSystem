package cn.syw.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.syw.crud.bean.Department;
import cn.syw.crud.bean.Employee;
import cn.syw.crud.dao.DepartmentMapper;
import cn.syw.crud.dao.EmployeeMapper;

/**
  *  测试dao层的工作
  *  推荐Spring的项目就可以使用Spring的单元测试，可以自动注入我们需要的组件
 *  1.导入SpringTest模块
 *  2.@ContextConfiguration指定Spring配置文件的位置
 *  3.直接autowired要使用的组件即可
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:applicationContext.xml"})
public class MapperTest {
	@Autowired
	DepartmentMapper departmentMapper;
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	@Autowired
	SqlSession sqlsession;
	
	/** 
	 * 测试DepartmentMapper
	 */
	@Test
	public void testCRUD() {
		/*//1.创建SpringIOC容器
		ApplicationContext ioc =new ClassPathXmlApplicationContext("");
		//2.从容器中获取mapper
		DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);*/
		
		System.out.println(departmentMapper);
		
		//1.插入几个部门		
//		departmentMapper.insertSelective(new Department(null,"开发部"));
//		departmentMapper.insertSelective(new Department(null,"测试部"));

		//2.生成员工数据，测试员工插入
//		employeeMapper.insertSelective(new Employee(null,"王五", "M", null, 1));
//		employeeMapper.insertSelective(new Employee(null,"李四", "M", null, 2));
//		System.out.println("插入完成！");
		// 测试删除员工
//		employeeMapper.deleteByPrimaryKey(1);
//		employeeMapper.deleteByPrimaryKey(2);
//		System.out.println("删除成功！");
		
		//3.批量插入多个员工；批量，使用可以执行批量操作的sqlSession。
//		for(){
//			employeeMapper.insertSelective(new Employee(null,"李四", null, null, null));
//		}
				
		EmployeeMapper mapper = sqlsession.getMapper(EmployeeMapper.class);
		for(int i=0;i<1000;i++) {
			String uid = UUID.randomUUID().toString().substring(0, 5)+i;
			mapper.insertSelective(new Employee(null, uid, "M", uid+"@163.com", 2));
		}
		System.out.println("批量插入完成！");
		
//		EmployeeMapper mapper = sqlsession.getMapper(EmployeeMapper.class);
//		for(int i=0;i<10010;i++) {
//			mapper.deleteByPrimaryKey(i);
//		}
//		System.out.println("批量删除完成！");		
		
	}
}
