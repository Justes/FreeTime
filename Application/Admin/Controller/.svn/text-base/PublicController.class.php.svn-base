<?php
namespace Admin\Controller;
use Think\Controller;

class PublicController extends Controller{
	
	public function _initialize(){
	//判断管理员是否登录	
        if($_SESSION['manage']['sign'] != 1 ){
            
            $this -> redirect("Login/index");
        }
	//判断登录的模块是否在用户组的权限之内
	    $auth = new \Think\Auth();	
        $url = CONTROLLER_NAME.'/'.ACTION_NAME;
        $uid = $_SESSION['manage']['id'];
        if($auth -> check($url,$uid)){
            return true; 
        }else{
            $this -> error("无权限",U("Index/index")); 
        }
    	
	} 

    	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
