<?php
namespace Admin\Controller;

class AdminController extends PublicController{
	//查看管理员
    public function index(){
        $admin = M("manage");
        $data = $admin -> select();
        $this -> assign("admins",$data);
        $this -> display(); 

    }
	//添加管理员
    public function add(){
    
        $this -> display(); 
    }
	//添加管理员
    public function addAction(){
        //var_dump($_POST); 
        $admin = M("manage");
        if($_POST['password']){
            $_POST['password'] = md5($_POST['password']); 
        }else{
            unset($_POST['password']); 
        }
        $_POST['repassword'] = md5($_POST['repassword']);
          $rule = array(
            //array('verity','require','验证码错误'),
            array('username','','账号名称已经存在',0,'unique',1),
            array('username','6,12','用户名长度在六到十二位之间',1,'length',1),
            array('repassword','password','两次输入有误',1,'confirm',3),
           // array('password','6,32','密码长度在六到十二位之间',1,'length',1),
           // array('email',' /\w+@\w+(\.com|\.cn)/','邮箱格式不正确',1,'regex',1),
           // array('phone',' /^1\d{10}$/','号码格式不正确',1,'regex',1),
          
            );
        if($admin -> validate(rule) ->create()){
            if($admin -> add()){
                 
                $map['username'] = $_POST['username'];
               
                $data = $admin -> where($map) -> select();
               
				//将更改的权限值写入对应的用户组表里
                $access = M("auth_group_access");
                if($data[0]['auth'] == '0'){
                    $add = M("auth_group");
                    $map1['title'] = "初级管理员";
                    $data1 = $add -> where($map1) -> select();
                    $datas['uid'] = $data[0]['id']; 
                    $datas['group_id'] = $data1[0]['id'];
                    $datass = $access -> add($datas);
                    if($datas){
                        $this -> success("添加成功",U("Admin/index"));
                    }else{
                         $this -> error("权限写入失败，请重试");
                    }
                }else if($data[0]['auth'] == '1'){
                    $add = M("auth_group");
                    $map1['title'] = "中级管理员";
                    $data1 = $add -> where($map1) -> select();
                    $datas['uid'] = $data[0]['id']; 
                    $datas['group_id'] = $data1[0]['id'];
                    $datass = $access -> add($datas);
                    if($datas){
                        $this -> success("添加成功",U("Admin/index"));
                    }else{
                         $this -> error("权限写入失败，请重试");
                    }
                }else if($data[0]['auth'] == '2'){
                    $add = M("auth_group");
                    $map1['title'] = "超级管理员";
                    $data1 = $add -> where($map1) -> select();
                    $datas['uid'] = $data[0]['id']; 
                    $datas['group_id'] = $data1[0]['id'];
                    $datass = $access -> add($datas);
                    if($datas){
                        $this -> success("添加成功",U("Admin/index"));
                    }else{
                         $this -> error("权限写入失败，请重试");
                    }
                }
            }else{
                $this -> error("添加失败"); 
            } 
        }else{
            $sign = $admin -> getError();
            $this -> error($sign); 
        }
    }
	//编辑管理员
    public function mod(){
      // var_dump($_GET['id']);
       
        $id = $_GET['id'];
        $admin = M("manage"); 
        $data = $admin -> where('id='.$id) -> select();
        $this -> assign("admin",$data);
        $this -> display();
    }
	//编辑管理员
    public function modAction(){
        //var_dump($_POST); 
        $admin = M("manage");
        if($_POST['password']){
             $_POST['password'] = md5($_POST['password']); 
            $_POST['repassword'] = md5($_POST['repassword']);
            $rule = array(
            //array('verity','require','验证码错误'),
            //array('username','','账号名称已经存在',0,'unique',1),
            array('username','6,12','用户名长度在六到十二位之间',1,'length',1),
            array('repassword','password','两次输入有误',1,'confirm',3),
           // array('password','6,32','密码长度在六到十二位之间',1,'length',1),
           // array('email',' /\w+@\w+(\.com|\.cn)/','邮箱格式不正确',1,'regex',1),
           // array('phone',' /^1\d{10}$/','号码格式不正确',1,'regex',1),
        
            );
           
             $datass = $admin -> validate($rule) -> create();
        }else{
            unset($_POST['password']); 
            $datass = $admin -> create();
        }
        
        if($datass){

            if($admin -> save()){
                
                $map['id'] = $_POST['id'];
                $map2['uid'] = $_POST['id'];
               
                $data = $admin -> where($map) -> select();
               
				//如果更改权限 将更改的权限值写入对应的用户组表里
                $access = M("auth_group_access");
                if($data[0]['auth'] == '0'){
                    $add = M("auth_group");
                    $map1['title'] = "初级管理员";
                    $data1 = $add -> where($map1) -> select();
                    $datas['uid'] = $data[0]['id']; 
                    $datas['group_id'] = $data1[0]['id'];
                    $datass = $access -> where($map2) -> save($datas);
                   
                }else if($data[0]['auth'] == '1'){
                    $add = M("auth_group");
                    $map1['title'] = "中级管理员";
                    $data1 = $add -> where($map1) -> select();
                    $datas['uid'] = $data[0]['id']; 
                    $datas['group_id'] = $data1[0]['id'];
                    $datass = $access -> where($map2) -> save($datas);
                   
                }else if($data[0]['auth'] == '2'){
                    $add = M("auth_group");
                    $map1['title'] = "超级管理员";
                    $data1 = $add -> where($map1) -> select();
                    $datas['uid'] = $data[0]['id']; 
                    $datas['group_id'] = $data1[0]['id'];
                    $datass = $access -> where($map2) -> save($datas);
                   
                }
                if($_POST['password']){
                     $_SESSION['manage']['password'] = $_POST['password'];
                }
                $_SESSION['manage']['auth'] = $data[0]['auth'];
                $this -> success("更改成功",U("Admin/index")); 
            }else{
                $this -> error("更改失败"); 
            }
        }else{
            if($_POST['password']){
                $sign = $admin -> getError(); 
                $this -> error($sign);
            
            }else{
                 $this -> error("更改失败");
            }
            
        }
    }
	//删除管理员
    public function del(){
        $id = $_GET['id']; 
        $admin = M("manage");
        if($admin -> delete($id)){
            $this -> success("删除成功",U("Admin/index")); 
        }else{
            $this -> error("删除失败"); 
        }
    }
}
