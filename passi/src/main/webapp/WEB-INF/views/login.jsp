<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<%
int timeout = session.getMaxInactiveInterval();
String contextPath = request.getContextPath();
response.setHeader("Refresh", timeout + "; URL = " + contextPath + "/expired");
%>

<!DOCTYPE html>
<html lang="fi">
<head>
<title>Työkykypassi&nbsp;&bull;&nbsp;Kirjaudu sisään</title>

<meta name="author" content="Mika Ropponen" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">

<!-- Custom styles for this template -->
<link href="<c:url value="/static/style/login.css" />" rel="stylesheet">

</head>

<body onload="document.getElementById('username').focus();">

<div class="container">

<div class="login-panel">
			
<div id="login-panel-style">
<h2 class="form-signin-heading">Anna tunnuksesi</h2>
<c:if test="${not empty error}"><h4 class="color-red">${error}</h4></c:if>
<c:if test="${not empty message}"><h4 class="color-green">${message}</h4></c:if>
</div>

<form class="form-signin" action="<c:url value='/login' />" method="post">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
<table>		
<tr><td><input type="text" id="username" name="username" class="form-control" placeholder="Käyttäjätunnus" autocomplete="off" required autofocus /></td></tr>
<tr><td><input type="password" id="password" name="password" class="form-control" placeholder="Salasana" required /></td></tr>
<tr><td><button class="btn btn-lg btn-primary btn-block" type="submit" value="Kirjaudu">Kirjaudu</button></td></tr>
</table>
</form>

<!-- Registration link -->
<c:url var="registrationURL" value="/registration" />
<p><a href="${registrationURL}">Rekisteröidy</a></p>

</div>

</div>

<pre style="display: inline-block; margin-top: 20px; padding: 10px 15px 10px 15px;">username = admin<br />password = passw</pre>

<div class="frontinfo">
Työkykypassi – mobiilisovellus on kehitetty Työterveyslaitoksen koordinoimassa Combo -

hankkeessa. Sovelluksen tarkoituksena on vahvistaa opiskelijoiden työkykyosaamista ammatillisissa

oppilaitoksissa. Hanketta on rahoittanut Euroopan sosiaalirahasto (ESR) / Pohjois-Pohjanmaan

elinkeino-, liikenne- ja ympäristökeskus. Sovellukseen kehittämiseen ovat osallistuneet Haaga-Helia

Ammattikorkeakoulu, Työterveyslaitos, Saku Ry ja Stadin ammattiopisto.

[Tekstin alapuolelle seuraavat kehittäjätaho logot: Haaga-Helia, Työterveyslaitos, Saku Ry, Stadin

ammattiopisto, ESR – lippulogo, Uudenmaan Ely-keskus, Vipuvoimaa –logo]

<img src="static/img/kehittaja_haaga-helia.jpg">
<img src="static/img/kehittaja_ttl.jpg">
<img src="static/img/saku.png">
<img src="static/img/kehittaja_vipuvoimaa.png">
<img src="static/img/kehittaja_eu_esr.png">
<img src="static/img/ely.jpg">

Sovelluksen sisällössä on hyödynnetty Alpo.fi-sivujen tehtäviä, jotka on aiemmin laadittu

yhteistyössä seuraavien tahojen kanssa:

[Tekstin alapuolelle seuraavat yhteistyötaho logot: Smart moves, Ehyt Ry, Mielenterveysseura, Yksi

elämä, Sydänliitto, Nuorten Akatemia, Suomen mielenterveysseura]

<img src="static/img/yhteistyo_smartmoves.png">
<img src="static/img/yhteistyo_ehyt.jpg">
<img src="static/img/yhteistyo_ye.jpg">
<img src="static/img/yhteistyo_sydanliitto.jpg">
<img src="static/img/yhteistyo_nuortenakatemia.jpg">
</div>

<!-- Script -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</body>
</html>