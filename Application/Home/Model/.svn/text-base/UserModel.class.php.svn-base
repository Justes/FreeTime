<?php
namespace Home\Model;
use Think\Model;

class UserModel extends Model {
	protected $_validate = array(
		array("username","require","用户名不能为空"),
		array("username","6~18","用户名长度为6~18位",1,"length"),
		array("password","require","密码不能为空"),
		array("password","6~18","密码长度为6~18位",1,"length"),
		array("repassword","password","确认密码不正确",0,"confirm")
	);
}
