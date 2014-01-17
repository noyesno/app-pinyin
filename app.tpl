<!DOCTYPE html>
{config_load 'smarty.cfg'}
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>拼音打字练习 - 非是非</title>
<meta name="author" content="非是非" />
<meta name="copyright" content="Copyright 2012"/> 
<meta name="keywords" content="汉字,中文,拼音,输入法"/>
<meta name="description" content="学习和练习拼音输入法"/>
<base href="/pinyin/"/>
<link rel="shortcut icon" href="{#favicon#}"/>

<style type="text/css">
{literal}
#hz_quiz {margin:1em 0;padding:1em;text-align:center}
#hz_hz    {display:inline-block;font-size:48px;width:2em; max-width:5em;height:60px;line-height:60px;border:1px solid silver;padding:6px;background-color:#eeeeee}
#hz_py    {display:inline-block;font-size:48px;width:3em; max-width:6em;height:60px;line-height:60px;border:1px solid silver;padding:6px;background-color:#eeeeee}
#hz_input {font-size:48px; height:60px;line-height:60px;border:1px solid silver;padding:6px;width:6em;background-color:#f3f4cc}

#keyboard {background-color:#eeeeee}
.chars {font-size:24px;line-height:140%;letter-spacing:0.5em}
.kb_key {font-size:32px;font-weight:bold;border:1px solid gray;background-color:silver;padding:2px 5px;margin-top:3px;line-height:150%}
.kb_stroked {background-color:yellow}
#kb_F, #kb_J {border:1px solid black; text-decoration:underline;}

#ft {text-align:center;font-size:small;color:gray}
#ft a {color:gray;margin:1px 6px}
#py_chart {font-family:黑体,fixed,宋体,monospace}

.donate {color:red !important;}
{/literal}
</style>
</head>
<body>

<h1>拼音打字练习</h1>
<div style="margin-bottom:1em;font-size:small;">
—— 献给好学的爸爸、妈妈们！
</div>

<div style="float:left;margin-right:3em;background-color:#eeeeee;font-size:16px;padding:3px">
{capture 'text'}
声母:                                      zh ch sh
b p m f d t n l g k h j q x r y    w       z  c  s  
B P M F D T N L G K H J Q X R Y    W       Z  C  S
-------------------------------------------------
韵母:          a    o    e    i    u    v
            +-----------------------------
        n   |  an        en   in   un
        ng  |  ang  ong  eng  ing      
        a   |                 ia   ua
        o   |  ao                  uo
        e   |                 ie   ue
        i   |  ai        ei        ui
        u   |       ou        iu
        r   |            er
            +-----------------------------
                              iao  uai
                              ian  uan 
                              iang uang
                              iong
{/capture}
<pre id='py_chart'>{preg_replace('/[a-z]+/', '<a href="$0">$0</a>', $smarty.capture.text) nofilter}</pre>

{capture 'text'}
  Q W E R T Y U I O P [ ]
   A S D F G H J K L ; '
    Z X C V B N M , . ?
{/capture}
<pre id="keyboard">{preg_replace('/\S/', '<span class="kb_key" id="kb_$0">$0</span>', $smarty.capture.text) nofilter}</pre>



<div style="text-align:center">

  <a href='http://me.alipay.com/noyesno' class="donate" style="font-size:90%">向开发者捐款</a>
</div>
</div>

<!-- 
<ul>
<li>
声母：
{foreach $page->sm_parts as $sm=>$n}
<a href="{$helper->url($sm)}">{$sm}</a>
{/foreach}
</li>
<li>
韵母：
{foreach $page->ym_parts as $ym=>$n}
<a href="{$helper->url($ym)}">{$ym}</a>
{/foreach}
</li>
</ul>
-->

{if !empty($page->chars)}
<h2>{$page->py_part|default:'随机练习'}</h2>
<div class="chars" id="hz_list">{foreach $page->chars as $hz=>$py}
  <span title="{$py}">{$hz}</span>
{/foreach}</div>
{/if}

<div id="hz_quiz">
<form method="get" action="#" onsubmit="init_typing();return false;">
  <span id="hz_hz"></span>
  <span id="hz_py"></span>
  <!-- input type="text" id="hz_hz" readonly="readonly"/>
  <input type="text" id="hz_py" readonly="readonly"/ -->
  <input type="text" id="hz_input" placeholder="输入拼音" title="输入拼音后按回车键练习下一个字"/>
  <!--button type="submit">输入</button-->
 <div style="font-size:90%;margin-top:1em">
   <a href="">随机练习</a>
 </div>
</form>
</div>

<hr style="clear:both"/>

<div style="display:none">
<form method="post" action="" style="text-align:center;margin:auto;width:96%">
  <textarea name="text" style="width:98%;height:300px">汉字转拼音</textarea>
<br/>
 <button type="submit">提交</button>
</form>
</div>


<div id="ft">
  <a href="http://noyesno.net/">非是非</a>
 | <a href="http://noyesno.net/about">关于</a>
 | <a href="mailto:%6e%6f%79%65%73%6e%6f%2e%6e%65%74%40%67%6d%61%69%6c%2e%63%6f%6d" rel="nofollow">联系</a>
 | 版权所有 &copy; 非是非 2012
 | <a class="donate" href='http://me.alipay.com/noyesno'>向开发者捐款</a>
</div>
<!-- button type="button" onclick="init_typing()">Next</button -->

<script type="text/javascript" src="http://lib.sinaapp.com/js/jquery/1.5.2/jquery.min.js"></script>
<script  type="text/javascript">
//<![CDATA[
{literal}

function init_typing(){
  var val = $('#hz_input').val();
  if(val.length>0 && val!=$('#hz_py').text()){
    alert("输入错误！请重新输入！");
    return;
  }
  var chars = $('.chars span');
  var n = chars.length;
  var i = Math.floor(n*Math.random());
  var c = $(chars.get(i));
  var pinyin = c.attr('title');
  $('#hz_hz').text(c.text());
  $('#hz_py').text(pinyin);
  $('#hz_input').val('').focus();
  $('.kb_key').removeClass('kb_stroked');
  for(var i=0; i<pinyin.length; i++){
    var key = pinyin.charAt(i).toUpperCase();
    $('#kb_'+key).addClass('kb_stroked');
  }
}


if($('#hz_list').width()<600) $('#hz_list').hide();

init_typing();
{/literal}
//]]>
</script>

<script src="{#site_static#}/asset/site.js"></script>
</body></html>
