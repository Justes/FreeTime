<?php
	/**
	 *		
	 */
namespace Home\Controller;
use Think\Controller;

class UserController extends Controller {
 
	/**
	 *		注册
	 */	
	public function register() {
       
        $this -> display();
    }
    public function ajaxReg(){
        $user = M("user");
        
        $map = 'username="'.$_POST['username'].'"';
        $data = $user -> field('username') -> where($map) -> select();
        if($data){
            echo 1; 
        }else{
            echo 0; 
        }
    }
	//用户注册
    public function regSubmit(){
       
        $user = M("user"); 
		
       
		$check = new \Think\Verify();
		if(!$check->check($_POST['code'])){
			$this -> error("验证码错误");
			
		}
		if(!$_POST['password']){
			
			$this -> error("密码不能为空");
		}
      
	  $rule = array(
            array('code','require','验证码错误'),
            array('username','','账号名称已经存在',0,'unique',1),
			//array('password','require','密码不能为空'),
            array('username','6,12','用户名长度在六到十二位之间',1,'length',1),
            array('repassword','password','两次输入有误',1,'confirm',3),
            //array('password','6,32','密码长度在六到十二位之间',1,'length',1),
            array('email',' /\w+@\w+(\.com|\.cn)/','邮箱格式不正确',1,'regex',1),
            array('tel',' /^1\d{10}$/','号码格式不正确',1,'regex',1),
          
        );
		$_POST['password'] = md5($_POST['password']);
       
        $_POST['nickname'] = $_POST['username'];
        $_POST['repassword'] = md5($_POST['repassword']); 
        $data = $user -> validate($rule) -> create();

        if($data){
			
            //向user写入数据
             $row = $user  ->add($data);
                 //如果写入成功
                 if($row){
                    $name = 'username="'.$_POST['username'].'"';
                    $id = $user -> field('id,username') -> where($name) -> select(); 
                    $_POST['userId'] = $id[0]['id'];
                //向详情表写入数据
                    $userDetail = M("userdetail");
                    $datas = $userDetail -> create();
                    
                    $map1['email'] = $datas['email'];
                    $map1['tel'] = $datas['tel'];
                    $map1['userId'] = $datas['userId'];
                    echo"<br/>";

                        
                    if($datas){
                        $rows = $userDetail ->  field('userId,tel,email') ->where($map1) -> add($datas);     
                        if($rows){
                           $this -> success("申请成功",U("Index/index")); 
                        }else{
                           $this -> error("申请失败"); 
                        }
                     }
                     
                        
                 } 
				 
        }else{
            $sign =  $user -> getError();
            $this -> error($sign);
            
        }
    }
    // 验证码
    public function regCode(){
        $codes = new \Think\Verify(); 
         session('[start]');
        //验证码字号
       // $codes -> fontSize = ; 
        //验证码长度
       // $codes -> length =1 ;
        //验证码宽度
        //$codes -> imageW = ;
        //验证码高度
        //$codes -> imageH = ;
        $codes -> useImgBg = true;
        $codes -> entry();
      
      
    
    }
    //验证码检测
    public function regCodeCheck(){
        $check = new \Think\Verify(); 
            $res =  $check -> check($_POST['code'],$id); 
          
        if($res){
            echo 1;
        }else{
            echo 0; 
        }


    }
   
	

	/**
	 *		查看个人信息
	 */
	public function info() {
		$this -> display();
	}

