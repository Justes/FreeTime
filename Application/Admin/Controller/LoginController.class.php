<?php
namespace Admin\Controller;
use Think\Controller;
class LoginController extends Controller{

    public function index(){
    
        $this -> display(); 
    }



	//管理员登录
    public function actLogin(){
        
        $manage = M("manage"); 
		//登录时判断
        if($_POST['submit']){
            
            $data = $manage -> create();  
           
            if($data){
                 
                $map['username'] = $data['username'];
                $map['password'] = md5($data['password']);
                $res = $manage -> where($map) -> select();
				//判断成功后压入SESSION
                if($res){
                    $_SESSION['manage'] = $res[0]; 
                    $_SESSION['manage']['sign'] = 1;
					
					//var_dump($_SESSION['manage']);
                    $this -> success("登陆成功",U("Index/index")); 
                }else{
                   
                    $this -> error("用户名或密码错误",U("Login/index"));  
                }
            }else{
               
                $this -> error("用户名或密码错误".U("Login/index"));   
            }
        }else{
           
            $this -> error("用户名或密码错误",U("Login/index"));
        }
    }
	//管理员登出
    public function logout(){
    
        $_SESSION['manage'] = array();
		
		$this -> redirect("Login/index");
    }
}
