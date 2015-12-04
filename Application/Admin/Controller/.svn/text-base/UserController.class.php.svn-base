<?php
namespace Admin\Controller;

class UserController extends PublicController{
    //查看用户
    public function index(){
       $user = M("user"); 
	   $map['recycle'] = '1';
       $data = $user ->field('id,username,status') -> where($map) -> select();
       $this -> assign("users",$data);
       $this -> display();
    }
    //增加用户
    public function UserAdd(){
    
        $this -> display(); 
    }
    //增加用户
     public function add(){

        $user = M("user");
        $_POST['password'] = md5($_POST['password']);
         $_POST['repassword'] = md5($_POST['repassword']);
       // var_dump($user -> create());
            $rule = array(
            //array('verity','require','验证码错误'),
            array('username','','账号名称已经存在',0,'unique',1),
            array('username','6,12','用户名长度在六到十二位之间',1,'length',1),
            array('repassword','password','两次输入有误',1,'confirm',3),
           // array('password','6,32','密码长度在六到十二位之间',1,'length',1),
            //array('email',' /\w+@\w+(\.com|\.cn)/','邮箱格式不正确',1,'regex',1),
           // array('tel',' /^1\d{10}$/','号码格式不正确',1,'regex',1),
          
            );
        if($user ->validate($rule) -> create()){
            if($user -> add()){
                $this -> success("添加用户成功",U("User/index")); 

            }else{
                echo 1;
                $this -> error("添加用户失败",U("User/UserAdd")); 
            } 
        }else{               
                echo 2;
                $sign = $user -> getError();
                $this -> error($sign,U("User/UserAdd"));
        }
    }
	//更改用户
     public function UserMod(){
        $user = M("user"); 
        $userDetail = M("userdetail");
        $id = $_GET['id'];
        //echo $id;
      //  var_dump($id);
        $data = $user -> where('id='.$id) -> select();
       // $data = $user -> find($id);
       // var_dump($data);
        $data1 = $userDetail -> where('userId='.$id) -> select();
        //var_dump($data1);
        $this -> assign("user",$data);
        $this -> assign("userDetail",$data1);
        $this -> display(); 
    }
	//更改用户
    public function actUserMod(){
      // var_dump($_POST['id']);  
      // var_dump($_POST['userId']);
        $user = M("user"); 
        $userDetail = M("userdetail");
        if($_POST['password']){
            $_POST['password'] = md5($_POST['password']); 
        }else{
            unset($_POST['password']); 
        }
          $rule = array(
            //array('verity','require','验证码错误'),
            //array('username','','账号名称已经存在',0,'unique',1),
            //array('username','6,12','用户名长度在六到十二位之间',1,'length',1),
            array('repassword','password','两次输入有误',1,'confirm',3),
           // array('password','6,32','密码长度在六到十二位之间',1,'length',1),
            //array('email',' /\w+@\w+(\.com|\.cn)/','邮箱格式不正确',1,'regex',1),
            //array('phone',' /^1\d{10}$/','号码格式不正确',1,'regex',1),
          
            );
              $rules = array(
            //array('verity','require','验证码错误'),
            //array('username','','账号名称已经存在',0,'unique',1),
            //array('username','6,12','用户名长度在六到十二位之间',1,'length',1),
            //array('repassword','password','两次输入有误',1,'confirm',3),
           // array('password','6,32','密码长度在六到十二位之间',1,'length',1),
            array('email',' /\w+@\w+(\.com|\.cn)/','邮箱格式不正确',1,'regex',1),
            array('tel',' /^1\d{10}$/','号码格式不正确',1,'regex',1),
          
            );
        $data = $user ->validate($rule)-> create();
        $data1 = $userDetail ->validate($rules)-> create();
       // var_dump($data1);
       // var_dump($user -> save($data));
       // var_dump($userDetail -> add($data1));
       // var_dump($userDetail -> save($data1));
       // var_dump(($user -> save($data))&&($userDetail -> save($data1)));
        if(($user -> create())||($userDetail -> create())){
            if(($user -> save($data))||($userDetail -> save($data1))){
                $this -> success("更改成功",U("User/index")); 
            }else{
                echo 1;
                $this -> error("更改失败",U("User/index"));
            } 
        }else{
            echo 2;
           
            $sign = $user -> getError();
            $sign1 = $userdetail -> getError();
            $sign2 = $sign.$sign1;
             $this -> error($sign2,U("UserMod/index"));
        }
      
    }
	//更改用户状态
     public function EditUserStatus(){
      
        $_GET['status'] = $_GET['status'] ? "0" : "1";
        var_dump($_GET);
            $user = M("user");
         
        
      
                if($_GET['id']){
                    if($user  -> field('id,status') -> create($_GET)){
                        if($user -> save()){
                            $this -> redirect("User/index"); 
                        }else{
                            $this -> error("修改失败"); 
                        } 
                    }


            }
      
        }
	//将用户移入回收站
	public function UserDel(){
		
		$map['id'] = $_GET['id'];
		$user = M("user");
		$data['recycle'] = '0';
		$rows = $user -> where($map) -> save($data);
		if($rows){
			
			$this -> redirect("User/index");
		}else{
			
			$this -> error("更改失败",U("User/index"));
		}
		
		
	}
		
		
		
		
}
