<%@ page language="java" pageEncoding="UTF-8"%>

<script type="text/javascript">
	if ("${msg}" != "") {
		alert('${msg}');
	}
	
	if (opener != null) {
		window.close();
	} else {
		history.back();
	}
</script>