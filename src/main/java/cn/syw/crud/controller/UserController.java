package cn.syw.crud.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.syw.crud.bean.Msg;
import cn.syw.crud.bean.User;
import cn.syw.crud.service.UserService;

@Controller
public class UserController {
	
	@Autowired
	UserService userService;
	
	//public User user1;
	
	//注册添加用户
	@ResponseBody
	@RequestMapping(value="/user",method=RequestMethod.POST)
	public Msg addUser(@Valid User user) {
		userService.saveUer(user);
		return Msg.success();
	}
	
	
	
	//根据ID查询用户，验证登录
/*	@RequestMapping(value="/user/{Id}/info",method=RequestMethod.GET)
	@ResponseBody
	public Msg checkUser(@PathVariable Integer Id) {
		//List<User> users = userService.getAll();
		user1 = userService.getUser(Id);
		if(user1!=null) {
			//if(user.getPassword()!=)
			System.out.println(user1.getUserId()+" "+user1.getUsername());
			//if(user.getUsername())
		}
		return Msg.success();
	}*/
	
	//登录验证，数据库中根据Id查找吗，与输入的比较
	@ResponseBody
	@RequestMapping(value="/user2/{InputId}/{InputName}/{InputPwd}",method=RequestMethod.GET)
	public Msg checkUser(@PathVariable Integer InputId,@PathVariable String InputName,@PathVariable String InputPwd) {
		User user =  userService.getUser(InputId);
		
		//解码中文用户名
		try {
			InputName = URLDecoder.decode(InputName, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
//		System.out.println("Id："+InputId+" name:"+InputName+" pwd："+InputPwd);
//		System.out.print("判断用户名：");
//		System.out.println(InputName.equals(user.getUsername()));
//		System.out.println("数据库中数据："+user.getUsername()+" 表单数据："+InputName);
//		System.out.print("判断密码：");
//		System.out.println(InputPwd.equals(user.getPassword()));
		
		if(user!=null) {
			if(InputName.equals(user.getUsername())) {
				if(InputPwd.equals(user.getPassword())){
					//System.out.println("匹配成功***************");
					return Msg.success();
				}else {return Msg.fail();}
			}else {return Msg.fail();}
		}else {
			return Msg.fail();
		}
		
	}

}
