
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Create account | PrivacyCheck</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
</head>
<body>
<main class="auth-shell">
  <section class="auth-brand">
    <div class="brand-mark">P</div>
    <h1>Your privacy deserves a clear picture.</h1>
    <p>Monitor connected services and review the data you choose to share.</p>
    <div class="trust-note">Private by design.</div>
  </section>

  <section class="auth-panel">
    <a class="brand-name" href="${pageContext.request.contextPath}/login">PrivacyCheck</a>
    <h2>Create your account</h2>
    <p class="muted">Start managing your digital privacy.</p>

    <% if (request.getAttribute("error") != null) { %>
      <div class="error"><%= org.apache.taglibs.standard.functions.
        Functions.escapeXml(request.getAttribute("error").toString()) %></div>
    <% } %>

    <form method="post" action="${pageContext.request.contextPath}/register">
      <label for="name">Full name</label>
      <input id="name" type="text" name="name" autocomplete="name"
             maxlength="100" required>

      <label for="email">Email address</label>
      <input id="email" type="email" name="email" autocomplete="email"
             maxlength="150" required>

      <label for="password">Password</label>
      <input id="password" type="password" name="password"
             autocomplete="new-password" minlength="12" required>

      <label for="confirmPassword">Confirm password</label>
      <input id="confirmPassword" type="password" name="confirmPassword"
             autocomplete="new-password" minlength="12" required>

      <button class="primary-btn" type="submit">Create account</button>
    </form>

    <div class="separator"><span>or</span></div>

    <a class="google-btn" href="${pageContext.request.contextPath}/google/login">
      <span aria-hidden="true">G</span> Sign up with Google
    </a>

    <p class="bottom-text">Already registered?
      <a href="${pageContext.request.contextPath}/login">Sign in</a>
    </p>
  </section>
</main>
</body>
</html>
