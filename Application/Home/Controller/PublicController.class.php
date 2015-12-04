<?php
namespace Home\Controller;
use Think\Controller;
class PublicController extends Controller{
    public function parent(){
           // $_POST['username'] = 111;
           $user = M("user");
		  // var_dump($_POST);
		  // var_dump($_POST['username']&&($flag == NULL));
		  // var_dump($flag);
		   //$_POST['username'] = 11;
		   if($_POST['username']){
			   
			        $sign = 1;
		   
		   
			    if($_POST['password']){
           
		            $_POST['password'] = md5($_POST['password']);
		            $flag = 1;
                }else{
                    $flag = 0; 
                }
           }
		    $map = 'username="'.$_POST['username'].'"';
		    $map2 = 'username ="'. $_POST['username'] .'" AND password = "'.$_POST['password'].'"';
		//var_dump($map);
		//echo "<br/>";
		//var_dump($map1);
		//echo "<br/>";
		//var_dump($map2);
       
		if($_POST['username']&&($flag==0)){

		    $data = $user -> field('username,id') -> where($map) -> select();  
           if($data){
                echo 1; 
           }else{
                echo 0; 
           }
        }
		
		if($_POST['username']&&($flag==1)){
            $data = $user  -> where($map2) -> select(); 
             if($data){
                echo 2; 
                $userdetail = M("userdetail");
                $map1['userId'] = $data[0]['id'];
                $datas = $userdetail -> where($map1) -> select();
                $_SESSION['user'] = $datas[0];
				//$_SESSION['user'] = $data[0];
                $_SESSION['user']['profile'] = $data[0]['profile'];
                $_SESSION['user']['flag'] = 1;
				$_SESSION['user']['username'] =$data[0]['username'];
				$_SESSION['user']['nickname'] =$data[0]['nickname'];
				$_SESSION['user']['status'] =$data[0]['status'];
				$_SESSION['user']['password'] = $data[0]['password'];
				$_SESSION['user']['id'] = $data[0]['id'];
			    //echo"<pre>";
				//var_dump($_SESSION);
				//echo"</pre>";
				//echo "<br/>";
				//var_dump($datas);
                
           }else{
                echo 3; 
                $aaa=123;
           }  
		   
        }
		//$this -> display();
		
    }
        public function quit(){
            unset($_SESSION); 
            session('[destory]');
            setcookie('PHPSESSID',",time()-1,'1'");
            $this -> redirect("Index/index");

        } 
    
	// 友情链接
	public function links() {
		if($_GET['links']) {
			$links = M("links");
			$datas = $links -> where("status='1'") -> select();
			echo json_encode($datas);
		}
    }

	// 网站配置
	public function man() {
		$man = M("configure");
		$data = $man -> select();
		$this -> ajaxReturn($data);
	}
}
