<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.atc.database.explore.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
<title>Insert title here</title>
</head>
<body>

<form action="index.jsp">

<div class="container">

	<h1>Database Explorer</h1>
	
	<div class="row toggable">
		<div class="col-xs-2">
			Database Type:
			<select class="database form-control">
				<option value="sqlserver2000">SQL Server 2000</option>
			</select>
		</div>
		<div class="col-xs-2">
			Database Name:
			<input class="databaseName form-control" 	placeholder="Database Name" value="ShareGen"/>
		</div>
		<div class="col-xs-2">
			Username:
			<input class="databaseUsername form-control" placeholder="Username" value="semaan_app_user"/>
		</div>
		<div class="col-xs-2">
			Password:
			<input class="databasePassword form-control" placeholder="Password" value="qcdb01" type="password"/>
		</div>
		<div class="col-xs-2">
			&nbsp;
			<button class="btn btn-success">Connect</button>
			<button class="btn btn-success" name="command" value="save">Save</button>
		</div>
		<a href="#" class="taggle">Toggle</a>
	</div>
	
	<hr/>
	
	<div class="row">
		<div class="col-xs-3 scrollable" style="height: 600px;overflow-y: scroll;overflow-x: hidden;">
			<table class="table">
				<thead>
					<tr>
<%
	Database db = new Database("ShareGen",
			"com.microsoft.jdbc.sqlserver.SQLServerDriver",
			"microsoft","sqlserver","QCSMN01","1433",
			"semaan_app_user","qcdb01",null);
	TableService svc = new TableService(db);

	TableService tableService = new TableService(db);
	List<Table> tables = tableService.getTables();
%>
						<th>Tables (<%= tables.size() %>)</th>
					</tr>
				</thead>
				<tbody>
<%	for(Table table : tables)
	{%>				<tr>
						<td><a href="index.jsp?table=<%= table.name %>"><%= table.name %></a></td>
					</tr>
<%	}%>			</tbody>
			</table>
		</div>
		<div class="col-xs-9">
			<div style="height: 600px;overflow-y: scroll;overflow-x: hidden;">
			<table class="table">
				<thead>
					<tr>
<%	String tableName = request.getParameter("table");
	if(tableName != null)
	{
		List<Column> columns = tableService.getColumns(tableName);
%>
						<th>Fields (<%= columns.size() %>)</th>
						<th>Siterra Field</th>
						<th>Comment</th>
						<th>Update</th>
					</tr>
				</thead>
				<tbody>
<%		for(Column col : columns)
		{
			String pkStyle = "";
			if(col.isPrimaryKey)
				pkStyle = "font-weight:bold";
		%>			<tr style="<%=pkStyle%>">
						<td><span style="font-weight:bold"><%= col.name %></span><br/><span style="font-size:0.65em"><%= col.getTypeName()%>(<%= col.size %>)</span></td>
						<td><input class="siterraField form-control" /></td>
						<td><input class="fieldComment form-control" /></td>
						<td><a href="#" class="btn btn-primary">Edit</a></td>
					</tr>
<%		}
	}
%>
				</tbody>
			</table>
			</div>
		</div>
	</div>
</div>
			<input type="hidden" name=table value="<%=tableName%>"/>

</form>

<script src="js/jquery.js"></script>
<!-- script src="js/util.js"></script>
<script src="js/atc.js"></script-->

</body>
</html>