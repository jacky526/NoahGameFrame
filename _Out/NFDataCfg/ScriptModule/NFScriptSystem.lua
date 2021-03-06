package.path = '../NFDataCfg/ScriptModule/?.lua;../NFDataCfg/ScriptModule/game/?.lua;../NFDataCfg/ScriptModule/world/?.lua;../NFDataCfg/ScriptModule/proxy/?.lua;../NFDataCfg/ScriptModule/master/?.lua;../NFDataCfg/ScriptModule/login/?.lua;'

require("NFScriptEnum");

script_module = nil;
function init_script_system(xLuaScriptModule)
	script_module = xLuaScriptModule;
end

function load_script_file(name)
	for i=1, #(name) do
		if package.loaded[name[i].tblName] then

		else
			local object = require(name[i].tblName);
			if nil == object then
				io.write("load_script_file " .. name[i].tblName .. " failed\n");
			else
				io.write("load_script_file " .. name[i].tblName .. " successed\n");
			end
		end
	end
end

function reload_script_file( name )
  
	

	local old_module = _G[name]
    package.loaded[name] = nil
	local object = require(name);
	if nil == object then
		io.write("  reload_script_file " .. name .. " failed\n");
	else
		io.write("  reload_script_file " .. name .. " successed\n");
	end
	
    local new_module = _G[name]
    for k, v in pairs(new_module) do
        old_module[k] = v
    end
end

function reload_script_table( name )
	io.write("----Begin reload lua list----\n");

	local ret = 0;
	for i=1, #(name) do
		ret = 1;
		io.write("reload script : " .. tostring(name[i].tblName) .. "\n");
		reload_script_file(name[i].tblName)
	end

	io.write("----End reload lua list----\n");

	if ret == 1 then
		for i=1, #(ScriptList) do
			ScriptList[i].tbl.reload();
		end
	end
end

function register_module(tbl, name)
	if ScriptList then
		for i=1, #(ScriptList) do
			if ScriptList[i].tblName == name then
				ScriptList[i].tbl = tbl;
				io.write("----register_module ".. name .. " successed\n");
			end
		end
	end
end

function find_module(name)
	if ScriptList then
		for i=1, #(ScriptList) do
			if ScriptList[i].tblName == name then
				return ScriptList[i].tbl;
			end
		end
	end
end
---------------------------------------------
function module_awake(...)
	for i=1, #(ScriptList) do
		ScriptList[i].tbl.awake(...);
	end
end


function module_init(...)
	for i=1, #(ScriptList) do
		ScriptList[i].tbl.init(...);
	end
end

function module_after_init(...)
	for i=1, #(ScriptList) do
		ScriptList[i].tbl.after_init(...);
	end
end

function module_ready_execute(...)	
	for i=1, #(ScriptList) do
	ScriptList[i].tbl.ready_execute(...);
	end
end

function module_before_shut(...)
	for i=1, #(ScriptList) do
		ScriptList[i].tbl.before_shut(...);
	end
end

function module_shut(...)
	for i=1, #(ScriptList) do
		ScriptList[i].tbl.shut(...);
	end
end

----------------------------------------------
