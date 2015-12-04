<?php
namespace Admin\Controller;
use Think\Controller;

class BlockController extends Controller{
    //版块查询主页
    public function index(){
        $type = M("type"); 
        $data = $type -> field("typeName,id,parentId,status,path,concat(path,'-',id) route") -> order("route desc") -> select();
       
        //var_dump($data);
        $this -> assign("data",$data); 
        $this -> display();

        }
    
    //增加版块
    public function add(){
         
        $type = M("type"); 
        $data = $type -> field("typeName,id,parentId,status,path,concat(path,'-',id) route") -> order("route") -> select();
       
        //var_dump($data);
        $this -> assign("data",$data); 
        $this -> display(); 
    }
    //增加版块
    public function actAdd(){
      //  var_dump($_POST); 
        $type = M("type");
        $_POST['status'] = "1";
        $_POST['path'] = $_POST['route']; 
        $str = explode("-",$_POST['route']);
        $num =count($str);

       // var_dump($num);
       // var_dump($str);

        $_POST['parentId'] = $str[$num-1];

       // var_dump($_POST);
        
        if($_POST){
        $data = $type -> create();
      //  var_dump($data);
            if($data){
                $rows = $type -> add(); 
                    if($rows){
                        $this -> success("添加成功",U("Block/index")); 
                    }else{
                        $this -> error("添加失败"); 
                    }
            }else{
            
                $this -> error("添加失败"); 
            }
        }else{
            $this -> error("添加失败");
        }
    }
    //删除版块
    public function del(){
    
        //var_dump($_GET);  
        $type = M("type");
        $map['parentId'] = $_GET['id'];
        $data = $type -> where($map) -> select();
        
        //var_dump($data);    
        if($_GET){

            if($data){
                $this -> error("存在子级版块，无法删除"); 
            }else{
                $rows = $type  -> delete($_GET['id']);
                
                if($rows){
                    $this -> success("删除成功",U("Block/index")); 
                }else{
                     $this -> error("删除失败"); 
                }
            }
        }else{
             $this -> error("删除失败"); 
        }     
    }

    //编辑版块 
    public function mod(){
        $get = $_GET;
        $this -> assign("fdata",$get);
        $type = M("type"); 
        $data = $type -> field("typeName,id,parentId,status,path,concat(path,'-',id) route") -> order("route") -> select();
       
        //var_dump($data);
        $this -> assign("data",$data); 
        $this -> display(); 
    }

    public function actMod(){
        //实例化type表
        $type = M("type");
        $datas = $type -> field('path') -> find($_POST['parentId']);
       /* echo "<pre>";
        var_dump($_POST);
        echo "</pre>"; 
        */
        //拆分选择子类版块的path
        $element = explode('-',$datas['path']);

        //用未来父级元素的id同拆分的数组进行比较
        $res = in_array($_POST['id'],$element);
        //进行判断
        if($res){
            $this -> error("版块结构不合理，请重试"); 
            exit;
        }else{
            //子级的绝对路径
            $formerRoute = $_POST['route']; 
            //变为父级的子级后的前几位绝对路径
            $route = $datas['path'].'-'.$_POST['parentId'].'-'.$_POST['id'];
            //在数据库中进行数据替换
            $type -> query("update xy_type set path = replace(path,'{$formerRoute}','{$route}')"); 

            //替换改动的版块本身的路径（不含其子级）
            $formerPath = $_POST['path'];
            //找到未来父级的绝对路径
            $newRoute = $datas['path'].'-'.$_POST['parentId'];
            //建立data数组
           
            $data['path'] = $newRoute;
            $data['parentId'] = $_POST['parentId'];
            $data['typeName'] = $_POST['typeName'];
            //建立map数组
            $map['id'] = $_POST['id'];
            
            $rows = $type -> where($map) -> save($data);

            if($rows){
            
                $this -> success("更改成功",U("Block/index")); 
            }else{
                $this -> error("更改失败"); 
            }
        
        
        
        }

 

    }
    //版块状态编辑
    public function edit(){
    var_dump($_GET); 
        $map['id'] = $_GET['id']; 
        $status = $_GET['status'];
        if($status == '1' ){
            $data['status'] = '0'; 
        }else if($status =='0'){
            $data['status'] = '1'; 
        }
        $type = M("type"); 
        $row = $type -> where($map) -> save($data);

        if($row){

            $this -> redirect("Block/index"); 
        }else{
                $this -> error("更改失败",U("Block/index")); 
            }
    }





















}
