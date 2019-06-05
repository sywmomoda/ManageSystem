package cn.syw.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.syw.crud.bean.Employee;
import cn.syw.crud.bean.EmployeeExample;
import cn.syw.crud.bean.EmployeeExample.Criteria;
import cn.syw.crud.dao.EmployeeMapper;


@Service
public class EmployeeService {
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	//查询所有员工
	public List<Employee> getAll() {
		return employeeMapper.selectByExampleWithDept(null);
	}
	
	//员工保存方法
	public void saveEmp(Employee employee) {
		employeeMapper.insertSelective(employee);
	}

	/**
	 * 检验用户名是否可用
	 * @param empName
	 * @return true:代表当前姓名可用  false：不可用
	 */
	public boolean checkUser(String empName) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria =example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(example);
		return count == 0;
	}

	/**
	 * 按照员工id查询员工
	 * @param id
	 * @return
	 */
	public Employee getEmp(Integer id) {
		Employee employee = employeeMapper.selectByPrimaryKeyWithDept(id);
		return employee;
	}

	/**
	 * 员工更新
	 * @param employee
	 */
	public void updateEmp(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
	}
	
	/**
	 * 根据员工Id删除员工
	 * @param empId
	 */
	public void deleteEmp(Integer empId) {
		employeeMapper.deleteByPrimaryKey(empId);
	}

	public void deleteBatch(List<Integer> ids) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		//delete from xxx where emp_id in(1,2,3)
		criteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(example);
	}

}
