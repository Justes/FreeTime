<?php
namespace Admin\Controller;

class AuthController extends PublicController{
	//查看规则
    public function rule(){
        $rule = M('auth_rule'); 
        $data = $rule -> select();
        $this -> assign("data",$data);
        $this -> display();
    }
   //添加规则 
    public function ruleAdd(){
        $rule = M("auth_rule");
		
        if(isset($_POST['sub'])){
        
            $data = $rule -> create();

            if($data){
            
                $res = $rule -> add();  

                if($res){
                
                    $this -> success("添加成功",U("Auth/rule")); 
                    exit;
                }else{
                
                    $this -> error("添加失败"); 
                    exit;
                }
                
            }else{
                $this -> error("添加失败"); 
                exit;
            }
        }

        $this -> display();
    }
	//更改规则
    public function ruleMod(){
        $id = $_GET['id'];
        $map['id'] = $id;
        $rule = M("auth_rule");
        $data = $rule -> where($map) -> select();
        $this -> assign("data",$data);
        if($_POST['sub']){
        
            $data1 = $rule -> create(); 
            //var_dump($data1);
            if($data1){
                 
                $rows = $rule -> save($data1); 

                if($rows){
                    $this -> success("更改成功",U("Auth/ruleMod")); 
                    exit;
                }else{
                    $this -> error("更改失败"); 
                    exit;
                }
            }else{
                $this -> error("更改失败"); 
                exit;
            }
        }
    
        $this -> display();
    }
	//删除规则
    public function ruleDel(){
    
        $rule = M("auth_rule"); 
        $id = $_GET['id'];
        if($_GET){
             
            $rows = $rule -> delete($id);

            if($rows){
            
                $this -> redirect("Auth/rule"); 
            }else{
                
                $this -> error("删除失败",U("Auth/rule"));
            }
        }else{
        
             $this -> error("删除失败",U("Auth/rule")); 
        }
    }
	//查看用户组
    public function group(){
    
        $group = M("auth_group"); 
        $rule = M("auth_rule");
        $data = $group -> select();
        //$flag ='';
        foreach($data as $k => $v){
                
            $array = explode(",",$v['rules']);  
            $flag = '';
            foreach($array as $kk=>$vv){
                
                $data1 = $rule -> field("title") -> find($vv);
                $flag .=$data1['title'].'/' ;
                 
            }
            $flag = trim($flag,'/');
            $data[$k]['flag'] = $flag;
        
        }
        
        //var_dump($data);
        $this -> assign("data",$data);
        $this -> display();
    }
	//增加用户组
    public function groupAdd(){
        $group = M("auth_group");
        if(isset($_POST['sub'])){
            $_POST['status'] = 1;
			//拆分字符串
            $_POST['rules'] = implode(',',$_POST['rules']);
            $data = $group -> create();
            if($data){
                 
                $res = $group -> add();

                if($res){
                
                    $this -> success("添加成功",U("Auth/group")); 
                    exit;
                }else{
                
                    $this -> error("添加失败"); 
                    exit;
                }
            }else{
            
                $this -> error("添加失败"); 
                exit;
            }
        } 
        $rule = M("auth_rule"); 
        $data = $rule -> select();
        $this -> assign("data",$data);
        $this -> display();
    }
    //编辑用户组
    public function groupMod(){
       
        $group = M("auth_group");
        if(isset($_POST['sub'])){
            
            $_POST['status'] = 1;
            $_POST['rules'] = implode(',',$_POST['rules']);
            $datass = $group -> create();
            if($datass){
                $map2['id'] = $_POST['id']; 
                $res = $group -> where($map2) -> save($datass);

                if($res){
                
                    $this -> success("更改成功",U("Auth/group")); 
                    exit;
                }else{
                    
                    $this -> error("更改失败",U("Auth/group")); 
                   
                }
            }else{
                 
                $this -> error("更改失败",U("Auth/group")); 
                
            }
        } 
        
        $id = $_GET['id'];
        $map['id'] = $id;
        $datas = $group -> where($map) -> select();
      
		//拆分字符串
        $datas[0]['numbers'] = explode(',',$datas[0]['rules']);
        $rule = M("auth_rule"); 
        $data = $rule -> select();
        $this -> assign("data",$data);
        $this -> assign("datas",$datas);
        $this -> assign("mess",$datas[0]['numbers']);



        $this -> display();
         
    }
	//删除用户组
    public function groupDel(){
        
        $group = M("auth_group"); 
        $id = $_GET['id'];
        if($_GET){
             
            $rows = $group -> delete($id);

            if($rows){
            
                $this -> redirect("Auth/group"); 
            }else{
                
                $this -> error("删除失败",U("Auth/group"));
            }
        }else{
        
             $this -> error("删除失败",U("Auth/group")); 
        }
    }
         





}