    //更改个人信息	
    public function changeInfo(){
        $this -> display();
    }
    //更改个人信息  
    public function addInfo(){
		//判断数据是否更改
		if(!$_POST['nickname']){
			
			unset($_POST['nickname']);	
		}
		if(!$_POST['email']){
		    $fflag = 1;	
			unset($_POST['email']);	
		}
		if(!$_POST['tel']){
		    $flag = 1;	
			unset($_POST['tel']);	
		}
		if(!$_POST['sex']){
			
			unset($_POST['sex']);	
		}
		if(!$_POST['school']){
		    	
			unset($_POST['school']);	
		}
		if(!$_POST['sign']){
			
			unset($_POST['sign']);	
		}
		if(!$_POST['info']){
			
			unset($_POST['info']);	
		}
		
		//找到原头像文件
		$formerPic = $_SESSION['user']['profile'];
		
		//上传头像文件
		
        if($_FILES['profile']['name']&&$_POST['submit']){
          
			$upload = new \Think\Upload();
			$upload -> maxSize = 10000000;
			$upload -> exts = array('jpg','png','jpeg');
			$upload -> savePath = 'upload/';
			$upload -> rootPath = './Public/Home/';
			$upload -> autoSub = false;
        
			$info = $upload -> uploadOne($_FILES['profile']); 
        //如果上传成功
			if($info){
				
				$first = "default.png";
				if($formerPic != $first){
					unlink("./Public/Home/upload/{$formerPic}");
				
				}
			
			}
		    
            if(!info){
                
				$this -> error($upload -> getError());
				
            }else{
                
				$_POST['profile'] = $info['savename'];
            }
        }else{
			
			$_POST['profile']=$_SESSION['user']['profile'];	
			
		}		
		
		//实例化
		$user = M("user");
        $userdetail = M("userdetail");
        //创建数据对象    
        if(($flag==1)&&($fflag==1)){
			
            $rule =array(); 
        }else if(($flag==1)&&($fflag!=1)){
			
             $rule = array(
           
            array('email',' /\w+@\w+(\.com|\.cn)/','邮箱格式不正确',1,'regex',1),
          
          
            );
        
        }else if(($fflag==1)&&($flag!=1)){
			
             $rule = array(
         
            array('tel',' /^1\d{10}$/','号码格式不正确',1,'regex',1),
          
            );
        
        }else{
          $rule = array(
          
            array('email',' /\w+@\w+(\.com|\.cn)/','邮箱格式不正确',1,'regex',1),
            array('tel',' /^1\d{10}$/','号码格式不正确',1,'regex',1),
          
            );
        }
        $data = $user -> create();
        //压入下标为id的字段   
        $data['id'] = $_POST['userId'];
		$data['profile'] = $_POST['profile'];
		//创建数据对象
		$datas = $userdetail -> validate($rule) -> create();
        
	
		//创建成功 写入数据	
		if($data){
            $res = $user -> save($data);
		}       
            
		//创建成功 写入数据
        if($datas){
            //组成查询条件   
            $map['userId'] = $datas['userId'];
            //写入数据
			$ress = $userdetail -> where($map)->save($datas);
        }
	
            
		
		//判断是否有数据写入
        if($info||$res||$ress){
			
			//将写入的新数据取出 压入SESSION
			$path1 = 'id="'.$_POST['userId'].'"';
			$path2 = 'userId="'.$_POST['userId'].'"';
            $insertData1 = $user -> where($path1) -> select();
			$insertData2 = $userdetail -> where($path2) -> select();
			
		
			//压入前判断	
			if($insertData1||$insertData2){
			
				$_SESSION['user'] = $insertData2[0];
				$_SESSION['user']['flag'] = 1;
				$_SESSION['user']['id'] = $insertData1[0]['id'];
				$_SESSION['user']['username'] = $insertData1[0]['username'];
				$_SESSION['user']['password'] = $insertData1[0]['password'];
				$_SESSION['user']['nickname'] = $insertData1[0]['nickname'];
				$_SESSION['user']['profile'] = $insertData1[0]['profile'];
				$_SESSION['user']['status'] = $insertData1[0]['status'];
				$_SESSION['user']['account'] = $insertData1[0]['account'];
			
				$this -> success("修改成功",U("User/info"));
			}		 
        }else{
				if(($flag==1)&&($fflag==1)){
					
					$sign = "更改失败";
				}else{
					
					$sign = $userdetail -> getError();
				}
				$this -> error($sign,U("User/info"));
        }
    }
	//修改密码
	public function changePwd(){
		
		$this -> display();
	}
	//修改密码
	public function ActChangePwd(){
		$user = M("user");
		
		if($_POST['submit']){
			
            $_POST['password'] = md5($_POST['password']);
            
         
            $data = $user -> create();
			
			$map['id'] = $_POST['id'];
			
			$row = $user -> where($map) -> save($data);
			
			if($row){
				$_SESSION['user']['password'] = $_POST['password'];
				$this -> success("密码更改成功",U("User/info"));
			}else{
				
				$this -> error("密码更改失败",U("User/info"));
               // echo $user -> getError();
			}
		}
		
	
	}
	//ajax判断密码
	public function ajaxPwd(){
		
		$username = $_SESSION['user']['username'];
		$password = md5($_POST['password']);
		
		$user = M("user");
		$map['username'] = $username;
		$map['password'] = $password;
		$data = $user -> field('username,password') -> where($map) -> select();
		if($data){
			
			echo 1;
		}else{
			
			echo 0;
		}
	}
	//设置密保问题
	public function setQues(){
		$this -> display();
	}
	//设置密保问题
	public function actSetQues(){
		$ques = M("question");
		$map['username'] = $_SESSION['user']['username'];
		$formerdata = $ques -> where($map) -> select();
		if($formerdata){
			
			$ques -> where($map) -> delete();
		}
		
		if($_POST){
		
			$data[0]['username'] = $_SESSION['user']['username'];
			$data[0]['question'] = $_POST['question1'];
			$data[0]['answer'] = $_POST['answer1'];
			$data[1]['username'] = $_SESSION['user']['username'];
			$data[1]['question'] = $_POST['question2'];
			$data[1]['answer'] = $_POST['answer2'];
			$data[2]['username'] = $_SESSION['user']['username'];
			$data[2]['question'] = $_POST['question3'];
			$data[2]['answer'] = $_POST['answer3'];
					
			$i=0;
			foreach($data as $v){
				
				if($ques -> add($v)){
					
					$i++;
				}
			}
			if($i==3){
				
				$this -> success("提交成功");	
			}else{
				
				$this -> error("提交失败");
			}
		}
	
	}
/*	public function enterRetrievePwdQues(){
		
		$this -> display();
	}
*/	
	//获取找回密码的账号
	public function retrievePwdAcc(){
		
		$this -> display();
	}
	//获取找回密码的账号
	public function checkRetrieveAcc(){
		//实例化两表
		$user = M("user");
		$ques = M("question");
		
		if($_POST){
			$map['username'] = $_POST['username'];
			//分别从两表中查询用户名是否存在
			$data1 = $user -> field('username') -> where($map) -> select();
			
			$data2 = $ques -> field('username') -> where($map) -> select();
					
				if(!$data1){
					
					$this -> error("用户名错误");
				}else{
					
					
					$sign1 = 1;
					
					if(!$data2){
						
						$this -> error("未设置验证问题");
					}else{
						
						$sign2 = 1;
					}
				
				}
				
				if($sign1&&$sign2){
					//将用户名压入SESSION
					$_SESSION['user']['username'] = $_POST['username'];
					
					$this -> success("验证成功",U("User/enterRetrievePwdQues"));
				}	
				
				
		}
				
	} 
	//获取密保问题
	public function enterRetrievePwdQues(){
		
		
			
			$ques = M("question");
			
			$map['username'] = $_SESSION['user']['username'];
			
			$data = $ques -> field('question') -> where($map) -> select();
			//将查出的验证问题放入SESSION
			$_SESSION['retrievePwd']['question1'] = $data[0]['question'];
			$_SESSION['retrievePwd']['question2'] = $data[1]['question'];
			$_SESSION['retrievePwd']['question3'] = $data[2]['question'];
			//var_dump($data);
			//echo "<br/>";
			//var_dump($_SESSION);
			$this -> assign("data",$data);
			
			$this -> display();
			
			
		
	}
	//获取密保问题
	public function actRetrievePwdQues(){
		
		$ques = M("question");
		
		if($_POST['answer1']&&$_POST['answer2']&&$_POST['answer3']){
			//map ='';
			$data[0]['username'] = $_SESSION['user']['username'];
			$data[0]['question'] = $_SESSION['retrievePwd']['question1'];
			$data[0]['answer'] = $_POST['answer1'];
			$data[1]['username'] = $_SESSION['user']['username'];
			$data[1]['question'] = $_SESSION['retrievePwd']['question2'];
			$data[1]['answer'] = $_POST['answer2'];
			$data[2]['username'] = $_SESSION['user']['username'];
			$data[2]['question'] = $_SESSION['retrievePwd']['question3'];
			$data[2]['answer'] = $_POST['answer3'];
					
			echo "<br/>";
			$i=0;
			foreach($data as $v){
				$map = $v;
				
				
				$data = $ques -> where($map) ->select();
				
				
				if($data){
					
					$i++;
				};
				
			}
			//echo $i;
			if($i==3){
				//echo 11;
				$this -> success("验证通过",U("User/retrievePwd"));	
			}else{
				//echo 22;
				$this -> error("验证失败，请重试");
			}
		}
		
	}
	//重置密码
	public function retrievePwd(){
		
		$this -> display();
	}
	//重置密码
	public function actRetrievePwd(){
		
		$user = M("user");
		
		$map['username'] = $_SESSION['user']['username'];
		
		$_POST['password'] = md5($_POST['password']);
		
		$data = $user -> create(); 
		
		//var_dump($data);
		
		if($data){
		
				$rows = $user -> where($map) -> save($data);
				
				if($rows){
					
					session('[destroy]'); 
					
					session('[regenerate]'); 
					
					$this -> success("修改成功",U("Index/index"));
				}else{
					
					$this -> error("密码修改失败，请重试");
				}
				
		}		
	} 
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   } 

