package cn.syw.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.syw.crud.bean.User;
import cn.syw.crud.dao.UserMapper;

@Service
public class UserService {
	
	@Autowired
	UserMapper userMapper;
	
	//插入用户，ID（自增）
	public void saveUer(User user) {
		userMapper.insertSelective(user);
	}

	public User getUser(Integer Id) {
		User user = userMapper.selectByPrimaryKey(Id);
		return user;
	}

	public List<User> getAll() {
		return userMapper.selectByExample(null);
	}
}
